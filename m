Return-Path: <linux-kernel+bounces-105577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADB987E0AF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA701C20BAE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACFD20334;
	Sun, 17 Mar 2024 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNg9+o1W"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A2B1CAAD;
	Sun, 17 Mar 2024 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710714738; cv=none; b=MKWehoX7XKtU0JPX02T5rSzxBvP4EGJn13mRfXs9ygJiXiK9Ch1Y3wOw34gppKE01+sOD2L/n+ZnM7TIQ2JIunw+d1gXnBlp3XXyC2hFaeUyNnqx60KoPsak87TfwpkKGTdGiriQHWj5GhmPROHK4C2gWoP/u6efMcWiFGJKnsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710714738; c=relaxed/simple;
	bh=c0OZTON+IyLGK8jH+PJEy7n9q6DXqULXWIdoEBe68IY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uG75L1YFaZewfHQXPlEJe6N4YS3eMREAybfEkKAR45x2qg66rhhh6anP5kLf3QVrstc7SvRw8QoI+bNTE6qVdgBzdVWb48ZyMa4/s+NaoLWQy1Ckt/SRyhf4Tdu6+MsQyvniWbfVMh69pqF12U7pqqJtfnOiEZ8Jdlp4B9ARHVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNg9+o1W; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513a08f2263so3960512e87.3;
        Sun, 17 Mar 2024 15:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710714734; x=1711319534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oKqhZPN7QFsjLPpu788l1fzAnbgMEFuSuh/7MopxlUQ=;
        b=FNg9+o1WMDGtDmxYpHfR5WYEqfg9vebjWMwiLbaCaAw+4jjaScpOHJ4V71yn+oXne9
         gQLHw4D7HR5TQF2+mR37b0s+w/1co+3596jtHM0Wdu0/5si5IB4NPswz9Vb/HkfMbPMH
         xIgVzxMlCJ/vFBzYKPxRffV82S76HmPFmgG8gZ7/nXosKE+WS2EzwckQwEZoravcdisw
         0XEKA6AvG54PqOiU6hUIeLB+9s4xaYHa0hyBqcI9FZdOCWYcvuhd+D8fT8u2YX1Sqh2P
         drqaLrwSOAHZT1P6rufMQVPELHr4s0bpLtQuAelvQMXO4Q18lGlBhikC4NZU0wPJI8Lg
         O02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710714734; x=1711319534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKqhZPN7QFsjLPpu788l1fzAnbgMEFuSuh/7MopxlUQ=;
        b=HASsu3nIcbZhy4iTVo5Ldrsk52sN0cbt9LYtBV0gkh0Q/x2OThnPWQAhbduqHR+aCx
         LEtM8ExApGdJY/oiVWPxVIcNeL85K26fVI+RJ+MdLipb8Z72mZg6paxQDe3li8ghb2/g
         MjQ948YH15Ufkhl/B3EsTreKchasAGOkul/Jrfn69ZytDHq9yfSMQNq2dqOdnT5AS8Yn
         Mh7fTyxiKTxEYzopooDXXoxPVOk3XYO8145s7DvcNK6QcwMcQ/28DVKfjyWtRGoVWRZH
         LfbmiU7B58EXS9tjhi8VJfPoIEIE7Od65+TTFoTOHrKi9ccGZ4JMxP3lGwzqWAefOzqr
         In+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUu3bUzN2i1SHy9PZUUkXLFLhKB1HSkGnEARCVAhufPlch9Tv0j3/GWoQK7tSfWhsyzNM8g7IWzyIqBLNiBqviPmDhbz1wTMLmm/iy9001bmQnpa1ShTENMbfCv2sR0c8OwNh/FF97Uaw==
X-Gm-Message-State: AOJu0YxO7HPkpuRUEDPSRfE29Jxp+ZjNWWt0E9YC2EdawOAvqRDNnaiX
	GTndgSQtatX41VUsf55hg4jY4rbOJ6/AiYK+rSdZvK+kXZv9cQs1
X-Google-Smtp-Source: AGHT+IGvZEXFQaZKOHgdv2XVxCJllpvk4dkQNQ0UD5UIfOjg4y1XaxXieT6UplycgUuKdWjVFnhkcA==
X-Received: by 2002:a19:3850:0:b0:513:c757:33d9 with SMTP id d16-20020a193850000000b00513c75733d9mr7114305lfj.53.1710714734438;
        Sun, 17 Mar 2024 15:32:14 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id x5-20020ac259c5000000b0051322c11100sm1366981lfn.221.2024.03.17.15.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 15:32:13 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3 0/4] dts: mediatek: add Cudy WR3000 V1 wireless router
Date: Sun, 17 Mar 2024 23:32:02 +0100
Message-Id: <20240317223206.22033-1-zajec5@gmail.com>
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

Cudy WR3000 V1 is a MediaTek Filogic 820 based 802.11ax wireless router.

https://www.cudy.com/productinfo/1637722.html

Rafał Miłecki (4):
  dt-bindings: vendor-prefixes: add Cudy
  dt-bindings: arm64: dts: mediatek: Add Cudy WR3000 V1 router
  arm64: dts: mediatek: mt7981: add pinctrl
  arm64: dts: mediatek: Add Cudy WR3000 V1

 .../devicetree/bindings/arm/mediatek.yaml     |  1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../dts/mediatek/mt7981b-cudy-wr3000-v1.dts   | 74 +++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi     | 22 ++++++
 5 files changed, 100 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dts

-- 
2.35.3


