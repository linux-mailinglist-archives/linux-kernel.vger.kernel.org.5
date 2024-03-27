Return-Path: <linux-kernel+bounces-120573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA16188D994
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63ED1C24D24
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96207381C9;
	Wed, 27 Mar 2024 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8kVElcV"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12B381C7;
	Wed, 27 Mar 2024 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529626; cv=none; b=EjOCTBCKuX2PB42lDj+TQIVFnPjEf8Sj69ERITfJ7Mewqpv4zxIk/vRBO105qGVe+9OnBomFl9ZQkvN4QUulSiNP+jLWItTJP53RAFAtLeQoNYMmeGrLbEhowgXJvihGtTpoAyhMdJ0gG5tzhTaJKt9sQ1mEA91Oq92a7ww7aSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529626; c=relaxed/simple;
	bh=OmbQeEpYAXewoGuDq+EgMFX3vG7k0YYOmneTwe9coEE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AQ9Vi1jX8grtZ0E0X0RZdga3I9IO7gYYJE2xYV7ulzABPodkKQE/rll1HZ20BqU9D0wwwO/6ga3nDOPeDFOUVPXfol/+uZaIaoUsk4ATdEiHeSDODE0T+zKl5TQonFvN2DcPAR9KgnN3EGcuwWkCPJw2aiKEBWAuioqZiVquo60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8kVElcV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e0d6356ce9so21811645ad.3;
        Wed, 27 Mar 2024 01:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711529625; x=1712134425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNSpu6YM8BptgR2qjrv8QihJHcI+7VsMuE3/EFlGmdw=;
        b=Q8kVElcV/XFrGp0HVllKUnRVNST6F1VeaOh1n7YQPd1rQbS1REqUycbRlikR8A9Taq
         FWNsikCTsaALOQM/z+wyi3cAQWhCEfaRJeEVrrwNCD6nXRj1YVR5LBZt6ZpEVzOsEhUO
         HH7hy/4x4FcrRIUe+9faNxP42thMZIB2uhJPHVlC1t7pZ7zdojPZW3Wj3pe+ywzrJgF4
         TSeWzqTsLMwuhXqD0xWivwWL0reJk6ML7JBZ2Yvo6ac7hAkDMLbdqpfTmoCgvCzFqvKo
         7BCfs4OZHO6rHBztE1yMSs6W6FVuMLIPNm8paD9nFf+UJP59lkFEn4a+2LuLe9sDOMaC
         irBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711529625; x=1712134425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNSpu6YM8BptgR2qjrv8QihJHcI+7VsMuE3/EFlGmdw=;
        b=vL/VdMG+JRhbLLuwbWZZhVuchSSEREz0onYDrKgj+NzaxWV3emB+IiPx5ogfaMRomV
         z2hJkEjLWlCSAuFORS4RXLWBAZs/vIEy9aQOUoqEMFEwmudPckZwE7tTGXxrLSKebCO1
         2WfASppYzFPqZStiRLRJVgFczkNenfTU37mMBQIOj8Tj1hw8Fmf2ZmjjqkgToyA9Q6nY
         aC9Nn6sWMjoHh7SEKA4S57mNQiLPPn7thwGkWBjM8eDWzbPu7Jh41vDWhHPccQrMz+Ef
         d6k3ZH2rtL6/RtEI3JsD7kVbgmvrt10D3oktsIFttqIsyzJavVsv7Oqcfn0ubT6f8Bkx
         bxLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsrCmXrL2EaTPZf1e6Me/HyIq/ZanV/VQ1wSzpZ/mkSZ8/ALPK3QcW3fCkf3ZX9Py9LFEFd2U3VLFjWtPZY9RQxsroLcPTs6jMYQzOjxfo+sRoYSmh+iWxB6j9G2ZUGehWwmfVqRb8j7joflX2wYLx/xX+HaEvHZ17ZYeysOnmtqtvwF/dwkud
X-Gm-Message-State: AOJu0Yzxc0ps/DK6zK6KHyZAW2EFTs34J/G5IWA8MsUPrETEWHFsGv61
	DZFE+R6OqTW5M7iqGKHhWMgpr1RXpgKW6TwnqtL3I64DDCDFCgsF
X-Google-Smtp-Source: AGHT+IHn+z3k+py4UVKTT73n+eHw2Es3sDNz128MEDJ3zzb3n/dn1oWz8gRzbMhU0oCuzm6/uIBFXg==
X-Received: by 2002:a17:903:2a8e:b0:1e0:294f:17d3 with SMTP id lv14-20020a1709032a8e00b001e0294f17d3mr660549plb.5.1711529624925;
        Wed, 27 Mar 2024 01:53:44 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e383-3566-013c-5a87-9abc-381e.emome-ip6.hinet.net. [2001:b400:e383:3566:13c:5a87:9abc:381e])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902eecc00b001e0501d3058sm8356848plb.63.2024.03.27.01.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:53:44 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] ARM: dts: aspeed: Add the AST2600 WDT with SCU register
Date: Wed, 27 Mar 2024 16:53:28 +0800
Message-Id: <20240327085330.3281697-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240327085330.3281697-1-peteryin.openbmc@gmail.com>
References: <20240327085330.3281697-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AST2600 Watchdog Timer (WDT) references
the System Control Unit (SCU) register for its operation.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 5f640b7d6b6d..2f7788f2f153 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -558,23 +558,27 @@ uart5: serial@1e784000 {
 			wdt1: watchdog@1e785000 {
 				compatible = "aspeed,ast2600-wdt";
 				reg = <0x1e785000 0x40>;
+				aspeed,scu = <&syscon>;
 			};
 
 			wdt2: watchdog@1e785040 {
 				compatible = "aspeed,ast2600-wdt";
 				reg = <0x1e785040 0x40>;
+				aspeed,scu = <&syscon>;
 				status = "disabled";
 			};
 
 			wdt3: watchdog@1e785080 {
 				compatible = "aspeed,ast2600-wdt";
 				reg = <0x1e785080 0x40>;
+				aspeed,scu = <&syscon>;
 				status = "disabled";
 			};
 
 			wdt4: watchdog@1e7850c0 {
 				compatible = "aspeed,ast2600-wdt";
 				reg = <0x1e7850C0 0x40>;
+				aspeed,scu = <&syscon>;
 				status = "disabled";
 			};
 
-- 
2.25.1


