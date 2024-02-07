Return-Path: <linux-kernel+bounces-56884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9BD84D0D1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFEBD1C24A13
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7663C85C50;
	Wed,  7 Feb 2024 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="Gk0hqWXx"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B1B82D84;
	Wed,  7 Feb 2024 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328955; cv=none; b=Ola3che+0VE5HmQY/qYASAYpWsQ/2KMp/trz/lrXsE6nA5SG/5K1c+lKItKGWOviOtSViAPJCPW439o/OG/3nfnvA90HR4UCehTFXK8S5bEgnOiMcQkwRzCjq7KRIlb/lEra/HqJ4oQ6SoC69FtxGj84gNkq42Jq1nHYy3sgso4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328955; c=relaxed/simple;
	bh=z136LXKA0PuDP+pN22K+c15MG1s8hrUVhUwd7Mft7wE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Km0NZZu8Y4Uk4Rm/OTpxA9dGUFgkTVoS78lxf09s7xSNmduAq3DQX649JibPLHETvjbBPx3kKfsKJOQNGLHJquSE850Oxegzgh+bSq+stp0fbH/v+zIOk3oThYEgzVsITQlwoOOrO3AF0/onSIip04N7hXrjUMbuITcOVcnbWnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=Gk0hqWXx; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2845C9C2AE3;
	Wed,  7 Feb 2024 13:02:25 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id YY61-W2GsUDK; Wed,  7 Feb 2024 13:02:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 769599C43A3;
	Wed,  7 Feb 2024 13:02:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 769599C43A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1707328944; bh=+4oiaVsOGXYuHSRiXQ/YZSZiOgTybQ6dnCa8ipMKIHI=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=Gk0hqWXxjUOFAZK+OfhFJod/epU3atRo76l9vXrCj7E2NBPwvJJHrHVnVeSe9yLu8
	 RXT8UDZVGyQUoD9OTpW1ATD6a3OkIRXI+8wnWS9/reViCZqEFVq6qET0Dyo7Da8zdE
	 vKOGwPyxDOFJhQlJdUsSuLoprecrq/HiieozIgAF1L2t7Y25/xi1NLf07Ts28MWBpG
	 WDLdlOgyJSgJYScl8/T1+sV0sA9IPmBLswcMT1jTJY7mzCa4p/hTGIbOfj9A/z1YJ9
	 eZOdUBsolxIxoJl6N3rNjEkBaO7laCJPptNxaiVO/oVNGnvt3M+UB9zhfJaMv52H5R
	 w26g0BXJmvPqw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id pQNA9LgsY3MQ; Wed,  7 Feb 2024 13:02:24 -0500 (EST)
Received: from pcperry.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 2FBB39C2AE3;
	Wed,  7 Feb 2024 13:02:24 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: mdf@kernel.org
Cc: avandiver@markem-imaje.com,
	bcody@markem-imaje.com,
	Charles Perry <charles.perry@savoirfairelinux.com>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	kishore Manne <nava.kishore.manne@amd.com>,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/5] fpga: xilinx-selectmap: add new driver
Date: Wed,  7 Feb 2024 13:01:23 -0500
Message-ID: <20240207180142.79625-1-charles.perry@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

This patchset adds a new driver for the 7 series FPGA's SelectMAP
interface.

The SelectMAP interface shares a common GPIO protocol with the SPI
interface which is already in the kernel (drivers/fpga/xilinx-spi.c).
The approach proposed in this patchset is to refactor xilinx-spi.c into
xilinx-core.c which would handle the common GPIO protocol. This is then
used to build two drivers, the already existing xilinx-spi.c driver and
a newly added xilinx-selectmap.c driver.

The SelectMAP driver proposed only supports 8 bit mode. This is because
the 16 and 32 bits mode have limitations with regards to compressed
bitstream support as well as introducing endianness considerations.

I'm testing xilinx-selectmap.c on a custom i.MX6 board connected to an
Artix 7 FPGA. Flashing a 913K bitstream takes 0.44 seconds.

Changes since v2:
 * Inserted patch 2 and 3 which rename "prog_b" and "init-b" into "prog"
   and "init" for the SPI driver.
 * From Krzysztof Kozlowski review's:
   * Use more specific compatible names
   * Remove other missing occurences of the slave word missed in v2.
 * From Xu Yilun review's:
   * Fix vertical whitespace in get_done_gpio().
   * Combine write() and write_one_dummy_byte() together.
   * Eliminate most of the xilinx_core_probe() arguments, the driver
     needs to populate those directly into the xilinx_fpga_core struct.
     Added some documentation to struct xilinx_fpga_core to clarify
     this.
   * Removed typedefs from xilinx-core.h.
   * Moved null checks in xilinx_core_probe() to first patch.
   * Move csi_b and rdwr_b out of xilinx_selectmap_conf as they are not
     used out of the probe function.

Changes since v1: (from Krzysztof Kozlowski review's)
  * Use more conventional names for gpio DT bindings
  * fix example in DT bindings
  * add mc-peripheral-props.yaml to DT bindings
  * fix various formatting mistakes
  * Remove all occurences of the "slave" word.


Charles Perry (5):
  fpga: xilinx-spi: extract a common driver core
  dt-bindings: fpga: xlnx,fpga-slave-serial: rename gpios
  fpga: xilinx-core: rename "prog_b" and "init-b" gpios
  dt-bindings: fpga: xlnx,fpga-selectmap: add DT schema
  fpga: xilinx-selectmap: add new driver

 .../bindings/fpga/xlnx,fpga-selectmap.yaml    |  86 +++++++
 .../bindings/fpga/xlnx,fpga-slave-serial.yaml |  12 +-
 drivers/fpga/Kconfig                          |  12 +
 drivers/fpga/Makefile                         |   2 +
 drivers/fpga/xilinx-core.c                    | 232 ++++++++++++++++++
 drivers/fpga/xilinx-core.h                    |  28 +++
 drivers/fpga/xilinx-selectmap.c               |  97 ++++++++
 drivers/fpga/xilinx-spi.c                     | 212 +---------------
 8 files changed, 476 insertions(+), 205 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-sele=
ctmap.yaml
 create mode 100644 drivers/fpga/xilinx-core.c
 create mode 100644 drivers/fpga/xilinx-core.h
 create mode 100644 drivers/fpga/xilinx-selectmap.c

--
2.43.0

