Return-Path: <linux-kernel+bounces-116220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9303A8895B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDD729958E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FD43BFFB4;
	Mon, 25 Mar 2024 03:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkM3RjX8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82E117DC37;
	Sun, 24 Mar 2024 23:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323849; cv=none; b=oSoxKOo34fAQ6XukNy653V4MFsalIoA2xrxX+/tE2IpdeS906yPAPRKQ6cJalxvnZlExY5zrNUZCyMqt/rRSLah+gio1ORenkL/m6Jw08xEqTeF5xmhr/e2umJ8jVLTuBSqN1BVio/V9fUIJr+hU21k/FZs8ObwenUifv1dVUDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323849; c=relaxed/simple;
	bh=LDY0af1l0wOjYJ8cMrD88wlEhNgwaU1OcXBV2y4G9lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzYdfgHsGL1VLwlR66DlkxqVSvpurrZS/j/wQceNeSWcpHe6/MVa1thMHklOk2KflB0mR2BQH43SjwnU3RFNVtzunUxZPY2uWF3PwNB/MJGM980c5IhR33KU8qCkIYk2CnIfS6vWySZ2/jQq9Vi1aCPRnbOWlCzpKxZv4rdcKLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkM3RjX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD54C433C7;
	Sun, 24 Mar 2024 23:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323849;
	bh=LDY0af1l0wOjYJ8cMrD88wlEhNgwaU1OcXBV2y4G9lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CkM3RjX8ih+eN4aXSVuDpLm5f6ewtz3vlbbZOCuLsyfqLEaXgoEMVJCoDoOgHm71r
	 oolHzrHMdvwbydK9UezMhSRC7LqIaTP6lsPv0exoIF485CEfD8pfF5batzA2CQlHtW
	 QpFMQOwaZLK+y9qDCCWUvrdCOUMSYQrfP7TH3d5p6+xbNJURwr3muPvXZB2//si47w
	 0GaOBtEkMRfWOSKriLleuAT+qixzRePpoozabn/+iy9urk1HOAmjvEScWj1L8tFmn8
	 bTUtCo6ZM0GvBM4ItNUCkAf63dH5NRL/cKNbmV2LEsMh75hnOfyHzNHW4EmOMqcdft
	 SafXnzH8O8oXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Maurer <fmaurer@redhat.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 227/238] hsr: Handle failures in module init
Date: Sun, 24 Mar 2024 19:40:15 -0400
Message-ID: <20240324234027.1354210-228-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Felix Maurer <fmaurer@redhat.com>

[ Upstream commit 3cf28cd492308e5f63ed00b29ea03ca016264376 ]

A failure during registration of the netdev notifier was not handled at
all. A failure during netlink initialization did not unregister the netdev
notifier.

Handle failures of netdev notifier registration and netlink initialization.
Both functions should only return negative values on failure and thereby
lead to the hsr module not being loaded.

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Signed-off-by: Felix Maurer <fmaurer@redhat.com>
Reviewed-by: Shigeru Yoshida <syoshida@redhat.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/r/3ce097c15e3f7ace98fc7fd9bcbf299f092e63d1.1710504184.git.fmaurer@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_main.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index 2fd1976e5b1c3..bea7f935f38e9 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -137,14 +137,21 @@ static struct notifier_block hsr_nb = {
 
 static int __init hsr_init(void)
 {
-	int res;
+	int err;
 
 	BUILD_BUG_ON(sizeof(struct hsr_tag) != HSR_HLEN);
 
-	register_netdevice_notifier(&hsr_nb);
-	res = hsr_netlink_init();
+	err = register_netdevice_notifier(&hsr_nb);
+	if (err)
+		return err;
+
+	err = hsr_netlink_init();
+	if (err) {
+		unregister_netdevice_notifier(&hsr_nb);
+		return err;
+	}
 
-	return res;
+	return 0;
 }
 
 static void __exit hsr_exit(void)
-- 
2.43.0


