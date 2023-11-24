Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC667F6C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjKXGKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjKXGJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:09:43 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7566219B0;
        Thu, 23 Nov 2023 22:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=E4j9PmHXo73pvef/B3umcswSWYxSbXtv+J2ZHSkA1+8=; b=X0V3xlMH2WsbArt4e7YAAIkwkk
        Wz8i6Geaq1fYX0yXmzRtzCMiJh4fTcKZpWbMDM7QXu/Zk2CLT4jVcomxqV61r60fV3mS+FoWUnbuA
        NY8Jymq5CT2kFqEQSTAn+QXJ5x+aoSlAW1tuOWWv+X3o0OcskQm56PaXoBLsgzEGNgg3QmZRkWhQ7
        IVXWHGVyQpDTqXMqCy12079OBddSHfUTdDn6yBJtPPwJSTtvZHm+pKPZhfnxsTRy3SN8T8rIMMOXu
        aBhpKJh/6roT6PHQB0hdvLtJ+CeeSUra4l4etFa1mXVhZqU4+cMeBHHtWKiOfCTwKOfaKExHR24s+
        cbscZFAw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PKv-002Q0x-3D;
        Fri, 24 Nov 2023 06:06:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/20] [software coproarchaeology] dentry.h: kill a mysterious comment
Date:   Fri, 24 Nov 2023 06:06:33 +0000
Message-Id: <20231124060644.576611-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060644.576611-1-viro@zeniv.linux.org.uk>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there's a strange comment in front of d_lookup() declaration:

/* appendix may either be NULL or be used for transname suffixes */

Looks like nobody had been curious enough to track its history;
it predates git, it predates bitkeeper and if you look through
the pre-BK trees, you finally arrive at this in 2.1.44-for-davem:
  /* appendix may either be NULL or be used for transname suffixes */
 -extern struct dentry * d_lookup(struct inode * dir, struct qstr * name,
 -                               struct qstr * appendix);
 +extern struct dentry * d_lookup(struct dentry * dir, struct qstr * name);
In other words, it refers to the third argument d_lookup() used to have
back then.  It had been introduced in 2.1.43-pre, on June 12 1997,
along with d_lookup(), only to be removed by July 4 1997, presumably
when the Cthulhu-awful thing it used to be used for (look for
CONFIG_TRANS_NAMES in 2.1.43-pre, and keep a heavy-duty barfbag
ready) had been, er, noticed and recognized for what it had been.

Despite the appendectomy, the comment remained.  Some things really
need to be put out of their misery...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/dcache.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 9706bf1dc5de..a5e5e274eee0 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -270,7 +270,6 @@ extern void d_move(struct dentry *, struct dentry *);
 extern void d_exchange(struct dentry *, struct dentry *);
 extern struct dentry *d_ancestor(struct dentry *, struct dentry *);
 
-/* appendix may either be NULL or be used for transname suffixes */
 extern struct dentry *d_lookup(const struct dentry *, const struct qstr *);
 extern struct dentry *d_hash_and_lookup(struct dentry *, struct qstr *);
 
-- 
2.39.2

