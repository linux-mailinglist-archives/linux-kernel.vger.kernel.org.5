Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B01A751AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjGMICW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjGMIBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:01:46 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DBE30F8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:00:24 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb87828386so127596e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689235205; x=1689840005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f23IFSdAOOx9PAA+0aLReuK2qCBP8wxWyzhLV70mA1Y=;
        b=ZPCjuNgzjHKy2ukXiMpF5+1SaokuO4SFHcj6+qof6IjynhPZbDizhhjdWOE0RpuNPR
         NhghNqr7XvvXoxL9KbOnd9NKm+a3waju4+jxeXmyICV7qkn5Hay6z5+3dHFDtwmG5flN
         wLa4R3ocItGUmtWTw7j2PCiF9lzuxFIuJFRVCA54nmFogl5IGt51PPsNZWIxWOT/2Ggo
         4jHKcLNDQxYzqViUb52biOOzzXZZyI5fkkUX2K9xc9xB166kLY/tJzbtDQzdWRStlF1m
         t8qapuor1wm5GWV5FFM/bjDXG4tLmpmQoxzihdCdls6rnKiy0zyjSCvlxUp6FPnzpwIt
         pouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689235205; x=1689840005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f23IFSdAOOx9PAA+0aLReuK2qCBP8wxWyzhLV70mA1Y=;
        b=jQIk8E3LsLTgs/pnfeBtSweUskvDirX0DHS3YjF5AWCxs1ObIU1+Wq+qxd7ThGbk4a
         D4yupmnVfjUH7/Q9zAlq8Bg6C0uu5v6CbVFFtfMUCTbbPIhiS/P9PxJonX4bl71kQarl
         WJXOKaaIwdZiS82i+ilgCw+C3dfDOWTNAtWsQG1qJG4kNNYDXkIewaHaBZnQuuTrq2hF
         ajXb7fm8dOXbg/BiVwHvl1iPiMli3UOkPYVSUDNxIj0lG9Gc2twR8ajjWGLdIUiu5Dup
         oeFZKtGb2XTRlb/13lSoVeUIYXC/9+fSow+sDJVsDRybhSwxqVycTLAyBCk6oo3ppgMb
         o2XA==
X-Gm-Message-State: ABy/qLbxvhUlpYrSvUGVvbboCuIP6/Dby1C9fdctZekEeS4cwQIBB3SU
        ZyitReZX6hUBh0QTcGxPg8RP68XApqILRf/I
X-Google-Smtp-Source: APBJJlGtg3kc9cR2gS2y8xggbKx8I5ncgNvVW0HhONStlpTat/Dts17uh0AzUS7JnmEXKghRuez/yw==
X-Received: by 2002:ac2:53ad:0:b0:4fa:73ea:aa2d with SMTP id j13-20020ac253ad000000b004fa73eaaa2dmr487312lfh.4.1689235204577;
        Thu, 13 Jul 2023 01:00:04 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([178.160.196.94])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25288000000b004fb8c0f247fsm1011385lfm.129.2023.07.13.01.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 01:00:04 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ALSA: pcmtest: Add 'open' PCM callback error injection
Date:   Thu, 13 Jul 2023 11:59:52 +0400
Message-Id: <20230713075953.13692-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend 'pcmtest' virtual driver with 'open' callback error injection
functionality, as it already can inject errors into other PCM callbacks.
Add module parameter which enables EBUSY error injection in the 'open'
PCM callback.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- Split changes in the patch into two different patches

 sound/drivers/pcmtest.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/drivers/pcmtest.c b/sound/drivers/pcmtest.c
index 291e7fe47893..e74c523e49eb 100644
--- a/sound/drivers/pcmtest.c
+++ b/sound/drivers/pcmtest.c
@@ -65,6 +65,7 @@ static int inject_delay;
 static bool inject_hwpars_err;
 static bool inject_prepare_err;
 static bool inject_trigger_err;
+static bool inject_open_err;
 
 static short fill_mode = FILL_MODE_PAT;
 
@@ -88,6 +89,9 @@ module_param(inject_prepare_err, bool, 0600);
 MODULE_PARM_DESC(inject_prepare_err, "Inject EINVAL error in the 'prepare' callback");
 module_param(inject_trigger_err, bool, 0600);
 MODULE_PARM_DESC(inject_trigger_err, "Inject EINVAL error in the 'trigger' callback");
+module_param(inject_open_err, bool, 0600);
+MODULE_PARM_DESC(inject_open_err, "Inject EBUSY error in the 'open' callback");
+
 
 struct pcmtst {
 	struct snd_pcm *pcm;
@@ -364,6 +368,9 @@ static int snd_pcmtst_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct pcmtst_buf_iter *v_iter;
 
+	if (inject_open_err)
+		return -EBUSY;
+
 	v_iter = kzalloc(sizeof(*v_iter), GFP_KERNEL);
 	if (!v_iter)
 		return -ENOMEM;
-- 
2.34.1

