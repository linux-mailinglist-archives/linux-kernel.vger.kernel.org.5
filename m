Return-Path: <linux-kernel+bounces-144855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAEA8A4BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B758282C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A7244C61;
	Mon, 15 Apr 2024 09:48:21 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9237D3FB2F;
	Mon, 15 Apr 2024 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174501; cv=none; b=AgaznI5231ncORR1pBrSfQKD+2vqnHJIGku3MyrpVoRJvz2r8sZavVGSEoMOt+rtNMFxVR1rYWXhruH3aSh3x5R3IL2GgCr0rF67xCrqEg3XGfN8cvGEELP96aM5dqRaOmUfuU/DRi3ET4M/fXD+PBmFJTd2OufhlaTRnB4Zx7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174501; c=relaxed/simple;
	bh=/3tgachGlba0xQYbgA3XnWnpLu/EQzU489/T8ZTP2eg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=di6uqa6+Lway6k5Fj/NPpIQRrH5nKMMZfFQIJVdpkW9xpsKEHBazZvROpQRxgR0s9At/O9ivwfVXlg3HTl44nCzf5iRqimeDy6YJBGpvqqBWR33Kdn9KrArWpnG9jG0KPUlmvD4VZOeOsbP+mmDXp9lZwZDaN/L75x4jt1PyrlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,202,1708354800"; 
   d="scan'208";a="201479136"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Apr 2024 18:48:17 +0900
Received: from renesas-deb12.cephei.uk (unknown [10.226.93.74])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 81BA64006DE8;
	Mon, 15 Apr 2024 18:48:13 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC v3 0/7] Improve GbEth performance on Renesas RZ/G2L and related SoCs
Date: Mon, 15 Apr 2024 10:47:57 +0100
Message-Id: <20240415094804.8016-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series aims to improve performance of the GbEth IP in the Renesas
RZ/G2L SoC family and the RZ/G3S SoC, which use the ravb driver. Along
the way, we do some refactoring and ensure that napi_complete_done() is
used in accordance with the NAPI documentation for both GbEth and R-Car
code paths.

Much of the performance improvement comes from enabling SW IRQ
Coalescing for all SoCs using the GbEth IP, and NAPI Threaded mode for
single core SoCs using the GbEth IP. These can be enabled/disabled at
runtime via sysfs, but our goal is to set sensible defaults which get
good performance on the affected SoCs.

The rest of the performance improvement comes from using a page pool to
allocate RX buffers, and reducing the allocation size from >8kB to 2kB.

The overall performance impact of this patch series seen in testing with
iperf3 is as follows (see patches 5-7 for more detailed results):
  * RZ/G2L:
    * TCP TX: +1.8% bandwidth
    * TCP RX: +1% bandwidth at 47% less CPU load
    * UDP RX: +1% bandwidth at 26% less CPU load

  * RZ/G2UL:
    * TCP TX: +37% bandwidth
    * TCP RX: +43% bandwidth
    * UDP TX: -8% bandwidth
    * UDP RX: +32500% bandwidth (!)

  * RZ/G3S:
    * TCP TX: +25% bandwidth
    * TCP RX: +76% bandwidth
    * UDP TX: -9% bandwidth
    * UDP RX: +37900% bandwidth (!)

  * RZ/Five:
    * TCP TX: +18% bandwidth
    * TCP RX: +212% bandwidth
    * UDP TX: +2% bandwidth
    * UDP RX: +inf bandwidth (test no longer crashes)

There is no significant impact on bandwidth or CPU load in testing on
RZ/G2H or R-Car M3N.

Fixing the crash in UDP RX testing for RZ/Five is a cumulative effect of
patches 1, 2, 5 & 6 so this is very difficult to break out as a bugfix
for backporting.

This series depends on my recent ravb bugfix patches [1] which are not
yet merged.

[1]: https://lore.kernel.org/all/20240412100024.2296-1-paul.barker.ct@bp.renesas.com/

Changes v2->v3:
  * Incorporated feedback on RFC v2 from Sergey.
  * Split out bugfixes and rebased. This changed the order of what was
    the first 5 patches of v2 and things look a little different so I've
    not picked up Reviewed-by tags from v2.
  * Further refactoring and tidy up of RX ring refill and
    ravb_rx_gbeth().
  * Switched to using a page pool to allocate RX buffers.
  * Re-tested and provided updated performance figures.

Changes v1->v2:
  * Marked as RFC as the series depends on unmerged patches.
  * Refactored R-Car code paths as well as GbEth code paths.
  * Updated references to the patches this series depends on.

Paul Barker (7):
  net: ravb: Simplify poll & receive functions
  net: ravb: Align poll function with NAPI docs
  net: ravb: Refactor RX ring refill
  net: ravb: Refactor GbEth RX code path
  net: ravb: Enable SW IRQ Coalescing for GbEth
  net: ravb: Use NAPI threaded mode on 1-core CPUs with GbEth IP
  net: ravb: Allocate RX buffers via page pool

 drivers/net/ethernet/renesas/ravb.h      |  13 +-
 drivers/net/ethernet/renesas/ravb_main.c | 430 +++++++++++------------
 2 files changed, 221 insertions(+), 222 deletions(-)

-- 
2.39.2


