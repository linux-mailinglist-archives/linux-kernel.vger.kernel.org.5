Return-Path: <linux-kernel+bounces-142198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE008A28C0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC1DDB258A0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE4253393;
	Fri, 12 Apr 2024 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjEd6huc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5810253370
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908992; cv=none; b=F6gJNs1cvRL8nOUB350mRgNZL+t5jPNdh8mVYZEsANWPm0KUOZ4mVMb4jBlgiec293s//AlBU2MJJt7+eC1+CaI+7rDOmS5AuxjRJnx7Mrhq1vGXh8MYk2hnBgVCurmA+Y+iCNHTaW3sjfjhFbh1waaRKxN2BaCu9K9uptisaMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908992; c=relaxed/simple;
	bh=7c1RQocUPxtNkMUYrXuz6Z5XrMBoGDR/AzBjy6t0JNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlsUjUaIMAH39o436CYRGkK+xqZaSQamcEYC8tTB/p2GQyWOyge3BW1IVCBZv3j73pXFZE8aVp+a3fcDbCiUFpXWg+d9bBPrrf/4OP6lFTZW+HaP2G3o4THdLZlodA/fLme5Ksod4MGPgA41ijDL8UMS/m+8TMTbbZn+zekhBvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NjEd6huc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712908990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PNPGi/LJLZ1f/UWkNAkdI7gt1aIfJVZxqk0hEY+zuuE=;
	b=NjEd6huc19pviT+tbLzv1wpA5c/GWissv+h1ozZZmNuzxBNQOnCSt6roLoJBHxMoOpfgzH
	fe+sc665ZNkCcn9RCTNtZa+VHyIGseGnxHEvBd88svH+Ls/Dq1T7DqC4vZ1/E8sSITFHRD
	sXQtPsUE1rIzJ/1ItIKIgxX+/ViD9uY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-gH4epgrTNWS-JbdwbRUptQ-1; Fri, 12 Apr 2024 04:03:08 -0400
X-MC-Unique: gH4epgrTNWS-JbdwbRUptQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a2fe3c35a1so641072a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712908987; x=1713513787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNPGi/LJLZ1f/UWkNAkdI7gt1aIfJVZxqk0hEY+zuuE=;
        b=WKnMoemNeeKUg5Tvj+gLhOOQoPaBlkpFAT3YH6rvJsNEfwzPPdZP9EvAss3oSmLUIA
         CULtR78flgiYFEpKANBDQolFV5YYPMCODVcUAAInfY1Ice84AoX4sERiQ2wtZ1JK5ifT
         cbtUTlQggYh2ENyv5hmF3Bzbg9ln1c7kTsEd5kzrbgc01WxKxOQ6cM8ITGSIeKBGScGx
         yn0wACqvUllgObudnRugEuz7NvsVNRQ69rXliqCAU0W+a0NhSsS3xzvLjEiTHSH+HZ9J
         7/zsoIpXkJQjpeT3en+nKyuvrllRSX2F6Oe7MSM8eNxj7v4AV3qDo+0bSQDu7OWNXFpD
         Ujgw==
X-Forwarded-Encrypted: i=1; AJvYcCU/KMa/5/y2nHI9lCv/4368IIDDYstHSoFaDFGE4OV62YXpEop2nwb+cpo2WEbqWaK/ClIoaxTgCLSSS/ZBMiu4qZN9FpDQNKlhohU/
X-Gm-Message-State: AOJu0Yy/T5caYBehlUlRjIP4v6SMq/pzUKoLXpnwJ+6g+bAP1EDyM0gz
	kanvDwvq2fjfmvDJkidJtnBIFpqA9hlMkoEIz5ysjaEUd9lxcIw7063YbYIoJEiS5fr3a3CZFmc
	3LnxtnP/xmEpG7oGNGStCHftnT2/YmHnzObzlQhd2G6m59Fr9nTj6gc/2USVkqQ==
X-Received: by 2002:a17:90b:3597:b0:2a5:5334:e223 with SMTP id mm23-20020a17090b359700b002a55334e223mr1616957pjb.24.1712908987666;
        Fri, 12 Apr 2024 01:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEXR+HX46H9j17BcJJXoxM6E1KRCiVCkfSB10IGeNquAnS6am5GYCSSbFBeb4H+vygzWBIgQ==
X-Received: by 2002:a17:90b:3597:b0:2a5:5334:e223 with SMTP id mm23-20020a17090b359700b002a55334e223mr1616944pjb.24.1712908987375;
        Fri, 12 Apr 2024 01:03:07 -0700 (PDT)
Received: from Samantha.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c9-20020a17090abf0900b002a610ef880bsm2601514pjs.6.2024.04.12.01.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 01:03:07 -0700 (PDT)
From: wefu@redhat.com
To: jszhang@kernel.org,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	guoren@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Wei Fu <wefu@redhat.com>
Subject: [PATCH 5/5] riscv: dts: thead: Add XuanTie TH1520 RTC device node
Date: Fri, 12 Apr 2024 16:01:47 +0800
Message-ID: <20240412080238.134191-6-wefu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412080238.134191-1-wefu@redhat.com>
References: <20240412080238.134191-1-wefu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Fu <wefu@redhat.com>

Add nodes for the XuanTie TH1520 RTC device node on the XuanTie TH1520 Soc.

Signed-off-by: Wei Fu <wefu@redhat.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index cd6bc89a240c..62e588dbc942 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -463,6 +463,17 @@ timer7: timer@ffffc3303c {
 			status = "disabled";
 		};
 
+		rtc: rtc@fffff40000 {
+			compatible = "snps,dw-apb-rtc";
+			reg = <0xff 0xfff40000 0x0 0x1000>;
+			interrupts = <74 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc_32k>;
+			clock-names = "osc_32k";
+			wakeup-source;
+			prescaler = <0x8000>;
+			status = "okay";
+		};
+
 		gpio@fffff41000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0xff 0xfff41000 0x0 0x1000>;
-- 
2.44.0


