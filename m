Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC977C4BDA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344747AbjJKHbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344920AbjJKHbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:31:05 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC4488F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=oKT7F
        qr44z78BErwG1vOizQzA/RhFHh09oOs0OyNp08=; b=aXnQVSsaw93utufBkzr1M
        Hyn0NnwefoZ3+8T9guNbobt5Kgddq1o08BJnN/I2EuqUqzR/uIc7QEsodz6I5rtU
        eMyhhMiH0kpOg922+BHNb1DUEbiNeh08t/XPaxp8k1yDLG9mhLwtes1njY3x+WBw
        lVLgSaSh1IPm6RVKO+A0JI=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g5-4 (Coremail) with SMTP id _____wDnbyTwTiZlYUr8AA--.36070S4;
        Wed, 11 Oct 2023 15:30:00 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     kvalo@kernel.org, quic_jjohnson@quicinc.com
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] wifi: ath12k: call ath12k_mac_fils_discovery() without condition
Date:   Wed, 11 Oct 2023 15:29:50 +0800
Message-Id: <20231011072950.4097927-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnbyTwTiZlYUr8AA--.36070S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Xr17tFykGFyUWrW5ur4UArb_yoW8JrW3pF
        47uF1DtF18CFn3JayUtF4xJF4rJ3Z8JrWxKF17Ja4rXFZ0yF1fKFy5Kay2kry8JFnFyF1Y
        9w48tr43uFn8uFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_MKZDUUUUU=
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFQIGC2B9od1edgAAsT
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

Mac80211 does not set flags BSS_CHANGED_FILS_DISCOVERY and
BSS_CHANGED_UNSOL_BCAST_PROBE_RESP if there are no updates to
FILS discovery and unsolicited broadcast probe response transmission
configurations respectively. This results in the transmissions getting
stopped during BSS change operations which do not include these
attributes. Remove the checks for the flags and always send the existing
configuration to firmware.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88346e66bb75..94967f810093 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -2761,9 +2761,7 @@ static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 		}
 	}
 
-	if (changed & BSS_CHANGED_FILS_DISCOVERY ||
-	    changed & BSS_CHANGED_UNSOL_BCAST_PROBE_RESP)
-		ath12k_mac_fils_discovery(arvif, info);
+	ath12k_mac_fils_discovery(arvif, info);
 
 	if (changed & BSS_CHANGED_EHT_PUNCTURING)
 		arvif->punct_bitmap = info->eht_puncturing;
-- 
2.37.2

