Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0168E7E3506
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjKGGFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjKGGFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:05:54 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAD410F;
        Mon,  6 Nov 2023 22:05:50 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2F4D541A42;
        Tue,  7 Nov 2023 06:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1699337148; bh=xxiIjvDbAksu9Y0ctF1XaFpoIJj+/zvV5fHsF1bZhWE=;
        h=From:Date:Subject:To:Cc;
        b=CbqR6KMrHZj9VLynVWP+/xA9O8EBvwGhCoiLtoxy2Gtv6X3uY2SuPrdKhzVs5KEXP
         axj76Y5/95D36x2sUYdzp1uvsMDwx+dnuhjMYiz/yGdarzNoiykiw8Rp7Jl8o1vWYp
         sRtxRuR/5i/DqGOrQ0l/uda7z6FjIgdGf9Xgp5JOerQQPcO28LAMgO2iWeccSCCy0i
         myqPyGS1B5UNjkZ+o2HMeLXlo4igKykO2CQkKs6VFZJ2JWj3twQU3E4n9ox35AfqkH
         zyONO/Ja59+x+SN5KKjLd9+hBO0bIn3LwQyRaNyvtvVVvqqFQu/yWgr6SCWY+b/kmv
         SE4yY1UbiYb5Q==
From:   Hector Martin <marcan@marcan.st>
Date:   Tue, 07 Nov 2023 15:05:31 +0900
Subject: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
X-B4-Tracking: v=1; b=H4sIAKrTSWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQwNz3aSi5Ny03MRk3fKCRGNdy1TTNDOzVIukVGMTJaCegqLUtMwKsHn
 RsbW1AGedk2VfAAAA
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Daniel Berlin <dberlin@dberlin.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3904; i=marcan@marcan.st;
 h=from:subject:message-id; bh=xxiIjvDbAksu9Y0ctF1XaFpoIJj+/zvV5fHsF1bZhWE=;
 b=owGbwMvMwCUm+yP4NEe/cRLjabUkhlTPyztmvH8ycYLr6kUKfp8LOWw7r6s2+TX9ODqZ557ei
 a+HCtOlO0pZGMS4GGTFFFkaT/Se6vacfk5dNWU6zBxWJpAhDFycAjARpSCG/8GvbKvezs6a+urN
 0W/fHZctLo3OMovf6ZdReXnZtQXKt0UY/jsY6c+TjG31uZ8b/+1CVMlnbrl14YE7hR4FPJq6583
 jU8wA
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the WSEC command instead of sae_password seems to be the supported
mechanism on newer firmware, and also how the brcmdhd driver does it.

According to user reports [1], the sae_password codepath doesn't actually
work on machines with Cypress chips anyway, so no harm in removing it.

This makes WPA3 work with iwd, or with wpa_supplicant pending a support
patchset [2].

[1] https://rachelbythebay.com/w/2023/11/06/wpa3/
[2] http://lists.infradead.org/pipermail/hostap/2023-July/041653.html

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 46 +++++++++-------------
 .../broadcom/brcm80211/brcmfmac/fwil_types.h       |  2 +-
 2 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 2a90bb24ba77..138af70a33b8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1687,52 +1687,44 @@ static u16 brcmf_map_fw_linkdown_reason(const struct brcmf_event_msg *e)
 	return reason;
 }
 
-static int brcmf_set_pmk(struct brcmf_if *ifp, const u8 *pmk_data, u16 pmk_len)
+static int brcmf_set_wsec(struct brcmf_if *ifp, const u8 *key, u16 key_len, u16 flags)
 {
 	struct brcmf_pub *drvr = ifp->drvr;
 	struct brcmf_wsec_pmk_le pmk;
 	int err;
 
+	if (key_len > sizeof(pmk.key)) {
+		bphy_err(drvr, "key must be less than %zu bytes\n",
+			 sizeof(pmk.key));
+		return -EINVAL;
+	}
+
 	memset(&pmk, 0, sizeof(pmk));
 
-	/* pass pmk directly */
-	pmk.key_len = cpu_to_le16(pmk_len);
-	pmk.flags = cpu_to_le16(0);
-	memcpy(pmk.key, pmk_data, pmk_len);
+	/* pass key material directly */
+	pmk.key_len = cpu_to_le16(key_len);
+	pmk.flags = cpu_to_le16(flags);
+	memcpy(pmk.key, key, key_len);
 
-	/* store psk in firmware */
+	/* store key material in firmware */
 	err = brcmf_fil_cmd_data_set(ifp, BRCMF_C_SET_WSEC_PMK,
 				     &pmk, sizeof(pmk));
 	if (err < 0)
 		bphy_err(drvr, "failed to change PSK in firmware (len=%u)\n",
-			 pmk_len);
+			 key_len);
 
 	return err;
 }
 
+static int brcmf_set_pmk(struct brcmf_if *ifp, const u8 *pmk_data, u16 pmk_len)
+{
+	return brcmf_set_wsec(ifp, pmk_data, pmk_len, 0);
+}
+
 static int brcmf_set_sae_password(struct brcmf_if *ifp, const u8 *pwd_data,
 				  u16 pwd_len)
 {
-	struct brcmf_pub *drvr = ifp->drvr;
-	struct brcmf_wsec_sae_pwd_le sae_pwd;
-	int err;
-
-	if (pwd_len > BRCMF_WSEC_MAX_SAE_PASSWORD_LEN) {
-		bphy_err(drvr, "sae_password must be less than %d\n",
-			 BRCMF_WSEC_MAX_SAE_PASSWORD_LEN);
-		return -EINVAL;
-	}
-
-	sae_pwd.key_len = cpu_to_le16(pwd_len);
-	memcpy(sae_pwd.key, pwd_data, pwd_len);
-
-	err = brcmf_fil_iovar_data_set(ifp, "sae_password", &sae_pwd,
-				       sizeof(sae_pwd));
-	if (err < 0)
-		bphy_err(drvr, "failed to set SAE password in firmware (len=%u)\n",
-			 pwd_len);
-
-	return err;
+	return brcmf_set_wsec(ifp, pwd_data, pwd_len, BRCMF_WSEC_PASSPHRASE);
 }
 
 static void brcmf_link_down(struct brcmf_cfg80211_vif *vif, u16 reason,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
index 611d1a6aabb9..b68c46caabe8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
@@ -584,7 +584,7 @@ struct brcmf_wsec_key_le {
 struct brcmf_wsec_pmk_le {
 	__le16  key_len;
 	__le16  flags;
-	u8 key[2 * BRCMF_WSEC_MAX_PSK_LEN + 1];
+	u8 key[BRCMF_WSEC_MAX_SAE_PASSWORD_LEN];
 };
 
 /**

---
base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
change-id: 20231107-brcmfmac-wpa3-9e5f66e8be34

Best regards,
-- 
Hector Martin <marcan@marcan.st>

