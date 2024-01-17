Return-Path: <linux-kernel+bounces-29033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEDC830747
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD4C1C2497F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9009A200D6;
	Wed, 17 Jan 2024 13:44:49 +0000 (UTC)
Received: from abrecht.li (75-128-16-94.static.cable.fcom.ch [94.16.128.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F96200BF;
	Wed, 17 Jan 2024 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.16.128.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705499089; cv=none; b=Z9PwZmMxiHeO0yyqwI3RnnyLHHwXF7M/++vtuBMZ892KGI9Qhil2kfd4ekReMHGOi2ueZxCYZNLZRCOqELjge4rtD5JL6vM+ff5Q5tc5VvlpmoM6cf7JcQJUqBRZLJBfFq9zAahKjvTjWIjAqMHiOL+KtFgYYaRJTxuSAYLap5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705499089; c=relaxed/simple;
	bh=IkAm2qbtN+PXCKqsmFFI7eY7DInbXy/jfGbcSK753tc=;
	h=DKIM-Filter:Received:MIME-Version:Date:From:To:Subject:Message-ID:
	 X-Sender:Content-Type:Content-Transfer-Encoding; b=KjuFwMMxB0o4qD0jtvSRuHLP9YoRg97mrQaI4QNEZeRZc6AVbjm+x/eIKZfHm3Acubc6EnWGbmllEDu22xOtPb8P4tGGDD6errnAgwuaV91tGrts/gACriUpAOi19mFHb7YtXPWnTyAtE5kV4jDj0JmRZgiOQjXayW4Hwx1BPlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nodmarc.danielabrecht.ch; spf=pass smtp.mailfrom=nodmarc.danielabrecht.ch; arc=none smtp.client-ip=94.16.128.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nodmarc.danielabrecht.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nodmarc.danielabrecht.ch
DKIM-Filter: OpenDKIM Filter v2.11.0 abrecht.li D55C826B920B
Received: from toucan.dmz.abrecht.li (unknown [IPv6:fc00:4::a3c:111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by abrecht.li (Postfix) with ESMTPSA id D55C826B920B;
	Wed, 17 Jan 2024 13:44:43 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Jan 2024 14:44:43 +0100
From: Daniel Abrecht <linux-sound@nodmarc.danielabrecht.ch>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: soc-core.c: Add "Unknown" and "Unknown Product" to
 dmi_blacklist
Message-ID: <7d11d0711ad93f2208efb9ab13fe915b@abrecht.li>
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

