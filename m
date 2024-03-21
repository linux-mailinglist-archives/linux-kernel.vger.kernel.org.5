Return-Path: <linux-kernel+bounces-110267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835E2885C4F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3CDAB28A04
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B189F128363;
	Thu, 21 Mar 2024 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZp9W6lg"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9CB86AE4;
	Thu, 21 Mar 2024 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035691; cv=none; b=uiJTGGhI7j4jV4gAJg751URPeXfg0cPC5Kxrg3gPXmrC54Y9a4xSwwLW3/mNovy0nUayghmRNcEO/8sxZ6dM2FKbCKlRPlo6ew9goLnsPy3HDhOLIyBAMig6/TzIoYoOmPTYe5YP6lVBcW2CS+DF9Ssqo1s584Ok4OUyp9PrsGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035691; c=relaxed/simple;
	bh=lem9Yjv8yaZLd3MWClynNq/kI9drw1H09iazXTBXM/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jcWCj80pY/pgC2zS5/9zgIdfdKJr3a8pnwV1ApkV00BQk3GaL+YamvFfLo3B9gPNqYjW7BiFl6wrZXnCFA3V+01EdW2qYa177Z2rMgtW0hRBX72J7wcqKjjnqbDnMGXhhfdTRFb1bkHJ06o5Ms+ny6+exemktAJhWA/LHHMcmNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZp9W6lg; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4675aaa2e8so157250566b.0;
        Thu, 21 Mar 2024 08:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711035688; x=1711640488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cql4KhJI1RGqgNE0QLjN48dIiZawH1fI2/9ft92MwUk=;
        b=nZp9W6lg/TyFZx3n0lxkc/Rx0uz3+b0V8/Zp+HH51ZLiSxRrQrGCPgK4VQT7WuFmUV
         fBuxMJYYi+5+EkTp9oMoz3KFscc6L+MTqTeYO8yN+8TbPSZpuhqfciwnh9VdMLdG37Dc
         QFygZEZAPPX68KSkGmn67Xex/UyXP6Wt77VK5gegQsmKYjDv8ZN3sb6dnoRtHY24qcad
         nYeyZEsV/nsrhVmQVUXg/Gy1zZq51tK9xqPI38lgfdSn0xK1QtBbBBPh9fk+TVbUT0wT
         PseGni0/E95GQtGP0FCsiUOGy3WzwQNVBo5fv82+xjnNWxGwz76lxezn9v3Kq9Scn95t
         +ACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711035688; x=1711640488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cql4KhJI1RGqgNE0QLjN48dIiZawH1fI2/9ft92MwUk=;
        b=buWkZS9eaon65B5J2qosW3HO2fL2V8LnmveW2n1itKGQ/SEl85GES8yBsorKRbAucX
         ckptGXvfXiPA2+OuXNUu5wyU/dxhD+htDhAWt5uviWcSWB9esn9g49mBJsjMsEAEiFOp
         qIwfUI/rlPk4OPvPuWaHFlhTgteinKKoORyrQEYGZuOQ7G/Atk1M9KXZMi2XDLr/oYrX
         GqO5p8fOFX6/5BpvvV0MLosmcojqcoyuPNVYsVL1IN4FGLVxHzgd9Equ+Ba3w+QbXI8L
         k4fJs0oblb51NWf8bP1aCIO2TYK5755MwlMQO7TVU/iiZJRwOibJG/xJmaDzMd8c26rf
         w2ag==
X-Forwarded-Encrypted: i=1; AJvYcCUfQKUwK3CD1PH/0+SAJDoab0cD2hYn2S0Tbhp3q8nJIf/KjQ0LQAdJ/wSC2IBjb2zvs5fYGOsAM9+X4PS0UmrJLZmc49x/IDnPyTrYDB0k3+kpTk2eCrLtwI+k1lSWn8FDNZKIZlUdlWf5lywsGZOA1y3MLqLINF55I3hJmFGqX3Zd9P2Zkrt517rHxmCml4w3wRYz55HjpDrg1MhO8JybGw==
X-Gm-Message-State: AOJu0Yz9yt4L6B5PpzbxG4nAzvj1cNnIdA8ZbFXk5BDtgQSFzb2CXmiY
	k8M9uWX4pNRczVSgzb8L3F2IPYMyKD4LWM55Vg14zpQVdCFdo6EA
X-Google-Smtp-Source: AGHT+IHADXR00efh+0T3naPrysiCTMBoMR1lh/T9J/Tr4Vj05dOXlG40rJlB8l0s7OCdUHeF93aVlA==
X-Received: by 2002:a17:906:3e4e:b0:a46:c519:73b6 with SMTP id t14-20020a1709063e4e00b00a46c51973b6mr1842833eji.50.1711035687425;
        Thu, 21 Mar 2024 08:41:27 -0700 (PDT)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0::11c2])
        by smtp.googlemail.com with ESMTPSA id wy3-20020a170906fe0300b00a46b10861acsm36851ejb.208.2024.03.21.08.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 08:41:26 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: 
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chester Lin <chester62515@gmail.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Schenker <philippe.schenker@toradex.com>,
	Yannic Moog <y.moog@phytec.de>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v3 3/4] dt-bindings: mmc: fsl-imx-esdhc: add NXP S32G3 support
Date: Thu, 21 Mar 2024 16:41:05 +0100
Message-Id: <20240321154108.146223-4-wafgo01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240321154108.146223-1-wafgo01@gmail.com>
References: <20240321154108.146223-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible string for the SDHC binding of NXP S32G3 platforms. Here
we use "nxp,s32g2-usdhc" as fallback since the s32g2-usdhc
driver works also on S32G3 platforms.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 82eb7a24c857..b42b4368fa4e 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -35,6 +35,7 @@ properties:
           - fsl,imx8mm-usdhc
           - fsl,imxrt1050-usdhc
           - nxp,s32g2-usdhc
+          - nxp,s32g3-usdhc
       - items:
           - const: fsl,imx50-esdhc
           - const: fsl,imx53-esdhc
@@ -90,6 +91,9 @@ properties:
           - enum:
               - fsl,imxrt1170-usdhc
           - const: fsl,imxrt1050-usdhc
+      - items:
+          - const: nxp,s32g3-usdhc
+          - const: nxp,s32g2-usdhc
 
   reg:
     maxItems: 1
-- 
2.25.1


