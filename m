Return-Path: <linux-kernel+bounces-38337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBFE83BE02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2737528D860
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F871CD2F;
	Thu, 25 Jan 2024 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UozhGrAK"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B921CD0C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176382; cv=none; b=k2ggZLPRjhkprYKHlU8GaQVvO/AsWbsKLMK8GFZ+Rv8uV7FRxki4oUhY/5L1/2lWKhOxcn7FP4Fw9w6TBgn9KXzHwEfDV3uuJLKpa0oH1oufT0zVQ4ezxeV/RkRBmVkfeB78FVOq3LZ3DkCTBBEdg5ZN6GXBdseoM2d6gbnynvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176382; c=relaxed/simple;
	bh=u25TQi/eCQzC6TkwHDavOWDYLYRf4oNMi+35yG2C16I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xnv7JrH4SBe/MWmwPUQQ/1bjI1e7tNX50WjuE/n3Th+7B6I2nPHyGY672tGnnqdhUpVK4a1qgKnbQKXs4ZVoHKoI51Iv9MyQMO2VTjmER6z25YBhSTFdIYj46X0xTgpdvEXb3XXPO9LXb/5s9IOfXlHs3IPQ0QPUWoQ7IdPM6fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UozhGrAK; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so4198710b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706176379; x=1706781179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwHQQ3y8mRIC5l7GJR/3O2cr3VUs7tVDE1ZJ0OPgKKc=;
        b=UozhGrAK9gJVtTbSEPb//zh8wAFymQqVEBy7InQ12SzZc5ARf5Eb7M93dmLIhki/EA
         JhDC5fXgqPlWipQJ9aUvmj2pKBSj1Hidi9NzJtMbgPsJkciPTrf6s8Jh3alfhr2NDq3D
         T4tu3plSujc4TxrUEVIqpZsbk81cQGX65wQVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706176379; x=1706781179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwHQQ3y8mRIC5l7GJR/3O2cr3VUs7tVDE1ZJ0OPgKKc=;
        b=Z34q0v5lkmjb/E/gQL7zXQ1dkMAmPXvqnfwVThiJ2qOcwMx9iU41twvVzvfTyqwXNR
         SZb64nP5GwWlKy8a/2XCApy3oxl8l5dCyORLpWyTj+VtElIm0V/Smxhn5yMi5R2ak5j3
         dgHvYlblKgwpHEjPzeBWP0BV9u1IpZ0yHkfMk9j6XTAyZqzKdjUQgu+Z5YWqqX3PKM5N
         IeZmM+AYBBukBNkvgYhrYStsgPvbEqbJbUxOOMk6cIEFO8EjJEx6s1rXSkSFb8MOggZZ
         4B3KZPtCWlAMqDTrgDArjdNFEafemNTmiBT6HXhFtzb2Q47pwHC6YMHHxCqMSWlYjTtf
         UfEw==
X-Gm-Message-State: AOJu0Yy0JrfdRqpLzT+ubjNYErPFXemerL/QW8TrjMpePoHLDT9vIum4
	s2nJCBDy8dOJfX9rnr19wuym4dxJT5hb/8nhjVKD8OCod+eJ481PXRuS4ULQ2A==
X-Google-Smtp-Source: AGHT+IF9ouqrxuN/kDRByMxn/PlL63gtfiQf6zEmcMi2K5+Vu4orKTJyiaEsZI9CeowBst0wk6XIzQ==
X-Received: by 2002:a05:6808:1911:b0:3bd:c038:b71a with SMTP id bf17-20020a056808191100b003bdc038b71amr770409oib.25.1706176379179;
        Thu, 25 Jan 2024 01:52:59 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:7fb6:ed02:1c59:9f9c])
        by smtp.gmail.com with ESMTPSA id gu15-20020a056a004e4f00b006dd8a4bbbc7sm3228275pfb.101.2024.01.25.01.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 01:52:58 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: mediatek: mt8183-pico6: Fix bluetooth node
Date: Thu, 25 Jan 2024 17:52:38 +0800
Message-ID: <20240125095240.2308340-3-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125095240.2308340-1-wenst@chromium.org>
References: <20240125095240.2308340-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bluetooth is not a random device connected to the MMC/SD controller. It
is function 2 of the SDIO device.

Fix the address of the bluetooth node. Also fix the node name and drop
the label.

Fixes: 055ef10ccdd4 ("arm64: dts: mt8183: Add jacuzzi pico/pico6 board")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
index a2e74b829320..6a7ae616512d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts
@@ -82,7 +82,8 @@ pins-clk {
 };
 
 &mmc1 {
-	bt_reset: bt-reset {
+	bluetooth@2 {
+		reg = <2>;
 		compatible = "mediatek,mt7921s-bluetooth";
 		pinctrl-names = "default";
 		pinctrl-0 = <&bt_pins_reset>;
-- 
2.43.0.429.g432eaa2c6b-goog


