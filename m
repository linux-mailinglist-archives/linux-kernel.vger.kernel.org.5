Return-Path: <linux-kernel+bounces-71702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE9985A942
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A301B22B43
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7F0446AD;
	Mon, 19 Feb 2024 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZaxrqb4"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C9A41742;
	Mon, 19 Feb 2024 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361176; cv=none; b=AN/1snnucMobjs4kw5b7YQ11IgI7QOLhaO+zZBDOks7suN3YXQ1NGu9/BUMYMWOmTTcMYmAVY0QblLV50ecNx5JflWCVWpWcUnSeREtO1Kno2nG9KbyJ1lgaOygAWnajfjy+1eBwhlaimdGwSztQ2yCQdxUsUO6vnngCcBJeW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361176; c=relaxed/simple;
	bh=IeG2i2FspVCYQp8ErTOsHim7wlCXVIRVr+QfG27vnVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CiK+yBqaubuQfUWNLFPGPNDmGfwGfb0pY3V0wu98H+dJnX4ccAqV1sC0MTz34OenPxJSKcZdN5lRgC+YTpjJLQu32S38DTtEfb/VtUfgvZYlhF7aR/fU67hzflKq+VSXqGqN2fwUQybLKkMHg9C7L19dNyOvimgATSQ0Ps+//AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZaxrqb4; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3ee69976c9so7739566b.0;
        Mon, 19 Feb 2024 08:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708361172; x=1708965972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvQx/ZWr1fmONRjsP3PMsf6y/RwS/zsUlWEFNTxP3t4=;
        b=LZaxrqb4EpeWpmfy8bfbQEZvYBKZj7tAzhRjmuCd21gIwiDgDBLN5ZawdLOwWfxEaF
         xcUDemf/9c/07plGzkQUvjP977KI/OUEAm72kemPkOIa96CJXjbQKOIHVx4+xvNVpXG5
         /RwSnd1EurqOfVTWdI6fq24CZVzM95VIcuBfmh4bZNfELI/3jf0J5HrNPHvU5qiPV9vN
         rwLf4vgOQKfEsmsBtt+S9PWXpZA4hTbkEuwbc4ekzs8f2hDwb/Tx1vVQIR1xAtmid1uu
         aAzHorftyf4sFDVOYckWsdET5wqL/83QiCo15P/qKYvrOVfhQLDBiTUVGxvXhvR1D6Z1
         KyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708361172; x=1708965972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvQx/ZWr1fmONRjsP3PMsf6y/RwS/zsUlWEFNTxP3t4=;
        b=Rnifg00310f29xiLlyx98XwCfmhFh3RduOeKieC0dtFh2UOp2yhkFLQs43uVRh6lMB
         ib1BFsVYB3EhLXcCJl0a57/NgfPuDwew4mPGsticBqxjJgDKwIOVkX8si92nwzZ2wPOo
         Wvg6opndR2OSxX6M0dhbXJ02cxK36uaY9NsyKvbQGBiElAhbM9CgBDb2kc4xIXbEBBQ/
         KrJbe3qrq73cJWkjYYIqEmmDAVal83ko4XpPVaDw/3Aa6/FnqvfH5x3e8CQQ3mzxaRvR
         w61KiS7Z+PndyUey4UbGl2xjxW6PdXzKzVUcjoCVTriSNugbVDm19uoT86i+DP9tDvZk
         F6Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWu6s7cYKBuuB7Jk61psE63ehEEO2DoreOxusW09MkCp5l5CM7Zuefx7gfGwIh4WfdsSxUlhqpGFTp17zLTPYuHoTKc5TvTh6yW+4nUzRGtiNXF/Tg204aX/v5Rou+N48GMdnvrW7ME9v9TBu9NN1yZhKQ9Z3NAMuRYAFeEXHDr48I=
X-Gm-Message-State: AOJu0YzEillG/xks6UX6aUNjfC3DdFv79kBJ5cnRX2LXgETYuaIOvv7b
	Um+UCnCePZHzIUyNPmlauZZaFNVCGm9o0e5T36gqO8rG7ME6h6dO
X-Google-Smtp-Source: AGHT+IGMrTXFePHwGK0f6Gfcanrxom7RdEshhcX0lXB5XyndiBsQwJpHCJ0fUqxOBqv59BYd5yg1Cw==
X-Received: by 2002:a17:906:8c4:b0:a3d:b6c2:fc58 with SMTP id o4-20020a17090608c400b00a3db6c2fc58mr7225638eje.2.1708361172613;
        Mon, 19 Feb 2024 08:46:12 -0800 (PST)
Received: from localhost (p200300e41f2d4600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f2d:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id qo3-20020a170907874300b00a3e4efbfdacsm2186128ejc.225.2024.02.19.08.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 08:46:11 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 19 Feb 2024 17:46:05 +0100
Subject: [PATCH net-next v3 2/3] net: stmmac: Allow drivers to provide a
 default AXI configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-stmmac-axi-config-v3-2-fca7f046e6ee@nvidia.com>
References: <20240219-stmmac-axi-config-v3-0-fca7f046e6ee@nvidia.com>
In-Reply-To: <20240219-stmmac-axi-config-v3-0-fca7f046e6ee@nvidia.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semit <fancer.lancer@gmail.com>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4527; i=treding@nvidia.com;
 h=from:subject:message-id; bh=LdiFXY9cbeHxsNR8EpusW5e+abDEIKHDPw46DFX7qbE=;
 b=owEBbQKS/ZANAwAIAd0jrNd/PrOhAcsmYgBl04XQc+VvRHCQa0rFZHSQK8YQYoyBj0+ZspjNm
 wiF3N9H2gWJAjMEAAEIAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCZdOF0AAKCRDdI6zXfz6z
 oefgD/oDiQVayaGBy3gD68Lgg02XvmyihQ7dQxJr9YR0oiGoOk2gp3rjgUYIzlzCKv72+CHcRSn
 Z2tjumF8g1yKw1DNsAjbldFLiUldaSd1yJxvjB5Mnj+XPAcZU2T82LC7k9e9dP1R0MZhxL63858
 Pkl5ItL3P0HnUJlDTCQYio9QKe0FZa3KoN+YXGp2bOnJzAsmOM/0NHXps/j0Z36V5oKtcc51Qo0
 wLQJivZTpduN7INxBHyVK0MZaGkQOJ3PY++gT78AwujJDbeSd3lXd6esYCesHqVUx6hqMD3t0tG
 iIeYMqzS6sEbYeJVSnO5vawV0yIjitoReFbU/FDLpEQl8rBWNMEI5bRCu7iZjiVULTjvGq6iha2
 e+ExUKqPuN2ShbmnMKPzPHHzfIkG3bqYNuCYuF5+6t+nL7WagNr96PpXvX980dYJGp2W8CiKned
 NbqyN8fITO8FuydmB5Gt+C5igUVCj9ZUN9pd9R6eHLBIEP7sZgkyomnaGK1IqnDpAjWOPGLvCPx
 ptpGh0Z/ZrBlxQsqup77PUdIjQbcvtV7EXLDiY+XSIIJvguDFoskjse27vsMvoc0toj0QtfnCE2
 IMYg87AbH+uXWUqSQjALEgnuzf3o4+SdWnvNIlczWvIGvmTs6V/4mw0nrABpYNNQpMcxXd0j5Ik
 6FVsTp7wlqeiJ6Q==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

In many cases the AXI configuration can be derived from the compatible
string, so there's no need to add the configuration to DT. Allow drivers
to pass in the default AXI configuration so they can be properly set up
without extra data in DT.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- add comments to help explain override logic
- add missing kerneldoc for new parameter

Changes in v2:
- fix bisectability
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 59 +++++++++++++++-------
 2 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index dddcaa9220cc..573c5d99b4d6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -36,6 +36,8 @@ struct stmmac_resources {
 	int sfty_ue_irq;
 	int rx_irq[MTL_MAX_RX_QUEUES];
 	int tx_irq[MTL_MAX_TX_QUEUES];
+
+	const struct stmmac_axi *axi;
 };
 
 enum stmmac_txbuf_type {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 4e2eb54306f9..583f78ae9bb0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -87,38 +87,61 @@ static int dwmac1000_validate_ucast_entries(struct device *dev,
 /**
  * stmmac_axi_setup - parse DT parameters for programming the AXI register
  * @pdev: platform device
+ * @res: driver-specific parameters
  * Description:
- * if required, from device-tree the AXI internal register can be tuned
- * by using platform parameters.
+ * Use driver-specific defaults for the AXI internal registers if available,
+ * or parse them from device tree, if present. Driver-specific defaults can
+ * be overridden by the values from device tree.
  */
-static struct stmmac_axi *stmmac_axi_setup(struct platform_device *pdev)
+static struct stmmac_axi *stmmac_axi_setup(struct platform_device *pdev,
+					   struct stmmac_resources *res)
 {
 	struct device_node *np;
 	struct stmmac_axi *axi;
 
+	/*
+	 * Exit early if the driver hasn't provided any defaults and the
+	 * device tree doesn't specify values for the AXI configuration.
+	 */
 	np = of_parse_phandle(pdev->dev.of_node, "snps,axi-config", 0);
-	if (!np)
+	if (!np && !res->axi)
 		return NULL;
 
 	axi = devm_kzalloc(&pdev->dev, sizeof(*axi), GFP_KERNEL);
 	if (!axi) {
-		of_node_put(np);
+		if (np)
+			of_node_put(np);
+
 		return ERR_PTR(-ENOMEM);
 	}
 
-	axi->axi_lpi_en = of_property_read_bool(np, "snps,lpi_en");
-	axi->axi_xit_frm = of_property_read_bool(np, "snps,xit_frm");
-	axi->axi_kbbe = of_property_read_bool(np, "snps,kbbe");
-	axi->axi_fb = of_property_read_bool(np, "snps,fb");
-	axi->axi_mb = of_property_read_bool(np, "snps,mb");
-	axi->axi_rb =  of_property_read_bool(np, "snps,rb");
+	/* copy defaults provided by the driver */
+	if (res->axi)
+		*axi = *res->axi;
+
+	/* override defaults with data from DT */
+	if (np) {
+		axi->axi_lpi_en = of_property_read_bool(np, "snps,lpi_en");
+		axi->axi_xit_frm = of_property_read_bool(np, "snps,xit_frm");
+		axi->axi_kbbe = of_property_read_bool(np, "snps,kbbe");
+		axi->axi_fb = of_property_read_bool(np, "snps,fb");
+		axi->axi_mb = of_property_read_bool(np, "snps,mb");
+		axi->axi_rb =  of_property_read_bool(np, "snps,rb");
+
+		if (of_property_read_u32(np, "snps,wr_osr_lmt", &axi->axi_wr_osr_lmt)) {
+			if (!res->axi)
+				axi->axi_wr_osr_lmt = 1;
+		}
 
-	if (of_property_read_u32(np, "snps,wr_osr_lmt", &axi->axi_wr_osr_lmt))
-		axi->axi_wr_osr_lmt = 1;
-	if (of_property_read_u32(np, "snps,rd_osr_lmt", &axi->axi_rd_osr_lmt))
-		axi->axi_rd_osr_lmt = 1;
-	of_property_read_u32_array(np, "snps,blen", axi->axi_blen, AXI_BLEN);
-	of_node_put(np);
+		if (of_property_read_u32(np, "snps,rd_osr_lmt", &axi->axi_rd_osr_lmt)) {
+			if (!res->axi)
+				axi->axi_rd_osr_lmt = 1;
+		}
+
+		of_property_read_u32_array(np, "snps,blen", axi->axi_blen, AXI_BLEN);
+
+		of_node_put(np);
+	}
 
 	return axi;
 }
@@ -606,7 +629,7 @@ stmmac_probe_config_dt(struct platform_device *pdev,
 
 	of_property_read_u32(np, "snps,ps-speed", &plat->mac_port_sel_speed);
 
-	plat->axi = stmmac_axi_setup(pdev);
+	plat->axi = stmmac_axi_setup(pdev, res);
 
 	rc = stmmac_mtl_setup(pdev, plat);
 	if (rc) {

-- 
2.43.2


