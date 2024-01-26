Return-Path: <linux-kernel+bounces-39706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB4583D529
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC5D1C25D0D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A0857317;
	Fri, 26 Jan 2024 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TzqOmKfl"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2394D134AD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706254521; cv=none; b=kKQ/AJHq5GxHlSorgardBfrJ2OtwFqtEThZQZn3U9Ct9owvFtq0v9sfDp66uyQGd2NcEB/Vf/1qse/28AtXgm34uZfp55ntE+Q1WLG0LHvHxShu4qMn3BD/7d0qf6tj4W0WaVgdu5tFUxgYacSfGaH/adSzXV8Z1taK3OCjD590=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706254521; c=relaxed/simple;
	bh=CN7eRsF2RUuCp59wm9aMwYGQrieE8Tt4W8JYrmNcByo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MFT0a9hETZqIlE5xNzVqVnoRKKJfTzOnZnYkqp/wJ5dmezyaJWpFXc3Yr86aVvCTAU7mFMpe5ddfvAo4F1pDbDGdBgOFD9roULAV4GtrUyBx46xqn3Up6BfJcV0JtsjRgT6tu8NsT3mNrmznm8zJRVuVJFZHIPgHhFc9H9BBecQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TzqOmKfl; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ddd1fc67d2so30053b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 23:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706254519; x=1706859319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LLBtLu4wKX94/+P/QqcYo4A1h3dyVmhkosY/sUXTdjA=;
        b=TzqOmKflUa7Sqo9Csqa0VrjO+jLyz54pxux/BouGU2vDno94pOCQ3cqDnW4P7m740q
         0E92DCq45ZboYuak8HxOeWDCVHsD4Cl6F2VpO9HqeDShl3xyeI6CNLpXoUMknxq0mnmo
         h1R2ZpcJXU/csw2hUlXhmc8WTVJa+YAUtIdkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706254519; x=1706859319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLBtLu4wKX94/+P/QqcYo4A1h3dyVmhkosY/sUXTdjA=;
        b=piLEiLgdfbUjj9af5TNDuAT7GCsB0G7M13NNc0WtwAwZdw62NT5j1kaQIt2M9xkK3j
         qPrjgWnA5FaIQVbDSVjM4SYc+uSMBuEdSu1zyi42kVX8fe7uHNz1J0Qi1wSIpvbHXsOs
         fXu/fthK89TCgJcTplrKOptZN6/Wx/wzdFpfJ3Bz2RADjCTTv6Jxch24bZuz8IWMhPAG
         FrZ5gB4JJ1dMFc4YcFNU3vaGYJcm7kzhT2XTv06KJcy8lQirJX8CXsRifYgCojUB2Ozg
         E23bj4cjn+tO9JnW7jEZqUGouE2f7ySLpWFAqLv2y8ADfSu/fqwCSipmVGigyvqFFuSC
         0jTQ==
X-Gm-Message-State: AOJu0Yx1W9rrFkPw7SgXvpsn7v8GnrUhn9PVyF0fJfFM73qLAxkS5YGY
	IcNYrqetnlpakROaD49GW1Oz2kPQt+qr+3TMYs6FsVyb2a2wbcOwvObiZNW3OQ==
X-Google-Smtp-Source: AGHT+IHCfZg7myP94HWqLShb7FnZKGeEWhG1lB4m6nfTYh97Z4qNJy4ySGIQ0mSBgidZ/Z3eT7G7RA==
X-Received: by 2002:a05:6a20:7b19:b0:199:f708:207a with SMTP id s25-20020a056a207b1900b00199f708207amr591065pzh.116.1706254519486;
        Thu, 25 Jan 2024 23:35:19 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2614:bbbd:8db2:1f54])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902eb0500b001d58ed4c591sm516983plb.105.2024.01.25.23.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 23:35:19 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Allen Chen <allen.chen@ite.com.tw>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: bridge: it6505: Add #sound-dai-cells
Date: Fri, 26 Jan 2024 15:35:10 +0800
Message-ID: <20240126073511.2708574-1-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ITE IT6505 display bridge can take one I2S input and transmit it
over the DisplayPort link.

Add #sound-dai-cells (= 0) to the binding for it.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
The driver side changes [1] are still being worked on, but given the
hardware is very simple, it would be nice if we could land the binding
first and be able to introduct device trees that have this.

[1] https://lore.kernel.org/linux-arm-kernel/20230730180803.22570-4-jiaxin.yu@mediatek.com/

 .../devicetree/bindings/display/bridge/ite,it6505.yaml         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
index 348b02f26041..7ec4decc9c21 100644
--- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
@@ -52,6 +52,9 @@ properties:
     maxItems: 1
     description: extcon specifier for the Power Delivery
 
+  "#sound-dai-cells":
+    const: 0
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
-- 
2.43.0.429.g432eaa2c6b-goog


