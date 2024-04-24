Return-Path: <linux-kernel+bounces-156139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BE48AFE69
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964CB1C23187
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8541F14A85;
	Wed, 24 Apr 2024 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="mluAJXul"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A842A21
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925823; cv=none; b=e2PY11qWh7r0fKrZOKkxgDTJajh4gmPBWsmVJMBtpcvrsqhOUISaHOOX/fZ/J1YNLm4DxmqqHbNpTLG2Dm6pYgt7B6LoJchYoVrMZkNEH3LvGSmosDFSYVazrfvgR2dm/rvx9xthSrhgcGNuGwFZiu6BNW/GGNMKBzv/DT5kQ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925823; c=relaxed/simple;
	bh=qsAAdSnJL6ZqG7ZaQVy29k94/mQH2Dt1qXPoheqilJU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gst8t+anizZXtrNjZHO6jzTlo5+a00ODKHYbCHqYrZGU8c+frhC4UMNjmatIWDDfsZTu0kf1By4QB9FG2u6VEurvpCjD7DSHC8jfG6AnLINc38QliFDbB7WnKDrdafFAi4rcmzPXMv5t8OMNEMiehohAyt3Nuj8ljM6fHGlnXb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=mluAJXul; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36b31df33a7so32171985ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1713925821; x=1714530621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SDuDS/PYysgnwfhzRTemDNx6xn19xsq6wPCRMweWSlU=;
        b=mluAJXuloE5hhszHnPy2/gwVMxO1Ymw6PsX2bgT6jQYUncdT1BeE821aowaxjjB5V7
         Pf5wkBZVTimdprSyFSv37cwJ4srXpqXsx+eBdRURHQmiruaAkqALrZo9+X+nw7UXQER5
         /ad0bmi/5R9phBo4aK4qCZDk1UqCW5SzP+5RXPrKlvDBchYoKyi+mqCoEZr1vghvtiXZ
         1hg0d/AeNzWM/3vMXYQ8ujjK7tR+9y9X6ZvIlzEk2jSJQSBE2ey1i6byM6Dn6qL8cemu
         DortxmyTFhnEwLw6yqGoSk90vQ+V9WBB3STnegFZ2dFePiFCXUY2FyKhBjzPzEECcUp3
         AO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713925821; x=1714530621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDuDS/PYysgnwfhzRTemDNx6xn19xsq6wPCRMweWSlU=;
        b=NaK/eAltrfEwDFDfeLSCoXl3RoCXgPKctJJt95crNU4HyiWRt/VFhNxPaaxKWg8NVW
         R9ti+wPTSzZL1/FIT+FxEPGVew9dSd9DsxfhmRMdFrU6Jx0JCBKPrWCGniHjZpwKhhpD
         zw1P+Mjm0hto9twPuRWWuqt83fTni1xlBH4ue/c/0RZI4hwDHWGdDw8k0obIer4U5R3H
         2d9slkv1qaSQz/pWT0wGqapW92MTZeb9sYANPQaAyCKXpKxUnaIXV4ktZ9cEz0AWVYd5
         tQAsalOCXP5YLfc6KFggOqs79LGfwyLPQhJXO9sz+PL24/juzpFzuimjRpNhpKOO9+or
         Lvkw==
X-Forwarded-Encrypted: i=1; AJvYcCXXK8gznX0MIuAoqzagTgd3qR3AQ270tq368QiJM5ljlJu2rjSIAwUUfGOKAbRO9hj6xt1SnvOO2a1/ECR+Qftsrh0ohzJFTx5rQ1ky
X-Gm-Message-State: AOJu0YxVkNh9kyen8MJsoR4xbdBrN14TYDAZ6jfbAj1O8OMJkG+cSv2k
	ZIbpuC7nDbm9ZdIp/KfeWH7QOrLWsUkO4/1RABuUQtydP8KcDiWhbpE7hDyYOuQ=
X-Google-Smtp-Source: AGHT+IFXTkr92CHcVMQccZURFuLiL9561gpJ8Hww/IBjkIZpKLRRVpOQs+UJOZ3+zGkoCoF2aLpmPA==
X-Received: by 2002:a05:6e02:188f:b0:36c:8d6:3641 with SMTP id o15-20020a056e02188f00b0036c08d63641mr1544845ilu.30.1713925821441;
        Tue, 23 Apr 2024 19:30:21 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id m2-20020a638c02000000b005e857e39b10sm10179385pgd.56.2024.04.23.19.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 19:30:20 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	linus.walleij@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v3 0/7] Break out as separate driver and add  BOE nv110wum-l60 IVO t109nw41 MIPI-DSI panel
Date: Wed, 24 Apr 2024 10:30:03 +0800
Message-Id: <20240424023010.2099949-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Discussion with Doug and Linus in V1, we need a
separate driver to enable the hx83102 controller.

So this series this series mainly Break out as separate driver
for Starry-himax83102-j02 panels from boe tv101wum driver.

Then add BOE nv110wum-l60 and IVO t109nw41 in himax-hx83102 driver.

Add compatible for BOE nv110wum-l60 and IVO t109nw41
in dt-bindings

Changes in v3:
- PATCH 1/7: Update commit message.
- PATCH 2/7: Drop excess flags and function, inital cmds use lowercasehex.
- PATCH 4/7: Update commit message.
- PATCH 5/7: inital cmds use lowercasehex.
- PATCH 6/7: Update commit message.
- PATCH 7/7: inital cmds use lowercasehex..
- Link to v1: https://lore.kernel.org/all/20240422090310.3311429-1-yangcong5@huaqin.corp-partner.google.com/

Changes in v2:
- PATCH 1/7: Delete Starry-himax83102-j02 from boe,tv101wum-nl6.yaml, add a new bindings file.
- PATCH 2/7: Break out as separate driver with Starry-himax83102-j02 panels.
- PATCH 3/7: Enable HIMAX_HX83102 panel.
- PATCH 4/7: Add compatible for BOE nv110wum-l60 in dt-bindings.
- PATCH 5/7: Support for BOE nv110wum-l60 MIPI-DSI panel.
- PATCH 6/7: Add compatible for IVO t109nw41 in dt-bindings..
- PATCH 7/7: Support for IVO t109nw41 MIPI-DSI panel.
- Link to v1: https://lore.kernel.org/all/20240410071439.2152588-1-yangcong5@huaqin.corp-partner.google.com/

Cong Yang (7):
  dt-bindings: display: panel: Add himax hx83102 panel bindings
  drm/panel: himax-hx83102: Break out as separate driver
  arm64: defconfig: Enable HIMAX_HX83102 panel
  dt-bindings: display: panel: Add compatible for BOE nv110wum-l60
  drm/panel: himax-hx83102: Support for BOE nv110wum-l60 MIPI-DSI panel
  dt-bindings: display: panel: Add compatible for IVO t109nw41
  drm/panel: himax-hx83102: Support for IVO t109nw41 MIPI-DSI panel

 .../display/panel/boe,tv101wum-nl6.yaml       |   2 -
 .../bindings/display/panel/himax,hx83102.yaml |  77 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    |  99 --
 drivers/gpu/drm/panel/panel-himax-hx83102.c   | 889 ++++++++++++++++++
 7 files changed, 977 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-himax-hx83102.c

-- 
2.25.1


