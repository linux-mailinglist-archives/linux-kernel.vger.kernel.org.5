Return-Path: <linux-kernel+bounces-57165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5D784D4A9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086921C22481
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A1915958E;
	Wed,  7 Feb 2024 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4VcAxvs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32202159C84;
	Wed,  7 Feb 2024 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341142; cv=none; b=t5FG9+lybt7gCZsb4dKoztDY8Ycl1/NG9vdH54tyJV/Cx0VyNbjSPLrOYnGewY9mT7IZEWDP9+1OlAIUPIV2e0lxBnYCFSIBkr7j7sSxD46/fdqXGkMRGu0PBAgkVbRItukH8NjOg4Kp51jHIDMaD1qINTILE+clOeCYAMBdfFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341142; c=relaxed/simple;
	bh=Iup1eeDQIYk9dSO0YPxYOwQGeKFzFwwvpASujqF6Vvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6wID4Y0H2gsfSZ1D+DKMzEDiYOm2jsqfqNNu/g5SktZb2rNkbZIehnh+m2A43wtuubfVQpM+8TySGr/JRzXdjbpmzz8c+pGVcBanCFJwU0ySlvQwUsbLXqwapCM5oezYgLJCFOAXUV8UERPtlmEohvC5istWiRHk7mCebwmcKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4VcAxvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D29C433C7;
	Wed,  7 Feb 2024 21:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341142;
	bh=Iup1eeDQIYk9dSO0YPxYOwQGeKFzFwwvpASujqF6Vvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4VcAxvsI1WFm+/x0JzqoKbOLCh09eqjHpX2wHnCxStyoduuDBdBS1C42IjGcBeVi
	 /Uo6/gitnWnwXw94SPPe6bIp1a3P5x9RtxFPlPRtF1LfVrBANRSLXqcAJ1d6PADKww
	 xxA4Or1cWckIplAXjnkVbamudAuBW8YUYVZkujZT0cVB3RwL1iCSaJqEgSuxI8j36X
	 XK/+bXiPQuZfnibEeKJ1plSncNHXe5B7ArqQwSh65f9biJe6zhFxNiTRcXpF4zaRXc
	 iodqhPVINoV32SKJqp+iQmicbzMFUcPiLWD0Z/6rxhHqaBsmohZ0EpRenXUbzVn0cq
	 dvh9sPbsZlvnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	simont@opensource.cirrus.com,
	jarkko.nikula@bitmer.com,
	claudiu.beznea@tuxon.dev,
	kuninori.morimoto.gx@renesas.com,
	dinghao.liu@zju.edu.cn,
	ckeepax@opensource.cirrus.com,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 17/29] ASoC: wm_adsp: Don't overwrite fwf_name with the default
Date: Wed,  7 Feb 2024 16:24:42 -0500
Message-ID: <20240207212505.3169-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit daf3f0f99cde93a066240462b7a87cdfeedc04c0 ]

There's no need to overwrite fwf_name with a kstrdup() of the cs_dsp part
name. It is trivial to select either fwf_name or cs_dsp.part as the string
to use when building the filename in wm_adsp_request_firmware_file().

This leaves fwf_name entirely owned by the codec driver.

It also avoids problems with freeing the pointer. With the original code
fwf_name was either a pointer owned by the codec driver, or a kstrdup()
created by wm_adsp. This meant wm_adsp must free it if it set it, but not
if the codec driver set it. The code was handling this by using
devm_kstrdup().
But there is no absolute requirement that wm_adsp_common_init() must be
called from probe(), so this was a pseudo-memory leak - each new call to
wm_adsp_common_init() would allocate another block of memory but these
would only be freed if the owning codec driver was removed.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://msgid.link/r/20240129162737.497-3-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 2cfca78f0401..47a4c363227c 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -740,19 +740,25 @@ static int wm_adsp_request_firmware_file(struct wm_adsp *dsp,
 					 const char *filetype)
 {
 	struct cs_dsp *cs_dsp = &dsp->cs_dsp;
+	const char *fwf;
 	char *s, c;
 	int ret = 0;
 
+	if (dsp->fwf_name)
+		fwf = dsp->fwf_name;
+	else
+		fwf = dsp->cs_dsp.name;
+
 	if (system_name && asoc_component_prefix)
 		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s-%s.%s", dir, dsp->part,
-				      dsp->fwf_name, wm_adsp_fw[dsp->fw].file, system_name,
+				      fwf, wm_adsp_fw[dsp->fw].file, system_name,
 				      asoc_component_prefix, filetype);
 	else if (system_name)
 		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s.%s", dir, dsp->part,
-				      dsp->fwf_name, wm_adsp_fw[dsp->fw].file, system_name,
+				      fwf, wm_adsp_fw[dsp->fw].file, system_name,
 				      filetype);
 	else
-		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s.%s", dir, dsp->part, dsp->fwf_name,
+		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s.%s", dir, dsp->part, fwf,
 				      wm_adsp_fw[dsp->fw].file, filetype);
 
 	if (*filename == NULL)
@@ -842,29 +848,18 @@ static int wm_adsp_request_firmware_files(struct wm_adsp *dsp,
 	}
 
 	adsp_err(dsp, "Failed to request firmware <%s>%s-%s-%s<-%s<%s>>.wmfw\n",
-		 cirrus_dir, dsp->part, dsp->fwf_name, wm_adsp_fw[dsp->fw].file,
-		 system_name, asoc_component_prefix);
+		 cirrus_dir, dsp->part,
+		 dsp->fwf_name ? dsp->fwf_name : dsp->cs_dsp.name,
+		 wm_adsp_fw[dsp->fw].file, system_name, asoc_component_prefix);
 
 	return -ENOENT;
 }
 
 static int wm_adsp_common_init(struct wm_adsp *dsp)
 {
-	char *p;
-
 	INIT_LIST_HEAD(&dsp->compr_list);
 	INIT_LIST_HEAD(&dsp->buffer_list);
 
-	if (!dsp->fwf_name) {
-		p = devm_kstrdup(dsp->cs_dsp.dev, dsp->cs_dsp.name, GFP_KERNEL);
-		if (!p)
-			return -ENOMEM;
-
-		dsp->fwf_name = p;
-		for (; *p != 0; ++p)
-			*p = tolower(*p);
-	}
-
 	return 0;
 }
 
-- 
2.43.0


