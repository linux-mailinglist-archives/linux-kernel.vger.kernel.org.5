Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB3B783F70
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbjHVLhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbjHVLhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:37:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47666CE5;
        Tue, 22 Aug 2023 04:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 971EA63A54;
        Tue, 22 Aug 2023 11:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE3BC433CB;
        Tue, 22 Aug 2023 11:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692704172;
        bh=m1o0jXed7BnewlHKG+1vCqtrmwRS0IPm7ZfcZTswWms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrdYlZZaWqM3fQQ0NJZafwAu1OL695GbZndRx3hQf5zRk7iEndCWn4NvUZNMeiyxB
         pv7g/X3WcItoae5jC4aG1ydhvIm4MHngcMdkbYNei/4rydcfm01ef2uPpTWKBWI/b7
         jtsV2C/WsPOBDvE/vRooAtVx3WfBIjTewkF6Q/ENDXipbzdcwiXHMoZGX5X6gGOiuS
         kEbdKGW1PhUN4X6iEwDujtXmH0EA488QHaoreoVM4chme3YuAatq1rtn4I6XK6bl5K
         O7n+oCm/S32gLduTZ2o9O9w9/mL5hwh91MWehm0EvbbUN647voxBgJIgXy+sPqVX2F
         Ypjx9gBGtnWRg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Gong <quic_wgong@quicinc.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        quic_jjohnson@quicinc.com, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 06/11] wifi: ath12k: Fix buffer overflow when scanning with extraie
Date:   Tue, 22 Aug 2023 07:35:48 -0400
Message-Id: <20230822113553.3551206-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822113553.3551206-1-sashal@kernel.org>
References: <20230822113553.3551206-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.11
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Gong <quic_wgong@quicinc.com>

[ Upstream commit 06f2ab86a5b6ed55f013258de4be9319841853ea ]

If cfg80211 is providing extraie's for a scanning process then ath12k will
copy that over to the firmware. The extraie.len is a 32 bit value in struct
element_info and describes the amount of bytes for the vendor information
elements.

The problem is the allocation of the buffer. It has to align the TLV
sections by 4 bytes. But the code was using an u8 to store the newly
calculated length of this section (with alignment). And the new
calculated length was then used to allocate the skbuff. But the actual
code to copy in the data is using the extraie.len and not the calculated
"aligned" length.

The length of extraie with IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS enabled
was 264 bytes during tests with a wifi card. But it only allocated 8
bytes (264 bytes % 256) for it. As consequence, the code to memcpy the
extraie into the skb was then just overwriting data after skb->end. Things
like shinfo were therefore corrupted. This could usually be seen by a crash
in skb_zcopy_clear which tried to call a ubuf_info callback (using a bogus
address).

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Link: https://lore.kernel.org/r/20230809081241.32765-1-quic_wgong@quicinc.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 7ae0bb78b2b53..1e65e35b5f3a6 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2144,8 +2144,7 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
 	struct wmi_tlv *tlv;
 	void *ptr;
 	int i, ret, len;
-	u32 *tmp_ptr;
-	u8 extraie_len_with_pad = 0;
+	u32 *tmp_ptr, extraie_len_with_pad = 0;
 	struct ath12k_wmi_hint_short_ssid_arg *s_ssid = NULL;
 	struct ath12k_wmi_hint_bssid_arg *hint_bssid = NULL;
 
-- 
2.40.1

