Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFF5758C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjGSDf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjGSDfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:35:00 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AC419BC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 20:34:49 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5KHP2r2wzCQYDr
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:18:24 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689733104; x=1692325105; bh=8Zl0vZY76tBdb/jVDtCmxFdg39w
        CDc1sNz0Rki5WdqA=; b=WKCtPGcNs5xGwHs0dm6dAYZY6dXEXdzZOm+LfQP+5v0
        kcj7DtaugDzH69Jlc8392Wl5jxFRXXbekaGdGxYNDNhGcOr3W4NtXZvja/plDRvf
        sawrQN1cU+siNUT5+DeRrer8xe7r8xoB9VTkz5DKwN2oMcDUgFxsvc5AlXbCG7oh
        uonneVhrDZRCvN04dqNJCYWKwaq8giehEgQ7RCLNWN7zM23rmFNvTJdboibxgTJ/
        4EyK5NkEPo5+h/6TpoMSuxc7o3iZwjZ0qblXojjGJru8rT9iTBFnSBbjGV0I4CvJ
        GUfx9Wc+WTQ1hsP4CAEG+Y0yQL+FSV8ly8votfInyOQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZURMCrdPUuwF for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 10:18:24 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5K5n6N6RzC2dDY;
        Wed, 19 Jul 2023 10:10:05 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 10:10:05 +0800
From:   wuyonggang001@208suo.com
To:     perex@perex.cz, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: ipc4-topology: Fix application of sizeof to
 pointer
In-Reply-To: <20230719015525.48613-1-zhanglibing@cdjrlc.com>
References: <20230719015525.48613-1-zhanglibing@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <ff40e45ed02be9e1a7144af259509689@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sizeof is being applied to the pointer ptr, not the integer it points 
to.

Eliminate the following error(s):
./sound/soc/sof/ipc4-topology.c:221:29-35: ERROR: application of sizeof 
to pointer

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  sound/soc/sof/ipc4-topology.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-topology.c 
b/sound/soc/sof/ipc4-topology.c
index a4e1a70b607d..2dbe87dbd239 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -218,7 +218,7 @@ static int sof_ipc4_get_audio_fmt(struct 
snd_soc_component *scomp,

      ret = sof_update_ipc_object(scomp, available_fmt,
                      SOF_AUDIO_FMT_NUM_TOKENS, swidget->tuples,
-                    swidget->num_tuples, sizeof(available_fmt), 1);
+                    swidget->num_tuples, sizeof(*available_fmt), 1);
      if (ret) {
          dev_err(scomp->dev, "Failed to parse audio format token 
count\n");
          return ret;
