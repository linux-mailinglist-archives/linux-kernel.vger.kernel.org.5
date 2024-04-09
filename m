Return-Path: <linux-kernel+bounces-137014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0C589DB1D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918C7288955
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CBB13B5BE;
	Tue,  9 Apr 2024 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vvL0/IEw"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D1913AD01
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670163; cv=none; b=AtKc0h+pMrRy1HFqqumhTa0JRCwb2pkcJj1loGXnld99c5xY6nCwHGD9dg+Lhxpf7xr+LPMeRHuvFv3DDpXWX0PEi4HxDcLqqvwqrcNZ/bL2/6cktWTccxCJdoxD07skypZD1tJAC206aUbTK8Ai+S56Dqq9nIRiDo93HOkNyzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670163; c=relaxed/simple;
	bh=9JiWubCt7cv90b13bkV2NJN74YeswiFHCbXLjZUbZs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XjzUjfmzFVhniZot6dOnscT9A000yNcRFXAYrD33z9G+prQiLw4XD6Bs9NQWLp0pvinj9ZpSVkVbTli1hQu+d49aKk4wXsjfqy9lTTqFL3xEMJMZA1m9A73Fgi7o4jQyqRc2ReavCjogAOcjxUlOb1rCqaipzW0aqOqQkApzvpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vvL0/IEw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-343bccc0b2cso4090507f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 06:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712670157; x=1713274957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZUgXZ3l9DX2S4a80uAdGLWMlbvZfcEw87Whhx0PSEo=;
        b=vvL0/IEwHIiUs8Iu+aVS7+B6/BFlrcamqiLGEgGzpUGWwoJlcGCp1lGofsH04f3+3V
         6BrcEE56ewG00iDmh9RaPeVrbHHqC1fxbnQ6nVtc1fDpUk4MFCRC/FU0pIXv0hlrryKp
         H+3RJKKjmvtWm+OnTj4FzTBXj/lJkXOJpuwKsqYBchS6vgUck6N/YEgqHgKff2wtZCCK
         LYr8psEUmrpl7W8Nv1JwZzyhF4YLimODMo8gQ/veKqj8ap7Eqqa1yPXBQiZMuRFkeO7o
         Z4iEdwtfuiaz8W8S8q+XDMxJHPO8q3pNocCZuf09gUK4vVLiOlNp3Ba4N7U6uaA2eoyc
         Rltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712670157; x=1713274957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZUgXZ3l9DX2S4a80uAdGLWMlbvZfcEw87Whhx0PSEo=;
        b=QR/UhtT6R30AWh8fH1bed2QtCvevFzCh5s+1g3AItsIh7+emLpGYdNaw6hw7jHoJwS
         agmRX96IMtmVP4Xpi5Wux8ONp27hfYuLa1eNDy6BldlhkLNj77suDap0kP1q496aGyK6
         1+TjNpsu6s+zDLm+pbf9YeMC/hOshLAvBYF0B8/oUtNUx6exrzw3gIcu9pBnhGzA9XWo
         oskuhQScYF2VHm25eZY/T4nxLtlscuR/uBPYBZNI4yD9INTZ8x7YLKKPrhzC1KKUk4Fz
         C2QZ+WW/LkG4xHLQIYUnCm3fq+dIrMlOQF8pviqF12RzV9r+Tnq07ZuJCNRzQuGWyIVX
         KvWw==
X-Forwarded-Encrypted: i=1; AJvYcCXa0mI8JKCNE6lQjTVw6N9CssFNe0Hl1hr77vrfZdcOfWzwCVElT1SGt3J7U1yGtrXXHprKaePd6rg6jUlEgGTsWUDIyO5muvq6Q6xQ
X-Gm-Message-State: AOJu0YyavR87qTspQrajrJQV0jSZ+gAR2kp8BnwVjyByDKbrYUrs2dfg
	Y5r1zIS5l34+PvUCI220db/U6rXzCnWdRRJiPW/VGEM3b4/vU+k/fNS95BfXmkA=
X-Google-Smtp-Source: AGHT+IFGjlvzbCOfjHn4TQ9oMwjpMQVJxWx5NSO8PTuMLqRsu3gSTek8o/Yb9Gs7WCNj9tkhxldYSg==
X-Received: by 2002:a5d:5f46:0:b0:345:b238:5350 with SMTP id cm6-20020a5d5f46000000b00345b2385350mr5028344wrb.5.1712670157486;
        Tue, 09 Apr 2024 06:42:37 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id j11-20020adff54b000000b003433bf6651dsm10753579wrp.75.2024.04.09.06.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 06:42:37 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 09 Apr 2024 15:42:14 +0200
Subject: [PATCH v3 16/18] arm64: dts: mediatek: add mt6357 audio codec
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-audio-i350-v3-16-16bb2c974c55@baylibre.com>
References: <20240226-audio-i350-v3-0-16bb2c974c55@baylibre.com>
In-Reply-To: <20240226-audio-i350-v3-0-16bb2c974c55@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=927; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=9JiWubCt7cv90b13bkV2NJN74YeswiFHCbXLjZUbZs4=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmFUWsBB+INxE5vCY/j+/NRlA1Wr5ahF8ESuy1jShl
 bI/aFGCJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZhVFrAAKCRArRkmdfjHURVwpD/
 9R7oL/mcgCA9hRwOKkrw1uc6s3UD1+x2wFhNB4vjNy8u/4LtZ6Si+Sz0wtbTuuZa81yYKvN5FDCXv6
 5yOO8IMT7TcZEqIuh080vc0ijR9sRDwaY8HjSgssSoqaDM1XMRhBipn+Ng58Jn2cc5uLtCC5ZtKgtx
 x5J7GafmxgaESLPUkh1dx3C8LhefYmZytIUINT0sjddpb1YaioLh9bHNfo1va/OpWMYfe+0guWf8Ui
 p8xVppXIjFa75KiPl1iBdS7RfxKf7PjCuMpAcQ+YMmhXBoEBgtsW9ChZTFqRThZagJu+0ZwveZE3sL
 6yv5PhBoOQRYwa3fo9Uh7L7HqlMFdhZl9f5zAx2afaAZZ4SsiMWH3ujDpINYnc/WUtBs9Rm8H8+CdB
 yizDvl+Pavx1zsHdfWGnbuA6+FooIUbrCl1+4I05iw7CsLuc11gLDwtEHgdGLnxX3k1ENGYlHer8Vi
 PNNS96zmDfhiDZVZMaZ3wUe/u4Pp76ZO5NJyheitbq6V0xjnVaapjXcA/TIvMB+YsyKFJ9SwZooiZT
 8V5GDMXNLep+3NcXD7KWDIuTO0fE3q7u/XnT0xV5LpFvUKJlSJMCoH/uK5l010GZtd18VfuLr//lcR
 U5b/D90TT9SgcqEyTYoLmIiRysTnoW4CcF2+4ZQp/TZGtHpw2+ZPyiSM88Cw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add audio codec support of MT6357 PMIC.
Update the file header.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt6357.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6357.dtsi b/arch/arm64/boot/dts/mediatek/mt6357.dtsi
index 3330a03c2f74..ade410851524 100644
--- a/arch/arm64/boot/dts/mediatek/mt6357.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6357.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
  * Copyright (c) 2020 MediaTek Inc.
- * Copyright (c) 2023 BayLibre Inc.
+ * Copyright (c) 2024 BayLibre Inc.
  */
 
 #include <dt-bindings/input/input.h>
@@ -10,6 +10,9 @@ &pwrap {
 	mt6357_pmic: pmic {
 		compatible = "mediatek,mt6357";
 
+		mt6357_codec: codec {
+		};
+
 		regulators {
 			mt6357_vproc_reg: buck-vproc {
 				regulator-name = "vproc";

-- 
2.25.1


