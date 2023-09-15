Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742CB7A13C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 04:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjIOCT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 22:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjIOCT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:19:27 -0400
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7E11BEB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 19:19:22 -0700 (PDT)
Received: from localhost (unknown [124.16.138.129])
        by APP-03 (Coremail) with SMTP id rQCowAAXH6MMvwNlW4gRDQ--.10658S2;
        Fri, 15 Sep 2023 10:18:53 +0800 (CST)
From:   Chen Ni <nichen@iscas.ac.cn>
To:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, kuninori.morimoto.gx@renesas.com,
        brent.lu@intel.com, amadeuszx.slawinski@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ASoC: hdaudio.c: Add missing check for devm_kstrdup
Date:   Fri, 15 Sep 2023 02:13:44 +0000
Message-Id: <20230915021344.3078-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXH6MMvwNlW4gRDQ--.10658S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr18KryUtF1ftr4kAF4rAFb_yoWfKrX_Cw
        4kCa1kuFyDXrsagw4qy3ySk3WFg3W7CFyUtr95tF9rA3s5Jw43Kr13trn5uay8XrZ2yr45
        ZF1qgr4xtr9rJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbVAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x0JUHWlkUUUUU=
X-Originating-IP: [124.16.138.129]
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of the potential failure of the devm_kstrdup(), the 
dl[i].codecs->name could be NULL.
Therefore, we need to check it and return -ENOMEM in order to transfer
the error.

Fixes: 97030a43371e ("ASoC: Intel: avs: Add HDAudio machine board")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 sound/soc/intel/avs/boards/hdaudio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/avs/boards/hdaudio.c b/sound/soc/intel/avs/boards/hdaudio.c
index cb00bc86ac94..8876558f19a1 100644
--- a/sound/soc/intel/avs/boards/hdaudio.c
+++ b/sound/soc/intel/avs/boards/hdaudio.c
@@ -55,6 +55,9 @@ static int avs_create_dai_links(struct device *dev, struct hda_codec *codec, int
 			return -ENOMEM;
 
 		dl[i].codecs->name = devm_kstrdup(dev, cname, GFP_KERNEL);
+		if (!dl[i].codecs->name)
+			return -ENOMEM;
+
 		dl[i].codecs->dai_name = pcm->name;
 		dl[i].num_codecs = 1;
 		dl[i].num_cpus = 1;
-- 
2.25.1

