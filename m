Return-Path: <linux-kernel+bounces-9373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EE681C4BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E14D1C24CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BE063A7;
	Fri, 22 Dec 2023 05:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOif9ryk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C54B46A8;
	Fri, 22 Dec 2023 05:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703223945; x=1734759945;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CjRK6L+3YHfQxLdgqWH6wzL66WcY3RprmAfaaHBD6ss=;
  b=MOif9rykfTPTPmFSirrH7KqOH4T+y952TsfZVmguJt6TAzAvQinYM8UM
   c9OOK99gj/vPWDTaJJdDMXU9CXv3p7lJZdDhx90vhVmbIUZPrMzrSwE8X
   GGyEz8NGlXTkemqpytzP/P4P5LFoQoOumZJaudlgY6f5N4E77nAb7EcAT
   Mc0oe3gUmqupncAp9HMQqoWdmZAGBNYZ7Ma86P3r0Nc+UjrpTawsYXvZk
   Z8pqeZkZqtYlLw1zYkgGrQyj8KY3RD5zn7k4UZ3Zbi4P4wc/N2lIHqTKc
   QMhXtxZoWmFvm5d6NLxPzjEF8qydjyAZBWnsGM3NpybeHBMAKwipWspl+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="9470499"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="9470499"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 21:45:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="900324167"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="900324167"
Received: from pg-esw-build.png.intel.com ([10.226.214.57])
  by orsmga004.jf.intel.com with ESMTP; 21 Dec 2023 21:45:39 -0800
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
Subject: [PATCH net-next v1 0/4] net: stmmac: Enable Per DMA Channel interrupt
Date: Fri, 22 Dec 2023 13:44:47 +0800
Message-Id: <20231222054451.2683242-1-leong.ching.swee@intel.com>
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

Swee Leong Ching (4):
  dt-bindings: net: snps,dwmac: per channel irq
  net: stmmac: Make MSI interrupt routine generic
  net: stmmac: Add support for TX/RX channel interrupt
  net: stmmac: Use interrupt mode INTM=1 for per channel irq

 .../devicetree/bindings/net/snps,dwmac.yaml   | 24 ++++++++++----
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 +--
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  3 ++
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 32 +++++++++++--------
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 29 +++++++++--------
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 24 ++++++++++++++
 include/linux/stmmac.h                        |  4 +--
 8 files changed, 84 insertions(+), 38 deletions(-)

-- 
2.34.1


