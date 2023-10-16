Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702CC7CA00B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjJPHCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjJPHCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:02:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83975D9;
        Mon, 16 Oct 2023 00:02:21 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98377c5d53eso632127766b.0;
        Mon, 16 Oct 2023 00:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697439740; x=1698044540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JIhJBlbfwa6Zp2zLHD2ldrf9h2gYA0FwmEhnEtZ+bAA=;
        b=MgXEtRK4mXbs+M0Z8vSkYzPI7bTAv+bs8lG8kNrSHR1IjueQH6IMrixUGB1y/eafF4
         RlKBERIZmqCJ0bjOWpGY7PS0sZZojGX1BuWOn6Md+xUfOnhx2UhDk3fw+w1GmaLzdSze
         NIdcPncMnFRrKGN4xS1QcTHBiJd3SIHJ8J/n0y6bCnJ0jb0d9iEBCCIObefpqdZowNMM
         QPH+Mwn1uH7MygrXLHqT8jxJMzbSA230HQACXho8lCN/2hL6VBlV46wCkJuhMtbQGPKr
         TFvLBNDKojtreGlRxv1I9Cqkx6AkAsgrevAGTIJJuyQpXB+LNE4ENqSF/8fJB9inJUrt
         vuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697439740; x=1698044540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JIhJBlbfwa6Zp2zLHD2ldrf9h2gYA0FwmEhnEtZ+bAA=;
        b=oAKV/2oWditLkt0jwtxEUjQvq2ATp2Y6KxL5CpjiqEDK4p4TndT5wbdgx9TqR85E9O
         NY9Qva1nUdEqqKPrvlPM1dewFKoRlIHfB2UGW0RGEjAdDkDSZ5J+OvOrUwDFEjY33mup
         vUWsQHPSFkR6Xql+RRWsfO/R1tZ+kfzHF3GgTCjbkdgT9CA8BtvVxhZaK1EovCxiBal9
         X/GsxtqGufJw1/C4wFuuEvaUfAOaA0D1ZJxX4BtrOJiMq8H8EE/XJCzt0f0pFqEWNheq
         x5L6kyg/BiJcjlNKgLI/2SauvLNX2V8URNA3asYD196A+lz5NVnTR3tm2BvEZx2yLshF
         Vtag==
X-Gm-Message-State: AOJu0Yw2+N1/uti18kZHVpwgGVGztCdcNWs4OKzy6Om5IoWWrLkcl9JM
        vhCn5GZCP+sHuyN/0BoPuAJXTgku8NQ=
X-Google-Smtp-Source: AGHT+IH28wgV2U9Nyc6iqsQnirqZTp1XcCXiz7OPfsAX1XjoVX6nEUujS5Hfl6zbDoMKfNKEp7yxww==
X-Received: by 2002:a17:907:7804:b0:9ad:9225:ced2 with SMTP id la4-20020a170907780400b009ad9225ced2mr27086794ejc.62.1697439739572;
        Mon, 16 Oct 2023 00:02:19 -0700 (PDT)
Received: from sauvignon.fi.muni.cz ([2001:718:801:22c:bdcb:518:be8f:6a76])
        by smtp.gmail.com with ESMTPSA id e16-20020a170906749000b0099bd0b5a2bcsm3447276ejl.101.2023.10.16.00.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:02:18 -0700 (PDT)
From:   Milan Broz <gmazyland@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        linux-kernel@vger.kernel.org, Milan Broz <gmazyland@gmail.com>
Subject: [PATCH] scsi: use ATA-12 pass-thru for OPAL as fallback
Date:   Mon, 16 Oct 2023 09:02:11 +0200
Message-ID: <20231016070211.39502-1-gmazyland@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB attached storage (handled by UAS or usb-storage driver) does not
support SCSI SECURITY IN/OUT commands. (USB adapters usually do not
support it, and USB drivers also turn off SCSI command enumeration).

The original sedutils (used to configure OPAL from userspace)
always used the ATA-12 pass-through command.

Internal kernel implementation for OPAL interface (sed-opal ioctls)
currently supports only SCSI SECURITY IN/OUT command wrapper.

This patch adds an optional wrapper to the SCSI layer for the ATA-12
pass-thru command as an alternative if SECURITY IN/OUT is unavailable.
The wrapper has the same structure as tools that talk to OPAL drives
through ioctl from userspace.

All common USB/SATA or USB/NVMe adapters I tested need this patch.

In short, these steps are run for OPAL support check:
  1) Storage driver enables security driver flag (security_supported).
     USB-attached storage drivers will enable it in a separate patchset.
     SCSI and NNVMe drivers do it already. If the flag is not enabled,
     no following steps are run, and OPAL remains disabled.
  2) SCSI device enumerates SECURITY IN/OUT command support. If detected,
     SECURITY ON/OUT wrapper is used (as in the current code).
     If not, new ATA-12 pass-thru wrapper is used instead.
  3) SED OPAL code tries OPAL discovery command for the device.
     If it receives a correct reply, OPAL is enabled for the device.
     If SCSI SECURITY or ATA-12 command with discovery command is rejected,
     OPAL remains disabled.

Note, USB attached storage needs an additional patchset sent separately
as requested by USB driver maintainers (it contains required changes
related to USB quirk processing).

Signed-off-by: Milan Broz <gmazyland@gmail.com>
---
 drivers/scsi/sd.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 83b6a3f3863b..3782556cb461 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -686,6 +686,32 @@ static int sd_sec_submit(void *data, u16 spsp, u8 secp, void *buffer,
 			       &exec_args);
 	return ret <= 0 ? ret : -EIO;
 }
+
+static int sd_ata12_submit(void *data, u16 spsp, u8 secp, void *buffer,
+		size_t len, bool send)
+{
+	struct scsi_disk *sdkp = data;
+	struct scsi_device *sdev = sdkp->device;
+	u8 cdb[12] = { 0, };
+	const struct scsi_exec_args exec_args = {
+		.req_flags = BLK_MQ_REQ_PM,
+	};
+	int ret;
+
+	cdb[0] = ATA_12;
+	cdb[1] = (send ? 5 /* ATA_PROTOCOL_PIO_DATA_IN */ : 4 /* ATA_PROTOCOL_PIO_DATA_OUT */) << 1;
+	cdb[2] = 2 /* t_length */ | (1 << 2) /* byt_blok */ | ((send ?  0 : 1) << 3) /* t_dir */;
+	cdb[3] = secp;
+	put_unaligned_le16(len / 512, &cdb[4]);
+	put_unaligned_le16(spsp, &cdb[6]);
+	cdb[9] = send ? 0x5e /* ATA_CMD_TRUSTED_SND */: 0x5c /* ATA_CMD_TRUSTED_RCV */;
+
+	ret = scsi_execute_cmd(sdev, cdb, send ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
+			       buffer, len, SD_TIMEOUT, sdkp->max_retries,
+			       &exec_args);
+	return ret <= 0 ? ret : -EIO;
+}
+
 #endif /* CONFIG_BLK_SED_OPAL */
 
 /*
@@ -3699,8 +3725,11 @@ static int sd_probe(struct device *dev)
 		goto out;
 	}
 
-	if (sdkp->security) {
-		sdkp->opal_dev = init_opal_dev(sdkp, &sd_sec_submit);
+	if (sdp->security_supported) {
+		if (sdkp->security)
+		    sdkp->opal_dev = init_opal_dev(sdkp, &sd_sec_submit);
+		else
+		    sdkp->opal_dev = init_opal_dev(sdkp, &sd_ata12_submit);
 		if (sdkp->opal_dev)
 			sd_printk(KERN_NOTICE, sdkp, "supports TCG Opal\n");
 	}
-- 
2.42.0

