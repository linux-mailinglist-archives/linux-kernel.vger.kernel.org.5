Return-Path: <linux-kernel+bounces-39841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB5F83D6A8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6543B2BBC4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D4F1487CF;
	Fri, 26 Jan 2024 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="LFfwpKA9"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F50C1482F3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259462; cv=none; b=kg9qoFAvJFfQEeuyEihlhTQQUDjqlJsCuIDbh4OjBimychZOCmP/JAfuS8y4cHKBaH6lRNwi+S5opfnC+IrLlK3q4fzx2+f23XEg3LdTcFP8LNGguIMXTmke/7F5yFGFdee1IbGHVJUDzBV6FkQT2We51Id+yciy75IPtALyxeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259462; c=relaxed/simple;
	bh=44w1Eo7RhlW6nXS4kAM9bhh18vbkIhL0x13ZWpwygyQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=bG8Cp6mccmbAUvoTFdgOMjugyIGdTscMDGFB0ozyq4ouFU6U2ez3Nh0Jfsy06VegB1CONX6klanCRNJSLCtZOskcXVrMsCXN8dFYNQme/f8PwN3cgQ4N9dZ0o/ngjmofecsUqTl29C4Wb165tBkQs+PT9FKeI54giOLPb3xhWDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=LFfwpKA9; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1706259456; x=1708851456;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=44w1Eo7RhlW6nXS4kAM9bhh18vbkIhL0x13ZWpwygyQ=;
	b=LFfwpKA9SmBgFuFZshgLaYZpbu3cL0WgOGget8JdV4wT3XvJn+7ZQfZcHJI+wVJ1
	eEjzo3DsrX6QtGABRUdGgjU7YlJeZBzQims94kD+XpsfPgTROsSrJdPNLSBxUvrc
	mvVb4+bOobmeQcYa8+9mjQv/h211vFOk4QLWw4Wxh04=;
X-AuditID: ac14000a-fadff7000000290d-b9-65b374007dc9
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A0.F9.10509.00473B56; Fri, 26 Jan 2024 09:57:36 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 26 Jan
 2024 09:57:36 +0100
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH RFC for upstream 0/4] Add support for ETML1010G3DRA LVDS
 display on phyBOARD-Pollux
Date: Fri, 26 Jan 2024 09:57:22 +0100
Message-ID: <20240126-wip-y-moog-phytec-de-upstream-pollux-lvds-v1-0-8ec5b48eec05@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPJzs2UC/52OwQrCMBBEf0VydiUbY1s8CYIf4FU8hO7WBqoJS
 Y0W6b8bK4JXPS2zzLyZh4gcLEexnj1E4GSjdZcscD4TdWsuJwZLWQsllZaIFdyshwHOzp3At0P
 PNRDD1cc+sDmDd113vUOXKEJZLJtCaqKKKpF5PnBj71PXQex329evceF1PnlxzKK1sXdhmCYln
 Nx/tCcECVoh1QZlXrLavAML4qklqS+y0r+QVSaXWBaNxpUxVHyTx3F8AslXSwtUAQAA
To: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
	<quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP
 Linux Team <linux-imx@nxp.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
CC: Primoz Fiser <primoz.fiser@norik.com>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <upstream@lists.phytec.de>, Yannic
 Moog <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbyzUcRzH7/v7dz+3tJ9j83VNliWxhTbXvm1lPev7QMmMWbW48Ru3u5zO
	qdTWmaQc+dOGuTiHsroTOXSINLMwxZpoCe3ogXYihahM+7m1PHt93p/3Pq8nH5aUzlAyVpmm
	47VpCrU/I6EafUS7Dol0rXzYzIIXGnxfR6ClhkKAGntGCLT1rJRENf0jNHq3usQgx3gUspR1
	Uqho3kEi29wEjQy/HpNorKuKQbXL7RTKy2+g0VLnJECDBgeNcu5VkOhWT78YbdptFHq00Q7Q
	fJs32ugyUahtoZRGBYuBKHdKfsIHN5oaAe5ZM1O40zgtxjZLPoOnJroZbBqKxp8KBgjc+kCP
	iwtyafxz9SmNWxY7CFy8GYZLu2/gB+XjDG4dvo5/2Pae4c5KjiXzauVlXhsakShJnXwxDdKd
	4qsrTVY6G1QzBsCykAuHuc1yA5CwUq6egBWz9wnX4ACwt/cLMAA3luH2w7n5GVpgT46Hs5sb
	YoEpLgA+dBq3O+7ceTj1vFvsYg84VPmZEgQkFwSbu0KFmOT8oP1rFSnch5yVgNWF9m2ZF2dg
	oNP2hnG1VgCsswcIDDlPeLtukhBYyvnC+dG7YlfuB8tHnKSLY2H7ip0oAR7GHW7jf7dxh9sM
	SAuQXlQmqXitUhWSnpql45NCknkbEH7ASyTpAEVVuA8QLOgDkCX9vdzD5S281D1ZkXWN12oS
	tJlqPqMP7GEpf293650YXsqlKHS8iufTee2/LcG6ybJBzuvqhPqOo3FrwVuRau5KgF4xbLZw
	8cedojKd78k/L32jj2TvC1yKqP+YeGq45IM6Il5l/SZf+75YFrhcazYN+MWNHVzUaBQxFeV+
	CxcCSlfKC/WnQUqUftRZfy5cdun3292ZmobK2snIJ7JX1vX2GvN60Lip6WanOPZACfTO86cy
	UhWHg0lthuIv5lOKUvECAAA=

This series adds the LVDS panel support in simple-panel, introduces
device tree support for the LVDS panel on the phyBOARD-Pollux and
enables the FSL_LDB config option needed for the driver for the imx8mp
ldb bridge.

---
Primoz Fiser (1):
      drm/panel: simple: Add EDT ETML1010G3DRA panel

Yannic Moog (3):
      dt-bindings: display: panel-simple: add ETML1010G3DRA
      arm64: dts: imx8mp-phyboard-pollux-rdk: add etml panel support
      arm64: defconfig: enable i.MX8MP ldb bridge

 .../bindings/display/panel/panel-simple.yaml       |  2 +
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   | 74 ++++++++++++++++++++++
 arch/arm64/configs/defconfig                       |  1 +
 drivers/gpu/drm/panel/panel-simple.c               | 30 +++++++++
 4 files changed, 107 insertions(+)
---
base-commit: de927f6c0b07d9e698416c5b287c521b07694cac
change-id: 20240118-wip-y-moog-phytec-de-upstream-pollux-lvds-763f604dd8d8

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>


