Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBCF7F6C41
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbjKXGSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjKXGSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:18:08 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A4919B1;
        Thu, 23 Nov 2023 22:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QOwAEHjAzooiTixlURPQlI4OYbvcu2xupAv3xF9Peuk=; b=Qbbyk1uo2Pul/QQ1Qx/TFF3EfR
        7krygJOlZpmSQq8mZh40soaNMQbHRHXR62k5ylGUMpL27wtLvO1qPtmHVAA/VzGBuni2HEv8oJiTD
        FqF0yDTLw1avpKGI7iR65+13M+pBmM6+5euuvpYO5GN0NPrGko4u8yUAScivLnnt6GIxoUkClTRYu
        nwy6AzVbaHDe/o1I21EZg06g/ljqQIwt76wO06cMXDpXJQ71qxdlp+RpJe7nehyF/kAiUN4XGKylj
        MhGcqz+UinMeMCNVnFt89VbWqgtwvbhc/AVesV8zDm5Fx+tqiF/QPVLFUd8NIoQks43MCMzr1xn5r
        cqORuJnQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PKx-002Q1k-21;
        Fri, 24 Nov 2023 06:06:47 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/20] d_alloc_parallel(): in-lookup hash insertion doesn't need an RCU variant
Date:   Fri, 24 Nov 2023 06:06:41 +0000
Message-Id: <20231124060644.576611-17-viro@zeniv.linux.org.uk>
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

We only search in the damn thing under hlist_bl_lock(); RCU variant
of insertion was, IIRC, pretty much cargo-culted - mea culpa...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 440b46851f52..51e2f777a2c5 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2690,7 +2690,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	/* we can't take ->d_lock here; it's OK, though. */
 	new->d_flags |= DCACHE_PAR_LOOKUP;
 	new->d_wait = wq;
-	hlist_bl_add_head_rcu(&new->d_u.d_in_lookup_hash, b);
+	hlist_bl_add_head(&new->d_u.d_in_lookup_hash, b);
 	hlist_bl_unlock(b);
 	return new;
 mismatch:
-- 
2.39.2

