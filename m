Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724E575A9AB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjGTI4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjGTIoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:44:02 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C471D269A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:44:01 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R65nn4lxyzBRDsM
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 16:43:57 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689842637; x=1692434638; bh=HQ5mIWPyQgiaiYiJ9muCewYTGSm
        cTxVH/CixYOAZjoU=; b=t9BqJUriJE4ftv/uIBFWr+LvsPon5wRqwFcfqAEsS1r
        3vxeG8rjKiQSETE66IKkZDg7nQqodj7f2/HJ8bbdwVQU5PYlrTKcnRuegO3cFBwM
        9DvL0VekE36r1Mn1FY+gPubgn7U9ki+8FFPRWuahexy5yRvhj9FroC8X6iqWzpEE
        lZhOZpmUeaeMwTeFXAJWoHzlOmpBtboUeLIJBsHN+lUfpJu3ULrRd6+yrUHarIrP
        pF9iK52LZxxTjm2Qe86ZH0HTY1glcautugIv71WJxGcc6ucwYNmeOrFGjq+OjXTa
        Kj44Knm+Fk0BtPluiDQAwh8l18MTpEveOLgMI6D8ePA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zBv9M4lDCoBM for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 16:43:57 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R65nn2H8HzBHXhQ;
        Thu, 20 Jul 2023 16:43:57 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 16:43:57 +0800
From:   sunran001@208suo.com
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: ipc4-topology: fix application of sizeof to
 pointer
In-Reply-To: <20230720073836.3285-1-xujianghui@cdjrlc.com>
References: <20230720073836.3285-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <74739aaaa05f52084757b526bc8348c8@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coccinelle check report:
./drivers/scsi/csiostor/csio_mb.c:1554:46-52: ERROR: application of
sizeof to pointer

Signed-off-by: Ran Sun <sunran001@208suo.com>
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
-				    swidget->num_tuples, sizeof(available_fmt), 1);
+				    swidget->num_tuples, sizeof(*available_fmt), 1);
  	if (ret) {
  		dev_err(scomp->dev, "Failed to parse audio format token count\n");
  		return ret;
