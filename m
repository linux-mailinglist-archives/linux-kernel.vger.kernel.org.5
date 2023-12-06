Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A56806F3B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377821AbjLFLyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377869AbjLFLyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:54:39 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD6F1739
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:54:08 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cb55001124so607802b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 03:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701863648; x=1702468448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UfUHNpfPacLF7I7URyFEVrXNCwdHWIRysCzkc7i/pu4=;
        b=MqHktkueGoeNznE3RU5M7tVL9HywbvIBsbKvAMQHaq14duk9NY6ByuKHvoXCSRxv6J
         aWtmweCJVgv0H6wshZntXjSF5ScMf3ZArYfhlF8o4kJKt3LVopTGSDy7uGITUn5wvpKr
         LrgNUHwI0cLuPEnPAGFSPAX7acL6g9rDTHXLSX3lh0A0TW/vtz8YIkUX5CCQqRNhtGXr
         u1q/J0LyBoWouxMiJe2f5dihj2zpEkBN5LBUhONAGBSj4araGMsuco0thnt32d5UaKC0
         suFwsj5LwYpcQD6ETKNWva2EC53gEubpM2PaQKffXA3gEX21oq8KbFlybkMyNfocsOJT
         s0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701863648; x=1702468448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfUHNpfPacLF7I7URyFEVrXNCwdHWIRysCzkc7i/pu4=;
        b=DSwI0AYXVD8Sz2CM0vsc6SBj/0WTBol3LzXZl6tPELdDKtGZSKc/gAWq0Wpn6wLv8P
         nu1bt/vKq+S2HG4VOrPHzgAnAOYIok5M9TKfvJz3yxlTpzTUil+rxrMKTRaQlJoZIZOg
         9/66KQc9GP+KpVua7D+wG4Y5QOLMrNRctdnnzVxwlzBkNUvUn/iCWfJGnSlvhnRl+Dem
         y0z9H5NBBBK/u6eJld8PLYTTY4Bw/sZSlbmRNfZVWHjdRFTls/h5GRLN9IB3E814Axis
         WTFz8tUIu+0DlF3Du0fWA7f/+qnxY1cLFIEjXLhUqcI2jQ28x3SHfvQGBpVp87A340IO
         PTgw==
X-Gm-Message-State: AOJu0Yz3n/6h7hDF43SBiqSICpywFUMlMDm35whaNxe1xp9VEXLYcEd8
        gwuK+UB1hZexB6fX3Q/gDpY=
X-Google-Smtp-Source: AGHT+IGP6QXdg4aAskS6XxG0PjhaGNiNJl9sMHSJHibhIfVxl8fvLfLDOgZKQw3qhtKBzxCmmgAZlA==
X-Received: by 2002:a05:6a20:100f:b0:18f:97c:3854 with SMTP id gs15-20020a056a20100f00b0018f097c3854mr975047pzc.46.1701863647706;
        Wed, 06 Dec 2023 03:54:07 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id u22-20020a056a00125600b006ce321a9523sm7542327pfi.49.2023.12.06.03.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 03:54:07 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] drivers: base: Introduce a new kernel parameter driver_sync_probe=
Date:   Wed,  6 Dec 2023 11:53:55 +0000
Message-Id: <20231206115355.4319-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading our kernel from version 4.19 to 6.1, certain regressions
occurred due to the driver's asynchronous probe behavior. Specifically,
the SCSI driver transitioned to an asynchronous probe by default, resulting
in a non-fixed root disk behavior. In the prior 4.19 kernel, the root disk
was consistently identified as /dev/sda. However, with kernel 6.1, the root
disk can be any of /dev/sdX, leading to issues for applications reliant on
/dev/sda, notably impacting monitoring systems monitoring the root disk.

To address this, a new kernel parameter 'driver_sync_probe=' is introduced
to enforce synchronous probe behavior for specific drivers.

For instance, using the following kernel parameter:

  driver_sync_probe=sd,nvme

The sd (SCSI) and nvme disks will undergo synchronous probing. This ensures
that these disks maintain consistent identification behavior despite the
default asynchronous probe, mitigating the issues experienced by
applications reliant on fixed disk identification.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         | 10 +++++
 drivers/base/dd.c                             | 41 ++++++++++++++-----
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..9b1a12b24f65 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1144,6 +1144,16 @@
 			match the *.
 			Format: <driver_name1>,<driver_name2>...
 
+	driver_sync_probe=  [KNL]
+			List of driver names to be probed synchronously. *
+			matches with all driver names. If * is specified, the
+			rest of the listed driver names are those that will NOT
+			match the *.
+			Format: <driver_name1>,<driver_name2>...
+
+			Note that 'driver_sync_probe=' takes precedence over
+			'driver_async_probe=' if both parameters are set.
+
 	drm.edid_firmware=[<connector>:]<file>[,[<connector>:]<file>]
 			Broken monitors, graphic adapters, KVMs and EDIDless
 			panels may send no or incorrect EDID data sets.
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 0c3725c3eefa..f4d8f0b76b26 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -58,9 +58,11 @@ static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
 static bool initcalls_done;
 
 /* Save the async probe drivers' name from kernel cmdline */
-#define ASYNC_DRV_NAMES_MAX_LEN	256
-static char async_probe_drv_names[ASYNC_DRV_NAMES_MAX_LEN];
+#define PROBE_DRV_NAMES_MAX_LEN	256
+static char async_probe_drv_names[PROBE_DRV_NAMES_MAX_LEN];
 static bool async_probe_default;
+static char sync_probe_drv_names[PROBE_DRV_NAMES_MAX_LEN];
+static bool sync_probe_default;
 
 /*
  * In some cases, like suspend to RAM or hibernation, It might be reasonable
@@ -843,30 +845,48 @@ static int driver_probe_device(struct device_driver *drv, struct device *dev)
 	return ret;
 }
 
-static inline bool cmdline_requested_async_probing(const char *drv_name)
+static inline bool
+cmdline_requested_probing(const char *drv_name, const char *drv_names, bool all_drv)
 {
-	bool async_drv;
+	bool probe_drv;
 
-	async_drv = parse_option_str(async_probe_drv_names, drv_name);
-
-	return (async_probe_default != async_drv);
+	probe_drv = parse_option_str(drv_names, drv_name);
+	return (all_drv != probe_drv);
 }
 
 /* The option format is "driver_async_probe=drv_name1,drv_name2,..." */
 static int __init save_async_options(char *buf)
 {
-	if (strlen(buf) >= ASYNC_DRV_NAMES_MAX_LEN)
+	if (strlen(buf) >= PROBE_DRV_NAMES_MAX_LEN)
 		pr_warn("Too long list of driver names for 'driver_async_probe'!\n");
 
-	strscpy(async_probe_drv_names, buf, ASYNC_DRV_NAMES_MAX_LEN);
+	strscpy(async_probe_drv_names, buf, PROBE_DRV_NAMES_MAX_LEN);
 	async_probe_default = parse_option_str(async_probe_drv_names, "*");
 
 	return 1;
 }
 __setup("driver_async_probe=", save_async_options);
 
+/* The option format is "driver_sync_probe=drv_name1,drv_name2,..."
+ * driver_sync_probe is prior to driver_async_probe if both of them are set.
+ */
+static int __init save_sync_options(char *buf)
+{
+	if (strlen(buf) >= PROBE_DRV_NAMES_MAX_LEN)
+		pr_warn("Too long list of driver names for 'driver_sync_probe'!\n");
+
+	strscpy(sync_probe_drv_names, buf, PROBE_DRV_NAMES_MAX_LEN);
+	sync_probe_default = parse_option_str(sync_probe_drv_names, "*");
+
+	return 1;
+}
+__setup("driver_sync_probe=", save_sync_options);
+
 static bool driver_allows_async_probing(struct device_driver *drv)
 {
+	if (cmdline_requested_probing(drv->name, sync_probe_drv_names, sync_probe_default))
+		return false;
+
 	switch (drv->probe_type) {
 	case PROBE_PREFER_ASYNCHRONOUS:
 		return true;
@@ -875,7 +895,8 @@ static bool driver_allows_async_probing(struct device_driver *drv)
 		return false;
 
 	default:
-		if (cmdline_requested_async_probing(drv->name))
+		if (cmdline_requested_probing(drv->name, async_probe_drv_names,
+					      async_probe_default))
 			return true;
 
 		if (module_requested_async_probing(drv->owner))
-- 
2.30.1 (Apple Git-130)

