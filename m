Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6897BCB0B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 02:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbjJHAvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 20:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbjJHAut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 20:50:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9491BF4;
        Sat,  7 Oct 2023 17:50:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40E4C433CB;
        Sun,  8 Oct 2023 00:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726204;
        bh=dQuFp9LbxT5HDqh2T4QVw+A5eVEt9TDxJ4S7un6epD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tSlsGw/HhdDsHL1fzPYWRRlIl2mYS05xHiOiZsXDKkTdIG70fAi/uA+k8Zx1Qhw6O
         IP+5s+mwxx+HZnccGSOSC7+J+apt+k3SmpgJ+SoENZ1ByFtsQT6RNiRf1JUm1JQf4e
         RAngplkAETgr5ieZKU98/Rh5qqZEu7+r/u9KJ8pgKgvf5URHVCa/kxYg/0O5fVo5JA
         VbF3bODONEAY3WK661W2gOPiIGHAcrASvkLAloEs7bQhDxqLNJBfNiCmaIGLJjxpyK
         iy/KjjDobW70ldmls1AkmZ/YiEyraLB+Isn+1nwumjy9cUrjBKKPegIw3GAiFQhvJc
         mfjrV3qnDKRGA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 08/10] ata: libata-core: Fix compilation warning in ata_dev_config_ncq()
Date:   Sat,  7 Oct 2023 20:49:47 -0400
Message-Id: <20231008004950.3768189-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008004950.3768189-1-sashal@kernel.org>
References: <20231008004950.3768189-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.134
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
index 025260b80a94c..ca7e887bad36d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2382,7 +2382,7 @@ static int ata_dev_config_lba(struct ata_device *dev)
 	struct ata_port *ap = dev->link->ap;
 	const u16 *id = dev->id;
 	const char *lba_desc;
-	char ncq_desc[24];
+	char ncq_desc[32];
 	int ret;
 
 	dev->flags |= ATA_DFLAG_LBA;
-- 
2.40.1

