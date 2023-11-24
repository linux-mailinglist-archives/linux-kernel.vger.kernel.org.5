Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160EA7F6C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344340AbjKXGKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjKXGJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:09:44 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099684C16;
        Thu, 23 Nov 2023 22:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=LmN7YWFVeedmNnhXo1eJlBUZcdYWMPMK9OY6elEEKrk=; b=ZTyrOv0DE6D19HqqHyqvlNOsJ4
        X2vB3RXCW234Z4IpK73Fms812wOExb+kaNWU+p+5TpXVbg4Y3FVy+ruXfooZK/o4zdK/DHAPhSoPD
        8R0wWqqQinI5JRIbKaKQkosP9bj0jrNi/4DiQAtAtb4U3ZCtBJP4ornQmbtKDQzE2GU7+jGQYYuCK
        jRfX52dnOlpcGvUzvwmk4rGSvgVA1t7sx60vNhu8h034oaAbNPpszwCLDcTJuIWqzo5yRqO+TYwdA
        ALtVJbSRsEWLUFuBsQB/ePQFQU3vZcVRPdrmgIEM88ikSXA7k9yJ52WKLYtO6RkoRaHaTDMbX0TKh
        7UQO7H7A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PKx-002Q1g-1H;
        Fri, 24 Nov 2023 06:06:47 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/20] get rid of DCACHE_GENOCIDE
Date:   Fri, 24 Nov 2023 06:06:40 +0000
Message-Id: <20231124060644.576611-16-viro@zeniv.linux.org.uk>
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

... now that we never call d_genocide() other than from kill_litter_super()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c            | 5 +----
 include/linux/dcache.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1296a3fa4f93..440b46851f52 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3196,10 +3196,7 @@ static enum d_walk_ret d_genocide_kill(void *data, struct dentry *dentry)
 		if (d_unhashed(dentry) || !dentry->d_inode)
 			return D_WALK_SKIP;
 
-		if (!(dentry->d_flags & DCACHE_GENOCIDE)) {
-			dentry->d_flags |= DCACHE_GENOCIDE;
-			dentry->d_lockref.count--;
-		}
+		dentry->d_lockref.count--;
 	}
 	return D_WALK_CONTINUE;
 }
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index b4324d47f249..981f529c6cb5 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -173,7 +173,6 @@ struct dentry_operations {
 #define DCACHE_DONTCACHE		BIT(7) /* Purge from memory on final dput() */
 
 #define DCACHE_CANT_MOUNT		BIT(8)
-#define DCACHE_GENOCIDE			BIT(9)
 #define DCACHE_SHRINK_LIST		BIT(10)
 
 #define DCACHE_OP_WEAK_REVALIDATE	BIT(11)
-- 
2.39.2

