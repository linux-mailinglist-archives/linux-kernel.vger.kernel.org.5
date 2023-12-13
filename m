Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC76A8119D8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379406AbjLMQnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377827AbjLMQnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:43:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9447F120
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:43:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38E4C433CB;
        Wed, 13 Dec 2023 16:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702485796;
        bh=/VgfUvsmvX2n019MxXLrjKmvUFShp1H3MaszHsAPHGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XsBXlv5DeBhXUIpcPuRuzSfg8SfGeHati6aAXIoHbRuo9LG+Q0hQq9DwpNqR5erpU
         1bZAemhQZ6c0x1GGAjt+lCl0lAouPl3cx+lmaBEONDONKH8hfJWdy2hdycCC/rs+H+
         4bHr8O1sItmqYGRbqHcIjQundVi/ie3WWHbOQXATp3WoH7wraD7/o3wS71+qjUBdue
         QcXqX5sN1aoPYitYQN+lqR9tMtWuq7I65TDfDkgWhq2GlcxRTfk1l8ywfHZmGrh9qY
         iqwVKRqva9DnVXB4Nsomot0VsTMY2oV/ivfmHUv+s5qNVvPUpNvON73Pzosf9dk57q
         h1PRp1wcEK3Ew==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 10/12] usb: mon_text: Replace snprintf() with the safer scnprintf() variant
Date:   Wed, 13 Dec 2023 16:42:39 +0000
Message-ID: <20231213164246.1021885-11-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213164246.1021885-1-lee@kernel.org>
References: <20231213164246.1021885-1-lee@kernel.org>
MIME-Version: 1.0
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

There is a general misunderstanding amongst engineers that {v}snprintf()
returns the length of the data *actually* encoded into the destination
array.  However, as per the C99 standard {v}snprintf() really returns
the length of the data that *would have been* written if there were
enough space for it.  This misunderstanding has led to buffer-overruns
in the past.  It's generally considered safer to use the {v}scnprintf()
variants in their place (or even sprintf() in simple cases).  So let's
do that.

Link: https://lwn.net/Articles/69419/
Link: https://github.com/KSPP/linux/issues/105
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/usb/mon/mon_text.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/mon/mon_text.c b/drivers/usb/mon/mon_text.c
index 39cb141646526..2fe9b95bac1d5 100644
--- a/drivers/usb/mon/mon_text.c
+++ b/drivers/usb/mon/mon_text.c
@@ -352,7 +352,7 @@ static int mon_text_open(struct inode *inode, struct file *file)
 	rp->r.rnf_error = mon_text_error;
 	rp->r.rnf_complete = mon_text_complete;
 
-	snprintf(rp->slab_name, SLAB_NAME_SZ, "mon_text_%p", rp);
+	scnprintf(rp->slab_name, SLAB_NAME_SZ, "mon_text_%p", rp);
 	rp->e_slab = kmem_cache_create(rp->slab_name,
 	    sizeof(struct mon_event_text), sizeof(long), 0,
 	    mon_text_ctor);
@@ -700,46 +700,28 @@ static const struct file_operations mon_fops_text_u = {
 
 int mon_text_add(struct mon_bus *mbus, const struct usb_bus *ubus)
 {
-	enum { NAMESZ = 10 };
+	enum { NAMESZ = 12 };
 	char name[NAMESZ];
 	int busnum = ubus? ubus->busnum: 0;
-	int rc;
 
 	if (mon_dir == NULL)
 		return 0;
 
 	if (ubus != NULL) {
-		rc = snprintf(name, NAMESZ, "%dt", busnum);
-		if (rc <= 0 || rc >= NAMESZ)
-			goto err_print_t;
+		scnprintf(name, NAMESZ, "%dt", busnum);
 		mbus->dent_t = debugfs_create_file(name, 0600, mon_dir, mbus,
 							     &mon_fops_text_t);
 	}
 
-	rc = snprintf(name, NAMESZ, "%du", busnum);
-	if (rc <= 0 || rc >= NAMESZ)
-		goto err_print_u;
+	scnprintf(name, NAMESZ, "%du", busnum);
 	mbus->dent_u = debugfs_create_file(name, 0600, mon_dir, mbus,
 					   &mon_fops_text_u);
 
-	rc = snprintf(name, NAMESZ, "%ds", busnum);
-	if (rc <= 0 || rc >= NAMESZ)
-		goto err_print_s;
+	scnprintf(name, NAMESZ, "%ds", busnum);
 	mbus->dent_s = debugfs_create_file(name, 0600, mon_dir, mbus,
 					   &mon_fops_stat);
 
 	return 1;
-
-err_print_s:
-	debugfs_remove(mbus->dent_u);
-	mbus->dent_u = NULL;
-err_print_u:
-	if (ubus != NULL) {
-		debugfs_remove(mbus->dent_t);
-		mbus->dent_t = NULL;
-	}
-err_print_t:
-	return 0;
 }
 
 void mon_text_del(struct mon_bus *mbus)
-- 
2.43.0.472.g3155946c3a-goog

