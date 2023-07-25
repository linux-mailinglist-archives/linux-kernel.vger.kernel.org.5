Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2754760A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjGYGW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjGYGWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:22:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917F310E2;
        Mon, 24 Jul 2023 23:22:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 390192249D;
        Tue, 25 Jul 2023 06:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690266132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NRKx0VeOYoR12sVFtMBeiLGHl5ooEUwXfcy64qyVtcY=;
        b=zw/9WulH1Jlb9JoRC09Al9CXvMWAqtlYioidBpO2WxNFBPVwFIdjwsjHikb/w6UKv7Z8RE
        HleebipqFnEHZ44/a9u7qH2F4a6zauaujpZU7jMcNnTiiQ+OT28WGOdspBQOpdsXDoAja7
        CykYNzJG8n1wakESfkoC+N67IqdvSgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690266132;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NRKx0VeOYoR12sVFtMBeiLGHl5ooEUwXfcy64qyVtcY=;
        b=DzLAgFUkmNyD91roXAO9nQVKgMidL+Zk8vVs087iYNL2yC6oL4eh+a3h8P0tp+0rbzrsiw
        +D2lyu7amGk8giBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D6C813342;
        Tue, 25 Jul 2023 06:22:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yANkAhRqv2S0dQAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 25 Jul 2023 06:22:12 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] usb: gadget: midi2: Dynamically create MIDI 1.0 altset descriptors
Date:   Tue, 25 Jul 2023 08:22:02 +0200
Message-Id: <20230725062206.9674-4-tiwai@suse.de>
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

This patch extends MIDI 2.0 function driver to deal with more MIDI1
Jacks depending on the given Block configuration.

For MIDI 1.0, we take the configuration given in Function Block 0, and
create MIDI Jacks and Endpoints depending on the definition there.
That is, when more UMP Groups are defined in the Block 0, the
corresponding MIDI1 Jacks will be created.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/usb/gadget/function/f_midi2.c | 228 ++++++++++++++++++--------
 1 file changed, 157 insertions(+), 71 deletions(-)

diff --git a/drivers/usb/gadget/function/f_midi2.c b/drivers/usb/gadget/function/f_midi2.c
index c68a6fa0d237..b15d832ff441 100644
--- a/drivers/usb/gadget/function/f_midi2.c
+++ b/drivers/usb/gadget/function/f_midi2.c
@@ -151,7 +151,7 @@ static struct usb_ms20_gr_trm_block_descriptor gtb_desc = {
 };
 
 DECLARE_USB_MIDI_OUT_JACK_DESCRIPTOR(1);
-DECLARE_USB_MS_ENDPOINT_DESCRIPTOR(1);
+DECLARE_USB_MS_ENDPOINT_DESCRIPTOR(16);
 DECLARE_UAC_AC_HEADER_DESCRIPTOR(1);
 DECLARE_USB_MS20_ENDPOINT_DESCRIPTOR(32);
 
@@ -185,7 +185,7 @@ static struct usb_interface_descriptor midi2_midi1_if_desc = {
 	.bDescriptorType =	USB_DT_INTERFACE,
 	.bInterfaceNumber =	0, // to be filled
 	.bAlternateSetting =	0,
-	.bNumEndpoints =	2,
+	.bNumEndpoints =	2, // to be filled
 	.bInterfaceClass =	USB_CLASS_AUDIO,
 	.bInterfaceSubClass =	USB_SUBCLASS_MIDISTREAMING,
 	.bInterfaceProtocol =	0,
@@ -200,50 +200,6 @@ static struct usb_ms_header_descriptor midi2_midi1_class_desc = {
 	.wTotalLength =		__cpu_to_le16(0x41), // to be calculated
 };
 
-/* MIDI 1.0 IN (Embedded) Jack */
-static struct usb_midi_in_jack_descriptor midi2_midi1_in_jack1_desc = {
-	.bLength =		0x06,
-	.bDescriptorType =	USB_DT_CS_INTERFACE,
-	.bDescriptorSubtype =	USB_MS_MIDI_IN_JACK,
-	.bJackType =		USB_MS_EMBEDDED,
-	.bJackID =		0x01,
-	.iJack =		0,
-};
-
-/* MIDI 1.0 IN (External) Jack */
-static struct usb_midi_in_jack_descriptor midi2_midi1_in_jack2_desc = {
-	.bLength =		0x06,
-	.bDescriptorType =	USB_DT_CS_INTERFACE,
-	.bDescriptorSubtype =	USB_MS_MIDI_IN_JACK,
-	.bJackType =		USB_MS_EXTERNAL,
-	.bJackID =		0x02,
-	.iJack =		0,
-};
-
-/* MIDI 1.0 OUT (Embedded) Jack */
-static struct usb_midi_out_jack_descriptor_1 midi2_midi1_out_jack1_desc = {
-	.bLength =		0x09,
-	.bDescriptorType =	USB_DT_CS_INTERFACE,
-	.bDescriptorSubtype =	USB_MS_MIDI_OUT_JACK,
-	.bJackType =		USB_MS_EMBEDDED,
-	.bJackID =		0x03,
-	.bNrInputPins =		1,
-	.pins =			{ { 0x02, 0x01 } },
-	.iJack =		0,
-};
-
-/* MIDI 1.0 OUT (External) Jack */
-static struct usb_midi_out_jack_descriptor_1 midi2_midi1_out_jack2_desc = {
-	.bLength =		0x09,
-	.bDescriptorType =	USB_DT_CS_INTERFACE,
-	.bDescriptorSubtype =	USB_MS_MIDI_OUT_JACK,
-	.bJackType =		USB_MS_EXTERNAL,
-	.bJackID =		0x04,
-	.bNrInputPins =		1,
-	.pins =			{ { 0x01, 0x01 } },
-	.iJack =		0,
-};
-
 /* MIDI 1.0 EP OUT */
 static struct usb_endpoint_descriptor midi2_midi1_ep_out_desc = {
 	.bLength =		USB_DT_ENDPOINT_AUDIO_SIZE,
@@ -257,8 +213,8 @@ static struct usb_ss_ep_comp_descriptor midi2_midi1_ep_out_ss_comp_desc = {
 	.bDescriptorType        = USB_DT_SS_ENDPOINT_COMP,
 };
 
-static struct usb_ms_endpoint_descriptor_1 midi2_midi1_ep_out_class_desc = {
-	.bLength =		0x05,
+static struct usb_ms_endpoint_descriptor_16 midi2_midi1_ep_out_class_desc = {
+	.bLength =		0x05, // to be filled
 	.bDescriptorType =	USB_DT_CS_ENDPOINT,
 	.bDescriptorSubtype =	USB_MS_GENERAL,
 	.bNumEmbMIDIJack =	1,
@@ -278,8 +234,8 @@ static struct usb_ss_ep_comp_descriptor midi2_midi1_ep_in_ss_comp_desc = {
 	.bDescriptorType        = USB_DT_SS_ENDPOINT_COMP,
 };
 
-static struct usb_ms_endpoint_descriptor_1 midi2_midi1_ep_in_class_desc = {
-	.bLength =		0x05,
+static struct usb_ms_endpoint_descriptor_16 midi2_midi1_ep_in_class_desc = {
+	.bLength =		0x05, // to be filled
 	.bDescriptorType =	USB_DT_CS_ENDPOINT,
 	.bDescriptorSubtype =	USB_MS_GENERAL,
 	.bNumEmbMIDIJack =	1,
@@ -337,25 +293,29 @@ static void *midi2_audio_descs[] = {
 static void *midi2_midi1_descs[] = {
 	&midi2_midi1_if_desc,
 	&midi2_midi1_class_desc,
-	&midi2_midi1_in_jack1_desc,
-	&midi2_midi1_in_jack2_desc,
-	&midi2_midi1_out_jack1_desc,
-	&midi2_midi1_out_jack2_desc,
 	NULL
 };
 
-static void *midi2_midi1_ep_descs[] = {
+static void *midi2_midi1_ep_out_descs[] = {
 	&midi2_midi1_ep_out_desc,
 	&midi2_midi1_ep_out_class_desc,
+	NULL
+};
+
+static void *midi2_midi1_ep_in_descs[] = {
 	&midi2_midi1_ep_in_desc,
 	&midi2_midi1_ep_in_class_desc,
 	NULL
 };
 
-static void *midi2_midi1_ep_ss_descs[] = {
+static void *midi2_midi1_ep_out_ss_descs[] = {
 	&midi2_midi1_ep_out_desc,
 	&midi2_midi1_ep_out_ss_comp_desc,
 	&midi2_midi1_ep_out_class_desc,
+	NULL
+};
+
+static void *midi2_midi1_ep_in_ss_descs[] = {
 	&midi2_midi1_ep_in_desc,
 	&midi2_midi1_ep_in_ss_comp_desc,
 	&midi2_midi1_ep_in_class_desc,
@@ -1197,6 +1157,11 @@ struct f_midi2_usb_config {
 	struct usb_descriptor_header **list;
 	unsigned int size;
 	unsigned int alloc;
+
+	/* MIDI 1.0 jacks */
+	unsigned char jack_in, jack_out, jack_id;
+	struct usb_midi_in_jack_descriptor jack_ins[16];
+	struct usb_midi_out_jack_descriptor_1 jack_outs[16];
 };
 
 static int append_config(struct f_midi2_usb_config *config, void *d)
@@ -1231,12 +1196,61 @@ static int append_configs(struct f_midi2_usb_config *config, void **d)
 	return 0;
 }
 
+static int append_midi1_in_jack(struct f_midi2 *midi2,
+				struct f_midi2_usb_config *config,
+				unsigned int type)
+{
+	struct usb_midi_in_jack_descriptor *jack =
+		&config->jack_ins[config->jack_in++];
+	int id = ++config->jack_id;
+	int err;
+
+	jack->bLength = 0x06;
+	jack->bDescriptorType = USB_DT_CS_INTERFACE;
+	jack->bDescriptorSubtype = USB_MS_MIDI_IN_JACK;
+	jack->bJackType = type;
+	jack->bJackID = id;
+	jack->iJack = midi2->strings[STR_GTB1].id; // TODO: better names?
+
+	err = append_config(config, jack);
+	if (err < 0)
+		return err;
+	return id;
+}
+
+static int append_midi1_out_jack(struct f_midi2 *midi2,
+				 struct f_midi2_usb_config *config,
+				 unsigned int type, unsigned int source)
+{
+	struct usb_midi_out_jack_descriptor_1 *jack =
+		&config->jack_outs[config->jack_out++];
+	int id = ++config->jack_id;
+	int err;
+
+	jack->bLength = 0x09;
+	jack->bDescriptorType = USB_DT_CS_INTERFACE;
+	jack->bDescriptorSubtype = USB_MS_MIDI_OUT_JACK;
+	jack->bJackType = type;
+	jack->bJackID = id;
+	jack->bNrInputPins = 1;
+	jack->pins[0].baSourceID = source;
+	jack->pins[0].baSourcePin = 0x01;
+	jack->iJack = midi2->strings[STR_GTB1].id; // TODO: better names?
+
+	err = append_config(config, jack);
+	if (err < 0)
+		return err;
+	return id;
+}
+
 static int f_midi2_create_usb_configs(struct f_midi2 *midi2,
 				      struct f_midi2_usb_config *config,
 				      int speed)
 {
-	void **midi1_eps;
-	int i, err;
+	struct f_midi2_block *blk = &midi2->midi2_eps[0].blks[0];
+	void **midi1_in_eps, **midi1_out_eps;
+	int i, jack, total;
+	int err;
 
 	switch (speed) {
 	default:
@@ -1248,7 +1262,8 @@ static int f_midi2_create_usb_configs(struct f_midi2 *midi2,
 				cpu_to_le16(512);
 		fallthrough;
 	case USB_SPEED_FULL:
-		midi1_eps = midi2_midi1_ep_descs;
+		midi1_in_eps = midi2_midi1_ep_in_descs;
+		midi1_out_eps = midi2_midi1_ep_out_descs;
 		break;
 	case USB_SPEED_SUPER:
 	case USB_SPEED_SUPER_PLUS:
@@ -1257,19 +1272,85 @@ static int f_midi2_create_usb_configs(struct f_midi2 *midi2,
 		for (i = 0; i < midi2->num_eps; i++)
 			midi2_midi2_ep_out_desc[i].wMaxPacketSize =
 				cpu_to_le16(1024);
-		midi1_eps = midi2_midi1_ep_ss_descs;
+		midi1_in_eps = midi2_midi1_ep_in_ss_descs;
+		midi1_out_eps = midi2_midi1_ep_out_ss_descs;
 		break;
 	}
 
 	err = append_configs(config, midi2_audio_descs);
 	if (err < 0)
 		return err;
+
+	switch (blk->info.direction) {
+	case SNDRV_UMP_DIR_INPUT:
+	case SNDRV_UMP_DIR_OUTPUT:
+		midi2_midi1_if_desc.bNumEndpoints = 1;
+		break;
+	default:
+		midi2_midi1_if_desc.bNumEndpoints = 2;
+		break;
+	}
+
 	err = append_configs(config, midi2_midi1_descs);
 	if (err < 0)
 		return err;
-	err = append_configs(config, midi1_eps);
-	if (err < 0)
-		return err;
+
+	total = USB_DT_MS_HEADER_SIZE;
+	if (blk->info.direction != SNDRV_UMP_DIR_INPUT) {
+		midi2_midi1_ep_out_class_desc.bLength =
+			USB_DT_MS_ENDPOINT_SIZE(blk->info.num_groups);
+		total += midi2_midi1_ep_out_class_desc.bLength;
+		midi2_midi1_ep_out_class_desc.bNumEmbMIDIJack =
+			blk->info.num_groups;
+		total += blk->info.num_groups *
+			(USB_DT_MIDI_IN_SIZE + USB_DT_MIDI_OUT_SIZE(1));
+		for (i = 0; i < blk->info.num_groups; i++) {
+			jack = append_midi1_in_jack(midi2, config,
+						    USB_MS_EMBEDDED);
+			if (jack < 0)
+				return jack;
+			midi2_midi1_ep_out_class_desc.baAssocJackID[i] = jack;
+			jack = append_midi1_out_jack(midi2, config,
+						     USB_MS_EXTERNAL, jack);
+			if (jack < 0)
+				return jack;
+		}
+	}
+
+	if (blk->info.direction != SNDRV_UMP_DIR_OUTPUT) {
+		midi2_midi1_ep_in_class_desc.bLength =
+			USB_DT_MS_ENDPOINT_SIZE(blk->info.num_groups);
+		total += midi2_midi1_ep_in_class_desc.bLength;
+		midi2_midi1_ep_in_class_desc.bNumEmbMIDIJack =
+			blk->info.num_groups;
+		total += blk->info.num_groups *
+			(USB_DT_MIDI_IN_SIZE + USB_DT_MIDI_OUT_SIZE(1));
+		for (i = 0; i < blk->info.num_groups; i++) {
+			jack = append_midi1_in_jack(midi2, config,
+						    USB_MS_EXTERNAL);
+			if (jack < 0)
+				return jack;
+			jack = append_midi1_out_jack(midi2, config,
+						     USB_MS_EMBEDDED, jack);
+			if (jack < 0)
+				return jack;
+			midi2_midi1_ep_in_class_desc.baAssocJackID[i] = jack;
+		}
+	}
+
+	midi2_midi1_class_desc.wTotalLength = cpu_to_le16(total);
+
+	if (blk->info.direction != SNDRV_UMP_DIR_INPUT) {
+		err = append_configs(config, midi1_out_eps);
+		if (err < 0)
+			return err;
+	}
+	if (blk->info.direction != SNDRV_UMP_DIR_OUTPUT) {
+		err = append_configs(config, midi1_in_eps);
+		if (err < 0)
+			return err;
+	}
+
 	err = append_configs(config, midi2_midi2_descs);
 	if (err < 0)
 		return err;
@@ -1421,14 +1502,19 @@ static int f_midi2_bind(struct usb_configuration *c, struct usb_function *f)
 	midi2_audio_class_desc.baInterfaceNr[0] = status;
 
 	/* allocate instance-specific endpoints */
-	status = f_midi2_init_ep(midi2, NULL, &midi2->midi1_ep_in,
-				 &midi2_midi1_ep_in_desc, 0, NULL);
-	if (status)
-		goto fail;
-	status = f_midi2_init_ep(midi2, NULL, &midi2->midi1_ep_out,
-				 &midi2_midi1_ep_out_desc, 0, NULL);
-	if (status)
-		goto fail;
+	if (midi2->midi2_eps[0].blks[0].info.direction != SNDRV_UMP_DIR_OUTPUT) {
+		status = f_midi2_init_ep(midi2, NULL, &midi2->midi1_ep_in,
+					 &midi2_midi1_ep_in_desc, 0, NULL);
+		if (status)
+			goto fail;
+	}
+
+	if (midi2->midi2_eps[0].blks[0].info.direction != SNDRV_UMP_DIR_INPUT) {
+		status = f_midi2_init_ep(midi2, NULL, &midi2->midi1_ep_out,
+					 &midi2_midi1_ep_out_desc, 0, NULL);
+		if (status)
+			goto fail;
+	}
 
 	for (i = 0; i < midi2->num_eps; i++) {
 		status = f_midi2_init_midi2_ep_in(midi2, i);
-- 
2.35.3

