Return-Path: <linux-kernel+bounces-46862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202EA8445DA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C97CB31222
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13D812C55D;
	Wed, 31 Jan 2024 17:05:55 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B9A84A3C;
	Wed, 31 Jan 2024 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720755; cv=none; b=rG0FQWF+04idBdJMuR9QKLmraUO+JZ20HI+pXPqhZ0r7VTr7Ag/4XxRWVvXnUxKFF2QmQCXMbp/XrJJIr4EFGoxI9JenxTd+5I45Iix7RZrYAGvgYN/0+7mhMh1P6iWg6Ay8uIprI6TcsqdYHbAcbQmZlEbtxfxmhHykox9RJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720755; c=relaxed/simple;
	bh=uJl5pmP7pzP0qSuDUSpGf4Bz6mdCugoDwzVWMXmOkvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UaIPMkjVpWRV/RdqmNJvwPAfXVLOEKfeyebFacTGFIlTVK1TO1qiLcW3B2eSnnblpR6Kemdkv/N5NWwvQ6zfgF/Ul0QC7TObEVq2Aj1qxmJDr3fjDcP9VCXICfdzh83L+8BBkJi5z4EMqgpm9Cm8PWk58tfFKK4900dbZcRjX4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.05,231,1701097200"; 
   d="scan'208";a="196315512"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Feb 2024 02:05:46 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.158])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BE78A40344F5;
	Thu,  1 Feb 2024 02:05:42 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/8] Improve GbEth performance on Renesas RZ/G2L and related SoCs
Date: Wed, 31 Jan 2024 17:05:14 +0000
Message-Id: <20240131170523.30048-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series aims to improve peformance of the GbEth IP in the Renesas
RZ/G2L SoC family and the RZ/G3S SoC, which use the ravb driver. Along
the way, we do some refactoring and ensure that napi_complete_done() is
used in accordance with the NAPI documentation.

Performance improvment mainly comes from enabling SW IRQ Coalescing for
all SoCs using the GbEth IP, and NAPI Threaded mode for single core SoCs
using the GbEth IP. These can be enabled/disabled at runtime via sysfs,
but our goal is to set sensible defaults which get good performance on
the affected SoCs.

Changes are made specific to the GbEth IP, avoiding potential impact on
the other Renesas R-Car based SoCs which also use the ravb driver. This
follows the principle of only submitting patches that we can fully test.

The performance impact of this series on iperf3 testing is as follows:
  * RZ/G2L Ethernet throughput is unchanged, but CPU usage drops:
      * Bidirectional and TCP RX: 6.5% less CPU usage
      * UDP RX: 10% less CPU usage

  * RZ/G2UL and RZ/G3S Ethernet throughput is increased for all test
    cases except UDP TX, which suffers a slight loss:
      * TCP TX: 32% more throughput
      * TCP RX: 11% more throughput
      * UDP TX: 10% less throughput
      * UDP RX: 10183% more throughput - the previous throughput of
        1.06Mbps is what prompted this work.

  * RZ/G2N CPU usage and Ethernet throughput is unchanged (tested as a
    representative of the SoCs which use the R-Car based RAVB IP).

This series depends on:
  * "net: ravb: Let IP-specific receive function to interrogate descriptors" v5
    https://lore.kernel.org/all/20240131084133.1671440-2-claudiu.beznea.uj@bp.renesas.com/

To get the results shown above, you'll also need:
  * "topology: Set capacity_freq_ref in all cases"
    https://lore.kernel.org/all/20240117190545.596057-1-vincent.guittot@linaro.org/

  * "ravb: Add Rx checksum offload support" v2
    https://lore.kernel.org/all/20240124102115.132154-2-biju.das.jz@bp.renesas.com/

  * "ravb: Add Tx checksum offload support" v2
    https://lore.kernel.org/all/20240124102115.132154-3-biju.das.jz@bp.renesas.com/

Work in this area will continue, in particular we expect to improve
TCP/UDP RX performance further with future changes to RX buffer
handling.

Paul Barker (8):
  net: ravb: Split R-Car & GbEth poll functions
  net: ravb: Simplify GbEth poll & receive functions
  net: ravb: Count packets in GbEth RX (not descriptors)
  net: ravb: Always process TX descriptor ring in GbEth poll
  net: ravb: Always update error counters
  net: ravb: Align GbEth poll function with NAPI docs
  net: ravb: Enable SW IRQ Coalescing for GbEth
  net: ravb: Use NAPI threaded mode on 1-core CPUs with GbEth IP

 drivers/net/ethernet/renesas/ravb.h      |   3 +-
 drivers/net/ethernet/renesas/ravb_main.c | 103 ++++++++++++++++-------
 2 files changed, 74 insertions(+), 32 deletions(-)

-- 
2.39.2


