Return-Path: <linux-kernel+bounces-74430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD3685D3F6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DCC1B25AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46853D56E;
	Wed, 21 Feb 2024 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPf57s0s"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AFD3F8D9;
	Wed, 21 Feb 2024 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508506; cv=none; b=LMYFdPPvZmmGIxcH4WY8IZunsvj+AM9VfId9to9z+thpxgAB0iXsuOtfZDPv2sR+rBcmXv2s42cb5UQVkA++gFnvslMfrDiLiXH9pWSKWB7rYCnRuXmlpRNJkAhDrsD9Nl6PddBXOccIA7uh6xLHi8gc9gtwTis2MuV7EMUCZPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508506; c=relaxed/simple;
	bh=fZl7oTQLuBarPlzbhJ747GqaQuGuvabRfhN0aH3pMWM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aqX7PNj30MVze7z137ImpsOaPV3zR/GoOnpc+EIutqUpmBRO7nX445bG5GfUPhNx9HhgszrlqmQjdafQqYAIcNHKX7DuyAAlY2Qux20IWfutYzqiGnq1M5ZBGGRqLPU5rYlZMuUImDR7BexD1jivgErl9xGEtOa9279/Hx5PcA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPf57s0s; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso5426112b3a.2;
        Wed, 21 Feb 2024 01:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708508504; x=1709113304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yp8IfCHTatW0ncFNjRQTUbnECiIcWKU3D3cZUARMrCo=;
        b=mPf57s0sO+xayOnlU88CTTOskoR8x7R4clRbRpk7ULFssoexerM2FVO1OGmxGLJksQ
         nhxqSboJrk++l0x4exOB5CegfcBgc6zQq1rELgYOjrf/M+OoS8oT6V7yp9SfzMS15DuC
         I2NYRzpMhR6Dc1Ds7q1W9LnpYK4g7RuQUdt/SN4uIbShcqZstocX4a1OrPjddt+5HsCL
         V7TMqkWy+/x7j5l1ZwfmeXlwJ0RF92zAlciyMGCzVwuYZqJdZJ6sUwBJvHx5AafQmG2N
         j85Uf+wK0oRhnU8PHV85TyEcuHNj+RIZx6y0H4UfR2q3McmHazidVOxs4L6QeZK8HPDp
         XJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508504; x=1709113304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp8IfCHTatW0ncFNjRQTUbnECiIcWKU3D3cZUARMrCo=;
        b=t0QdQL/eV0xB8Evo7u9mimss4Dg8cqVNBzLaalFTPq9/Rs/hqao53Ik+kMO5rWksLX
         gAU/NjgmRo/+IBKzzjvdcUbbWkDR15mE+AdnWGPifSHqDBXUZ0pFsUkcLMTGLNYatcnP
         N/bBfOnuy3ncexk5cRJOWhvxBYIjQ6rbw/eML89AapaCr/584YsL5brwvzGUVUCXy+M6
         znVDVSTxdCino3HBrDM0lGt2KTmAsPEuYyWUZufF8KWY0kKm7UiPPpiLLa70J3u0ynT5
         rhZI23V0GGGA/hhd67O2/7XRrVIr1fuK3w1/R8QjIU5LPg9qacOX3bhs68RpZ2nvcWHn
         1dAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG5p3oiL2hciGN2SZFIAFJWiHJjEeaal0G7kCY1oPlAlwEZSIL/aABJZ8O6GixK2buqAf4joVLBfRQB+52bHVUD8gJzw583jTh16Gl0+34dtTXh0R461wnaUMDKBImNTXfaaadW1rLog==
X-Gm-Message-State: AOJu0YwJqgldaS92irY9IpB7CjviD1Rh6ysPOPvMWPCjGNV8twSZ3zPE
	u5QR6babJ9zeanUmT2xRKUIVVc5lNA2G1QhfK9d65hzvCnWgHdDGUNhn/Y77
X-Google-Smtp-Source: AGHT+IGv7k191x4u9LLzlTbJkEegKheluwwC62bck+eptDgKc99iYcp34EFkFxeloxTP4rrjn5D+zQ==
X-Received: by 2002:aa7:8218:0:b0:6e1:dbc:d05f with SMTP id k24-20020aa78218000000b006e10dbcd05fmr14900363pfi.1.1708508504103;
        Wed, 21 Feb 2024 01:41:44 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id lm4-20020a056a003c8400b006e488553f09sm1645026pfb.81.2024.02.21.01.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:41:43 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/9] ARM: dts: aspeed: Harma: Add PDB temperature
Date: Wed, 21 Feb 2024 17:39:21 +0800
Message-Id: <20240221093925.2393604-7-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
References: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PDB temperature sensor.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index ca3052cce0e0..4d5d1c822fa3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -260,6 +260,11 @@ delta_brick@69 {
 		compatible = "pmbus";
 		reg = <0x69>;
 	};
+
+	tmp75@49 {
+		compatible = "ti,tmp75";
+		reg = <0x49>;
+	};
 };
 
 &i2c5 {
-- 
2.25.1


