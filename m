Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9570E76B8C0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjHAPi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjHAPiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:38:25 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1822136;
        Tue,  1 Aug 2023 08:37:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4RFf6P1n8sz9xGXQ;
        Tue,  1 Aug 2023 23:24:29 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.206.119])
        by APP1 (Coremail) with SMTP id LxC2BwA36biWJslk2IYdAA--.14146S4;
        Tue, 01 Aug 2023 16:37:34 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Ian Lin <ian.lin@infineon.com>,
        Wright Feng <wright.feng@cypress.com>,
        Hector Martin <marcan@marcan.st>,
        Prasanna Kerekoppa <prasanna.kerekoppa@cypress.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ramesh Rangavittal <ramesh.rangavittal@infineon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ryohei Kondo <ryohei.kondo@cypress.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Brian Henriquez <brian.henriquez@cypress.com>,
        linux-wireless@vger.kernel.org (open list:BROADCOM BRCM80211
        IEEE802.11n WIRELESS DRIVER),
        brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211
        IEEE802.11n WIRELESS DRIVER),
        SHA-cyfmac-dev-list@infineon.com (open list:BROADCOM BRCM80211
        IEEE802.11n WIRELESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Subject: [PATCH v1 2/3] wifi: brcm80211: separate abort scan param prepare from actual scan
Date:   Tue,  1 Aug 2023 17:36:41 +0200
Message-Id: <85a54ed5bd76a422165cc5ab532a680deb63ec93.1690904067.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690904067.git.petr.tesarik.ext@huawei.com>
References: <cover.1690904067.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwA36biWJslk2IYdAA--.14146S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCw47Jr48Cw13Gry7CF47XFb_yoW5tw4kpr
        1jvayj9a15Xr4q9wn8XFs7Jw1Yya97Xw1ag3y2yw1Y93Z8Gry8G3WDGFyagry5u392q34j
        9Fs0qFWUGr4xJrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2
        KfnxnUUI43ZEXa7VUURwZ5UUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

Use a dedicated helper to prepare parameters for a scan abort, rather than
special-casing a NULL argument to brcmf_escan_prep().

Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 49 ++++++++++---------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index de8a2e27f49c..3f4257fe76b3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1073,6 +1073,31 @@ static void brcmf_scan_params_v2_to_v1(struct brcmf_scan_params_v2_le *params_v2
 	       &params_v2_le->channel_list[0], params_size);
 }
 
+static void brcmf_escan_base_prep(struct brcmf_scan_params_v2_le *params_le)
+{
+	eth_broadcast_addr(params_le->bssid);
+
+	params_le->version = cpu_to_le16(BRCMF_SCAN_PARAMS_VERSION_V2);
+	params_le->bss_type = DOT11_BSSTYPE_ANY;
+	params_le->scan_type = cpu_to_le32(BRCMF_SCANTYPE_ACTIVE);
+	params_le->channel_num = 0;
+	params_le->nprobes = cpu_to_le32(-1);
+	params_le->active_time = cpu_to_le32(-1);
+	params_le->passive_time = cpu_to_le32(-1);
+	params_le->home_time = cpu_to_le32(-1);
+	memset(&params_le->ssid_le, 0, sizeof(params_le->ssid_le));
+}
+
+static void brcmf_escan_abort_prep(struct brcmf_scan_params_v2_le *params_le)
+{
+	int length = BRCMF_SCAN_PARAMS_V2_FIXED_SIZE + sizeof(u16);
+
+	brcmf_escan_base_prep(params_le);
+	params_le->channel_num = cpu_to_le32(1);
+	params_le->channel_list[0] = cpu_to_le16(-1);
+	params_le->length = cpu_to_le16(length);
+}
+
 static void brcmf_escan_prep(struct brcmf_cfg80211_info *cfg,
 			     struct brcmf_scan_params_v2_le *params_le,
 			     struct cfg80211_scan_request *request)
@@ -1086,29 +1111,9 @@ static void brcmf_escan_prep(struct brcmf_cfg80211_info *cfg,
 	int length;
 	struct brcmf_ssid_le ssid_le;
 
-	eth_broadcast_addr(params_le->bssid);
-
+	brcmf_escan_base_prep(params_le);
 	length = BRCMF_SCAN_PARAMS_V2_FIXED_SIZE;
 
-	params_le->version = cpu_to_le16(BRCMF_SCAN_PARAMS_VERSION_V2);
-	params_le->bss_type = DOT11_BSSTYPE_ANY;
-	params_le->scan_type = cpu_to_le32(BRCMF_SCANTYPE_ACTIVE);
-	params_le->channel_num = 0;
-	params_le->nprobes = cpu_to_le32(-1);
-	params_le->active_time = cpu_to_le32(-1);
-	params_le->passive_time = cpu_to_le32(-1);
-	params_le->home_time = cpu_to_le32(-1);
-	memset(&params_le->ssid_le, 0, sizeof(params_le->ssid_le));
-
-	/* Scan abort */
-	if (!request) {
-		length += sizeof(u16);
-		params_le->channel_num = cpu_to_le32(1);
-		params_le->channel_list[0] = cpu_to_le16(-1);
-		params_le->length = cpu_to_le16(length);
-		return;
-	}
-
 	n_ssids = request->n_ssids;
 	n_channels = request->n_channels;
 
@@ -1186,7 +1191,7 @@ s32 brcmf_notify_escan_complete(struct brcmf_cfg80211_info *cfg,
 		/* Do a scan abort to stop the driver's scan engine */
 		brcmf_dbg(SCAN, "ABORT scan in firmware\n");
 
-		brcmf_escan_prep(cfg, &params_v2_le, NULL);
+		brcmf_escan_abort_prep(&params_v2_le);
 
 		/* E-Scan (or anyother type) can be aborted by SCAN */
 		if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_SCAN_V2)) {
-- 
2.25.1

