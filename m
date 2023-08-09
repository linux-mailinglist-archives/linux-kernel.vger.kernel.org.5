Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999AA77543B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjHIHex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjHIHew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:34:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8F610C6;
        Wed,  9 Aug 2023 00:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5E9762FE2;
        Wed,  9 Aug 2023 07:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A0FC433C7;
        Wed,  9 Aug 2023 07:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691566491;
        bh=60Y6J4I0j3xXL5Nco312J593o+/GGtthikOgUobZJYo=;
        h=From:To:Cc:Subject:Date:From;
        b=KLYbVGAPMTOE6TBQhJigf7VgNNYfcES5L5qJFBKGt1lX4B7ZhbYwkwLo2SVmkKUlx
         jLl4q13qQfGDIX1SSZwBVsqxJc37jScOg/DEQEqi8jus0qQ1rn2aAQrhB9XYMWaYG5
         ZWaScln3FVt0MBewvBUzRQGa0MXJ1u13QtJCL33XV2CAqaVCSVUKzz9dKAyBtpy+0B
         1+lJCA0TmNshW026Cs1LL23QCTwDn/nAsHmDaVMIcDNtoi2BXG4FBp0fLHMHbS+/nG
         tPJTtOzmnErHWYsC7yCsAUxdnkIwyvJDCq2tPtgG4aEsyoNevVUF5LDSiR3NO78poY
         ry76Tm+3uD1Xw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qTdiS-00016I-1p;
        Wed, 09 Aug 2023 09:34:48 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] Revert "Revert "wifi: ath11k: Enable threaded NAPI""
Date:   Wed,  9 Aug 2023 09:34:32 +0200
Message-ID: <20230809073432.4193-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d265ebe41c911314bd273c218a37088835959fa1.

Disabling threaded NAPI causes the Lenovo ThinkPad X13s to hang (e.g. no
more interrupts received) almost immediately during RX.

Apparently something broke since commit 13aa2fb692d3 ("wifi: ath11k:
Enable threaded NAPI") so that a simple revert is no longer possible.

As commit d265ebe41c91 ("Revert "wifi: ath11k: Enable threaded NAPI"")
does not address the underlying issue reported with QCN9074, it seems we
need to reenable threaded NAPI before fixing both bugs properly.

Fixes: d265ebe41c91 ("Revert "wifi: ath11k: Enable threaded NAPI"")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

Hi Kalle,

Disabling threaded NAPI caused a severe regression in 6.5-rc5 by making
the X13s completely unusable (e.g. no keyboard input, I've seen an RCU
splat once).

I'm supposed to be on holiday this week, but thanks to the rain I gave
rc5 a try and ran into this.

I've added Bjorn, Mani and Konrad on CC who may be able to help with
debugging this further if needed while I'm out-of-office.

Johan


 drivers/net/wireless/ath/ath11k/ahb.c  | 1 +
 drivers/net/wireless/ath/ath11k/pcic.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 139da578831a..1cebba7889d7 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -376,6 +376,7 @@ static void ath11k_ahb_ext_irq_enable(struct ath11k_base *ab)
 		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
 
 		if (!irq_grp->napi_enabled) {
+			dev_set_threaded(&irq_grp->napi_ndev, true);
 			napi_enable(&irq_grp->napi);
 			irq_grp->napi_enabled = true;
 		}
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index c63083633b37..c899616fbee4 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -466,6 +466,7 @@ void ath11k_pcic_ext_irq_enable(struct ath11k_base *ab)
 		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
 
 		if (!irq_grp->napi_enabled) {
+			dev_set_threaded(&irq_grp->napi_ndev, true);
 			napi_enable(&irq_grp->napi);
 			irq_grp->napi_enabled = true;
 		}
-- 
2.41.0

