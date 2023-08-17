Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A5D77F378
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349700AbjHQJdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349722AbjHQJdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:33:03 -0400
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5BF2D4A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:33:01 -0700 (PDT)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230817093259537f62d7da2a7122c7
        for <linux-kernel@vger.kernel.org>;
        Thu, 17 Aug 2023 11:32:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ZqFov9jGDsnfiSsktXFWQg+2PQ3KFal/TX+lSDsD6S4=;
 b=SI1ueeRJk0/ekXnNJdNOnLi9MHCy5qKetbQIk/IzXtvXokvfamhI/0/ZuHJIk7mZyujcWU
 FEjhJJ4QAZgQ65Vw5ZTFqwp7hz0zpLuRo0FKSvm2FsoHu4V//WxlZdosoq4in7bSW2GEbG4c
 APoRR8v78+28jo/CKFHfkaxh95/xE=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v6 7/9] tty: n_gsm: cleanup gsm_control_command and gsm_control_reply
Date:   Thu, 17 Aug 2023 11:32:29 +0200
Message-Id: <20230817093231.2317-7-daniel.starke@siemens.com>
In-Reply-To: <20230817093231.2317-1-daniel.starke@siemens.com>
References: <20230817093231.2317-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

There are multiple places in gsm_control_command and gsm_control_reply that
derive the specific DLCI handle directly out of the DLCI table in gsm.

Add a local variable which holds this handle and use it instead to improve
code readability.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

v5 -> v6:
No changes.

Link: https://lore.kernel.org/all/20230517155704.5701-7-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 8b8f5187c6bb..fbef7977f775 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1451,15 +1451,16 @@ static int gsm_control_command(struct gsm_mux *gsm, int cmd, const u8 *data,
 			       int dlen)
 {
 	struct gsm_msg *msg;
+	struct gsm_dlci *dlci = gsm->dlci[0];
 
-	msg = gsm_data_alloc(gsm, 0, dlen + 2, gsm->dlci[0]->ftype);
+	msg = gsm_data_alloc(gsm, 0, dlen + 2, dlci->ftype);
 	if (msg == NULL)
 		return -ENOMEM;
 
 	msg->data[0] = (cmd << 1) | CR | EA;	/* Set C/R */
 	msg->data[1] = (dlen << 1) | EA;
 	memcpy(msg->data + 2, data, dlen);
-	gsm_data_queue(gsm->dlci[0], msg);
+	gsm_data_queue(dlci, msg);
 
 	return 0;
 }
@@ -1478,14 +1479,15 @@ static void gsm_control_reply(struct gsm_mux *gsm, int cmd, const u8 *data,
 					int dlen)
 {
 	struct gsm_msg *msg;
+	struct gsm_dlci *dlci = gsm->dlci[0];
 
-	msg = gsm_data_alloc(gsm, 0, dlen + 2, gsm->dlci[0]->ftype);
+	msg = gsm_data_alloc(gsm, 0, dlen + 2, dlci->ftype);
 	if (msg == NULL)
 		return;
 	msg->data[0] = (cmd & 0xFE) << 1 | EA;	/* Clear C/R */
 	msg->data[1] = (dlen << 1) | EA;
 	memcpy(msg->data + 2, data, dlen);
-	gsm_data_queue(gsm->dlci[0], msg);
+	gsm_data_queue(dlci, msg);
 }
 
 /**
-- 
2.34.1

