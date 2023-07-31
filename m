Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C9C76A240
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjGaUxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjGaUwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:52:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D23D198B;
        Mon, 31 Jul 2023 13:52:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9521C612CC;
        Mon, 31 Jul 2023 20:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1664C433C8;
        Mon, 31 Jul 2023 20:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690836760;
        bh=4bc7n+F7Mq8FK6H3ud6CK8gDj85KBAh5RyJs5hitlVE=;
        h=Date:From:To:Cc:Subject:From;
        b=eY+wxcw6USz4xRYOjCO77U7nKEkA27D/Zyuj2zPsNqNtlV7JBnJPKdelD6sJYj/Yu
         HEmCgiW2eBi8t8hR2GBe6I7+rRu781RkvhmZ8wQkMr4sQpnVDDm3x9wi+3Ia+CIvOl
         Yyz8uxIVBuVESYD9GlfwIt7QDp0KSFpgh0uonfpC9bhDwYrrkhNa1/V0/iA70+GDCc
         2Unsh5RZjyRXK4AwSs90QRSp7SBCHqS56k0J5LUW18dbsNVknT9wqMkV4fseaNDzwv
         PCl2uCrk7VkJJQCGffugV3PE3RWJXQ1lYtsAoXVgB2JiT8M673AMqIZgAAXGHCCGO5
         8CNNqoweA9foQ==
Date:   Mon, 31 Jul 2023 14:53:44 -0600
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
Subject: [PATCH] cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug
Message-ID: <ZMgfWEA0GAN/Rog8@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the iteration conditions in the for() loop to avoid writing in
array `table` beyond its allocated size.

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

