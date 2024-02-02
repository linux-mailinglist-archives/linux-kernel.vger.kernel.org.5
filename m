Return-Path: <linux-kernel+bounces-49800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DD2846F8C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8DE2999CE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6467B140795;
	Fri,  2 Feb 2024 11:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwXKhxAg"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9848813E228;
	Fri,  2 Feb 2024 11:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874830; cv=none; b=t79ZZOiN6Uf9DhPHSUYzw+pl2c45ev3LRoC0TmzU0xyZlJAE8lvoZvKRhWpVE2GnbpC2ODqMjBm4k4Ivql8L8IQkpYwmWqfH1k2zReQuX7VtF65Bezfo3fEBowvKTlS0Rh0RZeKPVBjsXPYO2tCtHJ7CWkpYWtmNgKrEJvb1yHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874830; c=relaxed/simple;
	bh=da0h25LZcdOghH7Hv90gQv6gx+cIMgh3md0m/OrTcik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbg9Uq2jpHiQc4D0RvZChVGNL3CfY8SDPvogNj6YumZAxGOG6BP5vQy2GjgwuYvvTkolDP3bF9ujEuReQFnKe9CXD25+gzbXyg1+ujOjrPoz2XsEb7k2EB4OgyzT+JTwMXxyaBStx9SaHtyi/Vs0VHu+ZJsyQVEO7ufFW5okVO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwXKhxAg; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-558f523c072so2983636a12.2;
        Fri, 02 Feb 2024 03:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706874827; x=1707479627; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Np7u1hXKM5rI6U/dlseYWouqV6C4YX8LzVJmyooXeU4=;
        b=gwXKhxAgQwAXGQ9WlX/2PrtLXVFYGZjI33MSS8oJMD0PTIkG/bwR51dohbiU/F+khX
         E9mNSZF3UFZv/exZUrIELi+vOjrW5+HNJ2/bnKfhN0i1qgav4DcxymBLhJTtGv8LQ360
         oDdO+Cx8KHsXwDDxjgnwe7aMtJEXxX2OjaAzkWX3TAfkuoPyMXiruHYEEwWFDUcYGeBI
         PQQJ0sUvTr0wkelmfe4mhxJMsFEPasehkI0B4ctWG+1RPqqd8nTLZs6FvrySUPI8ICIu
         wGKk+sZCnkEvDRtru4mr2PVLWHA/7ygINduunZiwdndj+ifdT26hMgTsIGmdpEQz2nVX
         Z5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706874827; x=1707479627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Np7u1hXKM5rI6U/dlseYWouqV6C4YX8LzVJmyooXeU4=;
        b=HIs5oMH58Kg1HG+/nJ/qri0fTdoMec+B8BSb6PkhS4nMwmvUM1o5L3TgJ7obbveqPJ
         gbWlFQmf8swcQ9+lhnUy5X58CJd8DZo5lJz+dsQBF6R4BvtVEQHNoAefJ/dRX4gJyV3L
         ixOHkLVZzHTBTxHSDxlW/QgpbyuDg+KlLVZS/AnHbG6e4XeEBhqeziEJa3oSkgujrNSW
         jP74yq5C2eRvfEorUkfu9huWhjdq+zuXAjvD4sJPOaLCTsdf4l2cFzRgEsLI4PhXQbaW
         ZP3yNiahmVjCu7TkTB58T89lWGrxLc2SKahAosroUNCEg5fHIZZML/janu76W3wH97QF
         BXeg==
X-Gm-Message-State: AOJu0YwPHqzUuD3x2ygFRaVv1Aw83WeryVlJoUar6WfweLkMyNEBwED6
	72YESSTfVZ59qka+ngn5pSHmuZRZz4Mgxu2VtqL8zcGojmwV9Nkw
X-Google-Smtp-Source: AGHT+IGXAB7OY/9527WOWDw2boh21DlXg5QEgxoOS1s+t4s7jiOUM+xbeT+3S9LvGOjj9dd43wl4og==
X-Received: by 2002:a17:906:1d6:b0:a36:fe5f:12ea with SMTP id 22-20020a17090601d600b00a36fe5f12eamr1466409ejj.11.1706874826621;
        Fri, 02 Feb 2024 03:53:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUbHjgqn6OGJaSZiz/MJvW0xJGgV3YaTmVkJX/pkkcbMdNTxXe26Hrt4N2J5+Che02N4EpBAowTrg/h1CuORkWetUIul9fPIjxlHVVNDLtTdgUaO+37E/4qOr99TE7Vx/QgH/JFsIK3zyt8siy9jjxb8zxVzYH2W/MlMXDWPu4RMgsUiDGOIXxFxMTwHqrECx9EXzN3pV1FrI78j1BqqYGifuvecUkYbzXgIridLMUdN/upU0+UV/LRjTZG/0BPDzL6EWuVjmYo8426b6/rPkRV/Te2zWdMzyVNW+HO1Rwnwt5LfMy8o01tU2CueLzz2JRxV/sPoQ14rp1x47CfVACOLMXpR3nQQRAzRoC+15tg93Bj1ZH/VVDUV4bUo/s=
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id jy13-20020a170907762d00b00a2b1a20e662sm815025ejc.34.2024.02.02.03.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 03:53:45 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 02 Feb 2024 12:53:34 +0100
Subject: [PATCH net-next v2 2/3] net: stmmac: Allow drivers to provide a
 default AXI configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-stmmac-axi-config-v2-2-64eab2bab17b@nvidia.com>
References: <20240202-stmmac-axi-config-v2-0-64eab2bab17b@nvidia.com>
In-Reply-To: <20240202-stmmac-axi-config-v2-0-64eab2bab17b@nvidia.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3804; i=treding@nvidia.com;
 h=from:subject:message-id; bh=jjLbVkcITf7A0bBP/JxRfOK9o0PWmiljex/57VdQidQ=;
 b=owEBbQKS/ZANAwAIAd0jrNd/PrOhAcsmYgBlvNfFukeArHXtXK5OpnuugX7cDo941KJypi4WA
 a1km2kECCeJAjMEAAEIAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCZbzXxQAKCRDdI6zXfz6z
 oW7HEADClKBGhWi0Zx82nAXZaCzfIVvZNrfpOpy9Xdz4gFT11/y3rXDPXfVfO73YI2/V/FFnPD9
 hEW1+UOH8m3qBULTMjf6ngVg2Cb7Xy8Tgn3Xsq9KUjxr7itXUu7PYgeSR7Xry6+k8RXkTHdXK5R
 VoXBd1nxwfnd6WnUQSs2WQg/eOeZ5xGrownugVu8ZyULrhOuu7muz5w1ajr4YETqhohzxNNi9af
 UB+iNF+xPK2D8y3g8HZVA8rr1/q7f3dtjWziHxIpyorqIls/pnF7yoR4edqSF2ZcPhJ9R1S3UA+
 auSS8mwh+G7jbclrVkxryIgm8QwxmhKSV2yq6pAwoC15zyf0bYmOpyIpngKf7QWNe/+zDz6o19k
 eJoqb8LPHb9hekU7JDhiB/hSu1MZiFJvWrqm7rNnrXM92KCUgPEOCfA9wLw2ao30QvQvYQP0g8h
 sreziZZcVIoEEq8b7xAJ/Qhw3C8xdOxAviulQ3MoFTizTzLJZ8S/agdAkyl6KeItQ7XYn4siWFR
 AoQqlMshTZJ6x0rARbMfitzM/hcsMHvjvJo5UVYzJkqo5+wS4Qc5f8y8lKNxdHDKnnL337oKMcg
 B3sPTHlcfbX8MUU9UscLGCkmak/0e+b5/+vcGxeXGoKTRuUSOx+IDMf33Tno05tQAYgdpoIgGuY
 ZmwCXzrtIFLcjNA==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

In many cases the AXI configuration can be derived from the compatible
string, so there's no need to add the configuration to DT. Allow drivers
to pass in the default AXI configuration so they can be properly set up
without extra data in DT.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- fix bisectability
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 47 ++++++++++++++--------
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index f155e4841c62..07706e7b3cfc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -35,6 +35,8 @@ struct stmmac_resources {
 	int sfty_ue_irq;
 	int rx_irq[MTL_MAX_RX_QUEUES];
 	int tx_irq[MTL_MAX_TX_QUEUES];
+
+	const struct stmmac_axi *axi;
 };
 
 enum stmmac_txbuf_type {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 650ec8d2f5d7..0d5f2cebd6fc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -91,34 +91,49 @@ static int dwmac1000_validate_ucast_entries(struct device *dev,
  * if required, from device-tree the AXI internal register can be tuned
  * by using platform parameters.
  */
-static struct stmmac_axi *stmmac_axi_setup(struct platform_device *pdev)
+static struct stmmac_axi *stmmac_axi_setup(struct platform_device *pdev,
+					   struct stmmac_resources *res)
 {
 	struct device_node *np;
 	struct stmmac_axi *axi;
 
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
+	if (res->axi)
+		*axi = *res->axi;
+
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
+
+		if (of_property_read_u32(np, "snps,rd_osr_lmt", &axi->axi_rd_osr_lmt)) {
+			if (!res->axi)
+				axi->axi_rd_osr_lmt = 1;
+		}
+
+		of_property_read_u32_array(np, "snps,blen", axi->axi_blen, AXI_BLEN);
 
-	if (of_property_read_u32(np, "snps,wr_osr_lmt", &axi->axi_wr_osr_lmt))
-		axi->axi_wr_osr_lmt = 1;
-	if (of_property_read_u32(np, "snps,rd_osr_lmt", &axi->axi_rd_osr_lmt))
-		axi->axi_rd_osr_lmt = 1;
-	of_property_read_u32_array(np, "snps,blen", axi->axi_blen, AXI_BLEN);
-	of_node_put(np);
+		of_node_put(np);
+	}
 
 	return axi;
 }
@@ -606,7 +621,7 @@ stmmac_probe_config_dt(struct platform_device *pdev,
 
 	of_property_read_u32(np, "snps,ps-speed", &plat->mac_port_sel_speed);
 
-	plat->axi = stmmac_axi_setup(pdev);
+	plat->axi = stmmac_axi_setup(pdev, res);
 
 	rc = stmmac_mtl_setup(pdev, plat);
 	if (rc) {

-- 
2.43.0


