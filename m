Return-Path: <linux-kernel+bounces-167072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3B58BA418
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E5C1F24487
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DC615CD72;
	Thu,  2 May 2024 23:36:45 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109DB4CDE0;
	Thu,  2 May 2024 23:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714693005; cv=none; b=U0w3F40v/2k84btsXcJzeO8ArJ95Jj3/7J8bUo28i2X+DPI0/h9r6/nUL4Q5MRhsikr9SmQvJDzFnrytKkg6Vmo/tcp2h5eE2/d2FMib/Ras3Dm5ssq3LxXz22xteJVY/WB8AzgLYGycXr2EtlTYHef5CzzFgF0qW8xpr9onR/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714693005; c=relaxed/simple;
	bh=jBKOsSBivqS7F+fVGIJGAZ4bcnWxyd5ZWWtsFuLVYH4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ez5ZAGZs7ChpB9hX6vx65YXVx3XbK/cOAvShxNafchra1/TObLNNgQygfBiac08uf8P9VZipGQbI/yFfyfAX5yZaG/9UD9wVvgMR+Kt2w4ZN7VL1wqNIKO+NSxl68PTlaDJ3kcU+34nESZrjep4B2frIyESTaLy97kOLf6LfS28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [221.192.179.227])
	by mail-app2 (Coremail) with SMTP id by_KCgC3ZqZwIzRm7PwDAA--.6463S2;
	Fri, 03 May 2024 07:36:20 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hams@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	jreuter@yaina.de,
	horms@kernel.org,
	Markus.Elfring@web.de,
	dan.carpenter@linaro.org,
	lars@oddbit.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH net v2 0/2] ax25: fix reference counting issue of ax25_dev
Date: Fri,  3 May 2024 07:36:14 +0800
Message-Id: <cover.1714690906.git.duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:by_KCgC3ZqZwIzRm7PwDAA--.6463S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYX7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aV
	CY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAC
	I402YVCY1x02628vn2kIc2xKxwCY02Avz4vE14v_uwCF04k20xvY0x0EwIxGrwCF54CYxV
	CY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUFJP_UUUUU
	=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwUJAWYztgkCSgAIsk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The first patch changes kfree in ax25_dev_free to ax25_dev_put,
because the ax25_dev is managed by reference counting.

The second patch fixes potential reference counting leak issue
in ax25_addr_ax25dev.

You can see the former discussion in the following link:
https://lore.kernel.org/netdev/20240501060218.32898-1-duoming@zju.edu.cn/

Duoming Zhou (2):
  ax25: change kfree in ax25_dev_free to ax25_dev_free
  ax25: fix potential reference counting leak in ax25_addr_ax25dev

 net/ax25/ax25_dev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.17.1


