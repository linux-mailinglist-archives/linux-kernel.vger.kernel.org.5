Return-Path: <linux-kernel+bounces-69932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8524285906D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD181F221E0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CE67C0BD;
	Sat, 17 Feb 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eHD9vhL2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE55B7C0A7
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708182880; cv=none; b=CqdkelSVjvUBl4lhyq+p56g24AyjLAjQGwoAXFDaXkp3gYIb18kuNAJUKBlumVVaMjuImnAT2G8X4vB1vGi4m8cH7uLZclnQf9rD/eoqYAITYPuWkcUIIGD9x1MqJZzIQrMeKYTMeIdGIFsRczKNznlo2t+7l73VwniM36lt+3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708182880; c=relaxed/simple;
	bh=XrwzlzkwkeqLkklx5L24R2ZN1JisgI1/EvrjQXWqmnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N7uaMikgbVbJ/r/U34GsGcNpyMsCXhCtaElu6JqbJhQfNRksouClWaYiyT9Fx7S0jU0UW18lCsEHP8XjM4UBIhSmJomE9HcQM7ByMsgJTP8lp7V+5TzzL6AuurhCAA0c/wu8XRx1JsHV3zRRrRblACVqxWxTflBI1bMj2BY3Vto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eHD9vhL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02AEC433C7;
	Sat, 17 Feb 2024 15:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708182880;
	bh=XrwzlzkwkeqLkklx5L24R2ZN1JisgI1/EvrjQXWqmnQ=;
	h=Date:From:To:Cc:Subject:From;
	b=eHD9vhL2VurKeQlzj9TIEAYanvwvc3cXU2R95RydI4bB/Ll3fLrwiCCJHXYmbg902
	 m/SanCFrQ+QBD3NW+60DhV2WfpGBSAvEjCYG6v3EmAaRmZs4wsIj4lCGwh5/bP+VHB
	 3WQqdoq8QpDR6mrEf7BA6TM1l3uQW/eocy11c2Jw=
Date: Sat, 17 Feb 2024 16:14:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.8-rc5
Message-ID: <ZdDNXWXBNNY5lc4B@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.8-rc5

for you to fetch changes up to e20f378d993b1034eebe3ae78e67f3ed10e75356:

  nvmem: include bit index in cell sysfs file name (2024-02-14 16:28:16 +0100)

----------------------------------------------------------------
Char/Misc changes for 6.8-rc5

Here is a small set of char/misc and IIO driver fixes for 6.8-rc5

Included in here are:
  - lots of iio driver fixes for reported issues
  - nvmem device naming fixup for reported problem
  - interconnect driver fixes for reported issues

All of these have been in linux-next for a while with no reported the
issues (the nvmem patch was included in a different branch in linux-next
before sent to me for inclusion here.)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      nvmem: include bit index in cell sysfs file name

Cosmin Tanislav (2):
      iio: adc: ad4130: zero-initialize clock init data
      iio: adc: ad4130: only set GPIO_CTRL if pin is unused

Dan Carpenter (1):
      iio: adc: ad7091r8: Fix error code in ad7091r8_gpio_setup()

David Schiller (1):
      staging: iio: ad5933: fix type mismatch regression

Dimitri Fedrau (1):
      iio: humidity: hdc3020: fix temperature offset

Dinghao Liu (1):
      iio: core: fix memleak in iio_device_register_sysfs

Greg Kroah-Hartman (2):
      Merge tag 'icc-6.8-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus
      Merge tag 'iio-fixes-for-6.8a' of http://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus

Javier Carrasco (1):
      iio: move LIGHT_UVA and LIGHT_UVB to the end of iio_modifier

Jonathan Cameron (1):
      iio: humidity: hdc3020: Add Makefile, Kconfig and MAINTAINERS entry

Konrad Dybcio (2):
      interconnect: qcom: sc8180x: Mark CO0 BCM keepalive
      interconnect: qcom: sm8550: Enable sync_state

Mario Limonciello (1):
      iio: accel: bma400: Fix a compilation problem

Mike Tipton (2):
      interconnect: qcom: sm8650: Use correct ACV enable_mask
      interconnect: qcom: x1e80100: Add missing ACV enable_mask

Nuno Sa (3):
      iio: imu: adis: ensure proper DMA alignment
      iio: adc: ad_sigma_delta: ensure proper DMA alignment
      iio: commom: st_sensors: ensure proper DMA alignment

Randy Dunlap (1):
      iio: imu: bno055: serdev requires REGMAP

Sam Protsenko (1):
      iio: pressure: bmp280: Add missing bmp085 to SPI id table

Srinivas Pandruvada (1):
      iio: hid-sensor-als: Return 0 for HID_USAGE_SENSOR_TIME_TIMESTAMP

zhili.liu (1):
      iio: magnetometer: rm3100: add boundary check for the value read from RM3100_REG_TMRC

 Documentation/ABI/testing/sysfs-nvmem-cells     | 16 ++++++++--------
 MAINTAINERS                                     |  8 ++++++++
 drivers/iio/accel/Kconfig                       |  2 ++
 drivers/iio/adc/ad4130.c                        | 12 ++++++++----
 drivers/iio/adc/ad7091r8.c                      |  2 +-
 drivers/iio/humidity/Kconfig                    | 12 ++++++++++++
 drivers/iio/humidity/Makefile                   |  1 +
 drivers/iio/humidity/hdc3020.c                  |  2 +-
 drivers/iio/imu/bno055/Kconfig                  |  1 +
 drivers/iio/industrialio-core.c                 |  5 ++++-
 drivers/iio/light/hid-sensor-als.c              |  1 +
 drivers/iio/magnetometer/rm3100-core.c          | 10 ++++++++--
 drivers/iio/pressure/bmp280-spi.c               |  1 +
 drivers/interconnect/qcom/sc8180x.c             |  1 +
 drivers/interconnect/qcom/sm8550.c              |  1 +
 drivers/interconnect/qcom/sm8650.c              |  2 +-
 drivers/interconnect/qcom/x1e80100.c            |  1 +
 drivers/nvmem/core.c                            |  5 +++--
 drivers/staging/iio/impedance-analyzer/ad5933.c |  2 +-
 include/linux/iio/adc/ad_sigma_delta.h          |  4 +++-
 include/linux/iio/common/st_sensors.h           |  4 ++--
 include/linux/iio/imu/adis.h                    |  3 ++-
 include/uapi/linux/iio/types.h                  |  4 ++--
 23 files changed, 73 insertions(+), 27 deletions(-)

