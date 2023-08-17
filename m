Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1322677F36B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349650AbjHQJd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349709AbjHQJdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:33:01 -0400
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E61F271B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:32:59 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230817093257cb57e848875a738da7
        for <linux-kernel@vger.kernel.org>;
        Thu, 17 Aug 2023 11:32:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=cWnaEzHZB2NjApMzdcxbIVj2X9/vD3Wo52v6lawLu5o=;
 b=BjQhg8yWdxUIZMHZYs7BNroMy2bJ6XpYeu+Qwc40iQ3UFrobiyDqoZkhqIw15h2i1kvoRJ
 hKqM1yyex8MwFfudRdGGmwz7YzBoXWzDUwhl3dX4Sd52fmu0euSD+QvS74kFwmzbRJ8vpcuB
 8IIOydYpY9f8aLH5cL5glc92zYml0=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v6 4/9] tty: n_gsm: add open_error counter to gsm_mux
Date:   Thu, 17 Aug 2023 11:32:26 +0200
Message-Id: <20230817093231.2317-4-daniel.starke@siemens.com>
In-Reply-To: <20230817093231.2317-1-daniel.starke@siemens.com>
References: <20230817093231.2317-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Extend the n_gsm link statistics by a failed link open counter in
preparation for an upcoming patch which will expose these.
This counter is increased whenever an attempt to open the control channel
failed. This is true in the following cases:
- new DLCI allocation failed
- connection request (SAMB) with invalid CR flag has been received
- connection response (UA) timed out
- parameter negotiation timed out or failed

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

v5 -> v6:
No changes.

Link: https://lore.kernel.org/all/20230517155704.5701-4-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index f6d3c4766e47..d28465f142a8 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -339,6 +339,7 @@ struct gsm_mux {
 	unsigned long bad_fcs;
 	unsigned long malformed;
 	unsigned long io_error;
+	unsigned long open_error;
 	unsigned long bad_size;
 	unsigned long unsupported;
 };
@@ -1730,25 +1731,32 @@ static void gsm_control_negotiation(struct gsm_mux *gsm, unsigned int cr,
 	struct gsm_dlci *dlci;
 	struct gsm_dlci_param_bits *params;
 
-	if (dlen < sizeof(struct gsm_dlci_param_bits))
+	if (dlen < sizeof(struct gsm_dlci_param_bits)) {
+		gsm->open_error++;
 		return;
+	}
 
 	/* Invalid DLCI? */
 	params = (struct gsm_dlci_param_bits *)data;
 	addr = FIELD_GET(PN_D_FIELD_DLCI, params->d_bits);
-	if (addr == 0 || addr >= NUM_DLCI || !gsm->dlci[addr])
+	if (addr == 0 || addr >= NUM_DLCI || !gsm->dlci[addr]) {
+		gsm->open_error++;
 		return;
+	}
 	dlci = gsm->dlci[addr];
 
 	/* Too late for parameter negotiation? */
-	if ((!cr && dlci->state == DLCI_OPENING) || dlci->state == DLCI_OPEN)
+	if ((!cr && dlci->state == DLCI_OPENING) || dlci->state == DLCI_OPEN) {
+		gsm->open_error++;
 		return;
+	}
 
 	/* Process the received parameters */
 	if (gsm_process_negotiation(gsm, addr, cr, params) != 0) {
 		/* Negotiation failed. Close the link. */
 		if (debug & DBG_ERRORS)
 			pr_info("%s PN failed\n", __func__);
+		gsm->open_error++;
 		gsm_dlci_close(dlci);
 		return;
 	}
@@ -1768,6 +1776,7 @@ static void gsm_control_negotiation(struct gsm_mux *gsm, unsigned int cr,
 	} else {
 		if (debug & DBG_ERRORS)
 			pr_info("%s PN in invalid state\n", __func__);
+		gsm->open_error++;
 	}
 }
 
@@ -2221,6 +2230,7 @@ static void gsm_dlci_t1(struct timer_list *t)
 			dlci->retries--;
 			mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
 		} else {
+			gsm->open_error++;
 			gsm_dlci_begin_close(dlci); /* prevent half open link */
 		}
 		break;
@@ -2236,6 +2246,7 @@ static void gsm_dlci_t1(struct timer_list *t)
 			dlci->mode = DLCI_MODE_ADM;
 			gsm_dlci_open(dlci);
 		} else {
+			gsm->open_error++;
 			gsm_dlci_begin_close(dlci); /* prevent half open link */
 		}
 
@@ -2757,12 +2768,16 @@ static void gsm_queue(struct gsm_mux *gsm)
 
 	switch (gsm->control) {
 	case SABM|PF:
-		if (cr == 1)
+		if (cr == 1) {
+			gsm->open_error++;
 			goto invalid;
+		}
 		if (dlci == NULL)
 			dlci = gsm_dlci_alloc(gsm, address);
-		if (dlci == NULL)
+		if (dlci == NULL) {
+			gsm->open_error++;
 			return;
+		}
 		if (dlci->dead)
 			gsm_response(gsm, address, DM|PF);
 		else {
-- 
2.34.1

