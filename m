Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B86760A42
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjGYGWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjGYGWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:22:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CAE199F;
        Mon, 24 Jul 2023 23:22:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EDEEB1FD5F;
        Tue, 25 Jul 2023 06:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690266132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8zpF+SUkasNIWZkOfvZPls/jKPiZoHAEyqDm14jWo0I=;
        b=FPbrBhG1xYDJ0nukBafO+w9XnYaYRRIJP+tHjBzL3ZxiEgOztLNp1BTEgOCnnWqS2kraE3
        o+d4p4LIIsIfJo9FKKpe+O/E9r/NlwWrTOUqY8mHYilgrZWTpOkFtNZ3FbHWdmL0uXG8Dx
        ERwjP6v5kMJ30fmN8hLk3zuztjONolg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690266132;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8zpF+SUkasNIWZkOfvZPls/jKPiZoHAEyqDm14jWo0I=;
        b=2QK4mNqYOktfyFo9ydlm3Y3pDHY9KYqGe51P+fTRPJxQMJbVqm59sSUBBwE8+7Ml8oQ5Im
        R4Zbme2YdE3JAUAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1EF71390F;
        Tue, 25 Jul 2023 06:22:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cIyOLhRqv2S0dQAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 25 Jul 2023 06:22:12 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] usb: gadget: midi2: More flexible MIDI 1.0 configuration
Date:   Tue, 25 Jul 2023 08:22:06 +0200
Message-Id: <20230725062206.9674-8-tiwai@suse.de>
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

This patch allows users to set up MIDI 1.0 ports more flexibly.
Namely, instead of the fixed mapping only from FB 0, now multiple
block definitions are applied to build up the MIDI 1.0 mapping.

The each block config has midi1_first_group and midi1_num_groups
attributes, and those specify which Groups are used for MIDI 1.0.
Those fields must be within the UMP Groups defined in the block
itself.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../ABI/testing/configfs-usb-gadget-midi2     |  24 +--
 Documentation/usb/gadget-testing.rst          |  34 ++--
 drivers/usb/gadget/function/f_midi2.c         | 154 ++++++++++++++----
 drivers/usb/gadget/function/u_midi2.h         |   2 +
 4 files changed, 153 insertions(+), 61 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-midi2 b/Documentation/ABI/testing/configfs-usb-gadget-midi2
index a3a036d784c7..0eac3aaba137 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-midi2
+++ b/Documentation/ABI/testing/configfs-usb-gadget-midi2
@@ -39,14 +39,16 @@ Description:
 
 		The attributes:
 
-		===============	===============================================
-		name		Function Block name string
-		direction	1: input, 2: output, 3: bidirectional
-		first_group	The first UMP Group number (0-15)
-		num_groups	The number of groups in this FB (1-16)
-		ui_hint		0: unknown, 1: receiver, 2: sender, 3: both
-		midi_ci_verison	Supported MIDI-CI version number (8 bit)
-		is_midi1	Legacy MIDI 1.0 device (0, 1 or 2)
-		sysex8_streams	Max number of SysEx8 streams (8 bit)
-		active		Active FB flag (0 or 1)
-		===============	===============================================
+		=================	==============================================
+		name			Function Block name string
+		direction		1: input, 2: output, 3: bidirectional
+		first_group		The first UMP Group number (0-15)
+		num_groups		The number of groups in this FB (1-16)
+		midi1_first_group	The first UMP Group number for MIDI 1.0 (0-15)
+		midi1_num_groups	The number of groups for MIDI 1.0 (0-16)
+		ui_hint			0: unknown, 1: receiver, 2: sender, 3: both
+		midi_ci_verison		Supported MIDI-CI version number (8 bit)
+		is_midi1		Legacy MIDI 1.0 device (0, 1 or 2)
+		sysex8_streams		Max number of SysEx8 streams (8 bit)
+		active			Active FB flag (0 or 1)
+		=================	==============================================
diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index 1fb181d61322..394cd226bfae 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -1009,22 +1009,24 @@ Each Endpoint subdirectory contains a subdirectory "block.0", which
 represents the Function Block for Block 0 information.
 Its attributes are:
 
-	===============	===============================================
-	name		Function Block name string
-	direction	Direction of this FB
-			1: input, 2: output, or 3: bidirectional
-	first_group	The first UMP Group number (0-15)
-	num_groups	The number of groups in this FB (1-16)
-	ui_hint		UI-hint of this FB
-			0: unknown, 1: receiver, 2: sender, 3: both
-	midi_ci_verison	Supported MIDI-CI version number (8 bit)
-	is_midi1	Legacy MIDI 1.0 device (0-2)
-			0: MIDI 2.0 device,
-			1: MIDI 1.0 without restriction, or
-			2: MIDI 1.0 with low speed
-	sysex8_streams	Max number of SysEx8 streams (8 bit)
-	active		Bool flag for FB activity (0 or 1)
-	===============	===============================================
+	=================	===============================================
+	name			Function Block name string
+	direction		Direction of this FB
+				1: input, 2: output, or 3: bidirectional
+	first_group		The first UMP Group number (0-15)
+	num_groups		The number of groups in this FB (1-16)
+	midi1_first_group	The first UMP Group number for MIDI 1.0 (0-15)
+	midi1_num_groups	The number of groups for MIDI 1.0 (0-16)
+	ui_hint			UI-hint of this FB
+				0: unknown, 1: receiver, 2: sender, 3: both
+	midi_ci_verison		Supported MIDI-CI version number (8 bit)
+	is_midi1		Legacy MIDI 1.0 device (0-2)
+				0: MIDI 2.0 device,
+				1: MIDI 1.0 without restriction, or
+				2: MIDI 1.0 with low speed
+	sysex8_streams		Max number of SysEx8 streams (8 bit)
+	active			Bool flag for FB activity (0 or 1)
+	=================	===============================================
 
 If multiple Function Blocks are required, you can add more Function
 Blocks by creating subdirectories "block.<num>" with the corresponding
diff --git a/drivers/usb/gadget/function/f_midi2.c b/drivers/usb/gadget/function/f_midi2.c
index ec9ef15abfea..f1c47753e0c1 100644
--- a/drivers/usb/gadget/function/f_midi2.c
+++ b/drivers/usb/gadget/function/f_midi2.c
@@ -84,6 +84,8 @@ struct f_midi2_ep {
 
 	struct f_midi2_usb_ep ep_in;	/* USB MIDI EP-in */
 	struct f_midi2_usb_ep ep_out;	/* USB MIDI EP-out */
+
+	u8 in_group_to_cable[SNDRV_UMP_MAX_GROUPS]; /* map to cable; 1-based! */
 };
 
 /* indices for USB strings */
@@ -95,6 +97,13 @@ enum {
 /* 1-based GTB id to string id */
 #define gtb_to_str_id(id)	(STR_GTB1 + (id) - 1)
 
+/* mapping from MIDI 1.0 cable to UMP group */
+struct midi1_cable_mapping {
+	struct f_midi2_ep *ep;
+	unsigned char block;
+	unsigned char group;
+};
+
 /* operation mode */
 enum {
 	MIDI_OP_MODE_UNSET,	/* no altset set yet */
@@ -112,10 +121,17 @@ struct f_midi2 {
 	struct f_midi2_usb_ep midi1_ep_in;
 	struct f_midi2_usb_ep midi1_ep_out;
 
+	/* number of MIDI 1.0 I/O cables */
+	unsigned int num_midi1_in;
+	unsigned int num_midi1_out;
+
 	/* conversion for MIDI 1.0 EP-in */
 	struct f_midi2_midi1_port midi1_port[MAX_CABLES];
 	/* conversion for MIDI 1.0 EP-out */
 	struct ump_cvt_to_ump midi1_ump_cvt;
+	/* mapping between cables and UMP groups */
+	struct midi1_cable_mapping in_cable_mapping[MAX_CABLES];
+	struct midi1_cable_mapping out_cable_mapping[MAX_CABLES];
 
 	int midi_if;			/* USB MIDI interface number */
 	int operation_mode;		/* current operation mode */
@@ -917,8 +933,7 @@ static bool process_midi1_pending_buf(struct f_midi2 *midi2,
 {
 	unsigned int cable, c;
 
-	for (cable = 0; cable < midi2->midi2_eps[0].blks[0].info.num_groups;
-	     cable++) {
+	for (cable = 0; cable < midi2->num_midi1_in; cable++) {
 		struct f_midi2_midi1_port *port = &midi2->midi1_port[cable];
 
 		if (!port->pending)
@@ -960,8 +975,8 @@ static void process_midi1_transmit(struct f_midi2 *midi2)
 	struct usb_request *req = NULL;
 	/* 12 is the largest outcome (4 MIDI1 cmds) for a single UMP packet */
 	unsigned char outbuf[12];
-	unsigned char group;
-	int len, size, cable;
+	unsigned char group, cable;
+	int len, size;
 	u32 ump;
 
 	if (!usb_ep->usb_ep || !usb_ep->usb_ep->enabled)
@@ -986,9 +1001,10 @@ static void process_midi1_transmit(struct f_midi2 *midi2)
 						&group);
 		if (size <= 0)
 			continue;
-		cable = group - ep->blks[0].info.first_group;
-		if (cable < 0 || cable >= ep->blks[0].info.num_groups)
+		cable = ep->in_group_to_cable[group];
+		if (!cable)
 			continue;
+		cable--; /* to 0-base */
 		fill_midi1_pending_buf(midi2, cable, outbuf, size);
 	}
 
@@ -1025,12 +1041,12 @@ static void f_midi2_midi1_ep_out_complete(struct usb_ep *usb_ep,
 {
 	struct f_midi2_req_ctx *ctx = req->context;
 	struct f_midi2 *midi2 = ctx->usb_ep->card;
-	struct f_midi2_ep *ep = &midi2->midi2_eps[0];
+	struct f_midi2_ep *ep;
 	struct ump_cvt_to_ump *cvt = &midi2->midi1_ump_cvt;
 	static const u8 midi1_packet_bytes[16] = {
 		0, 0, 2, 3, 3, 1, 2, 3, 3, 3, 3, 3, 2, 2, 3, 1
 	};
-	unsigned int group, bytes, c, len;
+	unsigned int group, cable, bytes, c, len;
 	int status = req->status;
 	const u8 *buf = req->buf;
 
@@ -1042,10 +1058,11 @@ static void f_midi2_midi1_ep_out_complete(struct usb_ep *usb_ep,
 
 	len = req->actual >> 2;
 	for (; len; len--, buf += 4) {
-		group = *buf >> 4;
-		if (group >= ep->blks[0].info.num_groups)
+		cable = *buf >> 4;
+		ep = midi2->out_cable_mapping[cable].ep;
+		if (!ep)
 			continue;
-		group += ep->blks[0].info.first_group;
+		group = midi2->out_cable_mapping[cable].group;
 		bytes = midi1_packet_bytes[*buf & 0x0f];
 		for (c = 0; c < bytes; c++) {
 			snd_ump_convert_to_ump(cvt, group, ep->info.protocol,
@@ -1641,6 +1658,7 @@ static int append_configs(struct f_midi2_usb_config *config, void **d)
 
 static int append_midi1_in_jack(struct f_midi2 *midi2,
 				struct f_midi2_usb_config *config,
+				struct midi1_cable_mapping *map,
 				unsigned int type)
 {
 	struct usb_midi_in_jack_descriptor *jack =
@@ -1653,7 +1671,9 @@ static int append_midi1_in_jack(struct f_midi2 *midi2,
 	jack->bDescriptorSubtype = USB_MS_MIDI_IN_JACK;
 	jack->bJackType = type;
 	jack->bJackID = id;
-	jack->iJack = midi2->strings[STR_GTB1].id; // TODO: better names?
+	/* use the corresponding block name as jack name */
+	if (map->ep)
+		jack->iJack = map->ep->blks[map->block].string_id;
 
 	err = append_config(config, jack);
 	if (err < 0)
@@ -1663,6 +1683,7 @@ static int append_midi1_in_jack(struct f_midi2 *midi2,
 
 static int append_midi1_out_jack(struct f_midi2 *midi2,
 				 struct f_midi2_usb_config *config,
+				 struct midi1_cable_mapping *map,
 				 unsigned int type, unsigned int source)
 {
 	struct usb_midi_out_jack_descriptor_1 *jack =
@@ -1678,7 +1699,9 @@ static int append_midi1_out_jack(struct f_midi2 *midi2,
 	jack->bNrInputPins = 1;
 	jack->pins[0].baSourceID = source;
 	jack->pins[0].baSourcePin = 0x01;
-	jack->iJack = midi2->strings[STR_GTB1].id; // TODO: better names?
+	/* use the corresponding block name as jack name */
+	if (map->ep)
+		jack->iJack = map->ep->blks[map->block].string_id;
 
 	err = append_config(config, jack);
 	if (err < 0)
@@ -1690,7 +1713,6 @@ static int f_midi2_create_usb_configs(struct f_midi2 *midi2,
 				      struct f_midi2_usb_config *config,
 				      int speed)
 {
-	struct f_midi2_block *blk = &midi2->midi2_eps[0].blks[0];
 	void **midi1_in_eps, **midi1_out_eps;
 	int i, jack, total;
 	int err;
@@ -1724,56 +1746,55 @@ static int f_midi2_create_usb_configs(struct f_midi2 *midi2,
 	if (err < 0)
 		return err;
 
-	switch (blk->info.direction) {
-	case SNDRV_UMP_DIR_INPUT:
-	case SNDRV_UMP_DIR_OUTPUT:
-		midi2_midi1_if_desc.bNumEndpoints = 1;
-		break;
-	default:
+	if (midi2->num_midi1_in && midi2->num_midi1_out)
 		midi2_midi1_if_desc.bNumEndpoints = 2;
-		break;
-	}
+	else
+		midi2_midi1_if_desc.bNumEndpoints = 1;
 
 	err = append_configs(config, midi2_midi1_descs);
 	if (err < 0)
 		return err;
 
 	total = USB_DT_MS_HEADER_SIZE;
-	if (blk->info.direction != SNDRV_UMP_DIR_INPUT) {
+	if (midi2->num_midi1_out) {
 		midi2_midi1_ep_out_class_desc.bLength =
-			USB_DT_MS_ENDPOINT_SIZE(blk->info.num_groups);
+			USB_DT_MS_ENDPOINT_SIZE(midi2->num_midi1_out);
 		total += midi2_midi1_ep_out_class_desc.bLength;
 		midi2_midi1_ep_out_class_desc.bNumEmbMIDIJack =
-			blk->info.num_groups;
-		total += blk->info.num_groups *
+			midi2->num_midi1_out;
+		total += midi2->num_midi1_out *
 			(USB_DT_MIDI_IN_SIZE + USB_DT_MIDI_OUT_SIZE(1));
-		for (i = 0; i < blk->info.num_groups; i++) {
+		for (i = 0; i < midi2->num_midi1_out; i++) {
 			jack = append_midi1_in_jack(midi2, config,
+						    &midi2->in_cable_mapping[i],
 						    USB_MS_EMBEDDED);
 			if (jack < 0)
 				return jack;
 			midi2_midi1_ep_out_class_desc.baAssocJackID[i] = jack;
 			jack = append_midi1_out_jack(midi2, config,
+						     &midi2->in_cable_mapping[i],
 						     USB_MS_EXTERNAL, jack);
 			if (jack < 0)
 				return jack;
 		}
 	}
 
-	if (blk->info.direction != SNDRV_UMP_DIR_OUTPUT) {
+	if (midi2->num_midi1_in) {
 		midi2_midi1_ep_in_class_desc.bLength =
-			USB_DT_MS_ENDPOINT_SIZE(blk->info.num_groups);
+			USB_DT_MS_ENDPOINT_SIZE(midi2->num_midi1_in);
 		total += midi2_midi1_ep_in_class_desc.bLength;
 		midi2_midi1_ep_in_class_desc.bNumEmbMIDIJack =
-			blk->info.num_groups;
-		total += blk->info.num_groups *
+			midi2->num_midi1_in;
+		total += midi2->num_midi1_in *
 			(USB_DT_MIDI_IN_SIZE + USB_DT_MIDI_OUT_SIZE(1));
-		for (i = 0; i < blk->info.num_groups; i++) {
+		for (i = 0; i < midi2->num_midi1_in; i++) {
 			jack = append_midi1_in_jack(midi2, config,
+						    &midi2->out_cable_mapping[i],
 						    USB_MS_EXTERNAL);
 			if (jack < 0)
 				return jack;
 			jack = append_midi1_out_jack(midi2, config,
+						     &midi2->out_cable_mapping[i],
 						     USB_MS_EMBEDDED, jack);
 			if (jack < 0)
 				return jack;
@@ -1783,12 +1804,12 @@ static int f_midi2_create_usb_configs(struct f_midi2 *midi2,
 
 	midi2_midi1_class_desc.wTotalLength = cpu_to_le16(total);
 
-	if (blk->info.direction != SNDRV_UMP_DIR_INPUT) {
+	if (midi2->num_midi1_out) {
 		err = append_configs(config, midi1_out_eps);
 		if (err < 0)
 			return err;
 	}
-	if (blk->info.direction != SNDRV_UMP_DIR_OUTPUT) {
+	if (midi2->num_midi1_in) {
 		err = append_configs(config, midi1_in_eps);
 		if (err < 0)
 			return err;
@@ -2236,6 +2257,8 @@ CONFIGFS_ATTR(f_midi2_block_opts_, name)
 F_MIDI2_BLOCK_OPT(direction, "0x%x", 1, 3);
 F_MIDI2_BLOCK_OPT(first_group, "0x%x", 0, 15);
 F_MIDI2_BLOCK_OPT(num_groups, "0x%x", 1, 16);
+F_MIDI2_BLOCK_OPT(midi1_first_group, "0x%x", 0, 15);
+F_MIDI2_BLOCK_OPT(midi1_num_groups, "0x%x", 0, 16);
 F_MIDI2_BLOCK_OPT(ui_hint, "0x%x", 0, 3);
 F_MIDI2_BLOCK_OPT(midi_ci_version, "%u", 0, 1);
 F_MIDI2_BLOCK_OPT(sysex8_streams, "%u", 0, 255);
@@ -2265,6 +2288,8 @@ static struct configfs_attribute *f_midi2_block_attrs[] = {
 	&f_midi2_block_opts_attr_direction,
 	&f_midi2_block_opts_attr_first_group,
 	&f_midi2_block_opts_attr_num_groups,
+	&f_midi2_block_opts_attr_midi1_first_group,
+	&f_midi2_block_opts_attr_midi1_num_groups,
 	&f_midi2_block_opts_attr_ui_hint,
 	&f_midi2_block_opts_attr_midi_ci_version,
 	&f_midi2_block_opts_attr_sysex8_streams,
@@ -2644,6 +2669,9 @@ static struct usb_function_instance *f_midi2_alloc_inst(void)
 		return ERR_PTR(ret);
 	}
 
+	/* set up the default MIDI1 (that is mandatory) */
+	block_opts->info.midi1_num_groups = 1;
+
 	config_group_init_type_name(&opts->func_inst.group, "",
 				    &f_midi2_func_type);
 
@@ -2707,6 +2735,16 @@ static int verify_parameters(struct f_midi2_opts *opts)
 				       i, j);
 				return -EINVAL;
 			}
+
+			if (bp->midi1_num_groups) {
+				if (bp->midi1_first_group < bp->first_group ||
+				    bp->midi1_first_group + bp->midi1_num_groups >
+				    bp->first_group + bp->num_groups) {
+					pr_err("f_midi2: Invalid MIDI1 group definitions for block %d:%d\n",
+					       i, j);
+					return -EINVAL;
+				}
+			}
 		}
 	}
 	if (!num_blks) {
@@ -2717,6 +2755,46 @@ static int verify_parameters(struct f_midi2_opts *opts)
 	return num_eps;
 }
 
+/* fill mapping between MIDI 1.0 cable and UMP EP/group */
+static void fill_midi1_cable_mapping(struct f_midi2 *midi2,
+				     struct f_midi2_ep *ep,
+				     int blk)
+{
+	const struct f_midi2_block_info *binfo = &ep->blks[blk].info;
+	struct midi1_cable_mapping *map;
+	int i, group;
+
+	if (!binfo->midi1_num_groups)
+		return;
+	if (binfo->direction != SNDRV_UMP_DIR_OUTPUT) {
+		group = binfo->midi1_first_group;
+		map = midi2->in_cable_mapping + midi2->num_midi1_in;
+		for (i = 0; i < binfo->midi1_num_groups; i++, group++, map++) {
+			if (midi2->num_midi1_in >= MAX_CABLES)
+				break;
+			map->ep = ep;
+			map->block = blk;
+			map->group = group;
+			midi2->num_midi1_in++;
+			/* store 1-based cable number */
+			ep->in_group_to_cable[group] = midi2->num_midi1_in;
+		}
+	}
+
+	if (binfo->direction != SNDRV_UMP_DIR_INPUT) {
+		group = binfo->midi1_first_group;
+		map = midi2->out_cable_mapping + midi2->num_midi1_out;
+		for (i = 0; i < binfo->midi1_num_groups; i++, group++, map++) {
+			if (midi2->num_midi1_out >= MAX_CABLES)
+				break;
+			map->ep = ep;
+			map->block = blk;
+			map->group = group;
+			midi2->num_midi1_out++;
+		}
+	}
+}
+
 /* gadget alloc callback */
 static struct usb_function *f_midi2_alloc(struct usb_function_instance *fi)
 {
@@ -2786,9 +2864,17 @@ static struct usb_function *f_midi2_alloc(struct usb_function_instance *fi)
 			bp = &ep->blks[blk];
 			midi2->string_defs[gtb_to_str_id(bp->gtb_id)].s =
 				ump_fb_name(&bp->info);
+
+			fill_midi1_cable_mapping(midi2, ep, blk);
 		}
 	}
 
+	if (!midi2->num_midi1_in && !midi2->num_midi1_out) {
+		pr_err("f_midi2: MIDI1 definition is missing\n");
+		do_f_midi2_free(midi2, opts);
+		return ERR_PTR(-EINVAL);
+	}
+
 	return &midi2->func;
 }
 
diff --git a/drivers/usb/gadget/function/u_midi2.h b/drivers/usb/gadget/function/u_midi2.h
index a68dc2ea035e..4e7adb41dfb7 100644
--- a/drivers/usb/gadget/function/u_midi2.h
+++ b/drivers/usb/gadget/function/u_midi2.h
@@ -18,6 +18,8 @@ struct f_midi2_block_info {
 	unsigned int direction;		/* FB direction: 1-3 */
 	unsigned int first_group;	/* first UMP group: 0-15 */
 	unsigned int num_groups;	/* number of UMP groups: 1-16 */
+	unsigned int midi1_first_group;	/* first UMP group for MIDI 1.0 */
+	unsigned int midi1_num_groups;	/* number of UMP groups for MIDI 1.0 */
 	unsigned int ui_hint;		/* UI-hint: 0-3 */
 	unsigned int midi_ci_version;	/* MIDI-CI version: 0-255 */
 	unsigned int sysex8_streams;	/* number of sysex8 streams: 0-255 */
-- 
2.35.3

