Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295997B34D2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjI2O0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjI2O0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:26:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C981A4;
        Fri, 29 Sep 2023 07:26:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74F3C433C7;
        Fri, 29 Sep 2023 14:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695997578;
        bh=KsSNZ/3pcClI6JWLRtjeqqaFMfgqGK3sBrnSG42ii28=;
        h=From:Subject:Date:To:Cc:From;
        b=ki792AsDeqafsGKRHaLPX/FhgHJKJPcuCrDc0nJXv3uCVX4i6Tnfuf2plv6FPsUEC
         keN4/VwGFX6VXtUAs1U8ZjZBQNU4y8UwHLwJDxj6IB5lD76ej8KfWjzET+F457Mp49
         5DNBuynb3fTqby1iWh8+4StW5yklJPi1zayrup6x1lkwAB2I3QP/+G1IE4uhe83yen
         epzR3mh7FLhNRMOF+8ukXY5R6qsrSBgL5SkRuR7L12vBQd7vkEUkIHBUS3sdtGbnBy
         GoP6fIofgursoTU1ggffUUJPVGK//SoBfDSKjXhru/TKruuMGUYYWPPOgOFPQubP+j
         NiQXg7o6JE9xA==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/4] clk: versaclock: regmap modernisations
Date:   Fri, 29 Sep 2023 16:26:04 +0200
Message-Id: <20230929-clk-maple-versaclk-v1-0-24dd5b3d8689@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHzeFmUC/x3MQQqAIBBA0avErBNyCsKuEi3MxhoyCwUJpLtnL
 d/i/wyRAlOEocoQKHHk0xfIugKzab+S4KUYsMG2UaiEcbs49OVIJApRf5SorO7s3Eu0UMIrkOX
 7n47T87y3UiFZZAAAAA==
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Alex Helms <alexander.helms.jy@renesas.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1075; i=broonie@kernel.org;
 h=from:subject:message-id; bh=KsSNZ/3pcClI6JWLRtjeqqaFMfgqGK3sBrnSG42ii28=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFt6EKxU/IFy5CpEoIBiGgMRKNDgrQV2ACWdw3
 dHdvgE3IhCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRbehAAKCRAk1otyXVSH
 0KDbB/4p0wUMeG+qaPtEwghbVlW3q/oWwCeAhQUNBXYTvKfZ5LMQq1mT4gAyaPNOtDFW7KeDNu7
 rE0KpM91MdGc5gIKqPqnuh0Gbff2Xpdi7MkcggxlH0O0CBQ2Uz9IM9BEi6oXPtGvPIPywK02T1U
 RxdmFNB5gDqkE3R89MFNNnI/XYvZ+KEfqUBKYRyMgb6tY8rjcXAijnOUrZncXa5XkN8SuDcqH6G
 vGb25A6/7OHxBH3KmsNG+9fqVBNH+J8uGGLj9i/8qYJ7YUYTxfkilXDgSE6Ehujx76vedvdygI5
 aWtQeMpEuALJ6FmujSp4CPqETIag0g2gLMftN1rt3KogwNPH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree register cache is a more modern replacement for the
rbtree cache which uses a more modern data structure and makes decisions
likely to be better for more current hardware, update the versaclock
drivers to use it.

While looking at updating the cache types I noticed a minor optimisation
opportunity with a redundant _is_writeable() operation in versaclock3 so
I updated that too.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (4):
      clk: versaclock3: Remove redundant _is_writeable()
      clk: versaclock3: Convert to use maple tree register cache
      clk: versaclock5: Convert to use maple tree register cache
      clk: versaclock7: Convert to use maple tree register cache

 drivers/clk/clk-versaclock3.c | 8 +-------
 drivers/clk/clk-versaclock5.c | 2 +-
 drivers/clk/clk-versaclock7.c | 2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)
---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230929-clk-maple-versaclk-129fa4fb712f

Best regards,
-- 
Mark Brown <broonie@kernel.org>

