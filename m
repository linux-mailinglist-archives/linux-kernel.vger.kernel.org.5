Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473BB7CBDE3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjJQIjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbjJQIjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:39:40 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4CFA93;
        Tue, 17 Oct 2023 01:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=krMrh
        +gnj9GwvY8PuJ2nHyEgdmzG0vhrGe+vOfvIw9Q=; b=lEzTpX+orqfVJ2Q9JhMlE
        +uWRMpNh5usXqsk/LmzkJH+Ow6i/A5MDgMGkt40XiVkd9CJjWeWOlrn2iWfg8gvr
        Mo1OK27vnQp89o90Tx8ytYEsZUi50V3+LMBSgrMR/WmP6X9pMESdWJz5TfzgntnV
        XURDX5D6QZ98BU42et/WHs=
Received: from ubuntu.. (unknown [171.83.47.247])
        by zwqz-smtp-mta-g5-4 (Coremail) with SMTP id _____wDnNwI6SC5lUGceAw--.33359S2;
        Tue, 17 Oct 2023 16:39:22 +0800 (CST)
From:   Charles <be286@163.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Charles <be286@163.com>
Subject: [PATCH]         usb: gadget: f_uac1: add adaptive sync support for capture
Date:   Tue, 17 Oct 2023 16:39:18 +0800
Message-Id: <20231017083918.1149647-1-be286@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnNwI6SC5lUGceAw--.33359S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr15JF47Ww4xWFW8ZF1xAFb_yoWrCr1kpw
        4UC3y0yr45ArZIqr4rAF4rAF43Aa1xG345GrW7Ww4Yganxt3sava42yryFkF17AFWrCw40
        qF4Fgw1a9w4kCrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRwvtXUUUUU=
X-Originating-IP: [171.83.47.247]
X-CM-SenderInfo: dehsmli6rwjhhfrp/1tbiWxIK0mI0cRDTdAADsC
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

        UAC1 has it's own freerunning clock and can update Host about
        real clock frequency through feedback endpoint so Host
        can align number of samples sent to the UAC1 to
        prevent overruns/underruns.

        Change UAC1 driver to make it configurable through
        additional 'c_sync' configfs file.

        Default remains 'asynchronous' with possibility to
        switch it to 'adaptive'.

        Signed-off-by: Charles <be286@163.com>
---
 drivers/usb/gadget/function/f_uac1.c | 31 ++++++++++++++++++++++++++++
 drivers/usb/gadget/function/u_uac1.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index 6f0e1d803dc2..0a8e55b19ee7 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -33,6 +33,8 @@
 #define FUOUT_EN(_opts) ((_opts)->c_mute_present \
 			|| (_opts)->c_volume_present)
 
+#define EPOUT_FBACK_IN_EN(_opts) ((_opts)->c_sync == USB_ENDPOINT_SYNC_ASYNC)
+
 struct f_uac1 {
 	struct g_audio g_audio;
 	u8 ac_intf, as_in_intf, as_out_intf;
@@ -227,6 +229,16 @@ static struct uac_iso_endpoint_descriptor as_iso_out_desc = {
 	.wLockDelay =		cpu_to_le16(1),
 };
 
+static struct usb_endpoint_descriptor as_fback_ep_desc = {
+	.bLength = USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType = USB_DT_ENDPOINT,
+
+	.bEndpointAddress = USB_DIR_IN,
+	.bmAttributes = USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_USAGE_FEEDBACK,
+	.wMaxPacketSize = cpu_to_le16(3),
+	.bInterval = 1,
+};
+
 static struct uac_format_type_i_discrete_descriptor as_in_type_i_desc = {
 	.bLength =		0, /* filled on rate setup */
 	.bDescriptorType =	USB_DT_CS_INTERFACE,
@@ -280,6 +292,7 @@ static struct usb_descriptor_header *f_audio_desc[] = {
 
 	(struct usb_descriptor_header *)&as_out_ep_desc,
 	(struct usb_descriptor_header *)&as_iso_out_desc,
+	(struct usb_descriptor_header *)&as_fback_ep_desc,
 
 	(struct usb_descriptor_header *)&as_in_interface_alt_0_desc,
 	(struct usb_descriptor_header *)&as_in_interface_alt_1_desc,
@@ -1107,6 +1120,9 @@ static void setup_descriptor(struct f_uac1_opts *opts)
 		f_audio_desc[i++] = USBDHDR(&as_out_type_i_desc);
 		f_audio_desc[i++] = USBDHDR(&as_out_ep_desc);
 		f_audio_desc[i++] = USBDHDR(&as_iso_out_desc);
+		if (EPOUT_FBACK_IN_EN(opts)) {
+			f_audio_desc[i++] = USBDHDR(&as_fback_ep_desc);
+		}
 	}
 	if (EPIN_EN(opts)) {
 		f_audio_desc[i++] = USBDHDR(&as_in_interface_alt_0_desc);
@@ -1317,6 +1333,12 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 		ac_header_desc->baInterfaceNr[ba_iface_id++] = status;
 		uac1->as_out_intf = status;
 		uac1->as_out_alt = 0;
+
+		if (EPOUT_FBACK_IN_EN(audio_opts)) {
+			as_out_ep_desc.bmAttributes =
+			USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC;
+			as_out_interface_alt_1_desc.bNumEndpoints++;
+		}
 	}
 
 	if (EPIN_EN(audio_opts)) {
@@ -1354,6 +1376,13 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 			goto err_free_fu;
 		audio->out_ep = ep;
 		audio->out_ep->desc = &as_out_ep_desc;
+		if (EPOUT_FBACK_IN_EN(audio_opts)) {
+			audio->in_ep_fback = usb_ep_autoconfig(gadget,
+								&as_fback_ep_desc);
+			if (!audio->in_ep_fback) {
+				goto err_free_fu;
+			}
+		}
 	}
 
 	if (EPIN_EN(audio_opts)) {
@@ -1685,6 +1714,8 @@ static struct usb_function_instance *f_audio_alloc_inst(void)
 
 	opts->req_number = UAC1_DEF_REQ_NUM;
 
+	opts->c_sync = UAC1_DEF_CSYNC;
+
 	snprintf(opts->function_name, sizeof(opts->function_name), "AC Interface");
 
 	return &opts->func_inst;
diff --git a/drivers/usb/gadget/function/u_uac1.h b/drivers/usb/gadget/function/u_uac1.h
index f7a616760e31..c6e2271e8cdd 100644
--- a/drivers/usb/gadget/function/u_uac1.h
+++ b/drivers/usb/gadget/function/u_uac1.h
@@ -27,6 +27,7 @@
 #define UAC1_DEF_MAX_DB		0		/* 0 dB */
 #define UAC1_DEF_RES_DB		(1*256)	/* 1 dB */
 
+#define UAC1_DEF_CSYNC		USB_ENDPOINT_SYNC_ASYNC
 
 struct f_uac1_opts {
 	struct usb_function_instance	func_inst;
@@ -56,6 +57,7 @@ struct f_uac1_opts {
 
 	struct mutex			lock;
 	int				refcnt;
+	int				c_sync;
 };
 
 #endif /* __U_UAC1_H */
-- 
2.34.1

