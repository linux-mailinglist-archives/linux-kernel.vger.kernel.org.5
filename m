Return-Path: <linux-kernel+bounces-15384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F990822B3D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77832854AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AE118B09;
	Wed,  3 Jan 2024 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSkHl15U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BF418C01;
	Wed,  3 Jan 2024 10:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C5AC433C7;
	Wed,  3 Jan 2024 10:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704277549;
	bh=70yV6dPZoIZpzr4uUDr7MGvuMP16x0pk4SVKCZWWsuw=;
	h=From:To:Cc:Subject:Date:From;
	b=kSkHl15UOLHlC/0U3rSSEIjwTcnL4eEkEtRRH+if+3/JC+QXWyx6ru/bs+1Vt70Pn
	 htFUvg8z57Q2/T1YjBgcKvivGICml3Zj5T5ITwplW0cQdfvezkOg37NyDIiF8ATAcC
	 12zhkYeNqG0uBnf/VEM1grKmQ+EaXkB9Bw/l5+N6tW4kHEnvGKAVPLAzPIwCICsJea
	 FV+JMKOu++SNCg0mMyDfhhLAOVzQX5PGRYLiqJhwLpwkIba+3txhhqjPjcX8xqut3/
	 oFRv9k9sGXA/8AIdtDpEfAlcGUSE4xKIVGSRUXGR9yLPcEMN1PV+Upc07we7Rrzuwh
	 Vo1ZAg2XII2jg==
From: Arnd Bergmann <arnd@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Yu Liao <liaoyu15@huawei.com>,
	Dawei Li <set_pte_at@outlook.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: ac97: fix build regression
Date: Wed,  3 Jan 2024 11:25:38 +0100
Message-Id: <20240103102544.3715055-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The ac97_bus_type structure is no longer declared in this file:

sound/ac97/bus.c: In function 'ac97_codec_add':
sound/ac97/bus.c:112:27: error: 'ac97_bus_type' undeclared (first use in this function); did you mean 'bus_type'?
  112 |         codec->dev.bus = &ac97_bus_type;
      |                           ^~~~~~~~~~~~~
      |                           bus_type
sound/ac97/bus.c:112:27: note: each undeclared identifier is reported only once for each function it appears in
sound/ac97/bus.c: In function 'snd_ac97_codec_driver_register':
sound/ac97/bus.c:191:28: error: 'ac97_bus_type' undeclared (first use in this function); did you mean 'ac97_bus_reset'?
  191 |         drv->driver.bus = &ac97_bus_type;

Include the header that contains the declaration and make sure the definition
is const but not static.

Fixes: 66e82d219924 ("ALSA: mark all struct bus_type as const")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/ac97/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index 1dc7965eb14b..5e46b972a3da 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -15,6 +15,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <sound/ac97_codec.h>
 #include <sound/ac97/codec.h>
 #include <sound/ac97/controller.h>
 #include <sound/ac97/regs.h>
@@ -529,7 +530,7 @@ static void ac97_bus_remove(struct device *dev)
 	pm_runtime_disable(dev);
 }
 
-static struct bus_type ac97_bus_type = {
+const struct bus_type ac97_bus_type = {
 	.name		= "ac97bus",
 	.dev_groups	= ac97_dev_groups,
 	.match		= ac97_bus_match,
-- 
2.39.2


