Return-Path: <linux-kernel+bounces-142376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D983F8A2AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D331C22644
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA925472A;
	Fri, 12 Apr 2024 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhrQ7F0d"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D2450A72;
	Fri, 12 Apr 2024 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913502; cv=none; b=bvKXDM3Ww6/UObnV2rAyhn4jhtY4YDo4JXcqmAB7MgKsVzgEzD2GEAkZ22cWIIg9mmt/NH0FNibyO5mPnXi/mf7mSE+0wPGuxAmJYF+L5/uXTm7pbZQeYxKauYI7HC4WRz3dA9qgTJFIuJkZKvwT+BwN3ES4s+T+12dKoeQ7+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913502; c=relaxed/simple;
	bh=XPSN/8fKOe9wSk+OzqVpG4SSnbM9P4l84A0yuzwgCRA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bji16Yg7/6hoG26iiEZai3vRn75Dx451A2xgMpEt7JQ0UG3GugSBwlItD2z5zs2qVel9YcrPWZ7aOZroe93TzQtJamv6PDCXS3Nvd8E/Fq/T9mFVu+WyBy3v7+YFQCNC4XpFgtoZGyLwUBlkW83SAEPtUzc4LDkEk9uMQas4hus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhrQ7F0d; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6eb5310e9fbso455352a34.2;
        Fri, 12 Apr 2024 02:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712913500; x=1713518300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eE+ArNThktHqxq53xyc4RaWaWv+q0sBFJ+ThRmH5j0U=;
        b=lhrQ7F0dpKszufGDVlAZ0svfgDnYXaFkRfqnmmF8cW2MYi0JPvgS07I4CynUPwklOV
         46Wwl8iapCNZLYdYEwdzdb98zr4wAn3ZymSAbJw3+3Q28N/lUzuzDieCjeIgYZN33Ptl
         cpmXQsjkKx1By19x/5Nxg8U49V3i5Eb3W2xztXwDRI1qnZSJsLFrwIMIXNEbHA7FEyyX
         Xr2uHkBpX5Avm/S0Miz8sLPQ3uLyOTlb5YTRQKdBAJ7k66ea2v/aST3/mMZHGOPr2uyU
         l+/vBM8mtGsU16Uc2tojFneStrOqi6yifiXSpwcMWdnoMQAoOESP3+LMHLUHdpA71yaz
         oQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712913500; x=1713518300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eE+ArNThktHqxq53xyc4RaWaWv+q0sBFJ+ThRmH5j0U=;
        b=twdMauVeqH8ImZ2C8bBBpkDcR29Lgq7K8ct/PJlg/M7Ur+tdMwKJhOHrEZseOow9VA
         wwJrfCP3WAFSeHnEUDb2lVCW/L+P51qsIpiL5mpjZaER6Bleeic2GoY4j3fd0YQCnLmG
         4Scl+Uk9GjTJho3t4SSvbyq7NrPejD1Dq6HTvd0JPk4KsFQTyeq/qsrFS7dDwpSn0EiR
         oXhiNPzAFE8eyOosyeKvmG9OBHMMQid/JBUMNjsFNx4F45YWVe3jBz26c4jLzTF4VHCU
         VDX7Sc7mUEduonfhxHB+9EAChIQy9yLoCfZ18F/h20ogZCxOAjXuuBUf7LfCbivJBwKN
         63JA==
X-Forwarded-Encrypted: i=1; AJvYcCUdxIHUrcFLIakSf8nhQrGH+LVTquH/C//IXUfeeiq16u46OsQ4vI3XHOVE/n4CJqkQwruwjS3N9+nNqT09lCp51UP1p0gz4//hTngSFTL/uEZIwxC0xmS/fXYuTDSVSIzusRzyJAJEsw==
X-Gm-Message-State: AOJu0YwpGf3bMiqcZkul7qvOmalNgyAtRSD7AYvzBIlhi81HnHmLRwbi
	Ct+JUJABy5sNs7rijBVT/cZdcdC7ffWmV0f2xt4MCutwKgi5a/aN381lvw==
X-Google-Smtp-Source: AGHT+IGuaPRWNC3+2UCR6QUBGuOjGB9+hyVmpUhpOqmfJLvoBQdvte3clovGToV70M0AqKTeQ7hR5g==
X-Received: by 2002:a05:6808:199c:b0:3c6:23d:ee47 with SMTP id bj28-20020a056808199c00b003c6023dee47mr2247264oib.41.1712913500656;
        Fri, 12 Apr 2024 02:18:20 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id b25-20020a63a119000000b005e840ad9aaesm2332711pgf.30.2024.04.12.02.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:18:20 -0700 (PDT)
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
Subject: [PATCH v5 06/12] ARM: dts: aspeed: Harma: Add PDB temperature
Date: Fri, 12 Apr 2024 17:15:54 +0800
Message-Id: <20240412091600.2534693-7-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
References: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
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
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index ca3052cce0e0..5c3fa8bbaced 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -203,7 +203,7 @@ max31790@30{
 &i2c1 {
 	status = "okay";
 
-	tmp75@4b {
+	temperature-sensor@4b {
 		compatible = "ti,tmp75";
 		reg = <0x4b>;
 	};
@@ -260,6 +260,11 @@ delta_brick@69 {
 		compatible = "pmbus";
 		reg = <0x69>;
 	};
+
+	temperature-sensor@49 {
+		compatible = "ti,tmp75";
+		reg = <0x49>;
+	};
 };
 
 &i2c5 {
-- 
2.25.1


