Return-Path: <linux-kernel+bounces-37703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5C883B420
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B8E2891E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C67136678;
	Wed, 24 Jan 2024 21:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Efpg5Jh2"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7924F135A5A;
	Wed, 24 Jan 2024 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132222; cv=none; b=bjdUvnPhGAeDBSFwAHl6mQUXXGREgtLQ5HGMKxXyQeAOgQHSm8Dcz1sPkEdSOZMCJCOEPYj5Y7287TgvMPT5g1HKU/rIVHkz78v15TJRqdfbG+hLEm+cNX+xqXSSRLlUuVYSdE/mo/Ck+lKAibtBSkLKfE2kED3ErKgtOmvOpuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132222; c=relaxed/simple;
	bh=AOE7n0KnewlaWwxbj8BBqxz1kEl4nUkcJEnkd3Rd1CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UimU8fQzuxrtNAS6MO9PTGVm3MeiSGr7MSI30PSL5xzKcspHmpLNVaJnY0iFoXBfrHJnQDB+Xln4Y6cR2vJA2T1ckuUcScAvis1GnYV2IgOX2DG85D4rwsSPe70qAhqjJDYieoz3Y0n9McE7rCF13W19WOJ/sR2yVt3ctCS5J0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Efpg5Jh2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d6b4e2945so70792175e9.0;
        Wed, 24 Jan 2024 13:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706132218; x=1706737018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Q3Rs7PU6VZ7DHw5oiGFQEWFBt/lSJt0fN7k2NTIpww=;
        b=Efpg5Jh2jxgCenaxgkIf7I/hW4yDtYNkk4j+q3gR0KoBae6r7dRYhTycs2sIiEOb9i
         QRWZnyWObpVrvH/2D7a0dz87cVmL3UFLwttAaMG4ElAZ923VX1sOW0Xz1NXupU5L05ZE
         CzH+7bU6c9bpBh5H0ZrKl9igdNOpiXVIqrMIMix0P0QpjfN1YiBW1a47E4mdWoGFzY5T
         KlqskRpvdyS6iANyJxUta+lpDr4CCWfCq+8URKviifYrMuxW1R0nsWwmHwmiZgRHJ5gn
         dwM/hck0zc2okkn7Dzz+QQu8s+w0jigCwqjXXYsNGQfBGGmT7JEKtM3M3SFWAQrGwGQw
         /vUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706132218; x=1706737018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Q3Rs7PU6VZ7DHw5oiGFQEWFBt/lSJt0fN7k2NTIpww=;
        b=TpPb3uU3FDV0b1BYYLh6T0m5SOTBq3AAp6NmPbPM5l5soCkcZJRbD4zquJ74Rj6Wl7
         kP6AHRnCbzphSy/mG69N0Oscxw5piJdvjRP1rx1ZQIQC4iY8ioBGwC+HrER0rNu0qzf2
         zkzhKr2MrYskVz9OFFrvhB2p4V6dKW84dtQr2ydvfJBIFanYuyWpizffw3SRmrTKvwWb
         6K9bC44qWtsf0uGdFWpqxVKIZpxAY/W3iQOWbw9xRdaU4mDaZMEy2IvknLqsDc/YTmMu
         7ps6TxQR75yNt9CWvP9dgblhIaFvrXiHi1JRETvbjkLTx2xx2EChYQHLRux9DKdQpW16
         pECw==
X-Gm-Message-State: AOJu0YyuPAHESjRY36cpv1C6lVn6GL82tgCl//oMYrBctyvl8bNhZRq3
	LGRG9aOYERhwI0+LakeVudILEAC/P++fC0wYowr/kYaIVl73LUmo
X-Google-Smtp-Source: AGHT+IHVdLu49ZheFyem/UbrZMcfgbfgZrLaOQv3BosrNO5JqxwttVmSuIpI0HNxLwOfbIJey2JX2A==
X-Received: by 2002:a05:600c:458f:b0:40e:46f5:e5ef with SMTP id r15-20020a05600c458f00b0040e46f5e5efmr963875wmo.21.1706132218200;
        Wed, 24 Jan 2024 13:36:58 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id q13-20020a05600c46cd00b0040e89ade84bsm339466wmo.4.2024.01.24.13.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 13:36:57 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 3/3] arm64: dts: qcom: ipq8074: add clock-frequency to MDIO node
Date: Wed, 24 Jan 2024 22:36:33 +0100
Message-ID: <20240124213640.7582-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124213640.7582-1-ansuelsmth@gmail.com>
References: <20240124213640.7582-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add clock-frequency to MDIO node to set the MDC rate to 6.25Mhz instead
of using the default value of 390KHz from MDIO default divider.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 2f275c84e566..08ddfeece043 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -264,6 +264,8 @@ mdio: mdio@90000 {
 			clocks = <&gcc GCC_MDIO_AHB_CLK>;
 			clock-names = "gcc_mdio_ahb_clk";
 
+			clock-frequency = <6250000>;
+
 			status = "disabled";
 		};
 
-- 
2.43.0


