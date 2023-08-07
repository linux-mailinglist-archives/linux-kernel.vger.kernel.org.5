Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC177726F1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjHGOET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjHGODF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:03:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D9C2697;
        Mon,  7 Aug 2023 07:01:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 913E91FE02;
        Mon,  7 Aug 2023 14:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691416891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8YiVCjwWL8Hw6O2ccp24AagZioe0mi6UgFUQbptbfTQ=;
        b=ojHriN3JOY/bSBqLl4QSvaLU6jbFDGQGR0v2JeL2AKiZsLR7dRarRb97H4wY1Zrs6DMr9/
        HxLizwI6NeLgMFPwAnhRhlO95xOKpp1IyvNt7t4E7wbtCPvhFxLH2XRBxbB9qfPayWPavN
        OUqS7qiJt09MSsJ7Yts01g8YuV0PUQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691416891;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8YiVCjwWL8Hw6O2ccp24AagZioe0mi6UgFUQbptbfTQ=;
        b=Y+sP2eHxATKVQfT5cS0Uy/ZWbDN6cZQSzqvC0PksykMgKYZVWkPIXKZuxwhTmk4czYH6Qz
        +WpohGqTxSlVSTBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6128513910;
        Mon,  7 Aug 2023 14:01:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gq62Fjv50GQvLAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 07 Aug 2023 14:01:31 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tpm/tpm_tis: Disable interrupts for Lenovo Thinkpad E14 Gen 2 and 13s-IML
Date:   Mon,  7 Aug 2023 16:01:25 +0200
Message-Id: <20230807140125.18486-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like other Lenovo laptops, Thinkpad E14 Gen 2 and Thinkpad 13s-IML
also require to disable the tpm_tis interrupts for avoiding a boot
hang.

Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
Cc: <stable@vger.kernel.org> # v6.4+
Link: https://bugzilla.suse.com/show_bug.cgi?id=1213779
Signed-off-by: Takashi Iwai <tiwai@suse.de>

---
 drivers/char/tpm/tpm_tis.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index a98773ac2e55..0633823dc515 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -130,6 +130,22 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop (13th Gen Intel Core)"),
 		},
 	},
+	{
+		.callback = tpm_tis_disable_irq,
+		.ident = "ThinkPad E14 Gen 2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad E14 Gen 2"),
+		},
+	},
+	{
+		.callback = tpm_tis_disable_irq,
+		.ident = "ThinkBook 13s-IML",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ThinkBook 13s-IML"),
+		},
+	},
 	{
 		.callback = tpm_tis_disable_irq,
 		.ident = "ThinkPad T490s",
-- 
2.35.3

