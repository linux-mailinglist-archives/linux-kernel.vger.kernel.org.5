Return-Path: <linux-kernel+bounces-101566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AF487A8C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC011F22337
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5130443ACA;
	Wed, 13 Mar 2024 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z0AJ8SZx"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315B541A87
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338041; cv=none; b=FW5n2kJdalaw3ZVB69inNsyV1bHB9wJOZ0PtOGlG0HnGMoOcBGt/BtxB0SSmX3Jd405JoSYibee2ck01EoiC5TQ2TVi20VJNzdw32vJiTEeXMbC7V54e6MCxhAPMJzZNWOSqnOYqLUqx2HslPUsDz3sYr+e9vTH/Bu+x8uC2JSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338041; c=relaxed/simple;
	bh=1WvjdW9Mx5rCDs4ryRQnEBXl7hdJ86vv3Rwr2lWNiTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c0/he0KE4tYsQGW6eF4e9GEiK3pW/KnI6Vp+DUZENHRK7QCBJUHi7egUrWHO2/MtiZoOlgxbrEyMrDquEBeLom3ULyKUtufAxQV4/7UxMUzG9Uoao9RSKe2Tfa/aCHGF5zyqxLK1oxqt3Hey7gWUGUTwyYzBvwfYqFADXZlfb/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z0AJ8SZx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc49b00bdbso41494075ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710338039; x=1710942839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/heQt+Db0ehDtq1JCZPcwy70snmGl2Z1H+WOU5UmOPc=;
        b=Z0AJ8SZxfVtjG/Fxm22gxUuyrKinQe3S6HmcMmxS04Bs/ME6jAyaoVDA7Q+loTYBOw
         bq1nNr9nAbrgumD8Ltvs5vibW9VYe43OWi4Hg1kaFvWIbeYytq4dq/WzVTtZdSTxxZ6l
         65A2XdzrrFSJ2LKkWv8NzyC/KM0CeVir4kuV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710338039; x=1710942839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/heQt+Db0ehDtq1JCZPcwy70snmGl2Z1H+WOU5UmOPc=;
        b=AQ3z2hJx3dcpsP8oTcd0U1isviYcrYLpegPKMmE08+bZLwgMyKIr5f2yBQhuW8Os5+
         TIE5bA73+45P1zPlD58hDkfqzIaIq95fC/4gty2yzHNmrBU8HMikZbQ9Smyrqoa2Qr44
         rM+j7oaz0P5QvR7FiMjCqXJoWq5RUH4zHRW5JhLcqA4lsjXb1LXbxCY5Ooj0MwzbWxL7
         Ox2BxgmeY4qTI6CI9r1UzDNCQajGkEFPMrIqYmmztLs1pjWFuHQxIgAp+/yY5PnpzYoH
         EeHgJyNgXaOQHdo7CPqnJVOYoykpqZImVlxLHaA2utJHwTdSteRwFCNiJSQoBaflE/2X
         So1A==
X-Forwarded-Encrypted: i=1; AJvYcCUcKjTRpfdv/Hb8XKvSQjp4RhewStEguvUtdG46aWu8eQuSrkLWyOCis4apJkJKQBuVpIruD9fPv0o2NQM9OLpBi9+ttFKhDa8ms5fY
X-Gm-Message-State: AOJu0Yy9vZE5YVpz4LLYgNnXW6zoBc1b9wUuf6HXd76+s7XK2PXsxsZr
	2D2JodE8AH7Cc5UyDaZWNxgde9NK6nLljLK2/myr1sbIClOBJgZr6lQslmlCew==
X-Google-Smtp-Source: AGHT+IE3PgaxgQ7zHkHAgGrWi0X7VbrllC27gi8LCOikz9dtE/g945xwEfsoOmxKeOZnqAPMvOWqew==
X-Received: by 2002:a17:902:f544:b0:1dd:aa58:a648 with SMTP id h4-20020a170902f54400b001ddaa58a648mr8030088plf.43.1710338039452;
        Wed, 13 Mar 2024 06:53:59 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:3708:eea3:d1b4:2032])
        by smtp.gmail.com with ESMTPSA id d16-20020a170902ced000b001d8aa88f59esm8632504plg.110.2024.03.13.06.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 06:53:59 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	devicetree@vger.kernel.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] arm64: dts: mediatek: mt8192-asurada: Update min voltage constraint for Vgpu
Date: Wed, 13 Mar 2024 21:51:36 +0800
Message-ID: <20240313135157.98989-1-treapking@chromium.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Although the minimum voltage listed on the GPU OPP table is 606250 uV,
the actual requested voltage could be even lower when the MTK Smart
Voltage Scaling (SVS) driver is enabled.

Set the minimum voltage to 300000 uV because it's supported by the
regulator.

Fixes: 3183cb62b033 ("arm64: dts: mediatek: asurada: Add SPMI regulators")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 43d80334610a..5cc5100a7c40 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -1448,7 +1448,7 @@ regulators {
 			mt6315_7_vbuck1: vbuck1 {
 				regulator-compatible = "vbuck1";
 				regulator-name = "Vgpu";
-				regulator-min-microvolt = <606250>;
+				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <800000>;
 				regulator-enable-ramp-delay = <256>;
 				regulator-allowed-modes = <0 1 2>;
-- 
2.44.0.278.ge034bb2e1d-goog


