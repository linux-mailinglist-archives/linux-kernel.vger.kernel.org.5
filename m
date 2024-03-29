Return-Path: <linux-kernel+bounces-125378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FF68924D0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0052E1F22A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0D313B58B;
	Fri, 29 Mar 2024 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSDHYXZ+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBD313B5A5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742724; cv=none; b=KBvYIKIly9eShbkIbAoWuCMqK1aUmDAWjRqLV9NK7XOb1KhTawhy2Q2iWSbXNi6LJPc1J0shw0D3qX5dxIelEFxjNy4ltLDU5DAm4dRX0Fj5d4ypMYYq2+ZUVU/o/4+8JqKJz2V0EsJD9nhrq7aod4SArR4MyXsAmf2EETcBEwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742724; c=relaxed/simple;
	bh=hT9xAw5IxdPaXu/5nnI+E2HWfqwsj6jyKMGvFE17uRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/wD8vRovjUO0IBt99vRK9AjP7j53Dlx3eLhyi9z3D/1PNW981b7mUjsE/ZsTpTNo2KfeodWOxIhFYKa+jMiTU2Z4o5/q/ds6JGNUWoKKUzw4iQ0wArk5bwMZC8Ww1dWAKxLpNcOuKziMMrgFbgKnUtOzNgQ6+FypNxYNDvK2Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SSDHYXZ+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711742722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=chv79W8KZV4FF91RJrZsjWXi3bo0UlBJqJ+YGhV9vI8=;
	b=SSDHYXZ+y752JCQexL/dyL5AtRXEhTf+sr2vrFlrZ22E7eFacuJGnsyzYM1UnqJI8qXjo/
	YL9vvyMAR4b4TEM16nEA94Ut8NjUxdvXwJESEzkcfzQpR/iFtzgVq88gakkemosRLw6Y1S
	GKm19Y75HL/iHCECxLs4oNOx1S7aMHA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-YLGIWRiYNlqA3Jt_uGFRtg-1; Fri, 29 Mar 2024 16:05:20 -0400
X-MC-Unique: YLGIWRiYNlqA3Jt_uGFRtg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29c751d57ddso1810824a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711742719; x=1712347519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chv79W8KZV4FF91RJrZsjWXi3bo0UlBJqJ+YGhV9vI8=;
        b=Acpl9ChR1IpHEkV6x822aAiuw3PTGMruaaw/479XAklDtkjqngokWyFYisdUNAzs9m
         I3qVHPX/9tfmbZrs3AdNI4wPgObVnKazY2ie1epCo2kNwgBqebQCGsRaOBRTx7ZoQQjR
         M2XGg0IOEbBh2L42tvV3wWCcavYvocjPzE4ZlANa9FtYhHJ5CXU49Q/OHTWSpBEWUbqM
         EoMiqmrfQhi7gPDYslmyTN50HbAF9FKgOxq3w3Ao4nTp7iAWllCOStjaOOErJSJ4uSaM
         7fr7fLuxNJgu0fXPgml/c1DhPgWHDxDiF+IfVvXnxiCQ8TC21E6pSb/pQY+hi0AwGtqT
         j6/w==
X-Forwarded-Encrypted: i=1; AJvYcCXmqmTPmbQ4BCmU7yO3W6WROn9wHfUlEBB9iClwj+tIvwmVjFOL+Cb2d/WKH0u4g461dO//S2mts1Vy+KcweOKR/6JdYjpQQiUsN+3i
X-Gm-Message-State: AOJu0YxOmJ0qSa9GGkPIQiPFbT17vivBln0IeLM2AIdlX6qOPFCX5oGJ
	SugO+KB3PU6tGC2lIp2Ziazqi5ijpSY7jhHuWYhJqqgAtBJ1fH3tBIKOYkLVPP6nfkaRtOG31Oz
	vqXuziW0RjGLU5gfnovK/NghFf5aXW66qYPy4u2+RG76efH0U+fjCCbHqMI+gNQ==
X-Received: by 2002:a17:903:2290:b0:1e0:b60e:1a33 with SMTP id b16-20020a170903229000b001e0b60e1a33mr4229112plh.31.1711742719438;
        Fri, 29 Mar 2024 13:05:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/BF0Y8M4+Q3wp921xNHu7UI9MEHoFLlOewsMWLujebRJ0bO50WafD/lpdLCKxaYaACz3mXA==
X-Received: by 2002:a17:903:2290:b0:1e0:b60e:1a33 with SMTP id b16-20020a170903229000b001e0b60e1a33mr4229084plh.31.1711742719151;
        Fri, 29 Mar 2024 13:05:19 -0700 (PDT)
Received: from localhost.localdomain ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090301c400b001dd6ebd88b0sm3830017plh.198.2024.03.29.13.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:05:18 -0700 (PDT)
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
Subject: [PATCH 2/3] riscv: dts: thead: Add XuanTie TH1520 ADC device node
Date: Sat, 30 Mar 2024 04:01:25 +0800
Message-ID: <20240329200241.4122000-3-wefu@redhat.com>
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

Add nodes for the XuanTie TH1520 ADC device node on the XuanTie TH1520 Soc.

Signed-off-by: Wei Fu <wefu@redhat.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index b7b7e950a7d7..cd6bc89a240c 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -417,6 +417,16 @@ uart5: serial@fff7f0c000 {
 			status = "disabled";
 		};
 
+		adc: adc@0xfffff51000 {
+			compatible = "thead,th1520-adc";
+			reg = <0xff 0xfff51000 0x0 0x1000>;
+			interrupts = <61 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&aonsys_clk>;
+			clock-names = "adc";
+			/* ADC pin is proprietary,no need to config pinctrl */
+			status = "disabled";
+		};
+
 		timer4: timer@ffffc33000 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0xff 0xffc33000 0x0 0x14>;
-- 
2.44.0


