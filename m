Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC518125C1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 04:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjLNDId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 22:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNDId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 22:08:33 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6253D0;
        Wed, 13 Dec 2023 19:08:37 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VySjsdn_1702523314;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VySjsdn_1702523314)
          by smtp.aliyun-inc.com;
          Thu, 14 Dec 2023 11:08:35 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] crypto: lib/mpi - Fix unexpected pointer access
Date:   Thu, 14 Dec 2023 11:08:34 +0800
Message-Id: <20231214030834.2665-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the mpi_ec_ctx structure is initialized, some fields are not
cleared, causing a crash when referencing the field when the
structure was released. Initially, this issue was ignored because
memory for mpi_ec_ctx is allocated with the __GFP_ZERO flag.
For example, this error will be triggered when calculating the
Za value for SM2 separately.

Fixes: d58bb7e55a8a ("lib/mpi: Introduce ec implementation to MPI library")
Cc: stable@vger.kernel.org # v6.5
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 lib/crypto/mpi/ec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/crypto/mpi/ec.c b/lib/crypto/mpi/ec.c
index 40f5908e57a4..e16dca1e23d5 100644
--- a/lib/crypto/mpi/ec.c
+++ b/lib/crypto/mpi/ec.c
@@ -584,6 +584,9 @@ void mpi_ec_init(struct mpi_ec_ctx *ctx, enum gcry_mpi_ec_models model,
 	ctx->a = mpi_copy(a);
 	ctx->b = mpi_copy(b);
 
+	ctx->d = NULL;
+	ctx->t.two_inv_p = NULL;
+
 	ctx->t.p_barrett = use_barrett > 0 ? mpi_barrett_init(ctx->p, 0) : NULL;
 
 	mpi_ec_get_reset(ctx);
-- 
2.24.3 (Apple Git-128)

