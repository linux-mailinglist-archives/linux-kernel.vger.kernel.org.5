Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C9C8001D3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377076AbjLADAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 22:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376922AbjLADAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 22:00:18 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0F9CE1722;
        Thu, 30 Nov 2023 19:00:23 -0800 (PST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 6E5CF60105E65;
        Fri,  1 Dec 2023 11:00:21 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     dan.carpenter@linaro.org, hare@suse.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     Su Hui <suhui@nfschina.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2 3/3] scsi: aic7xxx: return negative error codes in aic7770_probe()
Date:   Fri,  1 Dec 2023 10:59:56 +0800
Message-Id: <20231201025955.1584260-4-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231201025955.1584260-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aic7770_config() returns both negative and positive error code.
it's better to make aic7770_probe() only return negative error codes.

And the previous patch made ahc_linux_register_host() return negative error
codes, which makes sure aic7770_probe() returns negative error codes.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/scsi/aic7xxx/aic7770_osm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7770_osm.c b/drivers/scsi/aic7xxx/aic7770_osm.c
index bdd177e3d762..a19cdd87c453 100644
--- a/drivers/scsi/aic7xxx/aic7770_osm.c
+++ b/drivers/scsi/aic7xxx/aic7770_osm.c
@@ -87,17 +87,17 @@ aic7770_probe(struct device *dev)
 	sprintf(buf, "ahc_eisa:%d", eisaBase >> 12);
 	name = kstrdup(buf, GFP_ATOMIC);
 	if (name == NULL)
-		return (ENOMEM);
+		return -ENOMEM;
 	ahc = ahc_alloc(&aic7xxx_driver_template, name);
 	if (ahc == NULL)
-		return (ENOMEM);
+		return -ENOMEM;
 	ahc->dev = dev;
 	error = aic7770_config(ahc, aic7770_ident_table + edev->id.driver_data,
 			       eisaBase);
 	if (error != 0) {
 		ahc->bsh.ioport = 0;
 		ahc_free(ahc);
-		return (error);
+		return error < 0 ? error : -error;
 	}
 
  	dev_set_drvdata(dev, ahc);
-- 
2.30.2

