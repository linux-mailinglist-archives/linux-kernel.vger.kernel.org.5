Return-Path: <linux-kernel+bounces-166578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA3A8B9CA4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A10B1F21AEE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDF9153566;
	Thu,  2 May 2024 14:46:13 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C93E153502;
	Thu,  2 May 2024 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714661173; cv=none; b=qtq0LINPitVrpYXiKQy5kNZK7dk6ND39pqWU0u8cuhg4cM+Vwo05jQ+7yhUcu7zac7Y7SdB+e6PJVCeDHpNcVDDcXhWIAXJ1UZi2g3/nM49zh+GKcv7vjXVk6rizYNKNDrEccuMsawRYYHEgXrR4mR8POYUKmS6NmAaxtSY4RQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714661173; c=relaxed/simple;
	bh=FoWWffCrB0ZOfUtv98J8f9Am45YWgTeItc9Gkc/leJE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Bw9CAsN0EVFWGkKFDDHqjn7O+TPPslDaIjtppOqP3BXzsyuZZbGbUmyxAk8hqppCwgC3r6WIGz+TExNYZGAUcKGB5DI35LwUDU7Cl408ti19khvD8JF8GFqWo2h/m3afcOEbEXKDO+DXEgGs6KmSs/BnzS4X0Jb7VT29Ws54X3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [221.192.181.50])
	by mail-app2 (Coremail) with SMTP id by_KCgA3L4GZpjNmnigDAg--.28S2;
	Thu, 02 May 2024 22:44:01 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-hams@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jreuter@yaina.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dan.carpenter@linaro.org,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH net 0/2] ax25: fix reference counting issue of ax25_dev
Date: Thu,  2 May 2024 22:43:36 +0800
Message-Id: <cover.1714660565.git.duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:by_KCgA3L4GZpjNmnigDAg--.28S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYC7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVAFwVW5XwCF04k20xvY0x0EwIxGrwCF54
	CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmzuXU
	UUUU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwIJAWYySJ0M6ABbs3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The first patch changes kfree in ax25_dev_free to ax25_dev_free,
because the ax25_dev is managed by reference counting.

The second patch fixes potential reference counting leak issue
in ax25_addr_ax25dev.

Duoming Zhou (2):
  ax25: change kfree in ax25_dev_free to ax25_dev_free
  ax25: fix potential reference counting leak in ax25_addr_ax25dev

 net/ax25/ax25_dev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.17.1


