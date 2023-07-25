Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4483C760A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjGYGWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjGYGWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:22:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B564B10F6;
        Mon, 24 Jul 2023 23:22:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6CA1D224A7;
        Tue, 25 Jul 2023 06:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690266132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6fcCJ8Vaj3hw+RLNlHJQVq+19pva/3L/EmE633ig1ro=;
        b=RIVHnDBLwgYOGzjUJImXD776g6/L3dXdkZ9GEO++PzEi6SNOoRxuIMoAikI7MtGI8qcYhU
        FNNL1MEt0QK6jVQ37AfIqlKr4nKp7CRTF+dwpNQ6wfAHfO/87kI9bHVXK+4VXrfWu1W9AO
        BXo32OKzvcPHVPte++qAXzs6jmDJ/94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690266132;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6fcCJ8Vaj3hw+RLNlHJQVq+19pva/3L/EmE633ig1ro=;
        b=ge8KE8ofURsow9zmth6QZouNdbwU7CYsQ/otz52uAP80m/MKR8zH4iHeBGafRpirB/1Ul4
        f88iIf1Hjm5j4KAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F10E13342;
        Tue, 25 Jul 2023 06:22:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6FRaDhRqv2S0dQAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 25 Jul 2023 06:22:12 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] usb: gadget: midi2: MIDI 1.0 interface (altset 0) support
Date:   Tue, 25 Jul 2023 08:22:03 +0200
Message-Id: <20230725062206.9674-5-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230725062206.9674-1-tiwai@suse.de>
References: <20230725062206.9674-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends MIDI 2.0 function driver to add more proper support
for MIDI 1.0 interface.  Before this patch, the driver only exposes
the USB descriptor of a MIDI 1.0 interface in altset 0 while no actual
I/O is running for it.  This patch enables the actual I/O for the
altset 0; the backend UMP rawmidi is translated from/to the MIDI 1.0
USB commands.

For converting to USB MIDI 1.0 data protocol, a helper function is
copied from the existing f_midi driver, in addition to a few other UMP
Core helper functions.  For the MIDI 1.0 OUT (that is, input for
gadget), the incoming USB MIDI 1.0 packet is translated to UMP packets
via UMP Core helper, and tossed to the attached UMP rawmidi.  It's a
relatively straightforward.  OTOH, for MIDI 1.0 IN (i.e. output for
gadget), it's a bit more complex: we need to convert a source UMP
packet once to the standard MIDI 1.0 byte stream, and convert it again
to USB MIDI 1.0 packets, then send them out.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/usb/gadget/function/f_midi2.c | 494 +++++++++++++++++++++++---
 1 file changed, 452 insertions(+), 42 deletions(-)

diff --git a/drivers/usb/gadget/function/f_midi2.c b/drivers/usb/gadget/function/f_midi2.c
index b15d832ff441..a368ac51d349 100644
--- a/drivers/usb/gadget/function/f_midi2.c
+++ b/drivers/usb/gadget/function/f_midi2.c
@@ -11,6 +11,7 @@
 #include <sound/core.h>
 #include <sound/ump.h>
 #include <sound/ump_msg.h>
+#include <sound/ump_convert.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -50,6 +51,27 @@ struct f_midi2_block {
 	unsigned int string_id;		/* assigned string id */
 };
 
+/* Temporary buffer for altset 0 MIDI 1.0 handling */
+struct f_midi2_midi1_port {
+	unsigned int pending; /* pending bytes on the input buffer */
+	u8 buf[32];	/* raw MIDI 1.0 byte input */
+	u8 state;	/* running status */
+	u8 data[2];	/* rendered USB MIDI 1.0 packet data */
+};
+
+/* MIDI 1.0 message states */
+enum {
+	STATE_INITIAL = 0,	/* pseudo state */
+	STATE_1PARAM,
+	STATE_2PARAM_1,
+	STATE_2PARAM_2,
+	STATE_SYSEX_0,
+	STATE_SYSEX_1,
+	STATE_SYSEX_2,
+	STATE_REAL_TIME,
+	STATE_FINISHED,		/* pseudo state */
+};
+
 /* Resources for UMP Endpoint */
 struct f_midi2_ep {
 	struct snd_ump_endpoint *ump;	/* assigned UMP EP */
@@ -89,6 +111,11 @@ struct f_midi2 {
 	struct f_midi2_usb_ep midi1_ep_in;
 	struct f_midi2_usb_ep midi1_ep_out;
 
+	/* conversion for MIDI 1.0 EP-in */
+	struct f_midi2_midi1_port midi1_port[MAX_CABLES];
+	/* conversion for MIDI 1.0 EP-out */
+	struct ump_cvt_to_ump midi1_ump_cvt;
+
 	int midi_if;			/* USB MIDI interface number */
 	int operation_mode;		/* current operation mode */
 
@@ -707,12 +734,353 @@ static void f_midi2_ep_in_complete(struct usb_ep *usb_ep,
 	process_ump_transmit(ep);
 }
 
+/*
+ * MIDI1 (altset 0) USB request handling
+ */
+
+/* process one MIDI byte -- copied from f_midi.c
+ *
+ * fill the packet or request if needed
+ * returns true if the request became empty (queued)
+ */
+static bool process_midi1_byte(struct f_midi2 *midi2, u8 cable, u8 b,
+			       struct usb_request **req_p)
+{
+	struct f_midi2_midi1_port *port = &midi2->midi1_port[cable];
+	u8 p[4] = { cable << 4, 0, 0, 0 };
+	int next_state = STATE_INITIAL;
+	struct usb_request *req = *req_p;
+
+	switch (b) {
+	case 0xf8 ... 0xff:
+		/* System Real-Time Messages */
+		p[0] |= 0x0f;
+		p[1] = b;
+		next_state = port->state;
+		port->state = STATE_REAL_TIME;
+		break;
+
+	case 0xf7:
+		/* End of SysEx */
+		switch (port->state) {
+		case STATE_SYSEX_0:
+			p[0] |= 0x05;
+			p[1] = 0xf7;
+			next_state = STATE_FINISHED;
+			break;
+		case STATE_SYSEX_1:
+			p[0] |= 0x06;
+			p[1] = port->data[0];
+			p[2] = 0xf7;
+			next_state = STATE_FINISHED;
+			break;
+		case STATE_SYSEX_2:
+			p[0] |= 0x07;
+			p[1] = port->data[0];
+			p[2] = port->data[1];
+			p[3] = 0xf7;
+			next_state = STATE_FINISHED;
+			break;
+		default:
+			/* Ignore byte */
+			next_state = port->state;
+			port->state = STATE_INITIAL;
+		}
+		break;
+
+	case 0xf0 ... 0xf6:
+		/* System Common Messages */
+		port->data[0] = port->data[1] = 0;
+		port->state = STATE_INITIAL;
+		switch (b) {
+		case 0xf0:
+			port->data[0] = b;
+			port->data[1] = 0;
+			next_state = STATE_SYSEX_1;
+			break;
+		case 0xf1:
+		case 0xf3:
+			port->data[0] = b;
+			next_state = STATE_1PARAM;
+			break;
+		case 0xf2:
+			port->data[0] = b;
+			next_state = STATE_2PARAM_1;
+			break;
+		case 0xf4:
+		case 0xf5:
+			next_state = STATE_INITIAL;
+			break;
+		case 0xf6:
+			p[0] |= 0x05;
+			p[1] = 0xf6;
+			next_state = STATE_FINISHED;
+			break;
+		}
+		break;
+
+	case 0x80 ... 0xef:
+		/*
+		 * Channel Voice Messages, Channel Mode Messages
+		 * and Control Change Messages.
+		 */
+		port->data[0] = b;
+		port->data[1] = 0;
+		port->state = STATE_INITIAL;
+		if (b >= 0xc0 && b <= 0xdf)
+			next_state = STATE_1PARAM;
+		else
+			next_state = STATE_2PARAM_1;
+		break;
+
+	case 0x00 ... 0x7f:
+		/* Message parameters */
+		switch (port->state) {
+		case STATE_1PARAM:
+			if (port->data[0] < 0xf0)
+				p[0] |= port->data[0] >> 4;
+			else
+				p[0] |= 0x02;
+
+			p[1] = port->data[0];
+			p[2] = b;
+			/* This is to allow Running State Messages */
+			next_state = STATE_1PARAM;
+			break;
+		case STATE_2PARAM_1:
+			port->data[1] = b;
+			next_state = STATE_2PARAM_2;
+			break;
+		case STATE_2PARAM_2:
+			if (port->data[0] < 0xf0)
+				p[0] |= port->data[0] >> 4;
+			else
+				p[0] |= 0x03;
+
+			p[1] = port->data[0];
+			p[2] = port->data[1];
+			p[3] = b;
+			/* This is to allow Running State Messages */
+			next_state = STATE_2PARAM_1;
+			break;
+		case STATE_SYSEX_0:
+			port->data[0] = b;
+			next_state = STATE_SYSEX_1;
+			break;
+		case STATE_SYSEX_1:
+			port->data[1] = b;
+			next_state = STATE_SYSEX_2;
+			break;
+		case STATE_SYSEX_2:
+			p[0] |= 0x04;
+			p[1] = port->data[0];
+			p[2] = port->data[1];
+			p[3] = b;
+			next_state = STATE_SYSEX_0;
+			break;
+		}
+		break;
+	}
+
+	/* States where we have to write into the USB request */
+	if (next_state == STATE_FINISHED ||
+	    port->state == STATE_SYSEX_2 ||
+	    port->state == STATE_1PARAM ||
+	    port->state == STATE_2PARAM_2 ||
+	    port->state == STATE_REAL_TIME) {
+		memcpy(req->buf + req->length, p, sizeof(p));
+		req->length += sizeof(p);
+
+		if (next_state == STATE_FINISHED) {
+			next_state = STATE_INITIAL;
+			port->data[0] = port->data[1] = 0;
+		}
+
+		if (midi2->info.req_buf_size - req->length <= 4) {
+			queue_request_ep_raw(req);
+			*req_p = NULL;
+			return true;
+		}
+	}
+
+	port->state = next_state;
+	return false;
+}
+
+/* process all pending MIDI bytes in the internal buffer;
+ * returns true if the request gets empty
+ * returns false if all have been processed
+ */
+static bool process_midi1_pending_buf(struct f_midi2 *midi2,
+				      struct usb_request **req_p)
+{
+	unsigned int cable, c;
+
+	for (cable = 0; cable < midi2->midi2_eps[0].blks[0].info.num_groups;
+	     cable++) {
+		struct f_midi2_midi1_port *port = &midi2->midi1_port[cable];
+
+		if (!port->pending)
+			continue;
+		for (c = 0; c < port->pending; c++) {
+			if (process_midi1_byte(midi2, cable, port->buf[c],
+					       req_p)) {
+				port->pending -= c;
+				if (port->pending)
+					memmove(port->buf, port->buf + c,
+						port->pending);
+				return true;
+			}
+		}
+		port->pending = 0;
+	}
+
+	return false;
+}
+
+/* fill the MIDI bytes onto the temporary buffer
+ */
+static void fill_midi1_pending_buf(struct f_midi2 *midi2, u8 cable, u8 *buf,
+				   unsigned int size)
+{
+	struct f_midi2_midi1_port *port = &midi2->midi1_port[cable];
+
+	if (port->pending + size > sizeof(port->buf))
+		return;
+	memcpy(port->buf + port->pending, buf, size);
+	port->pending += size;
+}
+
+/* try to process data given from the associated UMP stream */
+static void process_midi1_transmit(struct f_midi2 *midi2)
+{
+	struct f_midi2_usb_ep *usb_ep = &midi2->midi1_ep_in;
+	struct f_midi2_ep *ep = &midi2->midi2_eps[0];
+	struct usb_request *req = NULL;
+	/* 12 is the largest outcome (4 MIDI1 cmds) for a single UMP packet */
+	unsigned char outbuf[12];
+	unsigned char group;
+	int len, size, cable;
+	u32 ump;
+
+	if (!usb_ep->usb_ep || !usb_ep->usb_ep->enabled)
+		return;
+
+	for (;;) {
+		if (!req) {
+			req = get_empty_request(usb_ep);
+			if (!req)
+				break;
+		}
+
+		if (process_midi1_pending_buf(midi2, &req))
+			continue;
+
+		len = snd_ump_transmit(ep->ump, &ump, 4);
+		if (len <= 0)
+			break;
+		if (snd_ump_receive_ump_val(ep->ump, ump) <= 0)
+			continue;
+		size = snd_ump_convert_from_ump(ep->ump->input_buf, outbuf,
+						&group);
+		if (size <= 0)
+			continue;
+		cable = group - ep->blks[0].info.first_group;
+		if (cable < 0 || cable >= ep->blks[0].info.num_groups)
+			continue;
+		fill_midi1_pending_buf(midi2, cable, outbuf, size);
+	}
+
+	if (req) {
+		if (req->length)
+			queue_request_ep_raw(req);
+		else
+			put_empty_request(req);
+	}
+}
+
+/* complete handler for MIDI1 EP-in requests */
+static void f_midi2_midi1_ep_in_complete(struct usb_ep *usb_ep,
+					 struct usb_request *req)
+{
+	struct f_midi2_req_ctx *ctx = req->context;
+	struct f_midi2 *midi2 = ctx->usb_ep->card;
+	int status = req->status;
+
+	put_empty_request(req);
+
+	if (status) {
+		DBG(midi2, "%s complete error %d: %d/%d\n",
+		    usb_ep->name, status, req->actual, req->length);
+		return;
+	}
+
+	process_midi1_transmit(midi2);
+}
+
+/* complete handler for MIDI1 EP-out requests */
+static void f_midi2_midi1_ep_out_complete(struct usb_ep *usb_ep,
+					  struct usb_request *req)
+{
+	struct f_midi2_req_ctx *ctx = req->context;
+	struct f_midi2 *midi2 = ctx->usb_ep->card;
+	struct f_midi2_ep *ep = &midi2->midi2_eps[0];
+	struct ump_cvt_to_ump *cvt = &midi2->midi1_ump_cvt;
+	static const u8 midi1_packet_bytes[16] = {
+		0, 0, 2, 3, 3, 1, 2, 3, 3, 3, 3, 3, 2, 2, 3, 1
+	};
+	unsigned int group, bytes, c, len;
+	int status = req->status;
+	const u8 *buf = req->buf;
+
+	if (status) {
+		DBG(midi2, "%s complete error %d: %d/%d\n",
+		    usb_ep->name, status, req->actual, req->length);
+		goto error;
+	}
+
+	len = req->actual >> 2;
+	for (; len; len--, buf += 4) {
+		group = *buf >> 4;
+		if (group >= ep->blks[0].info.num_groups)
+			continue;
+		group += ep->blks[0].info.first_group;
+		bytes = midi1_packet_bytes[*buf & 0x0f];
+		for (c = 0; c < bytes; c++) {
+			snd_ump_convert_to_ump(cvt, group, ep->info.protocol,
+					       buf[c + 1]);
+			if (cvt->ump_bytes) {
+				snd_ump_receive(ep->ump, cvt->ump,
+						cvt->ump_bytes);
+				cvt->ump_bytes = 0;
+			}
+		}
+	}
+
+	if (midi2->operation_mode != MIDI_OP_MODE_MIDI1)
+		goto error;
+
+	if (queue_request_ep_raw(req))
+		goto error;
+	return;
+
+ error:
+	put_empty_request(req);
+}
+
+/*
+ * Common EP handling helpers
+ */
+
 /* Start MIDI EP */
 static int f_midi2_start_ep(struct f_midi2_usb_ep *usb_ep,
 			    struct usb_function *fn)
 {
 	int err;
 
+	if (!usb_ep->usb_ep)
+		return 0;
+
 	usb_ep_disable(usb_ep->usb_ep);
 	err = config_ep_by_speed(usb_ep->card->gadget, fn, usb_ep->usb_ep);
 	if (err)
@@ -725,7 +1093,7 @@ static void f_midi2_drop_reqs(struct f_midi2_usb_ep *usb_ep)
 {
 	int i;
 
-	if (!usb_ep->num_reqs)
+	if (!usb_ep->usb_ep || !usb_ep->num_reqs)
 		return;
 
 	for (i = 0; i < usb_ep->num_reqs; i++) {
@@ -742,6 +1110,8 @@ static int f_midi2_alloc_ep_reqs(struct f_midi2_usb_ep *usb_ep)
 	struct f_midi2 *midi2 = usb_ep->card;
 	int i;
 
+	if (!usb_ep->usb_ep)
+		return 0;
 	if (!usb_ep->reqs)
 		return -EINVAL;
 
@@ -774,7 +1144,7 @@ static void f_midi2_free_ep_reqs(struct f_midi2_usb_ep *usb_ep)
 /* Initialize EP */
 static int f_midi2_init_ep(struct f_midi2 *midi2, struct f_midi2_ep *ep,
 			   struct f_midi2_usb_ep *usb_ep,
-			   void *desc, int num_reqs,
+			   void *desc,
 			   void (*complete)(struct usb_ep *usb_ep,
 					    struct usb_request *req))
 {
@@ -787,17 +1157,15 @@ static int f_midi2_init_ep(struct f_midi2 *midi2, struct f_midi2_ep *ep,
 		return -ENODEV;
 	usb_ep->complete = complete;
 
-	if (num_reqs) {
-		usb_ep->reqs = kcalloc(num_reqs, sizeof(*usb_ep->reqs),
-				       GFP_KERNEL);
-		if (!usb_ep->reqs)
-			return -ENOMEM;
-		for (i = 0; i < num_reqs; i++) {
-			usb_ep->reqs[i].index = i;
-			usb_ep->reqs[i].usb_ep = usb_ep;
-			set_bit(i, &usb_ep->free_reqs);
-			usb_ep->num_reqs++;
-		}
+	usb_ep->reqs = kcalloc(midi2->info.num_reqs, sizeof(*usb_ep->reqs),
+			       GFP_KERNEL);
+	if (!usb_ep->reqs)
+		return -ENOMEM;
+	for (i = 0; i < midi2->info.num_reqs; i++) {
+		usb_ep->reqs[i].index = i;
+		usb_ep->reqs[i].usb_ep = usb_ep;
+		set_bit(i, &usb_ep->free_reqs);
+		usb_ep->num_reqs++;
 	}
 
 	return 0;
@@ -821,6 +1189,9 @@ static void f_midi2_queue_out_reqs(struct f_midi2_usb_ep *usb_ep)
 {
 	int i, err;
 
+	if (!usb_ep->usb_ep)
+		return;
+
 	for (i = 0; i < usb_ep->num_reqs; i++) {
 		if (!test_bit(i, &usb_ep->free_reqs) || !usb_ep->reqs[i].req)
 			continue;
@@ -836,6 +1207,41 @@ static void f_midi2_queue_out_reqs(struct f_midi2_usb_ep *usb_ep)
  * Gadget Function callbacks
  */
 
+/* stop both IN and OUT EPs */
+static void f_midi2_stop_eps(struct f_midi2_usb_ep *ep_in,
+			     struct f_midi2_usb_ep *ep_out)
+{
+	f_midi2_drop_reqs(ep_in);
+	f_midi2_drop_reqs(ep_out);
+	f_midi2_free_ep_reqs(ep_in);
+	f_midi2_free_ep_reqs(ep_out);
+}
+
+/* start/queue both IN and OUT EPs */
+static int f_midi2_start_eps(struct f_midi2_usb_ep *ep_in,
+			     struct f_midi2_usb_ep *ep_out,
+			     struct usb_function *fn)
+{
+	int err;
+
+	err = f_midi2_start_ep(ep_in, fn);
+	if (err)
+		return err;
+	err = f_midi2_start_ep(ep_out, fn);
+	if (err)
+		return err;
+
+	err = f_midi2_alloc_ep_reqs(ep_in);
+	if (err)
+		return err;
+	err = f_midi2_alloc_ep_reqs(ep_out);
+	if (err)
+		return err;
+
+	f_midi2_queue_out_reqs(ep_out);
+	return 0;
+}
+
 /* gadget function set_alt callback */
 static int f_midi2_set_alt(struct usb_function *fn, unsigned int intf,
 			   unsigned int alt)
@@ -859,35 +1265,28 @@ static int f_midi2_set_alt(struct usb_function *fn, unsigned int intf,
 
 	midi2->operation_mode = op_mode;
 
+	if (op_mode != MIDI_OP_MODE_MIDI1)
+		f_midi2_stop_eps(&midi2->midi1_ep_in, &midi2->midi1_ep_out);
+
 	if (op_mode != MIDI_OP_MODE_MIDI2) {
 		for (i = 0; i < midi2->num_eps; i++) {
 			ep = &midi2->midi2_eps[i];
-			f_midi2_drop_reqs(&ep->ep_in);
-			f_midi2_drop_reqs(&ep->ep_out);
-			f_midi2_free_ep_reqs(&ep->ep_in);
-			f_midi2_free_ep_reqs(&ep->ep_out);
+			f_midi2_stop_eps(&ep->ep_in, &ep->ep_out);
 		}
-		return 0;
 	}
 
-	for (i = 0; i < midi2->num_eps; i++) {
-		ep = &midi2->midi2_eps[i];
+	if (op_mode == MIDI_OP_MODE_MIDI1)
+		return f_midi2_start_eps(&midi2->midi1_ep_in,
+					 &midi2->midi1_ep_out, fn);
 
-		err = f_midi2_start_ep(&ep->ep_in, fn);
-		if (err)
-			return err;
-		err = f_midi2_start_ep(&ep->ep_out, fn);
-		if (err)
-			return err;
+	if (op_mode == MIDI_OP_MODE_MIDI2) {
+		for (i = 0; i < midi2->num_eps; i++) {
+			ep = &midi2->midi2_eps[i];
 
-		err = f_midi2_alloc_ep_reqs(&ep->ep_in);
-		if (err)
-			return err;
-		err = f_midi2_alloc_ep_reqs(&ep->ep_out);
-		if (err)
-			return err;
-
-		f_midi2_queue_out_reqs(&ep->ep_out);
+			err = f_midi2_start_eps(&ep->ep_in, &ep->ep_out, fn);
+			if (err)
+				return err;
+		}
 	}
 
 	return 0;
@@ -1026,9 +1425,18 @@ static void f_midi2_ump_close(struct snd_ump_endpoint *ump, int dir)
 static void f_midi2_ump_trigger(struct snd_ump_endpoint *ump, int dir, int up)
 {
 	struct f_midi2_ep *ep = ump->private_data;
+	struct f_midi2 *midi2 = ep->card;
 
-	if (up && dir == SNDRV_RAWMIDI_STREAM_OUTPUT)
-		process_ump_transmit(ep);
+	if (up && dir == SNDRV_RAWMIDI_STREAM_OUTPUT) {
+		switch (midi2->operation_mode) {
+		case MIDI_OP_MODE_MIDI1:
+			process_midi1_transmit(midi2);
+			break;
+		case MIDI_OP_MODE_MIDI2:
+			process_ump_transmit(ep);
+			break;
+		}
+	}
 }
 
 static void f_midi2_ump_drain(struct snd_ump_endpoint *ump, int dir)
@@ -1160,8 +1568,8 @@ struct f_midi2_usb_config {
 
 	/* MIDI 1.0 jacks */
 	unsigned char jack_in, jack_out, jack_id;
-	struct usb_midi_in_jack_descriptor jack_ins[16];
-	struct usb_midi_out_jack_descriptor_1 jack_outs[16];
+	struct usb_midi_in_jack_descriptor jack_ins[MAX_CABLES];
+	struct usb_midi_out_jack_descriptor_1 jack_outs[MAX_CABLES];
 };
 
 static int append_config(struct f_midi2_usb_config *config, void *d)
@@ -1422,7 +1830,7 @@ static int f_midi2_init_midi2_ep_in(struct f_midi2 *midi2, int index)
 	fill_midi2_class_desc(ep, &midi2_midi2_ep_in_class_desc[index]);
 
 	return f_midi2_init_ep(midi2, ep, &ep->ep_in, desc,
-			       midi2->info.num_reqs, f_midi2_ep_in_complete);
+			       f_midi2_ep_in_complete);
 }
 
 /* initialize MIDI2 EP-out */
@@ -1439,7 +1847,7 @@ static int f_midi2_init_midi2_ep_out(struct f_midi2 *midi2, int index)
 	fill_midi2_class_desc(ep, &midi2_midi2_ep_out_class_desc[index]);
 
 	return f_midi2_init_ep(midi2, ep, &ep->ep_out, desc,
-			       midi2->info.num_reqs, f_midi2_ep_out_complete);
+			       f_midi2_ep_out_complete);
 }
 
 /* gadget function bind callback */
@@ -1504,14 +1912,16 @@ static int f_midi2_bind(struct usb_configuration *c, struct usb_function *f)
 	/* allocate instance-specific endpoints */
 	if (midi2->midi2_eps[0].blks[0].info.direction != SNDRV_UMP_DIR_OUTPUT) {
 		status = f_midi2_init_ep(midi2, NULL, &midi2->midi1_ep_in,
-					 &midi2_midi1_ep_in_desc, 0, NULL);
+					 &midi2_midi1_ep_in_desc,
+					 f_midi2_midi1_ep_in_complete);
 		if (status)
 			goto fail;
 	}
 
 	if (midi2->midi2_eps[0].blks[0].info.direction != SNDRV_UMP_DIR_INPUT) {
 		status = f_midi2_init_ep(midi2, NULL, &midi2->midi1_ep_out,
-					 &midi2_midi1_ep_out_desc, 0, NULL);
+					 &midi2_midi1_ep_out_desc,
+					 f_midi2_midi1_ep_out_complete);
 		if (status)
 			goto fail;
 	}
-- 
2.35.3

