Return-Path: <linux-kernel+bounces-1190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1111C814B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36401C236E2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732D13D396;
	Fri, 15 Dec 2023 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="p7olcrbW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AB83C6A3;
	Fri, 15 Dec 2023 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702653210; x=1734189210;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ybPCAvLgR8sMS4w/W/i9x0ElPfV/wtar3ypvuVot4nU=;
  b=p7olcrbWmAfiBHRdt0+dn1nEllp2wdqxhxxeEeycsvTnTJZmD2L3sked
   y96zHgRlGOp8321g7LKGLGLAqRjBoB5rwze5Qa0zk+e2p7li1h7zANWkF
   zixNrLesZ2GyEyAcjVZDIfM8SzGjdJUPdvjjdRCUzGVXmr/IO9LfVbJJf
   gJpQr8gF69ZwDrYuvScY5r90wBSc5mEam2FU8cvGcQ8Tzh2dAg2NB5VZQ
   RxtnoTOkZKCG/NvGMxgJaR6l7fsAIJdjHyZzO2EbkuDcUB4NEdfzcaAHw
   oxYz+5LvfNmeOPhrBu3k3FRcyYnP8hAICJDi5EA1H8lwF87RSC5t6kAgb
   g==;
X-CSE-ConnectionGUID: ZSd0znorTjqGetiYJCobuQ==
X-CSE-MsgGUID: JZz+o+VzS/2pohpxO5iIMQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="180577318"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Dec 2023 08:13:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 08:13:09 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 08:13:06 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <kumaravel.thiagarajan@microchip.com>,
	<tharunkumar.pasumarthi@microchip.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <keescook@chromium.org>, <gustavoars@kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
CC: <unglinuxdriver@microchip.com>
Subject: [PATCH v1 tty-next 0/4] 8250: microchip: Burst Mode Support for PCI1XXXX
Date: Fri, 15 Dec 2023 20:41:19 +0530
Message-ID: <20231215151123.41812-1-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series improves the UART performance in PCI1XXXX from C0 rev
using burst mode operation. Each transaction processes DWORDs at a time
and the remaining bytes are handled byte-by-byte. With burst mode access
the baud rate support is extended from 1.5 Mbps to 3.9 Mbps.

v1
Initial Submission for review

Rengarajan S (4):
  8250: microchip: pci1xxxx: Rearranging the structure declarations
  8250: microchip: pci1xxxx: Add Syslock support for reading UART system
    registers
  8250: microchip: pci1xxxx: Add Burst mode reception support in uart
    driver for writing into FIFO
  8250: microchip: pci1xxxx: Add Burst mode transmission support in uart
    driver for reading from FIFO

 drivers/tty/serial/8250/8250_pci1xxxx.c | 313 ++++++++++++++++++++++--
 1 file changed, 299 insertions(+), 14 deletions(-)

-- 
2.25.1


