Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A84576A26C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjGaVGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGaVGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:06:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2F4194;
        Mon, 31 Jul 2023 14:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65687612DD;
        Mon, 31 Jul 2023 21:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2DDC433C8;
        Mon, 31 Jul 2023 21:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690837575;
        bh=uFmV+Z9IEZrlWvkA9y0SJYB4T9OHFEmD0Fdew8OiXcs=;
        h=Date:From:To:Cc:Subject:From;
        b=mrH744iQrz7H9/m2jMOkpp+sRDM/1X4YqksMXBA8LCgMQY5YbV4fybbNg3IaYLGKM
         5+A1YzHtc3n4Kf6PbHETyDFT5o6x7m2JVuKlSqq0+272oHJ7Ir4Jp72rx8ElT2GWxd
         Yo41hVxoS6xL+TGS1WDKtj+TYqWE/VYIrbRLLN6hmWbOEfxV8Uzn2/8fuTxx6vCXVN
         Xg/8stS3DgMQ0rbmzutxZv4FCO5An08+w9GTNWiTWIbKaZapx8qD6rxBjG8eM7sQVm
         YfKr9aVn2BIzRwMN6b9wNdUVPI7zF1tZpXABmwJKGTHQTOaZ8raJURDgTEL78B/pi/
         xzGk2wffY3U5w==
Date:   Mon, 31 Jul 2023 15:07:20 -0600
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
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug
Message-ID: <ZMgiiEmBORZRaobc@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the iteration conditions in the for() loop to avoid writing in
array `table` beyond its allocated size at:

drivers/cpufreq/brcmstb-avs-cpufreq.c:
449         table[i].frequency = CPUFREQ_TABLE_END;

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
Changes in v2:
 - Update changelog text. Add more details.

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZMgfWEA0GAN%2FRog8@work/

 drivers/cpufreq/brcmstb-avs-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 1bdd513bcd19..99ba2d707eff 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -439,7 +439,7 @@ brcm_avs_get_freq_table(struct device *dev, struct private_data *priv)
 	if (!table)
 		return ERR_PTR(-ENOMEM);
 
-	for (i = AVS_PSTATE_P0; i <= AVS_PSTATE_MAX; i++) {
+	for (i = AVS_PSTATE_P0; i < AVS_PSTATE_MAX; i++) {
 		ret = brcm_avs_set_pstate(priv, i);
 		if (ret)
 			return ERR_PTR(ret);
-- 
2.34.1

