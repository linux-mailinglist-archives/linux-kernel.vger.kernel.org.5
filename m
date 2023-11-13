Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAD07E9F14
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjKMOqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjKMOpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:45:54 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B1A19AD;
        Mon, 13 Nov 2023 06:45:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 314712187C;
        Mon, 13 Nov 2023 14:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1699886724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=C55/Qkp749YOdFLW3Ql7AV3TyMx7ZOja0OEUL1O7cmw=;
        b=qF9JMBBPs6ELBULaJOXIQpMdwXEebNyty/ILRRrgEWaAkekhfn9984wQY7H6/cBJC+bZAE
        Zg4Fbai+9c8354J73virj+hNnWpkzFP4OQxSEINqwU+LfokvIO65p4+e6Vf2MmcGc2QENO
        5A2JFHjJRc86q/DoCgcxY21Jo4DlYqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1699886724;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=C55/Qkp749YOdFLW3Ql7AV3TyMx7ZOja0OEUL1O7cmw=;
        b=5IDGdCbNOcZw4YEcqrXFOuDhcXXlLZTpdU/bEj2+Qwa1iJdVEBcvyWfBzZq5VYQwN0+vNW
        D6DGVF2logXv5JCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2E5613398;
        Mon, 13 Nov 2023 14:45:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oS+aOYM2UmX/MwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 13 Nov 2023 14:45:23 +0000
Date:   Mon, 13 Nov 2023 15:45:22 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mips@vger.kernel.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: |PATCH] stmmac: dwmac-loongson: Add architecture dependency
Message-ID: <20231113154522.0bca3521@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only present the DWMAC_LOONGSON option on architectures where it can
actually be used.

This follows the same logic as the DWMAC_INTEL option.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Keguang Zhang <keguang.zhang@gmail.com>
---
I'm not familiar with the hardware, so please let me know if the
dependency needs to be adjusted somehow.

 drivers/net/ethernet/stmicro/stmmac/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-6.6.orig/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ linux-6.6/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -269,7 +269,7 @@ config DWMAC_INTEL
 config DWMAC_LOONGSON
 	tristate "Loongson PCI DWMAC support"
 	default MACH_LOONGSON64
-	depends on STMMAC_ETH && PCI
+	depends on MACH_LOONGSON64 && STMMAC_ETH && PCI
 	depends on COMMON_CLK
 	help
 	  This selects the LOONGSON PCI bus support for the stmmac driver,


-- 
Jean Delvare
SUSE L3 Support
