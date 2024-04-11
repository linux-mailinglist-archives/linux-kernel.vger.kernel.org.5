Return-Path: <linux-kernel+bounces-140357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 798988A134B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8061F233C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58CF14A099;
	Thu, 11 Apr 2024 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k7ulCCAu"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74229149C75;
	Thu, 11 Apr 2024 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835789; cv=none; b=GbOKfo657VU/69DoB6P3ybqXtyRwhhKXDK5doacfjUXD9qZdMi58v4pIUvG5v5t+sgTdThIVWi46Qv7nGwh9C81DDKjwW+Zyulgn3I/EF7gNS5JBqFkKTd8TbXjv6NKizWpOi6ZSjHDzRaqnah0kZ8B80/JS3D8YgA8t+JM2b6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835789; c=relaxed/simple;
	bh=hZOqM1m3fh6Pq5Sr9fpO6+gQjVeXP2CN8smO/JG0VAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RDrwt3HkU+udLpt9BvIvFJZF7LmSZrnWhbyFliiAI7lKP/S7WMpMTvbe4hVJR67/Peg19eEuvzFlmRgE5Xtvip1oUVDs7O6WutosVoWw8UmOyTcCwYmhJvVR3OOiqZX718dG1zq4WwxU6+nS98aQungzdtZLqaSEhAfhLat5hsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k7ulCCAu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712835785;
	bh=hZOqM1m3fh6Pq5Sr9fpO6+gQjVeXP2CN8smO/JG0VAs=;
	h=From:To:Cc:Subject:Date:From;
	b=k7ulCCAuOzpzMtCSSwJbToT4VvETX+O+bmx76FwmVxTB56ycdPpWvbmYTO2D8Rw27
	 278feKMJpxmNQX/zYDmA6NUF5apyPXCV4+mqb1PBul4EVNRZlIoO4Y87+yajpz7wSU
	 raO/0wToFReAHXlskJ563wsQlst8BG0MVGCsM3FxMyaeFTga0LiD6BcUoK414GoCtq
	 vpKeoAmEvvwQc+zfs0CQBVHQEwM10C/EEmf0IWmcSX8piRJA41m2gDjjoyCiDSlZdR
	 /6Z47bX6wUecgnr9nxL3DT6aewxd9BwFEJbttrNb8SBCyaKdgDuTduRF8CvQdqdd1a
	 goSDMWIlBbSjQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EF20D378208C;
	Thu, 11 Apr 2024 11:43:03 +0000 (UTC)
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
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/8] MediaTek UFS fixes and cleanups - Part 1
Date: Thu, 11 Apr 2024 13:42:52 +0200
Message-ID: <20240411114300.169055-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
  scsi: ufs: ufs-mediatek: Remove useless mediatek,ufs-support-va09 property
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
 2 files changed, 80 insertions(+), 40 deletions(-)

-- 
2.44.0


