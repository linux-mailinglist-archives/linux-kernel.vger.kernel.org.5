Return-Path: <linux-kernel+bounces-132488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783008995CA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3389928560D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD762C6B4;
	Fri,  5 Apr 2024 06:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ck7ggViB"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C3C2574B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 06:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299596; cv=none; b=I7yf18olcOFkrf9rfNHoDZOwTal4NfNFebQITNISURMAYyaQok61SIU8mhDXDfJuHqacmh5Ii6ZHpGcP2vrTBeQRbc1X5NwkKLiaQWNLUAK3KcrhlLjkCWf9Sf/VYiF24AEsXD9rKrpQgbQUe3RQXh8wUgMGUFN9OB1pcjMnoMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299596; c=relaxed/simple;
	bh=hpEkFx9qDzDs3gn2vXmzx5ZwmTcZ/C0FV+uDlcwNdiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BcpMD4NtES5HTaPoepkINiEr8D6dzekupepybGSFO3fHxJDrZdttHB/zxYuKEiCs46Psr//Z9z+V+OIQi2CCC9itVFGbcOlVdKXiOS4oeoEmGvcR2WBCRTIQyQeBghnOy/P8B3XoWCH4jeFpmf8KRpOVyGtCxpVB5J9t6rt9cYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ck7ggViB; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e2393b073so1799791a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 23:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712299593; x=1712904393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L03qktEe5BqKc8+hjupnXevOErFDWhALUB7ZlYJD1vo=;
        b=Ck7ggViBBCUfc0rz3OmGb5Wj1hHE2jSSB1KBEiVQ4nCnDi90/siNWSNSeyFAWEeHtT
         IBuWu7TWOZSWbqWh2Z/oeQKHXUmsvlkSIWpiO90aALQzRW/P27Dj+Htmv72Bhc6mPrX+
         ND6eN1/rKaJ0lu4i+ZFIlwBK6Vd3j8Wzj8//D6Qg7Qo/VMG3AGJmI6PeILb2CcudTfBJ
         Zf+wCjocyX1vYv5YxlUNEGwG0OmXL4Ghjw7WWkVAY3yYAM/JYEi8b771viXOYD11tFpD
         Vl1Vv3+o/YSKUVBu+UxDZMR2BDi4Gzw9DII6GafH/08ejqsrd/7D2uKvAiSzKHqho9o6
         IOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712299593; x=1712904393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L03qktEe5BqKc8+hjupnXevOErFDWhALUB7ZlYJD1vo=;
        b=ShvAbeGbOd6fHk76E04VqUcp66UAeXsvV+3S4K8aM0nln/l4suR3W9t8YlsXzfZr6r
         UjIcFtnTQYdpp0Qhx2nLXt+AMRlk9Bjj20P9vikS0yqDwp/iJM8rHWKiSXUeDf9plTNr
         ZCVBN9HcmQOjR/kWxwu18ajuZqj2RKcTxLLoScjaQjZoRKhNtRDbqz/kkp38fjUO3LED
         7gA3vsi9GgjNGwqKuTic0Mo42AmvVfiS65qAbgRV283ufSno/PyEOhOq1hXGCr5OMe/R
         S1GtAwXDtbFCo/oAX7fGY0OtL0XAhC4BgrwYUYrYTLPLqzBwUDqsqHM9mkC/FC9PAU6F
         OntA==
X-Forwarded-Encrypted: i=1; AJvYcCWbj24XbCefnpeJ3WPvBAbMbtgtelfLqVqRh5UHGzoX9OBxtb+Y6tkrRxpQAnzy3vEcaIVMOLocC0vDv+UsxXSEBy/tLieEXj9DbIsL
X-Gm-Message-State: AOJu0YyeMYalSJv8IzjhbneKdd8Ul+UsjE/51pi8yMaa2u+Vm+s4/xtR
	Pi63R3+HpKOoqEl3zovv/GnweAubeTvjNBPPUJuGtS2sdf35kk/zVVQUZ6SIz9o=
X-Google-Smtp-Source: AGHT+IHjmGROnu9Y1ix4apCPz2PhAt2PPjFja55HBstpjpgqzxLJBVjFWv5eRYdGN8y9f2GLmM9gRQ==
X-Received: by 2002:a50:cd9e:0:b0:56d:fc50:ec50 with SMTP id p30-20020a50cd9e000000b0056dfc50ec50mr759789edi.13.1712299593304;
        Thu, 04 Apr 2024 23:46:33 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id en16-20020a056402529000b0056e310e6655sm278888edb.68.2024.04.04.23.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 23:46:32 -0700 (PDT)
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
Subject: [PATCH v2 4/5] ARM: dts: aspeed: harma: correct Mellanox multi-host property
Date: Fri,  5 Apr 2024 08:46:23 +0200
Message-Id: <20240405064624.18997-4-krzysztof.kozlowski@linaro.org>
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
1. New patch
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index bbbab8023cd6..b2834399f3d1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -137,7 +137,7 @@ &mac3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii4_default>;
 	use-ncsi;
-	mlx,multi-host;
+	mellanox,multi-host;
 };
 
 &rtc {
-- 
2.34.1


