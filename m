Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8DE7DB1BE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 01:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjJ3Atk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 20:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjJ3Ati (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 20:49:38 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55DEBA
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 17:49:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 2211A60173;
        Mon, 30 Oct 2023 01:49:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698626973; bh=UuH9Bhgtc8CYKXgIbLMnFyP8eGT/ow9lhVeYuvbBnHI=;
        h=From:To:Cc:Subject:Date:From;
        b=rabutwy417UOteWsdg45v+xoTTtvYad1Bqv5MkIBRFVJAzZp/zjGceklFuUM88RJc
         2CTs5916QC1PKPBxXYTOAX2WezO5c9WOh0qKYH9NMmkV2tdGWnVUj+qSBV/beKi/3n
         yp0KNDDvq+XtDIXA2Vflzq+qNAnlsfewJ8ODvX8+WEIFTWWh204Nd8Bz8ngIlrHX/y
         XK4pILxJxfR9vVRkKCKxaKFVJuAgAq3W6Gj9AQZ2k9CcGkyDCD6NBwVVkkcHdslsCJ
         51SSnN5R0dTScc4m54xubfj0EEH9rYrTKyeBayi4iCp5nhQzVCe0/D6ObeD2xYutgL
         k3OZAzVT/Vk1A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Tq24Q_bA871N; Mon, 30 Oct 2023 01:49:30 +0100 (CET)
Received: from defiant.home (78-3-40-166.adsl.net.t-com.hr [78.3.40.166])
        by domac.alu.hr (Postfix) with ESMTPSA id 3B1DE60171;
        Mon, 30 Oct 2023 01:49:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698626970; bh=UuH9Bhgtc8CYKXgIbLMnFyP8eGT/ow9lhVeYuvbBnHI=;
        h=From:To:Cc:Subject:Date:From;
        b=KsBzvD3wSUI2RdhOa2WKGMXm8edZDeG54FHGLBKF3zJEIyCuJbHOIx4pcPzD3VEFh
         FhvDucDfzJHd9/RPcjuoeGxzSTdWu5sAXLcOZYsLI0H2dn2Yfj3SaUpS3kJ92Fhav8
         sL/Qi9yqbcyzB9sw0KkCr/qD7gR/N0ebBugpIVvB5yCHSLvz9eWTXfPW4S+IqJ/Gzw
         YrMNzSf3jJzG06/2wAH1LQr1VWc4pUHZfLWgRcknUMPwhywzHSbQB+3amxJ6yr0lIq
         kTRx3y7Hc7nfy/G6sDhVMuaj+9pZnPPmMPZ31Ja1n/Ld96B8tm+jwNnSAKrw6yhbAy
         JcOxGNlZl6jYg==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Aditya Kali <TejunHeotj@kernel.org>
Subject: [RFC PATCH v1 1/1] kernfs: replace deprecated strlcpy() with the safer strscpy()
Date:   Mon, 30 Oct 2023 01:36:50 +0100
Message-Id: <20231030003649.1214451-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to strlcpy() being officially deprecated and the encouragement
to remove the remaining occurrences, this came as the intriguing example.

We don't have a semantic way to bail out in the case kn->name
doesn't fit into buflen sized buffer which traces to sizeof(kernfs_pr_cont_buf)
which is PATH_MAX or currently 4096 bytes, so emulate what would
strlcpy(buf, kn->name, buflen) do not to break things.

(It would not leave an empty string in buf. But this defeats the purpose that
overrun is not silently ignored, but currently there doesn't seem a way to
signal the buffer overrun error to the caller. As the function is static and
the buf is only printed, it seems prudent to leave truncated path rather than
an empty string.)

FIXME: strlen(kn->name) is unprotected from overrun, but for now we preserve
exact behavior using strncpy(). As the return value passed by kernfs_name()
to pr_cont_kernfs_name() where it is ignored later in the code, we could as
well return the number of actually copied characters

     return buflen - 1;

rather than pointless and dangerous strlen(kn->name) of strlcpy(buf, kn->name, buflen).

As semantics are not agreed upon, a FIXME comment was left.

The strlcpy() in kernfs_path_from_node_locked() can never overrun as "(null)"
is needless to say safe for PATH_MAX sized buf and the rest is carefully
computed and protected, so translation is one-for-one.

Fixes: 17627157cda13 ("kernfs: handle null pointers while printing node name and path")
Fixes: 3eef34ad7dc36 ("kernfs: implement kernfs_get_parent(), kernfs_name/path() and friends")
Fixes: 9f6df573a4041 ("kernfs: Add API to generate relative kernfs path")
Fixes: 3abb1d90f5d93 ("kernfs: make kernfs_path*() behave in the style of strlcpy()")
Fixes: e56ed358afd81 ("kernfs: make kernfs_walk_ns() use kernfs_pr_cont_buf[]")
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Aditya Kali <Tejun Heo <tj@kernel.org>adityakali@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Link: https://lwn.net/ml/ksummit-discuss/20231019054642.GF14346@lst.de/#t
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---
v1:
 initial proposal for substituting deprecated strlcpy() with the preferred strscpy()

 fs/kernfs/dir.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8b2bd65d70e7..87456f3842c0 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -53,10 +53,32 @@ static bool kernfs_lockdep(struct kernfs_node *kn)
 
 static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_t buflen)
 {
-	if (!kn)
-		return strlcpy(buf, "(null)", buflen);
+	int len;
 
-	return strlcpy(buf, kn->parent ? kn->name : "/", buflen);
+	if (!kn)
+		return strscpy(buf, "(null)", buflen);
+
+	/**
+	 * We don't have a semantic way to bail out in the case kn->name
+	 * doesn't fit into the buflen which traces to sizeof(kernfs_pr_cont_buf)
+	 * which is PATH_MAX or currently 4096 bytes, so emulate what would
+	 * strlcpy() do not to break things.
+	 *
+	 * FIXME: strlen(kn->name) is unprotected from overrun, but for now we preserve
+	 * exact behavior using strncpy(). As the return value is ignored later in the
+	 * code, we could as well return
+	 *
+	 *	return buflen - 1;
+	 *
+	 * rather than pointless and dangerous strlen(kn->name) of
+	 * strlcpy(buf, kn->name, buflen).
+	 */
+	if ((len = strscpy(buf, kn->parent ? kn->name : "/", buflen)) == -E2BIG) {
+		strncpy(buf, kn->name, buflen);
+		buf[buflen - 1] = '\0';
+		return buflen - 1;
+	} else
+		return len;
 }
 
 /* kernfs_node_depth - compute depth from @from to @to */
@@ -141,13 +163,13 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
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
@@ -159,16 +181,16 @@ static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
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
 
@@ -850,16 +872,13 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 					  const unsigned char *path,
 					  const void *ns)
 {
-	size_t len;
 	char *p, *name;
 
 	lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem);
 
 	spin_lock_irq(&kernfs_pr_cont_lock);
 
-	len = strlcpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
-
-	if (len >= sizeof(kernfs_pr_cont_buf)) {
+	if (strscpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf)) == -E2BIG) {
 		spin_unlock_irq(&kernfs_pr_cont_lock);
 		return NULL;
 	}
-- 
2.34.1

