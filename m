Return-Path: <linux-kernel+bounces-142145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3462A8A280E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65EB41C23D33
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D094DA1B;
	Fri, 12 Apr 2024 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AORJLYS/"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FEB4F8A1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907058; cv=none; b=IULUTCacg+aqhY73nq4rEdXHb+8qb4iOnrXc7rOE6NWrQyM5vW/klZt5jJTG23lrEJ0acDbYP/rHtsZ9kbI8j6ZpY/NjARHsXyDHXIcG7fAgD6cZGi1OCUbM5UyKZeTUeZoRCbDiHdTjw2amIzXQcWahhWd7suapxiK/jrbVOow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907058; c=relaxed/simple;
	bh=ELyJ+CJCoG1IVqX5X75YSbhALkKqT4a5dFGLgQ4/ZnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XEMMwl7y19hW/Luq7LbbDHB9zrMu3J6v6KZE6ltYSDAv5sbACQGwL3aTgEO28xs0O0SiTJjbzbYUFAGSK1QA7RkmHUprbE3SQzFHDlhGms6qXCwbxMKsq+659JB56+uOLhn+o4OZF20GOpxqRluaylSRvAFzpFTmp8KOHy+levU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AORJLYS/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso630237b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 00:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712907055; x=1713511855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0kD8JSa/wlHNA1KdEJbBxgwZ9LZz09AqTXMn/5iB0iI=;
        b=AORJLYS/dU7fiuNfY1ETrdUwSLycDelJzn+mTsKDfbxyLAJLph9H4SvFMzzPZAaZzd
         zXDOb1GbJ6gGbUo++HWnu3mwBFMod1FhB7zya0NmI6kNi9Of6yA3YGgep1spOmwJdAhK
         SDetk1ghfShTvJRWYQs0wWq/IJuEMrz8JpIWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712907055; x=1713511855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kD8JSa/wlHNA1KdEJbBxgwZ9LZz09AqTXMn/5iB0iI=;
        b=FVZPZizkwPE/NbkDxBJU0jiD3WLT4OipJSHTGpGibMc+x+EeLYFhBzgjgRPIhkwTE0
         NcI0pnePudKxSpB1/N1FwbSrnZkn727OW9Drc//nXnSdKfOpcTZHQWwldM6hkftABEFL
         ZCxBasaSanL0Ujp5ivDvQqFv05tWiAhnJkxAUq5i+UrIvwHK4Khi6vYroeKVboT1+T+I
         a9S9M+TB1YP8RgnSJBLoL261HPctzxoRjNo7YsfUx/h/WoxCqOXKIvxtY2ccj1Bo9PKj
         +l4MEiWN1AEotWxJKSxZFrC1ZFU2DAd6EPHkUDNqGdRSO6L1dV1hCldvJuBiL2JeNaQn
         eYWw==
X-Forwarded-Encrypted: i=1; AJvYcCUlJtd451UJkUQl6+tuuo8K4kfDc+l1ZAN35D0KQpJeVzLbQv1khJKpkW6+6ZCEf4jVV/jOYN2R9UuzHWYFmyqkgjHnydDKEItpny42
X-Gm-Message-State: AOJu0YxcnyciFMCLV/PTHuPZk3CbRrrwXuv/t4FPCluDcPad19QK5YdO
	DecN18m+tjbcdXQFtu5H8+CUQguZjUJcLxEtkFnyuROr1uYuOQ/eEOFDJc3fPg==
X-Google-Smtp-Source: AGHT+IH9TJ0GU71I2lqJVSkEubfs2YUSVV/7k6TyMcFaUg5ykPaPZHNJ1QhyNg9VCsr2/J7KXJRL0w==
X-Received: by 2002:a05:6a00:3d44:b0:6ea:e841:5889 with SMTP id lp4-20020a056a003d4400b006eae8415889mr2368095pfb.33.1712907054781;
        Fri, 12 Apr 2024 00:30:54 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e3c8:6e1:dcfa:3e8c])
        by smtp.gmail.com with ESMTPSA id d6-20020a637346000000b005d3bae243bbsm2149609pgn.4.2024.04.12.00.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 00:30:54 -0700 (PDT)
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
Subject: [PATCH v3 0/2] bluetooth: mt7921s: Add binding and fixup existing dts
Date: Fri, 12 Apr 2024 15:30:41 +0800
Message-ID: <20240412073046.1192744-1-wenst@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This is v3 of my MT7921S Bluetooth binding series.

Changes since v2:
- Expand description and commit message to clearly state that WiFi and
  Bluetooth are separate SDIO functions, and that each function should
  be a separate device node, as specified by the MMC binding.
- Change 'additionalProperties' to 'unevaluatedProperties'
- Add missing separating new line
- s/ot/to/

Changes since v1:
- Reworded descriptions in binding
- Moved binding maintainer section before binding description
- Added missing reference to bluetooth-controller.yaml
- Added missing GPIO header to example

This short series adds a binding document for the MT7921S SDIO Bluetooth
controller. The MT7921S is a SDIO-based WiFi/Bluetooth combo. WiFi and
Bluetooth are separate SDIO functions. The chip has extra per-subsystem
reset lines that can reset only WiFi or Bluetooth cores.

Patch 1 documents the SDIO function and the reset line, based on
existing device tree and driver usage. I listed Sean Wang, the original
driver author and maintainer, as the maintainer of the binding.

Patch 2 fixes up the sole existing usage of the compatible string by
making it a proper SDIO function node.

Please take a look. Not sure which tree patch 1 should be merged
through? I suppose with proper acks it could go through the soc/mediatek
tree together with patch 2.


Regards
ChenYu


Chen-Yu Tsai (2):
  dt-bindings: net: bluetooth: Add MediaTek MT7921S SDIO Bluetooth
  arm64: dts: mediatek: mt8183-pico6: Fix bluetooth node

 .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 55 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 .../mediatek/mt8183-kukui-jacuzzi-pico6.dts   |  3 +-
 3 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml

-- 
2.44.0.683.g7961c838ac-goog


