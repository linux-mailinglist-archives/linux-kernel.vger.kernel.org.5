Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70597C4D80
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345703AbjJKIps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjJKIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:45:37 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07413B6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:45:35 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 77CBA24002A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:45:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1697013934; bh=HoFGL1O1u5jeH2eaAc/NSgPYTeO+yRIjCCiIYzJbT6w=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=fPB/cjVYgK9Fdfzt2+GmxUYKzlWxtsNpfGkoBdJ6va1ELOt/MEEsTHthx0gQpyMSo
         3zPVMDIwaZEtIgVLdIrk58uwS+fijwmAVPtz+GVbwkLaZdGOIpk29OPBI6qPFTVYd3
         TxBGn065nSqNGh9CH3RqMtRKWBzmxpQYZ95MOSZAQySq6vAfEzf70PorNtyG6KXonQ
         PDoGFhSQrTzN6b+H5yKQpKAHwdaUcNKProTXIZHetLMHaHZp6yQ4y0mQxbaQxH5c87
         9sqhmlTKLqcIUa9Swp75a1Uoe4f1Hs2hiyV7G2XbxmbWXZkMP/hfW5ZvBO+zjU5eC+
         MZaPwYHEsusbA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4S55vK1M9Pz6tw0;
        Wed, 11 Oct 2023 10:45:33 +0200 (CEST)
From:   Mark O'Donovan <shiftee@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, kbusch@kernel.org, hare@suse.de,
        Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH 2/2 RESEND] nvme-auth: set explanation code for failure2 msgs
Date:   Wed, 11 Oct 2023 08:45:12 +0000
Message-Id: <20231011084512.1835614-2-shiftee@posteo.net>
In-Reply-To: <20231011084512.1835614-1-shiftee@posteo.net>
References: <20231011084512.1835614-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some error cases were not setting an auth-failure-reason-code-explanation.
This means an AUTH_Failure2 message will be sent with an explanation value
of 0 which is a reserved value.

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v1->v2: Set failure explanation in a single place if the error handling
code has not already done so.
---
 drivers/nvme/host/auth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index e1a98647c3a2..9556cfc4f5f3 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -839,6 +839,8 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	}
 
 fail2:
+	if (chap->status == 0)
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
 	dev_dbg(ctrl->device, "%s: qid %d send failure2, status %x\n",
 		__func__, chap->qid, chap->status);
 	tl = nvme_auth_set_dhchap_failure2_data(ctrl, chap);
-- 
2.39.2

