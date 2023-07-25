Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D281760A41
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjGYGWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjGYGWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:22:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25171173F;
        Mon, 24 Jul 2023 23:22:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0A9581F460;
        Tue, 25 Jul 2023 06:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690266132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wz+K+MF0E29R6xWk5/OwTjFBIPIM9z4mkUoZpufqQ+E=;
        b=ni3Ck6LoN4UvMEBGxjs3FKRLIWY0aJbKCv2N2ij9x0IO/tNgQvWfvIGTwcNz9TR0ZKQjtp
        1VHcthr6Xm1MwT8ufk4EXlaz/8AfZHE0W+W8wahWmJWuBgrjGsyrLeT1Un2GrBpBhwGuS9
        8bUj3nbJwzdt7qYVslyqivN+MZ0CBpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690266132;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wz+K+MF0E29R6xWk5/OwTjFBIPIM9z4mkUoZpufqQ+E=;
        b=8i0aWKdw1aDkfnXyAEIh53ce+FERunv+DBzZZO2L8jPrrdC6iHJZnAa4a41r6vVLoPsn3P
        rqMCaWTXbVzdA0Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CEA7C1390F;
        Tue, 25 Jul 2023 06:22:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0IGQMRNqv2S0dQAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 25 Jul 2023 06:22:11 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] usb: gadget: midi2: Add configfs support
Date:   Tue, 25 Jul 2023 08:22:01 +0200
Message-Id: <20230725062206.9674-3-tiwai@suse.de>
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

This patch adds the support of configfs to MIDI 2.0 function driver
for users to allow configuring the UMP Endpoint and Function Blocks
more flexibly.  The configuration is in a tree form.  The top-most
contains some card-level configurations.  UMP Endpoints are defined in
subdirectories (ep.0, ep.1, etc) that contain Endpoint-specific
configurations such as ep_name, etc.  And, UMP Function Blocks are
defined in the subdirectories (block.0, block.1, etc) under EP
subdirectory.  As default, the driver creates a single UMP Endpoint
(ep.0) and a single Function Block (block.0) to work in a minimalistic
manner.  User can modify those attributes freely to fit with the
demands.

When multiple Function Blocks are required, user can create another
directory as block.1, block.2, and so on (up to block.31).  A block.*
directory can be deleted dynamically, too.  A caveat is that the block
number has to be continuous.

Similarly, when multiple UMP Endpoints are required, user can create
another directory as ep.1, ep.2, up to ep.3.

Also, some driver behavior can be controlled in the card top-level
configs.  e.g. you can pass process_ump=0 to disable the processing of
UMP Stream messages.  This would be equivalent with the older MIDI 2.0
spec that doesn't support UMP v1.1 features.

The configfs interface checks upper- / lower-bound of input values,
and more sanity checks are performed at binding.

Attributes can't be changed any longer once when the instance is
linked to UDC.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../ABI/testing/configfs-usb-gadget-midi2     |  52 ++
 drivers/usb/gadget/function/f_midi2.c         | 621 +++++++++++++++++-
 2 files changed, 650 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/ABI/testing/configfs-usb-gadget-midi2

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-midi2 b/Documentation/ABI/testing/configfs-usb-gadget-midi2
new file mode 100644
index 000000000000..a3a036d784c7
--- /dev/null
+++ b/Documentation/ABI/testing/configfs-usb-gadget-midi2
@@ -0,0 +1,52 @@
+What:		/config/usb-gadget/gadget/functions/midi2.name
+Date:		Jul 2023
+KernelVersion:	6.6
+Description:
+		The attributes:
+
+		============	===============================================
+		process_ump	Flag to process UMP Stream messages (0 or 1)
+		static_block	Flag for static blocks (0 or 1)
+		iface_name	MIDI interface name string
+		============	===============================================
+
+What:		/config/usb-gadget/gadget/functions/midi2.name/ep.number
+Date:		Jul 2023
+KernelVersion:	6.6
+Description:
+		This group contains a UMP Endpoint configuration.
+		A new Endpoint starts from 0, and can be up to 3.
+
+		The attributes:
+
+		=============	===============================================
+		protocol_caps	MIDI protocol capabilities (1, 2 or 3 for both)
+		protocol	Default MIDI protocol (1 or 2)
+		ep_name		UMP Endpoint name string
+		product_id	Product ID string
+		manufacturer	Manufacture ID (24 bit)
+		family		Device family ID (16 bit)
+		model		Device model ID (16 bit)
+		sw_revision	Software Revision (32 bit)
+		=============	===============================================
+
+What:		/config/usb-gadget/gadget/functions/midi2.name/ep.number/block.number
+Date:		Jul 2023
+KernelVersion:	6.6
+Description:
+		This group contains a UMP Function Block configuration.
+		A new block starts from 0, and can be up to 31.
+
+		The attributes:
+
+		===============	===============================================
+		name		Function Block name string
+		direction	1: input, 2: output, 3: bidirectional
+		first_group	The first UMP Group number (0-15)
+		num_groups	The number of groups in this FB (1-16)
+		ui_hint		0: unknown, 1: receiver, 2: sender, 3: both
+		midi_ci_verison	Supported MIDI-CI version number (8 bit)
+		is_midi1	Legacy MIDI 1.0 device (0, 1 or 2)
+		sysex8_streams	Max number of SysEx8 streams (8 bit)
+		active		Active FB flag (0 or 1)
+		===============	===============================================
diff --git a/drivers/usb/gadget/function/f_midi2.c b/drivers/usb/gadget/function/f_midi2.c
index 848cb3150deb..c68a6fa0d237 100644
--- a/drivers/usb/gadget/function/f_midi2.c
+++ b/drivers/usb/gadget/function/f_midi2.c
@@ -292,7 +292,7 @@ static struct usb_interface_descriptor midi2_midi2_if_desc = {
 	.bDescriptorType =	USB_DT_INTERFACE,
 	.bInterfaceNumber =	0, // to be filled
 	.bAlternateSetting =	1,
-	.bNumEndpoints =	2,
+	.bNumEndpoints =	2, // to be filled
 	.bInterfaceClass =	USB_CLASS_AUDIO,
 	.bInterfaceSubClass =	USB_SUBCLASS_MIDISTREAMING,
 	.bInterfaceProtocol =	0,
@@ -1403,6 +1403,8 @@ static int f_midi2_bind(struct usb_configuration *c, struct usb_function *f)
 				midi2->strings[gtb_to_str_id(ep->blks[blk].gtb_id)].id;
 	}
 
+	midi2_midi2_if_desc.bNumEndpoints = midi2->num_eps * 2;
+
 	/* audio interface */
 	status = usb_interface_id(c, f);
 	if (status < 0)
@@ -1510,16 +1512,274 @@ static void f_midi2_unbind(struct usb_configuration *c, struct usb_function *f)
 	usb_free_all_descriptors(f);
 }
 
+/*
+ * ConfigFS interface
+ */
+
+/* type conversion helpers */
+static inline struct f_midi2_opts *to_f_midi2_opts(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct f_midi2_opts,
+			    func_inst.group);
+}
+
+static inline struct f_midi2_ep_opts *
+to_f_midi2_ep_opts(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct f_midi2_ep_opts,
+			    group);
+}
+
+static inline struct f_midi2_block_opts *
+to_f_midi2_block_opts(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct f_midi2_block_opts,
+			    group);
+}
+
+/* trim the string to be usable for EP and FB name strings */
+static void make_name_string(char *s)
+{
+	char *p;
+
+	p = strchr(s, '\n');
+	if (p)
+		*p = 0;
+
+	p = s + strlen(s);
+	for (; p > s && isspace(*p); p--)
+		*p = 0;
+}
+
+/* configfs helpers: generic show/store for unisnged int */
+static ssize_t f_midi2_opts_uint_show(struct f_midi2_opts *opts,
+				      u32 val, const char *format, char *page)
+{
+	int result;
+
+	mutex_lock(&opts->lock);
+	result = sprintf(page, format, val);
+	mutex_unlock(&opts->lock);
+	return result;
+}
+
+static ssize_t f_midi2_opts_uint_store(struct f_midi2_opts *opts,
+				       u32 *valp, u32 minval, u32 maxval,
+				       const char *page, size_t len)
+{
+	int ret;
+	u32 val;
+
+	mutex_lock(&opts->lock);
+	if (opts->refcnt) {
+		ret = -EBUSY;
+		goto end;
+	}
+
+	ret = kstrtou32(page, 0, &val);
+	if (ret)
+		goto end;
+	if (val < minval || val > maxval) {
+		ret = -EINVAL;
+		goto end;
+	}
+
+	*valp = val;
+	ret = len;
+
+end:
+	mutex_unlock(&opts->lock);
+	return ret;
+}
+
+/* generic store for bool */
+static ssize_t f_midi2_opts_bool_store(struct f_midi2_opts *opts,
+				       bool *valp, const char *page, size_t len)
+{
+	int ret;
+	bool val;
+
+	mutex_lock(&opts->lock);
+	if (opts->refcnt) {
+		ret = -EBUSY;
+		goto end;
+	}
+
+	ret = kstrtobool(page, &val);
+	if (ret)
+		goto end;
+	*valp = val;
+	ret = len;
+
+end:
+	mutex_unlock(&opts->lock);
+	return ret;
+}
+
+/* generic show/store for string */
+static ssize_t f_midi2_opts_str_show(struct f_midi2_opts *opts,
+				     const char *str, char *page)
+{
+	int result = 0;
+
+	mutex_lock(&opts->lock);
+	if (str)
+		result = scnprintf(page, PAGE_SIZE, "%s\n", str);
+	mutex_unlock(&opts->lock);
+	return result;
+}
+
+static ssize_t f_midi2_opts_str_store(struct f_midi2_opts *opts,
+				      const char **strp, size_t maxlen,
+				      const char *page, size_t len)
+{
+	char *c;
+	int ret;
+
+	mutex_lock(&opts->lock);
+	if (opts->refcnt) {
+		ret = -EBUSY;
+		goto end;
+	}
+
+	c = kstrndup(page, min(len, maxlen), GFP_KERNEL);
+	if (!c) {
+		ret = -ENOMEM;
+		goto end;
+	}
+
+	kfree(*strp);
+	make_name_string(c);
+	*strp = c;
+	ret = len;
+
+end:
+	mutex_unlock(&opts->lock);
+	return ret;
+}
+
+/*
+ * Definitions for UMP Block config
+ */
+
+/* define an uint option for block */
+#define F_MIDI2_BLOCK_OPT(name, format, minval, maxval)			\
+static ssize_t f_midi2_block_opts_##name##_show(struct config_item *item,\
+					  char *page)			\
+{									\
+	struct f_midi2_block_opts *opts = to_f_midi2_block_opts(item);	\
+	return f_midi2_opts_uint_show(opts->ep->opts, opts->info.name,	\
+				      format "\n", page);		\
+}									\
+									\
+static ssize_t f_midi2_block_opts_##name##_store(struct config_item *item,\
+					 const char *page, size_t len)	\
+{									\
+	struct f_midi2_block_opts *opts = to_f_midi2_block_opts(item);	\
+	return f_midi2_opts_uint_store(opts->ep->opts, &opts->info.name,\
+				       minval, maxval, page, len);	\
+}									\
+									\
+CONFIGFS_ATTR(f_midi2_block_opts_, name)
+
+/* define a boolean option for block */
+#define F_MIDI2_BLOCK_BOOL_OPT(name)					\
+static ssize_t f_midi2_block_opts_##name##_show(struct config_item *item,\
+					  char *page)			\
+{									\
+	struct f_midi2_block_opts *opts = to_f_midi2_block_opts(item);	\
+	return f_midi2_opts_uint_show(opts->ep->opts, opts->info.name,	\
+				      "%u\n", page);			\
+}									\
+									\
+static ssize_t f_midi2_block_opts_##name##_store(struct config_item *item,\
+					 const char *page, size_t len)	\
+{									\
+	struct f_midi2_block_opts *opts = to_f_midi2_block_opts(item);	\
+	return f_midi2_opts_bool_store(opts->ep->opts, &opts->info.name,\
+				       page, len);			\
+}									\
+									\
+CONFIGFS_ATTR(f_midi2_block_opts_, name)
+
+F_MIDI2_BLOCK_OPT(direction, "0x%x", 1, 3);
+F_MIDI2_BLOCK_OPT(first_group, "0x%x", 0, 15);
+F_MIDI2_BLOCK_OPT(num_groups, "0x%x", 1, 16);
+F_MIDI2_BLOCK_OPT(ui_hint, "0x%x", 0, 3);
+F_MIDI2_BLOCK_OPT(midi_ci_version, "%u", 0, 1);
+F_MIDI2_BLOCK_OPT(sysex8_streams, "%u", 0, 255);
+F_MIDI2_BLOCK_OPT(is_midi1, "%u", 0, 2);
+F_MIDI2_BLOCK_BOOL_OPT(active);
+
+static ssize_t f_midi2_block_opts_name_show(struct config_item *item,
+					    char *page)
+{
+	struct f_midi2_block_opts *opts = to_f_midi2_block_opts(item);
+
+	return f_midi2_opts_str_show(opts->ep->opts, opts->info.name, page);
+}
+
+static ssize_t f_midi2_block_opts_name_store(struct config_item *item,
+					     const char *page, size_t len)
+{
+	struct f_midi2_block_opts *opts = to_f_midi2_block_opts(item);
+
+	return f_midi2_opts_str_store(opts->ep->opts, &opts->info.name, 128,
+				      page, len);
+}
+
+CONFIGFS_ATTR(f_midi2_block_opts_, name);
+
+static struct configfs_attribute *f_midi2_block_attrs[] = {
+	&f_midi2_block_opts_attr_direction,
+	&f_midi2_block_opts_attr_first_group,
+	&f_midi2_block_opts_attr_num_groups,
+	&f_midi2_block_opts_attr_ui_hint,
+	&f_midi2_block_opts_attr_midi_ci_version,
+	&f_midi2_block_opts_attr_sysex8_streams,
+	&f_midi2_block_opts_attr_is_midi1,
+	&f_midi2_block_opts_attr_active,
+	&f_midi2_block_opts_attr_name,
+	NULL,
+};
+
+static void f_midi2_block_opts_release(struct config_item *item)
+{
+	struct f_midi2_block_opts *opts = to_f_midi2_block_opts(item);
+
+	kfree(opts->info.name);
+	kfree(opts);
+}
+
+static struct configfs_item_operations f_midi2_block_item_ops = {
+	.release	= f_midi2_block_opts_release,
+};
+
+static const struct config_item_type f_midi2_block_type = {
+	.ct_item_ops	= &f_midi2_block_item_ops,
+	.ct_attrs	= f_midi2_block_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
 /* create a f_midi2_block_opts instance for the given block number */
 static int f_midi2_block_opts_create(struct f_midi2_ep_opts *ep_opts,
 				     unsigned int blk,
 				     struct f_midi2_block_opts **block_p)
 {
 	struct f_midi2_block_opts *block_opts;
+	int ret = 0;
+
+	mutex_lock(&ep_opts->opts->lock);
+	if (ep_opts->opts->refcnt || ep_opts->blks[blk]) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	block_opts = kzalloc(sizeof(*block_opts), GFP_KERNEL);
-	if (!block_opts)
-		return -ENOMEM;
+	if (!block_opts) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	block_opts->ep = ep_opts;
 	block_opts->id = blk;
@@ -1533,9 +1793,143 @@ static int f_midi2_block_opts_create(struct f_midi2_ep_opts *ep_opts,
 
 	ep_opts->blks[blk] = block_opts;
 	*block_p = block_opts;
-	return 0;
+
+	mutex_unlock(&ep_opts->opts->lock);
+ out:
+	return ret;
 }
 
+/* make_group callback for a block */
+static struct config_group *
+f_midi2_opts_block_make(struct config_group *group, const char *name)
+{
+	struct f_midi2_ep_opts *ep_opts;
+	struct f_midi2_block_opts *block_opts;
+	unsigned int blk;
+	int ret;
+
+	if (strncmp(name, "block.", 6))
+		return ERR_PTR(-EINVAL);
+	ret = kstrtouint(name + 6, 10, &blk);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ep_opts = to_f_midi2_ep_opts(&group->cg_item);
+
+	if (blk >= SNDRV_UMP_MAX_BLOCKS)
+		return ERR_PTR(-EINVAL);
+	if (ep_opts->blks[blk])
+		return ERR_PTR(-EBUSY);
+	ret = f_midi2_block_opts_create(ep_opts, blk, &block_opts);
+	if (ret)
+		return ERR_PTR(ret);
+
+	config_group_init_type_name(&block_opts->group, name,
+				    &f_midi2_block_type);
+	return &block_opts->group;
+}
+
+/* drop_item callback for a block */
+static void
+f_midi2_opts_block_drop(struct config_group *group, struct config_item *item)
+{
+	struct f_midi2_block_opts *block_opts = to_f_midi2_block_opts(item);
+
+	mutex_lock(&block_opts->ep->opts->lock);
+	block_opts->ep->blks[block_opts->id] = NULL;
+	mutex_unlock(&block_opts->ep->opts->lock);
+	config_item_put(item);
+}
+
+/*
+ * Definitions for UMP Endpoint config
+ */
+
+/* define an uint option for EP */
+#define F_MIDI2_EP_OPT(name, format, minval, maxval)			\
+static ssize_t f_midi2_ep_opts_##name##_show(struct config_item *item,	\
+					     char *page)		\
+{									\
+	struct f_midi2_ep_opts *opts = to_f_midi2_ep_opts(item);	\
+	return f_midi2_opts_uint_show(opts->opts, opts->info.name,	\
+				      format "\n", page);		\
+}									\
+									\
+static ssize_t f_midi2_ep_opts_##name##_store(struct config_item *item,	\
+					   const char *page, size_t len)\
+{									\
+	struct f_midi2_ep_opts *opts = to_f_midi2_ep_opts(item);	\
+	return f_midi2_opts_uint_store(opts->opts, &opts->info.name,	\
+				       minval, maxval, page, len);	\
+}									\
+									\
+CONFIGFS_ATTR(f_midi2_ep_opts_, name)
+
+/* define a string option for EP */
+#define F_MIDI2_EP_STR_OPT(name, maxlen)				\
+static ssize_t f_midi2_ep_opts_##name##_show(struct config_item *item,	\
+					     char *page)		\
+{									\
+	struct f_midi2_ep_opts *opts = to_f_midi2_ep_opts(item);	\
+	return f_midi2_opts_str_show(opts->opts, opts->info.name, page);\
+}									\
+									\
+static ssize_t f_midi2_ep_opts_##name##_store(struct config_item *item,	\
+					 const char *page, size_t len)	\
+{									\
+	struct f_midi2_ep_opts *opts = to_f_midi2_ep_opts(item);	\
+	return f_midi2_opts_str_store(opts->opts, &opts->info.name, maxlen,\
+				      page, len);			\
+}									\
+									\
+CONFIGFS_ATTR(f_midi2_ep_opts_, name)
+
+F_MIDI2_EP_OPT(protocol, "0x%x", 1, 2);
+F_MIDI2_EP_OPT(protocol_caps, "0x%x", 1, 3);
+F_MIDI2_EP_OPT(manufacturer, "0x%x", 0, 0xffffff);
+F_MIDI2_EP_OPT(family, "0x%x", 0, 0xffff);
+F_MIDI2_EP_OPT(model, "0x%x", 0, 0xffff);
+F_MIDI2_EP_OPT(sw_revision, "0x%x", 0, 0xffffffff);
+F_MIDI2_EP_STR_OPT(ep_name, 128);
+F_MIDI2_EP_STR_OPT(product_id, 128);
+
+static struct configfs_attribute *f_midi2_ep_attrs[] = {
+	&f_midi2_ep_opts_attr_protocol,
+	&f_midi2_ep_opts_attr_protocol_caps,
+	&f_midi2_ep_opts_attr_ep_name,
+	&f_midi2_ep_opts_attr_product_id,
+	&f_midi2_ep_opts_attr_manufacturer,
+	&f_midi2_ep_opts_attr_family,
+	&f_midi2_ep_opts_attr_model,
+	&f_midi2_ep_opts_attr_sw_revision,
+	NULL,
+};
+
+static void f_midi2_ep_opts_release(struct config_item *item)
+{
+	struct f_midi2_ep_opts *opts = to_f_midi2_ep_opts(item);
+
+	kfree(opts->info.ep_name);
+	kfree(opts->info.product_id);
+	kfree(opts);
+}
+
+static struct configfs_item_operations f_midi2_ep_item_ops = {
+	.release	= f_midi2_ep_opts_release,
+};
+
+static struct configfs_group_operations f_midi2_ep_group_ops = {
+	.make_group	= f_midi2_opts_block_make,
+	.drop_item	= f_midi2_opts_block_drop,
+};
+
+static const struct config_item_type f_midi2_ep_type = {
+	.ct_item_ops	= &f_midi2_ep_item_ops,
+	.ct_group_ops	= &f_midi2_ep_group_ops,
+	.ct_attrs	= f_midi2_ep_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
 /* create a f_midi2_ep_opts instance */
 static int f_midi2_ep_opts_create(struct f_midi2_opts *opts,
 				  unsigned int index,
@@ -1559,7 +1953,119 @@ static int f_midi2_ep_opts_create(struct f_midi2_opts *opts,
 	return 0;
 }
 
+/* make_group callback for an EP */
+static struct config_group *
+f_midi2_opts_ep_make(struct config_group *group, const char *name)
+{
+	struct f_midi2_opts *opts;
+	struct f_midi2_ep_opts *ep_opts;
+	unsigned int index;
+	int ret;
+
+	if (strncmp(name, "ep.", 3))
+		return ERR_PTR(-EINVAL);
+	ret = kstrtouint(name + 3, 10, &index);
+	if (ret)
+		return ERR_PTR(ret);
+
+	opts = to_f_midi2_opts(&group->cg_item);
+	if (index >= MAX_UMP_EPS)
+		return ERR_PTR(-EINVAL);
+	if (opts->eps[index])
+		return ERR_PTR(-EBUSY);
+	ret = f_midi2_ep_opts_create(opts, index, &ep_opts);
+	if (ret)
+		return ERR_PTR(ret);
+
+	config_group_init_type_name(&ep_opts->group, name, &f_midi2_ep_type);
+	return &ep_opts->group;
+}
+
+/* drop_item callback for an EP */
+static void
+f_midi2_opts_ep_drop(struct config_group *group, struct config_item *item)
+{
+	struct f_midi2_ep_opts *ep_opts = to_f_midi2_ep_opts(item);
+
+	mutex_lock(&ep_opts->opts->lock);
+	ep_opts->opts->eps[ep_opts->index] = NULL;
+	mutex_unlock(&ep_opts->opts->lock);
+	config_item_put(item);
+}
+
+/*
+ * Definitions for card config
+ */
+
+/* define a bool option for card */
+#define F_MIDI2_BOOL_OPT(name)						\
+static ssize_t f_midi2_opts_##name##_show(struct config_item *item,	\
+					  char *page)			\
+{									\
+	struct f_midi2_opts *opts = to_f_midi2_opts(item);		\
+	return f_midi2_opts_uint_show(opts, opts->info.name,		\
+				      "%u\n", page);			\
+}									\
+									\
+static ssize_t f_midi2_opts_##name##_store(struct config_item *item,	\
+					 const char *page, size_t len)	\
+{									\
+	struct f_midi2_opts *opts = to_f_midi2_opts(item);		\
+	return f_midi2_opts_bool_store(opts, &opts->info.name,		\
+				       page, len);			\
+}									\
+									\
+CONFIGFS_ATTR(f_midi2_opts_, name)
+
+F_MIDI2_BOOL_OPT(process_ump);
+F_MIDI2_BOOL_OPT(static_block);
+
+static ssize_t f_midi2_opts_iface_name_show(struct config_item *item,
+					    char *page)
+{
+	struct f_midi2_opts *opts = to_f_midi2_opts(item);
+
+	return f_midi2_opts_str_show(opts, opts->info.iface_name, page);
+}
+
+static ssize_t f_midi2_opts_iface_name_store(struct config_item *item,
+					     const char *page, size_t len)
+{
+	struct f_midi2_opts *opts = to_f_midi2_opts(item);
+
+	return f_midi2_opts_str_store(opts, &opts->info.iface_name, 128,
+				      page, len);
+}
+
+CONFIGFS_ATTR(f_midi2_opts_, iface_name);
+
+static struct configfs_attribute *f_midi2_attrs[] = {
+	&f_midi2_opts_attr_process_ump,
+	&f_midi2_opts_attr_static_block,
+	&f_midi2_opts_attr_iface_name,
+	NULL
+};
+
+static void f_midi2_opts_release(struct config_item *item)
+{
+	struct f_midi2_opts *opts = to_f_midi2_opts(item);
+
+	usb_put_function_instance(&opts->func_inst);
+}
+
+static struct configfs_item_operations f_midi2_item_ops = {
+	.release	= f_midi2_opts_release,
+};
+
+static struct configfs_group_operations f_midi2_group_ops = {
+	.make_group	= f_midi2_opts_ep_make,
+	.drop_item	= f_midi2_opts_ep_drop,
+};
+
 static const struct config_item_type f_midi2_func_type = {
+	.ct_item_ops	= &f_midi2_item_ops,
+	.ct_group_ops	= &f_midi2_group_ops,
+	.ct_attrs	= f_midi2_attrs,
 	.ct_owner	= THIS_MODULE,
 };
 
@@ -1569,11 +2075,7 @@ static void f_midi2_free_inst(struct usb_function_instance *f)
 
 	opts = container_of(f, struct f_midi2_opts, func_inst);
 
-	/* we have only one EP and one FB */
-	if (opts->eps[0]) {
-		kfree(opts->eps[0]->blks[0]);
-		kfree(opts->eps[0]);
-	}
+	kfree(opts->info.iface_name);
 	kfree(opts);
 }
 
@@ -1596,6 +2098,7 @@ static struct usb_function_instance *f_midi2_alloc_inst(void)
 	opts->info.num_reqs = 32;
 	opts->info.req_buf_size = 512;
 
+	/* create the default ep */
 	ret = f_midi2_ep_opts_create(opts, 0, &ep_opts);
 	if (ret) {
 		kfree(opts);
@@ -1612,6 +2115,15 @@ static struct usb_function_instance *f_midi2_alloc_inst(void)
 
 	config_group_init_type_name(&opts->func_inst.group, "",
 				    &f_midi2_func_type);
+
+	config_group_init_type_name(&ep_opts->group, "ep.0",
+				    &f_midi2_ep_type);
+	configfs_add_default_group(&ep_opts->group, &opts->func_inst.group);
+
+	config_group_init_type_name(&block_opts->group, "block.0",
+				    &f_midi2_block_type);
+	configfs_add_default_group(&block_opts->group, &ep_opts->group);
+
 	return &opts->func_inst;
 }
 
@@ -1630,12 +2142,58 @@ static void f_midi2_free(struct usb_function *f)
 			container_of(f->fi, struct f_midi2_opts, func_inst));
 }
 
+/* verify the parameters set up via configfs;
+ * return the number of EPs or a negative error
+ */
+static int verify_parameters(struct f_midi2_opts *opts)
+{
+	int i, j, num_eps, num_blks;
+	struct f_midi2_ep_info *ep;
+	struct f_midi2_block_info *bp;
+
+	for (num_eps = 0; num_eps < MAX_UMP_EPS && opts->eps[num_eps];
+	     num_eps++)
+		;
+	if (!num_eps) {
+		pr_err("f_midi2: No EP is defined\n");
+		return -EINVAL;
+	}
+
+	num_blks = 0;
+	for (i = 0; i < num_eps; i++) {
+		ep = &opts->eps[i]->info;
+		if (!(ep->protocol_caps & ep->protocol)) {
+			pr_err("f_midi2: Invalid protocol 0x%x (caps 0x%x) for EP %d\n",
+			       ep->protocol, ep->protocol_caps, i);
+			return -EINVAL;
+		}
+
+		for (j = 0; j < SNDRV_UMP_MAX_BLOCKS && opts->eps[i]->blks[j];
+		     j++, num_blks++) {
+			bp = &opts->eps[i]->blks[j]->info;
+			if (bp->first_group + bp->num_groups > SNDRV_UMP_MAX_GROUPS) {
+				pr_err("f_midi2: Invalid group definitions for block %d:%d\n",
+				       i, j);
+				return -EINVAL;
+			}
+		}
+	}
+	if (!num_blks) {
+		pr_err("f_midi2: No block is defined\n");
+		return -EINVAL;
+	}
+
+	return num_eps;
+}
+
 /* gadget alloc callback */
 static struct usb_function *f_midi2_alloc(struct usb_function_instance *fi)
 {
 	struct f_midi2 *midi2;
 	struct f_midi2_opts *opts;
-	int i;
+	struct f_midi2_ep *ep;
+	struct f_midi2_block *bp;
+	int i, num_eps, blk;
 
 	midi2 = kzalloc(sizeof(*midi2), GFP_KERNEL);
 	if (!midi2)
@@ -1643,6 +2201,12 @@ static struct usb_function *f_midi2_alloc(struct usb_function_instance *fi)
 
 	opts = container_of(fi, struct f_midi2_opts, func_inst);
 	mutex_lock(&opts->lock);
+	num_eps = verify_parameters(opts);
+	if (num_eps < 0) {
+		mutex_unlock(&opts->lock);
+		kfree(midi2);
+		return ERR_PTR(num_eps);
+	}
 	++opts->refcnt;
 	mutex_unlock(&opts->lock);
 
@@ -1658,17 +2222,20 @@ static struct usb_function *f_midi2_alloc(struct usb_function_instance *fi)
 	midi2->func.free_func = f_midi2_free;
 
 	midi2->info = opts->info;
+	midi2->num_eps = num_eps;
 
-	/* fixed 1 UMP EP and 1 UMP FB as of now */
-	midi2->num_eps = 1;
-	midi2->midi2_eps[0].info = opts->eps[0]->info;
-	midi2->midi2_eps[0].card = midi2;
-	midi2->midi2_eps[0].num_blks = 1;
-	midi2->midi2_eps[0].blks[0].info = opts->eps[0]->blks[0]->info;
-	midi2->midi2_eps[0].blks[0].gtb_id = 1;
-
-	for (i = 0; i < midi2->num_eps; i++)
-		midi2->total_blocks += midi2->midi2_eps[i].num_blks;
+	for (i = 0; i < num_eps; i++) {
+		ep = &midi2->midi2_eps[i];
+		ep->info = opts->eps[i]->info;
+		ep->card = midi2;
+		for (blk = 0; blk < SNDRV_UMP_MAX_BLOCKS &&
+			     opts->eps[i]->blks[blk]; blk++) {
+			bp = &ep->blks[blk];
+			ep->num_blks++;
+			bp->info = opts->eps[i]->blks[blk]->info;
+			bp->gtb_id = ++midi2->total_blocks;
+		}
+	}
 
 	midi2->string_defs = kcalloc(midi2->total_blocks + 1,
 				     sizeof(*midi2->string_defs), GFP_KERNEL);
@@ -1678,10 +2245,18 @@ static struct usb_function *f_midi2_alloc(struct usb_function_instance *fi)
 	}
 
 	if (opts->info.iface_name && *opts->info.iface_name)
-		midi2->string_defs[0].s = opts->info.iface_name;
+		midi2->string_defs[STR_IFACE].s = opts->info.iface_name;
 	else
-		midi2->string_defs[0].s = ump_ep_name(&midi2->midi2_eps[0]);
-	midi2->string_defs[1].s = ump_fb_name(&midi2->midi2_eps[0].blks[0].info);
+		midi2->string_defs[STR_IFACE].s = ump_ep_name(&midi2->midi2_eps[0]);
+
+	for (i = 0; i < midi2->num_eps; i++) {
+		ep = &midi2->midi2_eps[i];
+		for (blk = 0; blk < ep->num_blks; blk++) {
+			bp = &ep->blks[blk];
+			midi2->string_defs[gtb_to_str_id(bp->gtb_id)].s =
+				ump_fb_name(&bp->info);
+		}
+	}
 
 	return &midi2->func;
 }
-- 
2.35.3

