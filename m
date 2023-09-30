Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815D07B44AD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 01:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjI3XoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 19:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbjI3XoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 19:44:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B79BC;
        Sat, 30 Sep 2023 16:44:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32DBC433C7;
        Sat, 30 Sep 2023 23:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696117442;
        bh=gWdnyYXttxIjh88wfA/QmRjMof3T9So3DMxuvdVdIUQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=VJtuRrycxQGWoNSXUGTCkRhEeCg5lX5JvxdNj8wVaN/6ubtt2Rt9m+QvUYrOcqhhl
         kDchcEJ6ScCH7X4NYvhjLP13UMcUujADKfV2mBS10pgfGepFDOG+vW/gAvrq/1Pj2i
         QckII3LthanX+9sFXcBm1tMPGpv0uSizTkbQx2/R+Dz7Nn+NmCMkin58Ov/+v2UGrE
         NNk5l2StLvs50NwwwuD/Bm5KewJLZmQaCziKAryOqLZpkjv8DWaiXCfc/vFv5wvoLA
         K8Ypr+1fBE/NopMO//WKG8DmP82Cf4WHPXcWRbTEVkS8tWHLS6tj0pIvtMN1jGGf8Y
         9MD6qOESx2r4g==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 01 Oct 2023 01:43:39 +0200
Subject: [PATCH 2/3] Input: cap11xx - Convert to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-input-maple-v1-2-ed3716051431@kernel.org>
References: <20231001-input-maple-v1-0-ed3716051431@kernel.org>
In-Reply-To: <20231001-input-maple-v1-0-ed3716051431@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=887; i=broonie@kernel.org;
 h=from:subject:message-id; bh=gWdnyYXttxIjh88wfA/QmRjMof3T9So3DMxuvdVdIUQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGLK8phUcg9KoLSH9kT34IAkPQCetOyoMtXxGV
 fMmWLgzFLWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRiyvAAKCRAk1otyXVSH
 0OT7B/9Jgtz/re02rBFTuuXqFAw5agg5zLC7OM9Ge1yr6WEFqwfbqsh42MxBo/S2dsQGqnlSgCj
 q8Q3Ve7Gmiv9zSWQDvB9Hcao7IY1DI3ZOgetJdZeODUoJHmLQxwBA0FZCwwCA3dFTvhIoZSeCU7
 p5jcICAnRAvLA6VQTXfFgPpbEvIN3KT18QevJfjPipWwerUEFhxqMXXqOVUHmGFBQ2dFP2F3DoD
 5GJL5m63EHUxAFyzgZQcgIcQ2LCrq4+tFMJLazvMYmXkeQDsXxK7Pp9XF3NhfQnfDfeZs2QSQB/
 Jz3+N+naNRdAFVuYCKNuBa1jivzbTpkv/Imj27GJlTK4A2Be
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/input/keyboard/cap11xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 39ed3b9ddc65..77843ad15d4c 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -174,7 +174,7 @@ static const struct regmap_config cap11xx_regmap_config = {
 	.reg_defaults = cap11xx_reg_defaults,
 
 	.num_reg_defaults = ARRAY_SIZE(cap11xx_reg_defaults),
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_reg = cap11xx_volatile_reg,
 };
 

-- 
2.39.2

