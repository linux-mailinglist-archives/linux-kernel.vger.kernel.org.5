Return-Path: <linux-kernel+bounces-23415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFC282AC7B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760B61F23970
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45F314F6A;
	Thu, 11 Jan 2024 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Xhe1Vp8n"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC7314F60;
	Thu, 11 Jan 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704970370;
	bh=fshr/55h3wT+fevwdGwbnLEUOYH9vCJUJk2ISAPoJYk=;
	h=From:To:Cc:Subject:Date:From;
	b=Xhe1Vp8nV66TBCawvwAjnPaTLzQaQRdebTDUFoyaDaEdR+w7Q6enrQzLbXkJOxWa7
	 1VIqSTYMwjMLwjDtvnYwVkcUwI1l6LTGmCn5Iuy+3shh+mnUV05U1fiImxbTAoJ7px
	 GuuQKFn9e37GJeFxCTusXKaQ8Cw1uOqaDBBBFKtPcKvUqwRqF144BMDZToKUGwTGX3
	 dX9k4KqF+nAWHyqDnDqvpcMYpPBL5SH/3Osznm5XiaC8H929IbbCrlO5UzgpySdOST
	 F57IRWOqWplN9TmWYzEBEHQ5X/y1XBjepO72lrlQwqdPBrjvu8C/JEKP3YK6TGicUS
	 I3XClm5Z+cASA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CDD2237811D1;
	Thu, 11 Jan 2024 10:52:49 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: lgirdwood@gmail.com
Cc: broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ribalda@chromium.org,
	nicolas.ferre@microchip.com,
	u.kleine-koenig@pengutronix.de,
	kuninori.morimoto.gx@renesas.com,
	nfraprado@collabora.com,
	alsa-devel@alsa-project.org,
	trevor.wu@mediatek.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 0/7] ASoC: mediatek: AFE drivers cleanups
Date: Thu, 11 Jan 2024 11:52:40 +0100
Message-ID: <20240111105247.117766-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts MediaTek AFE drivers' probe functions to use
dev_err_probe() and devm functions where possible and, in some
cases, dropping the .remove_new() callback, reducing the size.

Cheers!

AngeloGioacchino Del Regno (7):
  ASoC: mediatek: mt8173-afe-pcm: Convert to devm_pm_runtime_enable()
  ASoC: mediatek: mt8173-afe-pcm: Use devm_snd_soc_register_component()
  ASoC: mediatek: mt8183-afe-pcm: Convert to devm_pm_runtime_enable()
  ASoC: mediatek: mt8183-afe-pcm: Simplify with dev_err_probe()
  ASoC: mediatek: mt8192-afe-pcm: Convert to devm_pm_runtime_enable()
  ASoC: mediatek: mt8192-afe-pcm: Simplify with dev_err_probe()
  ASoC: mediatek: mt8195-afe-pcm: Drop .remove_new() callback

 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c |  78 +++------------
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 108 +++++++--------------
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c |  95 ++++++------------
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c |  12 +--
 4 files changed, 81 insertions(+), 212 deletions(-)

-- 
2.43.0


