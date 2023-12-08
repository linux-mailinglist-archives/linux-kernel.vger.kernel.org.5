Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2366180AC58
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbjLHSoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHSoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:44:20 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9E211F;
        Fri,  8 Dec 2023 10:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1702061065;
        bh=qaCnYPlBMIzaa8Uz/9BoJw942PlrsJdBc0gloYteYG0=;
        h=Message-ID:Subject:From:To:Date:From;
        b=EhdL9GscnNzI6KeaYHVCqN7Y6GSEnGsVY6peYKiwYi2LS9GwEAIhXNtmGKzHF8KPd
         g5M9t0tfpLB+Zpz0zW2jASrBuhelKs3PjWLBPW+/+4ddg+o7ICQtHE4Bc2S6ImvEc0
         3emygQYEuiZbcYRWpw1KiS8a8ZlYgP247C85u30g=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7FCBA1281EF3;
        Fri,  8 Dec 2023 13:44:25 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id W3mO3yodjRzM; Fri,  8 Dec 2023 13:44:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1702061065;
        bh=qaCnYPlBMIzaa8Uz/9BoJw942PlrsJdBc0gloYteYG0=;
        h=Message-ID:Subject:From:To:Date:From;
        b=EhdL9GscnNzI6KeaYHVCqN7Y6GSEnGsVY6peYKiwYi2LS9GwEAIhXNtmGKzHF8KPd
         g5M9t0tfpLB+Zpz0zW2jASrBuhelKs3PjWLBPW+/+4ddg+o7ICQtHE4Bc2S6ImvEc0
         3emygQYEuiZbcYRWpw1KiS8a8ZlYgP247C85u30g=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C6FA312817A4;
        Fri,  8 Dec 2023 13:44:24 -0500 (EST)
Message-ID: <04e6cd5c53b77f7cf01df448525709f1eb7b7712.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.7-rc4
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 08 Dec 2023 13:44:22 -0500
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

One tiny fix to the be2iscsi driver fixing a memory leak in an error
leg.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Dinghao Liu (1):
      scsi: be2iscsi: Fix a memleak in beiscsi_init_wrb_handle()

And the diffstat:

 drivers/scsi/be2iscsi/be_main.c | 1 +
 1 file changed, 1 insertion(+)

With full diff below.

James

---

diff --git a/drivers/scsi/be2iscsi/be_main.c
b/drivers/scsi/be2iscsi/be_main.c
index e48f14ad6dfd..06acb5ff609e 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -2710,6 +2710,7 @@ static int beiscsi_init_wrb_handle(struct
beiscsi_hba *phba)
 		kfree(pwrb_context->pwrb_handle_base);
 		kfree(pwrb_context->pwrb_handle_basestd);
 	}
+	kfree(phwi_ctxt->be_wrbq);
 	return -ENOMEM;
 }
 

