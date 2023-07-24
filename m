Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4A675FFB1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjGXTQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGXTQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:16:55 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA21E10F7;
        Mon, 24 Jul 2023 12:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1690226211;
        bh=64pZcItTjZxIjDEl8EzEjacmRIVQb6Kl/2RNtm+3W3o=;
        h=Message-ID:Subject:From:To:Date:From;
        b=qKdPPK5SWzbg6WweegJVPDc+Y14TqL+xjdi2NAAyaPnKlINuO2LVdAJtG3j1y+8qb
         flzU/ZpZSHJeosLdho0eb8gGduWqm1q1MOJR4QdQgWxzbmVyM1BjmGALwIhPXOvu7j
         7qr5WH1ClnTJPI3SWLD1sdEDB3nLABEvUrGh4bAk=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D439A128605E;
        Mon, 24 Jul 2023 15:16:51 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id C0372O34OdMU; Mon, 24 Jul 2023 15:16:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1690226209;
        bh=64pZcItTjZxIjDEl8EzEjacmRIVQb6Kl/2RNtm+3W3o=;
        h=Message-ID:Subject:From:To:Date:From;
        b=JAwdcEEyF8qhlBRdqM4TQyqzai8kydFBA5oKexXMNAy2J8yww4cZt4nKQyboPAgLt
         mWM8SXpt/m8sPX+3+XqAUFuxrvhkTZBqHBgmUnRh25yVamP9iR4nxno58zLFWSLVKb
         5k77VmlanMLliPfinv2+0r8DC9s8d4yMDtBeAVBs=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 60AA11281F5F;
        Mon, 24 Jul 2023 15:16:49 -0400 (EDT)
Message-ID: <d75dc295e6ddaebc988f5af3ad6d12fa96948f5e.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.5-rc3
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 24 Jul 2023 15:16:47 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Single fix for a potential regression over a misunderstanding of the
blk_get_queue() api.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Yu Kuai (1):
      scsi: sg: Fix checking return value of blk_get_queue()

And the diffstat:

 drivers/scsi/sg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 89fa046c7158..0d8afffd1683 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1497,9 +1497,10 @@ sg_add_device(struct device *cl_dev)
 	int error;
 	unsigned long iflags;
 
-	error = blk_get_queue(scsidp->request_queue);
-	if (error)
-		return error;
+	if (!blk_get_queue(scsidp->request_queue)) {
+		pr_warn("%s: get scsi_device queue failed\n",
__func__);
+		return -ENODEV;
+	}
 
 	error = -ENOMEM;
 	cdev = cdev_alloc();

