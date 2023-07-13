Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3D0751593
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjGMAyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjGMAyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:54:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F852709
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:54:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8484619EC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67001C433C8;
        Thu, 13 Jul 2023 00:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689209639;
        bh=4xCyosK5hPNwehtDaNrTf/Y8gMcOBjAwl62LZXcJO2k=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=pSkjhgImx+SaRhrDL82JHZ6UnXod1X3YmYRn45w9oGQgn9Extnkav5IsHqNWbSzy7
         ScwQSFhloyQRWAlIykv073UWQQqwVF6MLtRvUA+xKdyj9jMfd4aAq+eGCBh/EohZsP
         Dk3PksxGem3QhDZzxVXBgyNFpK1TSiOAKJADaiKhOk4q/QUr4z40RmLIlqxRJtUWe/
         Mo51nn7fpeWlg/IxQEQYbxMVRMQrC3lpq9t9JMe+jT6ihfQus1a0RwrOj7YRiDPmEF
         jN6wpw30eMKaL79A6s9+fk8QAieP2PGlfEzajy9UbyRzBxowQBbfpV2CsW7dw0clMT
         HA0ILUy3wlZbg==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 13 Jul 2023 01:49:26 +0100
Subject: [PATCH 08/11] mfd: wm5110: Update to use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-mfd-cirrus-maple-v1-8-16dacae402a8@kernel.org>
References: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
In-Reply-To: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4xCyosK5hPNwehtDaNrTf/Y8gMcOBjAwl62LZXcJO2k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkr0sQ6b19gj1t3pk+IspVD63ACwUKmce+gW+3J
 fVQOh697P+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK9LEAAKCRAk1otyXVSH
 0FoECACGXALSQaWFQAnJ0GizEuUj7FSKDd7D6pHsgjYAqoKb7eaoSlzGKd5EgQcCwrFup4UB2St
 MDE2EPWQfIRPszMNUzZHPqVZI52AedurNdmwu1olUyR+QMHJXKYqBgScjgMZIguDv8195eJCZnp
 Ril2f8nSFPL5sgFaDLjvIPSJhDhKRD97w/lTTOPuylJ4oVzo8BHDACN13jPFtoxGVChmWLftrBa
 NExSO5w5VkWIND6zBvpiGM18YU6pbjWOJJg+eWUmXN5QFonj+qlRgmpmSYXf/Uh38py14OZObxd
 otVyxuRLhmraYFSZrS2Mnkh/s8/ryhqsLmFiq94WRrUB6X+2
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

Update the wm5110 driver to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/wm5110-tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/wm5110-tables.c b/drivers/mfd/wm5110-tables.c
index 65b9b1d6daec..eba324875afd 100644
--- a/drivers/mfd/wm5110-tables.c
+++ b/drivers/mfd/wm5110-tables.c
@@ -3218,7 +3218,7 @@ const struct regmap_config wm5110_i2c_regmap = {
 	.readable_reg = wm5110_readable_register,
 	.volatile_reg = wm5110_volatile_register,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.reg_defaults = wm5110_reg_default,
 	.num_reg_defaults = ARRAY_SIZE(wm5110_reg_default),
 };

-- 
2.39.2

