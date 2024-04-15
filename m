Return-Path: <linux-kernel+bounces-144953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B00B8A4D14
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA291C21D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00D85D47E;
	Mon, 15 Apr 2024 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GUXCDZ5C"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62DA4EB42;
	Mon, 15 Apr 2024 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178819; cv=none; b=HipbUGFyE6UfKBsm1BlmFQKLxGM8ZtuIXij9/hRk2YojuZB4RAtdu9xvx3iU/TdBFaxxWHoaWCHP7JtEv4RedGaxQf6xUrxidrsx/V0NIsALapKhVvpaWJnFCsLCCs75HXicjowORmSpg0KH7RNwXkfsBlijJIsJsnjhIUwVtk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178819; c=relaxed/simple;
	bh=q/mYk8lU6ClHh16h8UHvuyzapBbcS2gBCHZS8xDauBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E4u2s3OR9mraPmPqJM2xLSEoxKR0CkzXfmVHoWGrnNNavP87QY2QvrAb6EWqCM2mSyDKvh7M6WcgCjMvik6K0AbLF576D3k2JcGw2IUZgXufpu+tQ+Y8VxS1Cxn8OXs0NvMJCL6USBXvCoYMSpSYDjUPweN+LjLPbiKDEnHicQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GUXCDZ5C; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713178815;
	bh=q/mYk8lU6ClHh16h8UHvuyzapBbcS2gBCHZS8xDauBE=;
	h=From:To:Cc:Subject:Date:From;
	b=GUXCDZ5C3gFucvZ41xUJK2ewkecca9YSoSxXcYkhAqc5l5S0jgIJ5kVJbK3JvWgRM
	 OquhVFJiTGIqCYUrmK1W4ITvcUN9bp9I5IgHG3+kh0AL01Lg5xlMfWiIHX1LuOMFwT
	 jmUOm2t3Ce3JzKgqcgnWTV+wu8NB/MUOgGB9niCzmphM4FQNcx7aWENz2PkC6AiY4G
	 4anPK3ezp9lFpz3W9uIyRwAnM78MnhdGukwsxnul/j8rT1eINpHl5gfnM6A79AkWm0
	 CWGsVmDV+W3uAWWdeAiP2Xb3tCYKjzCD/HHJQO72DaEzj4aB4GmEaZ/6MSdM1U3cWz
	 23mZMq9fNDRtA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 97B243780022;
	Mon, 15 Apr 2024 11:00:14 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-scsi@vger.kernel.org
Cc: alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	peter.wang@mediatek.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/8] MediaTek UFS fixes and cleanups - Part 1
Date: Mon, 15 Apr 2024 13:00:04 +0200
Message-ID: <20240415110012.148871-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v4:
 - Replaced Stanley Chu with myself in maintainers as his email is gone
 - Fixed commit [5/8]

Changes in v3:
 - Disallowed mt8192 compatible in isolation
 - Added maxItems to clocks

Changes in v2:
 - Rebased over next-20240409 (because of merge issue for patch 1)
 - Added ufs: prefix to patch 1
 - Added forgotten ufs-rx-symbol clock to the binding


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
  scsi: ufs: ufs-mediatek: Remove useless mediatek,ufs-support-va09
    property
  scsi: ufs: ufs-mediatek: Fix property name for crypt boost voltage
  scsi: ufs: ufs-mediatek: Remove useless mediatek,ufs-boost-crypt
    property
  scsi: ufs: ufs-mediatek: Avoid underscores in crypt clock names
  dt-bindings: ufs: mediatek,ufs: Document MT8192 compatible with MT8183
  dt-bindings: ufs: mediatek,ufs: Document MT8195 compatible
  dt-bindings: ufs: mediatek,ufs: Document additional clocks
  dt-bindings: ufs: mediatek,ufs: Document optional dvfsrc/va09
    regulators

 .../devicetree/bindings/ufs/mediatek,ufs.yaml | 29 +++++-
 drivers/ufs/host/ufs-mediatek.c               | 91 +++++++++++--------
 2 files changed, 79 insertions(+), 41 deletions(-)

-- 
2.44.0


