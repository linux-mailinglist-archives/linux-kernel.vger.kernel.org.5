Return-Path: <linux-kernel+bounces-148212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9E18A7F61
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54DC1C20B12
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14BC130484;
	Wed, 17 Apr 2024 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Pv5vHMeE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C9357898;
	Wed, 17 Apr 2024 09:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345290; cv=none; b=iivsm/xf7vh8O7ChxAKhV+5olD3BOf5K+PGtSWZLDQ02zDUVucVkJkYk+Iega9G6BeC9PtFNQmNg9vLAhFk8KP0pRYkGT00gNQkH5r9vwg2sRCvQLzN9F9CoSuk8ygP49cqbBfprTSgowytXx0PbDDC6UIjeTFK3fHjzljVh+qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345290; c=relaxed/simple;
	bh=eqBJott6hPgctc1oZBVbJh/Mq8Jhu8Pex58Mgk17ASY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KBhBgDvd3zUTtOxwoZU7yQ7K1SOjQEOVpYNVXxvMMhxnZvnnhxb8OSJF3/ksX6lPK9QIKYMI/L6awAzEPI3Fn/qo6W1v4gC1B68a2cacKyBL8Ishn/V1PEt/CKoOKpyBrD/5S20GibH6gBWbmUxaDSXuNpsnIHUUawGPk2ZCzf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Pv5vHMeE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713345286;
	bh=eqBJott6hPgctc1oZBVbJh/Mq8Jhu8Pex58Mgk17ASY=;
	h=From:To:Cc:Subject:Date:From;
	b=Pv5vHMeEtF9qv4COQBqeTEHG7nzSOEmsFrN8yhdEkSNClUZeVTvJCrfEBxLR4mgDx
	 7popDit7WVv5CadsNqBX9QTvfn6KrHY2sToFp3IIZhV7V2jNTpOip1s6kooUcXGvNa
	 wubLvSr4oZ8RPdWjOuoyfSdSDqRKu3Lu3GS5405ScSEniqTq+MSlOCw8LCrmmz6axR
	 gl7P5UixbVUKyPa9hBGPosNvy9zDCa6DqQl2kyNOIv8gl+JdaA+okq5dQkGfNbHgBd
	 l8C1ZoeMfoqJIfwDdBqaUmGPsrasplkp2lcWPKPCqP8sLs8n7buleQSCfG0RhkiUPQ
	 hCXupJnl9DwJw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0E94037813C4;
	Wed, 17 Apr 2024 09:14:45 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: djakov@kernel.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	keescook@chromium.org,
	gustavoars@kernel.org,
	henryc.chen@mediatek.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	wenst@chromium.org,
	amergnat@baylibre.com
Subject: [PATCH v2 0/7] MediaTek DVFSRC Bus Bandwidth and Regulator knobs
Date: Wed, 17 Apr 2024 11:14:35 +0200
Message-ID: <20240417091442.170505-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
 - Fixed issues with regulator binding about useless quotes and
   wrong binding path (oops)
 - Removed useless 'items' from DVFSRC main binding
 - Allowed address/size cells to DVFSRC main binding to resolve
   validation issues on the regulator and interconnect bindings
 - Changed dvfsrc node name to `system-controller`, as the DVFSRC
   is actually able to control multiple system components.
 - Added a commit to remove mtk-dvfs-regulator.c before adding the
   new, refactored regulator driver


This series adds support for the MediaTek Dynamic Voltage and Frequency
Scaling Resource Controller (DVFSRC), found on many MediaTek SoCs.

This hardware collects requests from both software and the various remote
processors embededd into the SoC, and decides about a minimum operating
voltage and a minimum DRAM frequency to fulfill those requests, in an
effort to provide the best achievable performance per watt.

Such hardware IP is capable of transparently performing direct register
R/W on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.

Summarizing how the DVFSRC works for Interconnect:

             ICC provider         ICC Nodes
                              ----          ----
             _________       |CPU |   |--- |VPU |
    _____   |         |-----  ----    |     ----
   |     |->|  DRAM   |       ----    |     ----
   |DRAM |->|scheduler|----- |GPU |   |--- |DISP|
   |     |->|  (EMI)  |       ----    |     ----
   |_____|->|_________|---.   -----   |     ----
               /|\         `-|MMSYS|--|--- |VDEC|
                |             -----   |     ----
                |                     |     ----
                | change DRAM freq    |--- |VENC|
             --------                 |     ----
    SMC --> | DVFSRC |                |     ----
             --------                 |--- |IMG |
                                      |     ----
                                      |     ----
                                      |--- |CAM |
                                            ----

..and for regulators, it's simply...
   SMC -> DVFSRC -> Regulator voltage decider -> (vreg) Registers R/W

Please note that this series is based on an old (abandoned) series from
MediaTek [1], and reuses some parts of the code found in that.

Besides, included in this series, there's also a refactoring of the
mtk-dvfsrc-regulator driver, which never got compiled at all, and would
not build anyway because of missing headers and typos: that commit did
not get any Fixes tag because, well, backporting makes no sense at all
as the DVFSRC support - which is critical for that driver to work - is
introduced with *this series*! :-)

P.S.: The DVFSRC regulator is a requirement for the MediaTek UFSHCI
      controller's crypto boost feature, which is already upstream but
      lacking the actual regulator to work....... :-)

[1]: https://lore.kernel.org/all/20210812085846.2628-1-dawei.chien@mediatek.com/

Cheers!
AngeloGioacchino Del Regno (7):
  dt-bindings: regulator: Add bindings for MediaTek DVFSRC Regulators
  dt-bindings: interconnect: Add MediaTek EMI Interconnect bindings
  dt-bindings: soc: mediatek: Add DVFSRC bindings for MT8183 and MT8195
  soc: mediatek: Add MediaTek DVFS Resource Collector (DVFSRC) driver
  regulator: Remove mtk-dvfsrc-regulator.c
  regulator: Add refactored mtk-dvfsrc-regulator driver
  interconnect: mediatek: Add MediaTek MT8183/8195 EMI Interconnect
    driver

 .../interconnect/mediatek,mt8183-emi.yaml     |  76 +++
 .../mediatek,mt6873-dvfsrc-regulator.yaml     |  71 +++
 .../soc/mediatek/mediatek,mt8183-dvfsrc.yaml  |  94 +++
 drivers/interconnect/Kconfig                  |   1 +
 drivers/interconnect/Makefile                 |   1 +
 drivers/interconnect/mediatek/Kconfig         |  32 +
 drivers/interconnect/mediatek/Makefile        |   5 +
 drivers/interconnect/mediatek/icc-emi.c       | 153 +++++
 drivers/interconnect/mediatek/icc-emi.h       |  40 ++
 drivers/interconnect/mediatek/mt8183.c        | 143 +++++
 drivers/interconnect/mediatek/mt8195.c        | 339 +++++++++++
 drivers/regulator/mtk-dvfsrc-regulator.c      | 242 ++++----
 drivers/soc/mediatek/Kconfig                  |  11 +
 drivers/soc/mediatek/Makefile                 |   1 +
 drivers/soc/mediatek/mtk-dvfsrc.c             | 551 ++++++++++++++++++
 .../interconnect/mediatek,mt8183.h            |  23 +
 .../interconnect/mediatek,mt8195.h            |  44 ++
 include/linux/soc/mediatek/dvfsrc.h           |  36 ++
 include/linux/soc/mediatek/mtk_sip_svc.h      |   3 +
 19 files changed, 1736 insertions(+), 130 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
 create mode 100644 drivers/interconnect/mediatek/Kconfig
 create mode 100644 drivers/interconnect/mediatek/Makefile
 create mode 100644 drivers/interconnect/mediatek/icc-emi.c
 create mode 100644 drivers/interconnect/mediatek/icc-emi.h
 create mode 100644 drivers/interconnect/mediatek/mt8183.c
 create mode 100644 drivers/interconnect/mediatek/mt8195.c
 create mode 100644 drivers/soc/mediatek/mtk-dvfsrc.c
 create mode 100644 include/dt-bindings/interconnect/mediatek,mt8183.h
 create mode 100644 include/dt-bindings/interconnect/mediatek,mt8195.h
 create mode 100644 include/linux/soc/mediatek/dvfsrc.h

-- 
2.44.0


