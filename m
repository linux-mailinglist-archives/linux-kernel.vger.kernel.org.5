Return-Path: <linux-kernel+bounces-142373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 911D48A2AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27461C21A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C193EA73;
	Fri, 12 Apr 2024 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVtVBSMn"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B254D5AA;
	Fri, 12 Apr 2024 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913494; cv=none; b=A+9xiVd1HUfIHT3kYVjg48q4GfsZOctR2XUGlrQP3QUi3hipoTXAPyhZ9CgND0dNYozhk7AdSzBj/xKJzHOHnuzam7simGmEBgAZA85z6MQpaAMTCv7pr5c1i6j1b+kUHzOmH9L9gdEgrQzevUpMznsqRaEuPCwyVUGdXFTFeFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913494; c=relaxed/simple;
	bh=CebN2e7M+eUIq88kq6SwDH4xYTCQZktEekF7C3lknbI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EgBXDVdNL8mSfT5epfyjONaVV5mOQ7J/3IJF4LdYfMNrTvPfYIOFCZlMw4hfIbAqEBaKn8XxQL5aMeC3v/HyzexjnB+dHncze3CWN3faQNsEDqvptt4IzMuK79d89PORzd1VdwrKTe/1qBJ8BJlUpiq8YVGo93O1Plc5z0y+muI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVtVBSMn; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6eb50c13f44so440531a34.2;
        Fri, 12 Apr 2024 02:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712913492; x=1713518292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHfABZko5E3OyVpk0Pm7Tx9/GwQM3X5Y0l7yapoWLPM=;
        b=HVtVBSMnAvj6mFgDUBmpymZvKXIZjSNt9wWRM3wamVH9IWEAaBSZg8dBYHQiqsbPdg
         GSeeBE/PLXJlNZEnO07cCa8y131XrASNdTX2YWg3zU52vd7oYu1vMSsAIXeetoNvZiJd
         YCzZJ9+QjkuhcJb9X0iQgzWUT58tF8CYonOicMY69CecBuejwVPyOJCuWwbuKsTREEV3
         na8kAvxaftL0Zujga6UKRj1nOd53Kig1rIQBxbLFXzFd/RncOkpgO/42q1NW6tSBO0tG
         Lmjcy6cyAHNnYAdC2tgVmOqhBlr4EebSu2OQIFW+QiJIbtLloUtBcbtad2I0+xdippmk
         jtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712913492; x=1713518292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHfABZko5E3OyVpk0Pm7Tx9/GwQM3X5Y0l7yapoWLPM=;
        b=cP+vC4mo2a+iNJ5yj4mwUSL2BkOE4cRZ9XkckJO51NW2ARdyEOXwVCnO2zbAx7QUuz
         FHu1Qxc+k+MRqW8dTtk3WemXHF7Qblhr5vQANliil4llJNBRrNalWMJpLAaetEJZYB6u
         D/PKcfA0b2nLUI9+nLhLKOyR9aDgT2rePj7usz2eNOvwUD9IkOM9ZWa0G7CsOcPvDPTH
         IsPZeeDQg6rg3xtSlNHaI+IaR7YvFL0O3o7QPAKn171MKHutFbReu/5VtYJU+8LeJqRN
         zO9mCxPe86C+lGKYk4hdTDXkvul+5GPcrFGap3Fyadkq4XjTKY/sBMkPW/TaB0muDHM6
         x51w==
X-Forwarded-Encrypted: i=1; AJvYcCXVVo5WgZeWRB34e1B/5Vd3SP4btETFvGQgRs84qHSQFNBp6t/Lt5rrYJGbLgaQTUznRh51iiWNpwBkmiNz3oEi1uxYITMPcq47BoqcxNfKazT0NH8oMnN0crJDIFSkK0sBqlRiq71FcA==
X-Gm-Message-State: AOJu0YxFTK7e538XkOiecHURku1tkVVDgphQNfdrYgLhgt9ApeZyuxCc
	wOm5H18nvGJ7kWlDBktGOigFcEcXVhkG6NR5mwyUgxAH7arl5f1i
X-Google-Smtp-Source: AGHT+IE5zLPdK96gYU8DzX11JbPPP1pJ6TJv2SNsqJsLZ6SPyHZ16UaEC+PEbBoCiuihIKgXeFrY3A==
X-Received: by 2002:a9d:6556:0:b0:6ea:3851:82d4 with SMTP id q22-20020a9d6556000000b006ea385182d4mr2139807otl.27.1712913492713;
        Fri, 12 Apr 2024 02:18:12 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id b25-20020a63a119000000b005e840ad9aaesm2332711pgf.30.2024.04.12.02.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:18:12 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/12] ARM: dts: aspeed: Harma: Remove Vuart
Date: Fri, 12 Apr 2024 17:15:51 +0800
Message-Id: <20240412091600.2534693-4-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
References: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove vuart to avoid port conflict with uart2

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index a0056d633eb1..5d692e9f541e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -100,10 +100,6 @@ &uart_routing {
 	status = "okay";
 };
 
-&vuart1 {
-	status = "okay";
-};
-
 &wdt1 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.25.1


