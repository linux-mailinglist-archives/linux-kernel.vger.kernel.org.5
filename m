Return-Path: <linux-kernel+bounces-11679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2910F81E9DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 21:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AB7281C82
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E9C46B4;
	Tue, 26 Dec 2023 20:10:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F92F23C6;
	Tue, 26 Dec 2023 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 1CB0584223;
	Tue, 26 Dec 2023 21:00:45 +0100 (CET)
From: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
To: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	kernel test robot <lkp@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC] ASoC: pxa: sspa: Don't select SND_ARM
Date: Tue, 26 Dec 2023 21:00:24 +0100
Message-ID: <20231226200025.30870-1-duje.mihanovic@skole.hr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On ARM64 platforms, SND_ARM shouldn't be selectable, but enabling
SND_SOC_MMP_SSPA will enable SND_ARM and cause build errors if
SND_ARMAACI is enabled (which it is by default). Since the SSPA driver
doesn't depend on AACI nor PXA2XX_LIB, remove this false dependency.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310230518.zs9Qpg3j-lkp@intel.com/
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
This patch is necessary for my Marvell PXA1908 series to compile successfully
with allyesconfig:
https://lore.kernel.org/all/20231102-pxa1908-lkml-v7-0-cabb1a0cb52b@skole.hr/
---
 sound/soc/pxa/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index e6bca9070953..f03c74809324 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -35,7 +35,6 @@ config SND_MMP_SOC_SSPA
 	tristate "SoC Audio via MMP SSPA ports"
 	depends on ARCH_MMP
 	select SND_SOC_GENERIC_DMAENGINE_PCM
-	select SND_ARM
 	help
 	  Say Y if you want to add support for codecs attached to
 	  the MMP SSPA interface.
-- 
2.43.0



