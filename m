Return-Path: <linux-kernel+bounces-85157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C774586B13F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72261B27C54
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D2C1552EA;
	Wed, 28 Feb 2024 14:05:42 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54DD148FFC
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709129141; cv=none; b=CDtpAQizAlZHHsfbJHVM2kC3/b861zIMNczBa/TVHgkD+eQ2TCL2HoWJeAvC8iYJMxkYvQzAf3PeDHABTv7z2ms8UFRVTjDghaEKiuG+tA1ehZVZ/Ji47EBRxEEaIHhFiQHIZkFvsQlewOUqR9CD8BLB3HPd1UngO8by8A7doDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709129141; c=relaxed/simple;
	bh=L3K4rtzy6gxBJUGpTTcskVWOegBL2LVnvlohsA27NJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G0Fsfqy6j9qtWkYrqtfFV93rNvJs4L5aWRfaTwc2SpM8rYHPPfGY/SwRkXzU7FAW8XITJRzBCtFEe3Gabtgi+GjCwxT69H6S6ffkgqPODHlwGOtyf95QdEon5OE45Iz3K6XgyRm57pjotsgCzlLMkBUNSknEGUS3QNb1s/B90R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:48c4:26a9:d9ec:22cb])
	by baptiste.telenet-ops.be with bizsmtp
	id se5X2B00W4gWvPH01e5YVc; Wed, 28 Feb 2024 15:05:32 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rfKYk-001tZf-Ar;
	Wed, 28 Feb 2024 15:05:31 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rfKYt-006hqr-PP;
	Wed, 28 Feb 2024 15:05:31 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH net-next] Simplify net_dbg_ratelimited() dummy
Date: Wed, 28 Feb 2024 15:05:29 +0100
Message-Id: <5d75ce122b5cbfe62b018a7719960e34cfcbb1f2.1709128975.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to wrap calls to the no_printk() helper inside an
always-false check, as no_printk() already does that internally.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/net.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index c9b4a63791a45948..15df6d5f27a7badc 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -299,10 +299,7 @@ do {									\
 	net_ratelimited_function(pr_debug, fmt, ##__VA_ARGS__)
 #else
 #define net_dbg_ratelimited(fmt, ...)				\
-	do {							\
-		if (0)						\
-			no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__); \
-	} while (0)
+	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #endif
 
 #define net_get_random_once(buf, nbytes)			\
-- 
2.34.1


