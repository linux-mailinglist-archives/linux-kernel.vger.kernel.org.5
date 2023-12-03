Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2663780202D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 02:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjLCBR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 20:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCBR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 20:17:26 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB99BB
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 17:17:32 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cdd4aab5f5so3648946b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 17:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hawknetworks.com; s=hawknetworks; t=1701566252; x=1702171052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VJuY8GE58qdOR7T86duPKoW3wzd9Ql6QkE8GpXHr/I4=;
        b=PXQtfmqRUB6cNdVzkWcUJgTlo1jwgR3UCp/dAPAF2E/m/g4uxjj+1x9zAJKcfPpovS
         vK9Jc7u1N8AeRPhLiZ6GJmUG/n5pi2D+TG/sNInvHkmCgtgNTSIWK6rFif66zUt5avMC
         z+K0YUWOwy0tcL8TlRg5+an0/NQEhvl4K//dE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701566252; x=1702171052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJuY8GE58qdOR7T86duPKoW3wzd9Ql6QkE8GpXHr/I4=;
        b=cCTubOKhnCzTsERGJD9QgoHGnOyF4AR5MluiLerMPdrrozreqIAcFtja1sM+VPN9hZ
         shQrfq3YBuUOQEwTI6RYMJOjpolYXcoPx47N3jUry/N0g+fYZo5HHk6Rc9BrPUfti/Ow
         wiGPCE5fyeRHp0cz0QJoQKkyUOLIV4jOdVCDXaRznH6QPsNeY846aWBb6yfFpe2NGpuN
         ueJqAzjRCpvBW6ydd0ylk2Laaz2jVVlgOAum57gKX6wB4J6su6KXsCHteX6FXUjtw0l6
         vjJLOp7ZNKEJfzLmjgdtlBWzHecnofh+rg/MHexrcGfAw9IgCZbWFi2DM3pHofgOFwP1
         jOSw==
X-Gm-Message-State: AOJu0YzMiFk6orbeWR2qFlbtiZIwBHn5lPCaw14tDzu9p541noVFttim
        Ej/SIxoFMz+Yr76kEO+gVA/EJA==
X-Google-Smtp-Source: AGHT+IGfaVYI9bV0rdDz70emOMa1CZFH4dogTRDVWXjCON7HkMRGMBsitKlfZ3VEnBZKYwLiMCiSMg==
X-Received: by 2002:a05:6a20:dd92:b0:148:f952:552b with SMTP id kw18-20020a056a20dd9200b00148f952552bmr2146109pzb.51.1701566252028;
        Sat, 02 Dec 2023 17:17:32 -0800 (PST)
Received: from kkane-x1.adsrvr.org ([47.145.249.123])
        by smtp.gmail.com with ESMTPSA id z19-20020a62d113000000b0068ffd56f705sm557766pfg.118.2023.12.02.17.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 17:17:31 -0800 (PST)
From:   Kelly Kane <kelly@hawknetworks.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] r8152: add vendor/device ID pair for ASUS USB-C2500
Date:   Sat,  2 Dec 2023 17:17:12 -0800
Message-Id: <20231203011712.6314-1-kelly@hawknetworks.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS USB-C2500 is an RTL8156 based 2.5G Ethernet controller.

Add the vendor and product ID values to the driver. This makes Ethernet
work with the adapter.

Signed-off-by: Kelly Kane <kelly@hawknetworks.com>
---
 drivers/net/usb/r8152.c   | 1 +
 include/linux/usb/r8152.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index afb20c0ed688..04aaae8a74c3 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9993,6 +9993,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff) },
 	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0601) },
 	{ USB_DEVICE(VENDOR_ID_DLINK,   0xb301) },
+	{ USB_DEVICE(VENDOR_ID_ASUS,    0x1976) },
 	{}
 };
 
diff --git a/include/linux/usb/r8152.h b/include/linux/usb/r8152.h
index 287e9d83fb8b..33a4c146dc19 100644
--- a/include/linux/usb/r8152.h
+++ b/include/linux/usb/r8152.h
@@ -30,6 +30,7 @@
 #define VENDOR_ID_NVIDIA		0x0955
 #define VENDOR_ID_TPLINK		0x2357
 #define VENDOR_ID_DLINK			0x2001
+#define VENDOR_ID_ASUS			0x0b05
 
 #if IS_REACHABLE(CONFIG_USB_RTL8152)
 extern u8 rtl8152_get_version(struct usb_interface *intf);

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.34.1

