Return-Path: <linux-kernel+bounces-132436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AE88994ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A344D1F223D6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5E422626;
	Fri,  5 Apr 2024 06:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpGfKh6n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499271EB2B;
	Fri,  5 Apr 2024 06:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297319; cv=none; b=PeSTkjlIbXAb9P3gup/1+F9WfW+n5FsTtKhjOo3IAYc9RAiRlgK/N9gG+OxXBzRgOtrfOADp7cHN6BJ+fPAeIJ2ZxjMVy4EB95upu9brdn0Y1Y59rk8DaJRGFsloaUGvjMPaSfC5lnSZsAecZYGzNNWO97+njFu0UOE5GIy2ANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297319; c=relaxed/simple;
	bh=3a2D8FLQ+zRKWr+dT+h2iE0Z2sanm7uNODeFnm2l0+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BZqJI5J8BfqGhXCWnjpQbma41TgAAp+qYteLANOYl3MPvvqVp5R2wo0G8IaRK86Wph9ucVJSlMVp6t2BJ7uzwiqZENiCNvS8wkYyLzLkD0tia+i5zbtJNwcizpcny9tm1DTCk/SBgbzNKv/bIYAlg0e0a2gurBqRPOLIFSIC/3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpGfKh6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEF8C433F1;
	Fri,  5 Apr 2024 06:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712297319;
	bh=3a2D8FLQ+zRKWr+dT+h2iE0Z2sanm7uNODeFnm2l0+Y=;
	h=From:To:Cc:Subject:Date:From;
	b=gpGfKh6nDc7tcL07n3W/XO8V28YegkSc6XbhqFudjoYAoEcSCW65UXjShFQohkTxJ
	 NkiOqw/nDvbB/7Wp8V++4rR754zLEnQCcGMJRDCQZkS6sXlochANSJ2qkSpvu3MJ8f
	 y4pEho6HNQUYBnegAqqNlAWtWmwqqthP7t4QvOrj9dvOwHufEauqpiADXvX44F5c0y
	 ++d/E1f7AGfsF1/fvL7o4l72BK0/4NRsWrn9Ypb09dKMMkBEfhBmAElQHZArl2523F
	 A9gXXuQqCULLb5f/umebextqlEBfVsOgazcNMvjXfsBfITmLHpDWCKZMxCYz9u2VDC
	 py2I1SMgou3Pw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Al Cooper <alcooperx@gmail.com>,
	Alexander Shiyan <shc_work@mail.ru>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Bjorn Andersson <andersson@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Fabio Estevam <festevam@gmail.com>,
	Hammer Hsieh <hammerh0314@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <michal.simek@amd.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Peter Korsgaard <jacmet@sunsite.dk>,
	Richard Genoud <richard.genoud@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stefani Seibold <stefani@seibold.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Timur Tabi <timur@kernel.org>,
	Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 00/15] tty: serial: switch from circ_buf to kfifo
Date: Fri,  5 Apr 2024 08:08:11 +0200
Message-ID: <20240405060826.2521-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series switches tty serial layer to use kfifo instead of circ_buf.

The reasoning can be found in the switching patch in this series:
"""
Switch from struct circ_buf to proper kfifo. kfifo provides much better
API, esp. when wrap-around of the buffer needs to be taken into account.
Look at pl011_dma_tx_refill() or cpm_uart_tx_pump() changes for example.

Kfifo API can also fill in scatter-gather DMA structures, so it easier
for that use case too. Look at lpuart_dma_tx() for example. Note that
not all drivers can be converted to that (like atmel_serial), they
handle DMA specially.

Note that usb-serial uses kfifo for TX for ages.
"""

Cc: Al Cooper <alcooperx@gmail.com>
Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Hammer Hsieh <hammerh0314@gmail.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Simek <michal.simek@amd.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: "Pali Rohár" <pali@kernel.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Richard Genoud <richard.genoud@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Stefani Seibold <stefani@seibold.net>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Taichi Sugaya <sugaya.taichi@socionext.com>
Cc: Takao Orito <orito.takao@socionext.com>
Cc: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Timur Tabi <timur@kernel.org>
Cc: Vineet Gupta <vgupta@kernel.org>

Jiri Slaby (SUSE) (15):
  kfifo: drop __kfifo_dma_out_finish_r()
  kfifo: introduce and use kfifo_skip_count()
  kfifo: add kfifo_out_linear{,_ptr}()
  kfifo: remove support for physically non-contiguous memory
  kfifo: rename l to len_to_end in setup_sgl()
  kfifo: pass offset to setup_sgl_buf() instead of a pointer
  kfifo: add kfifo_dma_out_prepare_mapped()
  kfifo: fix typos in kernel-doc
  tty: 8250_dma: use dmaengine_prep_slave_sg()
  tty: 8250_omap: use dmaengine_prep_slave_sg()
  tty: msm_serial: use dmaengine_prep_slave_sg()
  tty: serial: switch from circ_buf to kfifo
  tty: atmel_serial: use single DMA mapping for TX
  tty: atmel_serial: define macro for RX size
  tty: atmel_serial: use single DMA mapping for RX

 drivers/tty/serial/8250/8250_bcm7271.c  |  14 +--
 drivers/tty/serial/8250/8250_core.c     |   3 +-
 drivers/tty/serial/8250/8250_dma.c      |  31 +++--
 drivers/tty/serial/8250/8250_exar.c     |   5 +-
 drivers/tty/serial/8250/8250_mtk.c      |   2 +-
 drivers/tty/serial/8250/8250_omap.c     |  48 +++++---
 drivers/tty/serial/8250/8250_pci1xxxx.c |  50 ++++----
 drivers/tty/serial/8250/8250_port.c     |  22 ++--
 drivers/tty/serial/amba-pl011.c         |  46 +++-----
 drivers/tty/serial/ar933x_uart.c        |  15 ++-
 drivers/tty/serial/arc_uart.c           |   8 +-
 drivers/tty/serial/atmel_serial.c       | 150 +++++++++++-------------
 drivers/tty/serial/clps711x.c           |  12 +-
 drivers/tty/serial/cpm_uart.c           |  20 ++--
 drivers/tty/serial/digicolor-usart.c    |  12 +-
 drivers/tty/serial/dz.c                 |  13 +-
 drivers/tty/serial/fsl_linflexuart.c    |  17 +--
 drivers/tty/serial/fsl_lpuart.c         |  39 +++---
 drivers/tty/serial/icom.c               |  25 +---
 drivers/tty/serial/imx.c                |  54 ++++-----
 drivers/tty/serial/ip22zilog.c          |  26 ++--
 drivers/tty/serial/jsm/jsm_cls.c        |  29 ++---
 drivers/tty/serial/jsm/jsm_neo.c        |  38 ++----
 drivers/tty/serial/max3100.c            |  14 +--
 drivers/tty/serial/max310x.c            |  35 +++---
 drivers/tty/serial/men_z135_uart.c      |  26 ++--
 drivers/tty/serial/meson_uart.c         |  11 +-
 drivers/tty/serial/milbeaut_usio.c      |  15 +--
 drivers/tty/serial/msm_serial.c         | 114 +++++++++---------
 drivers/tty/serial/mvebu-uart.c         |   8 +-
 drivers/tty/serial/mxs-auart.c          |  23 +---
 drivers/tty/serial/pch_uart.c           |  21 ++--
 drivers/tty/serial/pic32_uart.c         |  15 ++-
 drivers/tty/serial/pmac_zilog.c         |  24 ++--
 drivers/tty/serial/qcom_geni_serial.c   |  36 +++---
 drivers/tty/serial/rda-uart.c           |  17 +--
 drivers/tty/serial/samsung_tty.c        |  54 +++++----
 drivers/tty/serial/sb1250-duart.c       |  13 +-
 drivers/tty/serial/sc16is7xx.c          |  40 +++----
 drivers/tty/serial/sccnxp.c             |  16 ++-
 drivers/tty/serial/serial-tegra.c       |  43 ++++---
 drivers/tty/serial/serial_core.c        |  56 ++++-----
 drivers/tty/serial/serial_port.c        |   2 +-
 drivers/tty/serial/sh-sci.c             |  51 ++++----
 drivers/tty/serial/sprd_serial.c        |  20 ++--
 drivers/tty/serial/st-asc.c             |   4 +-
 drivers/tty/serial/stm32-usart.c        |  52 ++++----
 drivers/tty/serial/sunhv.c              |  35 +++---
 drivers/tty/serial/sunplus-uart.c       |  16 +--
 drivers/tty/serial/sunsab.c             |  30 ++---
 drivers/tty/serial/sunsu.c              |  15 +--
 drivers/tty/serial/sunzilog.c           |  27 ++---
 drivers/tty/serial/tegra-tcu.c          |  10 +-
 drivers/tty/serial/timbuart.c           |  17 ++-
 drivers/tty/serial/uartlite.c           |  13 +-
 drivers/tty/serial/ucc_uart.c           |  20 ++--
 drivers/tty/serial/xilinx_uartps.c      |  20 ++--
 drivers/tty/serial/zs.c                 |  13 +-
 include/linux/kfifo.h                   | 143 ++++++++++++++++------
 include/linux/serial_core.h             |  49 +++++---
 lib/kfifo.c                             | 107 +++++++++--------
 61 files changed, 944 insertions(+), 960 deletions(-)

-- 
2.44.0


