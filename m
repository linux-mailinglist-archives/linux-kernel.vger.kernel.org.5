Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A988087F2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379448AbjLGMgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjLGMg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:36:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FCD10D0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:36:33 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 45C3D1FB5B;
        Thu,  7 Dec 2023 12:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1701952592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hBvs7TZQ+nucLVLXIxUZxqkZhSIgkTWTSN7462TSV+g=;
        b=ZeIt+FIYVMYMeo9YLHrBBg8tRzTNUSlIdantCyfK4oKtSlPBeDXiiJg+PcWaEMhxtElUgU
        wSGC9Iv1diomTgpfvqbhLb1ZtZN1hGsfPip3UrGyHVdmXTqDYXOtTYVarqAvaTP+0E0rPX
        DGysDIWIv2U7n2I73b9Q5XpxWQD+reU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1701952592;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hBvs7TZQ+nucLVLXIxUZxqkZhSIgkTWTSN7462TSV+g=;
        b=aTbjMKu3D5F9l5snV5BTh+MbARCzE61MCHmi4JqZcndJDHOGPSbA+bJdBV+2rowcx1Swy5
        Ixj8mQCoufa9fdCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 33386139E3;
        Thu,  7 Dec 2023 12:36:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id XvwOC1C8cWUCAwAAn2gu4w
        (envelope-from <dwagner@suse.de>); Thu, 07 Dec 2023 12:36:32 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 4/4] nvme: repack struct nvme_ns_head
Date:   Thu,  7 Dec 2023 13:36:24 +0100
Message-ID: <20231207123624.29959-5-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207123624.29959-1-dwagner@suse.de>
References: <20231207123624.29959-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[7];
         MID_CONTAINS_FROM(1.00)[];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[12.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ns_id, lba_shift and ms are always accessed for every read/write I/O in
nvme_setup_rw. By grouping these variables into one cacheline we can
safe some cycles.

4k sequential reads:

           baseline   patched
Bandwidth: 1620       1634
IOPs       66345579   66910939

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/nvme.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2b31641a97b9..4a4beaecc832 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -445,21 +445,21 @@ struct nvme_ns_head {
 	struct list_head	list;
 	struct srcu_struct      srcu;
 	struct nvme_subsystem	*subsys;
-	unsigned		ns_id;
 	struct nvme_ns_ids	ids;
 	struct list_head	entry;
 	struct kref		ref;
 	bool			shared;
 	int			instance;
 	struct nvme_effects_log *effects;
+	u64			nuse;
+	unsigned		ns_id;
 	int			lba_shift;
 	u16			ms;
 	u16			pi_size;
-	u16			sgs;
-	u32			sws;
-	u64			nuse;
 	u8			pi_type;
 	u8			guard_type;
+	u16			sgs;
+	u32			sws;
 #ifdef CONFIG_BLK_DEV_ZONED
 	u64			zsze;
 #endif
-- 
2.43.0

