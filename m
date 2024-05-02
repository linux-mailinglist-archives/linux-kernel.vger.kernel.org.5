Return-Path: <linux-kernel+bounces-166659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1588B9DB3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89D0F1C22201
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08ED15B56B;
	Thu,  2 May 2024 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BwXV3xiN"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AB115574D
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714664706; cv=none; b=PUXdG2PBqSwxa+raMWSR8GbnMevwgkawcn7jcZkNTV2oLhfYb5EnyKBi5dFU0b6Bx7i24pZDHu0b7CTmOB9egoSle1IQ+mc4dN44DoQUPuRSo9zw0CWarGYjYDt05scZtNsu4gjrHCD+UWI9/zQGPijHfGqofgIdLa/Rv6xKAp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714664706; c=relaxed/simple;
	bh=Gpu0Hivw2WMkBjrWlt3F4okzBlo59nzVUjsQpo/rA8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YUFF0WjaqIR7veW2RnBsHmfAhynIc1F5T1xmzyzE/GsbazG5V/+jBzypgp3Q6eLSfDEXrYRTinVTtVtUoL1AkayMSBSUlc+jX8MyaQn7zPgJ0tSdHcLfoeON3u3eHTquMm7d0ypCzeY2FjDk84fYYvfpOpqejxWnnuTkOazmsmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BwXV3xiN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ecec796323so7776194b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 08:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714664704; x=1715269504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MOqLq0lZ0i7PXhp3YLh0UdxAncxBGq3YXZCOMwkygc4=;
        b=BwXV3xiN2lH6vpFw4linXe/2giOmlkrz9B/K0316slX0wNhlajDFX7X2x1bdJuFZ1D
         diSQSoDVrctCou7cNjL/X58/a1kZzpb8IIPCGHec2A5AWMdsqH+sMWkCw4DrUapjuU2a
         vVo1pRnLvgBwJC0IIFNhNOHabhV0bDDHEx5E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714664704; x=1715269504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOqLq0lZ0i7PXhp3YLh0UdxAncxBGq3YXZCOMwkygc4=;
        b=kHRmGS5dHH3Ovnoe7pTWQuAMcHMsP/Kz+14+z0r/a/oH9beE4zKMcWkXxAFfyU3XgX
         KksLzdPrn2yNzu2d+55VZZZssD/q81cYRbGzgJzejMoBhd2KbJ0RHt+rsDbytztrZx++
         5IkRlpHdQaM+tIKaPJCqoAkgEjBTG9VYtlu+zN9D9ilUItPWoOynOp1IPA37RydE6Ter
         e/cq82nvY44zSzEA4bnUkpVJH0617fQjCHWup4xRkkfRMCknO+KAx8ISSS+KQet+2dIF
         hXueSTNCnKJT54S0wn0jUjZyCG1gOPM0508fqx5k3ZzmOrHd7iChUH74YPBoc5SgtrpA
         t72A==
X-Forwarded-Encrypted: i=1; AJvYcCUW0lGYrIwWmVsU8/OQHoTpdVnXwzWM1IV4s1o0hkhsncNA89qFHhBcRrsztQro5uqUhBP+Er/d1FLqzpabC+G3e/+5bOdhFXatP/WZ
X-Gm-Message-State: AOJu0YyzpPkjx8+YNlX//4nZvmnh3om4epROYBkex5UFKksvzpaLY4gV
	UfzRuqi4k8N+wM2fDQ2ryk4BpV3fCWLKNoMmECqKWXP6NN4MTlI34UulaRQFeg==
X-Google-Smtp-Source: AGHT+IH+DKW/P1R56uRTZhYtqEUAHiBxc+2IZYShyGS2YIDsx+eMU2ct2kjiiYu7bnTgUSejCrtSrw==
X-Received: by 2002:a05:6a00:2ea6:b0:6ed:1c7:8c65 with SMTP id fd38-20020a056a002ea600b006ed01c78c65mr7064701pfb.10.1714664704045;
        Thu, 02 May 2024 08:45:04 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:8191:2b1f:c04b:51ab])
        by smtp.gmail.com with ESMTPSA id h4-20020a056a00218400b006f3e3d928fesm1387660pfi.220.2024.05.02.08.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 08:45:03 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	linux-mediatek@lists.infradead.org,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v2] arm64: dts: mediatek: mt8192-asurada: Add off-on-delay-us for pp3300_mipibrdg
Date: Thu,  2 May 2024 23:39:51 +0800
Message-ID: <20240502154455.3427793-1-treapking@chromium.org>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Set off-on-delay-us to 500000 us for pp3300_mipibrdg to make sure it
complies with the panel's unprepare delay (the time to power down
completely) of the power sequence. Explicit configuration on the
regulator node is required because mt8192-asurada uses the same power
supply for the panel and the anx7625 DP bridge.

For example, the power sequence could be violated in this sequence:
1. Bridge on: panel goes off, but regulator doesn't turn off (refcount=1).
2. Bridge off: regulator turns off (refcount=0).
3. Bridge resume -> regulator turns on but the bridge driver doesn't
   check the delay.

Or in this sequence:
1. Bridge on: panel goes off. The regulator doesn't turn off (refcount=1),
   but the .unprepared_time in panel_edp is still updated.
2. Bridge off, regulator goes off (refcount=0).
3. Panel on, but the panel driver uses the wrong .unprepared_time to check
   the unprepare delay.

Fixes: f9f00b1f6b9b ("arm64: dts: mediatek: asurada: Add display regulators")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

---

Changes in v2:
- Update the commit message
- Collect review tag

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
2.45.0.rc0.197.gbae5840b3b-goog


