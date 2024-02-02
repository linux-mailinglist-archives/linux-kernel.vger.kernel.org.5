Return-Path: <linux-kernel+bounces-49801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52F4846F8F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDAC299C51
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B330413EFE0;
	Fri,  2 Feb 2024 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dr8q0Xvq"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A014077B;
	Fri,  2 Feb 2024 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874832; cv=none; b=tdYly/Z6Fx1braAeuP0SaRhmXBuZibzX5UUIPwbLBuaEPIa48h+nuq24tV1n9xUNKtGlNdNjfr0yykfOV8EYFitDEWv+XiAWM4H5popdyQ8HCT+qze66Qq6yc9TvGxffzWNA1gwelkN3M4L9BInoxgsTzwlOGbJm7cQEVcd4rqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874832; c=relaxed/simple;
	bh=KFMTPvcO3d03ibcr31FFDVSDK7z2iX7xYkrIIVGimFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8mWZMpu4ZYQbL/rGJi1iiAgPKXpgiT2Ixg+unS5TfFj3PtXHeecErh8n/LqnoCv6uCNAiO9UMKu3MZdUJ9/aY8TqG22h4+QAPf5CvSklaCAwSyiADtvmAIsHvfkBzOqslMQcIFVeRYMwYcmPN7apuRcY+n8FkY0pkjFCDMuPxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dr8q0Xvq; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55fb4b22da8so2066467a12.2;
        Fri, 02 Feb 2024 03:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706874828; x=1707479628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CP10ASwjzq21gj6cHPQz3XuKiRelwR6OnJvv0UFbQiI=;
        b=dr8q0XvqdkH1e/1Ec/EZ6XLLhoXnZP727nNHUE5UFc0FhKusAUX/vg8D+WOWYt9AWy
         dyFrdejoLmXzUCmTdvX8spCRlF5TGa8rDv2z0tl0fM8fG7UTqqfzP/m6Vvxgf35a1TGe
         aSTGi6Zn/h9p3TC7yPqKPeKi50sdVwxrQyGl2AipmbBo+kHeMcsCgWb6/xoBUIuDgKLF
         n3eFvf59F6zp4z/3tTO80n/Z0uHhS+kizpUxAtIqJB59EFb0mneI8LPf0jQrCqyvf+0c
         87GGCzGgPCTFS029lsR3ahD9oX/LpB/7lnhzogoUA8HaUAmEcFC8JbrIolQ1vxm/dsEq
         1hqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706874828; x=1707479628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CP10ASwjzq21gj6cHPQz3XuKiRelwR6OnJvv0UFbQiI=;
        b=E27yLpBzU7DFohR5t0LKadV/vhHMpVb++fXtYKdl8NDIJXezuVlXfqGHyDAieM5E32
         E0epjMFEnNAlRsMNjCyjq6P0EIiD3hB4cC6lO/M2NN1AJC/zcH02OwEyaKNFXdEdSq17
         d/VjMq53QJEjgWXVeQ9RajGaHUwz9GedN+dUUrCCSFBUKEzf8gW0ZFPgFQaFkQL06CmT
         +uZTjrRniwYujVNT5Y7Tydc3sJ+CkjaDiUupolTJ6C1/PqJLnMet9qvTgzbbXfF7y26V
         CUWTbVmLmAHh3o79F/h0O3z6ddsI8aCJdzwA2VjfYgjxO/N9igUJtJJu2YSOqM9zZntj
         9MKQ==
X-Gm-Message-State: AOJu0Ywd1GPhChaCgRWD1Vf9Jm+eqi7lbnzqpaV3W1KJxsvZDJ7HpkaG
	MznxsiPEOsw/89QJZIZzS/ymtgjSxN4+6f0T0KBgFebpcqnTTyZU
X-Google-Smtp-Source: AGHT+IGHPPLYFBhqVR/gaDzrSKNq+tO5uK8z3aeMJR75LKxl6l5pqsJ2kUl8AjMTV9YnmXgCFMAI7Q==
X-Received: by 2002:a17:906:3185:b0:a37:e01:4ce1 with SMTP id 5-20020a170906318500b00a370e014ce1mr692612ejy.16.1706874827906;
        Fri, 02 Feb 2024 03:53:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWpwEO69sEwY4KarB6KuShExChyl8/gKuL/RYOilEGJSvlaVKBSfDpVehx2iEXmfMIaZLWmtTQCtJ+sjljcmpysvqBVEp7Nf1ulXOCFJgVIdSGNGS8QLi+QbTu6BGA7NtzpGOUIMujKAVoPgnibkSdGZFigPCgslnzX5XGoN2emcFLKbhJ0y76V7+dWN8VEUUJ5BEFlpdC1bamWyqWjS8NwWiF1uA0+DkgjBKsrIEyuIkVTglbzMvTmXb5mX69llbu2vEnJ+dhEzuFiARgKNZvr88qrb0gfHpU0MbdWdloBUu0H8GZgEzLvuZZrkDVsCHYaO6aVXEhAbuGWNQz9wFKDlQodxYYkbOYDPVDj+HE8GuWJPAZG2fx3Fkz5EiI=
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a26f1f36708sm804631ejc.78.2024.02.02.03.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 03:53:47 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 02 Feb 2024 12:53:35 +0100
Subject: [PATCH net-next v2 3/3] net: stmmac: Configure AXI on Tegra234
 MGBE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-stmmac-axi-config-v2-3-64eab2bab17b@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341; i=treding@nvidia.com;
 h=from:subject:message-id; bh=NJ6QmQ9rSuyu2yILzTMeD+XilmAw5wEYJDPvDZo2/VA=;
 b=owEBbQKS/ZANAwAIAd0jrNd/PrOhAcsmYgBlvNfF/cyXbjX6A8uf1KQJ9kvcSPEduJhDj4LrA
 fOD8DMzv7CJAjMEAAEIAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCZbzXxQAKCRDdI6zXfz6z
 ofsQD/sHVqjo63aewWEpeBEYYBpoufs8O0jXYlUjVdfx3sWoSAD4EyEQibNxxEgQdDDh01kQUdn
 mAdnVTIaQtKuVyq1R0RAs1A/uY6hY2QhViuUT2/HfOysFV33fuSz71I802I9DZab9OCfRff/8Bx
 jCxmXr5nLHjNmVKRNgApgif4lxhav5TabbhWUTPm4L6/y8Vtzotm6yGxk81+2DucSmP0cSk7ahS
 VMLQIfPHN7tdmYkTs50s8n403jdDWj4YmD6dISZg9W/KQ8M6eCPpb8zGrYweL2tLYnDRwSYPfJF
 2CAYW3fg6hfNlBHvf3Fl1SxN5kaO0vXkWi7oYh6nohxWr1ZuWdhdJrVc3kz4MbO8vwB+EpTKWoQ
 einP7RipurGn/kM90sfm0I/n/B/StFGuykby1NcOeIftcoSWTSpL8nemCX3gt7myZpEVY3GHzin
 OvTzDoRN6LJr32Mn+gjDHYJyytzGGHJMCByXJScdmMQFt7CF3olFd4eqNoIdu9kBX00FLYWJDlr
 NNvP+sLeuS5My0svv+LeCu+uo28G3kG5Kkxt+X8uBD/rgzCiAWOuIWFcT4TZrJlwjFcYsiFdSlM
 IEM0dwocJb5Bnul9Pr0IrwbUvTbsRgiFqHJHhHS1aRaf0mHNFOWi3V+NvOXktUZa/7lrjU/EMQT
 GeJ1umG6jQE0PiQ==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

Allow the device to use bursts and increase the maximum number of
outstanding requests to improve performance. Measurements show an
increase in throughput of around 5x on a 1 Gbps link.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
index bab57d1675df..b6bfa48f279d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
@@ -199,6 +199,12 @@ static void mgbe_uphy_lane_bringup_serdes_down(struct net_device *ndev, void *mg
 	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 }
 
+static const struct stmmac_axi tegra234_mgbe_axi = {
+	.axi_wr_osr_lmt = 63,
+	.axi_rd_osr_lmt = 63,
+	.axi_blen = { 256, },
+};
+
 static int tegra_mgbe_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat;
@@ -284,6 +290,9 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto disable_clks;
 
+	/* setup default AXI configuration */
+	res.axi = &tegra234_mgbe_axi;
+
 	plat = devm_stmmac_probe_config_dt(pdev, &res);
 	if (IS_ERR(plat)) {
 		err = PTR_ERR(plat);

-- 
2.43.0


