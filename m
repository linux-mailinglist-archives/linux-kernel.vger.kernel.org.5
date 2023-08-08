Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE2F774301
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjHHRzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjHHRyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:54:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EC229459
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:24:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C2EC420018;
        Tue,  8 Aug 2023 09:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691486155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iRtgBAku4257SBCPX9EvO+HL6e6liwMpsxDBOvqZyE8=;
        b=ger7pBuTrwZ1HKfT8z3sjooEkTpJe3raGS/n3xoYQLq0YXFOHoeHwbeOG6Bj+fsq/6zX54
        E1NP09owVZGoBvJeH64xMMrenfzb0bzQiygBaUWOhWaAINnsLapt19zbZUkeg0wBX+Qq+I
        j8LrLs0n9TeihtMldqsK9LaAO/bydwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691486155;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iRtgBAku4257SBCPX9EvO+HL6e6liwMpsxDBOvqZyE8=;
        b=y8Vlt3iowHtcCUjxibL0cRrP6Ih1Ml60GjqxgTHt1Yc1NMC+MzeOs2fm8IkUJeY+N/r/h1
        l43pwJ9arV5cIGBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4FED13451;
        Tue,  8 Aug 2023 09:15:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5zvcK8sH0mRFEwAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 08 Aug 2023 09:15:55 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Caleb Sander <csander@purestorage.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH libnvme v3 2/2] fabrics: Do not pass disable_sqflow if not supported
Date:   Tue,  8 Aug 2023 11:15:50 +0200
Message-ID: <20230808091550.25349-3-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808091550.25349-1-dwagner@suse.de>
References: <20230808091550.25349-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

Only retry a connect attempt with disable_sqflow if the kernel
actually supports this option.

Reported-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/nvme/fabrics.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 9725eeb3cda8..11d99580072a 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -1031,8 +1031,11 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t h,
 		return NULL;
 	}
 
-	if (e->treq & NVMF_TREQ_DISABLE_SQFLOW)
+	if (e->treq & NVMF_TREQ_DISABLE_SQFLOW &&
+	    nvmf_check_option(h->r, disable_sqflow))
 		c->cfg.disable_sqflow = true;
+	else
+		c->cfg.disable_sqflow = false;
 
 	if (e->trtype == NVMF_TRTYPE_TCP &&
 	    (e->treq & NVMF_TREQ_REQUIRED ||
-- 
2.41.0

