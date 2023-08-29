Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E479078C112
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbjH2JOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjH2JNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:13:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D7F19A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:13:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2941C2186B;
        Tue, 29 Aug 2023 09:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693300421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eB9aR/U6RXS2ICVTlyDomYJuoXmtN3u/uV5XxMcbYuo=;
        b=Hpqoevjysf1nd1SZYQ6aepWzFXEDTEdcxmvOBeF5UIf0r8QPknKN+mUMTvOZ2/LSGc8AAw
        /blVeYyProyUL7FHWzfrc5NhTu7m4nt7aaRokpcYAMq3KUjEBUBoKSoEgjj9hZzS7eygKM
        h6D+VFqdaFS67jUdWMnHmKZz1q8Y2ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693300421;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eB9aR/U6RXS2ICVTlyDomYJuoXmtN3u/uV5XxMcbYuo=;
        b=zxhdbhswoF+xnBjjhQZNxrT9am2KXkHQKth4H71nz1YFuqG+xMydTqyjpGcwLs8ZPmh9VP
        D0eBxqpIySVuyGDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CFD913301;
        Tue, 29 Aug 2023 09:13:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id irPtBsW27WS8UwAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 29 Aug 2023 09:13:41 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Subject: [RFC v1 4/4] nvmet-discovery: Do not use invalid port
Date:   Tue, 29 Aug 2023 11:13:50 +0200
Message-ID: <20230829091350.16156-6-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829091350.16156-1-dwagner@suse.de>
References: <20230829091350.16156-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The port entry binding might not be existing and thus the req->port
pointer is not valid.

Reproducer: nvme/005 with active system nvmf-autoconnect systemd service.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/discovery.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 668d257fa986..fc113057cb95 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -191,6 +191,15 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 		goto out;
 	}
 
+
+	/* No port assigned, portentrybinding is missing */
+	if (!req->port) {
+		req->error_loc =
+			offsetof(struct nvme_get_log_page_command, lpo);
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		goto out;
+	}
+
 	/*
 	 * Make sure we're passing at least a buffer of response header size.
 	 * If host provided data len is less than the header size, only the
-- 
2.41.0

