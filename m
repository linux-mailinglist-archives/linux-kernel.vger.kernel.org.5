Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FD97CFDEC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346304AbjJSPdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345965AbjJSPc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:32:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9465132;
        Thu, 19 Oct 2023 08:32:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F38EC433C7;
        Thu, 19 Oct 2023 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697729576;
        bh=ybnrjlLviCjSD8GSKMljRyMDeDtfP4Uw7YCw85cfwvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPXJJ494N+eQZDwnrF5/v4p3ljxHkhrb79+NS63aMaP8W7GUKRqOqEEWUV/LreBag
         HTxotFRSHtLz/rFWarbLOJNw1T2cWLMnZdVQ335Hp2fEyrar9dvQO05e82mbwu5yKq
         DTjzRvqhCmIJWpe1BO4BmxWi5s8ogvv3+H5rjW/jO53qoFb6ZaVbwdMcZz7Z/p8Rws
         UQzf2yGkDD8Me+A2p5mgUwCArQEExqPnb85OvdAndNgu2aZjBRI1AvVW4JCOqHNYFq
         iUOofKwV48HRgk75KinzjO9cPqCR5y7YtmJ3e191nYLXKnfqUq/IwCffYcSxO7pzTy
         brbnGVQpzxGug==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qtV1A-0006tA-0W;
        Thu, 19 Oct 2023 17:33:00 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v2 1/2] wifi: ath11k: fix temperature event locking
Date:   Thu, 19 Oct 2023 17:31:14 +0200
Message-ID: <20231019153115.26401-2-johan+linaro@kernel.org>
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

The ath11k active pdevs are protected by RCU but the temperature event
handling code calling ath11k_mac_get_ar_by_pdev_id() was not marked as a
read-side critical section as reported by RCU lockdep:

	=============================
	WARNING: suspicious RCU usage
	6.6.0-rc6 #7 Not tainted
	-----------------------------
	drivers/net/wireless/ath/ath11k/mac.c:638 suspicious rcu_dereference_check() usage!

	other info that might help us debug this:

	rcu_scheduler_active = 2, debug_locks = 1
	no locks held by swapper/0/0.
	...
	Call trace:
	...
	 lockdep_rcu_suspicious+0x16c/0x22c
	 ath11k_mac_get_ar_by_pdev_id+0x194/0x1b0 [ath11k]
	 ath11k_wmi_tlv_op_rx+0xa84/0x2c1c [ath11k]
	 ath11k_htc_rx_completion_handler+0x388/0x510 [ath11k]

Mark the code in question as an RCU read-side critical section to avoid
any potential use-after-free issues.

Fixes: a41d10348b01 ("ath11k: add thermal sensor device support")
Cc: stable@vger.kernel.org      # 5.7
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 23ad6825e5be..da1582b8dc30 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8383,14 +8383,17 @@ ath11k_wmi_pdev_temperature_event(struct ath11k_base *ab,
 	ath11k_dbg(ab, ATH11K_DBG_WMI, "event pdev temperature ev temp %d pdev_id %d\n",
 		   ev->temp, ev->pdev_id);
 
+	rcu_read_lock();
+
 	ar = ath11k_mac_get_ar_by_pdev_id(ab, ev->pdev_id);
 	if (!ar) {
 		ath11k_warn(ab, "invalid pdev id in pdev temperature ev %d", ev->pdev_id);
-		kfree(tb);
-		return;
+		goto exit;
 	}
 
 	ath11k_thermal_event_temperature(ar, ev->temp);
+exit:
+	rcu_read_unlock();
 
 	kfree(tb);
 }
-- 
2.41.0

