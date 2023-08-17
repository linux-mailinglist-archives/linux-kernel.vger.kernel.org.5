Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E7677F375
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349681AbjHQJdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349715AbjHQJdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:33:02 -0400
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6D32D63
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:33:00 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023081709330002d0f7c9ac78f970cd
        for <linux-kernel@vger.kernel.org>;
        Thu, 17 Aug 2023 11:33:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=i7oqPyKwXlHPCywflYWJCMT+4GZ0e0+uD/yAATpryKs=;
 b=IIZ5pLb/f5pRoNI8Ii7dVb8qAzQLt9fl5M0OV2jSZAQzBHc4rNNBEycHX8Z7a6Fl7mRuar
 pCPIQ8L60v7ZfhO55EynQRtXsZornr3Sj/EEtsD1pkcz49FXOT8BGWxLXQOLjz6IgNaCAjsr
 IfZ8tlyIOHHQ9VNENS/fpU2qFR8vs=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v6 8/9] tty: n_gsm: add DLCI specific rx/tx statistics
Date:   Thu, 17 Aug 2023 11:32:30 +0200
Message-Id: <20230817093231.2317-8-daniel.starke@siemens.com>
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

Add counters for the number of data bytes received/transmitted per DLCI in
for preparation for an upcoming patch which will expose these values to the
user.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

v5 -> v6:
No changes.

Link: https://lore.kernel.org/all/20230517155704.5701-8-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index fbef7977f775..47905803f8f9 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -186,6 +186,10 @@ struct gsm_dlci {
 	void (*data)(struct gsm_dlci *dlci, const u8 *data, int len);
 	void (*prev_data)(struct gsm_dlci *dlci, const u8 *data, int len);
 	struct net_device *net; /* network interface, if created */
+
+	/* Statistics (not currently exposed) */
+	u64 tx;			/* Data bytes sent on this DLCI */
+	u64 rx;			/* Data bytes received on this DLCI */
 };
 
 /*
@@ -1216,6 +1220,7 @@ static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 	tty_port_tty_wakeup(&dlci->port);
 
 	__gsm_data_queue(dlci, msg);
+	dlci->tx += len;
 	/* Bytes of data we used up */
 	return size;
 }
@@ -1283,6 +1288,7 @@ static int gsm_dlci_data_output_framed(struct gsm_mux *gsm,
 	memcpy(dp, dlci->skb->data, len);
 	skb_pull(dlci->skb, len);
 	__gsm_data_queue(dlci, msg);
+	dlci->tx += len;
 	if (last) {
 		dev_kfree_skb_any(dlci->skb);
 		dlci->skb = NULL;
@@ -1461,6 +1467,7 @@ static int gsm_control_command(struct gsm_mux *gsm, int cmd, const u8 *data,
 	msg->data[1] = (dlen << 1) | EA;
 	memcpy(msg->data + 2, data, dlen);
 	gsm_data_queue(dlci, msg);
+	dlci->tx += dlen;
 
 	return 0;
 }
@@ -1488,6 +1495,7 @@ static void gsm_control_reply(struct gsm_mux *gsm, int cmd, const u8 *data,
 	msg->data[1] = (dlen << 1) | EA;
 	memcpy(msg->data + 2, data, dlen);
 	gsm_data_queue(dlci, msg);
+	dlci->tx += dlen;
 }
 
 /**
@@ -1852,10 +1860,13 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 						const u8 *data, int clen)
 {
 	u8 buf[1];
+	struct gsm_dlci *dlci = gsm->dlci[0];
+
+	if (dlci)
+		dlci->rx += clen;
 
 	switch (command) {
 	case CMD_CLD: {
-		struct gsm_dlci *dlci = gsm->dlci[0];
 		/* Modem wishes to close down */
 		if (dlci) {
 			dlci->dead = true;
@@ -1934,6 +1945,8 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
 
 	ctrl = gsm->pending_cmd;
 	dlci = gsm->dlci[0];
+	if (dlci)
+		dlci->rx += clen;
 	command |= 1;
 	/* Does the reply match our command */
 	if (ctrl != NULL && (command == ctrl->cmd || command == CMD_NSC)) {
@@ -2298,6 +2311,9 @@ static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
 			need_pn = true;
 	}
 
+	dlci->tx = 0;
+	dlci->rx = 0;
+
 	switch (dlci->state) {
 	case DLCI_CLOSED:
 	case DLCI_WAITING_CONFIG:
@@ -2330,6 +2346,9 @@ static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
  */
 static void gsm_dlci_set_opening(struct gsm_dlci *dlci)
 {
+	dlci->tx = 0;
+	dlci->rx = 0;
+
 	switch (dlci->state) {
 	case DLCI_CLOSED:
 	case DLCI_WAITING_CONFIG:
@@ -2349,6 +2368,9 @@ static void gsm_dlci_set_opening(struct gsm_dlci *dlci)
  */
 static void gsm_dlci_set_wait_config(struct gsm_dlci *dlci)
 {
+	dlci->tx = 0;
+	dlci->rx = 0;
+
 	switch (dlci->state) {
 	case DLCI_CLOSED:
 	case DLCI_CLOSING:
@@ -2425,6 +2447,7 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
 		fallthrough;
 	case 1:		/* Line state will go via DLCI 0 controls only */
 	default:
+		dlci->rx += clen;
 		tty_insert_flip_string(port, data, clen);
 		tty_flip_buffer_push(port);
 	}
@@ -2785,6 +2808,7 @@ static void gsm_queue(struct gsm_mux *gsm)
 			gsm->open_error++;
 			return;
 		}
+		dlci->rx += gsm->len;
 		if (dlci->dead)
 			gsm_response(gsm, address, DM|PF);
 		else {
-- 
2.34.1

