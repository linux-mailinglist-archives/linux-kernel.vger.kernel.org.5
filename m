Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BDA7F6BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344496AbjKXGFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjKXGET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:04:19 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37001BE;
        Thu, 23 Nov 2023 22:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dygXiWQj01+v+M8EqnLDmRAM15rjFqh51JbrrIY5KXg=; b=GEO3n6mUIzHm/NcIO+KXB6pvDF
        YjpRn42VkFVF2oPiXcmD95jtOpAnBkD/76OIfMA+JcOc3JTiVQfnd9AE819o1KMxoiaGq+m/jrIEz
        xl+LohwoqM6vHCxrJL5qAyZQTGntOwiZtnhU2BcUpdBB01BvckPlSu2v0Hc5kwk3i4Y9uurjqY+Nn
        YEc+6fjdoil80r2X5hKMDq4IuSKhh9VQSIaPjjv7fESvwQUS0nknbz4rH9SB3AgmZPz/KWKFNpoCO
        QT/F+jl2Olw/poIVBarWzLKbmKtpMnAG23aaiGedmvjJ/ciepTyUFywSkyGYjIGLJ4bg5c0WAiRAR
        BGQRivFA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PIe-002PuT-0U;
        Fri, 24 Nov 2023 06:04:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/21] __dentry_kill(): get consistent rules for victim's refcount
Date:   Fri, 24 Nov 2023 06:04:12 +0000
Message-Id: <20231124060422.576198-11-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060422.576198-1-viro@zeniv.linux.org.uk>
References: <20231124060200.GR38156@ZenIV>
 <20231124060422.576198-1-viro@zeniv.linux.org.uk>
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

Currently we call it with refcount equal to 1 when called from
dentry_kill(); all other callers have it equal to 0.

Make it always be called with zero refcount; on this step we
just decrement it before the calls in dentry_kill().  That is
safe, since all places that care about the value of refcount
either do that under ->d_lock or hold a reference to dentry
in question.  Either is sufficient to prevent observing a
dentry immediately prior to __dentry_kill() getting called
from dentry_kill().

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 2e74f3f2ce2e..b527db8e5901 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -729,6 +729,7 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 			goto slow_positive;
 		}
 	}
+	dentry->d_lockref.count--;
 	__dentry_kill(dentry);
 	return parent;
 
@@ -741,6 +742,7 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 	if (unlikely(dentry->d_lockref.count != 1)) {
 		dentry->d_lockref.count--;
 	} else if (likely(!retain_dentry(dentry))) {
+		dentry->d_lockref.count--;
 		__dentry_kill(dentry);
 		return parent;
 	} else {
-- 
2.39.2

