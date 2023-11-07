Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0D27E44D9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbjKGP6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344076AbjKGP5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:57:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5035C1FF9;
        Tue,  7 Nov 2023 07:51:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F81C433C7;
        Tue,  7 Nov 2023 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372274;
        bh=zelHw0MvsgMhJEF3TCNNAeS+IjZM0jqwzwLJAQ/4FE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H41/10qpP0BhL+FXevapZspjYjUHdoefCKWi8SiUJUlt317XfQP1jsAPkcZhSzi7O
         B5iDfOWSyxC86xNlCEECnpB9lDruhve8kjgPNoECGYjBe2bQs+Qrj0j75petzcVe7D
         G6i1iMUX5F1OUnV8vFUXIEzTLDC2T76euOIlMshqeQ5FEeQ5pFsyReQR3EeadN6t64
         APYATsNV+OsRHZ/BsjU9kT3nx7gCu/TMlk18cls70eQ6qm1uFFrIIw+mJXGSNC+3SI
         HUaUhqowesBn3ZQwxRIt6FgWVbPrW5gioF/Ym8KU5YgfcMpHqxpv2nuLzO2e9eJf//
         d7mKbXqMifvew==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenchao Hao <haowenchao2@huawei.com>,
        Simon Horman <horms@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, hare@suse.de,
        jejb@linux.ibm.com, richardcochran@gmail.com,
        linux-scsi@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 20/30] scsi: libfc: Fix potential NULL pointer dereference in fc_lport_ptp_setup()
Date:   Tue,  7 Nov 2023 10:49:54 -0500
Message-ID: <20231107155024.3766950-20-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155024.3766950-1-sashal@kernel.org>
References: <20231107155024.3766950-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenchao Hao <haowenchao2@huawei.com>

[ Upstream commit 4df105f0ce9f6f30cda4e99f577150d23f0c9c5f ]

fc_lport_ptp_setup() did not check the return value of fc_rport_create()
which can return NULL and would cause a NULL pointer dereference. Address
this issue by checking return value of fc_rport_create() and log error
message on fc_rport_create() failed.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
Link: https://lore.kernel.org/r/20231011130350.819571-1-haowenchao2@huawei.com
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libfc/fc_lport.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/libfc/fc_lport.c b/drivers/scsi/libfc/fc_lport.c
index 9c02c9523c4d4..ab06e9aeb613e 100644
--- a/drivers/scsi/libfc/fc_lport.c
+++ b/drivers/scsi/libfc/fc_lport.c
@@ -241,6 +241,12 @@ static void fc_lport_ptp_setup(struct fc_lport *lport,
 	}
 	mutex_lock(&lport->disc.disc_mutex);
 	lport->ptp_rdata = fc_rport_create(lport, remote_fid);
+	if (!lport->ptp_rdata) {
+		printk(KERN_WARNING "libfc: Failed to setup lport 0x%x\n",
+			lport->port_id);
+		mutex_unlock(&lport->disc.disc_mutex);
+		return;
+	}
 	kref_get(&lport->ptp_rdata->kref);
 	lport->ptp_rdata->ids.port_name = remote_wwpn;
 	lport->ptp_rdata->ids.node_name = remote_wwnn;
-- 
2.42.0

