Return-Path: <linux-kernel+bounces-146739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB7C8A6A21
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A1728368C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DD612A15A;
	Tue, 16 Apr 2024 12:03:38 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906CB128363;
	Tue, 16 Apr 2024 12:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269018; cv=none; b=hxJ6qRjMvC7aBZmwkfgCtVZ1+YxQFCJRAnf0pekMWGbvievE24kb1vyNEJDarg296WxR9SSxjINNnuFirULmekLTDCHtl0Xe0hqyb8HDGujlzBMiGJP8IpQurqHwlCpgyQtE3KtvDBIm+NWO9Hsyb5xvP+oS0rD8Xf4rdIEd7DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269018; c=relaxed/simple;
	bh=HQoXKeBHkArTd9CmE/O7gZO7g4WAFGBHSEIJzFgu9yw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jtlc1t6S7GSGbneYteD5tP4JGfcdvKN1xNvLqcp3L0e6boUEi5oLnLB2J29CpTzqMXiy2GSc3RBOEgi2RpL4hKAZ65+W1IOL7TaVwDNI8EirOkjt/F/3lLjMMO78cTA3XN27p9bGQh5AoH9vkbbLqJevpRG8M9yiWHsCTYdeGz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,205,1708354800"; 
   d="scan'208";a="201616914"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Apr 2024 21:03:28 +0900
Received: from renesas-deb12.cephei.uk (unknown [10.226.93.86])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 78BAC400C44B;
	Tue, 16 Apr 2024 21:03:23 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	YueHaibing <yuehaibing@huawei.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net PATCH v3 0/4] ravb Ethernet driver bugfixes
Date: Tue, 16 Apr 2024 13:02:50 +0100
Message-Id: <20240416120254.2620-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These patches fix bugs found during recent work on the ravb driver.

Patches 1 & 2 affect the R-Car code paths so have been tested on an
R-Car M3N Salvator-XS board - this is the only R-Car board I currently
have access to.

Patches 2, 3 & 4 affect the GbEth code paths so have been tested on
RZ/G2L and RZ/G2UL SMARC EVK boards.

Changes v2->v3:
  * Incorporate feedback from Niklas and add Reviewed-by tag to patch
    "net: ravb: Count packets instead of descriptors in R-Car RX path".
Changes v1->v2:
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

 drivers/net/ethernet/renesas/ravb_main.c | 68 +++++++++++-------------
 1 file changed, 32 insertions(+), 36 deletions(-)


base-commit: 75ce9506ee3dc66648a7d74ab3b0acfa364d6d43
-- 
2.39.2


