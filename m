Return-Path: <linux-kernel+bounces-60306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA078502F2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A905F285683
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614FA2B9D0;
	Sat, 10 Feb 2024 07:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M7AYcW0o"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DA024214
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548982; cv=none; b=NAmOY0+hwdNknPYcD4TdObXN4ZVPybK4daZLemLx4K4MUXWTrBg+eoZV5SOVJrp5ocAlLTDQbWdtVTphsYZYsS1k8PjZHKUaD6KK6o5tWQkWcBTZGYSrbggmEWb4k+BuU91JUgs7K38QeeJJYqg6jwYhWpq5pj3wH2VvfZ3xVx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548982; c=relaxed/simple;
	bh=mbC0DB1VSkueSEIQOEMgbsEihDdd9hh6PSWoWxt8Hnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+OUj9cMTVRQxTt/wZR+nrXLHuJWGOgrPD2ndvbfzbtNsziVRKu4hzEeWw1KSgxE5rWj4GzUET606X/HvRwTz6EXxoT4GvE97me3fViz4OsxUOU9vHaeH6Y28QPzyig9MySNcBA2Qv4RQC4UqlfPonj/pJrcP7H4WqLNzeA9eUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M7AYcW0o; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e09493eb8eso805642b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 23:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707548979; x=1708153779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9ybKrfRhqeTAtLZZp91eR3wd0aV+0gDZsFZ2lmBVz4=;
        b=M7AYcW0owUafXlSINTxSwXRVOvKMlq1eUfzM53hxC9gDoNcvNYGfZ3plR+P7mXdfuH
         osdgd4sa88rYqBoEA+pNbTLSZx6wXfWug9kRdgMWdAmVM0QV2CF8CuWTcUwxLolQvQY3
         /41hu6R3rEvLxiiYK3ibnJO1YFlCnWQa6AK+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548979; x=1708153779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9ybKrfRhqeTAtLZZp91eR3wd0aV+0gDZsFZ2lmBVz4=;
        b=Yf8CxPDCxMnV4qRzSOCdZ7GWV9VUeFr4bzKptCe/hLbSHZX8fKbL8X0xaxH9dqG6rw
         RbWXVnZ1rdZX28ADL74i45LUkZ6RgiO/eWMksamFBbgmlyDRCg0pzTnFL7cE9STXRLXf
         K4YxDNZbN4aqC8lfYkcPfHDF77gyWp37myoavyFPYgdmBJkVcORdc749s5f/0gbMxAxO
         0IaV5t+n6/AGAoB0GgKdqc3YpdveYyWyFZlUMXgAfb9iuxs8t9pNgAX16m/2MB8+WdQi
         /qU4+2di1AkMBtpNPn95lyxY+dxdeBAWhra1dsjRvRzjwakCnwzB29V2Ooi53gXP/AEq
         yMhw==
X-Gm-Message-State: AOJu0YzDjAB8k1qM72SnTHck3y7Adh6SqKLUzPXgQT0F61Fjo7W2GhZb
	zKddm1smNAkdCCDuZ1Gusfn1gAfxc9P9UKWu6DrA/rHfDNxOMMWySLmDAKirRw==
X-Google-Smtp-Source: AGHT+IHHFtmTz4F6HkKCsABtdOtMPEvj2ixjc3Xu597pI5qeBktFMLaxG/9FeC2ZBzrgjmMIjMeamQ==
X-Received: by 2002:a05:6a20:2d11:b0:19e:8a29:5e81 with SMTP id g17-20020a056a202d1100b0019e8a295e81mr2125042pzl.20.1707548979163;
        Fri, 09 Feb 2024 23:09:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXukExwyisG683fg4h7pCl9rSIdxSMepDxpCM5dZ1O3HwsoS+nhng0ZD5rEZzlXs9GCVBcrtR2ahVrw9Tq+G75+AcxYBu6xzpYBwlSgTvre9uLLLINyC1uDx8QMFg/Uwvh/rDuEY6zof6+m901UXuFLunQ6MEYVEz1MqrsyoJUCTA5RP9w4WcwgUljdNy8efAMFoQ3lk332aFb0Aij/BoEM568msE7RR61tbj4Fm1ppOvvk28c/NG+kX2C5FvqrVZHFNH7SEc6+30VdeVE1i1DCaFPL1xa6vRJuKsNMvRTI1y/HM+Ggrp9HxUfaz3znu1b8St9e7okrMQovFcoDIZtjECCVRm9AsuDVMftg7VRs02tsnYOuyIs+qclbP7wPH9CqTe4Mienk8CICB7cqX7bWbOb7bV0TYRqo58lHQmWoY6RYVjENzX+rKP2mDr6fi0KedWE0ZIz+eRJF1chQWDHwWeUYN6AY9CndeAYz/Onb+wIvtNbOZmRidiilc8mQ55QRLsxnRMofAz2lzhdElSVJQxfET9ygcLKUE/qdRMnCAhgc3y3ZSdUJN4FsA203B6Q924VAQqVZmi+no22dFJaG5PRF8Y6idsNMD6wss+zhCYywwCmyMpxp/i1irUam42Cps33RK49GIGC4XGkFu/UI6Bg/C4pi7vaHwMcK40bmBHFtLheoVGghflGzfTmaKDKjKS8bPS9LZW0QkIpHysEK0ijpRhaUAP9OeGgWDwZyqEciZQPAZjYPHER2AEQa8jFV+4brprEP/zRKa6EsBOjtSDjia+33bkj+LSgZ/fge9XnptZN7snWBopOstR8OAUxdvjHP1bh7w9BzOu9tYQW7qh5DcS5kNqszUtb61B0GyTd9jWX4QB9W3aRvRk7BBbcqeJhc5zzBnK9FmFtyE4QVWxtfVJPc01IidMb9NDIZKNvox38te7RJ6caZ8R8nIjIstp
 4lGz0SjfgHZwjWvR2r9qWWj8HnjqDNj1y46zO15w2RjzLoQ0s/7gVZf+XqC5fea2YnxjCsFQO340QTn5W4+MFayh2Az1o4vV/QSz6cxraHru/ru5sePzI8qWlLfG5zUGPjko4maXtW8PMN7gihFpXWcbgPZ0FQrr5ceC74vIWunIVHs0Am6nU6ozeW19l0665suTVqD7L1WolrlSpKKiRjpp/lHwyyxVJB7QMPkcN5ZnKjv0ET2uvp60Ls246xA9kNT3qcmRuqqNoarBUMlI+A5l1EUu2CY6L9wJDH8y83qCg/8OvSVs3CTBz5pzF7Q1r+kO1qm+DPnUl2nTlhUSxZZxgFiIqAYDfECac0aalVi9KxfYb6VyjfCFgH/ui5zqs5WNFCWCvxexV+SAWxhW4qfMH6ALqq3t8PQIGuKvpzWFiOKOZdMoJiSQ3canXFCdRyNHh1R04AXBwPQaW95JZK0Nrrzix11McAxOdnbXFfmWycBbh2dK5W3GPdiShdLqa3MsarkGA0lGvSp7oDN+225ESySKGvIap3lLcCdHyh4m/eDAupHMH+0hUv/Zx2HiBF5/gR3EVjbKaqASOP71qFbazz5BGUGh4p1TgaSLJPm2yIxKpCgyxE/C5ja6PnOLTjlx2LDh7ss4pKSWoOnPKpzqP7dfzaNWJvw8O0STC36DwN
Received: from localhost (175.199.125.34.bc.googleusercontent.com. [34.125.199.175])
        by smtp.gmail.com with UTF8SMTPSA id y26-20020a63495a000000b005ce998b9391sm2846522pgk.67.2024.02.09.23.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 23:09:38 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Andy Gross <agross@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Benson Leung <bleung@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Daniel Scally <djrscally@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <groeck@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	maciek swiech <drmasquatch@google.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Maxime Ripard <mripard@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashant Malani <pmalani@chromium.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Robert Foss <rfoss@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 00/22] platform/chrome: Add DT USB/DP muxing/topology to Trogdor
Date: Fri,  9 Feb 2024 23:09:11 -0800
Message-ID: <20240210070934.2549994-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for fully describing the USB/DP topology on
ChromeOS Trogdor devices in DT. Trogdor devices have a single DP phy in
the AP that is muxed to one of two usb type-c connectors depending on
which port asserts HPD first to the EC. We'd like to know which port is
connected to an external monitor to provide a better experience to the
user about things like which type-c port is displaying DP or which
type-c hub is acting up, etc. Describing the connection all the way from
the source to the connector will allow us to do this. There will be some
more work to do after this to wire up sysfs connections, but that work
has already started or finished so it should be mostly minor changes to
support DT there.

This patch series is large, unfortunately, and is ordered in logical
groups: gpio, USB, DRM, typec, and finally dts to put it all together.
There's more that could be put in here, e.g. supporting ChromeOS Corsola
devices, but I wanted to get something out there early instead of
waiting to make this work with everything that exists today and posting
it then.

Onto the patches: 

First is the EC GPIO driver, which is dependency free and can be merged
at any time. It's only needed to provide information about which port
the EC is steering DP to, because the EC had a bug where it never told
the AP about which port has HPD asserted or not.

Second is the USB binding and hub patches. These are used to describe
how the USB hub is wired up on all the Trogdor devices, and make the
connect_type be something besides "unknown" on DT devices. ACPI has
supported setting a proper connect_type for some time now. These can
also be merged pretty much dependency free, except that the dt binding
will be needed to avoid DT binding check failures. I don't think those
checks are fatal though, so probably also fine to take this part
independently.

Third is the DRM bridge patches. These are used to implement lane
assignment for DP altmode configurations through the drm_bridge code.
The typec code will use this to tell the DP phy how many lanes of DP to
drive and which lanes to drive out to the USB type-c connector. Adding
support for lane assignment allows us to implement DP muxing as well,
physically splitting the DP lanes on the DP phy so that hardware doesn't
have to use an analog mux to steer two DP lanes to one or the other
type-c port. These are a hard dependency for the typec code.

Fourth is the typec patches, that ties together everything that comes
before it in this series. The EC typec switch driver implements a
drm_bridge that can signal HPD from the type-c connector through the
bridge chain, mux the DP phy in software so that we don't have to use an
analog mux, and implement orientation control for boards like Kukui that
directly connect the DP phy to the type-c port, necessitating lane
assignment to flip the lanes to match the cable orientation.

Finally, the dts patches wire everything up to fully describe the USB/DT
topology on Trogdor. This includes the USB hub, the EC gpios, the DP
controller, and the external connectors like the usb-c and usb-a
connectors.

After this initial version I will probably split this series and send
parts in pieces to more rapidly send new versions. Those parts will
refer back to this version in the cover letter so we can all get the
full context. I don't expect to merge this through one maintainer tree
immediately, so I set the 'To' line to chrome-platform to reflect the
overall target audience.

Prashant Malani (1):
  platform/chrome: cros_ec_typec: Purge blocking switch devlinks

Stephen Boyd (21):
  dt-bindings: gpio: Add binding for ChromeOS EC GPIO controller
  gpio: Add ChromeOS EC GPIO driver
  dt-bindings: usb: Add downstream facing ports to realtek binding
  usb: core: Set connect_type of ports based on DT node
  drm/atomic-helper: Introduce lane remapping support to bridges
  drm/bridge: Verify lane assignment is going to work during
    atomic_check
  device property: Add remote endpoint to devcon matcher
  platform/chrome: cros_typec_switch: Use read_poll_timeout helper
  platform/chrome: cros_typec_switch: Move port creation code to
    sub-function
  platform/chrome: cros_typec_switch: Use fwnode instead of ACPI APIs
  platform/chrome: cros_typec_switch: Use dev_err_probe()
  dt-bindings: chrome: Add google,cros-ec-typec-switch binding
  platform/chrome: cros_typec_switch: Add support for signaling HPD to
    drm_bridge
  platform/chrome: cros_typec_switch: Support DP muxing via DRM lane
    assignment
  platform/chrome: cros_typec_switch: Support orientation-switch
  platform/chrome: cros_typec_switch: Handle lack of HPD information
  dt-bindings: chrome: Add binding for ChromeOS Pogo pin connector
  arm64: dts: qcom: sc7180: quackingstick: Disable instead of delete
    usb_c1
  arm64: dts: qcom: sc7180: pazquel: Add missing comment header
  arm64: dts: qcom: sc7180-trogdor: Make clamshell/detachable fragments
  arm64: dts: qcom: sc7180-trogdor: Wire up USB and DP to
    usb-c-connectors

 .../chrome/google,cros-ec-typec-switch.yaml   | 365 ++++++++++++
 .../chrome/google,pogo-pin-connector.yaml     |  61 ++
 .../bindings/gpio/google,cros-ec-gpio.yaml    |  49 ++
 .../bindings/mfd/google,cros-ec.yaml          |   8 +
 .../bindings/usb/realtek,rts5411.yaml         |  50 ++
 .../dts/qcom/sc7180-trogdor-clamshell.dtsi    |  30 +
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  52 +-
 .../dts/qcom/sc7180-trogdor-detachable.dtsi   |  25 +
 .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  54 +-
 .../dts/qcom/sc7180-trogdor-kingoftown.dts    |  57 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  58 +-
 .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi |  59 +-
 .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  46 +-
 .../qcom/sc7180-trogdor-quackingstick.dtsi    |  46 +-
 .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts |   2 +-
 .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  52 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 175 ++++++
 drivers/base/property.c                       |   7 +-
 drivers/gpio/Kconfig                          |  10 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-cros-ec.c                   | 218 +++++++
 drivers/gpu/drm/drm_atomic_state_helper.c     |   2 +
 drivers/gpu/drm/drm_bridge.c                  |  50 ++
 drivers/platform/chrome/Kconfig               |   3 +-
 drivers/platform/chrome/cros_ec_typec.c       |  10 +
 drivers/platform/chrome/cros_typec_switch.c   | 555 +++++++++++++++---
 drivers/usb/core/port.c                       |  37 ++
 drivers/usb/roles/class.c                     |   4 +-
 drivers/usb/typec/mux.c                       |   8 +
 drivers/usb/typec/retimer.c                   |   7 +-
 include/drm/drm_atomic.h                      |  31 +
 include/drm/drm_bridge.h                      |   4 +
 include/linux/property.h                      |   5 +-
 33 files changed, 2026 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-typec-switch.yaml
 create mode 100644 Documentation/devicetree/bindings/chrome/google,pogo-pin-connector.yaml
 create mode 100644 Documentation/devicetree/bindings/gpio/google,cros-ec-gpio.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-clamshell.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-detachable.dtsi
 create mode 100644 drivers/gpio/gpio-cros-ec.c

Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Benson Leung <bleung@chromium.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: <chrome-platform@lists.linux.dev>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: <cros-qcom-dts-watchers@chromium.org>
Cc: Daniel Scally <djrscally@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@gmail.com>
Cc: <devicetree@vger.kernel.org>
Cc: <dri-devel@lists.freedesktop.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Lee Jones <lee@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: <linux-acpi@vger.kernel.org>
Cc: <linux-arm-msm@vger.kernel.org>
Cc: <linux-gpio@vger.kernel.org>
Cc: <linux-usb@vger.kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: maciek swiech <drmasquatch@google.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Pin-yen Lin <treapking@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Robert Foss <rfoss@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>

base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
https://chromeos.dev

