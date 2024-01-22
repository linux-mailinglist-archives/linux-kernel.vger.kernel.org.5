Return-Path: <linux-kernel+bounces-32638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB9A835E52
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538E21F23878
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44FB39AD8;
	Mon, 22 Jan 2024 09:36:43 +0000 (UTC)
Received: from abrecht.li (75-128-16-94.static.cable.fcom.ch [94.16.128.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B8C1E89B;
	Mon, 22 Jan 2024 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.16.128.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916203; cv=none; b=J6FbXBpca7K81LtQr0AQkRBLHtSkHCy/5iHlrQ12XwegTFZ6OfCaDqQsY7xNWTInHgb0XUYiZrb4FWPqJjeP92+LkAb1kUf49bOqaycAfFKV6HU+7UKCFKBxWMRmDM+Y/wKKZ6ccQT+uDnc8VThfh2fDxaetW9/pOfzm6RDWp+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916203; c=relaxed/simple;
	bh=P/K2p5qOybuu8S9ukoXzFxZFZq0Al91xSKb0Dcn300M=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=jZz8BRYHA5UK4OxTQsmzI02uEwNSFBMatJywhlmUo0Y7cTAYqtbTLpl9fBqGoOloXNlRVqggaES+y55vnux3Dq7S+e+9bsPbM3JWFBJFjWDO/rn2fPpevWF+IPSrvmDc4M/3auY0xl9EYYu4IJ9LXBCCCfpMzQICgSUEGLCQ0Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nodmarc.danielabrecht.ch; spf=pass smtp.mailfrom=nodmarc.danielabrecht.ch; arc=none smtp.client-ip=94.16.128.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nodmarc.danielabrecht.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nodmarc.danielabrecht.ch
DKIM-Filter: OpenDKIM Filter v2.11.0 abrecht.li 677BA27525E9
Received: from toucan.dmz.abrecht.li (unknown [IPv6:fc00:4::a3c:111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by abrecht.li (Postfix) with ESMTPSA id 677BA27525E9;
	Mon, 22 Jan 2024 09:36:31 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jan 2024 10:36:31 +0100
From: Daniel Abrecht <linux-sound@nodmarc.danielabrecht.ch>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] ASoC: soc-core.c: Add "Unknown" and "Unknown Product" to
 dmi_blacklist
Message-ID: <7d11d0711ad93f2208efb9ab13fe915b@abrecht.li>
X-Sender: linux-sound@nodmarc.danielabrecht.ch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

In U-Boot, the default for DMI vendor / product if not set is "Unknown" and "Unknown Product".
See https://source.denx.de/u-boot/u-boot/-/blob/v2023.10/lib/smbios.c?ref_type=tags#L272

This patch adds them to the dmi_blacklist.

Signed-off-by: Daniel Abrecht <public@danielabrecht.ch>
Acked-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/soc/soc-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f8524b5bfb33..aa1a31abbe3a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1804,6 +1804,8 @@ static const char * const dmi_blacklist[] = {
 	"Board Manufacturer",
 	"Board Vendor Name",
 	"Board Product Name",
+	"Unknown",
+	"Unknown Product",
 	NULL,	/* terminator */
 };
 
-- 
2.39.2

