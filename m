Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE5C78E43A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345525AbjHaBOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345514AbjHaBOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:14:19 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894E3CF4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 18:14:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso1833775ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 18:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693444451; x=1694049251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEJrJjFBjmTqZTkw0c+MWJuIIZBtJEhPZv34AHJkSns=;
        b=e9jK+OWpu67aLOcXzPA0EqK8nAUsV2jYZppTtpy/Me6rCuHGKc9Qv4y6Loa+pKnu2O
         Iah/kH/DA4ODhUPLFfbWNmJFR6l2zaG89WOIMRYXG6O9f31e71oyXfmdCxojj/gbJpd0
         DDAPYyPUGAhiQp8AiPaqKpa93PMHCYpfeCAaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693444451; x=1694049251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEJrJjFBjmTqZTkw0c+MWJuIIZBtJEhPZv34AHJkSns=;
        b=b7KsLKSENe7xpdMZlfrR2Cb63jOrJj/8wPq3w2fHmLAxYBj6d1L88xtLJY1jELyr1Z
         0c5QLkh6eDX7Pt805JQ0mGZcOqbKZ1r6UD/qWs0LKWQyfSSII7Hj7MF1ExmJAyFPOyM8
         ISs9T+bf5IWnkEG2dAonPwygIJFgxLrsMxFJ+hcwklKEwebxprsESkKn6SQoCTaMzCNP
         ahi6CZBOZFHW7WL1lRT0U26kiwh2V7FWSjcFqHdykQ0RHoMjMGDeJWUD7LCiNcSkCaqd
         twnjsnNiNWFMsECCxtb6UR8VXn+GKwvXjprtFV5EShmEADDiFiQjWzGlo5OA+WnMNi8V
         1EAQ==
X-Gm-Message-State: AOJu0YzbwHXeNLkTPA/mktqXkNQ6IH0s91wRkuLXK1v0Q6PblaKttdz5
        2A1stluecGTGVIvpOOwFTuuNyA==
X-Google-Smtp-Source: AGHT+IGHRduua6XQHeyDpp5hHrYBbEi8NumNCWTxbmxfFd2rZUkD/waUAals2TVmFzvmYy5Ipr4rAA==
X-Received: by 2002:a17:902:6b47:b0:1c0:ec0a:316a with SMTP id g7-20020a1709026b4700b001c0ec0a316amr3353964plt.36.1693444451091;
        Wed, 30 Aug 2023 18:14:11 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:248f:d364:b451:2bc0])
        by smtp.gmail.com with ESMTPSA id im23-20020a170902bb1700b001bbb7af4963sm132604plb.68.2023.08.30.18.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 18:14:10 -0700 (PDT)
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
Subject: [PATCH 3/3] platform/x86: intel_scu_ipc: Fail IPC send if still busy
Date:   Wed, 30 Aug 2023 18:14:03 -0700
Message-ID: <20230831011405.3246849-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230831011405.3246849-1-swboyd@chromium.org>
References: <20230831011405.3246849-1-swboyd@chromium.org>
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
 drivers/platform/x86/intel_scu_ipc.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 2a21153e3bf3..5a56be319f0e 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -266,6 +266,19 @@ static int intel_scu_ipc_check_status(struct intel_scu_ipc_dev *scu)
 	return scu->irq > 0 ? ipc_wait_for_interrupt(scu) : busy_loop(scu);
 }
 
+static bool intel_scu_ipc_busy(struct intel_scu_ipc_dev *scu)
+{
+	u8 status;
+
+	status = ipc_read_status(scu);
+	if (status & IPC_STATUS_BUSY) {
+		dev_err(&scu->dev, "device is busy\n");
+		return true;
+	}
+
+	return false;
+}
+
 /* Read/Write power control(PMIC in Langwell, MSIC in PenWell) registers */
 static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
 			u32 count, u32 op, u32 id)
@@ -285,6 +298,10 @@ static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
 		mutex_unlock(&ipclock);
 		return -ENODEV;
 	}
+	if (intel_scu_ipc_busy(scu)) {
+		mutex_unlock(&ipclock);
+		return -EBUSY;
+	}
 
 	for (nc = 0; nc < count; nc++, offset += 2) {
 		cbuf[offset] = addr[nc];
@@ -445,6 +462,10 @@ int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
 		return -ENODEV;
 	}
 	scu = ipcdev;
+	if (intel_scu_ipc_busy(scu)) {
+		mutex_unlock(&ipclock);
+		return -EBUSY;
+	}
 	cmdval = sub << 12 | cmd;
 	ipc_command(scu, cmdval);
 	err = intel_scu_ipc_check_status(scu);
@@ -490,6 +511,10 @@ int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
 		mutex_unlock(&ipclock);
 		return -ENODEV;
 	}
+	if (intel_scu_ipc_busy(scu)) {
+		mutex_unlock(&ipclock);
+		return -EBUSY;
+	}
 
 	memcpy(inbuf, in, inlen);
 	for (i = 0; i < inbuflen; i++)
-- 
https://chromeos.dev

