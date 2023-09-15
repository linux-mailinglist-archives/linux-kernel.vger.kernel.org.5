Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21197A26E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbjIOTIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236990AbjIOTIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:08:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE7BB2;
        Fri, 15 Sep 2023 12:08:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4FFC433C9;
        Fri, 15 Sep 2023 19:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694804897;
        bh=MyIJinpQ9MRMn81ExQ9ajAd6WI7sU/Hkeyd+BcDwjgM=;
        h=Date:From:To:Cc:Subject:From;
        b=gYy38NgDEaxdxsygoAP+2/quW8rTNMyRpJP9ZV8TtK+g5Y5u0QXK1UTwRMjbwk8Gz
         XANgzlbvILid7tntD8XrkILDhzG8La55yDL8I9VW2nMh0CAvBxKoCC72EJZlWuDfbS
         R6P/JlkAL+PZbhxiQFlm3lBN/9NXAGye5UD+DJ1n0hdLE/CPGjDxAl6I1wNBmYwraW
         Knm0vmboBjTLurGoatMl48Nr1+bWEfcPBBUw5Y5D6rLzt+U4fWGs8HzKHBzyvbUhU2
         5IlYhZPOSckqWgsP3grA4OJE/G+1aO6xdYnq+rrEzHBEd/6WqK0AU5zPhLHxgr/8TJ
         RNEs8sBPAwZGg==
Date:   Fri, 15 Sep 2023 13:09:11 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] ASoC: SOF: ipc4-topology: Use size_add() in call to
 struct_size()
Message-ID: <ZQSr15AYJpDpipg6@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If, for any reason, the open-coded arithmetic causes a wraparound,
the protection that `struct_size()` adds against potential integer
overflows is defeated. Fix this by hardening call to `struct_size()`
with `size_add()`.

Fixes: f9efae954905 ("ASoC: SOF: ipc4-topology: Add support for base config extension")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/soc/sof/ipc4-topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index f2a30cd31378..2a19dd022aaf 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -895,7 +895,8 @@ static int sof_ipc4_widget_setup_comp_process(struct snd_sof_widget *swidget)
 	if (process->init_config == SOF_IPC4_MODULE_INIT_CONFIG_TYPE_BASE_CFG_WITH_EXT) {
 		struct sof_ipc4_base_module_cfg_ext *base_cfg_ext;
 		u32 ext_size = struct_size(base_cfg_ext, pin_formats,
-						swidget->num_input_pins + swidget->num_output_pins);
+					   size_add(swidget->num_input_pins,
+						    swidget->num_output_pins));
 
 		base_cfg_ext = kzalloc(ext_size, GFP_KERNEL);
 		if (!base_cfg_ext) {
-- 
2.34.1

