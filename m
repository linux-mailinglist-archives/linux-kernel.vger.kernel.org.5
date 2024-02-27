Return-Path: <linux-kernel+bounces-82502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7779C868570
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316D2286D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB995468E;
	Tue, 27 Feb 2024 01:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="us0pGKxw"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1444A0A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995800; cv=none; b=r84EZzRc8hMAhL5zAAbG2UnkoQMbQAPf32jZ6N7wnjAh7rualCWVqFqYHH5xLDwsKLo2ZZnhEvTW747BX12sb6+VglvLahnst4dnRu25Q220DIJcYv0zf4ub4utrUYLt1v3SwvmXbhAj4fa03yY2k6Da8t3XovYXDarKvHE958o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995800; c=relaxed/simple;
	bh=gvzIXwDpjX4d5S1VMkvaaNcPTk6/807T5LNMxRG5Up0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fQRVp5Q3afkPbl8xePKAwTBAkSyLIdMLmw50P4PkfLdew95dfGW/0aCEI9DjfshNLjhiJ8LzsaDOlqyEDrT6UG8oVRECYAwp/1009h4CHelQHkbVenhIrex10vh1QieyhkIB56xjBqnBfTW49H/AADM21PyWLCwYA7v6zITl6UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=us0pGKxw; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E8AA22C0191;
	Tue, 27 Feb 2024 14:03:15 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1708995795;
	bh=5jYi58IRw9o2odkhlI79h95g1PWiKPkvmtYQOTlKynw=;
	h=From:To:Cc:Subject:Date:From;
	b=us0pGKxw7A2atK8sKb7+Qj7gfMz3bVNuyqPOcf9Av6wU5ocSMjUDVZbu0wU/cIGh6
	 0rLuL6zY9z3uNug0j8TdOCvqoKD3SfzzwX31ICHBw7kU6p1gh/gyyrksd0A9tVCoCf
	 CmCPCEDf35cZZnIk5I9fE5pdo66KA5tbuSRE1ZRzPSHqVescLwKlRMlN11yhZ5yG6/
	 gybxKayespE7iT2YIN033Edr8PqtkvP7N9EaWsjUbjqp1cLio8hMTURtfdn/GuZHaH
	 NiG/ltOQrTFnwnzE6M0bi81MW+CMUR13Ygfue5iRA5Zve3cq2biF5uotdUE2iTY7o+
	 aanxY77OFYm9w==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65dd34d30000>; Tue, 27 Feb 2024 14:03:15 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 6BAE213ED8D;
	Tue, 27 Feb 2024 14:03:15 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 657872807DC; Tue, 27 Feb 2024 14:03:15 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: antoniu.miclaus@analog.com,
	alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v8 0/2] drivers: rtc: add max313xx series rtc driver
Date: Tue, 27 Feb 2024 14:03:08 +1300
Message-ID: <20240227010312.3305966-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65dd34d3 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=k7vzHIieQBIA:10 a=gAnH3GRIAAAA:8 a=QyXUC8HyAAAA:8 a=GvT1rX6jx7WGb4_MOu8A:9 a=3ZKOabzyN94A:10 a=oVHKYsEdi7-vN-J5QA_j:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Datasheets:
  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX=
31328.pdf
  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX=
31329.pdf
  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX=
31331.pdf
  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX=
31334.pdf
  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX=
31341B-MAX31341C.pdf
  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX=
31342.pdf
  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX=
31343.pdf

changelog:
since v7:
  - Rename variables and functions to reduce delta with existing max31335
    driver
  - clean up some sparse warnings
  - Keep old dt-binding name
since v6:
  - Roll changes into max31335 driver that was landed while this was
    in-flight.
  - Adjusted code order and variable names to reduce the delta with
    the max31335

since v5:
  - change of maintainer
  - use adi,ti-diode property
  - deal with oscillator fail and releasing SWRST

since v4:
  - dt-binding: add enum value "2" to aux-voltage-chargable
  - dt-binding: remove adi,trickle-diode-enable
  - dt-binding: change description of trickle-resistor-ohms
  - dt-binding: reorder as in example schema
  - parse "wakeup-source" when irq not requested
  - remove limitation on max31328 irq and clockout
  - remove error and warning messages during trickle charger setup

since v3:
  - dt-binding: remove interrupt names.
  - dt-binding: add description for "interrupts" property
  - dt-binding: replace deprecated property "trickle-diode-disable"
      by "aux-voltage-chargeable"
  - dt-binding: add new property "adi,trickle-diode-enable"
  - dt-binding: remove "wakeup-source"
  - use clear_bit instead of __clear_bit
  - use devm_of_clk_add_hw_provider instead of of_clk_add_provider
  - use chip_desc pointer as driver data instead of enum.

since v2:
  - add "break" to fix warning: unannotated fall-through
    Reported-by: kernel test robot <lkp@intel.com>

since v1:
  - dt-binding: update title and description
  - dt-binding: remove last example
  - drop watchdog support
  - support reading 12Hr format instead of forcing 24hr at probe time
  - use "tm_year % 100" instead of range check
  - refactor max313xx_init for readability

Ibrahim Tilki (2):
  rtc:  max31335: Add support for additional chips
  dt-bindings: rtc: add max313xx RTCs

 .../devicetree/bindings/rtc/adi,max31335.yaml |  88 +-
 drivers/rtc/Kconfig                           |   2 +-
 drivers/rtc/rtc-max31335.c                    | 969 +++++++++++++-----
 3 files changed, 779 insertions(+), 280 deletions(-)

--=20
2.43.2


