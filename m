Return-Path: <linux-kernel+bounces-125924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90351892E48
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 04:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A420B21754
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 02:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113124C79;
	Sun, 31 Mar 2024 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rQmPuSUa"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCADA5F;
	Sun, 31 Mar 2024 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711851594; cv=none; b=F9A40dHtBdCI/T+rCbGZneRNh8c+mhnBnxdEUy6wzSoTuIKzF70DpZa25VFQoIlp5fSgeEUb7Mkbk7hPaTPCUhvWVsyCz3NPKMkfW8sqkXLkxIuEuLfYeqdyvAsQHLwQBHDmff1eOtN8J8CsKjFonEcPFYD71BiDk9amGHz2pMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711851594; c=relaxed/simple;
	bh=yomuf4wkK7hH4Up2rIVQWisnRt7HZ+ENL8Z1fLklLBE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q5VycOxnz09pfV00AuVgOD2blCQnwsHASOyo2UVraSYRNsMtG0ZGVxijIWdA+guAk+sbIa/hCMTUtC6llzAL5QmmHpwgkoqPH/IBmNRUCu/btCY8MQw9WFvUU0j3Q9kyn/MRML5xDGZ3QE4c4xwITR4Ezaq1YYwPzrvCg9CTQE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rQmPuSUa; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42V2Ikea068473;
	Sat, 30 Mar 2024 21:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711851526;
	bh=E9jrArP2IKtmwsCk5q7YN2on1sNGXBccHWbEIEhgr2g=;
	h=From:To:CC:Subject:Date;
	b=rQmPuSUaHSu730vdzCd0OQH7rdUqCFEl8st9M7HPjPrfGbHBAGC/onI16xVRsXf6m
	 YKyb8scrt9bbBX2/oPuIo7BkKgviX5fi7q7wp+kgGFU6mdtbY19Qhr0v3KDzUamsdL
	 cxXOAqjDZZl0P5reaJ1K+k/t0+R649z+MqqqIchg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42V2IkTx076791
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 30 Mar 2024 21:18:46 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 30
 Mar 2024 21:18:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 30 Mar 2024 21:18:45 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42V2Icm9106026;
	Sat, 30 Mar 2024 21:18:39 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-kernel@vger.kernel.org>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <13916275206@139.com>,
        <mohit.chawla@ti.com>, <soyer@irl.hu>, <jkhuang3@ti.com>,
        <tiwai@suse.de>, <pdjuandi@ti.com>, <manisha.agrawal@ti.com>,
        <s-hari@ti.com>, <aviel@ti.com>, <hnagalla@ti.com>, <praneeth@ti.com>,
        <Baojun.Xu@fpt.com>, Shenghao Ding
	<shenghao-ding@ti.com>
Subject: [PATCH v7 0/4] mixer-test report
Date: Sun, 31 Mar 2024 10:18:30 +0800
Message-ID: <20240331021835.1470-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

*** BLURB HERE ***
mixer-test report:
 root@am335x-evm:/bin# mixer-test
 TAP version 13
 # Card 0 - TI BeagleBone Black (TI BeagleBone Black)
 1..7
 ok 1 get_value.0.0
 # 0.0 pcmd3180-i2c-2 Profile id
 ok 2 name.0.0
 ok 3 write_default.0.0
 ok 4 write_valid.0.0
 ok 5 write_invalid.0.0
 ok 6 event_missing.0.0
 ok 7 event_spurious.0.0
 # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
 root@am335x-evm:/bin#

Shenghao Ding (4):
  ASoc: PCM6240: Create PCM6240 Family driver code
  ASoc: PCM6240: Create header file for PCM6240 Family driver code
  ASoc: PCM6240: Add compile item for PCM6240 Family driver
  ASoc: dt-bindings: PCM6240: Add initial DT binding

 .../devicetree/bindings/sound/ti,pcm6240.yaml |  177 ++
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/pcm6240.c                    | 2071 +++++++++++++++++
 sound/soc/codecs/pcm6240.h                    |  236 ++
 5 files changed, 2496 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
 create mode 100644 sound/soc/codecs/pcm6240.c
 create mode 100644 sound/soc/codecs/pcm6240.h

-- 
2.34.1


