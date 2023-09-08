Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CB2798CAC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbjIHSRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343731AbjIHSR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:17:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA8F211D;
        Fri,  8 Sep 2023 11:17:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AB7C4160E;
        Fri,  8 Sep 2023 18:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196857;
        bh=C/oZWkbGa1eucFDmpYfjnG4KHf6jX8KutakSwJRZLDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ciVSDDfWE2BV+DVuIv4VCiy+CIbtAFAHZl1HNxVx774/N251D5wMeVnWZhF+Au8CN
         x1c/aLdfNaauys2W0XYF8cioKWVnH/AzJ5LoI0ifIVjCUYy0EwEftcToc7jWy0UdTK
         LmmO+TPEMbkNJcnYyZDTJfMKQtpPpD3HJE/99wDvuFDinDxdbjWNYQJsvwJdtIB2X0
         6FI9sn1MgjigB0Hkzh4G2E4QAl+MSV7RbnRFLbgrI9lQx6YQh7K13Vi71erbVPwTE3
         ETrgtjwITwIutR68Fb9tsomn5EjuHzJF8ylDgllX1x/zc1iQnBr7TMo2VuZpbVHhqQ
         h3uodLzILPGxA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Gong <quic_wgong@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        quic_jjohnson@quicinc.com, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 17/45] wifi: ath12k: avoid array overflow of hw mode for preferred_hw_mode
Date:   Fri,  8 Sep 2023 14:12:58 -0400
Message-Id: <20230908181327.3459042-17-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181327.3459042-1-sashal@kernel.org>
References: <20230908181327.3459042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Gong <quic_wgong@quicinc.com>

[ Upstream commit 1e9b1363e2de1552ee4e3d74ac8bb43a194f1cb4 ]

Currently ath12k define WMI_HOST_HW_MODE_DBS_OR_SBS=5 as max hw mode
for enum wmi_host_hw_mode_config_type, it is also same for the array
ath12k_hw_mode_pri_map.

When tested with new version firmware/board data which support new
hw mode eMLSR mode with hw mode value 8, it leads overflow usage for
array ath12k_hw_mode_pri_map in function ath12k_wmi_hw_mode_caps(),
and then lead preferred_hw_mode changed to 8, and finally function
ath12k_pull_mac_phy_cap_svc_ready_ext() select the capability of hw
mode 8, but the capability of eMLSR mode report from firmware does
not support 2.4 GHz band for WCN7850, so finally 2.4 GHz band is
disabled.

Skip the hw mode which exceeds WMI_HOST_HW_MODE_MAX in function
ath12k_wmi_hw_mode_caps() helps to avoid array overflow, then the 2.4
GHz band will not be disabled.

This is to keep compatibility with newer version firmware/board data
files, this change is still needed after ath12k add eMLSR hw mode 8 in
array ath12k_hw_mode_pri_map and enum wmi_host_hw_mode_config_type,
because more hw mode maybe added in next firmware/board data version
e.g hw mode 9, then it will also lead new array overflow without this
change.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230714072405.28705-1-quic_wgong@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 4928e4e916603..4f378f06e946e 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -3704,6 +3704,10 @@ static int ath12k_wmi_hw_mode_caps(struct ath12k_base *soc,
 	for (i = 0 ; i < svc_rdy_ext->n_hw_mode_caps; i++) {
 		hw_mode_caps = &svc_rdy_ext->hw_mode_caps[i];
 		mode = le32_to_cpu(hw_mode_caps->hw_mode_id);
+
+		if (mode >= WMI_HOST_HW_MODE_MAX)
+			continue;
+
 		pref = soc->wmi_ab.preferred_hw_mode;
 
 		if (ath12k_hw_mode_pri_map[mode] < ath12k_hw_mode_pri_map[pref]) {
-- 
2.40.1

