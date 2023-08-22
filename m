Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7505783A23
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjHVGsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjHVGsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:48:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98C3FB;
        Mon, 21 Aug 2023 23:48:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AB61022C44;
        Tue, 22 Aug 2023 06:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692686899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=APnjFGwfih6UCAXoJMMRdQoOq8OBAmD6tC504XVu2hI=;
        b=bkwRhsaNBr7hSCKRdCiTWuVi4gmgk2wU/CZXn9i1WP5nUbWsubap59D0RKgZhAPMvqgAn+
        tHlmT28NkT8ql+7GpI/XExWnlfBPR0yes3G9BRSAR3iAFuECjrtiKXPKvGq/8kqY+D5V0+
        gIqBb+pKx1aeQ90DZ+EwK6IgpBXsV9k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63BCB132B9;
        Tue, 22 Aug 2023 06:48:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gEfnFjNa5GT1RQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 22 Aug 2023 06:48:19 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        xen-devel@lists.xenproject.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] xen/scsifront: shost_priv() can never return NULL
Date:   Tue, 22 Aug 2023 08:48:17 +0200
Message-Id: <20230822064817.27257-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
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

There is no need to check whether shost_priv() returns a non-NULL
value, as the pointer returned is just an offset to the passed in
parameter.

While at it replace an open coded shost_priv() instance.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/scsi/xen-scsifront.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index caae61aa2afe..9ec55ddc1204 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -743,7 +743,7 @@ static int scsifront_sdev_configure(struct scsi_device *sdev)
 	if (info->host_active == STATE_ERROR)
 		return -EIO;
 
-	if (info && current == info->curr) {
+	if (current == info->curr) {
 		err = xenbus_printf(XBT_NIL, info->dev->nodename,
 			      info->dev_state_path, "%d", XenbusStateConnected);
 		if (err) {
@@ -761,7 +761,7 @@ static void scsifront_sdev_destroy(struct scsi_device *sdev)
 	struct vscsifrnt_info *info = shost_priv(sdev->host);
 	int err;
 
-	if (info && current == info->curr) {
+	if (current == info->curr) {
 		err = xenbus_printf(XBT_NIL, info->dev->nodename,
 			      info->dev_state_path, "%d", XenbusStateClosed);
 		if (err)
@@ -903,7 +903,7 @@ static int scsifront_probe(struct xenbus_device *dev,
 		xenbus_dev_fatal(dev, err, "fail to allocate scsi host");
 		return err;
 	}
-	info = (struct vscsifrnt_info *)host->hostdata;
+	info = shost_priv(host);
 
 	dev_set_drvdata(&dev->dev, info);
 	info->dev = dev;
-- 
2.35.3

