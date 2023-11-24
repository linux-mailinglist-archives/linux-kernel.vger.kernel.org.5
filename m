Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F487F6C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344825AbjKXGFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjKXGEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:04:21 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84A0D71;
        Thu, 23 Nov 2023 22:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DSWH6ypd/JmZdBaXpi9Usyj9hcz5TwIIngwOFUz72p0=; b=wYsIeqWcIUAkisRbAQQlxrGg9H
        wT3mQx86KdlVBqT3CGV62ZKmSv/1hbtfusFE9jTKNQS2pv30R40rxjtOSpYgjIdQx4JHlzSNLYBGB
        tIJ2h/0YVaUStN/PgXYuf8B8L1xDeNuzFG8GPQVOlFpy7du8fwvuJ6Rglp7Dp2GNOQ70PQOUYOVaf
        UnDfHG1jBS7uq2MQJwQfV58ozzPnYMQdT7xMq7xooQ/kbA3/66LeoS2fW+wS7TFpdXwQ/nKThawU4
        prA5QQC3IiLS7AkwTVUzJdBVNtlFI2koKhLJbH3aQBJv5ghsPV12InRel94v0ewAo16ZBAGi2wLo4
        nfLekm3A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PIg-002Pv9-1S;
        Fri, 24 Nov 2023 06:04:26 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 18/21] switch select_collect{,2}() to use of to_shrink_list()
Date:   Fri, 24 Nov 2023 06:04:19 +0000
Message-Id: <20231124060422.576198-18-viro@zeniv.linux.org.uk>
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 704676bf06fd..f68fe7c863e0 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1495,13 +1495,9 @@ static enum d_walk_ret select_collect(void *_data, struct dentry *dentry)
 
 	if (dentry->d_flags & DCACHE_SHRINK_LIST) {
 		data->found++;
-	} else {
-		if (dentry->d_flags & DCACHE_LRU_LIST)
-			d_lru_del(dentry);
-		if (!dentry->d_lockref.count) {
-			d_shrink_add(dentry, &data->dispose);
-			data->found++;
-		}
+	} else if (!dentry->d_lockref.count) {
+		to_shrink_list(dentry, &data->dispose);
+		data->found++;
 	}
 	/*
 	 * We can return to the caller if we have found some (this
@@ -1522,17 +1518,13 @@ static enum d_walk_ret select_collect2(void *_data, struct dentry *dentry)
 	if (data->start == dentry)
 		goto out;
 
-	if (dentry->d_flags & DCACHE_SHRINK_LIST) {
-		if (!dentry->d_lockref.count) {
+	if (!dentry->d_lockref.count) {
+		if (dentry->d_flags & DCACHE_SHRINK_LIST) {
 			rcu_read_lock();
 			data->victim = dentry;
 			return D_WALK_QUIT;
 		}
-	} else {
-		if (dentry->d_flags & DCACHE_LRU_LIST)
-			d_lru_del(dentry);
-		if (!dentry->d_lockref.count)
-			d_shrink_add(dentry, &data->dispose);
+		to_shrink_list(dentry, &data->dispose);
 	}
 	/*
 	 * We can return to the caller if we have found some (this
-- 
2.39.2

