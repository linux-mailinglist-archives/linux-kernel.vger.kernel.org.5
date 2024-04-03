Return-Path: <linux-kernel+bounces-130645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D99AA897AE7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E801C2685B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A924156C4A;
	Wed,  3 Apr 2024 21:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y4a4Hn9k"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4341215696E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180355; cv=none; b=P+m2GKnt9qEGCwRzPQor3jD2A7mzB8ChrgKVW51sRbYDtMyqlT5sfOP/DnuynE85eItGnoYkHt1ZWd/PLMDqUNHK3zj2J0uFRH1FlkGz6Lb08gEsXjzgcVKV6HjX8vTTVlBMQ7Q/3h5nrBiq//6CiP+f3PaPuxv4qtpMLg9s6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180355; c=relaxed/simple;
	bh=4UwFQNYN7BZLHjTsOXtbVMsDeIi36ovhO4scIR9gxUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type; b=Owt9/u2+GlrQmZBHihv6AWpp2Hmt2VAKV7Sapl9bX/VLhxmD5MiU0hfa05y3YEQ5EvHkJRTZzvHXwxPORv9ivoXo7hIJto7SyWPVCpXaAryuJGMivAWsd+FLOeMHoqWvgRhyfT7wikTCqY/9970mUmJaCS3ibdt4VNljdmklLnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y4a4Hn9k; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4d43c633fecso128488e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 14:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712180352; x=1712785152; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rDbyCQtbln0sG+qV5ZXLpkyf8lyFL0hVrX8b8z/7vQQ=;
        b=Y4a4Hn9k2PORa3fJEIhMqbAzEy40dXSR40nR6hvUVNg+BlZYiJQDWSrkBsmC4gjYE1
         55HcajTRDboc+/+aHTGispKn58mp/1q6WA0vmP0pKsFQh6f8jM/6/T0gCltKku88GXAC
         Ov9HiGK+d4Ht/+riK7c40lKOnivjTanSZttmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712180352; x=1712785152;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDbyCQtbln0sG+qV5ZXLpkyf8lyFL0hVrX8b8z/7vQQ=;
        b=Zw9VLiIEK71/KMCMgw9wES48aMy1YY/BiDSanoeUI3Q1mV87zDaYaoZq9lZw2BfdBV
         qgl/yIiJM64suLapX6sOvY6HoJ//SMaFqynKEahyaf0vX13hUkmELhNpWCJVOlh0C3v9
         4vhvBBMls5QCZu2FZE9Auy53A/NmOgdkqPAETI6fnVoc0uUWk3JmSQR4ikHi3VLne39U
         Tw/g1QepNTOL3mrONCTfCEP8HpOYaQo+cajGltrzCOZ2kdumqBAfcBLlrP/km5q/iNwU
         zAKt/EAeMjO5jBMktHuTSAQWUuU79voOwRRofDPIIQyCfxyX/wqrWm9TwUttjWYExQ+B
         BizQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMadQEG3uWQDF4T2g4JeMbKCGyYxLlDOv9HXwBhpCPPv1kzu7rMZjILoeKWorJaCOBD4f1s+ui2j/AyDjsb+IO7xOsDyLu43hDdvMk
X-Gm-Message-State: AOJu0Yzl9Urk9JwqMYe0tBz5CAqiErK9XKKoJhoOhgLdbYF87vh1Hvj1
	KyHx4FCG3goN7fRSgD2YttHRmJlFNSMOq1nn1EXGW10pwHxbsaGp7Qw8jVvr+w==
X-Google-Smtp-Source: AGHT+IErr7Hms47uq2WTpFuYryFwuFomKLlaAAOJj253kxVtX/49vIxPIfd0y1MFwlJjtp1XR8ctqw==
X-Received: by 2002:a05:6122:a24:b0:4ca:615e:1b61 with SMTP id 36-20020a0561220a2400b004ca615e1b61mr651230vkn.10.1712180352188;
        Wed, 03 Apr 2024 14:39:12 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id pi10-20020a0562144a8a00b0069903cddc96sm1750739qvb.18.2024.04.03.14.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 14:39:11 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Phil Elwell <phil@raspberrypi.com>,
	bcm-kernel-feedback-list@broadcom.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 3/4] PCI: brcmstb: Set downstream maximum {no-}snoop LTR values
Date: Wed,  3 Apr 2024 17:39:00 -0400
Message-Id: <20240403213902.26391-4-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240403213902.26391-1-james.quinlan@broadcom.com>
References: <20240403213902.26391-1-james.quinlan@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b337e60615380d57"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--000000000000b337e60615380d57

Most of our systems do not have FW or ACPI, so it is up to the RC driver to
set the maximum LTR {no-}snoop latency values of downstream devices.  We
set them to a value that is slightly smaller than the value of our internal
bus timeout register.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 68 ++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e3480ca4cd57..3d08b92d5bb8 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -182,6 +182,20 @@
 #define DATA_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_DATA])
 #define PCIE_RGR1_SW_INIT_1(pcie)	(pcie->reg_offsets[RGR1_SW_INIT_1])
 
+/*
+ * What we call "LTR_FMT" is the 16 bit latency field format:
+ *     [15:15] Requirement bit
+ *     [12:10] Latency scale
+ *     [09:00] Latency value
+ */
+#define LTR_FMT_TO_NS(p)		(FIELD_GET(GENMASK(15, 15), (p)) \
+					 * ((unsigned long long)FIELD_GET(GENMASK(9, 0), (p)) \
+					    << (FIELD_GET(GENMASK(12, 10), (p)) * 5)))
+#define BRCM_LTR_MAX_SCALE		4 /* Scale==4 => Each unit is 1,048,576ns  */
+#define BRCM_LTR_MAX_VALUE		9 /* Using the above scale, roughly 9.4 ms */
+#define BRCM_LTR_MAX_NS			((unsigned long long)(BRCM_LTR_MAX_VALUE \
+					 << (5 * BRCM_LTR_MAX_SCALE)))
+
 /* Rescal registers */
 #define PCIE_DVT_PMU_PCIE_PHY_CTRL				0xc700
 #define  PCIE_DVT_PMU_PCIE_PHY_CTRL_DAST_NFLDS			0x3
@@ -679,6 +693,49 @@ static void brcm_extend_internal_bus_timeout(struct brcm_pcie *pcie, u32 nsec)
 	writel(216 * timeout_us, pcie->base + REG_OFFSET);
 }
 
+/* Sets downstream device latency tolerance registers to max we can handle */
+static int brcm_set_dev_ltr_max(struct pci_dev *dev, void *data)
+{
+	u16 ltr_cap_offset = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
+	u16 ltr_fmt_cur, ltr_fmt = *(u16 *)data;
+	unsigned long long cur_nsec;
+	static const u16 reg_offsets[2] = {
+		PCI_LTR_MAX_SNOOP_LAT,
+		PCI_LTR_MAX_NOSNOOP_LAT,
+	};
+	unsigned int i;
+
+	if (!ltr_cap_offset || !dev->ltr_path)
+		return 0;
+
+	/*
+	 * FW may have already written a value so we want to respect that
+	 * value if it is lower than ltr_fmt.  Update the current value if
+	 * it is 0 or if the new value is less than the current.
+	 */
+	for (i = 0; i < ARRAY_SIZE(reg_offsets); i++) {
+		pci_read_config_word(dev, ltr_cap_offset + reg_offsets[i],
+			&ltr_fmt_cur);
+		cur_nsec = LTR_FMT_TO_NS(ltr_fmt_cur);
+		if (cur_nsec == 0 || cur_nsec > BRCM_LTR_MAX_NS)
+			pci_write_config_word(dev, ltr_cap_offset
+					      + reg_offsets[i], ltr_fmt);
+	}
+
+	return 0;
+}
+
+void brcm_set_downstream_devs_ltr_max(struct brcm_pcie *pcie)
+{
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	u16 ltr_fmt = FIELD_PREP(GENMASK(9, 0), BRCM_LTR_MAX_VALUE)
+		| FIELD_PREP(GENMASK(12, 10), BRCM_LTR_MAX_SCALE)
+		| GENMASK(15, 15);
+
+	if (bridge->native_ltr)
+		pci_walk_bus(bridge->bus, brcm_set_dev_ltr_max, &ltr_fmt);
+}
+
 /* The controller is capable of serving in both RC and EP roles */
 static bool brcm_pcie_rc_mode(struct brcm_pcie *pcie)
 {
@@ -1074,8 +1131,12 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 		return -ENODEV;
 	}
 
-	/* Extend internal bus timeout to 8ms or so */
-	brcm_extend_internal_bus_timeout(pcie, SZ_8M);
+	/*
+	 * Extend internal bus timeout to 8-10ms, specifically to a value
+	 * that is slightly larger than what we are using for the max
+	 * {no-}snoop latency we will set in downstream devices.
+	 */
+	brcm_extend_internal_bus_timeout(pcie, BRCM_LTR_MAX_NS + 1000);
 
 	if (pcie->gen)
 		brcm_pcie_set_gen(pcie, pcie->gen);
@@ -1616,6 +1677,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (IS_ENABLED(CONFIG_PCIEASPM))
+		brcm_set_downstream_devs_ltr_max(pcie);
+
 	return 0;
 
 fail:
-- 
2.17.1


--000000000000b337e60615380d57
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCkg7iIQUuVDJNfabd+L2TlIwyTbBmA
r8iDIVRueaDykjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDA0
MDMyMTM5MTJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAmHJopDKz7XR/6LUtL5dD5xYt8kqL0YnCuPeONl+qPrLcEyKT
fqTSTwxGNjHGgW+Q5dpwOIjx1wvCjKBl5NwnEioSTq0F6HD1lRRXjqI1oTZJYDsuvdFawVKh9Mpi
z8/IEKnM4V3GMW8uqxhCdXn8ln5UjTPiNoT0+WJQ0W9QKI/y0SurzPXf1RvsGi2rMrPnVEhYg5p3
3UAMfJnqT0pP+GQQ4RQooqoegDmfrYshRnBbGcWOkGwNDH2KulXpBlNCR9e7eKA7if9XIC13Q7vl
vu/0Y0up1cdpSKJp3ETDSahqRZ92nPhRjIRzJmOd6fJlv3ra6rgeifUyml5B1YlwMQ==
--000000000000b337e60615380d57--

