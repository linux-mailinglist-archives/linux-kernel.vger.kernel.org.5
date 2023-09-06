Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA187942D1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243745AbjIFSJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239230AbjIFSJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:09:54 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51F31700
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 11:09:50 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso128421a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 11:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694023790; x=1694628590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wi6bhruWz0hbXHukGopFEWiMps+cu8JOpx7s5KKUhM=;
        b=hYau4/nUz5iYqd5W7Lj14r5dMlAYeqsITBKXdHZLNSG+82MGmLXvcE+458iJ+JH7oi
         aoU+66bn6yw+JaPcXej1plpvtQaTLUI3sW/sIpuO6gjXM02xmiuJaqwWfUqMHI45GQZd
         fM4MgOHCXVOBcHjG02SBO+erWI7DAr1QLyxTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694023790; x=1694628590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wi6bhruWz0hbXHukGopFEWiMps+cu8JOpx7s5KKUhM=;
        b=eh/DJaT5Wn3UROcAXq+hM+LL7MZ89q9pJtjgLFobsrsvAMdNg5QJmZaemBHI0kYVQh
         YMiGHbU95NE9svZFOrSKMyGJbbRnrS5xzXoMB/5LPOw1cUK7Tqul/z4NB7/zjA346VYg
         qbLcdED/21gBMWP2eGbd2Ra5xZk+omEzST83RVsgcyjXs6QwzXGUIeKMIyMc3h7C/lyo
         A/WK639gP7hEQ0Kv77U/IGmYHL0YvGtRiFJ3QZmJVbin65JcU1PQ9Fr6PuxMgfhhFxt+
         zQXxMxjRqx2j6XkQ0d9+sFh2Q3PAZK3tIqIQ0mAE3+czdYujAnyopyrt9ZX7DLIoWvxM
         T/zA==
X-Gm-Message-State: AOJu0Yzp/qS0Dr7Bbot4jOZAdxp/ZDKVazOAn171NZI43MsKpFCS4gB0
        dm+c/1BSkvuxwQXvC6skiC0wsg==
X-Google-Smtp-Source: AGHT+IGRoSyy5prcv7s6aCNDx4HYofOxt/2GfTUCB8Kos+5pU7v9KRLevtDFB4w6cibWsZB6VVxy4A==
X-Received: by 2002:a17:902:e5c3:b0:1c3:52ed:1905 with SMTP id u3-20020a170902e5c300b001c352ed1905mr6467512plf.28.1694023790329;
        Wed, 06 Sep 2023 11:09:50 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:a404:ed4a:5a1e:3b4a])
        by smtp.gmail.com with ESMTPSA id ix5-20020a170902f80500b001bc675068e2sm11363996plb.111.2023.09.06.11.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:09:49 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v2 3/3] platform/x86: intel_scu_ipc: Fail IPC send if still busy
Date:   Wed,  6 Sep 2023 11:09:43 -0700
Message-ID: <20230906180944.2197111-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230906180944.2197111-1-swboyd@chromium.org>
References: <20230906180944.2197111-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible for interrupts to get significantly delayed to the point
that callers of intel_scu_ipc_dev_command() and friends can call the
function once, hit a timeout, and call it again while the interrupt
still hasn't been processed. This driver will get seriously confused if
the interrupt is finally processed after the second IPC has been sent
with ipc_command(). It won't know which IPC has been completed. This
could be quite disastrous if calling code assumes something has happened
upon return from intel_scu_ipc_dev_simple_command() when it actually
hasn't.

Let's avoid this scenario by simply returning -EBUSY in this case.
Hopefully higher layers will know to back off or fail gracefully when
this happens. It's all highly unlikely anyway, but it's better to be
correct here as we have no way to know which IPC the status register is
telling us about if we send a second IPC while the previous IPC is still
processing.

Cc: Prashant Malani <pmalani@chromium.org>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Fixes: ed12f295bfd5 ("ipc: Added support for IPC interrupt mode")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/x86/intel_scu_ipc.c | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 3cea701d2bbd..8be24f48a0fa 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -271,6 +271,19 @@ static int intel_scu_ipc_check_status(struct intel_scu_ipc_dev *scu)
 	return scu->irq > 0 ? ipc_wait_for_interrupt(scu) : busy_loop(scu);
 }
 
+static int intel_scu_ipc_busy(struct intel_scu_ipc_dev *scu)
+{
+	u8 status;
+
+	status = ipc_read_status(scu);
+	if (status & IPC_STATUS_BUSY) {
+		dev_dbg(&scu->dev, "device is busy\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 /* Read/Write power control(PMIC in Langwell, MSIC in PenWell) registers */
 static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
 			u32 count, u32 op, u32 id)
@@ -290,6 +303,11 @@ static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
 		mutex_unlock(&ipclock);
 		return -ENODEV;
 	}
+	err = intel_scu_ipc_busy(scu);
+	if (err) {
+		mutex_unlock(&ipclock);
+		return err;
+	}
 
 	for (nc = 0; nc < count; nc++, offset += 2) {
 		cbuf[offset] = addr[nc];
@@ -450,6 +468,12 @@ int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
 		return -ENODEV;
 	}
 	scu = ipcdev;
+	err = intel_scu_ipc_busy(scu);
+	if (err) {
+		mutex_unlock(&ipclock);
+		return err;
+	}
+
 	cmdval = sub << 12 | cmd;
 	ipc_command(scu, cmdval);
 	err = intel_scu_ipc_check_status(scu);
@@ -495,6 +519,11 @@ int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
 		mutex_unlock(&ipclock);
 		return -ENODEV;
 	}
+	err = intel_scu_ipc_busy(scu);
+	if (err) {
+		mutex_unlock(&ipclock);
+		return err;
+	}
 
 	memcpy(inbuf, in, inlen);
 	for (i = 0; i < inbuflen; i++)
-- 
https://chromeos.dev

