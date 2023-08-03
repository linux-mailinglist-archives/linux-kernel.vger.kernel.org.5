Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE54776E921
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbjHCNEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbjHCNDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:03:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCAA272E;
        Thu,  3 Aug 2023 06:03:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A703961D74;
        Thu,  3 Aug 2023 13:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C974AC433C9;
        Thu,  3 Aug 2023 13:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691067817;
        bh=RmRU1Y0bR4m7Z4ZxHjX1XmGgx9CBo/c/cQcoL8cYxAw=;
        h=From:To:Cc:Subject:Date:From;
        b=gPx2E3lBnRtaHzZchiO3Q/W7TMJSMRZBWOujOpP2f2Vd49FINk0+khvbSPb4pHoY/
         d65hNStHMUqV07JW2pXIHKclvyEuPBtSzXPuYmHEmagTaueBNVLLI041alOILBtlvU
         nIyB12W2bczz+5V8iptTq5MetnHJikeU/V8ROer6KmZGxpCCv9+g2oy4+4S2B41xx2
         jxZSuuOxyi9BdIKRb6xqRcJgeKgyEjfpQ/aGxjfgdzxMpUdfutRLjyI0yaFfm+Btmc
         fRVtb7BuGVQEtwMSuM9MFbO7npWzwsPrtnORH5+jJB9D7KqEwI+Ipey55LQPyDrVul
         GlvAjfM4+DpnA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tuo Li <islituo@gmail.com>, BassCheck <bass@buaa.edu.cn>,
        Justin Tee <justin.tee@broadcom.com>,
        Laurence Oberman <loberman@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 1/5] scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()
Date:   Thu,  3 Aug 2023 09:03:29 -0400
Message-Id: <20230803130333.641625-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.42
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tuo Li <islituo@gmail.com>

[ Upstream commit 0e881c0a4b6146b7e856735226208f48251facd8 ]

The variable phba->fcf.fcf_flag is often protected by the lock
phba->hbalock() when is accessed. Here is an example in
lpfc_unregister_fcf_rescan():

  spin_lock_irq(&phba->hbalock);
  phba->fcf.fcf_flag |= FCF_INIT_DISC;
  spin_unlock_irq(&phba->hbalock);

However, in the same function, phba->fcf.fcf_flag is assigned with 0
without holding the lock, and thus can cause a data race:

  phba->fcf.fcf_flag = 0;

To fix this possible data race, a lock and unlock pair is added when
accessing the variable phba->fcf.fcf_flag.

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
Link: https://lore.kernel.org/r/20230630024748.1035993-1-islituo@gmail.com
Reviewed-by: Justin Tee <justin.tee@broadcom.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_hbadisc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index d38ebd7281b9b..326ef4942e672 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -6960,7 +6960,9 @@ lpfc_unregister_fcf_rescan(struct lpfc_hba *phba)
 	if (rc)
 		return;
 	/* Reset HBA FCF states after successful unregister FCF */
+	spin_lock_irq(&phba->hbalock);
 	phba->fcf.fcf_flag = 0;
+	spin_unlock_irq(&phba->hbalock);
 	phba->fcf.current_rec.flag = 0;
 
 	/*
-- 
2.40.1

