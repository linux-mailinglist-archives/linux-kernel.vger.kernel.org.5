Return-Path: <linux-kernel+bounces-116338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE891889A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6229B3DCE5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BFE186392;
	Mon, 25 Mar 2024 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcGpiiJ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC5D297D43;
	Sun, 24 Mar 2024 23:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324343; cv=none; b=SxhDXdmmw/Xp5u7g9xBaHM2iSkrhDmt6iE9plGH7jQjGTiTcQ4SCdZpykW97hqIZlLPzavnG6o4PPboAy0X6WlRTq1hhLL/6YPyqQj1qdoNYCn7w3Z54NohVTGwzkEpHfg6Oo+dB4kuoth02R5Vbf3IW8w36yRv5X35t67PmIEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324343; c=relaxed/simple;
	bh=1+tHARB2vxR+ibEk527kzygBTsc1DKby60Sbcozc8hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxWGLc+Qi26j7VhAgReccQSqUs3MNDuH3iM5YoAUCkVfuvqJ1tOgoUNuS4YYPdGZY4Hc1jcJsy3FSgjFbbHInY4VKM2ToirZCRg+84J+L5XkRxzqf6pCsw3e0YfBSpC4fAvPJs3Wmsjq0eYMf9N8Q3bxaMJ08ntXAlG5gRmqxLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcGpiiJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14BAC43390;
	Sun, 24 Mar 2024 23:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324343;
	bh=1+tHARB2vxR+ibEk527kzygBTsc1DKby60Sbcozc8hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RcGpiiJ13SP+W6SKY+Bv+gq1h37IMBM7b44zWW2/tA9JO6VwyldLg7XgdSMFKTd1Q
	 F7NfU5qb26SLe/kt9LjO+kQEdQ06Ilohaf5YXUzdQU1y0iFI3IgErNp7fF03fXrr7w
	 oS0zusTALhj5I4UJ65Nmt6dbViHNQl7xOwM4XttyHz/MNv+ls3/86y/3fs36jFZnLM
	 lgQ1pEvt+7a1eR7ePAjyMJGURZ3AaG5Cr+43lKZkoM8tI34fxVs5nESSzj6RfUTZAi
	 mCyrkgbTLGU3Tvo+40f9HA3/yT/2TiTB3QNgcEQqH4qV1hz1hte6A6f42F3a3RvtVw
	 34hP2sTtF59jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 113/148] ASoC: meson: axg-tdm-interface: fix mclk setup without mclk-fs
Date: Sun, 24 Mar 2024 19:49:37 -0400
Message-ID: <20240324235012.1356413-114-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit e3741a8d28a1137f8b19ae6f3d6e3be69a454a0a ]

By default, when mclk-fs is not provided, the tdm-interface driver
requests an MCLK that is 4x the bit clock, SCLK.

However there is no justification for this:

* If the codec needs MCLK for its operation, mclk-fs is expected to be set
  according to the codec requirements.
* If the codec does not need MCLK the minimum is 2 * SCLK, because this is
  minimum the divider between SCLK and MCLK can do.

Multiplying by 4 may cause problems because the PLL limit may be reached
sooner than it should, so use 2x instead.

Fixes: d60e4f1e4be5 ("ASoC: meson: add tdm interface driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://msgid.link/r/20240223175116.2005407-2-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/meson/axg-tdm-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 01cc551a8e3fa..2a7ea41fc49e5 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -258,8 +258,8 @@ static int axg_tdm_iface_set_sclk(struct snd_soc_dai *dai,
 	srate = iface->slots * iface->slot_width * params_rate(params);
 
 	if (!iface->mclk_rate) {
-		/* If no specific mclk is requested, default to bit clock * 4 */
-		clk_set_rate(iface->mclk, 4 * srate);
+		/* If no specific mclk is requested, default to bit clock * 2 */
+		clk_set_rate(iface->mclk, 2 * srate);
 	} else {
 		/* Check if we can actually get the bit clock from mclk */
 		if (iface->mclk_rate % srate) {
-- 
2.43.0


