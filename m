Return-Path: <linux-kernel+bounces-119250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA6988C628
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4B330686E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9C813C823;
	Tue, 26 Mar 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha0RCw0d"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1295E13C81B;
	Tue, 26 Mar 2024 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465244; cv=none; b=q1YEoar7Tfz39o3rhLDzmFahX9vW5AYlXCAqwg/o+EYmUqS6W9ZzdbdNFxvCA5tA2wjP62oNLDjdoaggoGdvtJtpvngg8u/yVCyCXMH78wwnV0jWgil2SmkYwH/NWHENQ8J+gzvEBUuX7KGnbq93ryF03OdGQ8iyAgou0P0SDQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465244; c=relaxed/simple;
	bh=OmbQeEpYAXewoGuDq+EgMFX3vG7k0YYOmneTwe9coEE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jknCEAyMaN6NOSpBP22lwjEzyer4y7Z8jstimFHT7JAUeglPcpEIhzDBKi6aOuHpx12T3WBMIVb2NO6a31gm7goshRDjlsaCMvGODea50yu+auwksoLMhm3j8YI7R7I3eZ8hHufO8pKyawfWJo5qb2VdG2Hm59W/oYr2yM4JP0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ha0RCw0d; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-222ba2a19bdso3497769fac.1;
        Tue, 26 Mar 2024 08:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711465242; x=1712070042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNSpu6YM8BptgR2qjrv8QihJHcI+7VsMuE3/EFlGmdw=;
        b=ha0RCw0dT2lnrmP6OHvYdaQouopg6ZDoCY449azy7VBRayhrudLKDQXRg/KN8e/J0f
         jhvxfwzlP5R/h48b79FlEiqHeWokKasFd3GmzOjsHxGcDBz9U534j5Xa3k5rnS8waJVj
         w4+f2XcOgrRyQ8shaRClrJA4LadYf5z/33CgEtR4gqbY2k8zJZHW5pLTXD6Z08y6h0nE
         feHvNV3P5Ki5m3K+bFVrf0ezZd6oywLxrznmgItSnZi0RMmoerNTIT7tpd42u3/a/CO/
         tw7TJh+UKpBUOnm6oYqtRFXjo0CTvDaHDnCWFs2JqvvUK2rmgqrvcLTsrIOA+oBONcnN
         ifJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711465242; x=1712070042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNSpu6YM8BptgR2qjrv8QihJHcI+7VsMuE3/EFlGmdw=;
        b=cYE+cCQduQkWfxUErUQF0p9SP2Cs+dU6LQAGFx3IjudtDVKLqvz2lzRd2NGeMMPDWH
         pe49pJfoY1BV9zkEDUeEEjnMiNO47MwUYkXNY21fK7cG0DmydofGv0uGk8uCSYdHjddj
         bG/MEUP4fcuYdLJiHVjofsPwWSL5AU6iK1fsPYujqEUtqVCHDWEsEbXxbTksENVs4gaY
         rK679j0MOViZAA2qIAcdm0mYlTCB3c4mYUE/okg4ylUjYWIOxizD4sEQkDUEn0mM4LX0
         f2RVMnfzbLYp4hj9d4xUaWjhh7uOdTZYYIu13uxdgEL3a4Eq2h+ax+LeDFRVO1SBlXA2
         B1zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz/szB2lR3/faqW8y69hsY7vhzuPd3TOunbDYubafI4N5si/iM6x4IoPWQJPOCF04NJAXuHw0V8KN+gw9hKXzX1/tbte6VBjcjcCJqCACDLYlHwMF09MnVXlnD04dev8RhwFp25Fabru6iyRBWZJ369Q20VLPLR5pao2wSF9sYKyeQcJG5PQjA
X-Gm-Message-State: AOJu0YzvPrNo2b6loLb2cNZgeJ6sVkkHxk0KeIygqEr0txSZmx4oA1g5
	Qo758ZhBwZyDEyWYzl3I4jbU20+jfeC/rbd97sdyT4fTQGq+nY/a
X-Google-Smtp-Source: AGHT+IG+eQB9Du+89O9YPqZUBHKoPkGBuBszCclR0pKdvZy2gkL+dMe3RVVwPqyf1FUChuKP+urjPg==
X-Received: by 2002:a05:6870:5693:b0:222:12dc:8af7 with SMTP id p19-20020a056870569300b0022212dc8af7mr11124988oao.59.1711465242163;
        Tue, 26 Mar 2024 08:00:42 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id l27-20020a635b5b000000b005dcbb855530sm7658404pgm.76.2024.03.26.08.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:00:41 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] ARM: dts: aspeed: Add the AST2600 WDT with SCU register
Date: Tue, 26 Mar 2024 23:00:25 +0800
Message-Id: <20240326150027.3015958-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240326150027.3015958-1-peteryin.openbmc@gmail.com>
References: <20240326150027.3015958-1-peteryin.openbmc@gmail.com>
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


