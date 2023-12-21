Return-Path: <linux-kernel+bounces-7934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3240E81AF6C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDDE0286374
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC38A156FE;
	Thu, 21 Dec 2023 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzFM9HcM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5EF156EF;
	Thu, 21 Dec 2023 07:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e18689828so605550e87.2;
        Wed, 20 Dec 2023 23:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703143756; x=1703748556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjNyfg9b/oa8PqsdonOr0+sP3WwEoMGtYWMIoH9NCVc=;
        b=MzFM9HcMGk/SHpHGn2yddyRZEUFTynpP5hQ9j5v2r5mBh+lBbp1/pv89clrFEfifF5
         U8hwhhqDaiQ2JP0rrvnTX4RrckIxZ3s5igCGHEuZvhlUX08ab33657kSnwPOKGocj52a
         sJF1wUtnE91ODf24Cmy4wW1k4d+8WBZJ/JCSv7ma/NOVSA1wyE8MR11Ss52Pz3Dm6/zP
         YG3yfsdkbS0pD5nyohpniG1eLtIsuWF5V0/RDc3w537fE955CRsWu4cpzK2WPzhFjDEO
         oAdFB4O963yRvjZCJ0QDvj+aX+X25YK96yE9X8gj5JSNGWUYlydUXfsd0+d5ZV2J6vmF
         GZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703143756; x=1703748556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjNyfg9b/oa8PqsdonOr0+sP3WwEoMGtYWMIoH9NCVc=;
        b=XNPM3AoaWnuy6ITIcr450aSOhCsK8orvCnhg+MYfaAE7k+KaoqJeT/T0hUeoYk6qBd
         D92DfepyvTng8UO78q+iNbirs5nUSn7t1RM6r98pgZoInraEeos5/RcTPxNLF/9W+54g
         GJT55Qun9ysmT1ril+MnCt8cOeDp27a9zfduHMTZ5LPnRCjVkIqsmSJzmntWwFOfJxwt
         iHqyK/2km6TMwErIa0GV3jmVeTPUvomYcDHoI88jY3ITCVUY98oXIEzbJvgyZwty4nVb
         S8fTN4VcecS8qh3sEcyTEFP3grzqu9vvHi80gpxupTWTbewlfk6D4oRGCnS6PbG+oCT4
         wuZg==
X-Gm-Message-State: AOJu0YwVCuO6iSNDyEBInaemPlZ73k/9LuWUfVx9C6Vm7TQvPT8E/0M0
	fwJ36vVOVmKlJQY9/CqVmVQ=
X-Google-Smtp-Source: AGHT+IEHCBGZ0DhiMdxR4anMGWX2eOZLz6T0JDXNpnpOMZ1qQ1tKA/raIEm5tx5reXntv2zgLwASpA==
X-Received: by 2002:a05:6512:e98:b0:50e:5901:7916 with SMTP id bi24-20020a0565120e9800b0050e59017916mr658174lfb.128.1703143756106;
        Wed, 20 Dec 2023 23:29:16 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id en22-20020a056402529600b00553830eb2fcsm787819edb.64.2023.12.20.23.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 23:29:15 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] net: phy: Add BaseT1 auto-negotiation constants
Date: Thu, 21 Dec 2023 08:28:48 +0100
Message-Id: <20231221072853.107678-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221072853.107678-1-dima.fedrau@gmail.com>
References: <20231219093554.GA6393@debian>
 <20231221072853.107678-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added constants for advertising 100BT1 and 1000BT1 in register BASE-T1
auto-negotiation advertisement register [31:16] (Register 7.515)

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 include/uapi/linux/mdio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index d03863da180e..020ccc810d23 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -348,6 +348,8 @@
 
 /* BASE-T1 auto-negotiation advertisement register [31:16] */
 #define MDIO_AN_T1_ADV_M_B10L		0x4000	/* device is compatible with 10BASE-T1L */
+#define MDIO_AN_T1_ADV_M_1000BT1	0x0080	/* advertise 1000BASE-T1 */
+#define MDIO_AN_T1_ADV_M_100BT1		0x0020	/* advertise 100BASE-T1 */
 #define MDIO_AN_T1_ADV_M_MST		0x0010	/* advertise master preference */
 
 /* BASE-T1 auto-negotiation advertisement register [47:32] */
-- 
2.39.2


