Return-Path: <linux-kernel+bounces-64774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6AA8542A8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6369D1F2486D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55F010A2B;
	Wed, 14 Feb 2024 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DB48cppC"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D6B6127;
	Wed, 14 Feb 2024 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707891197; cv=none; b=KdlowNDx+u/PxGuyHpERIpsnlAQnixGhCfD3LvpfJ+nNnLpa3j1GDW423qLAUOkdSLUmJO34GOIvvxQ+LmxbGk2iTIxsXgs7WsAy0rkZRn4ILCti+ZF4f8Tvg3H+Kxail4tyq+FIZtb7c/T37o7M/0Io/y/xlPX9+uJ8UB9n7hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707891197; c=relaxed/simple;
	bh=aCtWF2R5N/VsVQP3Wx2k7IGmH6gqYXNS9IoSQ6Dm0uU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=teTf9paK71EFbVMmkfvJ2Va2XR89M8r6ugEXHCNNtqUj8eV4/NArs07URRU04eFl8ri7vXG0x5Qs9E0wGg7vB8reSSCC7ODTZk5botIaqp0QeziBgotSrqGltC72G8B7yFnS9HAh2yG8dZvkgL6nphL2dmnJ7PPo7TLX6R9c/W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DB48cppC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26f73732c5so721270566b.3;
        Tue, 13 Feb 2024 22:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707891193; x=1708495993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RnNCrv7ZbOWP1fIz2vfcI4PrAv6LiZGSm+ggFT58wVc=;
        b=DB48cppCPEfYwe90pz3tyM4H3bZCP20LAZ6p+ZAz+fZchCM/0kqcsWp5te+gxcVUdV
         9mgMvTU4RSVLlVWoQ0zKhqIAE8x8qiYqHWX2bkonl5E/LMsXRCFetxkKKe6j8B06SI3R
         UzF622UOAYBK3vYcwrk2BxNquasrrN1y1S03/yTIDBLKcYSI0358+bVWOajlkOiFEmBe
         Xy2ThcmoetX7VJzK4JOPpyjXspR79hgbUzDCxKDeNY/1bA9gRfMm/oj0Gjpvt9ocCV+A
         LhjObAW0Gple9AQnZh1WjyKIAChP2RJrbtHN3Iw8xwdsj+wb78CoTSc6WP6NTPkP7kwt
         j/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707891193; x=1708495993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RnNCrv7ZbOWP1fIz2vfcI4PrAv6LiZGSm+ggFT58wVc=;
        b=dSR5hBAOouf5Q0WPgs1Z4wh7SFWpZ8PM4j7UC3z3ae1KuX1X9iShZHKEwF5mpYYk9A
         P42GPm00hQKVsJkuAtdXS9ljmc1+oKpj54YPoExb/240g92drjWzG/PDaPFbxFes6ijm
         pFglJ6Fg1jdAEEzqfN8W5awqKyzGcib/F1WHZWWNHiDOy0P7Nz/ya0YyPlb/wFcpxO5w
         yAC4tHeF7VDkZHbi5gUfIX6iLlHVRnJ+IK9DSNlAW7trxYEtHJZPzbocjKyiqQ+463QZ
         26B8MeyvWi+9vCcHKzSlQOvwTivdudYvKQy04JxaRg2rW512fNDC9/2xg5Y5uhKV4iiV
         sNiw==
X-Forwarded-Encrypted: i=1; AJvYcCUZekDv25it6U3SC3E5ovq4xX5ekorCDfAVylgDOai4PiRrBbVY/KidMuFdkX4FbsEHP8gTY9LRnkwHv353+m4YeJaGhaEdD1CLDrs7+e2kQoNqGZ0Ev6D0u8GMg2zPU9/e9YGwT0lzRVI1jmGd4DDSYP/aEpzhOZIyIo/UsWJtNFg/Bg==
X-Gm-Message-State: AOJu0YyW7YHeUXksbnAi8TNyIr67tXdEKiLyMKWayHWvrmGkv2MMiwJ+
	HnlFO/0BtRMStWKHMAU0+ntRABnKuOxouFtnKRvzEGSPqD6QTlXM
X-Google-Smtp-Source: AGHT+IGtPX37JYV5kM5O1SmKeozWVK6PqGYRhd1jozFU7jlXt8xqzmH3Q6m+kVq6dlwn3Ej5MDo1lg==
X-Received: by 2002:a17:906:56c2:b0:a3c:bfcd:bed2 with SMTP id an2-20020a17090656c200b00a3cbfcdbed2mr941828ejc.31.1707891193342;
        Tue, 13 Feb 2024 22:13:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXN0uKAweA5H+rNvQuNJvpZiek0Sy5TsEDjXpufOSG1llQF1SgDxoOZ2B8rY4Y4umzFVaZaihgHYLqjYhubf6a9mlKOoydC4oRyRUhZzWaNesZgoG21hU8y7tkMnv70RJPQNsFYtteoYGlOT0eSHTQzdOUK6ifMfGhGyrJVLFT7qmtk1KzTf5VEiIpKdMWWfrQBo/9Ehq2nIUFn6nf49bYhNZSmSSikwKmPWxnaFE/PycGRqyGpZeQjkJ/YBuCXbwbHZLAgYOaWFd9AziCcy3ET4W7jIJrss26XKj4Fg+oVgy8d9Up1py+UpPPnEn7l6hc94ZmovlXt3gmque/MaHD8IiBcZi3icgXcCj7HhM5qmKaupSGrNyv0eMzwuHPMycsgIO0Qfk2OPnBZEh5aS2PG/k4eeumlkUNC1LRrJ9b2GORy2BVG/C6ETgTGg9C/GPCh+BSXprk3/OWKKiqxDEHwDvCQCggDFrFmTvsyQ5tbDOQv8nuHGx0XwRDw+J7YrwMOCEVLS4PFTpcZXhQE7eFsQYwa3A6YvJXP1cK3OGEQ/N3+o8eHHG6n4g==
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ca23-20020a170906a3d700b00a3caccb8f66sm1980163ejb.44.2024.02.13.22.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 22:13:12 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V4 0/3] dt-bindings: clock: mediatek: convert MT7622-related bindings to the json-schema
Date: Wed, 14 Feb 2024 07:12:30 +0100
Message-Id: <20240214061233.24645-1-zajec5@gmail.com>
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

There are more MediaTek bindings to convert but for now I focused on
those used by MT7622.

V2: Move bindings to /clock/
    Use clock-controller@ nodenames
    Drop incorrectly specified "syscon"

V3: Update titles of all 3 bindings
    Simplify HIFSYS compatbile (drop "items:")

V4: Use "clock: " prefix in subjects
    Send including clock maintainers

Rafał Miłecki (3):
  dt-bindings: clock: mediatek: convert hifsys to the json-schema clock
  dt-bindings: clock: mediatek: convert PCIESYS to the json-schema clock
  dt-bindings: clock: mediatek: convert SSUSBSYS to the json-schema
    clock

 .../bindings/arm/mediatek/mediatek,hifsys.txt | 26 ----------
 .../arm/mediatek/mediatek,pciesys.txt         | 25 ----------
 .../arm/mediatek/mediatek,ssusbsys.txt        | 25 ----------
 .../clock/mediatek,mt2701-hifsys.yaml         | 50 +++++++++++++++++++
 .../clock/mediatek,mt7622-pciesys.yaml        | 45 +++++++++++++++++
 .../clock/mediatek,mt7622-ssusbsys.yaml       | 45 +++++++++++++++++
 6 files changed, 140 insertions(+), 76 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7622-ssusbsys.yaml

-- 
2.35.3


