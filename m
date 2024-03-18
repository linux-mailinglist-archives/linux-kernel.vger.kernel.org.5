Return-Path: <linux-kernel+bounces-106200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BFF87EAA7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399B71F21A37
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A830D4AEFB;
	Mon, 18 Mar 2024 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lmBkPmGZ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD714AECD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771391; cv=none; b=RqtKSJsO2yvKX/0mJ/HIa/6MosxlKVId/tVk3d26OdKFyScrdWKDrc9Nxj95QeZeQUThAT/Lv2a8IpHsrMyzmzw/ehKYMXZ7Qmu9QEZAwfV5Ys2nshb6rSU2Y5G0KpnD015PRfjMptf6KEOx1hS4Ec6xwuYnJVhGXKD4/AvswCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771391; c=relaxed/simple;
	bh=AVO0CRv0JE94l/fO/dv5SVK7xIoOeyHJggaKr7jbwXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=K6et6TM/lWVntmX0gS9pRzw0FKBq53Im5bwrnZU9+iSVNEVboIOf7GBNg20im5S7vHoF6ktNASruvtVzh9c1+x5odvC3HHtAC3YtzfmcKxsCNG94hh8YL9g9N5LvmYaf/9zri5O8JFkRI3cBi+LYV13r+8l6kPDt8vEsw+XO12M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lmBkPmGZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41460512c25so2080595e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710771388; x=1711376188; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6hoHJPzKivMW1yEjOBGD1bftC6F87yAj85WAtXr98Do=;
        b=lmBkPmGZKFbvIh7bcsTWXu33xARq6OYyKS0e3zW/Is8IF1ny/sVbjXqd2EFtJFAdVV
         R34HxHenYOUihdposUQAUpMfT7OAGGJGRGR1OGYbgAiAD1fvU8X5NMgMyWevLPtin11Q
         Zcs9kkOIUeupi+02EcCa1AibEeErWcRL9FR4LqhRIFgiaAAJ6ZTkij941/R17NeE67pw
         1yzFq2/LJyyCIzxSwZNR1JETN7OHCMWsOrFp93IrE14dTq5G6YHYRou91GnvQBnb/rEV
         k/yKBmH4HKvJbvO3jdI8AQH+w76+4i+WNws1AdWzqwEw022lvviHjq0GOeszbUURiAkM
         BRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710771388; x=1711376188;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hoHJPzKivMW1yEjOBGD1bftC6F87yAj85WAtXr98Do=;
        b=q5fCZJKhVtwxlONCE0Ej8b5wYjZymGoOLQ9t+ejSw4L5kKCMJe3N8OsPhP/VseX04f
         UtOhtrGw0jhOBmvbWuEYFVrEVrfXSElmWibpkIXmkgfilvuTsohCdbpW0eKfmD1RMGrL
         xAhEhK5p973puN3yiOOXjxMPWcJSuzHhhtijQraMXUkoyYRyWxxGvHuikbotPnPoybp9
         nUtQXnbQPfitomQKtkEIqwKvYEYp/dAm3cUHYhMW1kBMgDrT92YzWkcZ6qMuGnTWheyF
         354Il0qaIGe9+dyRU3sZCWuTTgbnwFu4uM9QgeI+RlN8lthG9WtwXzq72r2upZIdLBqE
         L1Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUgj3QFrB+Sdtuxul8dmpTB3KNH/v6LTgs4YTdZNkGk9GyaHVRertUmpGzBKWlckGRLri0BOXFE2230vn+pVuH/PWcl6m3riJISTtqm
X-Gm-Message-State: AOJu0YxRQO3M/aqu3It0PekzRH8X6XYPvLyq2dYYNlh3qHLplN2yabSt
	h+ewvdpki7Axi2TYtQEWckyXTUwB36c0/0vrmP9wCE90PFbaYTw9RbpBdFu2VCA=
X-Google-Smtp-Source: AGHT+IEqzbstFUamf1dr3ZQZI+3TDFusQzNphV5aLQUHgxcZhBUC+9G9ERQlw3BfIaiybAdjAODiyA==
X-Received: by 2002:a05:600c:314b:b0:413:7f3:8d5 with SMTP id h11-20020a05600c314b00b0041307f308d5mr6541011wmo.0.1710771388257;
        Mon, 18 Mar 2024 07:16:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id a18-20020a05600c349200b0041413d11838sm1642584wmq.26.2024.03.18.07.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 07:16:27 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 18 Mar 2024 15:16:21 +0100
Subject: [PATCH] Revert "drm/bridge: Select DRM_KMS_HELPER for
 DRM_PANEL_BRIDGE"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240318-revert-select-drm_kms_helper-for-drm_panel_bridge-v1-1-52a42a116286@linaro.org>
X-B4-Tracking: v=1; b=H4sIALRM+GUC/x2NUQqDMBAFryL73UDUUNtepUhIk2ddGmPYSCmId
 2/wc4bHvJ0KhFHo0ewk+HLhNVVoLw352aU3FIfK1OnO6L69qTqCbKogwm8qyGI/S7EzYoaoaZV
 TZZcQ7Us41ICGcWHwQ2/uV6rdLJj4d34+x+P4A5vjllqDAAAA
To: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Imre Deak <imre.deak@intel.com>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1324;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=AVO0CRv0JE94l/fO/dv5SVK7xIoOeyHJggaKr7jbwXQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl+Ey6S6ifjkU3YMO3rgKK5FOvKjMM3uGWoM5xG2o7
 N201Wu+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZfhMugAKCRB33NvayMhJ0e9SEA
 CcbN4WdLH4CEADtmqIVE2Xtq5X2X7rEhhGy6VcD2y4DKdXTRz53ijDHOVdnkeo0/hos94YeCl4qufj
 AFN2UxsLFgB3NHZVzY9L0Y5B0vvDUcIZEaYDReC286ANi4fgXvDJOjL4FvyKQCvMjqPpvmaiDNYcXM
 pynfskGc4LNdzgxcjnYOzO7tx9j/h4XS0D5ogPJUd8NYl0lE6tPfG9fYkLg+X4JiNZQzX3+GO2zJD/
 kryghoe9ixPlOQM6QwdH0U3CStqM52jLURE6DgBooJX7HJ8sWiKlIFVhW4S+EG/8px030HS6ltIuwX
 xNkFLQh3ZJ0woCwRdWJM1m8pH3zOenMvAGqPS1dK4IyhJCXd4VpiVNiM1M866FIaNnowS/aEh/AFlE
 dPCuWeeSery+dIe6I+JLZtS9xee3eGEQyuKJrw3PtrfTWzvozMfDE7LXz24uvR2Bf16WkVTeN8QVrV
 8JF+qUfBIAt/Rq24jpZez7sHq93f0RQcKuhRXO8kq7erV2f5Qu2AYG3avsbvhDdkG6dBExIyz9CUXu
 jei7sjB7c6UUJiCIrhzGvY/X8crqRNh380If+QzxuwlQurGXCSZAO9ZhZ00MJdQm7yrmtwcq6M/D3k
 BEw4+Qtzzo1LTnkF1Z/kN/wjS1TtA38o77pfiX58P7Hz970ttecQw8vRweWA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

This reverts commit e3f18b0dd1db242791afbc3bd173026163ce0ccc.

Selecting DRM_KMS_HELPER for DRM_PANEL_BRIDGE leads to:
WARNING: unmet direct dependencies detected for DRM_KMS_HELPER
  Depends on [m]: HAS_IOMEM [=y] && DRM [=m]
  ...

and builds with CONFIG_DRM=m will fail with the above kconfig
warns and then multiple linker error.

Reported-by: Imre Deak <imre.deak@intel.com>
Reported-by: Jani Nikula <jani.nikula@linux.intel.com>
Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Fixes: e3f18b0dd1db ("drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/bridge/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 1d4f010af97b..efd996f6c138 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -8,7 +8,6 @@ config DRM_BRIDGE
 config DRM_PANEL_BRIDGE
 	def_bool y
 	depends on DRM_BRIDGE
-	select DRM_KMS_HELPER
 	select DRM_PANEL
 	help
 	  DRM bridge wrapper of DRM panels

---
base-commit: e3f18b0dd1db242791afbc3bd173026163ce0ccc
change-id: 20240318-revert-select-drm_kms_helper-for-drm_panel_bridge-0e4ad7c73496

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


