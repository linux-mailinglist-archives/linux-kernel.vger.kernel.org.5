Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B263E7BCB24
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 02:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbjJHAwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 20:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbjJHAv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 20:51:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618A91738;
        Sat,  7 Oct 2023 17:51:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5C2C433CC;
        Sun,  8 Oct 2023 00:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726250;
        bh=6p7Galb7kPamhmOrQdg5k+pQUW0lZQ1Xtjgledyx02o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dpx0X1EZIcftBq6gd8+572VLLCijY4CuR/QgnQ6ZrtcoemRoJIq83w3Tf2sspnUyD
         OvU3y5QZAycN/8HJYfUiqbkljL53/s2m/6OceQd1nFkL+rV7QVb6dcgBuVntAIsBmV
         q6VEjluj1gL9DEmkYGGghrGMafYQQZeFSlWDiDIZPMR15TW5ZXkA5V/s+bETCTQQd2
         gF/x3CuQ3VrxE0hfCrMUTMqBWOJpKDTLjPwJukl4GJG/Kp43cLDT6egdUIyjvpfnhu
         cwsSRzAA0YkI80ByphQic0x7ai8EcB0YFQxBuHwdpiZ/e0GBAwetZ2idrQpuCsp1X1
         jqVkmqnlOKM1g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 7/8] ata: libata-eh: Fix compilation warning in ata_eh_link_report()
Date:   Sat,  7 Oct 2023 20:50:37 -0400
Message-Id: <20231008005039.3768522-7-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008005039.3768522-1-sashal@kernel.org>
References: <20231008005039.3768522-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.295
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
index fcc3d7985762a..d4bbcec2d7219 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2443,7 +2443,7 @@ static void ata_eh_link_report(struct ata_link *link)
 	struct ata_eh_context *ehc = &link->eh_context;
 	struct ata_queued_cmd *qc;
 	const char *frozen, *desc;
-	char tries_buf[6] = "";
+	char tries_buf[16] = "";
 	int tag, nr_failed = 0;
 
 	if (ehc->i.flags & ATA_EHI_QUIET)
-- 
2.40.1

