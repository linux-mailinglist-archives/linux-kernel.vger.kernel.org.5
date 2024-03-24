Return-Path: <linux-kernel+bounces-115261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A83D889379
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041AF29A4DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E728C1CEDD4;
	Mon, 25 Mar 2024 01:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSDVvC80"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296ED13C9B4;
	Sun, 24 Mar 2024 23:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324380; cv=none; b=ixYw1K4Gq9gYct4YmV8DoxpoV76Xhdv3Y1YB9a/r+4PqWd9WriabquOYe/3w6+ggtEC6X8vToc+Z2qJkZMP8EGe7kaLFtt+OEdX+bdiXsP/i3FT7xOj3oTb13HOYJ7YbD1Txv+2v5eQ1H8DaL+HF0qBM+85OO/icB3Uq9cg+m8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324380; c=relaxed/simple;
	bh=Q87wpKdOQl0hrcVlZqfLflnVZ+hc8gAvqiG16jNGA8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNeuGAKAhJ9DkhiVpacqS+D31eC261Cvxe/dsPZ+KiHOpDAyqRU8pyYiOmScl9getjrxFbi6R5+CAbX43UxlPpIgekzW+QE7c/YH8Sq/17pe98jtoSAdu3Roex3quLtMq8oIN8XcrZTjVo6urL5yyDPiC2Qc/LOTjemJkyx7Fo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSDVvC80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0747C43399;
	Sun, 24 Mar 2024 23:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324380;
	bh=Q87wpKdOQl0hrcVlZqfLflnVZ+hc8gAvqiG16jNGA8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FSDVvC80wX6z8CGSaLF4wYyLreJEK4J7bpvZvht1qsJtDrF2VFVVaaWMChIrOUDX+
	 OaCWiuFY9SMo8TeR0sQGUftK/Qy2vVNWRI8r0ro1IdX35gYUgrvWScJnRQBnc/Xpfq
	 IvzqFs7T6ogdp6hBDV6iyorcT5GUVZYCprvTsSu5l29PMR7uXhsptYMrV/6KRiv5Wa
	 SDRsfX6ZqNYgUJLLrvAko5UZYj8NM201aNKIINd99HAZ4WESnnjsZjYbypkK3XdVEu
	 EIC7L7LXGxzIJ64aL5omj3BSGKLRGMEH/Vi/XWLyrS4356v9Ad8j3FZykGQIsYUJLL
	 j7N06lCSm8qDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Maurer <fmaurer@redhat.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 145/148] hsr: Handle failures in module init
Date: Sun, 24 Mar 2024 19:50:09 -0400
Message-ID: <20240324235012.1356413-146-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index cd37d0011b424..c22013ff44795 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -115,14 +115,21 @@ static struct notifier_block hsr_nb = {
 
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


