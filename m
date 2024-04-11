Return-Path: <linux-kernel+bounces-140080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DE38A0B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C56283554
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6B213FD8C;
	Thu, 11 Apr 2024 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aDFr8eo4"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CA1846B;
	Thu, 11 Apr 2024 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824317; cv=none; b=PFXwY6rhypNjPFpPoQ/nZ6WD84QEEmPHU5+vMvKh7m25NyE21x/BNFi4TwtAcLvYpz/3a1tAajbxIPOXn2KE2QmyT0wo3n/HfgE3z3hRSbE+vNJ2yFlOtSDWwJyJJVukdU/MT0DpVVqckGyYLPTJzgmKIhqWqfGyRuwQk1iW8Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824317; c=relaxed/simple;
	bh=sDsx6/+mqmmjyVV0bm9WeLEM9nnWJMt059yWOadbhxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kyNQc5ssrrf2uyVLufDgAVsQQtT0jJg0XXdljm4i7iecr+DuJjvd/TJitucUlH7lDD9vTNisohvMe67DGcMHCbNLL/ee1XIoJ2mrs4z8OgXqXnTpfxN+BQbhbRmqC64e1zeVUsY75d8Dt/zRpexELxlTkvMkP2cQYJ6mjg0zDtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aDFr8eo4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712824313;
	bh=sDsx6/+mqmmjyVV0bm9WeLEM9nnWJMt059yWOadbhxI=;
	h=From:To:Cc:Subject:Date:From;
	b=aDFr8eo4rept7g6OxiKh4g7UPaT2YM8MR/WVTHAhtmlH3P5PTYJB5vMl/E2bakJih
	 4ANO3gzHzd/Ppi+JyTHOOBu7S5/JDeoYKXwqHOLB9P/1GVu+dqD7b8Zj5MIuh3D15h
	 y/+INT5L4JPEWXOnywRCf5VjxgqBv2Urqox9Q0bzsBA+l8RpWSuDDwgY0Ki+FNoZ60
	 F/Vu4TU2Gkrf7Nx8wgPNUkR6yhZnus9EAuLJ8zeXDdtJEU/ovHysOsZ3vjWMHytkpz
	 qiCCx8FC1vJZHOoKGaWhcgMdXNf1pPE/4DhpoKgVaOfAUeyO6fQIDrhnjihPARnic9
	 Md1a7MZ6wBDVQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8944437820A1;
	Thu, 11 Apr 2024 08:31:52 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-scsi@vger.kernel.org
Cc: alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	peter.wang@mediatek.com,
	chu.stanley@gmail.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	stanley.chu@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 0/8] MediaTek UFS fixes and cleanups - Part 1
Date: Thu, 11 Apr 2024 10:31:41 +0200
Message-ID: <20240411083149.78537-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series performs some fixes and cleanups for the MediaTek UFSHCI
controller driver.

In particular, while adding the MT8195 compatible to the mediatek,ufs
binding, I noticed that it was allowing just one clock, completely
ignoring the optional ones, including the crypt-xxx clocks, all of
the optional regulators, and other properties.

Between all the other properties, two are completely useless, as they
are there just to activate features that, on SoCs that don't support
these, won't anyway be activated because of missing clocks or missing
regulators, or missing other properties;
as for the other vendor-specific properties, like ufs-disable-ah8,
ufs-broken-vcc, ufs-pmc-via-fastauto, since the current merge window
is closing, I didn't do extensive research so I've left them in place
but didn't add them to the devicetree binding yet.

The plan is to check those later and eventually give them a removal
treatment, or add them to the bindings in a part two series.

For now, at least, this is already a big improvement.

P.S.: The only SoC having UFSHCI upstream is MT8183, which only has
just one clock, and *nothing else* uses properties, clocks, etc that
were renamed in this cleanup.

Cheers!

AngeloGioacchino Del Regno (8):
  scsi: ufs-mediatek: Remove useless mediatek,ufs-support-va09 property
  scsi: ufs: ufs-mediatek: Fix property name for crypt boost voltage
  scsi: ufs: ufs-mediatek: Remove useless mediatek,ufs-boost-crypt
    property
  scsi: ufs: ufs-mediatek: Avoid underscores in crypt clock names
  dt-bindings: ufs: mediatek,ufs: Document MT8192 compatible with MT8183
  dt-bindings: ufs: mediatek,ufs: Document MT8195 compatible
  dt-bindings: ufs: mediatek,ufs: Document additional clocks
  dt-bindings: ufs: mediatek,ufs: Document optional dvfsrc/va09
    regulators

 .../devicetree/bindings/ufs/mediatek,ufs.yaml | 28 +++++-
 drivers/ufs/host/ufs-mediatek.c               | 91 +++++++++++--------
 2 files changed, 79 insertions(+), 40 deletions(-)

-- 
2.44.0


