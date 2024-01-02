Return-Path: <linux-kernel+bounces-14586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78B9821F3F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98751C22355
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495381549B;
	Tue,  2 Jan 2024 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dTX8tc9m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344F214F92
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bbbd4d2b4aso4713286b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 08:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704211759; x=1704816559; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pfrYnQ2VeA7FSOetZv6xln9JGe69fYiqroiSkvqVflw=;
        b=dTX8tc9mUXN4KqgTOYrX0ismtLvtlOijgCkV23j9HsgDKYk1v/rIkjcEvlJA7KyCoR
         Gay1Boe9BAjdjUTY4CZDd1uAE7nAOisa/23bwFoXwqcILPOeST5KOivf/HldG6l39X9c
         xw59GO0pLV3CWx69OE2uL5fBTviPtHM1UhelU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704211759; x=1704816559;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfrYnQ2VeA7FSOetZv6xln9JGe69fYiqroiSkvqVflw=;
        b=N+5Sub7V99AilojR5Woyax3KuOy6WjhzubtYx712ntoMxv00vqZVGDBN3L09oOVITj
         cNvxU/Bw6LY15gwIr4UuCeLG2jLqQOXoMOPkpbP4fXAj5caxxn3W6zC7qlx5JfQspR8z
         kDLr0S61VyEFAdddl/lAb8Lqwk9WKpsQWMad6DXGyCJQhBUcr8JwCJI91ttdeknbEHXp
         kcpBoeZRWzOHI+ST4i7DeaH091YRuaBYa+u8mcUwQWY5AGiQarSPsMI7YtowfaMGz450
         DUZGoPHYqqkZNckxo6Is1YwUFaD+KXjSh047LN4d8rT3eZn8szOKAdbaYq3djREsSEyI
         jyXg==
X-Gm-Message-State: AOJu0Yx65eX9Rtiy2TTck74eij5MR9RbXMDrqCdqUcvCshhI29LAlnyB
	jYBuclVSU0S+axFM5+etRSqw32Oye87MPIz9e2IqZXwbv7v3
X-Google-Smtp-Source: AGHT+IHpK4las4p6fcezwyDMfYhjIjjihTHc9jKFT7LwTQvxL/ZP3CSOpHxfYAa9el7fUkW4VWhJ/w==
X-Received: by 2002:a05:6808:107:b0:3bb:c65c:2c58 with SMTP id b7-20020a056808010700b003bbc65c2c58mr9407756oie.101.1704211759300;
        Tue, 02 Jan 2024 08:09:19 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id hf8-20020a0562140e8800b0067f6f8c2a66sm10137520qvb.126.2024.01.02.08.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 08:09:18 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org,
	alcooperx@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	adrian.hunter@intel.com,
	linux-mmc@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: f.fainelli@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	Kamal Dasu <kdasu@broadcom.com>
Subject: [PATCH v7 2/2] mmc: add new sdhci reset sequence for brcm 74165b0
Date: Tue,  2 Jan 2024 11:09:10 -0500
Message-Id: <20240102160910.15485-3-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240102160910.15485-1-kamal.dasu@broadcom.com>
References: <20240102160910.15485-1-kamal.dasu@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008c7b00060df8b8d1"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--0000000000008c7b00060df8b8d1

From: Kamal Dasu <kdasu@broadcom.com>

74165b0 shall use a new sdio controller core version which
requires a different reset sequence. For core reset we use
sdhci_reset. For CMD and/or DATA reset added a new function
to also enable SDHCI clocks SDHCI_CLOCK_CARD_EN
SDHCI_CLOCK_INT_EN along with the SDHCI_RESET_CMD and/or
SDHCI_RESET_DATA fields.

Signed-off-by: Kamal Dasu <kdasu@broadcom.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 69 +++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index c23251bb95f3..9053526fa212 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/mmc/host.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -44,8 +45,13 @@ struct brcmstb_match_priv {
 
 static inline void enable_clock_gating(struct sdhci_host *host)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	u32 reg;
 
+	if (!(priv->flags & BRCMSTB_PRIV_FLAGS_GATE_CLOCK))
+		return;
+
 	reg = sdhci_readl(host, SDHCI_VENDOR);
 	reg |= SDHCI_VENDOR_GATE_SDCLK_EN;
 	sdhci_writel(host, reg, SDHCI_VENDOR);
@@ -53,14 +59,53 @@ static inline void enable_clock_gating(struct sdhci_host *host)
 
 static void brcmstb_reset(struct sdhci_host *host, u8 mask)
 {
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
-
 	sdhci_and_cqhci_reset(host, mask);
 
 	/* Reset will clear this, so re-enable it */
-	if (priv->flags & BRCMSTB_PRIV_FLAGS_GATE_CLOCK)
-		enable_clock_gating(host);
+	enable_clock_gating(host);
+}
+
+static void brcmstb_sdhci_reset_cmd_data(struct sdhci_host *host, u8 mask)
+{
+	u32 new_mask = (mask &  (SDHCI_RESET_CMD | SDHCI_RESET_DATA)) << 24;
+	int ret;
+	u32 reg;
+
+	/*
+	 * SDHCI_CLOCK_CONTROL register CARD_EN and CLOCK_INT_EN bits shall
+	 * be set along with SOFTWARE_RESET register RESET_CMD or RESET_DATA
+	 * bits, hence access SDHCI_CLOCK_CONTROL register as 32-bit register
+	 */
+	new_mask |= SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_INT_EN;
+	reg = sdhci_readl(host, SDHCI_CLOCK_CONTROL);
+	sdhci_writel(host, reg | new_mask, SDHCI_CLOCK_CONTROL);
+
+	reg = sdhci_readb(host, SDHCI_SOFTWARE_RESET);
+
+	ret = read_poll_timeout_atomic(sdhci_readb, reg, !(reg & mask),
+				       10, 10000, false,
+				       host, SDHCI_SOFTWARE_RESET);
+
+	if (ret) {
+		pr_err("%s: Reset 0x%x never completed.\n",
+		       mmc_hostname(host->mmc), (int)mask);
+		sdhci_err_stats_inc(host, CTRL_TIMEOUT);
+		sdhci_dumpregs(host);
+	}
+}
+
+static void brcmstb_reset_74165b0(struct sdhci_host *host, u8 mask)
+{
+	/* take care of RESET_ALL as usual */
+	if (mask & SDHCI_RESET_ALL)
+		sdhci_and_cqhci_reset(host, SDHCI_RESET_ALL);
+
+	/* cmd and/or data treated differently on this core */
+	if (mask & (SDHCI_RESET_CMD | SDHCI_RESET_DATA))
+		brcmstb_sdhci_reset_cmd_data(host, mask);
+
+	/* Reset will clear this, so re-enable it */
+	enable_clock_gating(host);
 }
 
 static void sdhci_brcmstb_hs400es(struct mmc_host *mmc, struct mmc_ios *ios)
@@ -162,6 +207,13 @@ static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
 	.set_uhs_signaling = sdhci_brcmstb_set_uhs_signaling,
 };
 
+static struct sdhci_ops sdhci_brcmstb_ops_74165b0 = {
+	.set_clock = sdhci_brcmstb_set_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = brcmstb_reset_74165b0,
+	.set_uhs_signaling = sdhci_brcmstb_set_uhs_signaling,
+};
+
 static struct brcmstb_match_priv match_priv_7425 = {
 	.flags = BRCMSTB_MATCH_FLAGS_NO_64BIT |
 	BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
@@ -179,10 +231,17 @@ static const struct brcmstb_match_priv match_priv_7216 = {
 	.ops = &sdhci_brcmstb_ops_7216,
 };
 
+static struct brcmstb_match_priv match_priv_74165b0 = {
+	.flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
+	.hs400es = sdhci_brcmstb_hs400es,
+	.ops = &sdhci_brcmstb_ops_74165b0,
+};
+
 static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
 	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
 	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
 	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
+	{ .compatible = "brcm,bcm74165b0-sdhci", .data = &match_priv_74165b0 },
 	{},
 };
 
-- 
2.17.1


--0000000000008c7b00060df8b8d1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DxuNuBlySpn/GYqPcDcRZd8EENWqnZrjtjHMk0j7ZfrPGXq8sQkbG3OX+DOwSaefPRq1pLGWBZaZ
YuUo5O7CNHo7h7Hc9GgjiW+6X9BjKAzSaDy8jwIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdrYW1hbC5kYXN1QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUcRYSWvAVyA3hgTrQ2c4AFquBsG0wDQYJ
KoZIhvcNAQELBQADggEBAIKB2IOweF2sIYGBZTDm+Hwmhga+sjekM167Sk/KwxxvQFwZYP6i0SnR
7aR59vbfVQVaAiZH/a+35EYxP/sXaIM4+E3bFykBuXwcGEnYyEn6MceiOCkjkWQq1Co2JyOdNvkP
nAxyPoWlsJtr+N/MF1EYKGpYMdPM7S2T/gujjO9N56BCGu9yJElszWcXHmBl5IsaQqMS36vhsV0b
NxffjNkeAdgfN/SS9S9Rj4WXD7pF1M0Xq8gPLCLyXrx1i2KkYOYJsj0PWlC6VRg6E1xXkYDte0VL
fAAG4QsETU27E1HBNQyp5zF1PoPCPvq3EnWQnbLgYk+Jz2iwIUwiqwr/bDgxggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgw89WX2Pp7ue922QVkwDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOOPXOoTzN/p4cFBKgQ1/YhDVbfR9yS8g86uY41O
7PepMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDEwMjE2MDkx
OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQAyOhP2aVeEtvUG/ANO3ke6RC1oX+/nRm7S2zvOxoqD/fVGBhe8s1bvd8tz
deoHsDQfdVp+pVShkUL5Ik2quLukbXYR+zn8iZXXk628Fyk3XUTXZn2SOhUj736NtQZb35DkPXJR
2AAUC33+tjJIAr6cJ7c/apMDNdxoqkU0kuDSClJnjX9ZfazeaKoZj+VGkDddmy6YnLilHH57EtRA
LxyTBPqVVaYxXaVajgx2hRyVfHRuXMvuHru4kxYj4JyICW46iC4x5qp10XWBZcRqKb05DqEcasks
N18vv+QKHwEne5iPG06tULqRa3UyAO1myXz6ZToOBLsg7KSF+uBGIjmI
--0000000000008c7b00060df8b8d1--

