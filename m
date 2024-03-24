Return-Path: <linux-kernel+bounces-113575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B17788856B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD8E1C245EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8C91C8FBE;
	Sun, 24 Mar 2024 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f//aVYNU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850F41C8FA1;
	Sun, 24 Mar 2024 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320378; cv=none; b=DjLN3X8eHhbFr/5dGAiyLjpCgf5a47V4+XLtdZZKg6SJ/loYisP8ewdwfEz6N74gbTxmuQuRa5uyk9+1VfM6XtaXJq6qvdJazCzI4U89397nUduO7cxjFgXr2VZG2BOBqrpH8I8DboxRgSDinWH2s/bBjdYaBBmzUymtdDwho+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320378; c=relaxed/simple;
	bh=pa35vW4onQCB+cbzrRN+5K9fSbHykdAF5OtD8khnado=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d262HZPJRhTO+qQSNzuPI8mYJUAbxVdQsjw5aJJFsfgH0X34yksAV8NdQlA9s4ssaAR7lYjKvhV3l/Lt0d27U7K4GlfJP5RGPBzw2SpqWTIs2sWn1x9oXJouEJaqS9dB3RXnwE/E1t7FUfG4ttUSLma0QFw6MSCcF5dySY8q5Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f//aVYNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5F5C43399;
	Sun, 24 Mar 2024 22:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320378;
	bh=pa35vW4onQCB+cbzrRN+5K9fSbHykdAF5OtD8khnado=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f//aVYNUSdu8CICWlFmZM+2RwapbXHgkgh9O43y5XUkryKH8ay3/SOCZ6Pkc+f+GW
	 golKAYsZdPQ3o95MywSe0hUCPu6yMo8aj6a0b2RstW6lxaS8gFD023TD5lJUVGqERb
	 0g4ublUfsEPhndYNaeh+BbOYdrqsCVzgTbEhzkaCuDkJnU7AtPNpA3wXcklLFy80cd
	 OMM/CEShsusq3DS9pCIV0xbZxI8yRZnE3GFixMGE9kTzLWSMefiNsf2AozoL6A0O0h
	 ZK+MdRoZQv69fdqoEpD/1GzYyUoKD0luAzX0rWJRGzre+HNu2K5HFxkQcJ4EhroxJW
	 d2XvLa/FnYtsw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Maurer <fmaurer@redhat.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 684/715] hsr: Handle failures in module init
Date: Sun, 24 Mar 2024 18:34:23 -0400
Message-ID: <20240324223455.1342824-685-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index cb83c8feb7465..9756e657bab97 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -148,14 +148,21 @@ static struct notifier_block hsr_nb = {
 
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


