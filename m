Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55332763E09
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjGZSAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGZSAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:00:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739B1269E;
        Wed, 26 Jul 2023 11:00:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3120B1F74D;
        Wed, 26 Jul 2023 18:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690394440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TqlDrc5/V+1K3oBFV9SbyP3zzx8dsHJ2zSPzAn31Vhk=;
        b=XvIRLju9S7fZKtnKyeQhJqFxHqmNrE9C01YY14wyR3N63wGOPB5yD3lu1pnexwHCo6F+D9
        2aLbyUGLXIgUrL/lduMFAavRjDQpLZMieCWVUVFDEgOPo7+85+LjeNbbdEhA0iFcqgb1pm
        TDEsz+r74BUK/HZxx2hRfmxM4u+l0iE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690394440;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TqlDrc5/V+1K3oBFV9SbyP3zzx8dsHJ2zSPzAn31Vhk=;
        b=IfsSdckhp8yxUmpOvDZZZKR8c2m/xpPGGQ/0716R2Ccu31/Q9+reEi8vOF02CIQ1gWVX1S
        1VHphGH7xvi4bOCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1E78139BD;
        Wed, 26 Jul 2023 18:00:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gCEBOkdfwWQGcQAAMHmgww
        (envelope-from <tiwai@suse.de>); Wed, 26 Jul 2023 18:00:39 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm/tpm_tis: Disable interrupts for TUXEDO InfinityBook S 15/17 Gen7
Date:   Wed, 26 Jul 2023 20:00:35 +0200
Message-Id: <20230726180035.14511-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TUXEDO InfinityBook S 15/17 Gen7 suffers from an IRQ problem on
tpm_tis like a few other laptops.  Add an entry for the workaround.

Cc: stable@vger.kernel.org
Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
Link: https://bugzilla.suse.com/show_bug.cgi?id=1213645
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/char/tpm/tpm_tis.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index cc42cf3de960..a98773ac2e55 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -162,6 +162,14 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L590"),
 		},
 	},
+	{
+		.callback = tpm_tis_disable_irq,
+		.ident = "TUXEDO InfinityBook S 15/17 Gen7",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TUXEDO InfinityBook S 15/17 Gen7"),
+		},
+	},
 	{
 		.callback = tpm_tis_disable_irq,
 		.ident = "UPX-TGL",
-- 
2.35.3

