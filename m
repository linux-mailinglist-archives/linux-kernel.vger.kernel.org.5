Return-Path: <linux-kernel+bounces-159749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3E88B3390
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABAAE28228A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2131420DA;
	Fri, 26 Apr 2024 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMujMDwB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BC113E3E4;
	Fri, 26 Apr 2024 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122362; cv=none; b=ZEOikvTMkAGx0xdWyGLOS40NrqGj+/Y5lkLRAQFziD9EOxaMXLF6y9qlZ3W2u1c1ZN5JYu4gm/NYTRVTUanCMtEUjk2fnrTrk6F2AttHdNapvjeQ89Uge+XGJpXon6YIO9YAQQui5F5GSgB6moVKQRnXFEjehSWiXQfrsEvY2YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122362; c=relaxed/simple;
	bh=XhUx011C+wZqMOdhwTy6Qg8ip1G5xaYrcjjSY155w/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bt/3gqoHZg+JNgyTxdatIBoqZtIVJIWne8lAWG3yUJRxToD5KVYFUB++Ed0UnK5VmrCOWDzzgZSnYiJTv1hC4ZKhp0sggZQQsBBUvnENAdDF6BcvOeNed+V8pgGJS/6Ocfjxe/Bfu72SkmeDPrf8t6if6GchguW9fAEoHVYgf2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMujMDwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD20C113CE;
	Fri, 26 Apr 2024 09:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714122362;
	bh=XhUx011C+wZqMOdhwTy6Qg8ip1G5xaYrcjjSY155w/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aMujMDwBsr5AJ6ROnowe+A7L8z1T5tXxxq73BO5xHU+9XjtC1AIMVuvizzgq/l0+3
	 soDbU4bOCwi6HQB/rbtDf/PC9CBr37R3k5SSiZj29vDhxKMwZHWFgDk4epCqHH2Oqv
	 u2dAspQQRvdPI4Eq8hFMbHBbme9GYJzRRhITxjEToz1GNzeeL25wUQXJFC91dFeH+g
	 zp+wB3r4NIqIcCE94xKtyay8mCQ0yeukQGMVCGw4Q1cGHss9Dp3HsSKxFLAd6rfuki
	 /fDHqa32jmC8W5P/533Y1F0SBjLJJ9P/4UVZQusNbiM8rMzBb39f8OFLFp5Fu2U8T+
	 IWLXO5wOvBW1Q==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Apr 2024 11:03:56 +0200
Subject: [PATCH v2 09/14] ASoC: SOF: imx8m: Constify snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-n-const-ops-var-v2-9-e553fe67ae82@kernel.org>
References: <20240426-n-const-ops-var-v2-0-e553fe67ae82@kernel.org>
In-Reply-To: <20240426-n-const-ops-var-v2-0-e553fe67ae82@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=829; i=krzk@kernel.org;
 h=from:subject:message-id; bh=XhUx011C+wZqMOdhwTy6Qg8ip1G5xaYrcjjSY155w/o=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmK24neTCw5n/IlL06iKPMsn5vHH38MnGB5Cn74
 zEmJH5zcXOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZituJwAKCRDBN2bmhouD
 15c5D/wKo7t1SBtqeeNDs4U0tuyIRMY0bKI5Luen2McymDX4vxNWoCowKQGuOBSxxe7M4fCxjU7
 rhdpj5W0LIHQwODHS9k056NOqXUId8lwYR20jN0s0AG4ATKra/0GSb4FXhyKtJxj4b1mt6Npoku
 +Lj3/4ETd804pyZRNHNIOFCWLduVaKsm+sJaoHI0lVS9MUolpQiQu8GJntiElFa66zHPGz0V1Y0
 wCzmXKa0/MrL9u8BzTTrhKZDDPkJ/Ph2D7LbRmP5IUErodE+dEV5j9ADsK/5KpWvoo58vIWmvwp
 qd+Nm2CwdLHTjEgwrmLVeGq+IUylQYvk4J4Xi2X11Dm/GnVaipBEm5GO8JHC2OnnFpzs60MTJoV
 LbLwHBHQpC6Z/FYyp2+v/20U+82im7uTMg2DT4sAzSfZ34TbkYZ07bXvi1GyyyNMWM2IFr1QP9/
 HYro7W8/4XI++iSG3TeUAUBDbUgWC+rRN4uftsXh5lqcZ/ECaflHiiV6jLZ9nNuipcg8yT/Cil2
 UQ+ObK45aafKJNWz5LqnlVbirIKdBvFYR5TGaI7u7so0IoVZEVSERfZiPxR4eGb3M54vCLcys8g
 Tb5OoaJhi0TrC3ZlZfg4SZ022AEioqjq0M5w8pkBVVcDA94E5peVa5qLQN0mrgxFdZYVlHBFcOX
 m/6Ze4nzrQlKo2w==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
const for increased code safety.

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/sof/imx/imx8m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
index 3e0b88002b4f..4ed415f04345 100644
--- a/sound/soc/sof/imx/imx8m.c
+++ b/sound/soc/sof/imx/imx8m.c
@@ -411,7 +411,7 @@ static int imx8m_dsp_suspend(struct snd_sof_dev *sdev, unsigned int target_state
 }
 
 /* i.MX8 ops */
-static struct snd_sof_dsp_ops sof_imx8m_ops = {
+static const struct snd_sof_dsp_ops sof_imx8m_ops = {
 	/* probe and remove */
 	.probe		= imx8m_probe,
 	.remove		= imx8m_remove,

-- 
2.43.0


