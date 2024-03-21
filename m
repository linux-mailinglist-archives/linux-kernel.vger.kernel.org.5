Return-Path: <linux-kernel+bounces-110265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B12885C45
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2961C22AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFEA86260;
	Thu, 21 Mar 2024 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xfs/Pns/"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475EC1272BC;
	Thu, 21 Mar 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035680; cv=none; b=unEfnVrJSBa6on+PNvAQ+hr/PzjR4jLuiWnhHhORIw95IeeEMobyYOLqN8wjUINlBV+ggamWyIkTlLyUYktlHFMPYvdQghb1TsCIqRm8pWhbNos1lxk/t8sHrhtVroBZrHa3dTPm2iGJbHQIGsRhSeYeqC/0TO2J1zcIbbmdYLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035680; c=relaxed/simple;
	bh=3k29lXcW8uEAKoWYgHnyswI0elzTFDIfCfwnq6FSOFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BLe8122S9N7vdP8s7bBopoXdu+P987MofOLRLnrMhonGpSc4S+Lfd4J7EuPHgW/An0Hw0WlwtDUbmSNxqfRqHa250pOjppOWn5CTsI8Rn1m/diRaIhf9ZviWf1ZKg+6oZU12wytU5LneSFhXzjq8xGnZVHOY3FEo1q0ZfpFPyCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xfs/Pns/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a46dec5d00cso154549166b.0;
        Thu, 21 Mar 2024 08:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711035677; x=1711640477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjMgNaZqZl/14S1XVKF7lRvTFCmrJzDvQB5xJ2Z6ALk=;
        b=Xfs/Pns/YuHG5mj+HHA86kEF7n2GIAbUC1AVtDpF7GYo3i3p6JjPDV6GGOEfG9GM7C
         aTjaZH5lOZn7+2K7pXMCWLnKE5QUyAhIBGBh1fBrn+houVyaAyopvpAJohVJhBSzzcJz
         vTIUPkTZUmZWLdc6/qHieMgPOBqk9Ezl87uAB+YVU4NIdcJSoOeaLaS8PBgbYSnoKsNb
         V6VJQVWFRfgiUtsNRjiRm97MWJn70bd8tBs48P8DKKf2VAXVzv4IIqfJIh9kW9VsH4gQ
         Guyriq/1oamPKLzRaC8i373/+0UYCcirGuIqrFMmkYvElYo+d//ZiiI9pEGRtkr0j1du
         JVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711035677; x=1711640477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjMgNaZqZl/14S1XVKF7lRvTFCmrJzDvQB5xJ2Z6ALk=;
        b=BWIPgJS5ozGn2+YA+pYtEsIV6ACVzqm9wzAotX7jf99iOxbtUJJNUAP2L2zBnzJn1y
         PmpGWeSeYBbJp1Z6TDKUwQbG6J70lqWLW6/PJEi7d9M4UiogVRwXSe6aEGRR8hssfO8b
         12zJOiiwhyVvz8E0Li5yfK74uDK4VNi+28y6p/XiauqsDeqGYz+DDjXu268uswh4/iOs
         ajigF/4wPZ/g/wVEBfRvknhGvninenkqIW5I4UiTsiqb6FeePv3T/obv+JMrbHbdR/kB
         hH/z/vIeceQNx3UT4fJI2MxAmi4N7FOPsiydfq3thlb20JXNRDgindu9oqw+we0/JfVS
         xYMA==
X-Forwarded-Encrypted: i=1; AJvYcCWeOeD9zlueSuYvjN8jrUG3aCxZWKFVRbtZdZtBUBBaWSy0mhd3FKQv8y/TRfqTx0OAW3SSs82JIGskACqGJtvtgVCdiIhvUJmRAafX3fQKjRm+GNrSbnBJvc04J69bQB10L/If0V8yQYfJUG9+7oSxU5T9gyMyPv3uql9ho2yvje5Ea3YVwkH+vZLRW/tILdco7dctWQa0WillJRbeuVRrsg==
X-Gm-Message-State: AOJu0YzZ2Oa2rJaXNe5ZOjW2g+uDmSMAq+kWjER17po2p4M8cwrh+TH2
	vflNcqRTjJo6jd7UCFxBQwqjhIiFxrytzDlXUWjyN9vOoZ69NYiR
X-Google-Smtp-Source: AGHT+IGsd/cX5+7Tj9NavMFeyeWi39bmOi5CnEGGqscA9E7yBGy0BVUERrFAZAdyo8PeEksgR3iKoQ==
X-Received: by 2002:a17:906:a09:b0:a46:64e3:e284 with SMTP id w9-20020a1709060a0900b00a4664e3e284mr1625960ejf.74.1711035677483;
        Thu, 21 Mar 2024 08:41:17 -0700 (PDT)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0::11c2])
        by smtp.googlemail.com with ESMTPSA id wy3-20020a170906fe0300b00a46b10861acsm36851ejb.208.2024.03.21.08.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 08:41:16 -0700 (PDT)
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
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
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
Subject: [PATCH v3 1/4] dt-bindings: arm: fsl: Document NXP S32G3 board
Date: Thu, 21 Mar 2024 16:41:03 +0100
Message-Id: <20240321154108.146223-2-wafgo01@gmail.com>
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

The NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3) [1]
is not documented.

Add entry with an nxp,s32g399a-rdb3 item.

[1]
https://www.nxp.com/design/design-center/designs/s32g3-vehicle-networking-reference-design:S32G-VNP-RDB3

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 228dcc5c7d6f..23bf1d7f95b1 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1503,6 +1503,12 @@ properties:
               - nxp,s32g274a-rdb2
           - const: nxp,s32g2
 
+      - description: S32G3 based Boards
+        items:
+          - enum:
+              - nxp,s32g399a-rdb3
+          - const: nxp,s32g3
+
       - description: S32V234 based Boards
         items:
           - enum:
-- 
2.25.1


