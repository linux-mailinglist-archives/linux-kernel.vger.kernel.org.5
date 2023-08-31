Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DF178E7F5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244455AbjHaI1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242431AbjHaI1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:27:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51611185
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:27:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 112721F45E;
        Thu, 31 Aug 2023 08:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693470455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OZhklEGEsuDHuwqIknZUDngSvYVfmayPcE03PW+hzVc=;
        b=sOuOhh2LWh2FhjlLGPxe5MQWItO4ywskBvHbtdMNFce0bpBBWC1VklpQdwtxZABaI8lt0a
        19IFl6IdP2gqJ5msrWpHbkeS9HRHZld+V5CU/2WIRHCWpA+E74NA75iCcUth3Sd/co5wVd
        tbeESuoBvWYr+b5IMcWSUmnPsBREYog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693470455;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OZhklEGEsuDHuwqIknZUDngSvYVfmayPcE03PW+hzVc=;
        b=XoaPBzCadvAw364A8tzLBJM5fs4ojn6EFArnDw4v8jDPAvs/7Z3a4YDHL6R6KDknyQvSv/
        07JFyrBYQizkOQBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0212913587;
        Thu, 31 Aug 2023 08:27:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E6osAPdO8GS0dQAAMHmgww
        (envelope-from <fvogt@suse.de>); Thu, 31 Aug 2023 08:27:35 +0000
From:   Fabian Vogt <fvogt@suse.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Gabriel Somlo <somlo@cmu.edu>
Cc:     qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Subject: firmware: qemu_fw_cfg: Do not hard depend on CONFIG_HAS_IOPORT_MAP
Date:   Thu, 31 Aug 2023 10:27:34 +0200
Message-ID: <5965390.lOV4Wx5bFT@linux-e202.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms require CONFIG_NO_IOPORT_MAP=y but would also support
qemu_fw_cfg over MMIO. Currently the qemu_fw_cfg module can't be built for
those as it needs HAS_IOPORT_MAP=y for ioport remapping.

This patch allows to build the qemu_fw_cfg in those cases. If
CONFIG_HAS_IOPORT_MAP=n, qemu_fw_cfg is built without support for ioport
based access.

Signed-off-by: Fabian Vogt <fvogt@suse.de>
---
Applies on top of 6c1b980a7e79.

 drivers/firmware/Kconfig       | 1 -
 drivers/firmware/qemu_fw_cfg.c | 5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b59e3041fd62..f8aad7de8c72 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -156,7 +156,6 @@ config RASPBERRYPI_FIRMWARE
 config FW_CFG_SYSFS
 	tristate "QEMU fw_cfg device support in sysfs"
 	depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || SPARC || X86)
-	depends on HAS_IOPORT_MAP
 	default n
 	help
 	  Say Y or M here to enable the exporting of the QEMU firmware
diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index a69399a6b7c0..1d60ac74a403 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -258,6 +258,7 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
 			return -EFAULT;
 		}
 	} else {
+#ifdef CONFIG_HAS_IOPORT_MAP
 		if (!request_region(fw_cfg_p_base,
 				    fw_cfg_p_size, "fw_cfg_io"))
 			return -EBUSY;
@@ -266,6 +267,10 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
 			release_region(fw_cfg_p_base, fw_cfg_p_size);
 			return -EFAULT;
 		}
+#else
+		dev_err(&pdev->dev, "IO region given but CONFIG_HAS_IOPORT_MAP=n");
+		return -EINVAL;
+#endif
 	}
 
 	/* were custom register offsets provided (e.g. on the command line)? */
-- 
2.41.0


