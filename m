Return-Path: <linux-kernel+bounces-132852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1090A899B37
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C7AEB2140A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408CF16ABC9;
	Fri,  5 Apr 2024 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgOkKTWp"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A6B1474DC;
	Fri,  5 Apr 2024 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314262; cv=none; b=a+kAfxibl/Fq/2Vj/u8Dmuvv+QUDq8P5duHWkYH80eYmZ9IR0cTNyrkaQIpLmNFpf3SqxO7ufVfbRqcbIl4GV+D1/lg3KNcKqGBM6wOUU33it0a4I5zuckAdUtbCRhT/sxrfcY012Ub4Zx97Wn23ee450TyRRefxwjhSCuygfOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314262; c=relaxed/simple;
	bh=5CmXyK3a1M7p1JQOO8iIHqCDHf58ftJ/qeYqUoA0OkM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AgDaHqHqAwPovpL6Stzr3jmkDP4ByiTaOVlEduzX3JNZH6mOuCSatU+WiAOGg3c551ZMPjmuUsa9LPGu70Dn3i+HIqeaDyob83xI7vw1TDgtBr104D/M3LLbtG2iT/Ra/OfFRKFMEha/xrmRT5G7FXFn8t9zIzhr0xQXRXl6v50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgOkKTWp; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516d16db927so1606945e87.0;
        Fri, 05 Apr 2024 03:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712314259; x=1712919059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=orLmA0U6SWD24u4F3d7lalRjfUDqxy5pYRcNZDhWsg0=;
        b=lgOkKTWp7hKDndJUe2i82Utgv8OoDnQrmRsZskKTroyvG5/hDi7Ie5oRbY9wseUsiW
         5NjGNVUJDFBH6kN2nyZC7X4JAAuzF+P0UGSTMWTdSgdRiyDwGWqvf6+QeAzdEv4zh1ff
         VbzwXqn2fu9K2eMTLygFSsVB5a78WwQpij/KAzPm6iQ6wlEaYmitjjWrqAO3yjaoDEW6
         yRmp+ABIkF0ulAJdajLEAIY1kLTcCdt4JThE3UuzM9ZrJ4jtLeKjDlbT3ikfhoEooHXo
         M2XNllldnZ4mxgixvZv2SO10RPMCQANf4THJ/vxFFKt62ZQAzlwdwjpp6KaOI3jlStgX
         L69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712314259; x=1712919059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orLmA0U6SWD24u4F3d7lalRjfUDqxy5pYRcNZDhWsg0=;
        b=n39h4+us0b+vz3Hual21jRYMbYE0pkJErdr5nQkrLTU6jggIUxBWc0+a4kRs8Eju5T
         iXmqt/oB5Nj8efZfkPOjHw3nbJC9cea4Po0u4T5GPcETC3Pxw7IAfLD4rD1nWBJ5YXHZ
         3hJFgEAG9yKj3PTIbc9QOfEYlVbNLvlspebuWcM17Gg2XcLORQGBoTwM+FQp/oIhLu7i
         PV/SMplEjZIoPDZXcCp2YJGuW+Jx1kBCNx2x+zaDVDMChSnYEFzJoPHiMiWhoSSjzLGR
         4Y9yW1kN2CugKPuTRptUTLlTqoBDOU92HDwI5IhCv1GZ+bum3k6dPkueOtR6jSRZfSW/
         R2hw==
X-Forwarded-Encrypted: i=1; AJvYcCUqOUl2b8mWi0Qcrh4J0ET8cJyqkioc5Xx7poxf5+eXr+jGHWSmX9csHpcOkbYJgxR1iPgWLh7CdFzbJRPKgsy/DE7Q4Jy9RvfGI2KJ
X-Gm-Message-State: AOJu0YzlWJA6W/jH5tY3DalDxHNvqCzPhEL8PkXik35L4pcr1wrh/GgV
	/qhANV63JibhUvkOrwFSf1ApuK9z9im6wFVNgGjfhtT5gUdIiJqL
X-Google-Smtp-Source: AGHT+IEX9qU7KVnW4TWbq3+NQWhG74pUo1ZDPBlJGnMZj77sXTLBLTRbcrw+V72NthRK3niJb3wyiQ==
X-Received: by 2002:a19:6915:0:b0:516:cc2c:6330 with SMTP id e21-20020a196915000000b00516cc2c6330mr729212lfc.6.1712314258526;
        Fri, 05 Apr 2024 03:50:58 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id bj1-20020a170906b04100b00a449026672esm697163ejb.81.2024.04.05.03.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 03:50:58 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] arm64: dts: mediatek: mt7981: fix code alignment for PWM clocks
Date: Fri,  5 Apr 2024 12:50:30 +0200
Message-Id: <20240405105030.24559-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Align "clocks" array entries to start at the same column.

Fixes: cf29427573cc ("arm64: dts: mediatek: Add initial MT7981B and Xiaomi AX3000T")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
index 5674ac81d1f8..8a6263cc569c 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
@@ -86,10 +86,10 @@ pwm@10048000 {
 			compatible = "mediatek,mt7981-pwm";
 			reg = <0 0x10048000 0 0x1000>;
 			clocks = <&infracfg CLK_INFRA_PWM_STA>,
-				<&infracfg CLK_INFRA_PWM_HCK>,
-				<&infracfg CLK_INFRA_PWM1_CK>,
-				<&infracfg CLK_INFRA_PWM2_CK>,
-				<&infracfg CLK_INFRA_PWM3_CK>;
+				 <&infracfg CLK_INFRA_PWM_HCK>,
+				 <&infracfg CLK_INFRA_PWM1_CK>,
+				 <&infracfg CLK_INFRA_PWM2_CK>,
+				 <&infracfg CLK_INFRA_PWM3_CK>;
 			clock-names = "top", "main", "pwm1", "pwm2", "pwm3";
 			#pwm-cells = <2>;
 		};
-- 
2.35.3


