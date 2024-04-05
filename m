Return-Path: <linux-kernel+bounces-132485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF1E8995BF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6813E286208
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D49323777;
	Fri,  5 Apr 2024 06:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sBtDD/I8"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E4E21A04
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299592; cv=none; b=UeBb+9+qg3SNVeZueLAO2NKB5nLAzyW8LPSVgRvrd4DCBhmtJa/ZZGn2bJ54O81Y2oqLB9KyFwpS1iLgE8UYf+iNHIVEFrkl6wpBRlf5lKEoyK99pbcXwcgkQrbujjBOhGcXtWbC/WBYXPszK0zFfi0evc7dnxv8Ek8Y23lgSRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299592; c=relaxed/simple;
	bh=l52rTRVybZqpYMc3LN3X9LFHBtAYJ/JGZ7TFovszzzE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RYgKnK8vgLliPQv6h9Zl3660J71Fx2+CqUClT+9Os32HrEsHVr6fO1SuNIVghVaniaI6ShPiXZJtRgijFSq/U3T6uLU02DkeeFdj7XGOhYxhZhFsVf1SkZJw/tVDl2BV4u45C4uwOEzVoWOAf4AMezUxp8LzeuntVzgN6WGpD2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sBtDD/I8; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e2e09fc27so663919a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 23:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712299589; x=1712904389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C88NRL8nmY+MoIB7uTpD++kTTD8uuIo9qZUpVy3NKUM=;
        b=sBtDD/I8X7tez0bjAPxQXL81sUNR/rhMoaY3RsD6SPBOKaCB9uq6oj9cqAhNEI/eQw
         V1gXp0WpJhhU1wyT6PYSoEKooKWIaI8mQuzIzdxSnYjKsrG2N7cDsK12eoRZbaPFszWS
         XsJmQgEwGKZRwWBi0j0cqQJ+KWaZpGsalyTKw9vFjt1WyIvFbt6okB20bcRXkFKsiY+p
         +losxh57qG11yFDN5r5srH4YhxByk2dK4a8IIt6CbqNpC2gZ2jSYOUYDN06b8iA+SaBI
         qZmd7izXFf9tafJDnaougWudHp/EPausRCqgwpWQm6BCi1z3dlxUio96A4+Cu75PitnI
         MVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712299589; x=1712904389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C88NRL8nmY+MoIB7uTpD++kTTD8uuIo9qZUpVy3NKUM=;
        b=tc/LeR6+nhu7dThG4L2KqAxV2UbbiRxy1WVuW4IaMJw4NH3JXojF4ZRZ4zyUjb5uRS
         gV6fi2qUiF5AKOBAesV+CELUmLXcyzKtmFaqpXaR1SDNLoGNJUC5UlTqEo2OlB8cQenf
         wn1Oba+UDaGTffUkoIuOQ5ARQUdpm6EsBISh8NUHLT7h4VMloU2yRSTuLrzfd+KvHnCH
         6HzLdzA+HU6ZUlOm8CA0LTbPukvsyIT5isyfKvK+8XQe7sVIuRxW6wM1+/bsBxI6Vb0z
         7WGG9xFiCtVtRxznJ9jH4IcjaCZC+ZFbb6PbMXr8+DkPVLn66FAir5kuGUP857a/A685
         CvkA==
X-Forwarded-Encrypted: i=1; AJvYcCVvETfow9psm/XtvkjC9Q1WNmyqzZX0dmjdwhW03V8aUGvqWCcUMbxsm0mmlx4MjLjbJ5JvcO+RVRSMjfx0CLXITKkW4KkfyuIy/9Pn
X-Gm-Message-State: AOJu0YxOlg/o4bIIho6RU4GV+7WaLGb1bF8+wvVoOmp8boLrMG3WZ203
	LEWmHvledjd7ALIZBbNXf+Ngch/qbDNuo9Iv6BeKeyUI+dfNie4qH4ot5HmbnWU=
X-Google-Smtp-Source: AGHT+IG1ynomuaxg2OaBpcGgD2b1Fq8zJ4ThG3lqY51F73zTrc0Y14wcLKO2TbXNzANaGR5Nd5O8Ag==
X-Received: by 2002:a05:6402:e81:b0:56c:292f:84da with SMTP id h1-20020a0564020e8100b0056c292f84damr1254405eda.17.1712299589341;
        Thu, 04 Apr 2024 23:46:29 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id en16-20020a056402529000b0056e310e6655sm278888edb.68.2024.04.04.23.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 23:46:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/5] ARM: dts: aspeed: greatlakes: correct Mellanox multi-host property
Date: Fri,  5 Apr 2024 08:46:20 +0200
Message-Id: <20240405064624.18997-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"mlx,multi-host" is using incorrect vendor prefix and is not documented.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. None
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts
index 7a53f54833a0..9a6757dd203f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts
@@ -66,7 +66,7 @@ &mac3 {
 	pinctrl-0 = <&pinctrl_rmii4_default>;
 	no-hw-checksum;
 	use-ncsi;
-	mlx,multi-host;
+	mellanox,multi-host;
 	ncsi-ctrl,start-redo-probe;
 	ncsi-ctrl,no-channel-monitor;
 	ncsi-package = <1>;
-- 
2.34.1


