Return-Path: <linux-kernel+bounces-58926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D46084EEB5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5AA1C24560
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6DE5C96;
	Fri,  9 Feb 2024 01:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="c3DSh6zr"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2854C8B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 01:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707443937; cv=none; b=nRxC1vl7ASihYKLLD3QSifQ7RZQnR9xxlHdDuUGt0UJ1ZcmneDT7j1opp+kj7Eo/ZrSR2wGP5rgR6gLjKPlMnkgNnc77cS+uRVoxyt7H0HqjjsE85R4RDSiY9ms7X+OD/FabOr1N8Sxk8khRw0AQE5sG3A0H/7+z9DY+OCDFgzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707443937; c=relaxed/simple;
	bh=SPMEhHXZ2gMON2Fdo5+psoDe8TKEgrIzCRXmLgoZkEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ihuFTJt2EXgIcR+zI8US4hI4SK/rJ1fInKpQg13YfbBQwGqlq5maIh5pduOfRqqAfiqkoIqyELDsiJTXZWJKF+yoBPP/3pL4QKFuNe1AzWguc3YntaWeFzLlk6nMK3Ju9j7845vs1ilpd9DAbrKLBFGfhcBElFR5uPPkdve+YAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=c3DSh6zr; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=JkJiI1zdweLmw5
	Brm11cP7jfynZIq7IJZmwIfkRRQnI=; b=c3DSh6zrTbJpNGfC2mXlrduQsNlpSf
	C1KH2X+l+7gzNtMC69FHqTeiQkGUoW2BimDdKRoGWn+J/50DvhojlV4OW1yMFWOC
	O6BpRoGF+YftBK/l2LtBIPnXT1gUz8HJ86GkvTIkwC8by9mJMEXemQaYkoq3CbdS
	UcQ60GfRSQa4gzucpuljhoNjaw/7F7Wvf0TVDPWdmPWTPoL0Vi7i0UM/E0THMRhp
	xWKNFy+phsoHzC/LutXtrUtwsn3JkiCB4srGwV6/vGK069TYqHQf9VLILaOzhBJJ
	vW6BrmdEbO/2FD5ISHMbpyoSq0tmelNsJxjVPTgNqbxADpe3G8SlyDhQ==
Received: (qmail 2792257 invoked from network); 9 Feb 2024 02:58:43 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Feb 2024 02:58:43 +0100
X-UD-Smtp-Session: l3s3148p1@sBmIROkQMuMujnsZ
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: [PATCH 0/6] mfd: tmio: simplify header and move to platform_data
Date: Fri,  9 Feb 2024 02:58:15 +0100
Message-ID: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MFD parts of the TMIO have been removed by Arnd, so that only the
SD/MMC related functionality is left. Remove the outdated remains in the
public header file and then move it to platform_data as the data is now
specific for the SD/MMC part.

Based on 6.8-rc3, build bot is happy. Branch is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/tmio-simplification

I'd suggest this goes via the MFD tree, so the series would need acks
from the MMC and SH maintainers. Is that okay with everyone?

All the best!

   Wolfram


Wolfram Sang (6):
  mfd: tmio: remove obsolete platform_data
  mfd: tmio: remove obsolete io accessors
  mmc: tmio/sdhi: fix includes
  mfd: tmio: update include files
  mfd: tmio: sanitize comments
  mfd: tmio: move header to platform_data

 MAINTAINERS                                   |   2 +-
 arch/sh/boards/board-sh7757lcr.c              |   2 +-
 arch/sh/boards/mach-ap325rxa/setup.c          |   2 +-
 arch/sh/boards/mach-ecovec24/setup.c          |   2 +-
 arch/sh/boards/mach-kfr2r09/setup.c           |   2 +-
 arch/sh/boards/mach-migor/setup.c             |   2 +-
 arch/sh/boards/mach-se/7724/setup.c           |   2 +-
 drivers/mmc/host/renesas_sdhi_core.c          |   2 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |   5 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      |   5 +-
 drivers/mmc/host/tmio_mmc_core.c              |   3 +-
 drivers/mmc/host/uniphier-sd.c                |   2 +-
 include/linux/mfd/tmio.h                      | 133 ------------------
 include/linux/platform_data/tmio.h            |  64 +++++++++
 14 files changed, 81 insertions(+), 147 deletions(-)
 delete mode 100644 include/linux/mfd/tmio.h
 create mode 100644 include/linux/platform_data/tmio.h

-- 
2.43.0


