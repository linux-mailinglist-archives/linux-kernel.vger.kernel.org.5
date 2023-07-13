Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E0775158B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjGMAxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjGMAxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:53:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24732101
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:53:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48066619E4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064B8C433CB;
        Thu, 13 Jul 2023 00:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689209625;
        bh=DMcBbHIWaHTbIq9ru63qI3E9fkbN5xT//N91HNaGRtQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ROFLvgG/95K1Vzvv61tkPhBFx4BcwLyxuWkepaw/umfwk90qjK/RU3bBFaDA4+4F5
         bu4JpXyZRQyTJPJ7NfCE+FawMu4k3fH7UwqCdIp7lpb2o/eYQ2y9x82yQYLYxRUS/t
         DV+aJ60eHxvP+HDB35ONWLbiYBvTLiAim07ckPI3fupKSotXs0KMc0vhC4m1wxzw8d
         fsPVKsP611YjSlYI0jIH28cpMxswWYA1q7r2e6TGFoprIUB0qUeu579YT5/1EPegqU
         OzcNCYjtNn8iUYFfvBXx6Y1jYf5aaPhxrcOQrKsKYaYStOCzcpvX2GFqsW//c09SHP
         PhzZP85w58kJw==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 13 Jul 2023 01:49:20 +0100
Subject: [PATCH 02/11] mfd: cs47l24: Update to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-mfd-cirrus-maple-v1-2-16dacae402a8@kernel.org>
References: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
In-Reply-To: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134; i=broonie@kernel.org;
 h=from:subject:message-id; bh=DMcBbHIWaHTbIq9ru63qI3E9fkbN5xT//N91HNaGRtQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkr0sLyGy1B+IlTty1iV5NhQQZdA3OWvcl8H5Wn
 G/JGK/Ynm2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK9LCwAKCRAk1otyXVSH
 0I+KB/9B/QsLxA6eB1e7qKUw8kkQsEsl2XJwSzAZjaCv97Ha0jWFXW0cR5/MyGCZDA4PUkMC2LP
 ZrRSdBhQbRJcBZY0xPErt79780tKWh2jgnC/Q492I0n0cUgtsNuNVeGzDGScFgT6/ynVcJxoLlE
 fSrN3mK25sWxMmsYRmfupHVYlPoivrglgPE99BU54nc87HIgE6I9IkmIHWbHVJcewiKr5/T/Bg3
 z6AllUElH+S0C02lNq93+grbmfHYMdOeqRfaqOxTPsOl7h+LMbjDWbS78O1IN6DqDUiHV7yyXax
 V0HlXVIqsiAtX165jsk73K70XDUqPn8CyRu3gh4KaiK0Xsgw
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

Update the cs47l24 driver to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/cs47l24-tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/cs47l24-tables.c b/drivers/mfd/cs47l24-tables.c
index c289d92a5c1d..878dfd298a17 100644
--- a/drivers/mfd/cs47l24-tables.c
+++ b/drivers/mfd/cs47l24-tables.c
@@ -1616,7 +1616,7 @@ const struct regmap_config cs47l24_spi_regmap = {
 	.readable_reg = cs47l24_readable_register,
 	.volatile_reg = cs47l24_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.reg_defaults = cs47l24_reg_default,
 	.num_reg_defaults = ARRAY_SIZE(cs47l24_reg_default),
 };

-- 
2.39.2

