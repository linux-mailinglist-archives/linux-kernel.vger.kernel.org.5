Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902897B37FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbjI2Qbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjI2Qbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:31:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263281A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:31:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c136ee106so1912822166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696005103; x=1696609903; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvOJgy48B1qqeyvTcx6jWjknArAYSXHsAq6fVEP2r78=;
        b=TmiPjF85x5aBdt5hf8nnY+o/nIr+w1lu/XRU2whwrpDvReGLlMaYf8OyfMyPInQwGW
         U3D2wHzmeWU+6OmKBtDpSzGdL6yxD+l2TDSFTjFU1d3CdpL7+mW/6fmapZLbTyMf9rKF
         5URjTe1jKal5/bDca6VQQw/0TWDN7U3G1T4g89HRjuUe9GMrqhGeBcvpV2VbpsIkfBbQ
         zCFkagRPnrBoj5JKIuTXiucPGB7J/9JeLDCjZ8rCD/ps5AfwXjUF3kR7x4Fv03Hc5JFU
         n7bUeIs8fNhug/WtpwoAlIwKllK8YvkQvEsakWpQ4TqECxPbbcT9enKe4YGM2OkHjfhj
         8agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696005103; x=1696609903;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvOJgy48B1qqeyvTcx6jWjknArAYSXHsAq6fVEP2r78=;
        b=S0dUqY9Zo6QHjt4hpmccZ5I02sPM28jVnQf5Wt0+PIAzMxCKuw66DrKyd3dqFuEZuC
         bGqCOyQtb4AjldAXcn9NmiV0hzF6X/ck3O0DsKXxP28qNIB64+hOySeKCyb5xQ0KyKUn
         AQjOEoOvVLoi0TAwlAyMrfG2yepA3zizZDN0eOMv+dazmcgx+1z57j/MR1UTaKElGUVL
         lORYCJamZGieq4ZW9tTLbX1Et6UtBVQJkNA3dFwpV2g7fJ1/y7si87tdMRH+7H7J8bAH
         tr8CnXJImwGjtdsls4Rk8LWX1kuitEkJoi3aTSLFWAFmjoM2wS1uVKBcmEUcpsSL5Unl
         Qvpw==
X-Gm-Message-State: AOJu0YyjV1UukGPte2opKa0ZrQNSDy5HVJ/aCd0b+HtTIq3YiFDe9Ikz
        wmHRVeOkvnulDuoqOUfq7xu2vrlp2A==
X-Google-Smtp-Source: AGHT+IHIs60N/9/ySSGKXc2pQdASzkqDIRJA0/kLlQOV6zk9MKVV8gXQcpH1O3lIOY9Z+8JoqGs7GQ==
X-Received: by 2002:a17:907:1dcc:b0:9ae:406c:3425 with SMTP id og12-20020a1709071dcc00b009ae406c3425mr4817704ejc.0.1696005103256;
        Fri, 29 Sep 2023 09:31:43 -0700 (PDT)
Received: from p183 ([46.53.252.219])
        by smtp.gmail.com with ESMTPSA id z11-20020a170906944b00b009a5f7fb51dcsm12595163ejx.42.2023.09.29.09.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 09:31:42 -0700 (PDT)
Date:   Fri, 29 Sep 2023 19:31:41 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: save LOC by using while loop
Message-ID: <82c8f8e7-8ded-46ca-8857-e60b991d6205@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use while loop instead of infinite loop with "break;".

Also move some variable to the inner scope where they belong.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/inode.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -110,18 +110,15 @@ void __init proc_init_kmemcache(void)
 
 void proc_invalidate_siblings_dcache(struct hlist_head *inodes, spinlock_t *lock)
 {
-	struct inode *inode;
-	struct proc_inode *ei;
 	struct hlist_node *node;
 	struct super_block *old_sb = NULL;
 
 	rcu_read_lock();
-	for (;;) {
+	while ((node = hlist_first_rcu(inodes))) {
+		struct proc_inode *ei = hlist_entry(node, struct proc_inode, sibling_inodes);
 		struct super_block *sb;
-		node = hlist_first_rcu(inodes);
-		if (!node)
-			break;
-		ei = hlist_entry(node, struct proc_inode, sibling_inodes);
+		struct inode *inode;
+
 		spin_lock(lock);
 		hlist_del_init_rcu(&ei->sibling_inodes);
 		spin_unlock(lock);
