Return-Path: <linux-kernel+bounces-47335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E965F844D4B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24C51B317BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CEA3B195;
	Wed, 31 Jan 2024 23:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="mF/Ok2ZD"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AD33AC2D;
	Wed, 31 Jan 2024 23:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742379; cv=none; b=NHdzikaBiJ106ZF3ZlgvV1evvG7l+vB12Kn9K9C3D6/Bba+uu32ibl93JjHioPh80yg3yD0nhP25YlO1fU4nZ9q3aSpt7oZn+CkhHSNp5p/iS/00WmoO3c7P0o4HrhyofL7KEAMov92ihF21Vt/kQLdqIbo9jgxUsxkfj5k9xSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742379; c=relaxed/simple;
	bh=yQ5sSp/srX5L79aKi05FfTRn8K15X3L/qJZyRoFxKgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBBNt7qEkcyZwUkC3vbOoU6w1/wlrh7BxglYGizILmXDikt7pwylEHACoT4lpubW+vgVxL7vQTEkIdvJ4apF2iQH22YXEcJet3b/jS/Uv1fFGBaqgX3GQxC7HqamGtZelWwRCfhYqpRk2rXbgyMyPt4MSo7pkvIb2+8AbJVDND4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=mF/Ok2ZD; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 54A179C0490;
	Wed, 31 Jan 2024 18:06:15 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id IIYOHo_50m_G; Wed, 31 Jan 2024 18:06:14 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1F4AB9C443E;
	Wed, 31 Jan 2024 18:06:14 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 1F4AB9C443E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1706742374; bh=YyNZx9Kwr8uHCYcqYCuicqbnXCLiCFYtvBTXF0+LUw4=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=mF/Ok2ZDiSGhdWQqS+QVDX286AyN/NDizeBLKr/O/in21PI9WIqOa8d9hxpmlaxX1
	 BLaSknULAL5EDKkFuuBaqAsp92c/wWmv5a/xjE787MvtRV0W15ElzUgJkj1e/Kx1aE
	 4NCmfIGa/6XfadWi3T55rTiYqiDcLEN+NsoXl9tYfpbVJO+36VpYlyBgtRMs+3Z1DK
	 71Ht45tQ2cy5/Uxityg9vvawsN3pzpaJWvOSF8PSs1Z2mDB5fNrtRmWcbs+umFaFyT
	 6FgGxFpIGVxBK0bRllmkAZcIjhOkGgXFSJd91g4vFP3huXY5q69c93It5Jq/2dr/Cw
	 yriiyZzOFgLgQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id biSyfPgtlLx9; Wed, 31 Jan 2024 18:06:14 -0500 (EST)
Received: from pcperry.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id D4ACE9C0490;
	Wed, 31 Jan 2024 18:06:13 -0500 (EST)
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
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] fpga: xilinx-selectmap: add new driver
Date: Wed, 31 Jan 2024 18:05:30 -0500
Message-ID: <20240131230542.3993409-1-charles.perry@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
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

v2: From Krzysztof Kozlowski review's:
  * Use more conventional names for gpio DT bindings
  * fix example in DT bindings
  * add mc-peripheral-props.yaml to DT bindings
  * fix various formatting mistakes
  * Remove all occurences of the "slave" word.

Charles Perry (3):
  fpga: xilinx-spi: extract a common driver core
  dt-bindings: fpga: xlnx,fpga-slave-selectmap: add DT schema
  fpga: xilinx-selectmap: add new driver

 .../bindings/fpga/xlnx,fpga-selectmap.yaml    |  83 +++++++
 drivers/fpga/Kconfig                          |  12 +
 drivers/fpga/Makefile                         |   2 +
 drivers/fpga/xilinx-core.c                    | 215 ++++++++++++++++++
 drivers/fpga/xilinx-core.h                    |  28 +++
 drivers/fpga/xilinx-selectmap.c               | 106 +++++++++
 drivers/fpga/xilinx-spi.c                     | 205 ++---------------
 7 files changed, 462 insertions(+), 189 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-sele=
ctmap.yaml
 create mode 100644 drivers/fpga/xilinx-core.c
 create mode 100644 drivers/fpga/xilinx-core.h
 create mode 100644 drivers/fpga/xilinx-selectmap.c

--
2.43.0

