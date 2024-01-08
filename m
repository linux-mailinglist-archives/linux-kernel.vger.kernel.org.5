Return-Path: <linux-kernel+bounces-20106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA70827954
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF921C22E4E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC5455790;
	Mon,  8 Jan 2024 20:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fu3FyYNg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3780654BDA;
	Mon,  8 Jan 2024 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704746837;
	bh=UQ/Pqq9hCugSxC3Fzh31NRAczf6loqtAEVkRzY9ZrUY=;
	h=From:To:Cc:Subject:Date:From;
	b=fu3FyYNgD+idTI4piSZ17tN+M/ZavzrqZBkRgO1z+9KFmMqXzHO/8MaMHHeKbgKmT
	 FCunKCxfVFTFdoQar8AN/9ZqZr73MNkTPjR4aPHsgoeJMS3NuE0UjmZFmJZh9B/wfm
	 uBEtKjRtItys+DDipV5HuIPi+QxZbVslRP6BrQ25fHTV6u4sqn6rq+CbWBPIPNKJIu
	 Z7TIDqO1NBgHE+VnrVF1jYrZ+UsjsfAxgLF+mpZLRIqqcC8Nrg5QeSBRea5wf5wLY2
	 BeZvGKI5a1tuhoHWLF+B5uVf+5ch4VRy95pl7af70cunodjkUWc85q+yz1zoXVfAPQ
	 RwNDbkGikAX2Q==
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 924B33781475;
	Mon,  8 Jan 2024 20:47:12 +0000 (UTC)
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Mark Brown <broonie@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado=20via=20Alsa-devel?= <alsa-devel@alsa-project.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-sound@vger.kernel.org
Subject: [PATCH] ASoC: mediatek: mt8192: Check existence of dai_name before dereferencing
Date: Mon,  8 Jan 2024 17:44:58 -0300
Message-ID: <20240108204508.691739-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Following commit 13f58267cda3 ("ASoC: soc.h: don't create dummy
Component via COMP_DUMMY()"), the dai_name field is only populated for
dummy components after the card is registered. This causes a null
pointer dereference in the mt8192-mt6359 sound card driver's probe
function when searching for a dai_name among all the card's dai links.

Verify that the dai_name is non-null before passing it to strcmp. While
at it, also check that there's at least one codec.

Reported-by: "kernelci.org bot" <bot@kernelci.org>
Closes: https://linux.kernelci.org/test/case/id/6582cd6d992645c680e13478/
Fixes: 13f58267cda3 ("ASoC: soc.h: don't create dummy Component via COMP_DUMMY()")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index 5bd6addd1450..bfcb2c486c39 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -1208,7 +1208,8 @@ static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
 			dai_link->ignore = 0;
 		}
 
-		if (strcmp(dai_link->codecs[0].dai_name, RT1015_CODEC_DAI) == 0)
+		if (dai_link->num_codecs && dai_link->codecs[0].dai_name &&
+		    strcmp(dai_link->codecs[0].dai_name, RT1015_CODEC_DAI) == 0)
 			dai_link->ops = &mt8192_rt1015_i2s_ops;
 
 		if (!dai_link->platforms->name)
-- 
2.43.0


