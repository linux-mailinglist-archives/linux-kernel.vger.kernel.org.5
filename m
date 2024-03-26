Return-Path: <linux-kernel+bounces-119443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A77DD88C8DE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA1C1F66533
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3115613CF95;
	Tue, 26 Mar 2024 16:19:05 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E89C13C9DA;
	Tue, 26 Mar 2024 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469944; cv=none; b=FSU4xR/OHqeEk4aRMq+SPxcRZdO1WQ2N04Qqva1qd9tFuAvB/ewjgnL0dHzRgZCm02MyLPuCm+oM06YbRhL/hVLlZ3riS7PjCX/hHzUen0MSuBuDUqWtAqTL0UCcnD2fy11F7XtoHvIt/F0bkxu4Nkf3IBWxhKmO98bUQ+39zEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469944; c=relaxed/simple;
	bh=5aDrrnIyMvrzhrxVH1Ca2IiEhPa9yUeMCoC85ZSPPPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qjLW+/JP3CoxSyVfeG1p8r8WekpO1Ul5Jo9Jf3iImGggjs7E9WWB9hK+CwW4aVS5q9X2GCbe3tYI+LAjzki2Yd4gmvn6CcR5qZPVU2J45eiw4jVKiN7JUHZEHJW7jYrVQZGZQT+nWb9n9Pfw2zln3cEQUBK7FSuYtrAglE4GV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68717.dsl.pool.telekom.hu [::ffff:81.182.135.23])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000077340.000000006602F575.0023D3CD; Tue, 26 Mar 2024 17:19:00 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v2 4/4] ALSA: hda/tas2781: remove useless dev_dbg from playback_hook
Date: Tue, 26 Mar 2024 17:18:48 +0100
Message-ID: <8b9546db6c92dea4476a7247a88d56248c2ba8c2.1711469583.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711469583.git.soyer@irl.hu>
References: <cover.1711469583.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

The debug message "Playback action not supported: action" is not useful,
because the action was previously printed, and the list of supported
actions are intentional.

Remove the debug statement from the default switch case.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/tas2781_hda_i2c.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index f495caee38e1..48dae3339305 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -161,8 +161,6 @@ static void tas2781_hda_playback_hook(struct device *dev, int action)
 		pm_runtime_put_autosuspend(dev);
 		break;
 	default:
-		dev_dbg(tas_hda->dev, "Playback action not supported: %d\n",
-			action);
 		break;
 	}
 }
-- 
2.44.0


