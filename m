Return-Path: <linux-kernel+bounces-144344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9EA8A44C4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7621C210CB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A89137777;
	Sun, 14 Apr 2024 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4UezHTK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABF613774E;
	Sun, 14 Apr 2024 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120560; cv=none; b=hQlo2/Z2VfPgVFV7PCB+xxF+cXeVEfLjADGlNr+EhfVRf5FWd84WoV0tLAvImcLN/o2MdKkD0slWtFtn7l8FwIjx1sx2m/rN0vffHWLub33tvarDoXYKDMdgLpzmlM6kf0+A6owLA6whl7ihZZ3+T48o/ai9aysOjBxg60qeYEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120560; c=relaxed/simple;
	bh=HDCjdUZ9nbqoLbalVPVe/UT1SONcMJH2I6HWQBc1Bwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BSQie1WIrcJ57W+EwQdJqR9bntEHMhL2tdAe9eRsvXjAevXa2FA4WO0UYH/0375HGspNJSan24QLJXEdXC1DKCpcYLJAobk+u2czyo0/14JbPuVylsFGNiyXbnP/b/Ku+427ysud/uZTW6aoE/42xmL94jVmxkp8IPMCwP+/HRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4UezHTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACB5C072AA;
	Sun, 14 Apr 2024 18:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120560;
	bh=HDCjdUZ9nbqoLbalVPVe/UT1SONcMJH2I6HWQBc1Bwg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D4UezHTK7gkYSB8U6BP8dGprcFYlx6MXcQcpiIzrnlGi6/cU5fo+9FSsCxX+8YQT1
	 ICz+VHyKvRbQedDXb+hZ/BiPZjYWtb61XAUQ1RcwwDkWcuViR2PFotNitqgUkVxg5E
	 UZaguPyyN6f3pfg5gNXoabh7xY3uKe1OA/dtJtjEu5M2NQJjC0jEehJ8foJeBV1L6A
	 aj3ZlJmhtbccpoKMwjDJ7/6P16FaJcuS0ECCJCyQk+TI3TzM2/oNsMdXu7w3QEGETd
	 zsxayGMGN8DxkdU59fDgtoGl7dPLOTMCNymOIcl8O4bu91QV7TRsy62q3n8b8nHbuR
	 y4PsfImOyuRow==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 20:47:37 +0200
Subject: [PATCH 12/14] ASoC: SOF: intel: byt: Constify snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-n-const-ops-var-v1-12-8f53ee5d981c@kernel.org>
References: <20240414-n-const-ops-var-v1-0-8f53ee5d981c@kernel.org>
In-Reply-To: <20240414-n-const-ops-var-v1-0-8f53ee5d981c@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=krzk@kernel.org;
 h=from:subject:message-id; bh=HDCjdUZ9nbqoLbalVPVe/UT1SONcMJH2I6HWQBc1Bwg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHCTOgSv/AebgOX4MZvM+Uh75zPZ0Rvctqm5Kz
 AmlxIeXz5yJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwkzgAKCRDBN2bmhouD
 1y/6D/4z/POCI8W7rkjUkLA0M+QsTfEAS2ki1DPELX7wk/YqHgSOolz78b1M7laKFW2+QCZW4fV
 rKZ3oGlTY8sxvrDOkjRcE2/L9LGcQyaZvtafXCvBF7OobozCO2KLn1P9Tz82SoU7L51UGPfUzbv
 DBwEL+8qzHNL2vKBy2ELBepSeb44RvlsQ8bY33CnW8oZUqcnNoYI6SU0ks81RpX7YVO8e3NDIQT
 aOQRvs/RJ7GsxZhWBlR0BCsStYo0f3bo0i0JrzuBgnim3bsr4+/FikmTT5J8aAPctCo4a7ar5rk
 ftqk8nL+M1zF4gmFEFBpqmeeuHEvypXA59P60SGLzqV3ju904VAGx3769t43JH5Z/MEmZvfm73B
 U/AG+h+2d3l0bGCEev6eD6hdC6/cu1KBpoQqhnmb6owYg9sXOno1dfaPHr5fWL38gT74USUCZzu
 j6xyrbRvMVKIvIoLr6StR35+Ah2VFi081knqkJNWghEd2wEOjYPCmtAd50O0RYIBZTVKijDU0S7
 7mJxwJKCBfhAOELf1Ll+r9VL85TXwThvz6r1tP60Ix0IVilM7I4r/+BoLtCJNe/bhbxwyG4ps3D
 wNSoXzLjeFdVFZ8fYdBpZDFtwkS3HDtDKgaqTFdGsr4N0wgpdm04zgh57ciWanELUhIIkDku441
 NFAEvaNp4sgXogA==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
const for increased code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/sof/intel/byt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index 373527b206d7..14a065999a89 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -214,7 +214,7 @@ static int byt_acpi_probe(struct snd_sof_dev *sdev)
 }
 
 /* baytrail ops */
-static struct snd_sof_dsp_ops sof_byt_ops = {
+static const struct snd_sof_dsp_ops sof_byt_ops = {
 	/* device init */
 	.probe		= byt_acpi_probe,
 	.remove		= byt_remove,
@@ -289,7 +289,7 @@ static const struct sof_intel_dsp_desc byt_chip_info = {
 };
 
 /* cherrytrail and braswell ops */
-static struct snd_sof_dsp_ops sof_cht_ops = {
+static const struct snd_sof_dsp_ops sof_cht_ops = {
 	/* device init */
 	.probe		= byt_acpi_probe,
 	.remove		= byt_remove,

-- 
2.34.1


