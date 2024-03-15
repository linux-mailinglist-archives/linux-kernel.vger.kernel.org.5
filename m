Return-Path: <linux-kernel+bounces-104494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D433487CEBC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E7F1F22C48
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32C23C087;
	Fri, 15 Mar 2024 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="nKR01fZ3"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0841B3BBCD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512641; cv=none; b=j1HkqHYqWrgCzj1jPEc3RtEwK0aSSDcOCJIc6h0ZzsbiVI3W/wEJBpZ9pxAgTUtEJu9xdpml9FtD6e3b8vB8A0K/CkahrCE4YMK5hyIENaTLp7GA1vn63QaOGnzcayD+m0Vk8Xhzn8CqiUsM/PUTJ34I/AfQ520jZ1Tr4I9b3kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512641; c=relaxed/simple;
	bh=fXau4aMPengQDZo9DjA1lWY+BpLa+Yk6m2NeDQcvUck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tL9ktyz3pcbZOIhVbQh8dupgu6HfjnbirQBsTnZMSXGDxQcQ4AyMDQRDQE893rHtad9VS1LzDtDzNFl7uq6yT1n7aZXASzvfsZVUxdfs1qW/QOlcJ+/cjG3ivxhWinRb74V2u6WyCo6tvTKlsS6Tx1eXSgmUi1OxnIuu5Loi17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=nKR01fZ3; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wSH5FGFCIv59n3XTzZYR2ZRxICHAaXYIdM5WDnGInd4=; b=nKR01fZ3qEWlufkqnK+sagHhdw
	qz0A2NfC6tmbfJG+VizF156NMvnlqW9uGmxsqnQlOIekq8Zfy4T+DZfH+DgfvA0ANlpt9zPeDGCgj
	UJQWf1cyYOzCJRmY2DoVJo01jGkLWv5TdFiwfS84J9Wm+YP/j+35CX5hAvFezq7fQIMwdRy3gR2D1
	I7HZclRIJSqgRlfGytmRNop/Y0idbpSDqPjZcuu1YPoSH+wQJb0zTidOrJHo3fqLew+2WEo8NAOMq
	MK0VKofFm936TOSv7KdzMtBBXyws+0VLsm8k4yrOIuvMfZtT97zCyiBgkpDQty+8+czLgduK/tI28
	ZVbRzRSw==;
Received: from [63.135.74.212] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1rl8TI-00GKtQ-QD; Fri, 15 Mar 2024 14:23:44 +0000
Received: from ben by rainbowdash with local (Exim 4.97)
	(envelope-from <ben@rainbowdash>)
	id 1rl8TI-0000000CBcd-08qD;
	Fri, 15 Mar 2024 14:23:44 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: devel@lists.orangefs.org
Cc: martin@omnibond.com,
	hubcap@omnibond.com,
	linux-kernel@vger.kernel.org,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH v2] orangefs: move debug only code into debugfs.c file
Date: Fri, 15 Mar 2024 14:23:41 +0000
Message-Id: <20240315142341.2904597-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The s_kmod_keyword_mask_map[] is only used in orangefs-debugfs.c and is
casing a number of warnings about it being defined and not used. Fix
this by moving it to remove a lot of:

 warning: ‘num_kmod_keyword_mask_map’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

---
v2: fix missing move of debugfs table
---
 fs/orangefs/orangefs-debug.h   | 37 ----------------------------------
 fs/orangefs/orangefs-debugfs.c | 37 ++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/fs/orangefs/orangefs-debug.h b/fs/orangefs/orangefs-debug.h
index 6e079d4230d0..62649f3fb231 100644
--- a/fs/orangefs/orangefs-debug.h
+++ b/fs/orangefs/orangefs-debug.h
@@ -49,41 +49,4 @@ struct __keyword_mask_s {
 	__u64 mask_val;
 };
 
-/*
- * Map all kmod keywords to kmod debug masks here. Keep this
- * structure "packed":
- *
- *   "all" is always last...
- *
- *   keyword     mask_val     index
- *     foo          1           0
- *     bar          2           1
- *     baz          4           2
- *     qux          8           3
- *      .           .           .
- */
-static struct __keyword_mask_s s_kmod_keyword_mask_map[] = {
-	{"super", GOSSIP_SUPER_DEBUG},
-	{"inode", GOSSIP_INODE_DEBUG},
-	{"file", GOSSIP_FILE_DEBUG},
-	{"dir", GOSSIP_DIR_DEBUG},
-	{"utils", GOSSIP_UTILS_DEBUG},
-	{"wait", GOSSIP_WAIT_DEBUG},
-	{"acl", GOSSIP_ACL_DEBUG},
-	{"dcache", GOSSIP_DCACHE_DEBUG},
-	{"dev", GOSSIP_DEV_DEBUG},
-	{"name", GOSSIP_NAME_DEBUG},
-	{"bufmap", GOSSIP_BUFMAP_DEBUG},
-	{"cache", GOSSIP_CACHE_DEBUG},
-	{"debugfs", GOSSIP_DEBUGFS_DEBUG},
-	{"xattr", GOSSIP_XATTR_DEBUG},
-	{"init", GOSSIP_INIT_DEBUG},
-	{"sysfs", GOSSIP_SYSFS_DEBUG},
-	{"none", GOSSIP_NO_DEBUG},
-	{"all", GOSSIP_MAX_DEBUG}
-};
-
-static const int num_kmod_keyword_mask_map = (int)
-	(ARRAY_SIZE(s_kmod_keyword_mask_map));
-
 #endif /* __ORANGEFS_DEBUG_H */
diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index 1b508f543384..d2a68d3dd31e 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -146,6 +146,43 @@ static DEFINE_MUTEX(orangefs_debug_lock);
 /* Used to protect data in ORANGEFS_KMOD_DEBUG_HELP_FILE */
 static DEFINE_MUTEX(orangefs_help_file_lock);
 
+/*
+ * Map all kmod keywords to kmod debug masks here. Keep this
+ * structure "packed":
+ *
+ *   "all" is always last...
+ *
+ *   keyword     mask_val     index
+ *     foo          1           0
+ *     bar          2           1
+ *     baz          4           2
+ *     qux          8           3
+ *      .           .           .
+ */
+static struct __keyword_mask_s s_kmod_keyword_mask_map[] = {
+	{"super", GOSSIP_SUPER_DEBUG},
+	{"inode", GOSSIP_INODE_DEBUG},
+	{"file", GOSSIP_FILE_DEBUG},
+	{"dir", GOSSIP_DIR_DEBUG},
+	{"utils", GOSSIP_UTILS_DEBUG},
+	{"wait", GOSSIP_WAIT_DEBUG},
+	{"acl", GOSSIP_ACL_DEBUG},
+	{"dcache", GOSSIP_DCACHE_DEBUG},
+	{"dev", GOSSIP_DEV_DEBUG},
+	{"name", GOSSIP_NAME_DEBUG},
+	{"bufmap", GOSSIP_BUFMAP_DEBUG},
+	{"cache", GOSSIP_CACHE_DEBUG},
+	{"debugfs", GOSSIP_DEBUGFS_DEBUG},
+	{"xattr", GOSSIP_XATTR_DEBUG},
+	{"init", GOSSIP_INIT_DEBUG},
+	{"sysfs", GOSSIP_SYSFS_DEBUG},
+	{"none", GOSSIP_NO_DEBUG},
+	{"all", GOSSIP_MAX_DEBUG}
+};
+
+static const int num_kmod_keyword_mask_map = (int)
+	(ARRAY_SIZE(s_kmod_keyword_mask_map));
+
 /*
  * initialize kmod debug operations, create orangefs debugfs dir and
  * ORANGEFS_KMOD_DEBUG_HELP_FILE.
-- 
2.37.2.352.g3c44437643


