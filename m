Return-Path: <linux-kernel+bounces-153042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BCF8AC844
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB304280B94
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B223524D3;
	Mon, 22 Apr 2024 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="09Rydp26"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0861EB37
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776603; cv=none; b=X8O0vh8i+iXcyYo0TWdrZWXpSYhZ297UtWueIp3pSdumKnPhWtPKNbopaX81qO7Yn0+kA9XFVirYlbwcuRqns9imQlZUiS4b7JMMOc9At4IUxHBzpclSXKbeT385R1e9cKQm59mknGzvJKulWGjPpbCE73ZXO4gbcpOOhevqsbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776603; c=relaxed/simple;
	bh=AvHxlzhoLS/TWU14vt1mwPlJju59/EIqKNjwsTGrb9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AuDrhsfUbC2u3xUcTtTo2OYuPtIWl8UHF9QEmajK8lKrpOi12jrbRblGZ0FKxKcFixzT3/4Fb+ZptilB2c0Z66wcaCuDGl9zqNzkhrvcjUoGVQ9nhVQeaIZ0Ycw9/3gVDulZFprzVwyhiGXWXEVEKzaisumIa87ymMdSqg6dKqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=09Rydp26; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e5aa82d1f6so31188235ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1713776600; x=1714381400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zShzprvocFR15NkBJxriMaUREG3UA4nsglZt6D8YZXU=;
        b=09Rydp26GY/EvlR7PSavykhv47BxX0+z2LdAR2ONyRjRpO+RMT+5PJ7U3zA6F1Tjb8
         r1MP7SrM53Ba0+oSYLfkY/FvkMwd7VcjU7AHXTPyMq5PNJ5pmlbPkgMgnWY/Gigbg1cY
         lHOGZdYlWG4wFtOekP66Xf6/h0U9pB34BD2k6wryeAPUO/8/jdypOKsW3k99ZppStrIa
         J9wh9dZtypc8qy1sYIX+vuU1GE0GBf+elz0Y1UGMT1VMWdq1skEYVXmf/3o2cFQfck3d
         S3dbYWdBNFtzpjCXOm4NB/fu0UVyoMAsmjk9321Htmq7EGesGfRxBKteHfQtqZJMLBgO
         NRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713776600; x=1714381400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zShzprvocFR15NkBJxriMaUREG3UA4nsglZt6D8YZXU=;
        b=TAKBqyF1M2X/vZ1wMVWCw6HGj7j5ZT4K9FAqtoGk7PqP8N0xkLBp8kC2TJlv4XXVpD
         4ZvY8rxTEx9o8rPYS9QTGUMJoluQhWfq/bbmI6J15ASCGWEd7fmxcNV+Qf57/dgTgFEC
         X4HSLrDa71JKO9DMkoLFRwe7b58hm5Wdax3w8N6Nb4isRbOtX72a5DMF5uGy94zkJszB
         wWjo1T4hTH3yhQrWPTw5NhYn8NQnHKe34Cxd1KHmFJIK2lAmz4sMA8cU/KDk7hd1+R6C
         8MkHcF/v16EObMjfnPQqpAM/PyfQo8OBsb1KHtFy+W5zNN4r7n/DFfe55cMO1Cq5m13D
         NOlw==
X-Forwarded-Encrypted: i=1; AJvYcCWYRQPdG96T+iKkhio4gVG9m3NNgBxLzK7F63Xr90WRQ0bpu6YRY3/+6VzvvwCofFoGTtCBpRJJjMebV/KTpJcyKRYTuf3DZ0ow9T2x
X-Gm-Message-State: AOJu0YyyymnfJGTA+PVAjWTx3m4X87TyLrOPGsRbBpX8VtmAwj4wYKR+
	eUdOxRh/eUdaTMpxHw4DU8OMKJw2Jab3/FbFt8AUjyEfDRA8CT8miO5FLG1mQOc=
X-Google-Smtp-Source: AGHT+IGkZLhJ4wqK/T/b/O9cZ3in5wv/8f9RFCQdHdixQXCo29pNUd8HeX6R/LOTeGqCRZpxw9/djQ==
X-Received: by 2002:a17:903:234e:b0:1e5:e664:9c12 with SMTP id c14-20020a170903234e00b001e5e6649c12mr19449363plh.0.1713776600255;
        Mon, 22 Apr 2024 02:03:20 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id by42-20020a056a0205aa00b005fdd11c0874sm1919137pgb.64.2024.04.22.02.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 02:03:19 -0700 (PDT)
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
Subject: [PATCH v2 0/7] Break out as separate driver and add  BOE nv110wum-l60 IVO t109nw41 MIPI-DSI panel
Date: Mon, 22 Apr 2024 17:03:03 +0800
Message-Id: <20240422090310.3311429-1-yangcong5@huaqin.corp-partner.google.com>
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
 drivers/gpu/drm/panel/panel-himax-hx83102.c   | 943 ++++++++++++++++++
 7 files changed, 1031 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-himax-hx83102.c

-- 
2.25.1


