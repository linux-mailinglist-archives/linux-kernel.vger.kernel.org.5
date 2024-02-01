Return-Path: <linux-kernel+bounces-48727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE771846058
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DB528517D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454CD85281;
	Thu,  1 Feb 2024 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ware3b3W"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030A45A4E0;
	Thu,  1 Feb 2024 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813360; cv=none; b=qKBf/i4oQv3GRqmziUDvf1qY3hdNl84wloVPEDTYsNOndjzJfPxt5RkRfOvs1dsjbvF0jLJSXjZtbGq1NYuBCeGxnw/D4610YA/eZn+jq+cQsVFKkcKEg7gVp6HAl/hHWYXYdMljdndgGwTK8aokG/y+S98Klbykf6FvdhmF3y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813360; c=relaxed/simple;
	bh=D4jZaqWoiqa4TrYXQqr+2O0RzLiC37H/Vk6tbka5qc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sffaPYFZQyTxpcTC2nIK366nvyxfJj6B5DOnqVETVrGFcQ7CM/7UpeQEgYFIZnqwu06GJ1oEmacHMG1Qg9e4JJ6XgmMDRGGU/FKxuAQd5BJnMwsMNNxVM4p+V1q/WpNwVatCjD79xeCobn5vuBWG+BBfwT8liZp3pFNRi7CK7dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ware3b3W; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a36126e7459so154023166b.2;
        Thu, 01 Feb 2024 10:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706813356; x=1707418156; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihl+g5/rZRPOCECkepIZuS5aKdjKNwlyiq9PZoCqPB4=;
        b=Ware3b3Wi/MggS7BW4Y/wxhPdckl4//dCM63oyfo+tVlkFFRf6XDIpf3YvWu/D9BMP
         twZvhn7ZicBER7NR1O3TUFWGqxG26L36Wq7DduQUJExXVxFmf2iHUKL6mod6Ec/CbA91
         wd4DuvPdSxShRw3oUfkX8bH/3dMuqo3KWVAqSEHs9LitbmsoZSqlP/sDnvlc91ON3FXa
         eRQ+1ydvT6MzMkLZhZLfh5VNOWVHLksiWntV3tS9m+46WroQ5XPZ/W5Up90fMdVmsWTs
         lkNi0MAUmo4X+UPoE6Dx1UVfVbtfR2uND39d2lpapUpA/bF9eY0YbhrhriAAKnEvQtHo
         wVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706813356; x=1707418156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihl+g5/rZRPOCECkepIZuS5aKdjKNwlyiq9PZoCqPB4=;
        b=kpGJfu2MWq7Aq6AIG9ywl7PN3ilett+2BuNTPOuPDo/O+TUG5sjVUCc0MKsAHySA6u
         gktTrtECABkzgPzKvfUeNnOAQJNg/vKfH8N0ONuPqrBBCF8R8j95Do3ifrl9MqGuky7E
         FlLcZP/NyMkOtIUVzFqgckqDC35KZJVzsqdHkhgJWKqazH26+/RFV+YRxuhtxYZLqkaE
         xL8vkGPjJoUb36UDpyGbe2gqUBuDt6o1hRCbEB/IUwI9aBxy9sybEjDIrFHOv5iYGyMs
         9q6/zoAAg6t//XMQ/Nb3c+Z6vCHyyeDoggtV7vZeQJcOx5R8iNl5D8Vr/ckGWRxjYdBu
         jwww==
X-Gm-Message-State: AOJu0Yzko90iE+Rk95+Smepw14i1j3B85yhHZDnPPEDvIy90+1CjC1P6
	1vLyHesZmFw7iXoTdbXuconsNXOV6eK+uldn3cVZO8BBrig1jivR
X-Google-Smtp-Source: AGHT+IECaAKFI+HrM9GJnKMdRlUNnkOvOobYd0oCEEuIMXKyN8t8yW7yRExvNAlaXXnMFJh7rNH/7w==
X-Received: by 2002:a17:906:11c4:b0:a35:de06:23fa with SMTP id o4-20020a17090611c400b00a35de0623famr4988269eja.6.1706813355834;
        Thu, 01 Feb 2024 10:49:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUN8ZouWAf5gZn/HHKLaxLcT/Ok7BEEedXGSuyBs8QzqCSIIcxcvlTiRoSbhhoXhDRkgyl5OX273PSpXkg3roODoizQK3K6v66G3knl0zkFNVVd3dP6NbzhDeH9sKVL+mav5IHyXlikv5fIGui1jaGiUURC++LAVT1pV3lzTYAOmmGXC/BXUZpJNAxWgmEWfsObFcHVBSxBaoUz7ALqWeXOgYbI25uTTc+gyCvF80w2irLuo6T4bHehALymDYQg0P0Y/ifoQ0rNoOGNw9d5chd8Gku7GMXA5eGQmiLl5/jx/FOlb/oXigxxL2fsUw8SMZqYwta+XcCxerixk6rpxuaz2mp5YNQjN2aV7/TkMqMNSxwhRq+KLCFa1O+cwxzI18I3XxoXi4GAScwEv+k0Vp91rg==
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k11-20020a17090627cb00b00a367a82c0e6sm57018ejc.156.2024.02.01.10.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:49:14 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 01 Feb 2024 19:49:05 +0100
Subject: [PATCH net-next 1/3] net: stmmac: Pass resources to DT parsing
 code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-stmmac-axi-config-v1-1-822e97b2d26e@nvidia.com>
References: <20240201-stmmac-axi-config-v1-0-822e97b2d26e@nvidia.com>
In-Reply-To: <20240201-stmmac-axi-config-v1-0-822e97b2d26e@nvidia.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=18495; i=treding@nvidia.com;
 h=from:subject:message-id; bh=FKxUC9O9kvT63FVRLSY5iJAMkiANp2n19vF0V6Qtwa8=;
 b=owEBbQKS/ZANAwAIAd0jrNd/PrOhAcsmYgBlu+eoWPJQ58rNP/yDc6hJBuMKTX/5jSzR4bGxx
 FG3h0uMBlmJAjMEAAEIAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCZbvnqAAKCRDdI6zXfz6z
 ocJ1EACloeRZl0DD7FeN81j0pqUr0b9ZHhnAiJz8/FBGVyKH4tHdTg2DkTHdLIMuiEd3UttFEFI
 wWoZfhYUa2FwASA8NtnR7TSN9RrqpXpNFjohYoNhd3ksdU3JyG4T+nxzDjvU6uvbMffF0DhKRwN
 aZHGORiLFT9TvXlqgxmgEXW0vfdJHqH+C7MTb90YEltjYxT1OqfNih3w5p1K+08UgE7cZAunmK7
 71L5drRXEzLLQOKi4Qa/jagaTsncmpx79LXzRN+nQ1EPxSfDQ6zjQNWxWtpDkYXFkK13pp012Dc
 P8yGhkHEPZ4psJU8L5PKKH6X7saOP3CVXly2sNufM3Vr+hmMztDXRgf05XWeTxY3R0g9KmpzpQy
 vNYwmYZXlrt6cdiaAczZMhtj2MHRw9Ka+qwvLFiXHeHYManGsxh8KX776aOVa9mtZzg04Y0ApeF
 B6lMejQ4m2zIpUXLWemC+U9bYIlu9NoSwsH0QkC6ykOx8usTJOFij6/DBbnUrAhywJ4g8ez4vCo
 HRQjVOCSleUK8KOJgEURDX1zGJTprkLqUkXkmsSek4IzO02x+vPlMvgXYRAScYjs3KxrOAUXu3N
 94AZc2qXzTs2oLY2zQ96HL0p9LLwKKL+f+aMrDVa2Xmup1ZRgF4v4pds/sM4b7SkbCmYaJzzaMd
 +YBOb+Zy0nKKFGg==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

We already pass the stmmac_resources structure to other initialization
functions since it allows us to exchange more data between the driver
and those functions. Passing this structure to the DT parsing code makes
it easier to extend what we pass around in the future.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c     |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-intel-plat.c  |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson1.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c      |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-starfive.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c     |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-visconti.c    |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c   | 21 ++++++++++++---------
 .../net/ethernet/stmicro/stmmac/stmmac_platform.h   |  3 ++-
 24 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
index 643ee6d8d4dd..f37d9912380b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
@@ -115,7 +115,7 @@ static int anarion_dwmac_probe(struct platform_device *pdev)
 	if (IS_ERR(gmac))
 		return PTR_ERR(gmac);
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index ec924c6c76c6..36ef2ed9fd2d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -435,7 +435,7 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 	if (IS_ERR(stmmac_res.addr))
 		return PTR_ERR(stmmac_res.addr);
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
index 598eff926815..98a00084807b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
@@ -27,7 +27,7 @@ static int dwmac_generic_probe(struct platform_device *pdev)
 		return ret;
 
 	if (pdev->dev.of_node) {
-		plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+		plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 		if (IS_ERR(plat_dat)) {
 			dev_err(&pdev->dev, "dt configuration failed\n");
 			return PTR_ERR(plat_dat);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 6b65420e11b5..d72b9d8ac464 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -331,7 +331,7 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 	if (!dwmac)
 		return -ENOMEM;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index 19c93b998fb3..de2f5d7e95b2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -241,7 +241,7 @@ static int ingenic_mac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
index d68f0c4e7835..79582983c060 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
@@ -84,7 +84,7 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat)) {
 		dev_err(&pdev->dev, "dt configuration failed\n");
 		return PTR_ERR(plat_dat);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
index 281687d7083b..311410509012 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
@@ -384,7 +384,7 @@ static int ipq806x_gmac_probe(struct platform_device *pdev)
 	if (val)
 		return val;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
index 3e86810717d3..1ede4f409937 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
@@ -169,7 +169,7 @@ static int ls1x_dwmac_probe(struct platform_device *pdev)
 	if (!dwmac)
 		return -ENOMEM;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat),
 				     "dt configuration failed\n");
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
index 4c810d8f5bea..004bf4d14fdb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
@@ -37,7 +37,7 @@ static int lpc18xx_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index 2a9132d6d743..763ec218ff2c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -656,7 +656,7 @@ static int mediatek_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
index a16bfa9089ea..5bd936ef2796 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
@@ -52,7 +52,7 @@ static int meson6_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index b23944aa344e..88db2907640d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -400,7 +400,7 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 31631e3f89d0..473e8d4228e4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -735,7 +735,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret,
 				     "Failed to get platform resources\n");
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat)) {
 		return dev_err_probe(dev, PTR_ERR(plat_dat),
 				     "dt configuration failed\n");
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 382e8de1255d..4297a6919c8a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1824,7 +1824,7 @@ static int rk_gmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 68f85e4605cb..e827e01b4398 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -400,7 +400,7 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index 4e1076faee0c..a0f15fbb8993 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -122,7 +122,7 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, err,
 				     "failed to get resources\n");
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat),
 				     "dt configuration failed\n");
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
index 4445cddc4cbe..5b2cde45dc3e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
@@ -273,7 +273,7 @@ static int sti_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index c92dfc4ecf57..af131b0bf589 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -366,7 +366,7 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 137741b94122..3ccf695c8b5f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1224,7 +1224,7 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return -EINVAL;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
index 2653a9f0958c..f78e244b9d81 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
@@ -108,7 +108,7 @@ static int sun7i_gmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
index 362f85136c3e..bab57d1675df 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
@@ -284,7 +284,7 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto disable_clks;
 
-	plat = devm_stmmac_probe_config_dt(pdev, res.mac);
+	plat = devm_stmmac_probe_config_dt(pdev, &res);
 	if (IS_ERR(plat)) {
 		err = PTR_ERR(plat);
 		goto disable_clks;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
index a5a5cfa989c6..f99d147b3424 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
@@ -220,7 +220,7 @@ static int visconti_eth_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, &stmmac_res);
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 70eadc83ca68..8ec2ac28a775 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -424,13 +424,14 @@ static void stmmac_remove_config_dt(struct platform_device *pdev,
 /**
  * stmmac_probe_config_dt - parse device-tree driver parameters
  * @pdev: platform_device structure
- * @mac: MAC address to use
+ * @res: driver-specific parameters
  * Description:
  * this function is to read the driver parameters from device-tree and
  * set some private fields that will be used by the main at runtime.
  */
 static struct plat_stmmacenet_data *
-stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
+stmmac_probe_config_dt(struct platform_device *pdev,
+		       struct stmmac_resources *res)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct plat_stmmacenet_data *plat;
@@ -443,12 +444,12 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	if (!plat)
 		return ERR_PTR(-ENOMEM);
 
-	rc = of_get_mac_address(np, mac);
+	rc = of_get_mac_address(np, res->mac);
 	if (rc) {
 		if (rc == -EPROBE_DEFER)
 			return ERR_PTR(rc);
 
-		eth_zero_addr(mac);
+		eth_zero_addr(res->mac);
 	}
 
 	phy_mode = device_get_phy_mode(&pdev->dev);
@@ -605,7 +606,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 
 	of_property_read_u32(np, "snps,ps-speed", &plat->mac_port_sel_speed);
 
-	plat->axi = stmmac_axi_setup(pdev);
+	plat->axi = stmmac_axi_setup(pdev, res);
 
 	rc = stmmac_mtl_setup(pdev, plat);
 	if (rc) {
@@ -677,17 +678,18 @@ static void devm_stmmac_remove_config_dt(void *data)
 /**
  * devm_stmmac_probe_config_dt
  * @pdev: platform_device structure
- * @mac: MAC address to use
+ * @res: driver-specific parameters
  * Description: Devres variant of stmmac_probe_config_dt(). Does not require
  * the user to call stmmac_remove_config_dt() at driver detach.
  */
 struct plat_stmmacenet_data *
-devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
+devm_stmmac_probe_config_dt(struct platform_device *pdev,
+			    struct stmmac_resources *res)
 {
 	struct plat_stmmacenet_data *plat;
 	int ret;
 
-	plat = stmmac_probe_config_dt(pdev, mac);
+	plat = stmmac_probe_config_dt(pdev, res);
 	if (IS_ERR(plat))
 		return plat;
 
@@ -700,7 +702,8 @@ devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 }
 #else
 struct plat_stmmacenet_data *
-devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
+devm_stmmac_probe_config_dt(struct platform_device *pdev,
+			    struct stmmac_resources *res)
 {
 	return ERR_PTR(-EINVAL);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
index bb6fc7e59aed..daf3bbb503a3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
@@ -12,7 +12,8 @@
 #include "stmmac.h"
 
 struct plat_stmmacenet_data *
-devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac);
+devm_stmmac_probe_config_dt(struct platform_device *pdev,
+			    struct stmmac_resources *res);
 
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res);

-- 
2.43.0


