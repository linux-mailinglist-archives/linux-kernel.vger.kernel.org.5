Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E10078C110
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjH2JOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbjH2JNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:13:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114F5194
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:13:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 93E6B21869;
        Tue, 29 Aug 2023 09:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693300420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eB9aR/U6RXS2ICVTlyDomYJuoXmtN3u/uV5XxMcbYuo=;
        b=jqB6/4DD7H3h9Qv0f5H3Amcc7qkkeg0pN/kQ1MA7nKvvxByqMV0cLWoUrlmkVSdi75ajWw
        6+DcvYqhXeG1vdz6Tp6I7eSBkCHQFAwGqfmmJ+yXo5FDmFgXSWciZD5Ke9d5Vl3qU7B7CJ
        Xc+4QY+uAm002euoxnqYy4MaNT8c/5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693300420;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eB9aR/U6RXS2ICVTlyDomYJuoXmtN3u/uV5XxMcbYuo=;
        b=gDO+TahvCneMmJqnz5bI64wB9N8vCLVS6ZJBqCCqOivnUJNoxhjZXOaxHWiR78fIVCEJJq
        rLaYC8qBh/KS5WDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8736013301;
        Tue, 29 Aug 2023 09:13:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IdP+IMS27WS2UwAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 29 Aug 2023 09:13:40 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Subject: [RFC v1 4/4] nvmet-discovery: do not use invalid port
Date:   Tue, 29 Aug 2023 11:13:49 +0200
Message-ID: <20230829091350.16156-5-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829091350.16156-1-dwagner@suse.de>
References: <20230829091350.16156-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

