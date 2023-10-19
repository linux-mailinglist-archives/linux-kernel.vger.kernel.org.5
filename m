Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0987F7CFDE8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346275AbjJSPc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345747AbjJSPc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:32:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD24312F;
        Thu, 19 Oct 2023 08:32:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6655CC433C8;
        Thu, 19 Oct 2023 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697729576;
        bh=JmxVPCdruKLMQZ5RUKgTCknlS6N8U4MPq35+pkolZUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=POBMJg19qSQ8erDJJsBUAf4QYH8J8D1C98PNUaEeDBax10sfUqooXE+3ZKs22bFFx
         Tg9fXsoNI6LSy/j0et+lzIy5ceQrs4BsPjQwjk6tD+nHsf2hGul/MyaheRNwH/wszt
         xHYnJlyz6oQmakAfMzDckwV0XWI316CcWj3YbngQAeHnep2LSdzgNys2eLGFEu5KNM
         HddIU7Bp2dEJECPMzwA191ONt1VSdxObTlvZ+T1OKmQWSXiA7A6TOvMFzR4bwLKq8l
         or2NE7fzpEJnHxWyFEMg+AOLSbqyFlZjJejvqN1n0klNmtRYMy+tSULs0BB/IKbE4I
         Zwz+s+1Czk0Aw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qtV1A-0006tC-0o;
        Thu, 19 Oct 2023 17:33:00 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v2 2/2] wifi: ath11k: fix dfs radar event locking
Date:   Thu, 19 Oct 2023 17:31:15 +0200
Message-ID: <20231019153115.26401-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019153115.26401-1-johan+linaro@kernel.org>
References: <20231019153115.26401-1-johan+linaro@kernel.org>
MIME-Version: 1.0
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

The ath11k active pdevs are protected by RCU but the DFS radar event
handling code calling ath11k_mac_get_ar_by_pdev_id() was not marked as a
read-side critical section.

Mark the code in question as an RCU read-side critical section to avoid
any potential use-after-free issues.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Cc: stable@vger.kernel.org      # 5.6
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index da1582b8dc30..f0eac6cb84fd 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8337,6 +8337,8 @@ ath11k_wmi_pdev_dfs_radar_detected_event(struct ath11k_base *ab, struct sk_buff
 		   ev->detector_id, ev->segment_id, ev->timestamp, ev->is_chirp,
 		   ev->freq_offset, ev->sidx);
 
+	rcu_read_lock();
+
 	ar = ath11k_mac_get_ar_by_pdev_id(ab, ev->pdev_id);
 
 	if (!ar) {
@@ -8354,6 +8356,8 @@ ath11k_wmi_pdev_dfs_radar_detected_event(struct ath11k_base *ab, struct sk_buff
 		ieee80211_radar_detected(ar->hw);
 
 exit:
+	rcu_read_unlock();
+
 	kfree(tb);
 }
 
-- 
2.41.0

