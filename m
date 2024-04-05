Return-Path: <linux-kernel+bounces-132486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 605358995C2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914361C21C21
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB18286A6;
	Fri,  5 Apr 2024 06:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbC/ugPw"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FC6224CC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 06:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299594; cv=none; b=CCIKSmdKRiUBYfyQ43VmBE02/m7dMBLDqKJHo1xpgCenTkMNmn6twb/NeNzZYgAqDp9L5mgqX2RaRKVvUwamxBfJ2E/SaHV4RsCDFj157CbvvSLwISB+slzZGJ155Rd5o/ZCSZ1vHN9PuTmjyuTMtkZ6nVogkGyNT23beWo5LLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299594; c=relaxed/simple;
	bh=LoXd4uXAUC4MYCvOWelMgffMqJLLlUcM6jBei3hAM50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6zRFykw+ABfCvI3Q7dojOrBP6NakLdaOWZ6weJ57zfCEc3YUPAM94zOwkiwf2COh1yRbJ4htYe9V5Ry2DNv7cV0ns7PgNctDAYL2RDN2kEAZLE0BMAnPN0yA44/exMH9gZ6n+4BPduU1PR3gU/Q4glMsGKXQyNUCeyFHI5aGgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pbC/ugPw; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e2119cffeso1602768a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 23:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712299591; x=1712904391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+UqM3H8PVtmZJzWNwLXI8j0aa2hbrCpkSPJmFMLYHA=;
        b=pbC/ugPwUpGYPpiHdmRjEWtLQLfJuk+lU8lxmQ/vtYiAK2AQvWQnydqtAoMyHaGFAu
         D5VqPubONn8zaYzPit646tSgK+o8lSx6Av1Rx2uwOEV+mjGB83TKKkS9jgt6b1O4anIy
         um1cbdTOI0kQz3jC9k5rnTcEsvUpNrf93rAwN5gZxBTFBny8za58qY0bg8prmdxytKw/
         Ay46SnoBihdGqS5HzVtOOKNefvcRa0Mx7xQzBPMQYwB2R682xO+0SIXFC7aOeKI5omRh
         B0VnzlD2hcH36tL+GFYgsZWZNUo3QJORiT/j5kDpgvYVZb4ZlEsz9TUZgfuqsS8x2Izs
         1Qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712299591; x=1712904391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+UqM3H8PVtmZJzWNwLXI8j0aa2hbrCpkSPJmFMLYHA=;
        b=HLL0EqsjpZgdcu5zgXbP8k6QleIlWh9ibAQoATHHtfUW/WGPRHdZCSqtPSqQS9Q0Sz
         RAWHwbLU83x8fvyd7HtT2ermtDgCzZhrO6c07xxZxIh45hpIjDBl6HN+JmFbFrnYfG3y
         /WEME2uXvDrfOVHr9v8cnJhslR8Vhw6bXC00JuQr9kisE66Dh84QJg66Ftt5I3wsDMbL
         /kpOVaYhzK/yhhDaqmLRWF21v85owo9Yx3GyvjmMwCYMzYQ2ODr5qbv3jKKHtr8nudt0
         njWqrMFGBltHtwOeLvjoHyq+mq6pgre1hv2KIhLP6s801oL26PDELUq00WjKoh6We3CH
         r46Q==
X-Forwarded-Encrypted: i=1; AJvYcCXW8NtL38GycYfXUC7NanuwtpJ61aUHrCGLfy17dAgHHRNwXVpAet0WIO1N2LGB+JQG/m1/m1RuQjqQ/sUYQ36z8++ix1KPX/cMTqIX
X-Gm-Message-State: AOJu0Yyt+Pruugkz7BA9cf212SKfg5n4X7MoOjG8m50Fg9dJJLNhcht4
	lGLnNfDXmR3cMNP3DijW/aFhXUW0m0XJ3DDQS8q66M1KLCgbwYSlKTJj10sYVYY=
X-Google-Smtp-Source: AGHT+IGeVQQOsWD3RRp2nLjnTGbweeoIgbKqDmAqFoGst9o8fm+FI9kAswgJa9x35D6KWQQvPQfc3Q==
X-Received: by 2002:a50:a69d:0:b0:56e:2b0b:58 with SMTP id e29-20020a50a69d000000b0056e2b0b0058mr326730edc.10.1712299590730;
        Thu, 04 Apr 2024 23:46:30 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id en16-20020a056402529000b0056e310e6655sm278888edb.68.2024.04.04.23.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 23:46:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/5] ARM: dts: aspeed: yosemite4: correct Mellanox multi-host property
Date: Fri,  5 Apr 2024 08:46:21 +0200
Message-Id: <20240405064624.18997-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405064624.18997-1-krzysztof.kozlowski@linaro.org>
References: <20240405064624.18997-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"mlx,multi-host" is using incorrect vendor prefix and is not documented.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. None
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 64075cc41d92..1bd555a6c3ba 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -88,7 +88,7 @@ &mac2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii3_default>;
 	use-ncsi;
-	mlx,multi-host;
+	mellanox,multi-host;
 };
 
 &mac3 {
@@ -96,7 +96,7 @@ &mac3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii4_default>;
 	use-ncsi;
-	mlx,multi-host;
+	mellanox,multi-host;
 };
 
 &fmc {
-- 
2.34.1


