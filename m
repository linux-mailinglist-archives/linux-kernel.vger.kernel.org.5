Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B36E766EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbjG1Nse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbjG1Nsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:48:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C8F272C;
        Fri, 28 Jul 2023 06:48:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BCBB62130;
        Fri, 28 Jul 2023 13:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A17C433C8;
        Fri, 28 Jul 2023 13:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690552106;
        bh=BfRz7+IlBdcF/JG2+s7kyWYuaZqm69j/PYmjGHVN70o=;
        h=From:To:Cc:Subject:Date:From;
        b=lvCkqtRAi8C7XvpKMhWGHtKa0QETNY+KmCu8+jY3Bh016P9n1rKIO2x8z6FfKWySn
         DeiaZuEuhSVlLO9Ch16BbQaU4Pqu1ibMBv/rgPFTkOtEqJmP4hs0X+tylmku3eZIL4
         +X/C01JgkUrN2L0Rkocp9fvIhGI4DMc/52Atw9Q1D7BcgF1+ud1pjluc7386uLEEgH
         RjYy3qwNWFWmfoLzhI5YZezFQQY1Jzb6TPSE/bx6ZBd/rkygyr4kmnSxNdCmvUgP4N
         +TwxLubl8qT+0aoA+MNULE7MxHjEHlB+G/G4bg0nIjVoJdNe7rAAr9zBMVm5aZhqV2
         aySD4bVBoLdLg==
Received: (nullmailer pid 3224159 invoked by uid 1000);
        Fri, 28 Jul 2023 13:48:24 -0000
From:   Rob Herring <robh@kernel.org>
To:     Corey Minyard <minyard@acm.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] ipmi: Explicitly include correct DT includes
Date:   Fri, 28 Jul 2023 07:48:18 -0600
Message-Id: <20230728134819.3224045-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it was merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
 - Split out hw_random, ipmi and tpm
---
 drivers/char/ipmi/kcs_bmc_aspeed.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index 2dea8cd5a09a..72640da55380 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/poll.h>
 #include <linux/regmap.h>
-- 
2.40.1

