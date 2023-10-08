Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971A17BCAE3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 02:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbjJHAuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 20:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbjJHAtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 20:49:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17171BF;
        Sat,  7 Oct 2023 17:49:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD58C433C7;
        Sun,  8 Oct 2023 00:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726165;
        bh=wtFSbLP5r9XsfArwr+pNSmLxwawv57lCaVruSDfsNCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NUihBYc98NOMbjuF2py7ZQziZ3IWm14Dh9rPx66QxRlW0v73BC5uHI1nMMcnbUrzC
         BQkNmZw7+UQAX+bZw6wfFV/X1i3Ap52AfFgbCgIm+YogLsb9tsmI3l5Wh5U8JoN5u9
         GoCS5TpnOnBe9Xo1ifHmL4Sz6buUC9EUxD+7/QRh+yipaEhFRTDnGVDDP5NvhxhnhD
         LYZoHeE7pHitNOte0VSmRy4rANMTGse4Cdpth/ZVY8EcOWrBC260cB5qQlMFbXUY3M
         EQea5rRaRgdSoTPIois11Rg5Wb/jbd0gDilFs9z7ByqtYZHFH/roW2DCcOdPcBTYmk
         ZMG4vLyykQEsg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 17/18] ata: libata-eh: Fix compilation warning in ata_eh_link_report()
Date:   Sat,  7 Oct 2023 20:48:51 -0400
Message-Id: <20231008004853.3767621-17-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008004853.3767621-1-sashal@kernel.org>
References: <20231008004853.3767621-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit 49728bdc702391902a473b9393f1620eea32acb0 ]

The 6 bytes length of the tries_buf string in ata_eh_link_report() is
too short and results in a gcc compilation warning with W-!:

drivers/ata/libata-eh.c: In function ‘ata_eh_link_report’:
drivers/ata/libata-eh.c:2371:59: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 4 [-Wformat-truncation=]
 2371 |                 snprintf(tries_buf, sizeof(tries_buf), " t%d",
      |                                                           ^~
drivers/ata/libata-eh.c:2371:56: note: directive argument in the range [-2147483648, 4]
 2371 |                 snprintf(tries_buf, sizeof(tries_buf), " t%d",
      |                                                        ^~~~~~
drivers/ata/libata-eh.c:2371:17: note: ‘snprintf’ output between 4 and 14 bytes into a destination of size 6
 2371 |                 snprintf(tries_buf, sizeof(tries_buf), " t%d",
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2372 |                          ap->eh_tries);
      |                          ~~~~~~~~~~~~~

Avoid this warning by increasing the string size to 16B.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-eh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 35e03679b0bfe..bf75b3af2d053 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2331,7 +2331,7 @@ static void ata_eh_link_report(struct ata_link *link)
 	struct ata_eh_context *ehc = &link->eh_context;
 	struct ata_queued_cmd *qc;
 	const char *frozen, *desc;
-	char tries_buf[6] = "";
+	char tries_buf[16] = "";
 	int tag, nr_failed = 0;
 
 	if (ehc->i.flags & ATA_EHI_QUIET)
-- 
2.40.1

