Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1590E77A9E2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbjHMQXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjHMQXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:23:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10964226;
        Sun, 13 Aug 2023 09:15:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30A0663B53;
        Sun, 13 Aug 2023 16:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F82C433C7;
        Sun, 13 Aug 2023 16:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691943232;
        bh=xiTGrDSYlvcJnKr0wiRPk4nN3jl03MAp7/ZN2W90s8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DHRNDJ2FsEYZYe3eoaWwYp9T5/p9MVm7X36EpGuYRc9SEjm+NkPTFUaXhWF1lg3nL
         mDXWMiZmq5Wk2BPFR0b45DZgdDuY+iv0KzGi9vPs1lgJRtqV6c/meXj00ErJpuB0BD
         56+b5iY/JlOpT96YlQ5ABgVr4MRnuftrLuVT6xSTDaizzC7MsafGkx42EML+sPeJJZ
         0dan9dTzKT36QWiH13HIcKJ6xOOy1Vel9CTpgPF1FVPjQJma4ve8ljGJz+ftHEFSFE
         MmjohNYIxMUMXl8vqqMk9LKpI9z6rKrB1udiToQJDdvAB2p4wZJQCJIDtrf5iuPx6a
         qHxh+jhoIWf3Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 07/13] s390/dasd: use correct number of retries for ERP requests
Date:   Sun, 13 Aug 2023 12:13:11 -0400
Message-Id: <20230813161317.1087606-7-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813161317.1087606-1-sashal@kernel.org>
References: <20230813161317.1087606-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.291
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Haberland <sth@linux.ibm.com>

[ Upstream commit acea28a6b74f458defda7417d2217b051ba7d444 ]

If a DASD request fails an error recovery procedure (ERP) request might
be built as a copy of the original request to do error recovery.

The ERP request gets a number of retries assigned.
This number is always 256 no matter what other value might have been set
for the original request. This is not what is expected when a user
specifies a certain amount of retries for the device via sysfs.

Correctly use the number of retries of the original request for ERP
requests.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Link: https://lore.kernel.org/r/20230721193647.3889634-3-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd_3990_erp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index ee73b0607e47c..8598c792ded30 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -2436,7 +2436,7 @@ static struct dasd_ccw_req *dasd_3990_erp_add_erp(struct dasd_ccw_req *cqr)
 	erp->block    = cqr->block;
 	erp->magic    = cqr->magic;
 	erp->expires  = cqr->expires;
-	erp->retries  = 256;
+	erp->retries  = device->default_retries;
 	erp->buildclk = get_tod_clock();
 	erp->status = DASD_CQR_FILLED;
 
-- 
2.40.1

