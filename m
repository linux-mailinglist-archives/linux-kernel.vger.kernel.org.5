Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3841751596
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjGMAyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjGMAy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:54:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFE7210C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:54:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C0EC619E5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC111C433C8;
        Thu, 13 Jul 2023 00:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689209643;
        bh=LxhvrFeL+Gpj7Qmr5b/IyGJ+AVzm6I0kUVJo1JuCt7I=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=HJaW3QnwWRiD1OoF8dkDIqNT6oKTmaV2TSAJ3iwONv84fDV/8wNFx4MrKj+vBglmr
         PUZCc3lPEwCqN8scn9UjLU+kyuturhN1H/0YWLWECxWr9pfiAJaGbbelKS5xnfOtwD
         TQ8SdVZevWBg7vB4uSevcGKeaaN4Qy059quTviboUHHFDqTw8Z6LVinHFYoi5fWly2
         5dg20ug43Ow0hx7/QXScCQHGQ4j/tCvMdjwIPOC3z17CahIXym81ilbplL9SIGkTsu
         NvULdvEp9uNJANusMS8cyM1gMArJrY7vTrEVdiOI0tfmctuiBEIOw6c9Lcdkg+AuZ6
         y4rmY0IpgzfQA==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 13 Jul 2023 01:49:28 +0100
Subject: [PATCH 10/11] mfd: wm8997: Update to use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-mfd-cirrus-maple-v1-10-16dacae402a8@kernel.org>
References: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
In-Reply-To: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LxhvrFeL+Gpj7Qmr5b/IyGJ+AVzm6I0kUVJo1JuCt7I=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkr0sRpxscLPqDJrncFL/Ygn/56QtMhdNUuMBPM
 6rHWS3o3CWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK9LEQAKCRAk1otyXVSH
 0KleCACEKH56FWa5rh+8+iXB+UL4K0XsQ7SW5jwr5jsail8gfJoGulRImulX7o3XtO61b0lvGYA
 eSmpKsHADfZE3X4czRuTzo+rZt3qqdew/bT6k9x22SyG/6MyMvH6+9A3dzM2LfSt2k1f44m+v2b
 oaiT/Vc1gX7u7CvjJKFfM278apwzkslv+j4tjBPU75ZaB35RC8OGWL/m2rPxEVXrRg+O/YGAgHR
 FKSNBtyF0LqtInBnlW+F0qRQQ8c7wzcg8+uL34sx1R/Q8HSK+Iza26UYOwooi6SpyUSqD4r5ioS
 dJFpqlsg9M20odrLblmdI6HuTChLGcWw9HBcc6WTAtZIF7/o
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Update the wm8997 driver to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/wm8997-tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/wm8997-tables.c b/drivers/mfd/wm8997-tables.c
index 3476787c485e..288c57b2d21e 100644
--- a/drivers/mfd/wm8997-tables.c
+++ b/drivers/mfd/wm8997-tables.c
@@ -1523,7 +1523,7 @@ const struct regmap_config wm8997_i2c_regmap = {
 	.readable_reg = wm8997_readable_register,
 	.volatile_reg = wm8997_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.reg_defaults = wm8997_reg_default,
 	.num_reg_defaults = ARRAY_SIZE(wm8997_reg_default),
 };

-- 
2.39.2

