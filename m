Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDD380A65F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574094AbjLHO7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574090AbjLHO6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:58:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A0B2118
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:58:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D1B1C433C7;
        Fri,  8 Dec 2023 14:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047510;
        bh=z+uODMNdb+yL0ZZzyWs5UmEeiIVKC6u4wz42h2ik2a8=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=VwF0zPtxXQwsYpma2Yw0Mklf9CCRg98430fuCELiUfyB9ycExFgU6rf4trmogH67e
         8Y0JrXm/fzjtsFbMFal5QKu4hQw/fYXvlU6DdtZTXmxlOeSo400G8zTNQ3VAIbHYTZ
         tgmB6/dn6VkHEmOnMc3S/SJUL6paeAlR2zN2Uqu10WbInJuusDH1Aw0zAfUsC8De6D
         9Wc3KdCB7guCdJRnsQ4uMbQQ4PjS/gMFI14HyrgshdmLa6nCc/RxYTopIYcqhVyRNS
         /D88uq+kgmH2blBiUAKAMzbR+Rzvn7Baqcu/dMviZpnfZMuv9UFEvbzg3tYd5yHub2
         VTs7hd/ERBbhQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 49AEAC4167B;
        Fri,  8 Dec 2023 14:58:30 +0000 (UTC)
From:   Rodrigo Cataldo via B4 Relay 
        <devnull+rodrigo.cadore.l-acoustics.com@kernel.org>
Date:   Fri, 08 Dec 2023 15:58:16 +0100
Subject: [PATCH iwl-net] igc: Fix hicredit calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231208-igc-fix-hicredit-calc-v1-1-7e505fbe249d@l-acoustics.com>
X-B4-Tracking: v=1; b=H4sIAAcvc2UC/x2M0QpGQBQGX0Xn2qm1+pFXkYt1HHylpV2h5N1t/
 +XUzDwUNUAjtdlDQU9EbD5BkWcki/OzMsbEZI0tC2sqxiw84eYFEnTEweJWYWObYapL+RnXUGr
 3oEn6fzvCtbLXg/r3/QCLV9ZIcAAAAA==
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>,
        Mallikarjuna Chilakala <mallikarjuna.chilakala@intel.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>,
        Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657;
 i=rodrigo.cadore@l-acoustics.com; h=from:subject:message-id;
 bh=weMSbJurKkzqYl3uCO65fr+skPXlmh7FrZPzSvAd/0U=;
 b=owGbwMvMwCGWd67IourLsUDG02pJDKnF+qIb625IOjBMseo/ujNfr2h/wfewxacfxdQHmTE/a
 ZgwOde2o5SFQYyDQVZMkUX/N5/T6jIlI47EySth5rAygQxh4OIUgIk8+8XwPzTNNpGBL+zR5MKJ
 p5+Kz2J44/LG1P7HE1UO7Y16mb2/LRkZzta4mXeZPFXaEt0UcW9y+Ou8iaGeHh88FVJOc0ZK2TE
 zAQA=
X-Developer-Key: i=rodrigo.cadore@l-acoustics.com; a=openpgp;
 fpr=E0F4E67DE69A235AC356157D2DDD1455748BC38F
X-Endpoint-Received: by B4 Relay for rodrigo.cadore@l-acoustics.com/default with auth_id=109
X-Original-From: Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>
Reply-To: <rodrigo.cadore@l-acoustics.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>

According to the Intel Software Manual for I225, Section 7.5.2.7,
hicredit should be multiplied by the constant link-rate value, 0x7736.

Currently, the old constant link-rate value, 0x7735, from the boards
supported on igb are being used, most likely due to a copy'n'paste, as
the rest of the logic is the same for both drivers.

Update hicredit accordingly.

Fixes: 1ab011b0bf07 ("igc: Add support for CBS offloading")
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>
---
This is a simple fix for the credit calculation on igc devices
(i225/i226) to match the Intel software manual.

This is my first contribution to the Linux Kernel. Apologies for any
mistakes and let me know if I improve anything.
---
 drivers/net/ethernet/intel/igc/igc_tsn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index a9c08321aca9..22cefb1eeedf 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -227,7 +227,7 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 			wr32(IGC_TQAVCC(i), tqavcc);
 
 			wr32(IGC_TQAVHC(i),
-			     0x80000000 + ring->hicredit * 0x7735);
+			     0x80000000 + ring->hicredit * 0x7736);
 		} else {
 			/* Disable any CBS for the queue */
 			txqctl &= ~(IGC_TXQCTL_QAV_SEL_MASK);

---
base-commit: 2078a341f5f609d55667c2dc6337f90d8f322b8f
change-id: 20231206-igc-fix-hicredit-calc-028bf73c50a8

Best regards,
-- 
Rodrigo Cataldo <rodrigo.cadore@l-acoustics.com>

