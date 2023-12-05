Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887EF8056DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345637AbjLEOKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345587AbjLEOKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:10:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDFDB9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701785421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zjpDU1pO5fL8Z2EU79m8w3lIjmII9ANV1M3MyIbt0ME=;
        b=AXzplE61wm0wc8yNrlCbxbSpHbVLySxPi78iZKby+0WCo0ihllR/JlQ/2jqtZHDqgv2ys8
        heOvMEWC9tuTuaLKP5p6HK235MeLrAn/MX144leLPJjSb+F0KcVLIvWDhqCPxSKtztfo23
        Lgyn3x78pvHOseVM2mqEMw4y4fLdMkE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-hAEfsowROliopZ5AVRFZjQ-1; Tue,
 05 Dec 2023 09:09:30 -0500
X-MC-Unique: hAEfsowROliopZ5AVRFZjQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A21B1C06915;
        Tue,  5 Dec 2023 14:09:30 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit2023-praritguest.khw1.lab.eng.bos.redhat.com [10.16.200.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED5A22026F95;
        Tue,  5 Dec 2023 14:09:29 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        David Arcari <darcari@redhat.com>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: Provide a better stop error message
Date:   Tue,  5 Dec 2023 09:09:16 -0500
Message-ID: <20231205140926.397956-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a better stop error message for the case where the watchdog does
not stop.

CC: Wim Van Sebroeck <wim@linux-watchdog.org>
CC: Guenter Roeck <linux@roeck-us.net>
CC: David Arcari <darcari@redhat.com>
CC: linux-watchdog@vger.kernel.org
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/watchdog/watchdog_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 15df74e11a59..f0084bf7c750 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -965,7 +965,8 @@ static int watchdog_release(struct inode *inode, struct file *file)
 
 	/* If the watchdog was not stopped, send a keepalive ping */
 	if (err < 0) {
-		pr_crit("watchdog%d: watchdog did not stop!\n", wdd->id);
+		pr_crit("watchdog%d is still active. Stop by [%s:%d] failed.\n",
+			wdd->id, current->comm, current->pid);
 		watchdog_ping(wdd);
 	}
 
-- 
2.43.0

