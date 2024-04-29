Return-Path: <linux-kernel+bounces-162008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F408B5498
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED8D1C21947
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB472940C;
	Mon, 29 Apr 2024 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j1MObEsk"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B301805E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714384453; cv=none; b=GJJZqSyg7SCC+W3KTsXBWKeGesDCHXcT99h3QJ67ymeWDmWvLizQOFSpV6QezYmBwnlTYFTLPjQDZId+t5lvSgrdSLJJusU+pR39kSEK6ndmwzAxvcXpky6ql3mORCL45CRwi5CiFsqBiut37UpbrJTDgKjwAMFIGm0Ngt11RPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714384453; c=relaxed/simple;
	bh=6Vcg0heBQTZuMAZV/90OJ42YzsBiIRDDFrShHiCidxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IH1Ca7zroIcUQf8gIjfDpAn08CAX0UjRuYZv04gOqiwly92+wvTp2qNfGO38gVwuR40a6jQovc0OhxgIZmCkp1nd6PNwbyjWbbCWDpKjJm0sF+BXF6cZcFNy7qK0/sU2vrVgrscAI2cT04xEvVxtxOJ6NGqS/fUrwf63z08HReg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j1MObEsk; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6eff9dc1821so3958948b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 02:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714384450; x=1714989250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K9Tuxkuv5GP03on1LEPNW9dEztUbP1PxdWw89MgNsZg=;
        b=j1MObEskRJEbSqrmPhPIRPqjnQ66ocyQLzwzFHjeqUUGmuvW83MTa6aaPnFBQhRXtP
         IKUiPYdQp+MZCxfg83iwRuJdHGrsz8/WI8D/24ejAVNXZ2HbltSSri5szQdbVzhSoSGj
         5IjLu5n6yk5vIW4qEPDY3HOvZluTbdjKE7/hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714384450; x=1714989250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9Tuxkuv5GP03on1LEPNW9dEztUbP1PxdWw89MgNsZg=;
        b=YR2QaXD6Hz7yREeH9mIsUo4K3eUp75tE4vgy4ihrLkRjqUrb1zAZAD2yGFHvi5QFTz
         M1VJGfs0SC1uTXo+UCyFOUAtgbzNqHDbNEz9q0jWn5fgj/Hx2aXmo7T0jCti2Gb25OWH
         bqCucDpuVUlbORNdPB0f/AHvGJy4BQnWAp2vTlActHfAuU+kQQec8jZaBBID4zpTlubM
         7nyDeLON/QD5msRSWnislskZHrwjxQB0nyAveP7p7f2OTLV7iq9Wg0VgmurC5/7/fWkK
         n+MFrf8FDf9VLsAgTaAPsaMZW4WM6vUP1WKZ7v7jziYZc4EjRFUXxZZYdVp6ZidkpDci
         vYPg==
X-Forwarded-Encrypted: i=1; AJvYcCUE1Gna9txsmvbeWeBztcsmQGuu8/ZGR2LZfbounkUp5TmIBXbG7yd4o3ywThbO5+8j/C5aGHJ3sDyNA/4/s8rJfUX/jXwuANoW54nO
X-Gm-Message-State: AOJu0YwCPg3m0fupvNuXXQuIp9lvGQmo66+DEZPqZzpuJvHJxEn0mqd1
	MFZcfgOhntIzTOpJHuvibUlBTPU2rfwGFKhH2EEol4xGTGr1wi7L78PW+38S6Q==
X-Google-Smtp-Source: AGHT+IE8IGwWKDE8w65mqrsUHZCWFhQYSBQsWdqW2ncfFU1qhQ9LU47X0Hj6sRPRPpb9Jccy3pViug==
X-Received: by 2002:a05:6a20:d80f:b0:1af:3d3f:83f1 with SMTP id iv15-20020a056a20d80f00b001af3d3f83f1mr5737629pzb.44.1714384450196;
        Mon, 29 Apr 2024 02:54:10 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:38e5:4a2b:ec4a:2ec9])
        by smtp.gmail.com with ESMTPSA id c7-20020a056a000ac700b006eb0027f2b8sm18932083pfl.9.2024.04.29.02.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 02:54:10 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] arm64: dts: mediatek: mt8192-asurada: Add off-on-delay-us for pp3300_mipibrdg
Date: Mon, 29 Apr 2024 17:53:31 +0800
Message-ID: <20240429095333.3585438-1-treapking@chromium.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Set off-on-delay-us to 500000 us for pp3300_mipibrdg to make sure it
complies with the panel sequence. Explicit configuration on the
regulator node is required because mt8192-asurada uses the same power
supply for the panel and the anx7625 DP bridge. So powering on/off the
DP bridge could break the power sequence requirement for the panel.

Fixes: f9f00b1f6b9b ("arm64: dts: mediatek: asurada: Add display regulators")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 7a704246678f..08d71ddf3668 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -147,6 +147,7 @@ pp3300_mipibrdg: regulator-3v3-mipibrdg {
 		regulator-boot-on;
 		gpio = <&pio 127 GPIO_ACTIVE_HIGH>;
 		vin-supply = <&pp3300_g>;
+		off-on-delay-us = <500000>;
 	};
 
 	/* separately switched 3.3V power rail */
-- 
2.44.0.769.g3c40516874-goog


