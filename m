Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84FC7E4527
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343863AbjKGQCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343835AbjKGQAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:00:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDAF869B;
        Tue,  7 Nov 2023 07:53:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB22C433CB;
        Tue,  7 Nov 2023 15:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372404;
        bh=TxO+xCiY4eH2/AfVA5mEkt7Go34h1a1zFP9teb2wC+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZGQjWkzZt9WbnlcdCOap5rFEnbEdBTeINmBiIwJ717zGuBa1sFRT1hcmkqW+TB9r
         TM4+7Agj4uv4DgkJHdfSArYI6di8r6wK22uJX6++5HH28T4qehHa/txbup4KSb3sbw
         P4gvvfQT29yoDc0AhsUlX3LH2hmqWZQ+7D6nPTynxVFbMo3mYN2VOo7u/ltewcDq34
         nQ0n4gS75y+kipb3aDgAMxB717t5WYNNCDKWCMp2du6Ng8u06p9FJVfgAUdMqhtdKW
         rt5SXCC+foRoR+v+W2gnkPiguuHZ1IfEygVQK9SQTgWBrk41NuiBh9ILSAmmIByogK
         a2KMgId1P2URg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenchao Hao <haowenchao2@huawei.com>,
        Simon Horman <horms@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, hare@suse.de,
        jejb@linux.ibm.com, richardcochran@gmail.com,
        linux-scsi@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 13/16] scsi: libfc: Fix potential NULL pointer dereference in fc_lport_ptp_setup()
Date:   Tue,  7 Nov 2023 10:52:32 -0500
Message-ID: <20231107155249.3768098-13-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155249.3768098-1-sashal@kernel.org>
References: <20231107155249.3768098-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
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
index abb14b206be04..82b8477c7d737 100644
--- a/drivers/scsi/libfc/fc_lport.c
+++ b/drivers/scsi/libfc/fc_lport.c
@@ -238,6 +238,12 @@ static void fc_lport_ptp_setup(struct fc_lport *lport,
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

