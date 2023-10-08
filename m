Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB347BCADD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 02:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjJHAt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 20:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbjJHAtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 20:49:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DD41AD;
        Sat,  7 Oct 2023 17:49:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592DAC433CA;
        Sun,  8 Oct 2023 00:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726164;
        bh=8dzV7F0lp1v/etKjKPjfl9O2WGcBkdPyPCCANMJVpLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AFb1WeoCaAkVIdmJ8X2gog8lOnbxvr565RL2f9VZLWLuZiND4jWHxeNY5LMj0aixs
         pAoG35gc5uSD2NmEB0p7trYa7BjAv+y5vD8DNms+rqFsTHtkMpmBxJFZjiYSeP/DqW
         eXjCOuAO8oohVxFwcft04IFoh+gxVwlClwSnUdmOwi7oVDqgEk473RWLXOARfTPC7O
         Hk/1/tvSlVot+03/rbABxD6cuh7yj/aFSzO8TB3DQ+VY0XkgtxQsf5MH3Di31Zx5XH
         5/Acly/vu4orWkQKTGdhILA9F4t05P72o5qX8elR1tZWkLmntILQeT0wXlG08pzUpW
         ZVms/aJ79n5JQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 16/18] ata: libata-core: Fix compilation warning in ata_dev_config_ncq()
Date:   Sat,  7 Oct 2023 20:48:50 -0400
Message-Id: <20231008004853.3767621-16-sashal@kernel.org>
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

[ Upstream commit ed518d9ba980dc0d27c7d1dea1e627ba001d1977 ]

The 24 bytes length allocated to the ncq_desc string in
ata_dev_config_lba() for ata_dev_config_ncq() to use is too short,
causing the following gcc compilation warnings when compiling with W=1:

drivers/ata/libata-core.c: In function ‘ata_dev_configure’:
drivers/ata/libata-core.c:2378:56: warning: ‘%d’ directive output may be truncated writing between 1 and 2 bytes into a region of size between 1 and 11 [-Wformat-truncation=]
 2378 |                 snprintf(desc, desc_sz, "NCQ (depth %d/%d)%s", hdepth,
      |                                                        ^~
In function ‘ata_dev_config_ncq’,
    inlined from ‘ata_dev_config_lba’ at drivers/ata/libata-core.c:2649:8,
    inlined from ‘ata_dev_configure’ at drivers/ata/libata-core.c:2952:9:
drivers/ata/libata-core.c:2378:41: note: directive argument in the range [1, 32]
 2378 |                 snprintf(desc, desc_sz, "NCQ (depth %d/%d)%s", hdepth,
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/ata/libata-core.c:2378:17: note: ‘snprintf’ output between 16 and 31 bytes into a destination of size 24
 2378 |                 snprintf(desc, desc_sz, "NCQ (depth %d/%d)%s", hdepth,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2379 |                         ddepth, aa_desc);
      |                         ~~~~~~~~~~~~~~~~

Avoid these warnings and the potential truncation by changing the size
of the ncq_desc string to 32 characters.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 79d02eb4e4797..f03612f07b16c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2534,7 +2534,7 @@ static int ata_dev_config_lba(struct ata_device *dev)
 {
 	const u16 *id = dev->id;
 	const char *lba_desc;
-	char ncq_desc[24];
+	char ncq_desc[32];
 	int ret;
 
 	dev->flags |= ATA_DFLAG_LBA;
-- 
2.40.1

