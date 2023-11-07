Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F0D7E3C0E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjKGMMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbjKGML3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:11:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE432D5F;
        Tue,  7 Nov 2023 04:09:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499DAC433C8;
        Tue,  7 Nov 2023 12:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699358984;
        bh=ED9jN/0/Mt6n022JLzSXrZj1RIbYmo+/SGoE/4zE9iQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SrP8q0hh17h6cu4nOtPIDcPyr8Q32aNYioCwI3FDxEKIrrQ27Ps3Pg/nBh1p+dS+j
         D6KF3i7iqNmS+J7VMYmTWpucvNYUz8LyMFTBUpGyAwadXWrY+0rp4BjdV9qGFzOLPY
         ff3fga1KsGKzapn/NscdmmKVsMGxQk8r7fANqepZe217GDDcVj5nQCwJ/LEMV/CuZ2
         RBafO/9hgbJtxpuHwNchuYq47+yd96clqTFvPsPvjmDUoNgR0f1xLh7Qgon2VzsB+m
         fV2N+2Knn0Q91OFvIqoLsOTNaxrqmoZ1A1a57XmssIkbd4ygzq/k4/TGdPyi9XTlCM
         6lPvpxsXpw27A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Baochen Qiang <quic_bqiang@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 10/30] wifi: ath12k: fix possible out-of-bound write in ath12k_wmi_ext_hal_reg_caps()
Date:   Tue,  7 Nov 2023 07:08:25 -0500
Message-ID: <20231107120922.3757126-10-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120922.3757126-1-sashal@kernel.org>
References: <20231107120922.3757126-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
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

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit b302dce3d9edea5b93d1902a541684a967f3c63c ]

reg_cap.phy_id is extracted from WMI event and could be an unexpected value
in case some errors happen. As a result out-of-bound write may occur to
soc->hal_reg_cap. Fix it by validating reg_cap.phy_id before using it.

This is found during code review.

Compile tested only.

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230830020716.5420-1-quic_bqiang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index eebc5a65ce3b4..416b22fa53ebf 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -3799,6 +3799,12 @@ static int ath12k_wmi_ext_hal_reg_caps(struct ath12k_base *soc,
 			ath12k_warn(soc, "failed to extract reg cap %d\n", i);
 			return ret;
 		}
+
+		if (reg_cap.phy_id >= MAX_RADIOS) {
+			ath12k_warn(soc, "unexpected phy id %u\n", reg_cap.phy_id);
+			return -EINVAL;
+		}
+
 		soc->hal_reg_cap[reg_cap.phy_id] = reg_cap;
 	}
 	return 0;
-- 
2.42.0

