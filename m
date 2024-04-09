Return-Path: <linux-kernel+bounces-136640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1806489D687
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C081F285B6D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4193126F2A;
	Tue,  9 Apr 2024 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qsZb+AKu"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42DB839E4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657628; cv=none; b=gF0pq2OSv0qfg4/cVGU2oEPlM340Qs8L0gqqvXR+hBtLW7kVME68ROK1tJXr3gsYSeqJEQGP/r7Al7Vs2M7CcmGh3T2/USiIMXbngJ54gJDeosIUbh911jEagmwXAWyjJjm/HFbP8p8Gaea+dHFtSrPBu0l3Rnhx66EZlaChUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657628; c=relaxed/simple;
	bh=m2WMimLT+3s6slBofqVAvaqLkWzrgGp85vJbqpzM2J8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C/VSpnQ8Qyy9ffrA/48tGMdBYjlClhMsRLKNiqrrw1DzkJtxDVWiYf4ivgzN5j5qgSV0tP/WRXmH0TqPxhx+LiPongTjkmnTQNb7ZlMoD7kYd3xaX0Zt4dusyu5ZFRvW6eFcXA4QIY2mI1iTbVW1QQYw/P1NYwAP3O8/IdHApcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qsZb+AKu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-343e70dd405so3469457f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712657625; x=1713262425; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0Ft7gJMIMDuyFaMl73MCWCL0VnoY8SMUukXDjxNKP4=;
        b=qsZb+AKuwDGR0JCHSvAiJ7CarDN7bkp/Cg3/6gLUg2GsGEsQxvZOQP1Zxxod6OUdWV
         W7WQwL8LrjmkKKz7z8ovvYQvdRmk5xEw7s8pzxECe1Q6BNoXM1XyZuqahDtjGqCorGk8
         NMXMNBmKcUwxY3RiFXspUS+IRDJJu2/BuKYOztOCeZeAxzU4NUa+oFVfnnmnTFYhVFn2
         Reu9y8RPkO7eofXXNaUMqS+l0b4n+wL73ZXhD8bR4O1R96awf3soYyjmmiSxuzZkExSH
         5KNu/6HBAe9gdxphFyDB6oU/j5Edn2nvjVLkkoIAVp1fXialcnkhqpjA31yLej9a8IDx
         Afig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657625; x=1713262425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0Ft7gJMIMDuyFaMl73MCWCL0VnoY8SMUukXDjxNKP4=;
        b=EMtVR5We4waGUJGXx7XAMWGH6GWp2nlF/FGGV6S0j1knUVS3kAcDQzpeVKxUb7GySQ
         XeJlXzwkxuwX7LHJGqrYeyLTJKg7jS1Ng/p8yBK+aaIt4TQ3jrv/TjkmHEg0csPqyHkR
         43PHn83al6Z0XhVXErBDG3km3fAmbhNT9utYAonPIxrsIF4QpXrqJR/8Asto3p7QNyx3
         8iN79+6+8wPaNuQEoORoc1ATwsYH2+tdspu4SchBgBYWD2GUECqwr/vk1QvHjob8/ZmF
         5RP1spGnClTEa3Lz/NIVbHV1085anEaNCtCr8jjfrTeca23OhThrHUCFSNsa/si1VhB/
         qVXw==
X-Forwarded-Encrypted: i=1; AJvYcCXtXyFVaeJ8lamsnpUhxSpTuiWpDLyzCrtVitMwXd9LKC2zxqmNDq0UqP4Opi5dwYV0nKdMtsRTj3huMRgDKSaoC4ejg1Jjnu40ddjU
X-Gm-Message-State: AOJu0YzBGTSCanZVlj59sDZieb6sJnvWR6tIHPFc7fN+Hv811mTtS9GD
	Ws2R1XIro5A7w4U5p0LAJrFsrQC8Qzxw+jgnJlSw9KxY3XgxcSmMaUSfSQTnQrpH6AlTWqaP0hg
	r+zw=
X-Google-Smtp-Source: AGHT+IGK4AiPdoPdK/Nj8GgRRQnhRywKu0i7mdq9xkLbTZkIIeBqZ5HZnSAGrmuyoOY8FKcwZklQHQ==
X-Received: by 2002:adf:f390:0:b0:343:5cca:f7c7 with SMTP id m16-20020adff390000000b003435ccaf7c7mr9025258wro.41.1712657625053;
        Tue, 09 Apr 2024 03:13:45 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id r7-20020a05600c458700b00416b035c2d8sm1124149wmo.3.2024.04.09.03.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:13:44 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 09 Apr 2024 12:13:24 +0200
Subject: [PATCH v2 03/18] dt-bindings: mfd: mediatek: Add codec property
 for MT6357 PMIC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-audio-i350-v2-3-3043d483de0d@baylibre.com>
References: <20240226-audio-i350-v2-0-3043d483de0d@baylibre.com>
In-Reply-To: <20240226-audio-i350-v2-0-3043d483de0d@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=911; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=m2WMimLT+3s6slBofqVAvaqLkWzrgGp85vJbqpzM2J8=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmFRTTqCdhPMIFZWlG+RUcAbHEDXlIAWarybBpGWPD
 AT/xwJeJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZhUU0wAKCRArRkmdfjHURQ0FD/
 421AUS7r15gqz0cDoSJUWf/NwqPKzmknIY7/gc2AzW6uV9A8lGiL5egEUbMbau1KaWDGym8HEA9db7
 bt7tplgEVwqLq6K5RR/JF9K6zebQp0T15i8ijlHrf51CJS35ez4zXxUOr+PLROVdryvRQLvplLazH9
 q7L7vJVYUTpedo+SJR/hMzHe9KJUk4dvZQeVWKEfwyLX0RBdXBXoTV4EfPr+6/XUvKdgC01ksee6ji
 bPWeUyBm8uUbEOT2wL88gbnACMBIsw8tWU6SY1HcDQopSUJ2pHhavISuUd6Lc4zw6gAo/tapvBqCRz
 Yfqy6/i2AR1JTEcEH3SszNFHYUNr3ygXClDnMaUUk6amncjDV3vrHzYOnX93+niYjEIteSh3e5Ht/N
 SOk0kI+N7lj7gwOzVskKLRyUcLdZK7EN2KWfk5rxFDLzl+tX4Iea/7wtMwCw2F7RCOaDnXQtod/Vlr
 NymwDc0vagUQE4BuHF3eQMFr88QYoVkBre/JUc3T2taGZ0Tc7UHAWDJkYktyTSORMuluCCZjljK9o0
 ClLwJMrSiPYIqf8wzBU3uTNoPM8z4CaHZC5e2UDUjfdLkzw8pvxwFuj6I0yLU+CUtuBBvj06SNDt0Q
 h7H9SK62oWBZy/PWQdW5/h4z1d06KaN7RgGcNsKWBrqyFCUwYRTSPS7KJEDw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add the audio codec sub-device. This sub-device is used to set required
and optional voltage properties between the codec and the board.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
index 37423c2e0fdf..7c6a4a587b5f 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
@@ -37,6 +37,11 @@ properties:
   "#interrupt-cells":
     const: 2
 
+  codec:
+    type: object
+    $ref: /schemas/sound/mt6357.yaml
+    unevaluatedProperties: false
+
   regulators:
     type: object
     $ref: /schemas/regulator/mediatek,mt6357-regulator.yaml

-- 
2.25.1


