Return-Path: <linux-kernel+bounces-117788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 806EF88AF93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D0D1FA212A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68E818AF9;
	Mon, 25 Mar 2024 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMxKADBa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FF011737;
	Mon, 25 Mar 2024 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394070; cv=none; b=txaCEBHvpFxnlHRAzhWlqvpa+ipLIK5w2DhxG//Ne4w2GCu+BoOXxVjirXhsIf1AADynEpNtLyKy9knFHjp2B0ZFLywWVAtUdVzrwvrAxTvSPz7vYrOavL4Ms4oNR26RMedJq/nUFQenoux6/B81DxDhSUbCY0P4UEHz8/OfMoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394070; c=relaxed/simple;
	bh=S4dR9hMjuyXo+2NLjdCApilcKOOtn4MC+CpSK0tyAkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GHvQJuo/ROO+1/8tJGGxMZ8e0R7xRbfxdwl+u4RQXWoI04AB+cFy0WCY3GG2ghOtc9xXh6c4cJmgF7ZL94COu3GtiJEhmRZQc7zLwwAyrS79IhB0c1D015vU962OSHOEazHkkiTJ2TlNXW5Yecwxab10S60PPSMM2PIYllpAw6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMxKADBa; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711394069; x=1742930069;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S4dR9hMjuyXo+2NLjdCApilcKOOtn4MC+CpSK0tyAkM=;
  b=AMxKADBaFjLF7rinPZw3jk2vCbfjVFyRaVpYuHkdzF2LXF8wDOtWmHj0
   Atin8dkll7yRqaWwpIdzRZyLcfZ4SDsw/sT5NoHN+tsVdjQ23lOg7dgzA
   OYP80H+bbFAoCMYs5hf0rthjgUA0FK5dVC54MlsgXFDhPzqjyP7gO7a9q
   C857vfNbwFQVILBDO9HwrfDbSv/r10h0if2PP7Z8gj4W3jpHFS/d2Tyq4
   CbymBVzpdh01NkNS0zkR9ILdTXWJklatFGFG/CpQ+9wAwb4DDp0gellgC
   D4EPSuuPG5g33LbUh9JtvdNPTCltoFd1RAd7ttQlLVpXmx9VK2e3g3Y/J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="10213322"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="10213322"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 12:14:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="937070805"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="937070805"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 12:14:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 470F2101; Mon, 25 Mar 2024 21:14:22 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ASoC: fsl: imx-es8328: Remove leftover gpio initialisation
Date: Mon, 25 Mar 2024 21:13:41 +0200
Message-ID: <20240325191341.3977321-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gpio field is not used anymore, remove the leftover.
This also fixes the compilation error after the ...

Fixes: 9855f05e5536 ("ASoC: fsl: imx-es8328: Switch to using gpiod API")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/fsl/imx-es8328.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/imx-es8328.c b/sound/soc/fsl/imx-es8328.c
index d67b8a149bff..5b9648f3b087 100644
--- a/sound/soc/fsl/imx-es8328.c
+++ b/sound/soc/fsl/imx-es8328.c
@@ -28,7 +28,6 @@ struct imx_es8328_data {
 
 static struct snd_soc_jack_gpio headset_jack_gpios[] = {
 	{
-		.gpio = -1,
 		.name = "headset-gpio",
 		.report = SND_JACK_HEADSET,
 		.invert = 0,
-- 
2.43.0.rc1.1.gbec44491f096


