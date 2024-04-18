Return-Path: <linux-kernel+bounces-150427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463178A9F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A60281F76
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC8716F83E;
	Thu, 18 Apr 2024 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQWwmmPH"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED27B16EBE1;
	Thu, 18 Apr 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455530; cv=none; b=AZeq/3Q2kaOFQGqO6I8eKee60d3NaQwLEt88GWgICcRIvSA1Sl/BYnRjv7zh3RtsTy5iESyeYujaOzIuHKEr4cxGIUVSw7+rnQjBWHtEfbUnK3l0Au2XOuz+Opraw8Gz/oS3wBPi0IvTps41f2yAh8t3l40WLVHQ6f2jSCappyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455530; c=relaxed/simple;
	bh=wFnbcWy5gk5sXW+5zvt0NargWqewhsVtKQ7Weekss4g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L39thU4zx6BpflSR+bMJd+DaLAI6IYpSlDPaZMbsAfQpLek0Me+2fVZTYmTsKB56KxkHm/L4LJjdchtZ3CXwUADfxuJ57x0WNP/+FfB/bPh+BxrTJ0IFISe6UWAT6CKzhw+W/vYodpIAOTYwSBumjZRSi83HPCsBNKX0ZJ/AOjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQWwmmPH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-416a8ec0239so6408355e9.0;
        Thu, 18 Apr 2024 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713455526; x=1714060326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WPBZ9ExHuwu+bu/mp1K2y+evtVoXz/i7anIOf+mTPDM=;
        b=gQWwmmPH1uWnTyO1OWY3UhpPR/xTuH864OmjPShFuK6zQ8OADlA4rvnDcQFTE2G4KD
         nvno1Z/mCEDoYsiUlcBYJFfX+leELAcHUKEz/X4Cl1ezwPQ4NSKBINQYAdLow8IfjIaT
         Rg0g0yzlp5U/VxpS0Xfox6sArLeNDvia/ft8dgLnZAcw/Jdmam/uWV+u0Ad45TjcpBwf
         DsIOgDtxRvsYDy6bwWojPmZ1jM/YYOAFzvmDAMAaMRZuFHjnofh4livsJ+aWEg/0R7ZA
         QwaZI9ImQebR4SCFYKVKZT8fHrabZZSe3uGuqi0S9GFgTokklFeOPn1SYXDwVl24AlUV
         uhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713455526; x=1714060326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPBZ9ExHuwu+bu/mp1K2y+evtVoXz/i7anIOf+mTPDM=;
        b=AK8FfJUe1wF2u/nBXruwVvqIVeeAptc41RmkBFktwFHU2pmYpgOU6PJkov7lJt4LlU
         RcHrXxShinzqo034ReX9oFGWS6sGdzUu+zBMfqQ0eUdCcKY0fgwMtP2glHdMVHOtfh7q
         4HiMah0PU0b/C3/KhVol+Yw1ohhx9WFE2Z8JoP8Mu/9o4bYC8GV5PFqt0K/4f3LuHfp9
         Va4oRQUH/qbcOttmQW9apSul/btyuIrIIE3h2jJXWjhcpjQejhY3WEEyF6CXHbmS2PLK
         42oYks0PAokfn74Jk3SD1XSNNKLO/t3WaGvvBMwLV1ET8XV+4ANrzPv5YK2EdsB0Iacr
         kR+w==
X-Forwarded-Encrypted: i=1; AJvYcCWhkSiwWU4PbQRQR8ReMYy+7ckSoMUQYOyZr6E3Rc9DtDG10PLKhcbB4+ASZUpLkegEfSMOREXSHj1ysLlgXDco7Chb2EPCi8KvL6i0rmxiR0zK0qVUFj2j3T+i25zuxlsEs78EFJyOFcJpL1lzc3Url/vdQq6Z1k0gAi11aeY=
X-Gm-Message-State: AOJu0Yy3dhayejxhNlOrk3be717OU14ZPUYw6bn87l4hYMa4SIZxILEe
	xt4Ew5XvGBtSEaFr7dh4ag9S76pZmqFRS0TonLTb46sl6DA3NYuP
X-Google-Smtp-Source: AGHT+IFSm2+nTTTBh/s5wnJ18wP/8/m9M0ecQsavX8QpbNXPEQlYhBTSMGaOPCVh/XJ7vaSK6GL7IQ==
X-Received: by 2002:a05:600c:4e09:b0:418:f219:6e22 with SMTP id b9-20020a05600c4e0900b00418f2196e22mr1182984wmq.11.1713455526019;
        Thu, 18 Apr 2024 08:52:06 -0700 (PDT)
Received: from vitor-nb.. ([2001:8a0:e622:f700:cffe:40a8:31d4:2e61])
        by smtp.gmail.com with ESMTPSA id o30-20020adfa11e000000b00341b7d5054bsm2168202wro.72.2024.04.18.08.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 08:52:05 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ivitro@gmail.com,
	stable@vger.kernel.org,
	Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH v1] pmdomain: imx8m-blk-ctrl: fix suspend/resume order
Date: Thu, 18 Apr 2024 16:51:51 +0100
Message-Id: <20240418155151.355133-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitor Soares <vitor.soares@toradex.com>

During the probe, the genpd power_dev is added to the dpm_list after
blk_ctrl due to its parent/child relationship. Making the blk_ctrl
suspend after and resume before the genpd power_dev.

As a consequence, the system hangs when resuming the VPU due to the
power domain dependency.

To ensure the proper suspend/resume order, add a device link betweem
blk_ctrl and genpd power_dev. It guarantees genpd power_dev is suspended
after and resumed before blk-ctrl.

Cc: <stable@vger.kernel.org>
Closes: https://lore.kernel.org/all/fccbb040330a706a4f7b34875db1d896a0bf81c8.camel@gmail.com/
Link: https://lore.kernel.org/all/20240409085802.290439-1-ivitro@gmail.com/
Fixes: 2684ac05a8c4 ("soc: imx: add i.MX8M blk-ctrl driver")
Suggested-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---

This is a new patch, but is a follow-up of:
https://lore.kernel.org/all/20240409085802.290439-1-ivitro@gmail.com/

As suggested by Lucas, we are addressing this PM issue in the imx8m-blk-ctrl
driver instead of in the imx8mm.dtsi.

 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index ca942d7929c2..cd0d2296080d 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -283,6 +283,20 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 			goto cleanup_pds;
 		}
 
+		/*
+		 * Enforce suspend/resume ordering by making genpd power_dev a
+		 * provider of blk-ctrl. Genpd power_dev is suspended after and
+		 * resumed before blk-ctrl.
+		 */
+		if (!device_link_add(dev, domain->power_dev, DL_FLAG_STATELESS)) {
+			ret = -EINVAL;
+			dev_err_probe(dev, ret,
+				      "failed to link to %s\n", data->name);
+			pm_genpd_remove(&domain->genpd);
+			dev_pm_domain_detach(domain->power_dev, true);
+			goto cleanup_pds;
+		}
+
 		/*
 		 * We use runtime PM to trigger power on/off of the upstream GPC
 		 * domain, as a strict hierarchical parent/child power domain
@@ -324,6 +338,7 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 	of_genpd_del_provider(dev->of_node);
 cleanup_pds:
 	for (i--; i >= 0; i--) {
+		device_link_remove(dev, bc->domains[i].power_dev);
 		pm_genpd_remove(&bc->domains[i].genpd);
 		dev_pm_domain_detach(bc->domains[i].power_dev, true);
 	}
@@ -343,6 +358,7 @@ static void imx8m_blk_ctrl_remove(struct platform_device *pdev)
 	for (i = 0; bc->onecell_data.num_domains; i++) {
 		struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
 
+		device_link_remove(&pdev->dev, domain->power_dev);
 		pm_genpd_remove(&domain->genpd);
 		dev_pm_domain_detach(domain->power_dev, true);
 	}
-- 
2.34.1


