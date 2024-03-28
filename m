Return-Path: <linux-kernel+bounces-122329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB74588F548
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB47D1C28565
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFFD28DA7;
	Thu, 28 Mar 2024 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnIBh5Xb"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BD93771E;
	Thu, 28 Mar 2024 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592563; cv=none; b=QUQQBmGJwh6XhuJ4okRPlkOsj8EAAz7kDEsHrduhtM3I+DpOQYwEqaa1ScQ/d4/OzWYORX+BEaaKtG2u1JvpjnG/XJbo8ry26HaMDRSEYP6ve+MAnE++0MVpohznNRPTwELiUNg2KisTtmXxKtvn90llm+N6I5WkwhEirnN1MEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592563; c=relaxed/simple;
	bh=i2IRRjTZyiYex34MyWLMNAUhtzs5XV3CN9xcafzB4wU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O+p/XWRpVXYRPVdZaeNN3VqZcsQQMcoKIrPRPojCYz4L7WwjNMGirlIEegxq15mO9Kut3wjlTC8eZgZzwxb0D/l248lOGxbMw+C6DzN/wpptNpwL8ZbTfKhfvDjInseHNNIqwpCa4u1g6BFzZQDPiep9ExXrMDwYygHZR/8pYEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnIBh5Xb; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c3bc867eaaso373141b6e.1;
        Wed, 27 Mar 2024 19:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711592561; x=1712197361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axYCeiGWmH5zGIGoROlm87X0Iv4FCoHgVdnjtyDTc9Q=;
        b=WnIBh5XbtbSA8xM2Fq8junhGrw7rZYYc/0VELW8mvT7ll236t+6kfxct6KZNJtMdP1
         PJPuG22p7fWoURlnAiUXORMzQVj9IOxqKQ45s4ReFJoR3qS9ZRvExvrLPd2ouapxickq
         YfXFY5RmFjYsOb5ezLkLFrm7OdMNLDhG/bpjB1YdKrCRhIL+d9iCjm1deNJb30YQqlRw
         Jfa8s/j/bLxln2ci0NbQoSKoPuQuD0FpRv0H5yRtld2Ia5Al374UVxfxTcsi27Db8sb7
         ie1hi45i1cBiWuai4G5Ak9a9lRX5suS5yNjFSvYWbV9scsOVxBy0k5A8o0I6nYfdjfwn
         B1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711592561; x=1712197361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axYCeiGWmH5zGIGoROlm87X0Iv4FCoHgVdnjtyDTc9Q=;
        b=Hk1UD6Qonjjyvd6soPc+Al/z56WfdCB9JOl2I2bZgzN2tSXYvcFSp/zzrB/gBJxGss
         SkXqmXv5kmYOpQe4NNE+ErEehd5TJOXYkSN8Ltoj5hmyWZPQ5n3CtvZuhW9bv2W2EpPZ
         o1jLq8HzUa87UT29zk9cb2Zm9VkxXrVs3+qksvcrTyNHCDqiGdvAA4MXSsAJduJUU1IT
         h5Q6gPyb4mUFekP4asd2xw/f6aooPzsi/dGeGzITyfuGN/e5rokbduSjxUuzADG7M32P
         ERbQZOhIN8N5TJu5YG1A8dwpl2wSKQnj56RAo1c9z3pWE6MbUEc3qz4e0tIbZX4JA3V4
         uwIg==
X-Forwarded-Encrypted: i=1; AJvYcCU80ZTbVlHoAmHb623EPle9UNUHrkCbWCeMZFKRDBBMfSMy6DnK87pwePjr9VXmN0SeDhAgAEVYIsPLGwTJGMU8mZDGMJMyv+xXhy8RojOMWiRDxZggAUfle5MZl9zjNbaB+lTVIVoPfh5Vrk2F6aZaIHnsL6lEUtZ5lilK+Zp5rATUTfd9WNSp
X-Gm-Message-State: AOJu0Yy2XCY8yu3T+3MENgFRMWCSGiFBNwjHXKPnTPPvmquWJZK4VQp5
	vEDL2QaemWKMVLkQSwHlU+ekAWmpFq8ayjVaSFqTTil/k6hR4/zP
X-Google-Smtp-Source: AGHT+IF/M2aT2iNp3ruFJkZVXPJ0JqQ59asv05qBqw21fy7twZ5ntMVtEyAWYGtrxsTVZAd3CYIWkA==
X-Received: by 2002:a05:6808:ec7:b0:3c3:cd21:8a07 with SMTP id q7-20020a0568080ec700b003c3cd218a07mr1833577oiv.32.1711592560966;
        Wed, 27 Mar 2024 19:22:40 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e355-7eb0-17c6-c47d-d4ee-f9e8.emome-ip6.hinet.net. [2001:b400:e355:7eb0:17c6:c47d:d4ee:f9e8])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78699000000b006ea858ea901sm229256pfo.210.2024.03.27.19.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 19:22:40 -0700 (PDT)
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
Subject: [PATCH v6 1/4] ARM: dts: aspeed: Add the AST2500 WDT with SCU register
Date: Thu, 28 Mar 2024 10:22:28 +0800
Message-Id: <20240328022231.3649741-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328022231.3649741-1-peteryin.openbmc@gmail.com>
References: <20240328022231.3649741-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AST2500 WDT references the System Control Unit
register for its operation.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 04f98d1dbb97..5fd12c057c31 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -410,12 +410,14 @@ wdt1: watchdog@1e785000 {
 				compatible = "aspeed,ast2500-wdt";
 				reg = <0x1e785000 0x20>;
 				clocks = <&syscon ASPEED_CLK_APB>;
+				aspeed,scu = <&syscon>;
 			};
 
 			wdt2: watchdog@1e785020 {
 				compatible = "aspeed,ast2500-wdt";
 				reg = <0x1e785020 0x20>;
 				clocks = <&syscon ASPEED_CLK_APB>;
+				aspeed,scu = <&syscon>;
 			};
 
 			wdt3: watchdog@1e785040 {
@@ -423,6 +425,7 @@ wdt3: watchdog@1e785040 {
 				reg = <0x1e785040 0x20>;
 				clocks = <&syscon ASPEED_CLK_APB>;
 				status = "disabled";
+				aspeed,scu = <&syscon>;
 			};
 
 			pwm_tacho: pwm-tacho-controller@1e786000 {
-- 
2.25.1


