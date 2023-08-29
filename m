Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66A078C5DE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjH2Ndx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbjH2Ndi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA02194;
        Tue, 29 Aug 2023 06:33:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 616C461ADB;
        Tue, 29 Aug 2023 13:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF787C433C9;
        Tue, 29 Aug 2023 13:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693315987;
        bh=CRQOBcDKkYXV+TFZ5KF31xG95sqxncyXnME8XF38jKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SjBwa10IUQ4xX9yRDlw+b5dBZDdt5anTY0LR8g/jGLw6DZ17zTqMQRsggp9SNZ7mk
         nA+XUnLykgEhXc+CNUgV2Gm6UUkXvH9xWB3bi0qYmYZ919M34lB0Dph6+7TVgzCWrZ
         CSC3lagC62xo08C5bixJEPwzSpSJcJwc/VibIT2bjU+XmCNI1fGOeE6EFyx7QvbhLf
         nuLklj2hb57hxMhD1bTxhWhtlLWR4rsa7FIGPMhwvjzNgGaERRlFth7M03GQo70mNn
         H4PF/nNBzQIXOXM++TmS73jruSi2wL1oJxNtNhVv7FxZYyiXtDIBw8xMJiqdzq3jiq
         JaUn608ZoqiUQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Justin Tee <justintee8345@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>,
        kernel test robot <lkp@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 12/15] scsi: lpfc: Fix incorrect big endian type assignment in bsg loopback path
Date:   Tue, 29 Aug 2023 09:32:42 -0400
Message-Id: <20230829133245.520176-12-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133245.520176-1-sashal@kernel.org>
References: <20230829133245.520176-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.49
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Tee <justintee8345@gmail.com>

[ Upstream commit 9cefd6e7e0a77b0fbca5c793f6fb6821b0962775 ]

The kernel test robot reported sparse warnings regarding incorrect type
assignment for __be16 variables in bsg loopback path.

Change the flagged lines to use the be16_to_cpu() and cpu_to_be16() macros
appropriately.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20230614175944.3577-1-justintee8345@gmail.com
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306110819.sDIKiGgg-lkp@intel.com/
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_bsg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 852b025e2fecf..b54fafb486e06 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -889,7 +889,7 @@ lpfc_bsg_ct_unsol_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 			struct lpfc_iocbq *piocbq)
 {
 	uint32_t evt_req_id = 0;
-	uint32_t cmd;
+	u16 cmd;
 	struct lpfc_dmabuf *dmabuf = NULL;
 	struct lpfc_bsg_event *evt;
 	struct event_data *evt_dat = NULL;
@@ -915,7 +915,7 @@ lpfc_bsg_ct_unsol_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 
 	ct_req = (struct lpfc_sli_ct_request *)bdeBuf1->virt;
 	evt_req_id = ct_req->FsType;
-	cmd = ct_req->CommandResponse.bits.CmdRsp;
+	cmd = be16_to_cpu(ct_req->CommandResponse.bits.CmdRsp);
 
 	spin_lock_irqsave(&phba->ct_ev_lock, flags);
 	list_for_each_entry(evt, &phba->ct_ev_waiters, node) {
@@ -3186,8 +3186,8 @@ lpfc_bsg_diag_loopback_run(struct bsg_job *job)
 			ctreq->RevisionId.bits.InId = 0;
 			ctreq->FsType = SLI_CT_ELX_LOOPBACK;
 			ctreq->FsSubType = 0;
-			ctreq->CommandResponse.bits.CmdRsp = ELX_LOOPBACK_DATA;
-			ctreq->CommandResponse.bits.Size   = size;
+			ctreq->CommandResponse.bits.CmdRsp = cpu_to_be16(ELX_LOOPBACK_DATA);
+			ctreq->CommandResponse.bits.Size   = cpu_to_be16(size);
 			segment_offset = ELX_LOOPBACK_HEADER_SZ;
 		} else
 			segment_offset = 0;
-- 
2.40.1

