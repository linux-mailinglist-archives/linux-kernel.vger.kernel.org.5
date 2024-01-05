Return-Path: <linux-kernel+bounces-17534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C892C824EF5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D46D1F2371E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DB51D68C;
	Fri,  5 Jan 2024 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ddd73IgM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0CE1D68F;
	Fri,  5 Jan 2024 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704438585; x=1735974585;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yKUXbdD8qpgSi58w2LiSPZgWQ2PW44f2VTnKYrF/+3I=;
  b=Ddd73IgMI3QeBzBz/e/BqUCpbAN7ioFEhcqpdKfKR7us7rW9i3l2DqXg
   +KiVdzUg7jX48a3Koz8dXu1Vzl7c+KTg9dILQpaFyuRD3nyLiCOdCfNjP
   CZHHNLyEiNx1WVZzMjSaZPx3xE5XhUKEK1uCCApuGg9cCg7uHeU1Nv6A3
   wGen5nKP2t72Ic982XMgOHBq/n0AXcROsxT2LH0IhLG7Y4ktiMda0CPwR
   6FCVcRm9oFyZQsans+nYkHEV0xxoCNGtMFeX4f9dgZD1nzrZzf69/+wYz
   FH1r2+Qe32t09B4Jb8r3nnBqbyFjdO3DsfRDppDTR3MqIQ7GhRlmnJhYh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="463845803"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="463845803"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 23:09:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="871167246"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="871167246"
Received: from pg-esw-build.png.intel.com ([10.226.214.65])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jan 2024 23:09:39 -0800
From: Leong Ching Swee <leong.ching.swee@intel.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Swee Leong Ching <leong.ching.swee@intel.com>
Subject: [PATCH net-next v2 0/4] net: stmmac: Enable Per DMA Channel interrupt
Date: Fri,  5 Jan 2024 15:09:21 +0800
Message-Id: <20240105070925.2948871-1-leong.ching.swee@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Swee Leong Ching <leong.ching.swee@intel.com>

Hi,
Add Per DMA Channel interrupt feature for DWXGMAC IP.
 
Patchset (link below) contains per DMA channel interrupt, But it was 
achieved.
https://lore.kernel.org/lkml/20230821203328.GA2197059-
robh@kernel.org/t/#m849b529a642e1bff89c05a07efc25d6a94c8bfb4
 
Some of the changes in this patchset are based on reviewer comment on 
patchset mentioned beforehand.

changelog v2:
*extend irq_name array to 9
*add empty line after int i
*avoid polluting rx_irq/tx_irq array with temporary variable
*move tx/rx IRQ loop to bottom of stmmac_get_platform_resource()
*rename stmmac_xx_queue_interrupt() to stmmac_dma_xx_interrupt()
*fix error message in stmmac_request_irq_multi()
*move STMMAC_FLAG_MULTI_IRQ_EN handling to glue driver 

Swee Leong Ching (4):
  dt-bindings: net: snps,dwmac: per channel irq
  net: stmmac: Make MSI interrupt routine generic
  net: stmmac: Add support for TX/RX channel interrupt
  net: stmmac: Use interrupt mode INTM=1 for per channel irq

 .../devicetree/bindings/net/snps,dwmac.yaml   | 24 ++++++++++----
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 +--
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  3 ++
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  3 ++
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 32 +++++++++++--------
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 30 ++++++++---------
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 28 ++++++++++++++++
 include/linux/stmmac.h                        |  4 +--
 9 files changed, 90 insertions(+), 40 deletions(-)

-- 
2.34.1


