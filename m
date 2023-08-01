Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DED276A75B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 05:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjHADOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 23:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjHADOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 23:14:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136751BC6;
        Mon, 31 Jul 2023 20:14:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FBB1613F1;
        Tue,  1 Aug 2023 03:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471FCC433C7;
        Tue,  1 Aug 2023 03:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690859684;
        bh=2oC1axryfLbP+TCpiGARmMNZzsq4UdhTAH2upeuRKAQ=;
        h=Date:From:To:Cc:Subject:From;
        b=jhgy7qjl3QW+L8CbNw51tigS3tZSBhG/HYf3GSvbGrG3bvuUXIa/O+KxEDzuqxlod
         P8B56Hd4b+zcdPWEl5IIGHS6UoGsWvbbuG9jthVc6U5+CKsvVXqkXKVRTkA8gx81p9
         ahh31yEXdFxO045zP3A+quMQTM+aM9TI4K/rkEgpe1E6RdmezYfXDdO4Tn+w5m9Bas
         XFVjng3yIRffZ5v7IeaTcSHDdcv2ek+Jyb9ZrfH66rbmdDSSOiB0PTJkkHSvCMG6hd
         qy96KAHE9irZRKpqFW2bwKRYnYYizmAT4y/7O1TtLwzNm2i7b+KWFr6aA5gdk/fycJ
         fvHH2fzbvPD/Q==
Date:   Mon, 31 Jul 2023 21:15:48 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH v3] cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug
Message-ID: <ZMh45KH2iPIpNktr@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate extra space for terminating element at:

drivers/cpufreq/brcmstb-avs-cpufreq.c:
449         table[i].frequency = CPUFREQ_TABLE_END;

and add code comment to make this clear.

This fixes the following -Warray-bounds warning seen after building
ARM with multi_v7_defconfig (GCC 13):
In function 'brcm_avs_get_freq_table',
    inlined from 'brcm_avs_cpufreq_init' at drivers/cpufreq/brcmstb-avs-cpufreq.c:623:15:
drivers/cpufreq/brcmstb-avs-cpufreq.c:449:28: warning: array subscript 5 is outside array bounds of 'void[60]' [-Warray-bounds=]
  449 |         table[i].frequency = CPUFREQ_TABLE_END;
In file included from include/linux/node.h:18,
                 from include/linux/cpu.h:17,
                 from include/linux/cpufreq.h:12,
                 from drivers/cpufreq/brcmstb-avs-cpufreq.c:44:
In function 'devm_kmalloc_array',
    inlined from 'devm_kcalloc' at include/linux/device.h:328:9,
    inlined from 'brcm_avs_get_freq_table' at drivers/cpufreq/brcmstb-avs-cpufreq.c:437:10,
    inlined from 'brcm_avs_cpufreq_init' at drivers/cpufreq/brcmstb-avs-cpufreq.c:623:15:
include/linux/device.h:323:16: note: at offset 60 into object of size 60 allocated by 'devm_kmalloc'
  323 |         return devm_kmalloc(dev, bytes, flags);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -Warray-bounds.

Link: https://github.com/KSPP/linux/issues/324
Fixes: de322e085995 ("cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v3:
 - Allocate extra space for a terminating element. (Kees Cook)
 - Update changelog text.

Changes in v2:
 - Update changelog text. Add more details.
 - Link: https://lore.kernel.org/linux-hardening/202307311610.B1EB796684@keescook/

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZMgfWEA0GAN%2FRog8@work/

 drivers/cpufreq/brcmstb-avs-cpufreq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index ffea6402189d..3052949aebbc 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -434,7 +434,11 @@ brcm_avs_get_freq_table(struct device *dev, struct private_data *priv)
 	if (ret)
 		return ERR_PTR(ret);
 
-	table = devm_kcalloc(dev, AVS_PSTATE_MAX + 1, sizeof(*table),
+	/*
+	 * We allocate space for the 5 different P-STATES AVS,
+	 * plus extra space for a terminating element.
+	 */
+	table = devm_kcalloc(dev, AVS_PSTATE_MAX + 1 + 1, sizeof(*table),
 			     GFP_KERNEL);
 	if (!table)
 		return ERR_PTR(-ENOMEM);
-- 
2.34.1

