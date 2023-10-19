Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2567CFEBD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346182AbjJSPyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjJSPx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:53:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E9C93;
        Thu, 19 Oct 2023 08:53:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B09C433C8;
        Thu, 19 Oct 2023 15:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697730836;
        bh=wa4WXUdBJDSprT0pug2ujhG4LLF9gr+xArqonoxADzw=;
        h=From:To:Cc:Subject:Date:From;
        b=sXKWpTylvlESxh+A9Ob0R/6Ik+gMuidD6esDgwByGAV8s6TPXDJolqJ8+l+mEAHYh
         d1M59feYyobvivShElD7sHFA1952PL4IhTuygo2gVnCTiM2/+aOmL/VMxuVNXQlC4B
         Pkvr7U9z4QIB8r2Jy2rKHXVbYa09DwZn3Xd8/Aeg4Ou4eBbaFlpGA3Be3uOG7gU4aZ
         WtR6mxZnlEKNWalKmfIDIYPn/XQKlFxyTwnjR2f24gw0BqI3BQbR4AIdNxYFE0gNg4
         RyNzKWp8mWJSCHYMNKmjQcGRBOQ8FnAi+LDtskbRn2XKQ/Ygc/VHfWOZL9VNFS+mPd
         ljpK+AzNp49rg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qtVLT-0008Eg-2K;
        Thu, 19 Oct 2023 17:53:59 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org,
        Carl Huang <quic_cjhuang@quicinc.com>
Subject: [PATCH] wifi: ath11k: fix gtk offload status event locking
Date:   Thu, 19 Oct 2023 17:53:42 +0200
Message-ID: <20231019155342.31631-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
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

The ath11k active pdevs are protected by RCU but the gtk offload status
event handling code calling ath11k_mac_get_arvif_by_vdev_id() was not
marked as a read-side critical section.

Mark the code in question as an RCU read-side critical section to avoid
any potential use-after-free issues.

Fixes: a16d9b50cfba ("ath11k: support GTK rekey offload")
Cc: stable@vger.kernel.org      # 5.18
Cc: Carl Huang <quic_cjhuang@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

...and here's one more, this time using the
ath11k_mac_get_arvif_by_vdev_id() helper.

Johan


 drivers/net/wireless/ath/ath11k/wmi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index f0eac6cb84fd..78af659b1ccd 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -8618,12 +8618,13 @@ static void ath11k_wmi_gtk_offload_status_event(struct ath11k_base *ab,
 		return;
 	}
 
+	rcu_read_lock();
+
 	arvif = ath11k_mac_get_arvif_by_vdev_id(ab, ev->vdev_id);
 	if (!arvif) {
 		ath11k_warn(ab, "failed to get arvif for vdev_id:%d\n",
 			    ev->vdev_id);
-		kfree(tb);
-		return;
+		goto exit;
 	}
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI, "event gtk offload refresh_cnt %d\n",
@@ -8640,6 +8641,8 @@ static void ath11k_wmi_gtk_offload_status_event(struct ath11k_base *ab,
 
 	ieee80211_gtk_rekey_notify(arvif->vif, arvif->bssid,
 				   (void *)&replay_ctr_be, GFP_ATOMIC);
+exit:
+	rcu_read_unlock();
 
 	kfree(tb);
 }
-- 
2.41.0

