Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B11751595
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjGMAyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjGMAyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:54:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE3B2722
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:54:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE1E061A01
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B57C433CB;
        Thu, 13 Jul 2023 00:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689209641;
        bh=bgb4zzrORARsttsVydsHYK2GR/dBIf7Y05nOGfBm76Q=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=E3L0NFRriB2e+qQymmmDygbgT2zGzhTC3pL6IYAPKSSLS6NGAFgy7noyB5qJQSF6I
         dt9nfEXeWjxZr76nkTjbCfMzozZdGCDN11G3Cpokycjw3Aw8NtJQ/Lo0WUvCqDWpZG
         8cXNShcC6vK7tOX+5jEIlYvNUw7nyLDchkKI5yaAtrLsKdgrzjrFCcL5jj9mAWv0h4
         NBdf5LAuqR6uGYJMvKXw5FELQ0XsYx1H2PtypWqtevBzFNE+rA+72xGiBfYGVRJp2M
         rIYvRN8cmkiSW6T1hDICEAKq6A7s9Wb8utUD/IOJPgv7WbGx023NvbXurHa/OLTjPZ
         O6Q++DhhpAA2A==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 13 Jul 2023 01:49:27 +0100
Subject: [PATCH 09/11] mfd: wm8994: Update to use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-mfd-cirrus-maple-v1-9-16dacae402a8@kernel.org>
References: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
In-Reply-To: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1602; i=broonie@kernel.org;
 h=from:subject:message-id; bh=bgb4zzrORARsttsVydsHYK2GR/dBIf7Y05nOGfBm76Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkr0sQP16X+5LO03wDeyBuSFRWgtqyxe/bYiSDo
 bVKlVemph6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK9LEAAKCRAk1otyXVSH
 0JzQB/95CWvUzhmhz2JVDo4P8KEtrsoRWkifqnHg3s2q32MLacOQJgC+/ci/oNb1TcgNNzbU8hj
 8MYoK+h+RW/L0QofLHS+dip/p/hORXSRo4/oGzIDhSnWm/iA9eLZ/TX//qZxxuloyH0lEgUVIdh
 QLtOVJXJd9SPkWCCDOMp04X8erf7UDTBU2hVPnopZWrjv5B/SqnnGL8N/prP6S68vgVBx9EMkhL
 7jVNmiyroCbtWQE1JBF0CByz8Q1nz/WaE0jf1Kwv58Chkpd0PXRUAuPwzov6W9n4QN+EVQ0EAp3
 +ZhcjmSYEniPU8RoG5jZtEBhgBhxGf5H5dzyhcLEflJ1gmLA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache. In
v6.5 it has also acquired the ability to generate multi-register writes in
sync operations, bringing performance up to parity with the rbtree cache
there.

Update the wm8994 driver to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/wm8994-regmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/wm8994-regmap.c b/drivers/mfd/wm8994-regmap.c
index cd4fef7df336..ee2ed6773afd 100644
--- a/drivers/mfd/wm8994-regmap.c
+++ b/drivers/mfd/wm8994-regmap.c
@@ -1238,7 +1238,7 @@ struct regmap_config wm1811_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 16,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 
 	.reg_defaults = wm1811_defaults,
 	.num_reg_defaults = ARRAY_SIZE(wm1811_defaults),
@@ -1253,7 +1253,7 @@ struct regmap_config wm8994_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 16,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 
 	.reg_defaults = wm8994_defaults,
 	.num_reg_defaults = ARRAY_SIZE(wm8994_defaults),
@@ -1268,7 +1268,7 @@ struct regmap_config wm8958_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 16,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 
 	.reg_defaults = wm8958_defaults,
 	.num_reg_defaults = ARRAY_SIZE(wm8958_defaults),

-- 
2.39.2

