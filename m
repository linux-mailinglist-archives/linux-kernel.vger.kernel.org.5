Return-Path: <linux-kernel+bounces-101350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91B687A5DB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3881C21C10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A6C39AFF;
	Wed, 13 Mar 2024 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgER+0n2"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFE536AF3;
	Wed, 13 Mar 2024 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325723; cv=none; b=HmUC5Rvaw4W4L8qYVif5P4jX6XpsZGFhbruXa88fAXQTZSnAJRQ38PW0QLOA+UpN6d8BxCQp0OmKmgGvaYjIGvBRjpKCaixPlhsNFN8lu0wTX8uoWrHWXk56QToQwWoD/Tarwv0/76NFGNS/dxFQqSRVzQZn8kgiD6vRzfCFI6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325723; c=relaxed/simple;
	bh=iNqqPDu0+YCap1NuB1tRCUwk4XGFtYWN27juh+mnM8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T7xRyDrJE3IAJme+QajDcb5OLpyLjWM2EMlHz/lzSh9ZB3NQOHIG/ThJslyoAqS1cuWAgyCxaH5XG2wCJsGLJ6rEUw1ZMcuRgxaXXj6W0jgcR5iFXug/xkzAQVGDRgQ2LLaFx96kRmyygAu2/nUv34cfQlTJ0sZ4ePmgWIWQgrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgER+0n2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-413e9965782so2707415e9.3;
        Wed, 13 Mar 2024 03:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710325720; x=1710930520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e2HK/laxxSeo/rIXohsO/4GruamlzcDdBzwhbrpKEbU=;
        b=WgER+0n2g9PXKjlt4WspSngP7suay1EUWbCuutJBsS1IRbjcBgw5w+KeUcDV+i5YgT
         VcoKWw7LF3+psEw1RCWG9wX3n3GVSvFWtZKTDqZ5dRZk+i1QHZxg2k5UnXgsDhkw9CHE
         tfAv/oMMWE2bWF7bGjrUUWE0blafBFlu3OYl+nbV2q4nVt4yKc9AKU6749OJO+A3od14
         UfY2DMhu2lQuGZ75ZKG/hbWSmB1gvltuMP9uAZ+CsUL8vajgG9XDMp3lfBabJA66P1bM
         +9+SBICOtim5dfdpf/sV1LrE4ghbvEWNaw+tTbXrcQVNlwEiDXoWi+KwPF5+hfsl/bbi
         IYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710325720; x=1710930520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2HK/laxxSeo/rIXohsO/4GruamlzcDdBzwhbrpKEbU=;
        b=dxDHAW6RuwJm6Eqa5F4UzZdcelc5lxFi4/My3WViSpPNYjFUjSOXdnuOs6BueKLNkT
         HBgl9RuFFs4h5AufO7cfkT938kLlqEqQAUSZEShdEzlFTF++K/RCshA0bd1n84/ajDlI
         gdo5djgqhRpBBR+AbsNor0m+Xy6igBg6mc//K9Qow0THEZtb4wzHoxsBGwZGKAUrSk8H
         TcVr8NfvL9s29BU00th5z9LpbaPzP3O8QOzWAfRsNxHgL9tAsMRT5Rt7tpdIy/W0DwPC
         DTmYpKd9X0amq6UlY3KZ5+MVJzlAmppQEgnmFqrsYH+hA2rYvYifssbrotef9k/uPGPG
         TRRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG4uB4sbSBNm5CBIhOV0dUZdmPo1FoXwOfchIM7bViPwqMy4y1OrXDgkN6TcgUdmi8RK5oSW1Jw9ApQaXoL+TDeMKb0+vDqZMPKt8vGucXAh57+rpQACtKBG+tmtrMHre6iojVE193qTfTjaeHq6wCj8nSySWtqehR6/mjHRGUrOgaXWX3aXU=
X-Gm-Message-State: AOJu0Yzeq13EeA/zRIDknj6zEVE8WOLmzUgo7KfQ1b/h6I7/Uebs4294
	+KnQVM/4nYb2rGO0JKIipGZXLoBJQm5ti1OJE2hbLEFQPME2cts=
X-Google-Smtp-Source: AGHT+IG+NpDQjqnFAxgaibjHA7PJtqRlWJa1Ew55FIDwaKyUH3L+CC4q8Sydc3PvvIdcOiGE7fxdLA==
X-Received: by 2002:a5d:4ed0:0:b0:33e:75e4:d410 with SMTP id s16-20020a5d4ed0000000b0033e75e4d410mr1459487wrv.22.1710325719589;
        Wed, 13 Mar 2024 03:28:39 -0700 (PDT)
Received: from frutis-latitude7490.lan (public-gprs367196.centertel.pl. [37.47.65.157])
        by smtp.googlemail.com with ESMTPSA id c11-20020adfe70b000000b0033e41e1ad93sm11333360wrm.57.2024.03.13.03.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 03:28:39 -0700 (PDT)
From: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>
To: 
Cc: Robert Marko <robimarko@gmail.com>,
	=?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: ipq8074: Remove unused gpio from QPIC pins
Date: Wed, 13 Mar 2024 11:27:06 +0100
Message-ID: <20240313102713.1727458-1-frut3k7@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

gpio16 will only be used for LCD support, as its NAND/LCDC data[8]
so its bit 9 of the parallel QPIC interface, and ONFI NAND is only 8
or 16-bit with only 8-bit one being supported in our case so that pin
is unused.

It should be dropped from the default NAND pinctrl configuration
as its unused and only needed for LCD.

Signed-off-by: Paweł Owoc <frut3k7@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index e5b89753aa5c..8bed34174460 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -349,7 +349,7 @@ qpic_pins: qpic-state {
 				       "gpio5", "gpio6", "gpio7",
 				       "gpio8", "gpio10", "gpio11",
 				       "gpio12", "gpio13", "gpio14",
-				       "gpio15", "gpio16", "gpio17";
+				       "gpio15", "gpio17";
 				function = "qpic";
 				drive-strength = <8>;
 				bias-disable;
-- 
2.44.0


