Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DAA7DB110
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjJ2X2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjJ2X2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:28:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305394C35;
        Sun, 29 Oct 2023 15:59:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F8BC433CA;
        Sun, 29 Oct 2023 22:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620394;
        bh=mQGaD8SdnRGpdqijaVnOL7A5AJg4D28G3aoLsMYbEts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RNhKdzTzqaJ2UbCwlkCfxZBA0Tjx3u3bzWY+DmAO8Nhh8ZWMBIPWCAbjw7M8jFV7x
         zzhStULtruS/xTbXfZqCIy6ytMrI5Z0ROf7CEJvVtY2iUr0fgjLRxpi964xjhNHEXp
         cZMn8Y1cG6ElEoRpc213adqfaTQ2s4zb46wDCI2Gyv9dK0d+3jes/MoyBiOMeXz1xi
         h3VXBSlq6z7jnDZfywg7wqbBhRB711Pf7CHDN5O2SJrMApvtX4qmrMw7vGv9CEotJp
         3jQu752Fn2XsUo3HIAZOwa1uiLRDvUKBtZsimYIe3ozVEte3I87fiKXr0xxXZwCiFh
         4ZDeuUGTCSZ0g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomas Henzl <thenzl@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, sathya.prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com, jejb@linux.ibm.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 23/28] scsi: mpt3sas: Fix in error path
Date:   Sun, 29 Oct 2023 18:58:58 -0400
Message-ID: <20231029225916.791798-23-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225916.791798-1-sashal@kernel.org>
References: <20231029225916.791798-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Henzl <thenzl@redhat.com>

[ Upstream commit e40c04ade0e2f3916b78211d747317843b11ce10 ]

The driver should be deregistered as misc driver after PCI registration
failure.

Signed-off-by: Tomas Henzl <thenzl@redhat.com>
Link: https://lore.kernel.org/r/20231015114529.10725-1-thenzl@redhat.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 9eb3d0b4891dd..c9f85605349bf 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -12899,8 +12899,10 @@ _mpt3sas_init(void)
 	mpt3sas_ctl_init(hbas_to_enumerate);
 
 	error = pci_register_driver(&mpt3sas_driver);
-	if (error)
+	if (error) {
+		mpt3sas_ctl_exit(hbas_to_enumerate);
 		scsih_exit();
+	}
 
 	return error;
 }
-- 
2.42.0

