Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51DB7E3B93
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjKGMHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbjKGMH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:07:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E645418D;
        Tue,  7 Nov 2023 04:07:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E18C433C7;
        Tue,  7 Nov 2023 12:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699358843;
        bh=01j6EKsgCax7l7Fd8OSsdrmplpwNAU3rMOg92D5wsp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jmR0CEXlCuh99CrQfAqHccjtlQGB4j+qy8j6A6JYwHCwl1Us3aVXqPxIO1zGwXdX3
         AagIPCzqYpezXhzeujYpUcjSLS7o6L6ur+F1tshJdTHeS3Rm63aLeZm7e8YodAbU9K
         W5YYRYU/IGfX0dwHbsxHqI/NzbaZ5lB8HgSrDLzJQdyh4PcBmlxFlZGE108inHYBUg
         xmx0CYpGRbR1HkVXAcJTsXdfBRX7nzdypLZAknFwPKeIV1z2h9HlTi/mZ5hLFUCyLk
         5SWMjBBL+wp20D4h+pCL1e3uBcHp52kZxH3YBJDESfAxlR6JPN4lOMKNmE3st3aYT4
         1vv/p8s7GJG5Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Baochen Qiang <quic_bqiang@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/31] wifi: ath12k: fix possible out-of-bound read in ath12k_htt_pull_ppdu_stats()
Date:   Tue,  7 Nov 2023 07:05:55 -0500
Message-ID: <20231107120704.3756327-8-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120704.3756327-1-sashal@kernel.org>
References: <20231107120704.3756327-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
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

[ Upstream commit 1bc44a505a229bb1dd4957e11aa594edeea3690e ]

len is extracted from HTT message and could be an unexpected value in
case errors happen, so add validation before using to avoid possible
out-of-bound read in the following message iteration and parsing.

The same issue also applies to ppdu_info->ppdu_stats.common.num_users,
so validate it before using too.

These are found during code review.

Compile test only.

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230901015602.45112-1-quic_bqiang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 100390fdc735f..42f9cfede12bf 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1555,6 +1555,13 @@ static int ath12k_htt_pull_ppdu_stats(struct ath12k_base *ab,
 
 	msg = (struct ath12k_htt_ppdu_stats_msg *)skb->data;
 	len = le32_get_bits(msg->info, HTT_T2H_PPDU_STATS_INFO_PAYLOAD_SIZE);
+	if (len > (skb->len - struct_size(msg, data, 0))) {
+		ath12k_warn(ab,
+			    "HTT PPDU STATS event has unexpected payload size %u, should be smaller than %u\n",
+			    len, skb->len);
+		return -EINVAL;
+	}
+
 	pdev_id = le32_get_bits(msg->info, HTT_T2H_PPDU_STATS_INFO_PDEV_ID);
 	ppdu_id = le32_to_cpu(msg->ppdu_id);
 
@@ -1583,6 +1590,16 @@ static int ath12k_htt_pull_ppdu_stats(struct ath12k_base *ab,
 		goto exit;
 	}
 
+	if (ppdu_info->ppdu_stats.common.num_users >= HTT_PPDU_STATS_MAX_USERS) {
+		spin_unlock_bh(&ar->data_lock);
+		ath12k_warn(ab,
+			    "HTT PPDU STATS event has unexpected num_users %u, should be smaller than %u\n",
+			    ppdu_info->ppdu_stats.common.num_users,
+			    HTT_PPDU_STATS_MAX_USERS);
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	/* back up data rate tlv for all peers */
 	if (ppdu_info->frame_type == HTT_STATS_PPDU_FTYPE_DATA &&
 	    (ppdu_info->tlv_bitmap & (1 << HTT_PPDU_STATS_TAG_USR_COMMON)) &&
-- 
2.42.0

