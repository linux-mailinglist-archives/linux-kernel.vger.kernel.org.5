Return-Path: <linux-kernel+bounces-147905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8D68A7B26
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B97E282692
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC8D40850;
	Wed, 17 Apr 2024 03:57:20 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853FE10976;
	Wed, 17 Apr 2024 03:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713326240; cv=none; b=amrjSwbbu99tIztGJvPP9YKQK6hcVZahGXjt7b5kf+QfkW6YtmPgFlt9qg7c3hrqZt5vwpbpBLjleLVYnOgFfO7DSJtwA4QuyMauxwtF9zWVGnZ39Gt95v8/Gd6npsKqDXJGV780DA/tKCW21MKSKM1Ezg30ZvpdEJuSIPpjjMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713326240; c=relaxed/simple;
	bh=yGNctuQHUcCDXPl8MG3Yqguf16BmQ/shTe6xOPNkLMw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cfaB7jlLV0oXJ59FtBitsxMrYzXxY7suJt8OusmfafiGqyocGY+xRXYVi62iPG/yukhf2/8ZvpBsMnkdY1DRK00M9wiaMuc1tmkhsf9y90/LVH9L6/iUMyETCDV0RKyZDjjO9aX8MOtOcf+8zOJOPMwKIKwLeDB1pReM/j7GP6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VK6YG1vrdz4f3nTt;
	Wed, 17 Apr 2024 11:57:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2DD551A0572;
	Wed, 17 Apr 2024 11:57:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RGaSB9mzMnFKA--.65099S4;
	Wed, 17 Apr 2024 11:57:14 +0800 (CST)
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luogengkun@huaweicloud.com
Subject: [PATCH RESEND v2 0/2] Fix small negative period being ignored
Date: Wed, 17 Apr 2024 11:54:44 +0000
Message-Id: <20240417115446.2908769-1-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RGaSB9mzMnFKA--.65099S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUO27AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JF
	v_Gryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AK
	xVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aV
	AFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	F7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
	AKI48JMxAqzxv262kKe7AKxVWUXVWUAwCF54CYxVCY1x0262kKe7AKxVWUAVWUtwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7
	xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRR-eOUUUUU
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

v1 -> v2:
1. Add reviewed by for perf/core: Fix small negative period being ignored
2. Add perf/core: Fix incorrected time diff in tick adjust period

Luo Gengkun (2):
  perf/core: Fix small negative period being ignored
  perf/core: Fix incorrected time diff in tick adjust period

 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 21 +++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.34.1


