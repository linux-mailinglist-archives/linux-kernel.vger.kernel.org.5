Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD7580A196
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573771AbjLHKyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573718AbjLHKxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:53:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A698115
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:53:47 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8E89D2118C;
        Fri,  8 Dec 2023 10:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702032825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wG/WgEHtQYUHrRNwmOMTcsj+OVIRNNcNPPGKhtYYRik=;
        b=WyhIZb8fVCvvI6mfbtAmMkupFo7uo1Pnv/lOwO5I5jSvf86VJBfeovcwmhZOZhGFs0Yb/o
        XlCZe/ZBV3RPcOu8BwtIgzv/DjlOGlQf6CsxypuqBLU29+SP3Ki10IQoX+U5yAmp31hCv3
        wTRmFEC7+B4lppEumCPzXJIx4rFXag0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702032825;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wG/WgEHtQYUHrRNwmOMTcsj+OVIRNNcNPPGKhtYYRik=;
        b=5x3x1RcVmlqzRVzwELwHCh7VWuOJWwjt2hC/p/MTq82Ja9D112HXCwqh2FTWH2I8kOnrDq
        ps65B1kJlRR/Q1CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702032825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wG/WgEHtQYUHrRNwmOMTcsj+OVIRNNcNPPGKhtYYRik=;
        b=WyhIZb8fVCvvI6mfbtAmMkupFo7uo1Pnv/lOwO5I5jSvf86VJBfeovcwmhZOZhGFs0Yb/o
        XlCZe/ZBV3RPcOu8BwtIgzv/DjlOGlQf6CsxypuqBLU29+SP3Ki10IQoX+U5yAmp31hCv3
        wTRmFEC7+B4lppEumCPzXJIx4rFXag0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702032825;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wG/WgEHtQYUHrRNwmOMTcsj+OVIRNNcNPPGKhtYYRik=;
        b=5x3x1RcVmlqzRVzwELwHCh7VWuOJWwjt2hC/p/MTq82Ja9D112HXCwqh2FTWH2I8kOnrDq
        ps65B1kJlRR/Q1CQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BA22138FF;
        Fri,  8 Dec 2023 10:53:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id mqauHLn1cmU9VgAAn2gu4w
        (envelope-from <dwagner@suse.de>); Fri, 08 Dec 2023 10:53:45 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 6/6] nvme: repack struct nvme_ns_head
Date:   Fri,  8 Dec 2023 11:53:37 +0100
Message-ID: <20231208105337.23409-7-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208105337.23409-1-dwagner@suse.de>
References: <20231208105337.23409-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***********
X-Spam-Score: 11.79
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
        dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WyhIZb8f;
        dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5x3x1RcV;
        dmarc=pass (policy=none) header.from=suse.de;
        spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dwagner@suse.de) smtp.mailfrom=dwagner@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-6.01 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all:c];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_TRACE(0.00)[suse.de:+];
         DMARC_POLICY_ALLOW(0.00)[suse.de,none];
         RCPT_COUNT_SEVEN(0.00)[7];
         MX_GOOD(-0.01)[];
         DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-0.00)[27.39%];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         FROM_HAS_DN(0.00)[];
         DWL_DNSWL_MED(-2.00)[suse.de:dkim];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         WHITELIST_DMARC(-7.00)[suse.de:D:+];
         MID_CONTAINS_FROM(1.00)[];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.01
X-Rspamd-Queue-Id: 8E89D2118C
X-Spam-Flag: NO
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/nvme.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8912292720d4..416794727364 100644
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

