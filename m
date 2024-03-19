Return-Path: <linux-kernel+bounces-107332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E4387FB28
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227E21C20BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CED7D417;
	Tue, 19 Mar 2024 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGizSRYd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A127D083;
	Tue, 19 Mar 2024 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842009; cv=none; b=X101GlxGEzS86pcPvQ29m+3PTOZbSfTJWbYqPjD0NiaalDf9bwYtPwZGpfRq9+trVu6a4BeKDCnk4To5RKIBAaE4tMVG8hcUHWbr3qCcsXUvwQcM2iwvrcN9RqqJOBn/Kk8l5bmnBlJyu/bYLwxdLhlqQ8SpYe9hRKB9yUbOhh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842009; c=relaxed/simple;
	bh=ai0U2zh0od3mIZWy2eSqdoVTkokovEgyzUxpISIiZ7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rXvZ8vxFlmBQD64RYl7EYJBG/tnvnYMHxdzpaiy6+p1rFvGRRoaS6Q4ZaKPs11stygWqxvZjVZtBDqgwfW2+7DD8elUQBR5rTHgTY1LSH8z5Y+F+eBzWeG3djGhTzXZ8ZiFl76BI22CgYucsBVyuosuHNJHNVYaU1B8GTRciFFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGizSRYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320E8C43390;
	Tue, 19 Mar 2024 09:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710842008;
	bh=ai0U2zh0od3mIZWy2eSqdoVTkokovEgyzUxpISIiZ7Q=;
	h=From:To:Cc:Subject:Date:From;
	b=OGizSRYd4Dt2lxl4soBg5WoJ+adA/2jX4E2a5JOsSA9V9OZ4is/tXnnNlo9Y1tHQW
	 K/vGAF2iFcOVfkpMeKFF3u6/RwBV0G1Gg+PYPkO4miEuzIcQZ2seSd2b1Hx20LKhsj
	 CvEv99RJ4UUkgEGDABwEOgFmHMi5TgA3IaEdP/hv1iq1jc7f2zJ9zs8Jc11Y/oQgTf
	 ABirlSDmm6oOoYx83oht/L71/YC1NdESe8b3jgviAUCn3gHX6AUupeH9SUVbNw0MK+
	 ysie6fH0jEz65NWHe2vS1tE3p4hK7iT+/ysrJ7hXzy6tuOr6AVCJ2pvZr/Y5ylbTHP
	 AadAssOLVrSEw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
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
Subject: [RFT 00/15] tty: serial: switch from circ_buf to kfifo
Date: Tue, 19 Mar 2024 10:52:59 +0100
Message-ID: <20240319095315.27624-1-jirislaby@kernel.org>
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
Excerpt from the switching patch:
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

This is Request for Testing as I cannot test all the changes
(obviously). So please test your HW's serial properly.

And of course comments welcome.

I will send this as PATCHes later, when -rc1 is out, at earliest.

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


