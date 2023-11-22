Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633497F54DD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344410AbjKVXdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjKVXc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:32:59 -0500
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B5E1B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:32:33 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700695952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qgv33Ovxam0+KiksvHm1DaTN1DFcMIwCLo7TltDYJWk=;
        b=BsDuU21WrjJl0BjQ0mHT2oy9QZIswuRNbpcZm/xDU+FSGPNd3DFXdPAZKbnv8QQ032ltZx
        ud0N+bpOfodRztqH1p47dyIB0WVCl9V/YnCOPKBmx2/jU7LgZogfC7Zkf4YWIWQTJP+KoY
        n5zGcjDgVDOUHd7nA1dgzCHC4nXQIyY=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] rhashtable: Better error message on allocation failure
Date:   Wed, 22 Nov 2023 18:32:16 -0500
Message-ID: <20231122233225.178910-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory allocation failures print backtraces by default, but when we're
running out of a rhashtable worker the backtrace is useless - it doesn't
tell us which hashtable the allocation failure was for.

This adds a dedicated warning that prints out functions from the
rhashtable params, which will be a bit more useful.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Thomas Graf <tgraf@suug.ch>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
 lib/rhashtable.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 6ae2ba8e06a2..d3fce9c8989a 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -360,9 +360,14 @@ static int rhashtable_rehash_alloc(struct rhashtable *ht,
 
 	ASSERT_RHT_MUTEX(ht);
 
-	new_tbl = bucket_table_alloc(ht, size, GFP_KERNEL);
-	if (new_tbl == NULL)
+	new_tbl = bucket_table_alloc(ht, size, GFP_KERNEL|__GFP_NOWARN);
+	if (new_tbl == NULL) {
+		WARN("rhashtable bucket table allocation failure for %ps",
+		     (void *) ht->p.hashfn ?:
+		     (void *) ht->p.obj_hashfn ?:
+		     (void *) ht->p.obj_cmpfn);
 		return -ENOMEM;
+	}
 
 	err = rhashtable_rehash_attach(ht, old_tbl, new_tbl);
 	if (err)
-- 
2.42.0

