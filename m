Return-Path: <linux-kernel+bounces-28946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A077830504
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC6C1F25900
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCCB1DFE3;
	Wed, 17 Jan 2024 12:14:17 +0000 (UTC)
Received: from abrecht.li (75-128-16-94.static.cable.fcom.ch [94.16.128.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E4B1DFC7;
	Wed, 17 Jan 2024 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.16.128.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705493657; cv=none; b=c08L9wSW3OtLAvB6mfENkB8Pfv06YYK4JzYRn/L4hW2G+RGyveb3+bX50KbZBdHZZLBYFFC0e2zZlfR/bpyLS6NbdBPt89XYzbO/70YIfH2KvcPIqlBbN8iigGxQldSHckarbVOylSyHXQZPWqoSfheAVGogP1ki+UNRRw8RV4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705493657; c=relaxed/simple;
	bh=RlZFmj9rLo2wrABejOWSXj94vkocMEJnlyZj1KYaC+A=;
	h=DKIM-Filter:Received:MIME-Version:Date:From:To:Subject:Message-ID:
	 X-Sender:Content-Type:Content-Transfer-Encoding; b=Dnfi7m8GGEZ9MrJhApdZE6fWNBX18XjyzVAtjeCTPI0zf5xYq+aGqvs+JBymb/TnRh0DQzG4JZ0ngIDZc+UacqFsdIW+pLt09w3Zerh6DEuhzYPJj6s1jwh4b4xeVbFwh1uf+8uMDcoUWGrju0zAj/gjMO9EVdhXGHGlnjWtauM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nodmarc.danielabrecht.ch; spf=pass smtp.mailfrom=nodmarc.danielabrecht.ch; arc=none smtp.client-ip=94.16.128.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nodmarc.danielabrecht.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nodmarc.danielabrecht.ch
DKIM-Filter: OpenDKIM Filter v2.11.0 abrecht.li EE8F726B6536
Received: from toucan.dmz.abrecht.li (unknown [IPv6:fc00:4::a3c:111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by abrecht.li (Postfix) with ESMTPSA id EE8F726B6536;
	Wed, 17 Jan 2024 12:14:10 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Jan 2024 13:14:10 +0100
From: Daniel Abrecht <linux-sound@nodmarc.danielabrecht.ch>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: soc-core.c: Add "Unknown" and "Unknown Product" to
 dmi_blacklist
Message-ID: <78a54997daea2b327ad59d495bc33851@abrecht.li>
X-Sender: linux-sound@nodmarc.danielabrecht.ch
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

In U-Boot, the default for DMI vendor / product if not set is "Unknown" 
and "Unknown Product".
See 
https://source.denx.de/u-boot/u-boot/-/blob/v2023.10/lib/smbios.c?ref_type=tags#L272

This patch adds them to the dmi_blacklist.

Signed-off-by: Daniel Abrecht <public@danielabrecht.ch>
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
+    "Unknown",
+    "Unknown Product",
      NULL,    /* terminator */
  };

-- 
2.39.2

