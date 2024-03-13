Return-Path: <linux-kernel+bounces-102157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1A687AEE7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112471F22F3D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B2A192502;
	Wed, 13 Mar 2024 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKzqF1Jb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F89D7690B;
	Wed, 13 Mar 2024 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349374; cv=none; b=aQSms3mFYGoJym0scD+oblqAaClKAuCbJ2H8oy/4KRafV65zmURj3lc0I7A+90c+BaftPe09z51kFK+lcRx53+x1CWG4oy6vnDFXqJVzbw7LKV5vrgp0n5hPb2elaPp82EyoZb8Vp9J3Fgr2l/dUV3ge0OFhgqN3mMiSHnSuDQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349374; c=relaxed/simple;
	bh=ECco995W7VfrB+XT15DK5ej7i+e4UGgjp4foVqaP1zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQLEOfgH7bFvNzJ5ZJrO23MPOeGqZhZzu6+Kqq1PZ7Yv6AwajtOpc0VFVJKTi29IfH0d0aWl00KDpLMY11Z22gzgQznNGfYqb/RLLXwtEMY1ZmFkQbi5Ctm82NVBswxr8wdG8AiKyjD+MUgONzmlath8uvbFisS0yk6JNdCauic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKzqF1Jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F7EC433B1;
	Wed, 13 Mar 2024 17:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349374;
	bh=ECco995W7VfrB+XT15DK5ej7i+e4UGgjp4foVqaP1zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mKzqF1Jb5kiyoq/AbpYVYSG2OyFjeOCZZyXcKl5TmjJGQ/XvwJjCC9h1Ilg5hMi89
	 1PBc/6CBYWw6nUSdjEcXghKST+rjT590pTPI7fAhojzbJQpTEjZle80Ja6745HB0uf
	 VeRiccNLr3x763ITvKYI6z7Q9HiE50/zkIsgBGdmJCGAkD5rWaVKGJoy8jupOO9lPn
	 LShdxYoywej/5VAEv2sWe+58hVPkarEX4JU5/fJFO2MH6kHKHBVI4D5XIOixiimBcY
	 UtmfIj4bKksYFppOp7L92GIMDRPlYmsa7g8Xx+cbgZJ9Upn75w8GzTLcaDBcmlSYib
	 CCf6cnGSYGEMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Juhee Kang <claudiajkang@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 36/51] hv_netvsc: use netif_is_bond_master() instead of open code
Date: Wed, 13 Mar 2024 13:01:57 -0400
Message-ID: <20240313170212.616443-37-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Juhee Kang <claudiajkang@gmail.com>

[ Upstream commit c60882a4566a0a62dc3a40c85131103aad83dcb3 ]

Use netif_is_bond_master() function instead of open code, which is
((event_dev->priv_flags & IFF_BONDING) && (event_dev->flags & IFF_MASTER)).
This patch doesn't change logic.

Signed-off-by: Juhee Kang <claudiajkang@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 9cae43da9867 ("hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/netvsc_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 5697fe709f687..880c3f69c9c10 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2511,8 +2511,7 @@ static int netvsc_netdev_event(struct notifier_block *this,
 		return NOTIFY_DONE;
 
 	/* Avoid Bonding master dev with same MAC registering as VF */
-	if ((event_dev->priv_flags & IFF_BONDING) &&
-	    (event_dev->flags & IFF_MASTER))
+	if (netif_is_bond_master(event_dev))
 		return NOTIFY_DONE;
 
 	switch (event) {
-- 
2.43.0


