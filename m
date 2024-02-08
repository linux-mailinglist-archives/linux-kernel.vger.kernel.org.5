Return-Path: <linux-kernel+bounces-57894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3E184DEBC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D353B26B46
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4226EB51;
	Thu,  8 Feb 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w0/F5a7T"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB93B6EB40
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389488; cv=none; b=rUe4Rea4AAvnpyZD0PdrGq/z32TlquIMStkEkl7ula9G29L5q+b5dEBZgacoomB4ZTsDeXj0OMEVuhZKGRSlEB5QNotxt7WsHpKrhOWyT95pRr1fuknHamNabKebOxrCqQA9nMCSbc/98PYOqNgSlV1zPSo5DwwuKBfwS+GGAsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389488; c=relaxed/simple;
	bh=Emv88gdDG9pxYGUfTBsBEdEI0xWLZ5BnAsMkMUFkpJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mB8K1N0zdryYSVMtWwpF+mPF0VogNQVcLN5gcYNEDZTTDJ+hEYJx39OocqjhA0QZo15tW4lA8RiAQvBARmX1HWpkOKxoHS9ARg5rlz4jOSk6pvfoDHE3EDcWpjXULiRSdD21tleCwYLvYwb0+We0veZnEgCYIS3xbVentVh+Mms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w0/F5a7T; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33b586e38f7so284057f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 02:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707389485; x=1707994285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HNZpB/EZ4NWTASPOpVzKWYUje+5cX+UaG3ufU3H/M78=;
        b=w0/F5a7TbKesblU+ree8wYDdzBzxvEw1iuv4lGfzoRHBucwhqMv94I2PG3uuBX0q2g
         8EMv8xjG8FJRsV/8tEWuCgee5g0Bgg/dx5x+TUxgeDM4wE3OzeY5YlSSY9omZOoNRdyL
         bI6Ev/VBNfN7Qdmt8R6jbibBbSXQ0nn0TJU7t/MEcEP6QAJawAkfxWYvm25InbHTgTAh
         1ebSB7esvkxAF50aa7ysxxUSpCL4Nu/WjGjoBS2DKH+y4W1KPGBGoE3P+aNghB6WOlmY
         jJd2AWXD39T9ejQBXQf61gHHcj5iaquvjgx+qM5mHLp5JpA6kZjqAFdla9RiY5lenwYa
         2TfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389485; x=1707994285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNZpB/EZ4NWTASPOpVzKWYUje+5cX+UaG3ufU3H/M78=;
        b=s4WRig/5pNA/9K+Coso8oj3qjbHl0ixhjPP488vd7lVOL/5RGBI6c1ucgok8y34heU
         Y0vrHvoAxeZHAC3KEF2kk8U+TxQ4ppkHf9DLplcu9RM7vFnt+zrt8gHHIcb1T/kDIHkg
         +WNo2jwiRYNTo8gQ3wnoIEPJCTHmkWJkQieQcN6Jw2YZ1ukZMNYoxlF8VlJG6HzCy8sK
         eSeQLABWcRtPqZGsWc2+OJ5pWnLYiFFJxZ2KyAp8bZzSA4bV+srGUdkiTcait1hvBOnH
         hIMvcOIO3zk2oOXauC8G0DF6gyzkkTan0o1lqnIpNAydoY7+Two+BQMFpu2H+CWCmppP
         QgeA==
X-Gm-Message-State: AOJu0YzGOAHYotBkWbzOXHSCa7q8U02sdR3m69Fri65QXxYgH7Ih1U77
	vQ9Jq/AnDhU3LrLWqgXbkJ0Wo/YhYPRc8Hp5ATotJeS5HCS0YemU4gn29oBZV08=
X-Google-Smtp-Source: AGHT+IG/kpPi0hDLahtJf6Zl7iOAtwtOFLT5HQAwO/GC4rKQbHaL0ZIM+cfHVjTakOaZqbnsfVy1nw==
X-Received: by 2002:adf:b196:0:b0:33b:58dd:84c5 with SMTP id q22-20020adfb196000000b0033b58dd84c5mr941338wra.53.1707389485245;
        Thu, 08 Feb 2024 02:51:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnciD60jji026n5unEXbnYRO2wX370lNj1yfb2eMmvYIkCLxGw+Fw70zuIAxqIwi24cZ1WAdRcI7uIY0UxF7OLxdCTQdWQtrcshhfQrCT1hh+T3i+WDxBHinbKaRqXDMgMGpwYRQ4rHj2cilTvoZ4nefbgo/ukzC83fTvCo2JKjvh85F+QXLcmoX8GVVG+2QegkzmYrt4O85p/0e7O3eV2HeYKqR6u6100FEaASTf370aYyyLBUSyo40zeNg5nzIwTUg==
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id g15-20020a056000118f00b0033af5716a7fsm3328649wrx.61.2024.02.08.02.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:51:24 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	devicetree@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] LoongArch: dts: minor whitespace cleanup
Date: Thu,  8 Feb 2024 11:51:21 +0100
Message-Id: <20240208105121.128521-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space before '{'
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/loongarch/boot/dts/loongson-2k0500-ref.dts | 2 +-
 arch/loongarch/boot/dts/loongson-2k1000-ref.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/boot/dts/loongson-2k0500-ref.dts b/arch/loongarch/boot/dts/loongson-2k0500-ref.dts
index b38071a4d0b0..8aefb0c12672 100644
--- a/arch/loongarch/boot/dts/loongson-2k0500-ref.dts
+++ b/arch/loongarch/boot/dts/loongson-2k0500-ref.dts
@@ -60,7 +60,7 @@ &i2c0 {
 
 	#address-cells = <1>;
 	#size-cells = <0>;
-	eeprom@57{
+	eeprom@57 {
 		compatible = "atmel,24c16";
 		reg = <0x57>;
 		pagesize = <16>;
diff --git a/arch/loongarch/boot/dts/loongson-2k1000-ref.dts b/arch/loongarch/boot/dts/loongson-2k1000-ref.dts
index 132a2d1ea8bc..ed4d32434041 100644
--- a/arch/loongarch/boot/dts/loongson-2k1000-ref.dts
+++ b/arch/loongarch/boot/dts/loongson-2k1000-ref.dts
@@ -78,7 +78,7 @@ &i2c2 {
 
 	#address-cells = <1>;
 	#size-cells = <0>;
-	eeprom@57{
+	eeprom@57 {
 		compatible = "atmel,24c16";
 		reg = <0x57>;
 		pagesize = <16>;
-- 
2.34.1


