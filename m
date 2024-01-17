Return-Path: <linux-kernel+bounces-28625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4447E8300DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC8B5B2288A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939B8125D1;
	Wed, 17 Jan 2024 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dIadjfOH"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4761118C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478190; cv=none; b=pjcc7elQLNthkHCIrJjAsJVNhxfk1BAMfjoPZYtfvbs27bSo64C4rULkRGwIFQCtOjKAC9X/PaDHqzF0uLNO3WqkHXjCiYrZvULCDEFSXnDm3bX3dn0Bc7JAhCWA1LMBSbZA4YBGTEETAKfjzXmwTwkPSMiMDwrTKUgYwkcv99w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478190; c=relaxed/simple;
	bh=ZMzYx2Elb/0rfmxVadiD7ZKAwxY3qPlagy8S8qz/ac4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=hAlY2ERMZQ72ee3AKDXia0n2E0hv1yTZ0SrmXzcYCnstYxdRk9Wp8JGInLHPGvkWtEk+49oGl/4CLgTw2J2VDxJmDND4e8yrKu/fUmEWPfB5VjrixVXJ2qguqmJAdR+h2AmPIMfWwx66MFO608yltGG6GcgBInXyaR3xYNJ4k9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dIadjfOH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5571e662b93so8852372a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 23:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705478188; x=1706082988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XwkSEcICpe+ea0RQFV2DwhY0p5bgvvp7tE8xUKgZWE=;
        b=dIadjfOHUTMOcFQyk1ayQUlQO18NH4cTgSbRtovSjX7masQU1HKRUffB7ZruAykeyi
         /yEOAnYxtLUA2KBxwkdDlgiYZDrnlISP70Eom9yc2VlLa6VDEHSsWsohyLET7Dj/5D/8
         RlLM15qT4jpqe+k/oi3lu42kx+KXZYnBpFTs3W/JxFEBZZfGSeK1NikahRTc84UWTG55
         1xobLfcVvzWNFIF3B/Qz2OJjcEn45FERdiNpHVs7FwOh9JmrItSIwtiG3cqPd/eiZFlU
         9cEXSIy57fwqAH1TSej6mH7Nha3e4UTMJSLFS0rXevV/jDXf6Zs/VBUJ1iXZjasysIwD
         wVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705478188; x=1706082988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XwkSEcICpe+ea0RQFV2DwhY0p5bgvvp7tE8xUKgZWE=;
        b=Fv9d1UOoOl63d3zPSntbpCEbqh7xALur33TbLpU47pgRfblJezNNjhsxix6br3MzB5
         XySdHNQEMWVsOnqLwYeef2qiTcnBnY/itjz49Pm3i+zMAFZw0RPVskdr2VIz5g6B+3oF
         W8PyOD/bUGG2nuHpJ0biM5i41FFXwVgIeQ5QpdfS21bQktq0MIlsovbWWgmwfAu0OzCo
         5Q1RTn4AChgYTck6Z30bqjqTpwTiaDwfy5WIQqyIgCFpa34T4TssFIOj6J6r9hmdaDIh
         p9n3jq/qnMfGk10lbAa0tVzMeOeSy92uBxqFYEjfYJBn7gyaQ77WUGP//qm1P4592gAE
         C71g==
X-Gm-Message-State: AOJu0Yxd7h/h6bW+87Yqyd2HIVmC8GmV3f/17wdOzogtvI3Y2wgcXPRA
	KWmmZRTK6Q1v+UWBnXWB6Ql8tguiyJ0IVQ==
X-Google-Smtp-Source: AGHT+IHkw9HZFsdb6DKFrLoeYbHMisIsEIxTQf5ZInpVZB2TZbqsfkwq85KIqoqU8GUl2wPwxTB3zQ==
X-Received: by 2002:aa7:d589:0:b0:559:ba2a:68ce with SMTP id r9-20020aa7d589000000b00559ba2a68cemr928382edq.41.1705478187767;
        Tue, 16 Jan 2024 23:56:27 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id fg7-20020a056402548700b005593c83bdafsm3911729edb.45.2024.01.16.23.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 23:56:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	=?UTF-8?q?Przemys=C5=82aw=20Gaj?= <pgaj@cadence.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] arm64: dts: intel: agilex5: drop "master" I3C node name suffix
Date: Wed, 17 Jan 2024 08:56:18 +0100
Message-Id: <20240117075618.81932-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
References: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following change in the I3C bindings, the "master" suffix in I3C
controller node name is discouraged (it is "controller" now) and not
accurate (if device supports also target mode).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

The change can be applied through independent trees, if the I3C bindings
change is applied.  Therefore please take it once I3C bindings is
applied.
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index d66d425e45b7..1162978329c1 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -202,7 +202,7 @@ i2c4: i2c@10c02c00 {
 			status = "disabled";
 		};
 
-		i3c0: i3c-master@10da0000 {
+		i3c0: i3c@10da0000 {
 			compatible = "snps,dw-i3c-master-1.00a";
 			reg = <0x10da0000 0x1000>;
 			#address-cells = <3>;
@@ -212,7 +212,7 @@ i3c0: i3c-master@10da0000 {
 			status = "disabled";
 		};
 
-		i3c1: i3c-master@10da1000 {
+		i3c1: i3c@10da1000 {
 			compatible = "snps,dw-i3c-master-1.00a";
 			reg = <0x10da1000 0x1000>;
 			#address-cells = <3>;
-- 
2.34.1


