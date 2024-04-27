Return-Path: <linux-kernel+bounces-160807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C398B4318
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C178284801
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CEE249ED;
	Sat, 27 Apr 2024 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="ZEaWsCQO"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055218F6B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714176661; cv=none; b=ACXkA9spDkoMWPDPlJ57WPKXaEY/Dz2a5Kw+Qju9G47FQvUck/qE7IlSye7KHgTrZ/iyIvY+H+TBAmmqMZd8JbumcxE9joPcCGCbjy8zn3bP45Ikc7FDD7Enqinf7GdCyvAECqnMzema1W8ldBYkVdOvwAuE8eYGpkvg07R4aHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714176661; c=relaxed/simple;
	bh=Tkyi4QZD3iXRNC9I3Th5GPUlpVYoVqpI8o+66sXr35M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lwzQR76REAEwmG3c7tUNaV69tFUrFFxybCRxnE3l+GhNGP8LwI88z5a33keAYMrbU+uEoSrGMpPQxCCaVqAvSrmqsDg9XhMNIeJbpU2osfISjbRaq1k0MMqdwwJ61GCDvTXs7m77RmqpAxaXLgBXnGZ9XADZaRAlodbLCNRIRW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=ZEaWsCQO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ecff9df447so2725297b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1714176659; x=1714781459; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/8O6an2WdHxxonYSgEiYeduIeqZHNZdg71uXcAFpLM=;
        b=ZEaWsCQOKbQrHKEahRxNjkAw4POlRtwAg5WzveZXle1mzvVjAFFx8ypeWEnULdLPkK
         vMPZRgg3R3eDWlf58X2wWy1BgMfAHgosmBq7/FPse8tB9NOFGPFxIHvgckdRQWl/iEk4
         9chfebcre6ViKpJ9ZTmZsEoHjijNkoDMLiXs9ZSQpUP53dpZY+UEPnRexqxlPPUyxDYC
         dwtkLdN9glE4s95b3M0Z8XhPHFSRW/8snwVQaZF5rkH9Gv9RpNSY4DZREWi46UQ0diTt
         uzgyL38cSiCca3Mprw0qule2MyvGmp7GJUJ6906Vl8HNMDe/PNHm/wIpjWrIfKzTXLa5
         dqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714176659; x=1714781459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/8O6an2WdHxxonYSgEiYeduIeqZHNZdg71uXcAFpLM=;
        b=X7VNPfTVQYkFyXK4S35Ry6PUKdCB7FzUzmQlF/2bkxOjqaZWKZkxQclxO3aE9EGYfr
         U5vQra9iy1eyGTDBp7EYrgQTGFtHRSiAiWCXkxcQT4MGNtx4yJjiVIQhKF4+/tM7kr9m
         E8Z544TxnciBPTkl91FZZ+5alfDQYiLMB9WYPYv5XUWRFgrTEpNQLBUj0Kov4TT7ApnP
         SXc9a5fNXFYngrMw0nzj3IlBFe2/k2EI/mntK/Nz4eeJkzmPYJZGWpb3hSKWCCI/yspO
         cpMpU6r8t9qG8rzH4HoeqnGkOIS/EEaknHPGttqsldiutdA/+fu2n8q84UaSLqhG3VWs
         cnxA==
X-Forwarded-Encrypted: i=1; AJvYcCU5zz8XX2/0HjHqrmWk2iOWEWTU1juLfLz3E5BcqopnZ6t1WJr4WVHTrr6HPQtqWNbEW/Kdf7LsjlYrO38rsksYRsC7lYoNnGsbbZi7
X-Gm-Message-State: AOJu0YxFKSgkNGf0mi8XPqyQf2AaaHRufLx7knM/NRibL6QuObLIRAZh
	d6JflTtkzsRP+kHAagFW5HtZQ1N+qYVrXRUw9CFPLXJ7KL2Tc2znWQ1xjQO/gqsSnjVST2UhAMz
	4Wgk=
X-Google-Smtp-Source: AGHT+IHYGANP1t640rQDF4TNy0DIxIquUVdYZoD1tRH1yjH88XxV9oq8sxkuJD55TgcVLJd3G3z2gw==
X-Received: by 2002:a05:6a00:174a:b0:6ec:fdcc:40b9 with SMTP id j10-20020a056a00174a00b006ecfdcc40b9mr6286127pfc.9.1714176659410;
        Fri, 26 Apr 2024 17:10:59 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1802:170:3569:7ce4:94b8:1691])
        by smtp.gmail.com with ESMTPSA id w1-20020a6556c1000000b005f3d54c0a57sm6061883pgs.49.2024.04.26.17.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 17:10:59 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Fri, 26 Apr 2024 17:10:37 -0700
Subject: [PATCH RFC v2 4/4] riscv: dts: thead: Add clock to TH1520 mmc
 controllers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-th1520-clk-v2-v2-4-96b829e6fcee@tenstorrent.com>
References: <20240426-th1520-clk-v2-v2-0-96b829e6fcee@tenstorrent.com>
In-Reply-To: <20240426-th1520-clk-v2-v2-0-96b829e6fcee@tenstorrent.com>
To: Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Yangtao Li <frank.li@vivo.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Drew Fustini <dfustini@tenstorrent.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714176654; l=1420;
 i=dfustini@tenstorrent.com; s=20230430; h=from:subject:message-id;
 bh=Tkyi4QZD3iXRNC9I3Th5GPUlpVYoVqpI8o+66sXr35M=;
 b=i3zE1I6IyMOXFj1bKYUcSwl0Q+FnHv6uXONEvzmZvhfqQFzAPv6ylEPDFIVtUnS30Bx/yo+p2
 EZ3wEbt1Ps4A+ZnwPmEdb/PCw8a64vl7uB541tl7Q8wYln+VeouGe4d
X-Developer-Key: i=dfustini@tenstorrent.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

Change the clock property in the T-Head TH1520 mmc controller nodes to a
real clock provided by the AP_SUBSYS clock driver.

Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 6285cdf91bd6..a6f51ec9fb55 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -324,7 +324,7 @@ emmc: mmc@ffe7080000 {
 			compatible = "thead,th1520-dwcmshc";
 			reg = <0xff 0xe7080000 0x0 0x10000>;
 			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&sdhci_clk>;
+			clocks = <&clk CLK_EMMC_SDIO>;
 			clock-names = "core";
 			status = "disabled";
 		};
@@ -333,7 +333,7 @@ sdio0: mmc@ffe7090000 {
 			compatible = "thead,th1520-dwcmshc";
 			reg = <0xff 0xe7090000 0x0 0x10000>;
 			interrupts = <64 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&sdhci_clk>;
+			clocks = <&clk CLK_EMMC_SDIO>;
 			clock-names = "core";
 			status = "disabled";
 		};
@@ -342,7 +342,7 @@ sdio1: mmc@ffe70a0000 {
 			compatible = "thead,th1520-dwcmshc";
 			reg = <0xff 0xe70a0000 0x0 0x10000>;
 			interrupts = <71 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&sdhci_clk>;
+			clocks = <&clk CLK_EMMC_SDIO>;
 			clock-names = "core";
 			status = "disabled";
 		};

-- 
2.34.1


