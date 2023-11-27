Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBBE7F9E60
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjK0LRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjK0LRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:17:46 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF21C18F;
        Mon, 27 Nov 2023 03:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1701083870;
        bh=GnVT0hiyn7TRSDmZz7FBYTKjVoHrPlsa0H3dZCecCEo=;
        h=From:To:Cc:Subject:Date:From;
        b=KxiLisXTDDkTUgkB74pMzkUlMMDLgbdJGDw/XcZNf8xCXCLuTBKYa67cdJO+ny2gH
         kZLXVhrOz4bR5NahPmu3IDjZgYB/GgBs3SRqe8b18g+YPX6xgY4yvkfc1A5z4A4uNK
         e2fzf7FMV/c37pGWbYjNpAqxIuHEXBKll+IdEVdoJ93gJ1zqrTIH06Y+Ruy9XdUUje
         xG8m1oVL650hAqYh0Zq/uj9WjtUva3Y4kMfPrH7Od/iU+N4vqEczldwJuu6drr2A1k
         HgjxXucbct4JovVvW6sAwoGLOkDzIotaF+H0Y+4JcIv5Bz8DYGl4hLhih4ySXcjWio
         WbGWoXeTgv7sw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sf33L3JxHz4wd2;
        Mon, 27 Nov 2023 22:17:50 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     brking@us.ibm.com
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] scsi: ipr: Remove obsolete check for old CPUs
Date:   Mon, 27 Nov 2023 22:17:40 +1100
Message-ID: <20231127111740.1288463-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPR driver has a routine to check whether it's running on certain
CPU versions and if so whether the adapter is supported on that CPU.

But none of the CPUs it checks for are supported by Linux anymore.

The most recent CPU it checks for is Power4+ which was removed in commit
471d7ff8b51b ("powerpc/64s: Remove POWER4 support").

So drop the check. That makes the "testmode" module paramter unused, so
remove it as well.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/scsi/ipr.c | 55 ----------------------------------------------
 1 file changed, 55 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 81e3d464d1f6..3819f7c42788 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -77,7 +77,6 @@
 static LIST_HEAD(ipr_ioa_head);
 static unsigned int ipr_log_level = IPR_DEFAULT_LOG_LEVEL;
 static unsigned int ipr_max_speed = 1;
-static int ipr_testmode = 0;
 static unsigned int ipr_fastfail = 0;
 static unsigned int ipr_transop_timeout = 0;
 static unsigned int ipr_debug = 0;
@@ -193,8 +192,6 @@ module_param_named(max_speed, ipr_max_speed, uint, 0);
 MODULE_PARM_DESC(max_speed, "Maximum bus speed (0-2). Default: 1=U160. Speeds: 0=80 MB/s, 1=U160, 2=U320");
 module_param_named(log_level, ipr_log_level, uint, 0);
 MODULE_PARM_DESC(log_level, "Set to 0 - 4 for increasing verbosity of device driver");
-module_param_named(testmode, ipr_testmode, int, 0);
-MODULE_PARM_DESC(testmode, "DANGEROUS!!! Allows unsupported configurations");
 module_param_named(fastfail, ipr_fastfail, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(fastfail, "Reduce timeouts and retries");
 module_param_named(transop_timeout, ipr_transop_timeout, int, 0);
@@ -6416,45 +6413,6 @@ static const struct scsi_host_template driver_template = {
 	.proc_name = IPR_NAME,
 };
 
-#ifdef CONFIG_PPC_PSERIES
-static const u16 ipr_blocked_processors[] = {
-	PVR_NORTHSTAR,
-	PVR_PULSAR,
-	PVR_POWER4,
-	PVR_ICESTAR,
-	PVR_SSTAR,
-	PVR_POWER4p,
-	PVR_630,
-	PVR_630p
-};
-
-/**
- * ipr_invalid_adapter - Determine if this adapter is supported on this hardware
- * @ioa_cfg:	ioa cfg struct
- *
- * Adapters that use Gemstone revision < 3.1 do not work reliably on
- * certain pSeries hardware. This function determines if the given
- * adapter is in one of these confgurations or not.
- *
- * Return value:
- * 	1 if adapter is not supported / 0 if adapter is supported
- **/
-static int ipr_invalid_adapter(struct ipr_ioa_cfg *ioa_cfg)
-{
-	int i;
-
-	if ((ioa_cfg->type == 0x5702) && (ioa_cfg->pdev->revision < 4)) {
-		for (i = 0; i < ARRAY_SIZE(ipr_blocked_processors); i++) {
-			if (pvr_version_is(ipr_blocked_processors[i]))
-				return 1;
-		}
-	}
-	return 0;
-}
-#else
-#define ipr_invalid_adapter(ioa_cfg) 0
-#endif
-
 /**
  * ipr_ioa_bringdown_done - IOA bring down completion.
  * @ipr_cmd:	ipr command struct
@@ -7385,19 +7343,6 @@ static int ipr_ioafp_page0_inquiry(struct ipr_cmnd *ipr_cmd)
 	type[4] = '\0';
 	ioa_cfg->type = simple_strtoul((char *)type, NULL, 16);
 
-	if (ipr_invalid_adapter(ioa_cfg)) {
-		dev_err(&ioa_cfg->pdev->dev,
-			"Adapter not supported in this hardware configuration.\n");
-
-		if (!ipr_testmode) {
-			ioa_cfg->reset_retries += IPR_NUM_RESET_RELOAD_RETRIES;
-			ipr_initiate_ioa_reset(ioa_cfg, IPR_SHUTDOWN_NONE);
-			list_add_tail(&ipr_cmd->queue,
-					&ioa_cfg->hrrq->hrrq_free_q);
-			return IPR_RC_JOB_RETURN;
-		}
-	}
-
 	ipr_cmd->job_step = ipr_ioafp_page3_inquiry;
 
 	ipr_ioafp_inquiry(ipr_cmd, 1, 0,
-- 
2.41.0

