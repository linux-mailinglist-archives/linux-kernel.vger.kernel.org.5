Return-Path: <linux-kernel+bounces-39845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082E383D6AC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD9B1F2DCE5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C970441C77;
	Fri, 26 Jan 2024 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="PrKilppn"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9495D41C72
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259468; cv=none; b=bRFiHxu5VnbKsTZ8pPAL5y33fQh0c/gMtcB5fpbs+btEbTWUXPZNsRk9ieYYDyaQ5KG11pbe6rtgqam6lQcFVkGqhBOBOiSiYsCwuLxEDYYj88I7XSFbAEj0yzlUNG4qUq+YlfaegqU1OQmDWwpo7B8WuhfwnrGvr+Ka6CkIbSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259468; c=relaxed/simple;
	bh=wBQ4xfAfXtn1FLfmimQlpQJ+HcmxcQEmSqcJyqP6Px0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=P9wgTmxZP7ToWPVm7L2HCJTiKfbwL6bFl+m5isBrEsneHNwBc8s9Bvz4HJ+5M0M3uia9855UbydrnWddhv9MWCGkD5NXEVYMSaGXa+g9G+3KNaACdqAe4W5Y55N5lb3KF3xRWXjNT96iPaetQUkoubNrU9zuSCb0rHkcZcDEspw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=PrKilppn; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1706259457; x=1708851457;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wBQ4xfAfXtn1FLfmimQlpQJ+HcmxcQEmSqcJyqP6Px0=;
	b=PrKilppnBmch0CAVl61IH3pQu9sJHL61j8hreTot/ZKHNO1zTo5HjVxbTw4defKf
	54FsbVmAz4a9b7/z8LExmMEWPgHOiHKYYhDWQu1Im/xXJosatrsSwMexIMx026o5
	l2WWdgGpCxM7m/ho4wq9ygWBiE84hvsRt7FoQ0bhdA8=;
X-AuditID: ac14000a-fbefe7000000290d-bd-65b37401dcb5
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 27.F9.10509.10473B56; Fri, 26 Jan 2024 09:57:37 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 26 Jan
 2024 09:57:36 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Fri, 26 Jan 2024 09:57:26 +0100
Subject: [PATCH RFC for upstream 4/4] arm64: defconfig: enable i.MX8MP ldb
 bridge
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240126-wip-y-moog-phytec-de-upstream-pollux-lvds-v1-4-8ec5b48eec05@phytec.de>
References: <20240126-wip-y-moog-phytec-de-upstream-pollux-lvds-v1-0-8ec5b48eec05@phytec.de>
In-Reply-To: <20240126-wip-y-moog-phytec-de-upstream-pollux-lvds-v1-0-8ec5b48eec05@phytec.de>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbSyVYRjH3c+bx6nTnh7KTQsZ6c1LTXZ/qFattduXVOpDlumMezkjzo6j
	JVtFp+QQqaWRnRASGo6XwxnZRDmzWPNSeclMNS/FzNuI5Oms5dvv+l//67r+Hy6eFr8xjrwy
	SkPUUYpIV07GlDlYbfQEmirik6LdgNo+5lNoqigVoLLGDgqt1mbQ6FlLB4u656Y4NNwTgEoe
	1zMobXSYRoaRXhbpll7SqMuUw6G86RoG3U0uYtFUfR9AbbphFiU+fEKjO40t1mjFaGBQ8WIN
	QKPV9mjRpGdQ9Y8MFqVMeiDtwMGjDrhMXwZw43wug+uzB62xoSSZwwO9DRzWm8/goZR3FK4q
	uInTU7QsXpirYHHlZB2F01d8cEbDDVyQ2cPhqvZ4PGNwOi0EyQ6FkUjlVaL2PnJJFq41VdKq
	FvbazCO3W2Cc0QEbHgq+8LNueY1lvCg8p2CS+a21pRgGsKlpDEguTnCDI6NfWB3geUZwh7++
	H5dkWyEQ9mjNfxfJhc3QnPWVkSy0sBuWm7wlmRacofFnDi3JcuEiHHsdK6G4hrqREAlthGCY
	cNtTumkn6Dg4YXjPWSZnAcw3ultS2sKk/D5KYlHYDkc771tbdGeY2TFBW/g8rJk1Ug+AmL0u
	T/b/PNnr8uQCugSIV5ShEUStjPBShcdpSKhXGDEA6RXsrGR1IC0HNwOKB80A8rSrndz3YCUR
	5WGKuOtEHR2ijo0kMc1gG8+42stL7wUSUbis0JAIQlRE/a9L8TaOt0Dq/HJFQnGwb+0+F6c8
	uwt9LzY0xE76rAR4+C/VGNnfy8auVV3UicHozMKnxcd6HQLV43WtnfGiauZNoZC4I0Hf6K/a
	2bopWraQpY0U2bP1+vyEglOm/iFmKOlV967+UqRXsgufiNmP4uwrptvLz6Xt/eAXtIVsPXnD
	5fAcfcCViQlX7N9Dq2MUfwBl3OZO+AIAAA==

Enable the i.MX8MP LDB driver used for display support of the i.MX8MP
LVDS interface.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b60aa1f89343..acd71548cf29 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -850,6 +850,7 @@ CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_SITRONIX_ST7703=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m
+CONFIG_DRM_FSL_LDB=m
 CONFIG_DRM_LONTIUM_LT8912B=m
 CONFIG_DRM_LONTIUM_LT9611=m
 CONFIG_DRM_LONTIUM_LT9611UXC=m

-- 
2.34.1


