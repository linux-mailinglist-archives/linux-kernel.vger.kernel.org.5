Return-Path: <linux-kernel+bounces-101038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC7987A12F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33D69B2223F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2E9BA3F;
	Wed, 13 Mar 2024 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jwang.link header.i=@jwang.link header.b="IhD+07LW"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8794AD56
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710295207; cv=none; b=r1+yz/wJ5PUmZknt6m3bmBJM1t+bcVcjGuw0+iD2lO3w6vzRWG/U0H6IcEXEKldNIuYsB6EgqYQz3NIIYvS1MPptfPQsTGs0rVLEX37wC117Kp0R/K4G/1lXIYRxZCjMt8PQ4V5ety0KdK6kZygwkEC4H9cCTAw2lD9b5lpGsB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710295207; c=relaxed/simple;
	bh=APTa/8Fhdr3cFmkiQSmv4Cee2OoQldd7OYx7dwB+9ts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8ztl64yM5STjMxcWUkWHPZ+yZw7dv4KVM0PwavjywNoAolZCMs4ug52ftrygBeOyCwre/zqux6yMxNFhwCWIc5vcxtAuCtgbkIqU5f8S4pLHDfHvj5G2egmdOvt9d7DLOrSvBr+CiR5PmQYu9CzREmKAIBztcceN+Cgiw3hmlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jwang.link; spf=pass smtp.mailfrom=jwang.link; dkim=pass (2048-bit key) header.d=jwang.link header.i=@jwang.link header.b=IhD+07LW; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jwang.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jwang.link
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jwang.link; s=key1;
	t=1710295200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HzuNIXQtvXRiIKbJM4BL72narhpcWuIm7CcPK5xNzYk=;
	b=IhD+07LWuE8n0mizyzeA9pjIMSYV5hJtfcE3qngeG3/I3wtWC06UZecV8Q0IdEZA7htUxs
	jR4Zjqozvk0QV4SzZn4GzGCFQFoYpw0Zpc1C+++QCjQUNdBbIdNHx6JYbgy2wZK/xj+GA1
	+SYd4AAWg2fkjWj4QTAkHj4D8mvGKVpEuNlZip8sUJN8zELOv7b4GiPCPIMUAkFxoz7pZE
	wK8UerrX0KFagT28X4IvRNFJ+FSHZ0ie+pwJMqjFWGeciKzqpyoUR09ly5evNfqbB0CdAV
	r6UgiLDFmSMnDD4tiZ2HbP/2XvHCtpjXDkJtOwJo1IRab0xsfvK+Fy/FWH/FrQ==
From: Jiawei Wang <me@jwang.link>
To: broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	me@jwang.link,
	sashal@kernel.org,
	vijendar.mukunda@amd.com,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jeremy Soller <jeremy@system76.com>,
	August Wikerfors <git@augustwikerfors.se>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] ASoC: amd: yc: Revert "Fix non-functional mic on Lenovo 21J2"
Date: Wed, 13 Mar 2024 09:58:52 +0800
Message-Id: <20240313015853.3573242-2-me@jwang.link>
In-Reply-To: <20240313015853.3573242-1-me@jwang.link>
References: <a127404b-a071-4917-8ddb-d7371c721827@sirena.org.uk>
 <20240313015853.3573242-1-me@jwang.link>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This reverts commit ed00a6945dc32462c2d3744a3518d2316da66fcc,
which added a quirk entry to enable the Yellow Carp (YC)
driver for the Lenovo 21J2 laptop.

Although the microphone functioned with the YC driver, it
resulted in incorrect driver usage. The Lenovo 21J2 is not a
Yellow Carp platform, but a Pink Sardine platform, which
already has an upstreamed driver.

The microphone on the Lenovo 21J2 operates correctly with the
CONFIG_SND_SOC_AMD_PS flag enabled and does not require the
quirk entry. So this patch removes the quirk entry.

Thanks to Mukunda Vijendar [1] for pointing this out.

Link: https://lore.kernel.org/linux-sound/023092e1-689c-4b00-b93f-4092c3724fb6@amd.com/ [1]

Signed-off-by: Jiawei Wang <me@jwang.link>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 1ab69a53174e..69c68d8e7a6b 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -199,13 +199,6 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21HY"),
 		}
 	},
-	{
-		.driver_data = &acp6x_card,
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "21J2"),
-		}
-	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.2


