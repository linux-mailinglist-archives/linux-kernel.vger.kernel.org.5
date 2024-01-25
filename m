Return-Path: <linux-kernel+bounces-37998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E9B83B975
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB50A281B00
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC91610A10;
	Thu, 25 Jan 2024 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxfHavau"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A271097B;
	Thu, 25 Jan 2024 06:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706163108; cv=none; b=s/ASBjs53Rlqmj9LkcUIJvCgdBuuFC97KyfwDBlgOETyNLYkjGQ+3opKln7Qc9Tmcd/Zi7Vhy680vSt4BBJw3LS6mlOGTuyAF1JZ1JwmTRwsPT4ZHolV8ycqRZFqhY3nYBVb7O6ZFBV7c+HbXyE/s4v+oeBGamw6BC5aqaf+nrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706163108; c=relaxed/simple;
	bh=3MKR4/XYUSI2wrtdQulYwzqyYPi1R36yUw5pep9LgFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=raC8BMHKmcsCO7twVDpilbnFbEZNRJQFvPL3aCx+hNMpf3Y+fEIAY/O/hCC++L9RaNkEaXPvA0JqmhbtCNUiKBUnWS83YXalOFiBxxbc3GjEJohXr7oWn+tii9ZhQiRDedDx1j53PsysNzq41ZJlTc9yx2WZ9276giq+9Zkwi/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxfHavau; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ddf1e88e51so4800103a34.0;
        Wed, 24 Jan 2024 22:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706163106; x=1706767906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXs4eXFLnV8TiKAn9u+8OI+mgIAVMlsd0Rv7wG5W1mg=;
        b=HxfHavauiaEcdWopTxX9mvB2J2HWOs3YlyozrykYxspgziu+IkMHCIJ33ErzrRnzm9
         6nXDydU1fc7BxEP1Nald+xH+u9LGUH1hXdDcX4H0C8uzr6Ycq8q589HjfkDVmMiQLCVE
         z5PphFaSxEVGP4W3EFyMnmiR7GTH4NlLyHsLK/whAge7NQ38BP7Z8ZxWUFdz4/UaC9zC
         m+sRKPSXWOOUhE/S7uSfhhh+CysWV6hkL6nSAOC6AKGNcl22z/jtb8jpDvVVTcw2Q6nt
         bX6m81lmzYL7YEaPNJNKGn4+H44jTfZh/GhF5+JZgCtrad62l1b2UWSA0eL4cJ92zukD
         i5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706163106; x=1706767906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXs4eXFLnV8TiKAn9u+8OI+mgIAVMlsd0Rv7wG5W1mg=;
        b=mxLAN9qvlA82yVBvckN8f5P07hacfOXulSD0JXG7mUtYpwHMNJcSYTGPwgy5+UYc5b
         9RJnnqZjTzSL6nbWpvk/tBW4D3f2tLAfjpqv9vhBFy4HJhUrRm8uqzrB04ppYrOtq46N
         VWrWrYlsRItgg9p/BDzx7ix1f/+5wLJD4pEjS5cuznsrpKA0Poh0cL79b323mvSs8UFL
         xYwt21MUVJrnMD3EySvmV2C5BstPYpUzGLPIKWdSKd28K6MdOpEv4KXbaOIf89IsjOQF
         1Tj0/8d3K9JbOpKvVBE1yfBgB21KTBYA708TKFESWbR3O5jQhgT/3Q8WQTsUu19aWJuk
         JfBg==
X-Gm-Message-State: AOJu0YwhuFEudKwbClJiq8EUarsl1IerZ1Yu4e9hxY41bKVXNJ52P0vn
	G4fgJVgzCWJN929WkB6Gk2+w6gPQIoQhFsMf2cDIHZkPh2xdAWrz
X-Google-Smtp-Source: AGHT+IGPv8XWHmnipQpI8c9vTBTtdJ/LiW9rOnrrb8ZlyCZnBJ3lppf9GtyMaw27UoUrBTpiCfqXsA==
X-Received: by 2002:a05:6830:1cc:b0:6dc:12e9:f638 with SMTP id r12-20020a05683001cc00b006dc12e9f638mr440913ota.11.1706163105715;
        Wed, 24 Jan 2024 22:11:45 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id s18-20020a056830125200b006ddd602afccsm2886399otp.66.2024.01.24.22.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:11:45 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	p.zabel@pengutronix.de,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v2 3/4] riscv: dts: add reset generator for Sophgo SG2042 SoC
Date: Thu, 25 Jan 2024 14:11:36 +0800
Message-Id: <09cd6540365a44ba2f45062a6afd920f4f4a921f.1706161530.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706161530.git.unicorn_wang@outlook.com>
References: <cover.1706161530.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add reset generator node to device tree for SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 93256540d078..f59081d4f0ee 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -6,6 +6,8 @@
 /dts-v1/;
 #include <dt-bindings/interrupt-controller/irq.h>
 
+#include <dt-bindings/reset/sophgo,sg2042-reset.h>
+
 #include "sg2042-cpus.dtsi"
 
 / {
@@ -311,6 +313,12 @@ intc: interrupt-controller@7090000000 {
 			riscv,ndev = <224>;
 		};
 
+		rstgen: reset-controller@7030013000 {
+			compatible = "sophgo,sg2042-reset";
+			reg = <0x00000070 0x30013000 0x00000000 0x0000000c>;
+			#reset-cells = <1>;
+		};
+
 		uart0: serial@7040000000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x00000070 0x40000000 0x00000000 0x00001000>;
-- 
2.25.1


