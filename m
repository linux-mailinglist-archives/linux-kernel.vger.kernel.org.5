Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA567FC8BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376354AbjK1VHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346617AbjK1VGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:06:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54F41BC1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:06:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE937C433CA;
        Tue, 28 Nov 2023 21:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205600;
        bh=+NrWQrBv8ISFQLjQerhL7DQug0d51ngGgWX5u9WiijA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSKflLYxHlRUNA2MsgA+j90bkaSaa32qeKna4lC1tJS/NfYEudEewS7tbGzxcCrQg
         o1YvnvfuV9+0J36Cpx1UyJPwkFNmROR34Jx1IpvX2IIzorP/0vVxE84gKhntlbQyCo
         MMSM3ghFGRbF+bUmyOwAsJEQTWUaitENSpNSprZRa3muuEcYM0OLeOq+nm5qJBj3Mr
         vJMazJPvuq72SKirnWMuxmfOFZAXSHmNY5fad1k+tqyO4VkHoDNboHkhb6dYda/6D4
         dM+AprJhFF8iidfWEGlX5u0p1qHofugu3R9OeJU8/esbdNmKB3n2W/+fn2CPlmIWTY
         fR/unBANiE5gw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Li Nan <linan122@huawei.com>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH AUTOSEL 6.6 13/40] nbd: fix null-ptr-dereference while accessing 'nbd->config'
Date:   Tue, 28 Nov 2023 16:05:19 -0500
Message-ID: <20231128210615.875085-13-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

[ Upstream commit c2da049f419417808466c529999170f5c3ef7d3d ]

Memory reordering may occur in nbd_genl_connect(), causing config_refs
to be set to 1 while nbd->config is still empty. Opening nbd at this
time will cause null-ptr-dereference.

   T1                      T2
   nbd_open
    nbd_get_config_unlocked
                 	   nbd_genl_connect
                 	    nbd_alloc_and_init_config
                 	     //memory reordered
                  	     refcount_set(&nbd->config_refs, 1)  // 2
     nbd->config
      ->null point
			     nbd->config = config  // 1

Fix it by adding smp barrier to guarantee the execution sequence.

Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Link: https://lore.kernel.org/r/20231116162316.1740402-4-linan666@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index daaf8805e876c..3f03cb3dc33cc 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -397,8 +397,16 @@ static u32 req_to_nbd_cmd_type(struct request *req)
 
 static struct nbd_config *nbd_get_config_unlocked(struct nbd_device *nbd)
 {
-	if (refcount_inc_not_zero(&nbd->config_refs))
+	if (refcount_inc_not_zero(&nbd->config_refs)) {
+		/*
+		 * Add smp_mb__after_atomic to ensure that reading nbd->config_refs
+		 * and reading nbd->config is ordered. The pair is the barrier in
+		 * nbd_alloc_and_init_config(), avoid nbd->config_refs is set
+		 * before nbd->config.
+		 */
+		smp_mb__after_atomic();
 		return nbd->config;
+	}
 
 	return NULL;
 }
@@ -1559,7 +1567,15 @@ static int nbd_alloc_and_init_config(struct nbd_device *nbd)
 	init_waitqueue_head(&config->conn_wait);
 	config->blksize_bits = NBD_DEF_BLKSIZE_BITS;
 	atomic_set(&config->live_connections, 0);
+
 	nbd->config = config;
+	/*
+	 * Order refcount_set(&nbd->config_refs, 1) and nbd->config assignment,
+	 * its pair is the barrier in nbd_get_config_unlocked().
+	 * So nbd_get_config_unlocked() won't see nbd->config as null after
+	 * refcount_inc_not_zero() succeed.
+	 */
+	smp_mb__before_atomic();
 	refcount_set(&nbd->config_refs, 1);
 
 	return 0;
-- 
2.42.0

