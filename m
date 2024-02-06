Return-Path: <linux-kernel+bounces-54569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 140FA84B0DE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97FF1F237AE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4095512D15B;
	Tue,  6 Feb 2024 09:19:28 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAAA74E2A;
	Tue,  6 Feb 2024 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211167; cv=none; b=NsG0ilppC9hqT1YosSizZ5fOybGBaFljdj7EJUOOxof2xyLkZ73kEIj+h44KIvXK/W+hvgYZA8UseeeOQr+JAkVGfv6HzxGzKResvYheqtjIWye+NYnv/h9li0Q1tY/XBDTFU1hNabBKdLg5SiTqxJuE1SDxg+Q5M9FZBF9IYnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211167; c=relaxed/simple;
	bh=uFOZ1ypR768ApbRlA9QHiVMff+/kXLj8ZxVHMRuRlbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oNOAUuUKQk1DaXRIzaLygQmHJn/l4CCabuRvSocje2z3a06cnzOJh8zYw78DAS2Woirjpof+vkUbLEOmga2UCQkDp/qQq0xsuwPgY2r7DnqwhtS843jpPV//GoilJuYfHHMEVV5jkPCeT3enIOeo+2Xa/MkQg+S1K+YG0NCI79A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.05,246,1701097200"; 
   d="scan'208";a="193022662"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Feb 2024 18:19:17 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.63])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4505041B8EF7;
	Tue,  6 Feb 2024 18:19:14 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next v2 0/7] Improve GbEth performance on Renesas RZ/G2L and related SoCs
Date: Tue,  6 Feb 2024 09:19:02 +0000
Message-Id: <20240206091909.3191-1-paul.barker.ct@bp.renesas.com>
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
used in accordance with the NAPI documentation for both GbEth and R-Car
code paths.

Performance improvment mainly comes from enabling SW IRQ Coalescing for
all SoCs using the GbEth IP, and NAPI Threaded mode for single core SoCs
using the GbEth IP. These can be enabled/disabled at runtime via sysfs,
but our goal is to set sensible defaults which get good performance on
the affected SoCs.

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
  * "net: ravb: Let IP-specific receive function to interrogate descriptors" v6
    https://lore.kernel.org/all/20240202084136.3426492-2-claudiu.beznea.uj@bp.renesas.com/

To get the results shown above, you'll also need:
  * "topology: Set capacity_freq_ref in all cases"
    https://lore.kernel.org/all/20240117190545.596057-1-vincent.guittot@linaro.org/

  * "ravb: Add Rx checksum offload support" v4
    https://lore.kernel.org/all/20240203142559.130466-2-biju.das.jz@bp.renesas.com/

  * "ravb: Add Tx checksum offload support" v4
    https://lore.kernel.org/all/20240203142559.130466-3-biju.das.jz@bp.renesas.com/

Work in this area will continue, in particular we expect to improve
TCP/UDP RX performance further with future changes to RX buffer
handling.

Changes v1->v2:
  * Marked as RFC as the series depends on unmerged patches.
  * Refactored R-Car code paths as well as GbEth code paths.
  * Updated references to the patches this series depends on.

Paul Barker (7):
  net: ravb: Simplify poll & receive functions
  net: ravb: Count packets instead of descriptors in RX path
  net: ravb: Always process TX descriptor ring
  net: ravb: Always update error counters
  net: ravb: Align poll function with NAPI docs
  net: ravb: Enable SW IRQ Coalescing for GbEth
  net: ravb: Use NAPI threaded mode on 1-core CPUs with GbEth IP

 drivers/net/ethernet/renesas/ravb.h      |  3 +-
 drivers/net/ethernet/renesas/ravb_main.c | 92 ++++++++++++------------
 2 files changed, 46 insertions(+), 49 deletions(-)

-- 
2.39.2

