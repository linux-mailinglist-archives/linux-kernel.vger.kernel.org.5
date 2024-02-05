Return-Path: <linux-kernel+bounces-52858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30107849D82
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3DE41F24818
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79FE2E408;
	Mon,  5 Feb 2024 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dua5cP+K"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FF32CCD6;
	Mon,  5 Feb 2024 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145060; cv=none; b=c4UPOoSEH/8Z/7Aiw1Zt48w+EglZVOBHxP/Do4d5hcHP7YWUZchbvne1k86vhuvhnuJYJgiko0H/KX+0FK/cWcQo/Tw9XMcFgaQIt8qMu2thEvKiPa6jhjBSkgOilZihjAb56+TLP4rk52oL5lC+hJkoNMV0lJK5xD126XvpGyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145060; c=relaxed/simple;
	bh=bbnVRfSTTyUwEskkAt8A1NoibdYucpRDjbkx5OMqZAs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HxFSLtKmNOMvugeHKWWkKX5Vkqq/ifpqKDZBSe31frovcUq2cntDWQuN+qmq0Agt/BgveGgtl7j5AXxTSxMXAkPP8CqjXNsSPeMlY0Rq58SjKABKROk55685WJ2kFljLPqFtXmL+hsJm8Un0wNPOeps+2iPam1rgVCvi9YizuOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dua5cP+K; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1C13620003;
	Mon,  5 Feb 2024 14:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707145050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h1sNYp+gc9a9VoUu+eh68EAIfTPEAijNDew8gQP2kNQ=;
	b=dua5cP+KAskFu8T8l5ctgxrgM4HO/0/M+4V1fvsyzMxbMb3BANSOE5kdd9Ci6yC75JfG08
	QZlDBgSmVP00Dt4GA6k8hbx8pSLJUkcYeQ1Z2zCrCxytgJZS2T3oAfOsWinNESegYZsvkp
	0HUCjsmPkQP47Z3jLPUbuj8rlkyffWdQoLlrVuTMPkCObFa9wXwp3MJ2NKtV+U00Kne9jI
	6H0k7Awn7wrAtWf0nAkVSoqpGlu20K1xilgN2bkIEBWxxPPeAnrBf4RIRK9E49Cy8WoSYz
	fkmFD2aFCvqXACftsX7nI8xj/VuBxjBU1X8+vGflxZBeETjIJBlJoBwx3MuaZA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v2 0/4] spi: cadence-qspi: Fix runtime PM and system-wide
 suspend
Date: Mon, 05 Feb 2024 15:57:28 +0100
Message-Id: <20240205-cdns-qspi-pm-fix-v2-0-2e7bbad49a46@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFj3wGUC/32NTQrCMBCFr1Jm7UgSpVZX3kO6MH92wCYxKUEpu
 btjD+DmwffgfW+F4jK5ApduhewqFYqBQe06MNM9PBySZQYl1FFwoLGh4KskwjSjpzeqcy+EMb0
 9aQ88S9lxvSlvI/NEZYn5sz1U+Wv/yKpEiQczeKeV9tYOVx3j8qSwN3GGsbX2Bb/JH1OyAAAA
To: Mark Brown <broonie@kernel.org>, Apurva Nandan <a-nandan@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Hi,

This V2 got a false start, hoping you got a good laugh out of it. :-)
Sorry for the spam.

This fixes runtime PM and system-wide suspend for the cadence-qspi
driver. Seeing how runtime PM and autosuspend are enabled by default, I
believe this affects all users of the driver.

The V1 has been split into three commits and a fourth commit is added to
add system-wide suspend/resume callbacks as discussed under V1.

The MIPS platform at hand, used for debugging and testing, is currently
not supported by the driver. It is the Mobileye EyeQ5 [0]. No code
changes are required for support, only a new compatible and appropriate
match data + flags. That will come later, with some performance-related
patches.

This series has been tested on both Mobileye EyeQ5 hardware and the TI
J7200 EVM board, under s2idle.

Thanks all,
Théo

[0]: https://lore.kernel.org/lkml/20240118155252.397947-1-gregory.clement@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v2:
- Split the initial change into three separate commits, to make intents
  clearer.
- Mark controller as suspended during the system-wide suspend.
- Link to v1: https://lore.kernel.org/r/20240202-cdns-qspi-pm-fix-v1-1-3c8feb2bfdd8@bootlin.com

---
Théo Lebrun (4):
      spi: cadence-qspi: put runtime in runtime PM hooks names
      spi: cadence-qspi: fix pointer reference in runtime PM hooks
      spi: cadence-qspi: remove system-wide suspend helper calls from runtime PM hooks
      spi: cadence-qspi: add system-wide suspend and resume callbacks

 drivers/spi/spi-cadence-quadspi.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)
---
base-commit: 13acce918af915278e49980a3038df31845dbf39
change-id: 20240202-cdns-qspi-pm-fix-29600cc6d7bf

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


