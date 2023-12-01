Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA85800702
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378248AbjLAJ37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378127AbjLAJ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:29:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6F32733
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:27:49 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 156B721C3F;
        Fri,  1 Dec 2023 09:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1701422867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fkc5UQmZbcBUbNRn9VLW++X90Qjbh2OojrbXDmLxlsA=;
        b=1ZVFa38pdPtRvAC5/DIScZ2yVwNBE1gpgzErhVtgLROxIX4+Ww5NgSETm/zruqpaPctHt8
        Ltgs6zTze7dkvXSJxJeqUYNgccz2to34Ozxp2th4a0fTPAxqi5V86VbmyzNMeu61fxuFt4
        OWqkE/yPEkpAZTG7+xLIgVOlAUGfX0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1701422867;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fkc5UQmZbcBUbNRn9VLW++X90Qjbh2OojrbXDmLxlsA=;
        b=yH/6L59LeseuS28t1fhEfN05DSn8KMOBlSi+7LsOJZN0ELWgiYnePD3l1x6Jsl7zunPood
        bW1GiHk1fSzUSKDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0346F13928;
        Fri,  1 Dec 2023 09:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id NDYFOxKnaWUPZgAAn2gu4w
        (envelope-from <dwagner@suse.de>); Fri, 01 Dec 2023 09:27:46 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [RFC v2 1/3] nvme: lookup ctrl from request instead from namespace
Date:   Fri,  1 Dec 2023 10:27:33 +0100
Message-ID: <20231201092735.28592-2-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201092735.28592-1-dwagner@suse.de>
References: <20231201092735.28592-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.10
X-Spamd-Result: default: False [-3.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         RCPT_COUNT_SEVEN(0.00)[7];
         MID_CONTAINS_FROM(1.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to use struct nvme_ns_head pointers instead of a struct
nvme_ns pointers, get the the ctrl pointer from a request. The reason is
that there is no easy and fast way to lookup the ctrl from struct
nvme_ns_head.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d699f0c8b13e..900c045fcae0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -769,6 +769,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmnd)
 {
 	unsigned short segments = blk_rq_nr_discard_segments(req), n = 0;
+	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
 	struct nvme_dsm_range *range;
 	struct bio *bio;
 
@@ -786,10 +787,10 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		 * discard page. If that's also busy, it's safe to return
 		 * busy, as we know we can make progress once that's freed.
 		 */
-		if (test_and_set_bit_lock(0, &ns->ctrl->discard_page_busy))
+		if (test_and_set_bit_lock(0, &ctrl->discard_page_busy))
 			return BLK_STS_RESOURCE;
 
-		range = page_address(ns->ctrl->discard_page);
+		range = page_address(ctrl->discard_page);
 	}
 
 	if (queue_max_discard_segments(req->q) == 1) {
@@ -815,8 +816,8 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	}
 
 	if (WARN_ON_ONCE(n != segments)) {
-		if (virt_to_page(range) == ns->ctrl->discard_page)
-			clear_bit_unlock(0, &ns->ctrl->discard_page_busy);
+		if (virt_to_page(range) == ctrl->discard_page)
+			clear_bit_unlock(0, &ctrl->discard_page_busy);
 		else
 			kfree(range);
 		return BLK_STS_IOERR;
@@ -861,9 +862,11 @@ static void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,
 static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd)
 {
+	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
+
 	memset(cmnd, 0, sizeof(*cmnd));
 
-	if (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
+	if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
 		return nvme_setup_discard(ns, req, cmnd);
 
 	cmnd->write_zeroes.opcode = nvme_cmd_write_zeroes;
-- 
2.43.0

