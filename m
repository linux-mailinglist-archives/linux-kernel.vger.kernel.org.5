Return-Path: <linux-kernel+bounces-91637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3816B871481
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E0F1C21B60
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D78F40BE6;
	Tue,  5 Mar 2024 03:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="qla71323"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A953FE47
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 03:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709611143; cv=none; b=LIPd1cwlnE5oO21TM+1DVJClzV20pYuSMpnG5d7meHyOFxX7enCk9NYVrPS/AuOoRyo4zdAAcoTyz80cHIhszihcqvGuYRO4lEd8Vj+ogVaK6CA8JnDAKgOVjUFdL3xVqniQ1THVZe1CDRNYO1PVX644g58SnjW0hnQ7D8LdpT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709611143; c=relaxed/simple;
	bh=bXAGuUxRBCgObUsqSXoOe+c0gDtKh1q3nZ/KUl5RdvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EVIodqR3ANEi9Ff66jAxnhebmZRqetCUF00Ba/6PVUGyKsMHjolb7MDptYc2QqqXhWxE5UyUo3pMiB86oQ7xaf0Aqy/CBUAeYWZ0zj95bNyMuS/MpEMVtx5sdKwB0qlE8iAaw6+xKBOZO9z4C4+hJjqp2n22BChS8srrRqtmosM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=qla71323; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F3EAC2C04EC;
	Tue,  5 Mar 2024 16:58:57 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1709611138;
	bh=DHrpp2tA0LcOHes0WuPnCXMuY2OQGO2ESTJzGh+hfXk=;
	h=From:To:Cc:Subject:Date:From;
	b=qla71323Yv55yancZ8ARlNncFdOPNxSE3/+wva5OdKINFOjcGxxsWAzwKL0ukbgrB
	 jwGkIP7vksKP2pORvu+6WvjUyUw0GB2wEJaSbne4wwFWODYAvshW93n735KULTC9wq
	 kfAgujJvACHWmEHD1k90Q4IPkbejZI7W/ErgLxNpbGpQO67I1ZAsncD9/k4+yan/0q
	 Wkl/HQQH25wZO27Dz9P6tBbF+JTRt+eqIN+vSkCUH3Ihkp9o9H1LPIq7yiYq/plisX
	 njNGRoREaL7a/iVeB2nsVfCpdy+sahn7VzXuxlNcnxrFk3zRXeTc/RrJMeI8HwegdZ
	 WaiFQScB9hjYg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65e698810000>; Tue, 05 Mar 2024 16:58:57 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id A8F8813ED56;
	Tue,  5 Mar 2024 16:58:57 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id A1D8928084D; Tue,  5 Mar 2024 16:58:57 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: andy@kernel.org,
	geert@linux-m68k.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	lee@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-leds@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v4 0/3] auxdisplay: 7-segment LED display
Date: Tue,  5 Mar 2024 16:58:49 +1300
Message-ID: <20240305035853.916430-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65e69881 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=K6JAEmCyrfEA:10 a=vR_gaf37D5lytMZdZ5IA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

This series adds a driver for a 7-segment LED display.

I think I've addressed all of Andy's feedback in this round. I haven't
heard from the ARM maintainers on any of the previous rounds. At Andy's
request I've dropped the USB LED change as it's not related. I can
submit the dts change separately if required, I've mostly been including
it so there is an in-tree user of the driver I'm adding.

Chris Packham (3):
  auxdisplay: Add 7-segment LED display driver
  dt-bindings: auxdisplay: Add bindings for generic 7-segment LED
  ARM: dts: marvell: Add 7-segment LED display on x530

 .../bindings/auxdisplay/gpio-7-segment.yaml   |  54 +++++++++
 .../boot/dts/marvell/armada-385-atl-x530.dts  |  13 ++-
 drivers/auxdisplay/Kconfig                    |  10 ++
 drivers/auxdisplay/Makefile                   |   1 +
 drivers/auxdisplay/seg-led-gpio.c             | 109 ++++++++++++++++++
 5 files changed, 186 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/gpio-7-s=
egment.yaml
 create mode 100644 drivers/auxdisplay/seg-led-gpio.c

--=20
2.43.2


