Return-Path: <linux-kernel+bounces-70368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEBC8596A8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 12:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFCF1C2096C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 11:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A97627EA;
	Sun, 18 Feb 2024 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JIEcVwJ2"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE24612C8;
	Sun, 18 Feb 2024 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708255216; cv=none; b=Ee0NbWA+J+9CxRgJhy7ABumghT12Mz+HkuZQAX4qROoF3Y37YDTHi8+Th9CHQavby9bp/AcCwSPNBMKnV7t7rE9al+EnaqNqhLajyHQ+HN9rSvThM9ZefrrfhIXpmpS3Yvf7l5AP0K7QUrd/zoc2/zKKEH6XNzeppnYSbQO2gaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708255216; c=relaxed/simple;
	bh=KHkH7k4/V7PCFmh9k52BW9kvmYLH7d38mMJvM47yp4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrJXK7trsEd94Hi1jXu3wXXukiMM6BLZHZHoMXMa5YScvvii+8p6fHHgRi1gU3JCQJlT6bNmuvwht8RN+Wq3hnBlgyCucjfcdm3Q96XB1Lb18vImDl5fwQY2HeHK+qMhAG39SeGi9Iu9myZsahtpucHRLq8UYe/qRpfiQKhWUBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JIEcVwJ2; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56399fb02b3so4232225a12.1;
        Sun, 18 Feb 2024 03:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708255213; x=1708860013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPmTNE6EQgfeRHYPjzRQvUwlTRq7in5uTwy6USAXPPo=;
        b=JIEcVwJ2s9c3f4ovUDxkS2JMANDEcheT8CqlI7gIe/udj90qc0mUbZlGEEJ4Ystibl
         Jsa7NPdZElNiUcYOZ/OaPpgHnIsvQcKzuJiY2K7pKX3Ada54M7AhdbVA9XL+kWDTL6Vr
         XYSdPOn4ZP8JbkMfqwqd0xppIe57PVZpI3AJDVIRCWHZ90ixXa6svkapx4Hn8cEz8+N4
         i2m8vTKnBZKffNHnm+5V3ZNd3WYK4GMM/0DFZV09C6O/FwNkwxSuYM4XqKT4Gfd0KNoe
         QiQOl0LynsDrPnVl6HeuB+bRKL9zBWOpL8W9nv3UsC2JHBHFmB83bybmKuMy183USyTI
         TfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708255213; x=1708860013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPmTNE6EQgfeRHYPjzRQvUwlTRq7in5uTwy6USAXPPo=;
        b=m6qqS9taejjBu1uKpt36oYNoOfWuzq5GBhZseAEasfGVQ6VNtdGLhH3sSx8g940OpS
         AY6VziIYitXZTlOIyllgmlMqVck01Ev8SIpubcgdfrk2DrrJ/lwrgnUHFhtKCD1lhpUo
         PempKfOyVWTa71stBpNKWxWRj0NXoQLEhx4+8DMx9xcoCc4s0eO9svO9jcl6BJ/4I8Pp
         KvKIhf7fewmuBmdIkqiJBplD9VauI1jLl3QT/6JJmPAG/swGB3L4d5VxUj2vMsGj/37L
         MFDF06ygj3FbmEJXJKQIJF8UhnIhmn0WEFFWehPBjT1I0wyGlyMbf3hr5H5RPHR92slS
         r3eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy6Q4pFOQy9KKT80aGJkuErOw5d2/q4fMhS/sA8fi1ECJsDPjBaWL7CILM6gqVKMARqjCr28rEgW+d0pBWGbWz/7K+98aWkj6YOYLo
X-Gm-Message-State: AOJu0YzhyYRNkueP0cBz6hhpThFqQssIkNgcbEBpHxAF2rIi3bsAIaIs
	u5YXOASxghZAgf7ngZuiolhHphS5GfoMMWYYaBgNKute1Wj09HAeM91oGmIg
X-Google-Smtp-Source: AGHT+IHr9ZdbJztJjtjBHXqCE/IMhxSFhijBU0XuiX8iDIUv0acD2Fpa4u6xKvRiExVfnNHWhQraNA==
X-Received: by 2002:aa7:d7d9:0:b0:564:3b52:2293 with SMTP id e25-20020aa7d7d9000000b005643b522293mr1997873eds.24.1708255213606;
        Sun, 18 Feb 2024 03:20:13 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-7b37-4900-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7b37:4900::e63])
        by smtp.googlemail.com with ESMTPSA id di25-20020a056402319900b0056401eb3766sm1675190edb.29.2024.02.18.03.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 03:20:13 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	neil.armstrong@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 3/3] ARM: dts: meson8b: fix &hwrng node compatible string
Date: Sun, 18 Feb 2024 12:19:59 +0100
Message-ID: <20240218111959.1811676-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218111959.1811676-1-martin.blumenstingl@googlemail.com>
References: <20240218111959.1811676-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no documentation for a "amlogic,meson8b-rng" compatible string.
Keep the default compatible string from meson.dtsi which is
"amlogic,meson-rng" (which is also documented).

This fixes a binding check error.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/amlogic/meson8b.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/amlogic/meson8b.dtsi b/arch/arm/boot/dts/amlogic/meson8b.dtsi
index 5198f5177c2c..2d9d24d3a95d 100644
--- a/arch/arm/boot/dts/amlogic/meson8b.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson8b.dtsi
@@ -620,7 +620,6 @@ pwrc: power-controller {
 };
 
 &hwrng {
-	compatible = "amlogic,meson8b-rng", "amlogic,meson-rng";
 	clocks = <&clkc CLKID_RNG0>;
 	clock-names = "core";
 };
-- 
2.43.2


