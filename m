Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC5D7C7EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjJMHsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjJMHsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:48:00 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB5FF130;
        Fri, 13 Oct 2023 00:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=2FP/I
        2HYvAdTtXOXfAHhCpnshFB9PypJYAVg1wtwkRU=; b=YWvQlSrhLrGqgUFYLb9bj
        Dzv6ST3gElzGD9PRpj+6XgdJvz9Gl9TLaRTWJa7s7f8cS/ttCxJb9xJxKatgeQ7v
        pv/0Sg5DDrie8nwFklTgNDPbb9FsV+bWlKStqA91iNQ6j6eCGtYM98sMjEGHeZOg
        LMQQijj5ttImm9/za4suso=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g4-4 (Coremail) with SMTP id _____wDHb8cB9ihl+PW5AQ--.20384S4;
        Fri, 13 Oct 2023 15:47:25 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     kvalo@kernel.org, quic_jjohnson@quicinc.com
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] wifi: ath12k: drop NULL pointer check in ath12k_update_per_peer_tx_stats()
Date:   Fri, 13 Oct 2023 15:47:11 +0800
Message-Id: <20231013074711.2202850-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHb8cB9ihl+PW5AQ--.20384S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruF45Xr1kGrWkGw4DJF4kCrg_yoW3Krc_Ga
        12vF4xXFs3Gws8Kr47ZF42qrWqvasrJFZ5JF4qqrWfCrW7JrWUAr98Zw1kAryq93WDArna
        9wsrJF4UX39YgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMeHqJUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbivggIC1ZcjGu80wAAs3
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 'user_stats' is a fixed-size array of 'struct htt_ppdu_user_stats'
in 'struct htt_ppdu_stats', any of its member can't be NULL and so
relevant check may be dropped.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index e6e64d437c47..a38a239669a8 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1339,9 +1339,6 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 	u8 tid = HTT_PPDU_STATS_NON_QOS_TID;
 	bool is_ampdu = false;
 
-	if (!usr_stats)
-		return;
-
 	if (!(usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_RATE)))
 		return;
 
-- 
2.37.2

