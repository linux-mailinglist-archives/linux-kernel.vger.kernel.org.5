Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1DC797C01
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244107AbjIGSgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjIGSgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:36:16 -0400
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D317F9D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:36:09 -0700 (PDT)
From:   Felix Yan <felixonmars@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1694111768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QWmWOHF2kStxZNUk4MazgA7GlrOHMD+B76AIe95Nk4U=;
        b=MNm2Ub3uQ8Dh+Q7+p5ak587lyDFZChGVD/r6xxCMFLbkV8grzNDkuFWpqVS7pe7iFUQQuZ
        glVtyuvagCsQtES2k3N0+axxVxwgcxtrvPOZsSwr7Ykpwpt2SLovmb0SVKrz7WyZtKmKK9
        hzudGKVsh6jdep2qfZLnAWV6nmQXAGNquaeKaSplTDGrIrLXxQD5dhQlkO8s483GHlKNY9
        /zCsTZoi8ewZKkyyzXyIJs7k930KZcgegCPdHsQ4/Q2Q7UrPa4ZKQl905IPRj/vHU/AYJR
        EQi2DD6XXDWRFyDJ0tMikPhiciF3KC3IUxu6VAcOGP3tOcMwYNBhmY/QODPpodV0vdbTyU
        AnnNKWAkPonqPozjv0w8ljsLf9gRRkbtyVYb6o+Zh7IlFlle/La94/hDU3DDR9s7hSrAdf
        Ipc9pJXKTMg4b/yqgCu8UlxZYEdjh4+p7D+UDAhOsPdmB8CQeeylw0u09A7eoNWVZJ3EM2
        CQyW+pBeOl5rowOxNx+OyBtOeNkALlUB9nDU1VvWtWcB9Iqw54uJl39fcsakENYCu1WPXX
        Iqv9jika61cKHcMkToK0U9hRbRbB6K7yaAPA+qixsUqyeCBflzTkXE7WXszDWJB595dw5x
        q9M0fWWExeXlxXaPJM2guDsb0FmzAtqPGYWyroo2WKCD9liq6do7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1694111768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QWmWOHF2kStxZNUk4MazgA7GlrOHMD+B76AIe95Nk4U=;
        b=I9aqoA3LjIEgdySzT9RTa6FTPMoSoJ9SfNi2CqzBdI0GH1rJEG/HuEKnvBQ7UzqXyin81G
        IuiNYpSkxHX+NuCA==
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=felixonmars smtp.mailfrom=felixonmars@archlinux.org
To:     kbusch@kernel.org, highenthalpyh@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     xuwd1@hotmail.com, Felix Yan <felixonmars@archlinux.org>
Subject: [PATCH v2] nvme-pci: add NVME_QUIRK_DELAY_BEFORE_CHK_RDY for MAXIO MAP1602
Date:   Thu,  7 Sep 2023 21:36:05 +0300
Message-ID: <20230907183605.631347-1-felixonmars@archlinux.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4TB SSD with MAXIO MAP1602 controller cannot by initialized
in nvme_enable_ctrl with a high probability, which causes the system
to be unable to use SSD, and SSD device only be shown in lspci.

dmesg output of problem

----------
nvme nvme1: Device not ready; aborting initialisation, CSTS=0x0
----------

Problem and fix are verified with my MAP1602 controller SSD device.

Applying the NVME_QUIRK_DELAY_BEFORE_CHK_RDY quirk to nvme_enable_ctrl
too as the quirk name actually matches what is being done there. If this
should be a different quirk, please let me know and I'll adapt.

Adding also Lexar NM790 and AIGO P7000Z with the same controller
but has their vendored pci device ids.

Signed-off-by: Felix Yan <felixonmars@archlinux.org>
---
 drivers/nvme/host/core.c | 2 ++
 drivers/nvme/host/pci.c  | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3a01b79148c..dea1749d40dc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2281,6 +2281,8 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
 		return ret;
+	if (ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY)
+		msleep(NVME_QUIRK_DELAY_AMOUNT);
 	return nvme_wait_ready(ctrl, NVME_CSTS_RDY, NVME_CSTS_RDY,
 			       (timeout + 1) / 2, "initialisation");
 }
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2f57da12d983..fe02593c48d0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3439,7 +3439,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1602),   /* MAXIO MAP1602 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
+		.driver_data = NVME_QUIRK_BOGUS_NID |
+				NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
@@ -3457,6 +3458,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1d97, 0x2269), /* Lexar NM760 */
 		.driver_data = NVME_QUIRK_BOGUS_NID |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x1d97, 0x1602), /* Lexar NM790, AIGO P7000Z */
+		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x10ec, 0x5763), /* TEAMGROUP T-FORCE CARDEA ZERO Z330 SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4b, 0x1602), /* HS-SSD-FUTURE 2048G  */
-- 
2.42.0

