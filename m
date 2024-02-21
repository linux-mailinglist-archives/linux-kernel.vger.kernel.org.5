Return-Path: <linux-kernel+bounces-74428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C204485D3F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27071C22D75
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7673C3EA8B;
	Wed, 21 Feb 2024 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="In5PMXMA"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D853D552;
	Wed, 21 Feb 2024 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508500; cv=none; b=sQgAebf6iGoSDEXIHO3B3QZPecSO6fxdLu7+0ZfmWRrN8sM7nTLZQMEJOIPOh5lEWdsJzeFH81qnxbla4Z0fRpnBhT/KAeuysFfH1r4lG+/IYzLf1erXpWI5q/vcn61qxaqomM9PDaydwPt0SDnNdR1n0Smwt4ahqeRwJpCAmAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508500; c=relaxed/simple;
	bh=JKiYk0LR7yM+OlGvUuYEMLdDUknawu7uYlYpmKIx9Ik=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k3534QLaJ7S17wvy/bxxV5g9bjgy3gRbnoFgAbrU4qD1/X/X0+tyf2ZieN1B0iEz7D/9CPm6on7q+lYUY17Pb6u3LhTcrCmx+YkZm/7ftoQTD9O3vAfVqyWUq/VZ8O6mgzZwnVO/b0AVSNgCWiu2jyJVJFtyJFaZo5ePw1v3FHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=In5PMXMA; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e45dd96437so697415a34.3;
        Wed, 21 Feb 2024 01:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708508498; x=1709113298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mmt0UdSDV+w1BWZtmNFxfAxPy3KjCbVYZPCzBNdDlQ=;
        b=In5PMXMAyj4bTCYkd12WG/df5Oy2sMNI3rwTwJf7Uo9PyrgOKK3EZsersdSEvuX9xw
         qdWCUVbCeAFhBhgNpwMXEl0futvXKomcQoe3nwfqO/MqQT52Fi/00TxIMLsdccAAdWOi
         XUmatfHrbpwLjIkqkeo8vjDblkKRdZtjLUmDvGA89jBm3UrByHlSLglPO6gYp4R00DfC
         mMnnAmTZGEQXLtPGv8w2L+g2Wvxbdyo3NiEZYTtgBEYuVLmWzF3L8jPHf9MqWpcSq4Jr
         dUPf8Jg9+vlN/h9tFoAY29bAJGRn+XyhPq9kjnAOvhYoSToVnrQqV43AseP9LW0JE7Ir
         oxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508498; x=1709113298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mmt0UdSDV+w1BWZtmNFxfAxPy3KjCbVYZPCzBNdDlQ=;
        b=wN9gfA9Yp//hUXIvUtM3UWYaBwzkEzDX4+iHWOvLlaMOvQ/iRNrbVysdG9UEDGjl1x
         NAV0EmazQC//NeYZJvFezCr35E8uYe25qaoPqgQ0wi16VgfMcvamvVu3ob9ayjt9LPSU
         E1EKfhxbs+JW141TpawwFCrKPgTNzTEgugUzmKni2Clw9Ba5rIwnthgZYYsqPSae0XSl
         u2IsUUNR352KrEHNJ96v5IDccTizfgDdcCfIJNIuJp2hz1U5n5QvQopq18PtYGWmvUIQ
         6B7ZmuegIfW2DWFbo21hGvImTdKXmnxcM6s5aPmCkveYRWhkyKCp4uRdUiO8cx7z6qIF
         7mPg==
X-Forwarded-Encrypted: i=1; AJvYcCUnMdJle1vNIqB2fjCLKe63Tj5D5FffbS4awp78gD2das9+I+O1UOnEGRyCmrAsuvRdbnjQXBxlcp0mJL6iGqqWZZs2hgneFa9HAF04HWSWaQ2cPx4+2bEA0E0rjSD5ZrD0MooXBDvLyw==
X-Gm-Message-State: AOJu0Ywvn5yo4kg8Bz6pmgANZUq6012bd15DVKm+/WirZytRQwexaEoz
	han3GXbTbM/CclzGYcdAeyUccy5R5RGG5xoUL2S+xbLOJjezNNAO
X-Google-Smtp-Source: AGHT+IEk23OMsphGOr3JIPpvQ/UoYj7rhWxmPqSYMwm4auZh3476JgXP6t5EO6mFZnThL4axuTIY/g==
X-Received: by 2002:a05:6358:786:b0:176:5cad:a2e1 with SMTP id n6-20020a056358078600b001765cada2e1mr20693946rwj.26.1708508498311;
        Wed, 21 Feb 2024 01:41:38 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id lm4-20020a056a003c8400b006e488553f09sm1645026pfb.81.2024.02.21.01.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:41:38 -0800 (PST)
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
Subject: [PATCH v3 4/9] ARM: dts: aspeed: Harma: Add cpu power good line name
Date: Wed, 21 Feb 2024 17:39:19 +0800
Message-Id: <20240221093925.2393604-5-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
References: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a line name for cpu power good.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 5d692e9f541e..36aad01dda20 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -501,7 +501,7 @@ &sgpiom0 {
 	"","reset-control-cpu0-p1-mux",
 	"","reset-control-e1s-mux",
 	"power-host-good","reset-control-mb-mux",
-	"","reset-control-smb-e1s-0",
+	"power-cpu-good","reset-control-smb-e1s-0",
 	/*E0-E3 line 64-71*/
 	"","reset-control-smb-e1s-1",
 	"host-ready-n","reset-control-srst",
-- 
2.25.1


