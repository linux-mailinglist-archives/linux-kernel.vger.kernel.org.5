Return-Path: <linux-kernel+bounces-140368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 904458A136D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C191F21804
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC6A14AD29;
	Thu, 11 Apr 2024 11:45:05 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAF3147C9D;
	Thu, 11 Apr 2024 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835905; cv=none; b=Uhgc6YbgwLBlPu2JPp9mJHrsa5gyBDdt98OYUTgQo4x3k6BQ6PwCo2VuFEWTQLCBuIfKQ1TtSkrC0zzqSz7gDq+NkSe3BZHzKmfqtm2iR5DA6gingfjYtCWKv3T59m451WhGkXFNySR60pbRBce3vBU6hLlYjINhPo0iZGFNk5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835905; c=relaxed/simple;
	bh=a4ZnXu/Wt8dzHVuHzWH69gzym3Z1KzBuNghoKN4HseM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=reub9fCPqiBrS96MKl2oPmmPdw5R72qRKhg5KJuj9lgnfVQWANgM9yiuUHSpc/zH3uLZyz/qUGEVa6O2IjsoT8wV8esTW+oaKyvmAG7YOCRAm5FeScNl4rmyeVoXGpTJsnDH1onVm0fWZ9nJyy3iVKcLvKadTn1qwPPbLN54oFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,193,1708354800"; 
   d="scan'208";a="201123371"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 11 Apr 2024 20:44:55 +0900
Received: from renesas-deb12.cephei.uk (unknown [10.226.93.85])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7E54942017D7;
	Thu, 11 Apr 2024 20:44:51 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/4] ravb Ethernet driver bugfixes
Date: Thu, 11 Apr 2024 12:44:29 +0100
Message-Id: <20240411114434.26186-1-paul.barker.ct@bp.renesas.com>
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

Paul Barker (4):
  net: ravb: Count packets instead of descriptors in R-Car RX path
  net: ravb: Allow RX loop to move past DMA mapping errors
  net: ravb: Fix GbEth jumbo packet RX checksum handling
  net: ravb: Fix RX byte accounting for jumbo packets

 drivers/net/ethernet/renesas/ravb_main.c | 67 +++++++++++-------------
 1 file changed, 32 insertions(+), 35 deletions(-)


base-commit: 47d8ac011fe1c9251070e1bd64cb10b48193ec51
-- 
2.39.2


