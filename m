Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E601798D60
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344135AbjIHSV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344093AbjIHST4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:19:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB072D56;
        Fri,  8 Sep 2023 11:18:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283AFC433BB;
        Fri,  8 Sep 2023 18:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197050;
        bh=TT8QA3sHXmMs7mhUHh3fHuPlrwyc1j5L7ZAZXwAf6VM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aO/O1BYutDKTVWnFrXa5/BVc0Z9p9ev+T9r/Ms8MXzm/ZJMdfxscgyGKYS/g9dQeT
         lNtfCpbI/x7ek3vJuxm6opcvNy5hptVvKzetLXcfX99AUxZss1aY7/5LYIgM/YySBS
         +TtjsEKejwH81xxdgJF+2COaxFyVcGFjrlNRVcL/iO+w0+NRQIdq1RGgwNsuLTCcO2
         JlQ8FlYtxmgVfLt4cDE0qjtJ20ktR3hb/heBexTsCm1y097AuSvmDyZV2IFv/zr9Iz
         yNw8t/skSAXRJrZPmeJshB900ZIAu9kPwuiUfKJRqwfwuUfQtV5feftfHUTUPRibC5
         Xb1qBj/UnByVw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Gong <quic_wgong@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 38/41] wifi: ath12k: add check max message length while scanning with extraie
Date:   Fri,  8 Sep 2023 14:15:52 -0400
Message-Id: <20230908181555.3459640-38-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181555.3459640-1-sashal@kernel.org>
References: <20230908181555.3459640-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
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

[ Upstream commit 2f5124e86ae74b7ba24c9ae2644107b750cbf38f ]

Currently the extraie length is directly used to allocate skb buffer. When
the length of skb is greater than the max message length which firmware
supports, error will happen in firmware side.

Hence add check for the skb length and drop extraie when overflow and
print a message.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230809081657.13858-1-quic_wgong@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index cef01148fc163..6ae09779a68cc 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2163,12 +2163,6 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
 	if (arg->num_bssid)
 		len += sizeof(*bssid) * arg->num_bssid;
 
-	len += TLV_HDR_SIZE;
-	if (arg->extraie.len)
-		extraie_len_with_pad =
-			roundup(arg->extraie.len, sizeof(u32));
-	len += extraie_len_with_pad;
-
 	if (arg->num_hint_bssid)
 		len += TLV_HDR_SIZE +
 		       arg->num_hint_bssid * sizeof(*hint_bssid);
@@ -2177,6 +2171,18 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
 		len += TLV_HDR_SIZE +
 		       arg->num_hint_s_ssid * sizeof(*s_ssid);
 
+	len += TLV_HDR_SIZE;
+	if (arg->extraie.len)
+		extraie_len_with_pad =
+			roundup(arg->extraie.len, sizeof(u32));
+	if (extraie_len_with_pad <= (wmi->wmi_ab->max_msg_len[ar->pdev_idx] - len)) {
+		len += extraie_len_with_pad;
+	} else {
+		ath12k_warn(ar->ab, "discard large size %d bytes extraie for scan start\n",
+			    arg->extraie.len);
+		extraie_len_with_pad = 0;
+	}
+
 	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
 	if (!skb)
 		return -ENOMEM;
@@ -2266,7 +2272,7 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
 	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE, len);
 	ptr += TLV_HDR_SIZE;
 
-	if (arg->extraie.len)
+	if (extraie_len_with_pad)
 		memcpy(ptr, arg->extraie.ptr,
 		       arg->extraie.len);
 
-- 
2.40.1

