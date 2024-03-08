Return-Path: <linux-kernel+bounces-97431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2247876A59
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA511F214E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684115380F;
	Fri,  8 Mar 2024 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erwnwZyV"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E279C20B0E;
	Fri,  8 Mar 2024 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921011; cv=none; b=OXRIGj9r3o+XKTLaf3bQjSKoOyl6Q3MEKKMQR8pnDFbqDrSxguh7bn//QuUe0G9X5tG/LoqOMWZYLCaPGB9B+kurIpxbx6mwornk/KfNdJyP6SypNkKK4BkAKVRKHTtJzfzfPWZ5hvcUAWHX6xRRX29hmex5yW3/bfJLLPg8rsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921011; c=relaxed/simple;
	bh=T3+C4sD+48h/f9PPvGL2oQQUFDnTmdL6c6184009t18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tr+gGK0w21x5GV3e520ZkL06LhcUawNFFY+0uUrwv5ujfOoWTjmuRY/RUextWAmVdfH/4OCLSLrvq2Ytb4Ys59PfA7HgctR2HuLy53+FoDIFUA6dRqbtPD2HipDtJ8zdyIB0Oa65aG9W5FhdFkbffV/F6q8tPlloJhoSBybfofU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erwnwZyV; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e5a232fe80so1719221b3a.0;
        Fri, 08 Mar 2024 10:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709921009; x=1710525809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvxyjWZPs43KUvfT6EX0QHFzXkWAMi9OKmmDSNtq6LA=;
        b=erwnwZyV41Ua2LJBt89LQ/OeeJva0gjLTM0cnsvHOlQ4ZnUGjDaczJouXP2JzFUoiv
         qUCvdn8w75eJasR8tVu4KntwxC0qsF2c6IKdOix5QqaUxauGy58fQ4QUX4UR+g+LmjjI
         ubXrUc96jsIk4pFMP0gtegSbAXabZandY9lo3NPyn3+11FnNuPMhNQWAD9fmIZng4VmF
         OEBTCX60taszxLYDl3tepp28Huvp/l02YPT82G/Z77IpQnJM38aDyyq+WSRltdJPL797
         jDjOyWU7iDDjrhsEfPOI+V+lw8+MzGSiPkVJopwuySQhj4QiSZ9r0h/n+jpXj5rF4N8u
         2lSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709921009; x=1710525809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvxyjWZPs43KUvfT6EX0QHFzXkWAMi9OKmmDSNtq6LA=;
        b=AeP4PlDgwcFiTEJbes8fd1nfAWFfw1OlZWRqNS0ksR4LwQj85gMN/qDBeNtPe9+bzi
         cXGZeqdCliXfomesKngSiCWeDAMOEbwPNAhABii0uSqi0/Q/rBgDcw1Szh+wH48KBSBa
         WG5/hkzEnU86mwdTkbtivOl85hz6pJMk6vQqYiQ0ggsnP5EWWPHxAdZvcmaVMTHe1T6V
         npUa5eLuo/7D+7ydOjCjFA+MgdaEam37k4v+5rm8GBbDyJ/AgIajxHIAigQ1bUFmbU84
         Zne0C4SkB87MDgXLrSoDCSPB0bIQAKbK6Q+SP879sHN6h3F8CKxpffuzVwhahhSd9qDd
         W2ug==
X-Forwarded-Encrypted: i=1; AJvYcCXNdYmiCTMjY8eFmVzsq/9nTatNr9YcCvoRxI52KBMCMXbcxBNAd0E4b6L05hU5bJHfVtXuSK1ZcTLCfhJFlB4neLHiDrbAFmkd73oD7AKPZ4O+lhhZokyfot/Eh/q3bh02ZqQRklXF5SlyvnwP
X-Gm-Message-State: AOJu0Yzs8clIYj+hbu17zTw00RwTRKh6o3qvo4iUIXPA/fDhPqceoXUq
	kUVaf10nTGQGFeXsEqEGXa59L3ZX55Ld86IkGlQnseWuwsIgPwJ4
X-Google-Smtp-Source: AGHT+IFg31W4smGFICbIbkJ9McK/PNBijYN+8B6c5e3pO+HWbQK8laiPVEIBWZxjV2uandooYbIFNw==
X-Received: by 2002:a05:6a00:939a:b0:6e0:df2d:e7fe with SMTP id ka26-20020a056a00939a00b006e0df2de7femr1387616pfb.11.1709921008889;
        Fri, 08 Mar 2024 10:03:28 -0800 (PST)
Received: from ubu.. ([2401:4900:1c83:357e:3ed1:9144:7623:b9d1])
        by smtp.gmail.com with ESMTPSA id f6-20020a056a000b0600b006e3a69eb6c4sm14280024pfu.219.2024.03.08.10.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 10:03:28 -0800 (PST)
From: Ayaan Mirza Baig <ayaanmirza.788@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: Ayaan Mirza Baig <ayaanmirza.788@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: bfusb: corrected mistakes in previous commits
Date: Fri,  8 Mar 2024 23:33:21 +0530
Message-Id: <20240308180321.178945-1-ayaanmirza.788@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <65eb4049.050a0220.b0e71.849d@mx.google.com>
References: <65eb4049.050a0220.b0e71.849d@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Left out some errors in previous commit
Sending in newer patch fixing all style errors

Signed-off-by: Ayaan Mirza Baig <ayaanmirza.788@gmail.com>
---
 drivers/bluetooth/bfusb.c | 51 ++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 08beae26e345..c97cf509b2e9 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -84,7 +84,7 @@ static struct urb *bfusb_get_completed(struct bfusb_data *data)
 
 	skb = skb_dequeue(&data->completed_q);
 	if (skb) {
-		urb = ((struct bfusb_data_scb *) skb->cb)->urb;
+		urb = ((struct bfusb_data_scb *)skb->cb)->urb;
 		kfree_skb(skb);
 	}
 
@@ -99,7 +99,7 @@ static void bfusb_unlink_urbs(struct bfusb_data *data)
 	BT_DBG("bfusb %p", data);
 
 	while ((skb = skb_dequeue(&data->pending_q))) {
-		urb = ((struct bfusb_data_scb *) skb->cb)->urb;
+		urb = ((struct bfusb_data_scb *)skb->cb)->urb;
 		usb_kill_urb(urb);
 		skb_queue_tail(&data->completed_q, skb);
 	}
@@ -110,7 +110,7 @@ static void bfusb_unlink_urbs(struct bfusb_data *data)
 
 static int bfusb_send_bulk(struct bfusb_data *data, struct sk_buff *skb)
 {
-	struct bfusb_data_scb *scb = (void *) skb->cb;
+	struct bfusb_data_scb *scb = (void *)skb->cb;
 	struct urb *urb = bfusb_get_completed(data);
 	int err, pipe;
 
@@ -125,7 +125,7 @@ static int bfusb_send_bulk(struct bfusb_data *data, struct sk_buff *skb)
 	pipe = usb_sndbulkpipe(data->udev, data->bulk_out_ep);
 
 	usb_fill_bulk_urb(urb, data->udev, pipe, skb->data, skb->len,
-			bfusb_tx_complete, skb);
+			  bfusb_tx_complete, skb);
 
 	scb->urb = urb;
 
@@ -158,7 +158,7 @@ static void bfusb_tx_wakeup(struct bfusb_data *data)
 		clear_bit(BFUSB_TX_WAKEUP, &data->state);
 
 		while ((atomic_read(&data->pending_tx) < BFUSB_MAX_BULK_TX) &&
-				(skb = skb_dequeue(&data->transmit_q))) {
+		       (skb = skb_dequeue(&data->transmit_q))) {
 			if (bfusb_send_bulk(data, skb) < 0) {
 				skb_queue_head(&data->transmit_q, skb);
 				break;
@@ -172,8 +172,8 @@ static void bfusb_tx_wakeup(struct bfusb_data *data)
 
 static void bfusb_tx_complete(struct urb *urb)
 {
-	struct sk_buff *skb = (struct sk_buff *) urb->context;
-	struct bfusb_data *data = (struct bfusb_data *) skb->dev;
+	struct sk_buff *skb = (struct sk_buff *)urb->context;
+	struct bfusb_data *data = (struct bfusb_data *)skb->dev;
 
 	BT_DBG("bfusb %p urb %p skb %p len %d", data, urb, skb, skb->len);
 
@@ -197,7 +197,6 @@ static void bfusb_tx_complete(struct urb *urb)
 	read_unlock(&data->lock);
 }
 
-
 static int bfusb_rx_submit(struct bfusb_data *data, struct urb *urb)
 {
 	struct bfusb_data_scb *scb;
@@ -218,15 +217,15 @@ static int bfusb_rx_submit(struct bfusb_data *data, struct urb *urb)
 		return -ENOMEM;
 	}
 
-	skb->dev = (void *) data;
+	skb->dev = (void *)data;
 
-	scb = (struct bfusb_data_scb *) skb->cb;
+	scb = (struct bfusb_data_scb *)skb->cb;
 	scb->urb = urb;
 
 	pipe = usb_rcvbulkpipe(data->udev, data->bulk_in_ep);
 
 	usb_fill_bulk_urb(urb, data->udev, pipe, skb->data, size,
-			bfusb_rx_complete, skb);
+			  bfusb_rx_complete, skb);
 
 	skb_queue_tail(&data->pending_q, skb);
 
@@ -274,7 +273,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 		switch (pkt_type) {
 		case HCI_EVENT_PKT:
 			if (len >= HCI_EVENT_HDR_SIZE) {
-				struct hci_event_hdr *hdr = (struct hci_event_hdr *) buf;
+				struct hci_event_hdr *hdr = (struct hci_event_hdr *)buf;
 
 				pkt_len = HCI_EVENT_HDR_SIZE + hdr->plen;
 			} else {
@@ -285,7 +284,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 
 		case HCI_ACLDATA_PKT:
 			if (len >= HCI_ACL_HDR_SIZE) {
-				struct hci_acl_hdr *hdr = (struct hci_acl_hdr *) buf;
+				struct hci_acl_hdr *hdr = (struct hci_acl_hdr *)buf;
 
 				pkt_len = HCI_ACL_HDR_SIZE + __le16_to_cpu(hdr->dlen);
 			} else {
@@ -296,7 +295,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 
 		case HCI_SCODATA_PKT:
 			if (len >= HCI_SCO_HDR_SIZE) {
-				struct hci_sco_hdr *hdr = (struct hci_sco_hdr *) buf;
+				struct hci_sco_hdr *hdr = (struct hci_sco_hdr *)buf;
 
 				pkt_len = HCI_SCO_HDR_SIZE + hdr->dlen;
 			} else {
@@ -335,8 +334,8 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 
 static void bfusb_rx_complete(struct urb *urb)
 {
-	struct sk_buff *skb = (struct sk_buff *) urb->context;
-	struct bfusb_data *data = (struct bfusb_data *) skb->dev;
+	struct sk_buff *skb = (struct sk_buff *)urb->context;
+	struct bfusb_data *data = (struct bfusb_data *)skb->dev;
 	unsigned char *buf = urb->transfer_buffer;
 	int count = urb->actual_length;
 	int err, hdr, len;
@@ -482,7 +481,7 @@ static int bfusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 		return -ENOMEM;
 	}
 
-	nskb->dev = (void *) data;
+	nskb->dev = (void *)data;
 
 	while (count) {
 		size = min_t(uint, count, BFUSB_MAX_BLOCK_SIZE);
@@ -536,13 +535,14 @@ static int bfusb_load_firmware(struct bfusb_data *data,
 	pipe = usb_sndctrlpipe(data->udev, 0);
 
 	if (usb_control_msg(data->udev, pipe, USB_REQ_SET_CONFIGURATION,
-				0, 1, 0, NULL, 0, USB_CTRL_SET_TIMEOUT) < 0) {
+			    0, 1, 0, NULL, 0, USB_CTRL_SET_TIMEOUT) < 0) {
 		BT_ERR("Can't change to loading configuration");
 		kfree(buf);
 		return -EBUSY;
 	}
 
-	data->udev->toggle[0] = data->udev->toggle[1] = 0;
+	data->udev->toggle[0] = data->udev->toggle[1];
+	data->udev->toggle[1] = 0;
 
 	pipe = usb_sndbulkpipe(data->udev, data->bulk_out_ep);
 
@@ -552,9 +552,9 @@ static int bfusb_load_firmware(struct bfusb_data *data,
 		memcpy(buf, firmware + sent, size);
 
 		err = usb_bulk_msg(data->udev, pipe, buf, size,
-					&len, BFUSB_BLOCK_TIMEOUT);
+				   &len, BFUSB_BLOCK_TIMEOUT);
 
-		if (err || (len != size)) {
+		if (err || len != size) {
 			BT_ERR("Error in firmware loading");
 			goto error;
 		}
@@ -564,7 +564,7 @@ static int bfusb_load_firmware(struct bfusb_data *data,
 	}
 
 	err = usb_bulk_msg(data->udev, pipe, NULL, 0,
-					&len, BFUSB_BLOCK_TIMEOUT);
+			   &len, BFUSB_BLOCK_TIMEOUT);
 	if (err < 0) {
 		BT_ERR("Error in null packet request");
 		goto error;
@@ -573,13 +573,14 @@ static int bfusb_load_firmware(struct bfusb_data *data,
 	pipe = usb_sndctrlpipe(data->udev, 0);
 
 	err = usb_control_msg(data->udev, pipe, USB_REQ_SET_CONFIGURATION,
-				0, 2, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
+			      0, 2, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
 	if (err < 0) {
 		BT_ERR("Can't change to running configuration");
 		goto error;
 	}
 
-	data->udev->toggle[0] = data->udev->toggle[1] = 0;
+	data->udev->toggle[0] = data->udev->toggle[1];
+	data->udev->toggle[1] = 0;
 
 	BT_INFO("BlueFRITZ! USB device ready");
 
@@ -592,7 +593,7 @@ static int bfusb_load_firmware(struct bfusb_data *data,
 	pipe = usb_sndctrlpipe(data->udev, 0);
 
 	usb_control_msg(data->udev, pipe, USB_REQ_SET_CONFIGURATION,
-				0, 0, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
+			0, 0, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
 
 	return err;
 }
-- 
2.40.1


