Return-Path: <linux-kernel+bounces-35428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C128390EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A1D1C209A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFABF5F876;
	Tue, 23 Jan 2024 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m1WsWUtB"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04DD55E60
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019217; cv=none; b=K3CRwAWYB3ncQKIUiNoY4XFXH0mD8cAvArPyIYjwxOiOv1kS+QEmkqqKUcIwYdL3tIly5YKze4ZDeLoA2Z8jxFC+RIdfoK78cBbioe58OHP/APgkfwnaNHgmXzGDxFb6LbimcTrGztvdofS/R3iUutHWszCT36PB97FvmuFcAVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019217; c=relaxed/simple;
	bh=59g27bt8e6S4r2ETTP2EkFw+s31TUQk1QwcJu0PCIT0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bXQ1cZh8LgNS25n7bjKEVOa22qfyPx+IofcoESzkiN3GNxTavRajy0zHj64xwzO8rf6f/NYgRSpo1Uelqjcx+ODe7VlfUmyHFsm6XSYA9fSLVHFZSFx4YziVkR68xwx+oRH4aZ7RZe+wagQ/DUU2FLR8rYbeY2wQjvXz5YGOcRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m1WsWUtB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-337d05b8942so5003658f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 06:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706019213; x=1706624013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3wc/JiN8Loe+9s5GeVUhog8zNaIeXcbf5dgRtXCIKt4=;
        b=m1WsWUtBOZ3TLoIvheeBvT4it6wBWUHe8ixOLD89llU1NNcf5h4ZcOwYYulY+OICHi
         nPomRrMDlpFANNvoHYMsjSLNvFGOCmwk5AtQxPpw/DQaRUUtUpH2E+lMR3eU5nKfOoO6
         hemdG1YsMfWUmfzzlSCZq15OT8fKVQ8Z/hTGdCdAhP6TekHA91oQTJXVp+SHDDUEIKAE
         srWuNuMp8HxcTi83zPlGGekT82JQqWc2dwXhd4mZD+mAY9AgbHhzGzOJmiDbPdEkBxwh
         yhORHiURN9oxQBxFyVp4Pk25gv++QYOZNEgXIFyhmZRDLAoUhZ02bgzyCCVIW71Kg2EY
         Rocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706019213; x=1706624013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wc/JiN8Loe+9s5GeVUhog8zNaIeXcbf5dgRtXCIKt4=;
        b=PHQjfh+DQIckKQPSo49t+4IX30cB9NRTdQkriIswiztYVctmsBwxsfR5lv9p5iTBgY
         +HI/qWjjsogY4LW2dI1/eectsNzRu72nX/O0CPxTRus5fqp/nsyC0EA4ikMCMkXy7wZN
         LAR1pdhgP14nedrceRvO7nst6xLkkBO/cQ2kKAmOjJ5PXH+V+HPJMr8cSgIb9dlzFpWU
         NvJlNLec3CIiQqh2fGCUvLwbiMa1KHIlixWNZ3xkaMWXOITgpNAjFo77i3PZRgC+V+JN
         ft3iwHyT1SCkNUdMvUdalIvLGP2PVOYObE7dmlS6FcgCzDlBkFNVlxpoU93WCXNLUhaJ
         nEfg==
X-Gm-Message-State: AOJu0YxlEUK34jXWFy0NVAbNPaCIjiEVuB1mz7nAMG6R/qmE0W0rZ3YZ
	MeRz9/AFKbwhZxqhhJKDiNNIx6YgPDFfrBlSJzcjjpOp+2E7FWaNgsZ3rnHHHB4=
X-Google-Smtp-Source: AGHT+IGUwHiuIN/rr3Sfo3cQy+gFNAVnhehKWEZSRNQVxSnP0gfdhi5FegVHP6kGfQJRsqXageDuDw==
X-Received: by 2002:a5d:4e0f:0:b0:336:6dad:2c71 with SMTP id p15-20020a5d4e0f000000b003366dad2c71mr3605582wrt.111.1706019213110;
        Tue, 23 Jan 2024 06:13:33 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id r8-20020adfe688000000b00337d97338b0sm12132298wrm.76.2024.01.23.06.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 06:13:32 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v4 0/6] reset: gpio: ASoC: shared GPIO resets
Date: Tue, 23 Jan 2024 15:13:05 +0100
Message-Id: <20240123141311.220505-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Patch #2 (cpufreq: do not open-code of_phandle_args_equal()) and patch #4
(reset: Instantiate reset GPIO controller for shared reset-gpios) depend on OF
change (patch #1).

Changes in v4
=============
1. New patches:
   of: add of_phandle_args_equal() helper
   cpufreq: do not open-code of_phandle_args_equal()

2. reset-gpio.c:
   - Drop unneeded comment (Bartosz), add Rb tag.
   - Do not assign of_node.

3. reset/core.c:
   - Implement most of Bartosz feedback (I responded to one which I did not
     implement) and comments from Philipp.
   - Expect either rcdev->of_args or rcdev->of_node.
   - Drop __reset_gpios_args_match() and use common helper (Philipp).
   - Move declarations of automatic-cleanup variables in
     __reset_add_reset_gpio_lookup() to place of use (Bartosz).
   - Separate gpio_device_get_label() and kstrdup() (Philipp).
   - Correct doc for __reset_add_reset_gpio_device(), rewrite few comments.
   - Drop unneeded "r" variable in __reset_find_rcdev() (Philipp).
   - Drop of_phandle_args initialization in __of_reset_control_get (Philipp).
   - Check if CONFIG_RESET_GPIO is enabled before trying to look up reset-gpios.

4. Drop Chris' patch: "i2c: muxes: pca954x: Allow sharing reset GPIO", because
   discussion is on going.

Changes in v3
=============
1. reset-gpio.c:
  - Add reset_gpio_of_xlate (Philipp).
  - reset_gpio_of_args_put->reset_gpio_of_node_put (Philipp).
  - Expect via platdata of_phandle_args.
  - Do not call device_set_node() to attach itself to reset consumer
    (the final device).  This was questionable idea in the first place.
    Bartosz suggested to use GPIO_LOOKUP to solve this.

2. reset/core.c, implement Philipp's feedback. That was a lot:
  - Commit msg fixes.
  - Add new platform_device earlier, when reset core found "reset-gpios" but
    not "resets".
  - Do not overwrite of_phandle_args.
  - Expect matching .of_reset_n_cells.
  - Pass of_phandle_args as platdata to reset-gpio.
  - Rename reset_gpio_device->reset_gpio_lookup and others. Fix few comments
    and code cleanup pointed on review.
  - From Bartosz:
    Use GPIO_LOOKUP and a lot of cleanup.h in __reset_add_reset_gpio_lookup().

3. Include here Chris' patch: "i2c: muxes: pca954x: Allow sharing reset GPIO".

Changes in v2
=============
1. wsa884x.c: add missing return in wsa884x_get_reset(), correct comment.
2. qcom,wsa8840.yaml: fix oneOf syntax.
3. reset-gpio.c:
   - Fix smatch warning on platdata evaluation.
   - Parse GPIO args and store them in rc.of_args.
4. reset/core.c:
   - Revise approach based on Bartosz comments: parse the reset-gpios phandle
     with arguments, do not use deprecated API and do not rely on gpio_desc
     pointer.
   - Create a list of instantiated platform devices to avoid any duplicates.
   - After creating reset-gpio platform device, try to get new reset controller
     or return EPROBE_DEFER.
   - Drop the "cookie" member and add new "of_args" to "struct
     reset_controller_dev".

Description
===========

We have at least few cases where hardware engineers decided to use one
powerdown/shutdown/reset GPIO line for multiple devices:

1. WSA884x (this and previous patch):
https://lore.kernel.org/all/b7aeda24-d638-45b7-8e30-80d287f498f8@sirena.org.uk/
2. https://lore.kernel.org/all/20231027033104.1348921-1-chris.packham@alliedtelesis.co.nz/
3. https://lore.kernel.org/lkml/20191030120440.3699-1-peter.ujfalusi@ti.com/
4. https://lore.kernel.org/all/20211018234923.1769028-1-sean.anderson@seco.com/
5. https://social.treehouse.systems/@marcan/111268780311634160

I try to solve my case, hopefuly Chris' (2), partially Sean's (4) and maybe
Hectors (5), using Rob's suggestion:

https://lore.kernel.org/all/YXi5CUCEi7YmNxXM@robh.at.kernel.org/

Best regards,
Krzysztof

Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sean Anderson <sean.anderson@seco.com>

Krzysztof Kozlowski (6):
  of: Add of_phandle_args_equal() helper
  cpufreq: do not open-code of_phandle_args_equal()
  reset: gpio: Add GPIO-based reset controller
  reset: Instantiate reset GPIO controller for shared reset-gpios
  ASoC: dt-bindings: qcom,wsa8840: Add reset-gpios for shared line
  ASoC: codecs: wsa884x: Allow sharing reset GPIO

 .../bindings/sound/qcom,wsa8840.yaml          |  11 +-
 MAINTAINERS                                   |   5 +
 drivers/reset/Kconfig                         |   9 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/core.c                          | 213 ++++++++++++++++--
 drivers/reset/reset-gpio.c                    | 119 ++++++++++
 include/linux/cpufreq.h                       |   3 +-
 include/linux/of.h                            |  16 ++
 include/linux/reset-controller.h              |   4 +
 sound/soc/codecs/wsa884x.c                    |  53 ++++-
 10 files changed, 408 insertions(+), 26 deletions(-)
 create mode 100644 drivers/reset/reset-gpio.c

-- 
2.34.1


