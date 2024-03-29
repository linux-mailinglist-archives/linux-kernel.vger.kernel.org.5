Return-Path: <linux-kernel+bounces-125379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD678924D3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4327C1F228E6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E09313BAF3;
	Fri, 29 Mar 2024 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4newtaO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8A613B595
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742731; cv=none; b=Mu8N3kBpIcTLV5LeqvoTrW6DsNNEnBU4bHaojvhRgBUUXODfGloszRNDKTwt/ONoX0fu9RFkUZMS5XaDUtABW2hT8BY+xmxLLdu80uqWSyOoJx+kj5pBXoPvpCh7f9geLKyWxNhNfwHPLO79Wd/AapT1x9HU9A/hwIJBwgA08Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742731; c=relaxed/simple;
	bh=x17cpD0ssTnsMTSeMcB6KMh78X6RtLqdVZUufL1mCUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaPdfBXBfF5ikjyIN/WTSxnIgWWAIgva5/fqdsoD4isF2wgQU2hAMup8qMsOpymxM1bLWrN21izHMonl26Zwl/Mcz4xXSAdDy5o61+z0lUukztEJw4x3yn9GXlcGuoollu7JxV6W+W7zEB4kn6Hi/nQHDLRfeqBGkUgksAlvNtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X4newtaO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711742728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pnNZnWrnFQuL9z8tKMfOjE6Als92KSQE2PBtCEWHcNY=;
	b=X4newtaO5wX0WCZiCkajXyReisASnGYCCWHrr4KXksMxc3D5RfGkldxM2LIRx5IlRJVOeT
	efqhMJkvrNKOSB1g5CY/BmzRCW7pB9R1elcW+0hoEEvIJrAFjdlcLRq8r6PSi7OP0laE0Y
	cQ6JUUxFuGjH0+mPwNOiFr5kRLigp7w=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-J8MkeLLgOUy3QXRXavBaJQ-1; Fri, 29 Mar 2024 16:05:27 -0400
X-MC-Unique: J8MkeLLgOUy3QXRXavBaJQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a039b47c5fso2556225a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711742726; x=1712347526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnNZnWrnFQuL9z8tKMfOjE6Als92KSQE2PBtCEWHcNY=;
        b=Y9Lx8kxgCooYoRCI3eKu5dpaXDNF+U7BKzDvmj5X/LbR8Z27qmKujQLC5lg7DDLwIN
         UvJ771ZYTO52UF2KRdSGsdDAdRD2wcLfp9uyZvqbmhpUtAyqg9+PPJh3+6uTWUGf+9L7
         +ZNM/kViFymkMAyA/iIBaWOisaxzJudi3Rgf7Ai/GsW5TPFGsXib6KodNj4fP9rTozag
         TbCGu0IK5lPhs/GsqiOFeed75VB2UQkjQkaKPVNvfAvgcjAp9tvp3vAbEn2aDjyhKQq2
         bCIqoKtORATre6e9QC/MYTErWlJ30VsgxMno6xHFGXLMgpeqCHpMCtHjQmKY0fDFtp+J
         igjA==
X-Forwarded-Encrypted: i=1; AJvYcCU9zc2cCgzAqQ8/3H/mshKHYAzhjWtEtdVWHk2C4jplglkNG8USYBlRppt6HALrJ4EhTeslIlg0eSHg1Pl3r81XUtrpI0xpG+KmwLui
X-Gm-Message-State: AOJu0Yy+9tm3miUBku+99O+YGFDG8smyY+VKsod0fZYDQkPJO2XzghvI
	CPEWAh7No93q9rza0ZFOxMLcNmRONfzjcvXnIddP5TVIfLSDdasII6vfWODyUJT35NSYmYSPvme
	zBVkgGuOUj96ypVmhS9gPgFX0NMqGPmdqsXRHXwLcdidYMgXmR0UMhBWEvux2tA==
X-Received: by 2002:a17:902:d511:b0:1dd:8ed:997d with SMTP id b17-20020a170902d51100b001dd08ed997dmr9174628plg.3.1711742726530;
        Fri, 29 Mar 2024 13:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJYw4jR0YEnb8pmE90nAgE4U0L687WOcBXmCkEU8q6jh3nVskf4AhRBUJH/lIDQYZgDuFnCA==
X-Received: by 2002:a17:902:d511:b0:1dd:8ed:997d with SMTP id b17-20020a170902d51100b001dd08ed997dmr9174602plg.3.1711742726167;
        Fri, 29 Mar 2024 13:05:26 -0700 (PDT)
Received: from localhost.localdomain ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090301c400b001dd6ebd88b0sm3830017plh.198.2024.03.29.13.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:05:25 -0700 (PDT)
From: wefu@redhat.com
To: jszhang@kernel.org,
	guoren@kernel.org,
	conor@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jic23@kernel.org,
	lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	marius.cristea@microchip.com,
	fr0st61te@gmail.com,
	okan.sahin@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	lee@kernel.org,
	mike.looijmans@topic.nl
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Wei Fu <wefu@redhat.com>
Subject: [PATCH 3/3] dt-bindings: adc: Document XuanTie TH1520 ADC
Date: Sat, 30 Mar 2024 04:01:26 +0800
Message-ID: <20240329200241.4122000-4-wefu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329200241.4122000-1-wefu@redhat.com>
References: <20240329200241.4122000-1-wefu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Fu <wefu@redhat.com>

Document devicetree bindings for the XuanTie TH1520 AP sub-system ADC.

Signed-off-by: Wei Fu <wefu@redhat.com>
---
 .../bindings/iio/adc/thead,th1520.yaml        | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/thead,th1520.yaml b/Documentation/devicetree/bindings/iio/adc/thead,th1520.yaml
new file mode 100644
index 000000000000..80890ce62810
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/thead,th1520.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/thead,th1520.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: XuanTie TH1520 Analog to Digital Converter (ADC)
+
+maintainers:
+  - Fugang Duan <duanfugang.dfg@linux.alibaba.com>
+  - Wei Fu <wefu@redhat.com>
+
+description: |
+  12-Bit Analog to Digital Converter (ADC) on XuanTie TH1520
+
+properties:
+  compatible:
+    const: thead,th1520
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: adc
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - status
+
+additionalProperties: false
+
+examples:
+  - |
+    adc: adc@0xfffff51000 {
+	compatible = "thead,th1520-adc";
+	reg = <0xff 0xfff51000 0x0 0x1000>;
+	interrupts = <61 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&aonsys_clk>;
+	clock-names = "adc";
+	/* ADC pin is proprietary,no need to config pinctrl */
+	status = "disabled";
+    };
-- 
2.44.0


