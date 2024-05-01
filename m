Return-Path: <linux-kernel+bounces-165396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1376F8B8C3E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0925BB21E09
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653C612F385;
	Wed,  1 May 2024 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i/k9Mx0k"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E692612E6A
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575352; cv=none; b=tV1Feig5XuLNd7wZjpVznlYWO7B9ELAOqkX9oEZXs9XIWaPV748LGs7GhlJUbInDnIT4iwNfHD6Jo0WSWY3d4gBrJL1IYYs31zpbrGUr2D64DHPEfmWSqfat5I5YRGpPHYEXLoGCcTjg34/ecYNwTJYIgh4RNzRIz1jXHBCjLw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575352; c=relaxed/simple;
	bh=XCCvPuX/qkGPr7VFraEc7esj3UP9OrVL880YGBoqLGQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fzzM+xyGr1ZqbNt9Y4PQqXMJa9PEd3KDSZ/gj7yUJGkTOsvr7kDYwjpqB/EzOkRVJ2U6qxc3Oufs6D/3479fg/ojJuOwqZHsi6a6EmGF73s1UIALJBQplk29SN5hJA6poNcETzH9O5gOQjPsfRg3H9BLTTQoRUNtZ+S1IudD+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=i/k9Mx0k; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41b79451128so39725545e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 07:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714575348; x=1715180148; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HKQ+6gqcDM6g4mtjJkVG0cuF7/5Upv2QHRX+6EIPnTU=;
        b=i/k9Mx0knQiX0VgYE0JOvEHa7Hj3Zif2/+CNV4GmKIOjI/gyl63GYGYECTS6l2fV2H
         Dsh8ZQFlBQLWMuJ6/prmhbQ0kiGuWMWTZDIKmVjJ+hk2x9jrq6bi3MFCdSg1PGXeX++j
         5T+HQAaCPH0w4GO1UDOgYz/K1BjZ7kTppPbDN0jrxL4I9o1jtEgQrA4UCyqGxoE2uMZX
         zfCU0+YPYamv/GWWuuNR70voURQwkASCWGZc4jBSBGVBEySWMvGjr+Y8k9NyBLXbIoSr
         J6TpwSgN2gJFMHA2LaJUOrTlICEImgRviXV/GUikpGv9NS4tnLT7oM3ITMpYqXdX4xAx
         3jrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714575348; x=1715180148;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKQ+6gqcDM6g4mtjJkVG0cuF7/5Upv2QHRX+6EIPnTU=;
        b=qE3C+slfPjbLSNXYRMAHxD0O6Z2i9XHtubtnINhF2wbx4qUIeUeNjvkHJNNNuEwxpC
         xjO3nu+2CDZUqcXw/LtwX7uT4qy2GvFS1Au8cqFfSU2I23r2gALVu1asPNLov1hFCMoI
         kljWRxxRWETmrvUMhYzvg4PU3lwa7CUclsGsSWyR/lvcUBzYxbFoNwPQWMSAM92iWttT
         9sRJ+oBpxNawKLe1pwa77HY3TyWmLNmJ0UOtFldfgL9iIo4+8V0baDsreegabB2uGMJC
         imGKUfxpHsWBya49QW24ZfcoxYfABabU3FxzkvoGdqqPXqmLNgWUqvVDhh4EQKcYf3Dj
         uXgw==
X-Forwarded-Encrypted: i=1; AJvYcCWQxHOvGj+3fgGtJtm4Ms/WdQz4Q7shWGEi0FwqI6jTzrN9HKTPv8+qixneke1LCX+gYLUR1aeb3Q1Z/2SFEpwJh7bBvGqkYmhd8Oe6
X-Gm-Message-State: AOJu0YwfeQXCq/VxFuKCZJ/B6ZRh5Jxm5VBlLYv5LB3itxVFDuUOCH9f
	g5mMIScY9hzVqKAAQYFlDSPHmIgg6WsngiMtgEMxP9TUfnuqdsgEFRgIm7+sUuc=
X-Google-Smtp-Source: AGHT+IFJxwu7F8bLUaI0KVezWzBWFkD/8mA8rAD1LxBEh8aUfzPPesyRzcNZETQcn8wJ+lxEjTc7tw==
X-Received: by 2002:a05:600c:ac9:b0:41b:83bc:e9ba with SMTP id c9-20020a05600c0ac900b0041b83bce9bamr1806759wmr.23.1714575348112;
        Wed, 01 May 2024 07:55:48 -0700 (PDT)
Received: from [192.168.1.61] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b00418a386c17bsm2422999wms.12.2024.05.01.07.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:55:47 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH RFC v6 00/10] iio: adc: add new ad7380 driver
Date: Wed, 01 May 2024 16:55:33 +0200
Message-Id: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOVXMmYC/3WNTQ6CMBCFr0Jm7ZgCrYgrExMP4NawoO0Ak2gxr
 akQwt1tiFt37yfvewsE8kwBTtkCniIHHl0yh10GZmhdT8g2eShEIUWZ59hay65HR58kq/I4ofU
 cyaPqaq1kykwlIc1fnjqeNvQdbtcLNCkcOLxHP293UW3Vj1z/J0eFAg1VthNCGtLlWbfzg7Wnv
 Rmf0Kzr+gXqiPIByAAAAA==
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Stefan Popa <stefan.popa@analog.com>
X-Mailer: b4 0.13.0

Taking over this series with David Lechner's approval, to add some
fixes, proper handling of pseudo differential parts and
some extra commits to add support for 4-channel compatible parts,
oversampling and resolution boost.

We are happy with most of the series other than perhaps patch 10/10
(adding the resolution boost feature), so adding RFC prefix as suggested
by Jonathan.
This patch changes the userspace interface which is why we didn't want
the earlier patches to be applied yet. More details on this, on the
corresponding patch 10/10 commit message.

Here is David's cover letter:

This series is adding a new driver for the Analog Devices Inc. AD7380,
AD7381, AD7383, and AD7384 ADCs. These chips are part of a family of
simultaneous sampling SAR ADCs.

To keep things simple, the initial driver implementation only supports
the 2/4-channel differential chips listed above. There are also 4-channel
single-ended chips in the family that can be added later.

Furthermore, the driver is just implementing basic support for capturing
data. Additional features like interrupts, CRC, etc. can be added later.

This work is being done by BayLibre and on behalf of Analog Devices Inc.
hence the maintainers are @analog.com.

Changes in v6:
- Added a comment for math in IIO_CHAN_INFO_OFFSET
- Added a comment for raw buffer
- use iio_device_claim_direct_scoped instead of iio_device_claim_direct_mode

Adding the following commits on top of v5:
- add oversampling support
- add resolution boost support

- Link to v5: https://lore.kernel.org/r/20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com

Changes in v5:
- make ad7380_regmap_config static
  Reported-by: kernel test robot <lkp@intel.com>
  Closes: https://lore.kernel.org/oe-kbuild-all/202401280629.5kknB57C-lkp@intel.com/
- don't use bool in FIELD_PREP
  Reported-by: kernel test robot <lkp@intel.com>
  Closes: https://lore.kernel.org/oe-kbuild-all/202401280629.5kknB57C-lkp@intel.com/
- fix rx/tx buffer for regmap access
- add datasheet links of supported parts
- move reading reference voltage to probe function
- removed DIFFERENTIAL from a few macro names

Adding the following commits on top of the v4
- add supplies for pseudo-differential chips
- prepare driver to add more compatible parts
- add support for 4-channel compatible parts

- Link to v4: https://lore.kernel.org/all/20240110-ad7380-mainline-v4-0-93a1d96b50fa@baylibre.com

Changes in v4:
- Dropped SPI bindings patch.
- Removed `spi-rx-bus-channels` from the adi,ad7380 bindings.
- Link to v3: https://lore.kernel.org/r/20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com

Changes in v3:
- dt-bindings:
    - Picked up Conor's Reviewed-By on the adi,ad7380 bindings
- driver:
    - Removed extra indent in DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL macro
    - Removed scan mask that included timestamp channel
    - Removed parent device assignment
    - Picked up Nuno's Reviewed-by
- Link to v2: https://lore.kernel.org/r/20231213-ad7380-mainline-v2-0-cd32150d84a3@baylibre.com

Changes in v2:
- dt-bindings:
    - Added new patch with generic spi-rx-bus-channels property
    - Added maxItems to reg property
    - Replaced adi,sdo-mode property with spi-rx-bus-channels
    - Made spi-rx-bus-channels property optional with default value of 1
      (this made the if: check more complex)
    - Changed example to use gpio for interrupt
- driver:
    - Fixed CONFIG_AD7380 in Makefile
    - rx_buf = st->scan_data.raw instead of rx_buf = &st->scan_data
    - Moved iio_push_to_buffers_with_timestamp() outside of if statement
    - Removed extra blank lines
    - Renamed regulator disable function
    - Dropped checking of adi,sdo-mode property (regardless of the actual
      wiring, we can always use 1-wire mode)
    - Added available_scan_masks
    - Added check for missing driver match data
- Link to v1: https://lore.kernel.org/r/20231208-ad7380-mainline-v1-0-2b33fe2f44ae@baylibre.com

To: Lars-Peter Clausen <lars@metafoo.de>
To: Michael Hennerich <Michael.Hennerich@analog.com>
To: Nuno Sá <nuno.sa@analog.com>
To: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
David Lechner (4):
      dt-bindings: iio: adc: Add binding for AD7380 ADCs
      iio: adc: ad7380: new driver for AD7380 ADCs
      dt-bindings: iio: adc: ad7380: add pseudo-differential parts
      iio: adc: ad7380: add support for pseudo-differential parts

Julien Stephan (6):
      iio: adc: ad7380: prepare for parts with more channels
      dt-bindings: iio: adc: ad7380: add support for ad738x-4 4 channels variants
      iio: adc: ad7380: add support for ad738x-4 4 channels variants
      iio: adc: ad7380: add oversampling support
      iio: adc: ad7380: add support for rolling average oversampling mode
      iio: adc: ad7380: add support for resolution boost

 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7380 |   38 +
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |  148 +++
 MAINTAINERS                                        |   11 +
 drivers/iio/adc/Kconfig                            |   16 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad7380.c                           | 1019 ++++++++++++++++++++
 6 files changed, 1233 insertions(+)
---
base-commit: b80ad8e3cd2712b78b98804d1f59199680d8ed91
change-id: 20240311-adding-new-ad738x-driver-5f9b54ad7c74

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


