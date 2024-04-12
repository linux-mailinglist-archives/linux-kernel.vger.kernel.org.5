Return-Path: <linux-kernel+bounces-142448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCD68A2BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768ED284A00
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C8253393;
	Fri, 12 Apr 2024 10:01:06 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E503524DC;
	Fri, 12 Apr 2024 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916066; cv=none; b=NQuxILOyApt9pexVl4mJ2E/7beYULa945ahHCxjjxcDGv3Roe1cF/GZGL6GgMul+Vk/ffFpBrdKPSC+tLErr603tgiHC6HqEd8K4IwFN6Cqhs/wfrfyC3cKPnM8psyXHY1Baf1Rq9+UxihqCUfuhzdqxQTPd+VVIGN9bN005Ido=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916066; c=relaxed/simple;
	bh=FHWV3NbTZJVvgX19u1exvDjE/a+Vl9HY6tKBV4SMR/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tcfCRt90S9VVklgULnUOfRAVyqQMZTWuYF/v82b471Y+M+XElgRIs+FEI5mLSPrq3SOmxxRBCjIpeeDjmKpakf0IRuxX8olCThXiRyf25vF0TiSawT+VSRU7vuRV7HPaYSWAXs5PcTusC92j8WmQKcAJavnNEJkk2NLSSouyWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,195,1708354800"; 
   d="scan'208";a="201242322"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Apr 2024 19:01:01 +0900
Received: from renesas-deb12.cephei.uk (unknown [10.226.93.65])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BD76141E0D16;
	Fri, 12 Apr 2024 19:00:56 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	YueHaibing <yuehaibing@huawei.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net PATCH v2 0/4] ravb Ethernet driver bugfixes
Date: Fri, 12 Apr 2024 11:00:20 +0100
Message-Id: <20240412100024.2296-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches fix bugs found during recent work on the ravb driver.

Patches 1 & 2 affect the R-Car code paths so have been tested on an
R-Car M3N Salvator-XS board - this is the only R-Car board I currently
have access to.

Patches 2, 3 & 4 affect the GbEth code paths so have been tested on
RZ/G2L and RZ/G2UL SMARC EVK boards.

Changes from v1:
  * Fixed typos in commit message of patch
    "net: ravb: Allow RX loop to move past DMA mapping errors".
  * Added Sergey's Reviewed-by tags.
  * Expanded Cc list as Patchwork complained that I had missed people.
  * Trimmed the call trace in accordance with the docs [1] in patch
    "net: ravb: Fix GbEth jumbo packet RX checksum handling".

[1]: https://docs.kernel.org/process/submitting-patches.html#backtraces-in-commit-messages

Paul Barker (4):
  net: ravb: Count packets instead of descriptors in R-Car RX path
  net: ravb: Allow RX loop to move past DMA mapping errors
  net: ravb: Fix GbEth jumbo packet RX checksum handling
  net: ravb: Fix RX byte accounting for jumbo packets

 drivers/net/ethernet/renesas/ravb_main.c | 67 +++++++++++-------------
 1 file changed, 32 insertions(+), 35 deletions(-)


base-commit: 2ae9a8972ce04046957f8af214509cebfd3bfb9c
-- 
2.39.2


