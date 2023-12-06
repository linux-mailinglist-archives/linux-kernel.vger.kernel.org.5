Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90115807357
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379098AbjLFPGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379084AbjLFPGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:06:12 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E34BD4D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:06:15 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6ce9c8c45a7so329629b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 07:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701875174; x=1702479974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wvGGeUhAcBlY5JsYq0v3hWMNXvHne0yXH5FlnUniu4=;
        b=U4elgeEYIQUcvbzJNcMC76sY3cr1uj9UNeLapfAi9a3z50MM2f22dOsGvY6KskCxrt
         sFDkdkAba5ySC0Atb1/d3o/nQSaPVdHx+Qat4xNGwIu3U6i4t4eyXtirbv0sOlCIv7XC
         hRsOLrJgasDMWWn6c61RVBOe5xQCcfr2k4UcOi9UVgrAd1WBC0hAjfztFdpzkvoQpiQ4
         yUIBUBLSazRAPzaIb8LTvdswlB37bLWAkBbWwktTjxj5HvFFlfNsHBKvX63tQkBjB39h
         rWppAu/qYM1rfd4/fKma3U9Q/uLpoctu0xy45lXgQBi29NggA0mPB2Hc9Nbdlhyg/7T2
         rvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875174; x=1702479974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wvGGeUhAcBlY5JsYq0v3hWMNXvHne0yXH5FlnUniu4=;
        b=SYpoOCtzKnXGZxLWFtvRGSP1uJIE1FiKTeh6IdMMZRDY2q9uW3CSqiZlrqxzzEMwVB
         BEaOab+eVd4zUYLVelRcHZM85JEMQhLcmaXyaOSPFpyngnlPmplBMUxo2zGSGBS485Yz
         WXSo+dOvA3UsIqQBq/LmoTsAS60whtmZSOJIfoUfQUB5pjKmb8/SLTdcHvDb9HKXrNkh
         tl+J3d5MafOYa/suAxUk0oP5G2bZ0kS1n2Ccx9pNS6Q27E1VLEUyFvYGiu7tkQ05MSOY
         3BAxTIpX4Rb37r3MgQ/D28d2VuV5IaA8T/4jraKT3GlyMOyl9VkgqwP2nDLuLpijz5Qr
         O3xQ==
X-Gm-Message-State: AOJu0YxsZpbiUYkLqepTBS8APbLnv9u2ZSTePh5Ynlhjd+rH6ygxhsKQ
        rK6/7Qun9NfGsP0+G1r9pJ8=
X-Google-Smtp-Source: AGHT+IHBbuqWhu8nKhe+H9p6HqLEg9xo+xunL7MYEGAAVkWuTI3aJsFG2pqQgZkaRdr6gs+jjP6Uaw==
X-Received: by 2002:a05:6a20:5141:b0:18f:97c:4f6d with SMTP id b1-20020a056a20514100b0018f097c4f6dmr532514pzc.121.1701875174553;
        Wed, 06 Dec 2023 07:06:14 -0800 (PST)
Received: from toolbox.. ([2401:4900:1f3e:53bf:50c7:2988:e019:4b97])
        by smtp.gmail.com with ESMTPSA id s5-20020a625e05000000b006ce7ed5ba41sm96885pfb.55.2023.12.06.07.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:06:14 -0800 (PST)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, jkridner@beagleboard.org, nm@ti.com,
        yujie.liu@intel.com
Subject: [PATCH 1/1] greybus: gb-beagleplay: Remove use of pad bytes
Date:   Wed,  6 Dec 2023 20:36:00 +0530
Message-ID: <20231206150602.176574-2-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206150602.176574-1-ayushdevel1325@gmail.com>
References: <20231206150602.176574-1-ayushdevel1325@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make gb-beagleplay greybus spec compliant by using a wrapper around HDLC
payload to include cport information.

Fixes: ec558bbfea67 ("greybus: Add BeaglePlay Linux Driver")
Reported-by: kernel test robot <yujie.liu@intel.com>
Closes: https://lore.kernel.org/r/202311072329.Xogj7hGW-lkp@intel.com/
Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 drivers/greybus/gb-beagleplay.c | 44 +++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
index 1e70ff7e3da4..fb40ade9364f 100644
--- a/drivers/greybus/gb-beagleplay.c
+++ b/drivers/greybus/gb-beagleplay.c
@@ -85,17 +85,35 @@ struct hdlc_payload {
 	void *buf;
 };
 
+/**
+ * struct hdlc_greybus_frame - Structure to represent greybus HDLC frame
+ *
+ * @cport: cport id
+ * @hdr: greybus operation header
+ * @payload: greybus message payload
+ */
+struct hdlc_greybus_frame {
+	__le16 cport;
+	struct gb_operation_msg_hdr hdr;
+	u8 payload[];
+} __packed;
+
 static void hdlc_rx_greybus_frame(struct gb_beagleplay *bg, u8 *buf, u16 len)
 {
-	u16 cport_id;
-	struct gb_operation_msg_hdr *hdr = (struct gb_operation_msg_hdr *)buf;
+	struct hdlc_greybus_frame *gb_frame = (struct hdlc_greybus_frame *)buf;
+	u16 cport_id = le16_to_cpu(gb_frame->cport);
 
-	memcpy(&cport_id, hdr->pad, sizeof(cport_id));
+	/* Ensure that the greybus message is valid */
+	if (le16_to_cpu(gb_frame->hdr.size) > len - sizeof(cport_id)) {
+		dev_warn_ratelimited(&bg->sd->dev, "Invalid/Incomplete greybus message");
+		return;
+	}
 
 	dev_dbg(&bg->sd->dev, "Greybus Operation %u type %X cport %u status %u received",
-		hdr->operation_id, hdr->type, le16_to_cpu(cport_id), hdr->result);
+		gb_frame->hdr.operation_id, gb_frame->hdr.type, cport_id, gb_frame->hdr.result);
 
-	greybus_data_rcvd(bg->gb_hd, le16_to_cpu(cport_id), buf, len);
+	greybus_data_rcvd(bg->gb_hd, cport_id, &buf[sizeof(cport_id)],
+			  le16_to_cpu(gb_frame->hdr.size));
 }
 
 static void hdlc_rx_dbg_frame(const struct gb_beagleplay *bg, const char *buf, u16 len)
@@ -339,7 +357,7 @@ static struct serdev_device_ops gb_beagleplay_ops = {
 static int gb_message_send(struct gb_host_device *hd, u16 cport, struct gb_message *msg, gfp_t mask)
 {
 	struct gb_beagleplay *bg = dev_get_drvdata(&hd->dev);
-	struct hdlc_payload payloads[2];
+	struct hdlc_payload payloads[3];
 	__le16 cport_id = le16_to_cpu(cport);
 
 	dev_dbg(&hd->dev, "Sending greybus message with Operation %u, Type: %X on Cport %u",
@@ -348,14 +366,14 @@ static int gb_message_send(struct gb_host_device *hd, u16 cport, struct gb_messa
 	if (le16_to_cpu(msg->header->size) > RX_HDLC_PAYLOAD)
 		return dev_err_probe(&hd->dev, -E2BIG, "Greybus message too big");
 
-	memcpy(msg->header->pad, &cport_id, sizeof(cport_id));
-
-	payloads[0].buf = msg->header;
-	payloads[0].len = sizeof(*msg->header);
-	payloads[1].buf = msg->payload;
-	payloads[1].len = msg->payload_size;
+	payloads[0].buf = &cport_id;
+	payloads[0].len = sizeof(cport_id);
+	payloads[1].buf = msg->header;
+	payloads[1].len = sizeof(*msg->header);
+	payloads[2].buf = msg->payload;
+	payloads[2].len = msg->payload_size;
 
-	hdlc_tx_frames(bg, ADDRESS_GREYBUS, 0x03, payloads, 2);
+	hdlc_tx_frames(bg, ADDRESS_GREYBUS, 0x03, payloads, 3);
 	greybus_message_sent(bg->gb_hd, msg, 0);
 
 	return 0;
-- 
2.43.0

