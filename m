Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F6F7F5283
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343882AbjKVVXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjKVVXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:23:16 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B191A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:23:12 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 28BF5601A5;
        Wed, 22 Nov 2023 22:23:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1700688186; bh=H7MlBg9YpVfV+cspaM8Vo5IiwZKZH0xos1nZLD/aRBc=;
        h=From:To:Cc:Subject:Date:From;
        b=qNX3yMMbWBa5mYT3MdCdQHfB4eboXliC/nG4U5YgBlpRCkfqkiWMPgalE6UygCPJ9
         cgTaN4PHyFBtXSSctBsHBT9KCQY+plrh4h+zKvuqh3cocFtAzh9fP7Y6du0rmOUTje
         IIGylnhSpYKmL/sYuYX1l+o74pSASNw+fUu7yZ9Vbc1s/8FsDae/AtugfV24jBezGZ
         FM9mVY23JflGp2XXmOTcBeQ+QqAXJDopNT4gt//rxb1RKOsz/LLt450RF3v6K112pR
         /Hq4R1IWCweaDiXQnzT3epbwdkvLVbL6jhDkb+bH+wQLeEDWWuYWwWtlM2uU6z7Kh+
         fTJEEmfmkK7XA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8iAfKtP24BS4; Wed, 22 Nov 2023 22:23:03 +0100 (CET)
Received: from defiant.. (78-2-200-148.adsl.net.t-com.hr [78.2.200.148])
        by domac.alu.hr (Postfix) with ESMTPSA id 72DDB60189;
        Wed, 22 Nov 2023 22:23:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1700688183; bh=H7MlBg9YpVfV+cspaM8Vo5IiwZKZH0xos1nZLD/aRBc=;
        h=From:To:Cc:Subject:Date:From;
        b=bKPEu64cNCG0LWGGAHW7BVVXev2wBhsy0Xur3AHoc5MI1Hzk96Yy+q5kh4iI78GQd
         fNEVXPU8dT/hv3JQ1x1uc9EUCTViK38qHlDA2++NJqW/0ThzgShXKo7FwWfnGO5oIc
         RA2PngKkVIThvh7d36XKa+CP3Rxp+cn62+blFYVXgNy7itBufrjIwQLaKrzZLRhhuy
         BiqzP254da45G482IwOxbqVPrLaRZpxY/YNkGc4Rd7QbciqrWfoPGMkH4LrKeTsxaq
         A5CeQT/DuACWvDJP3l2YZsCSs4k8wl8ZRHqLO2or5bCSlsrAF7qvVebFEuRNK0Rvop
         xKiutD5Yb88ng==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Aditya Kali <adityakali@google.com>
Subject: [RFC PATCH v2 1/1] kernfs: replace deprecated strlcpy() with strscpy()
Date:   Wed, 22 Nov 2023 22:20:10 +0100
Message-Id: <20231122212008.11790-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

According to strlcpy() being officially deprecated and the encouragement
to remove the remaining occurrences, this came as the intriguing example.

In the kernfs_name_locked() the behaviour of truncating the kn->name is
preserved, for it only used in the module for printing in the log and
declared static. It is only called from pr_cont_kernfs_name() via kernfs_name()
and returned result is ignored.

It is avoided to go past the allocated page and cause the internal equivalent
of SEGFAULT in the unlikely case kn->name is not null-terminated, which I
believe was the idea behind replacing strlcpy() with strscpy().

kernfs_path_from_node_locked() has "(null)" which certainly cannot overrun,
and a carefully calculated len and truncated path elsewhere.

Fixes: 17627157cda13 ("kernfs: handle null pointers while printing node name and path")
Fixes: 3eef34ad7dc36 ("kernfs: implement kernfs_get_parent(), kernfs_name/path() and friends")
Fixes: 9f6df573a4041 ("kernfs: Add API to generate relative kernfs path")
Fixes: 3abb1d90f5d93 ("kernfs: make kernfs_path*() behave in the style of strlcpy()")
Fixes: e56ed358afd81 ("kernfs: make kernfs_walk_ns() use kernfs_pr_cont_buf[]")
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Aditya Kali <adityakali@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Link: https://lwn.net/ml/ksummit-discuss/20231019054642.GF14346@lst.de/#t
Link: https://lwn.net/Articles/659214/
Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
v2:
 Fixed a Cc: address bug.
 Fixing the patch according to the new definition of strscpy() in
    LWN article https://lwn.net/Articles/659214/ that makes strscpy_truncate()
    obsoleted.

 fs/kernfs/dir.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8b2bd65d70e7..a6971a6756bc 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -53,10 +53,17 @@ static bool kernfs_lockdep(struct kernfs_node *kn)
 
 static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_t buflen)
 {
+	size_t len;
+
 	if (!kn)
-		return strlcpy(buf, "(null)", buflen);
+		return strscpy(buf, "(null)", buflen);
+
+	len = strscpy(buf, kn->parent ? kn->name : "/", buflen);
 
-	return strlcpy(buf, kn->parent ? kn->name : "/", buflen);
+	if (unlikely(len == -E2BIG)) {
+		return buflen - 1;
+	} else
+		return len;
 }
 
 /* kernfs_node_depth - compute depth from @from to @to */
@@ -141,13 +148,13 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
 	int i, j;
 
 	if (!kn_to)
-		return strlcpy(buf, "(null)", buflen);
+		return strscpy(buf, "(null)", buflen);
 
 	if (!kn_from)
 		kn_from = kernfs_root(kn_to)->kn;
 
 	if (kn_from == kn_to)
-		return strlcpy(buf, "/", buflen);
+		return strscpy(buf, "/", buflen);
 
 	common = kernfs_common_ancestor(kn_from, kn_to);
 	if (WARN_ON(!common))
@@ -159,16 +166,16 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
 	buf[0] = '\0';
 
 	for (i = 0; i < depth_from; i++)
-		len += strlcpy(buf + len, parent_str,
+		len += strscpy(buf + len, parent_str,
 			       len < buflen ? buflen - len : 0);
 
 	/* Calculate how many bytes we need for the rest */
 	for (i = depth_to - 1; i >= 0; i--) {
 		for (kn = kn_to, j = 0; j < i; j++)
 			kn = kn->parent;
-		len += strlcpy(buf + len, "/",
+		len += strscpy(buf + len, "/",
 			       len < buflen ? buflen - len : 0);
-		len += strlcpy(buf + len, kn->name,
+		len += strscpy(buf + len, kn->name,
 			       len < buflen ? buflen - len : 0);
 	}
 
@@ -857,9 +864,9 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 
 	spin_lock_irq(&kernfs_pr_cont_lock);
 
-	len = strlcpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
+	len = strscpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
 
-	if (len >= sizeof(kernfs_pr_cont_buf)) {
+	if (unlikely(len == -E2BIG)) {
 		spin_unlock_irq(&kernfs_pr_cont_lock);
 		return NULL;
 	}
-- 
2.34.1

