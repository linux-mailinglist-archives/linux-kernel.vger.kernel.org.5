Return-Path: <linux-kernel+bounces-42638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7755A840430
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C67C1C2282A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148CF5D75B;
	Mon, 29 Jan 2024 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OH9HviHQ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686C85D8EC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529145; cv=none; b=J2ICI8sFYCoSYIv6v+r2IuAR7oNys/tDYkExQy8/HAMIviINbI9mhYO4FTCtbZd41d5CKFM3W8+4DvMizRvdNawgA+BS1VIZrgNIIczy+Lx0cq/SHkwFL6iJ1SYZtpK/lbGJiyp5AIHB/mb2oNhjlyu7yG9jhEXro0mK0F9Unms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529145; c=relaxed/simple;
	bh=TevWKR2DSrMzB/VAXnrwgpjtV2WO/i7dhXJ3FYqBRLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p5D2n2RoYP8Ohd5pn60B4wYQzIDnoNmDsmxteYKa8Tas+3v30aS4mo54RnfdE7gZwoArN7mBpb7kPjjI2yIU/aNhlGMmKydl9250NxyJgpixALSF1dPtSpYha1hh5ujXHWRowUJBeDJg7T2+C5tQQxYfmCf5au3pzSI/+lMRolA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OH9HviHQ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cf0390eddbso29679571fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706529140; x=1707133940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R/YgAdznIozSs2D/WsWY2hpfyQsPzLBVEOR2iGtuuDw=;
        b=OH9HviHQWkoyDQT4YvNqrANkRD7RpAirmBuoBJuSOXbhaF1V24XtCDeDMaKuOMGpza
         lDqDhacP/ihanyKi5G4f00m2tGbxHPTFx5smunBSkdTvrBoABuTn8SJ8EVdx/rVPHXRg
         Lm9vSniSgtxpXVQl82AvHxaes1TbCG8fbrtyKoz8wmpgh7W/c02XCZxzJf6B4QF3ZvOK
         aQJKd7f09b7HUcS9TNTYXw8Y9fjBowcIyg0vF1rz+YjITXAFRAjJ6Qf9yLvv5D1OWtYX
         5MDTWJ4TQ7NfF2b25lWow7dLIwr6K6Ubuf33eHRmTTtWXEptZeMDXRwjPVYY76Nw6CQb
         gqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706529140; x=1707133940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/YgAdznIozSs2D/WsWY2hpfyQsPzLBVEOR2iGtuuDw=;
        b=eSDCQMgDhFGCdqaYPBxlqvP/sIUyCT97Ky7uP7ZuwVeETtoPU6s6k81Xqijmzztyve
         Tn1cpwVyNhKkbmg9AYmhUOp1imixtn2yVMTmzy2muH/aYK3f3c+AP44kyS0XUxxfmxlK
         1b7ZdrvNxT2AvIyYGKwQOCRNpYKJWnOVwuV2d7giD/rJD5NbAtcfu4m2crqg5IRmaeRq
         yH352AWjp7vv5t1jLwiT++NtCvWr/gfK6ojNU9EicrJ+n96T8Vr8sFGd+xZEOPGdp10S
         lSe51Mvv5XU494Czcq8ETK/awv5GEQxQDHxOaSM2VWGgB6Xxz5m5RMMTojxBKOQm0MQd
         G1VA==
X-Gm-Message-State: AOJu0YzP3Z1IPW4RFCgacO8QWvXSe+g8wExmFgTTPGRcpm5QrkHK4b0J
	zFJyAuKkiLasM0vQMMu4oNxbDRvv8y+Q62TFSOLdMyU7gRzStSJDfHWPJ4RR0oQ=
X-Google-Smtp-Source: AGHT+IFqjoy3FZxoV9ITWG/DVDbPwIlEmiyp2X8ew7y1z0leblC2o5ktNI6NnAt/yx6tOebUXaknnQ==
X-Received: by 2002:a05:651c:1986:b0:2cd:7357:58eb with SMTP id bx6-20020a05651c198600b002cd735758ebmr4260461ljb.39.1706529140447;
        Mon, 29 Jan 2024 03:52:20 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id ec19-20020a0564020d5300b0055f29ececeasm19907edb.57.2024.01.29.03.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:52:19 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
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
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v6 0/6] reset: gpio: ASoC: shared GPIO resets
Date: Mon, 29 Jan 2024 12:52:10 +0100
Message-Id: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Dependencies / Merging
======================
1. Depends on !GPIOLIB stub:
   https://lore.kernel.org/all/20240125081601.118051-3-krzysztof.kozlowski@linaro.org/

2. Patch #2 (cpufreq: do not open-code of_phandle_args_equal()) and patch #4
   (reset: Instantiate reset GPIO controller for shared reset-gpios) depend on OF
   change (patch #1).

Changes in v6
=============
1. reset/core.c: Add check for number of GPIO cells==2 (Neil).
2. Add Rb/Ack tags.

Changes in v5
=============
1. Minor comments from Philipp: missing cleanup.h, correct indentation of
   pr_err(), shorten gpio_device_find_by_fwnode() line.
2. Acks/Rbs.

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
 drivers/reset/core.c                          | 224 +++++++++++++++++-
 drivers/reset/reset-gpio.c                    | 119 ++++++++++
 include/linux/cpufreq.h                       |   3 +-
 include/linux/of.h                            |  16 ++
 include/linux/reset-controller.h              |   4 +
 sound/soc/codecs/wsa884x.c                    |  53 ++++-
 10 files changed, 419 insertions(+), 26 deletions(-)
 create mode 100644 drivers/reset/reset-gpio.c

-- 
2.34.1


