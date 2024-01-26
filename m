Return-Path: <linux-kernel+bounces-39665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B4783D4D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6D51C218EE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751E614288;
	Fri, 26 Jan 2024 06:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bxpTrb+M"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B22B1D54F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250907; cv=none; b=dNsunUiIHjO2Llv/8/R0oKAsn55DQnVfBohG2i0KEttd54Z4gqnAIyWPf+JTrOBCJrSikRWhMC+X33hAJgf4wIlAx+kAshSqrTQ/UZRV9vwL0ocpI82Tie2BA7NnBWJBHZPGTs37g5onyFNd6IBelZhqbGTiet9DAFY9z+UUkco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250907; c=relaxed/simple;
	bh=NH2euUCqwPzQ8EOeRcSGE0TtlrdDDvu0F19oCXj/2VM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JYB+/9W8fwgKrkd+8ek9+g5157RLr8Wm/iP9G/ndNlnpLx1qFiIvOgJHswxO6XWXDVJug3C4/a6dBRf+VGegNSgpWaF5GmPKipkpYdvHDTEWBDRNUv6hNotUnhi9/jiYOi20dWr5OKCECeGzEbzs/gTlEDcc0ifiunjZgzaXvGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bxpTrb+M; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce74ea4bf2so36804a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 22:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706250905; x=1706855705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ySgp2UiszzMfNCnD6O5mfCcxxHNvIaL6WmT8mRfAk0M=;
        b=bxpTrb+MRMOYJIzkdauCkxaRZKK01HcEuQMG3e070C9PhDFEutxkdCGlJK8NSYYFcc
         8vx0bH2a/ZrlIG/rdsbLbIwEhWHY9XZkwA5o9+LvuIc/H8rgRluf5iDRk6Dkovr7gnFH
         xWjfxdQiW1+Om+itQt9LKXpd6ld3gNTjBLfok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706250905; x=1706855705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ySgp2UiszzMfNCnD6O5mfCcxxHNvIaL6WmT8mRfAk0M=;
        b=fDaZ10ScEEDMns9Oa3U6c6NcY8RPSkL86sIrfhyvnkL9y70uHl8SJupccgQRD1xHDp
         1p7vV1l4SthZbi7DDCCpd+XNLGp0c1CADCS2nWv1o9jabxjZZ11G2PIDaR4CNn89EYke
         tNdpVW3g7RIUGkZv4/JVHVAFnWS1CxwSX84llIbv85pWRMQT46RN+6EkznQC1cyNef22
         k9NuXVh2tNsxHx3VBJtkwnTQ6XfDnCQiPCAxSAzpik4IgOwgEmuMRbtpMeMavVPsd4lX
         QL5V4TczM2KAmEQpdiTMezUgAecDViff25M3DxU20+/JhjtAdCYHTKFTKlaYkfaBGg34
         FoIA==
X-Gm-Message-State: AOJu0YzNfDeiS2F+tqYLUcAMNeVU5fV+gzwr2Z/Xc7i1miWEUdYS+pKG
	800kcrFMGnr5YOpTuv8ecDZxyaIT1qLeV+UaUtiyl3kxzGiaJlKPui/5In3Pug==
X-Google-Smtp-Source: AGHT+IF1szoUbF1JDZy6toVdzGRAw8HhVOL8J8FWhgQ/IhKqWQPq084VnvUGMXytbOdxbOyYMcX4MA==
X-Received: by 2002:a05:6a21:3987:b0:19c:53ab:d7d0 with SMTP id ad7-20020a056a21398700b0019c53abd7d0mr684905pzc.50.1706250905647;
        Thu, 25 Jan 2024 22:35:05 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2614:bbbd:8db2:1f54])
        by smtp.gmail.com with ESMTPSA id ka3-20020a056a00938300b006db13a02921sm488735pfb.183.2024.01.25.22.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 22:35:05 -0800 (PST)
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
Subject: [PATCH v2 0/2] bluetooth: mt7921s: Add binding and fixup existing dts
Date: Fri, 26 Jan 2024 14:34:56 +0800
Message-ID: <20240126063500.2684087-1-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This is v2 of my MT7921S Bluetooth binding series.

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

 .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 53 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 .../mediatek/mt8183-kukui-jacuzzi-pico6.dts   |  3 +-
 3 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml

-- 
2.43.0.429.g432eaa2c6b-goog


