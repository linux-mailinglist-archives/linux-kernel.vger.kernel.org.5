Return-Path: <linux-kernel+bounces-26217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A83782DCF3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3D928268B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D55617C6D;
	Mon, 15 Jan 2024 16:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGV4R376"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7050617BA3;
	Mon, 15 Jan 2024 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d9b13fe9e9so6946378b3a.2;
        Mon, 15 Jan 2024 08:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705334783; x=1705939583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFjfBuQ8gREaq4FYxrLGf+324YZ/SzYtv7HMcJo8OiM=;
        b=dGV4R376ICDmCQn+pbRycYk6b3wIyBzY7jijNawbQgXXxkTE/FSd6xOoAdaMwfIcpH
         7akwx1kza2NI6111uriHjvoQZG/UZe0XN6hkpiyADJHOuXx++C35agxJTlWLQhmxgF/W
         HcxTYce60B0wkJ50sUuc5npiY0UTEsq+vLnDmS/WkS7FVUSzc63XoHeuXIuuSxaajtEk
         4gBzWxUOdKfeSZ+kMAYXBGrFAkebV+mEtEUCcvLofMykLTeulasTB1wgaX7n99q21ju3
         9Sn3hgs5Iih2cZ9Jb5+St7j0lCvHLXL3oP2QJgB/CtI9H4jWIQ6oWUPeWd5LJdKHI1LV
         NLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705334783; x=1705939583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFjfBuQ8gREaq4FYxrLGf+324YZ/SzYtv7HMcJo8OiM=;
        b=vNoyTtbC9AdYJ0b/JzGCP44n/SSH3laSSmx0vW28gaiz9/MdbftjVe3Cju1gbsv/EO
         pO7vd8/vULU9vJ0PTLzcHUy4D0pCXHLM9jW35BO7FDvAAePSFEMDfQ0YlR4F5QBs6xuU
         43gwv6+er7SaPToC7CscA1D9GT4XjOYt2py7CEuUewtk2n7m6GMkMQaJALskIsEB7DeW
         g/na088G4fgx9TFDHWgWKfTJXfcYyXR98bN3uSqMChsUVpEahEwEOv/ft1zAY62NdLVX
         H4K4m4vr3POPJFVddtY52MswBE0xF8KQJU4+TGqecoNq0sjIFfS/mVP6O2hTEBDW/xHX
         wtQA==
X-Gm-Message-State: AOJu0YzPRA20AW1SInee60vqjPEKgC6EcmxUWrP1oZJYYHBJukIW8wzY
	4bUoBY4xid7iU2vQs/yg1fw=
X-Google-Smtp-Source: AGHT+IFKj9mSl4b8I0aFzy6SsolLQ9h6pIbeCtf+spzb47O3C8OybzpfLNS5qaDEzORGMAY8PuH/4w==
X-Received: by 2002:a05:6a20:d392:b0:19a:9e3c:e98a with SMTP id iq18-20020a056a20d39200b0019a9e3ce98amr6370013pzb.21.1705334782493;
        Mon, 15 Jan 2024 08:06:22 -0800 (PST)
Received: from localhost ([124.131.233.112])
        by smtp.gmail.com with ESMTPSA id n27-20020a056a000d5b00b006d9fd64fdcasm7757783pfv.37.2024.01.15.08.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 08:06:22 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	dlan@gentoo.org,
	inochiama@outlook.com
Subject: [PATCH v6 3/3] riscv: dts: sophgo: add rtc dt node for CV1800
Date: Tue, 16 Jan 2024 00:06:00 +0800
Message-ID: <20240115160600.5444-4-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115160600.5444-1-qiujingbao.dlmu@gmail.com>
References: <20240115160600.5444-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the rtc device tree node to cv1800 SoC.

Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index df40e87ee063..66bb4a752b91 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -119,5 +119,17 @@ clint: timer@74000000 {
 			reg = <0x74000000 0x10000>;
 			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
 		};
+
+		rtc: rtc@5025000 {
+			compatible = "sophgo,cv1800-rtc", "syscon";
+			reg = <0x5025000 0x2000>;
+			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc>;
+		};
+
+		por {
+			compatible = "sophgo,cv1800-por";
+			sophgo,rtc-sysreg = <&rtc>;
+		};
 	};
 };
-- 
2.43.0


