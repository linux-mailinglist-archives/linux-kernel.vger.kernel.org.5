Return-Path: <linux-kernel+bounces-161724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2568B502E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237242814AB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A11CBE62;
	Mon, 29 Apr 2024 04:24:24 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6540C946C;
	Mon, 29 Apr 2024 04:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714364663; cv=none; b=X+3Og/tJzkV78SVlH9od0QaB3boI/4EO0kLlekQl34D0cijdLLjO8klY9uNNSKxS1AF+Es49Ny7f2bw2HspY89Q0eBCtXOzU2SEGJPAqgVVVJe7LotdaloxJcfPllYnOGefil90L5YrHfwxpkEx/IzwemQLcqnRlBjFfS1Lb8Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714364663; c=relaxed/simple;
	bh=JGOwRwb3wGY35/7bkooHaUwoAyvkcfcIq1Fea0jPVvo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HW9jgnhaxgcdQEQj5SNe+gOX8JruoHXhICXkjItVhrXagdUBa2qEC08h3kh0+Cv+HtOL0xEpfvqFaoQCARCzfsubZ5B+SF/M1bs5uQ+XOZZBlHTIYkZmV7X6ovBD0vaVy2OOUHcVL/v0GZpCjl6Hsg3ESWty097W3HpFZ2Js0HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowABnbRnkIC9mz_ISAQ--.33589S2;
	Mon, 29 Apr 2024 12:24:05 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: cezary.rojewski@intel.com,
	pierre-louis.bossart@linux.intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	maarten.lankhorst@linux.intel.com,
	amadeuszx.slawinski@linux.intel.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ASoC: intel: skylake: Add check for dma_set_max_seg_size
Date: Mon, 29 Apr 2024 12:23:20 +0800
Message-Id: <20240429042320.2150567-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnbRnkIC9mz_ISAQ--.33589S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xry3uF47GrW8Xr4rZr47Jwb_yoWDXrX_Kw
	n5G3s5Wa4UW3yI9wnrKr43CF42qws7ZFyDXFyvq3WfA343GrZ8GFWvqFnruFWku34Fqry0
	v3ZIvrWDC348XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUj_-BtUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add check for the return value of dma_set_max_seg_size() and return
the error if it fails in order to catch the error.

Fixes: c22a8086b384 ("ASoC: intel: skylake: Set max DMA segment size")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 sound/soc/intel/skylake/skl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 117125187793..8edc13795462 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -943,7 +943,9 @@ static int skl_first_init(struct hdac_bus *bus)
 	/* allow 64bit DMA address if supported by H/W */
 	if (dma_set_mask_and_coherent(bus->dev, DMA_BIT_MASK(64)))
 		dma_set_mask_and_coherent(bus->dev, DMA_BIT_MASK(32));
-	dma_set_max_seg_size(bus->dev, UINT_MAX);
+	err = dma_set_max_seg_size(bus->dev, UINT_MAX);
+	if (err)
+		return err;
 
 	/* initialize streams */
 	snd_hdac_ext_stream_init_all
-- 
2.25.1


