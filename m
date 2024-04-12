Return-Path: <linux-kernel+bounces-142148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AAF8A281B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B78EFB22855
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117E55102E;
	Fri, 12 Apr 2024 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="heniOicJ"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DE550296
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907063; cv=none; b=Ua5G+oxSrjXxCS5EwZyqZPjHhTCKEW2/3MzqHx7EPExYA3dFUtSWJCg+OP5kbtAAOC/8Ss8QWRPH1obxLFqP8CvF7iHmv26SNq9MoeRcz1LTWvLFSzEmhmuAVp4ljKHfRdDMq8XNesqD+aYQ4Z3Z4U9DN1eEFh8WuG/xs8L4n2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907063; c=relaxed/simple;
	bh=7FCb+zQUOtiGsCLei7LkLyGVhMO0RYM/Z1q3ODTRet4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRUv8awcLG6xRlcKzQoM5Gu6ywRRoMhEEc2xvJNSwNupPtpP8q/fWhOzDtQUJSqvI3BAGZG0ZblCUkRaCTRZ0LW5uAxo7/h+KeRWgEeh3RAZATx9EAGlZkldOQPXohYsM3Xk4Zr131fZLb8yFU6VGuM8cnGoQHtuWHttKJZkW7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=heniOicJ; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36a0bca01e2so2762215ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 00:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712907061; x=1713511861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RdZHSk4TFU7CzZXHHxRZDn956keZAqDxJBl6Nwvleg=;
        b=heniOicJd5C1A2LxytOgFoDC7zUsuuWkX0viRRfsoaAygWH/lsWlP6lETns/GJJHjt
         n551M1HDSO+mc+N6GQy5kz2xx6sLkF1qpnXkEq3rI/7mmoTqLevCMys5GvAp2zUclKPH
         rCcZf8XG9e0VQqglu8Bx5S1wf0g2BqD20Fhss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712907061; x=1713511861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RdZHSk4TFU7CzZXHHxRZDn956keZAqDxJBl6Nwvleg=;
        b=A6gyUYw0j+fUYWQCHC26Smq+lEpmWA4SsAu9xoBTEnkKJlcmK5NWMu2cvYO+6pvKtR
         WpE3ucdjRKBysqwk5q3Ngv/fHSdKxIDDeWvdLgtNQwG1CjvcjTC3OHuKHghIGNKIYx19
         YWmPnqEuOjTXFbxXYveDH6I2FclOl490DPu3FmC0Fzy9zFK98IWEPTvx+uSYM7/3DCcL
         /RKt5sIPeGtX1J/mZlRMr6ZAvcJkdPawQcCKJLvI/p5ziQAwIwU3KNMDyge0JhZarMKE
         LYLrQsvcTeP3LPQATA69Dx0NDiKDYvax1g3kNRlQNu5ixl/mfdo9L7MhJnaoIsdM65cH
         vdUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH/tJOND3vHo80BdJf3/cl4icHJJsC5mOvzjlfaxznxY2St4iLR8Eq33dRhmxgn4qY87w7KNKUfHQJGep2ziF5x+yU1Sy+b1aKktOt
X-Gm-Message-State: AOJu0Yw2SM4ITVLpciilNPmC42FYN7txlJyz3QjHvtDsqv58E8f6ewqi
	yG3+77lhCC9P6yCtJRxh9Y0l/i17iacMxztfN2m9Rw3gKtZe/a8lSMCRsJ2ywA==
X-Google-Smtp-Source: AGHT+IEL4CHJZN6cyV51F6bVm8k72tn6WE6KhBCBOK+lKr3ueEZGkvYYXfBhK3hbMLBmSdrvlM2k9Q==
X-Received: by 2002:a05:6e02:160a:b0:369:9492:c24b with SMTP id t10-20020a056e02160a00b003699492c24bmr2090150ilu.10.1712907061055;
        Fri, 12 Apr 2024 00:31:01 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e3c8:6e1:dcfa:3e8c])
        by smtp.gmail.com with ESMTPSA id d6-20020a637346000000b005d3bae243bbsm2149609pgn.4.2024.04.12.00.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 00:31:00 -0700 (PDT)
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
Subject: [PATCH v3 2/2] arm64: dts: mediatek: mt8183-pico6: Fix bluetooth node
Date: Fri, 12 Apr 2024 15:30:43 +0800
Message-ID: <20240412073046.1192744-3-wenst@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
In-Reply-To: <20240412073046.1192744-1-wenst@chromium.org>
References: <20240412073046.1192744-1-wenst@chromium.org>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
No changes since v1.

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
2.44.0.683.g7961c838ac-goog


