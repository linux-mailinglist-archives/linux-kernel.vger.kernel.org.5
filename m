Return-Path: <linux-kernel+bounces-109809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FD98855F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBB2285BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622A5200D9;
	Thu, 21 Mar 2024 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0v4EnGUW"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DC11D526;
	Thu, 21 Mar 2024 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711010794; cv=none; b=hiw+E82MrnoaYeXjzQVkNDsAPbzc2kts69vXwqx+cJLVw+DodoOoU4qD+ayOFHgHrHLwUZka5DZ00z5N/MbYJJAmG2hP5zdMO2O9tCU7y6iSGtawz8QoLyyVqYi+nBfbAodjSyBKHVspxsHhvEUIvV6NdI7bWgJ0qEVXMZXdIp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711010794; c=relaxed/simple;
	bh=uni785XgmjmNkc/C23w1CJqH5avsHkxBrwb1KdEt5Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNdNNl4+P9KJH6VOEJZTpXBWhAjbN6YZ3kUJdqG+U10w7tvi829aRLZHNYEr7+F+NRWvHHH5L6gI8luCzHxFJuH6+EqAa7xURzcaqfqAhQSeOiQa+oTOLSGs1XCGy9l2Gu5wAPZhqXfp+MeMYREggKKY5n9ET2t2YrmF90zbbA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0v4EnGUW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711010791;
	bh=uni785XgmjmNkc/C23w1CJqH5avsHkxBrwb1KdEt5Ug=;
	h=From:To:Cc:Subject:Date:From;
	b=0v4EnGUW/G+xUFSL0VQe7KjxUcQxDvhnhP2i1M53K5NMejlWaqYDaj0KD9UUGxVGT
	 ziwUND22GEr/gDVsiWUdSav1ftJcpM4XPcR10afH1XoZ96rk8O7UgDFVnSbN2sKiBv
	 j1k/3tCWk8iRSxZc8ndGZon8VY4fxhlaw63kpqC5RLYrplPQ/7fdSdb5XdJ1uYCH9O
	 MyazSPQ4kiZoKl/oWabiVkskyPBPmTx/uwpEZPnCaQ1B2XwYJn5GkJGsXWhW1Udto1
	 Vm8H8RJyHFyLs3qSYcZXc8w8oHOE4atiu/r7hkI6Pzw4AHbI1UzNCG87NbjO1G5h1R
	 +h0pQClHi7LqA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 97B4E3780BFE;
	Thu, 21 Mar 2024 08:46:30 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: mathieu.poirier@linaro.org
Cc: andersson@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	tzungbi@kernel.org,
	tinghan.shen@mediatek.com,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	wenst@chromium.org,
	kernel@collabora.com
Subject: [PATCH 0/2] MediaTek SCP: Urgent fixes for all MTK SoCs
Date: Thu, 21 Mar 2024 09:46:12 +0100
Message-ID: <20240321084614.45253-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series brings some missing validation for the IPI buffer size
that is read from the firmware retrieved from userspace: if the FW
declares IPI buffer offset starting at an out of range address, the
driver doesn't do any validation and naively goes on with IO R/W
operation.

That poses various risks which I believe I really don't need to
describe, leaving it to the reader's imagination :-)

Please note that the first fix is URGENT.

P.S.: Of course, this was tested OK on multiple MTK platforms.

AngeloGioacchino Del Regno (2):
  remoteproc: mediatek: Make sure IPI buffer fits in L2TCM
  remoteproc: mediatek: Don't parse extraneous subnodes for multi-core

 drivers/remoteproc/mtk_scp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.44.0


