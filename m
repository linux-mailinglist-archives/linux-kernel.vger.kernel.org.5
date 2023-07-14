Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066C0753B94
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbjGNNNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbjGNNNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:13:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B2F30EB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:13:45 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8ad907ba4so11087025ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689340424; x=1691932424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lPSms7Svt0v1FhaYrBtasQxf1zX/2vOpkMaaCXfzVv8=;
        b=bNQIefppjIKFx2HPNJdWZwzu4OATM5y1y4LiD6TulYlcu56jrK+c5SB7HqUXz9pG9/
         hDVMAZg6iKi7PoVjsiB7rc1CcXKhawfmWm8dazwFZLsmnzUqAkXmFIANnx82k/t07rzb
         MJ91IlNG8xCEdVeCXIOPO9GiczWZjAAvguQ7H1RdSGd0Q9a6VtHYIH10dmykKYrMuBsT
         0PT5jvXjsMeyYhiXDacDPRG1vZ94QnpiRMbNqZKp08wMef9f5NwWoiFq3mal6w+KsNCK
         3US3dBBZqKyK33isSGsIP6cPmmLInGhg/7JRDVWO8iEWXq5mUXj7DOGd8RQxDqIee9gj
         4jzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689340424; x=1691932424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPSms7Svt0v1FhaYrBtasQxf1zX/2vOpkMaaCXfzVv8=;
        b=Mo5fPlLYdv/7CPKaDo4dIovUPN/8NjWlZWCvMUWef9hkkacIqqzWesavJJumnb7zgA
         VD80ABTRu8oE4qUz3FjjCjI7RnZ8KROYRuvwwD5PN5F07hCz6ZjQh1O3KKnvNRS//l9h
         +HZAHcmoeypPe3XVoRWqd8Uw7NFd1tPAtCYwmaqP0QpssNbHiqRwFfkxlnGMKR8CnidR
         bWihjxELDJ3h3ASkwXKls5hIWVewI8bSnHzSUUn8/9DhSA8R1yRC8he1Crs1i6cq7ZEg
         X96upDA5uYs5bPatulS4BjVp76FWzzx0Dhy4j65fqeYSDcOIxvqFCr1yfkxJvt3ThtD1
         cgBw==
X-Gm-Message-State: ABy/qLbDSN0GIy9LaEg8gfpSf0mSa7EUGoD4sUZrhuuBj15ODpqtLgcV
        YJ3cM4TVg3LbLc5jy5Qs4jwZntmnzn+JMFk/doikog==
X-Google-Smtp-Source: APBJJlGL9JGLy10O73QK3szm+DEF7SAKVndVH3a3mA6KEGtyxifInalzNWCIpWbxy0wzSqsUngr6tw==
X-Received: by 2002:a17:902:704c:b0:1ba:fe63:6616 with SMTP id h12-20020a170902704c00b001bafe636616mr3242178plt.6.1689340424527;
        Fri, 14 Jul 2023 06:13:44 -0700 (PDT)
Received: from localhost.localdomain ([103.156.184.205])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902b41500b001b3bf8001a9sm7777905plr.48.2023.07.14.06.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 06:13:44 -0700 (PDT)
From:   Han Gao <highenthalpyh@gmail.com>
To:     kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Han Gao <highenthalpyh@gmail.com>, David Xu <xuwd1@hotmail.com>
Subject: [PATCH] nvme-pci: add NVME_QUIRK_DELAY_BEFORE_CHK_RDY for MAXIO MAP1602
Date:   Fri, 14 Jul 2023 21:13:33 +0800
Message-ID: <20230714131333.5858-1-highenthalpyh@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4TB SSD with MAXIO MAP1602 controller is cannot by initialised
in nvme_enable_ctrl with a high probability, which causeds the system
to be unable to use SSD, and SSD device only be shown in lspci.

dmesg output of problem

----------
nvme nvme1: Device not ready; aborting initialisation, CSTS=0x0
----------

Problem and fix are verified with my MAP1602 controller SSD device.

Signed-off-by: Han Gao <highenthalpyh@gmail.com>
Signed-off-by: David Xu <xuwd1@hotmail.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 492f319ebdf3..f75c27730bde 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3425,7 +3425,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1602),   /* MAXIO MAP1602 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
+		.driver_data = NVME_QUIRK_BOGUS_NID |
+				NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
-- 
2.41.0

