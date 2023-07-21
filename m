Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C897375CB97
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjGUPXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjGUPXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:23:25 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360F83AB6;
        Fri, 21 Jul 2023 08:23:02 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7EB9E3F30D;
        Fri, 21 Jul 2023 15:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689952954;
        bh=Ce8ROm7GD4JAsILKV21vfET07MwWq4GnXXI4EwwUbYs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=KPdeNJq0nBYQ2rVgU5ZOqtJLRnsBt9JCbPDbYwzm1DtsFYrAlU2SsHiWJVsOnn8Cx
         5+ql8zLYXESOoi7blIJSYAUeeAQ85UbmlB5QHPNMvIPDVnsmqb+vNYeCzWGB+vGEQv
         npbbAaYsuzPc+u/9ECXc6V22ww6XYp9kkzHfOj6It7jYuSpuqhgGU7ahBx1rKaR6Eb
         cdVDX0ZAXBEq1eZ2SIK73bD86ER77kNfD7A3fCN9KZ692+h2h49O349LsgamOEUGzs
         1Ez6bNubQAku0R969HEfxy1rl2JTAm3C0+k+64ARwY+VmD84KPCpkkFc/BuTaZG8Og
         PXDTvSvWwbp7Q==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rafael@kernel.org, lenb@kernel.org, hdegoede@redhat.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] ACPI: video: Put ACPI video and its child devices to D0 at boot
Date:   Fri, 21 Jul 2023 23:21:43 +0800
Message-Id: <20230721152143.3108017-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Screen brightness can only be changed once on HP ZBook Fury 16 G10.

Vendor identified the root cause as Linux doesn't invoke _PS0 at boot
for all ACPI devices:

    Scope (\_SB.PC00.GFX0)
    {
        Scope (DD1F)
        {
            Method (_PS0, 0, Serialized)  // _PS0: Power State 0
            {
                If (CondRefOf (\_SB.PC00.LPCB.EC0.SSBC))
                {
                    \_SB.PC00.LPCB.EC0.SSBC ()
                }
            }
	    ...
	}
	...
    }

The \_SB.PC00.GFX0.DD1F is the panel device, and its _PS0 needs to be
executed to make the brightness control work properly.

_PS0 doesn't get invoked for this device because _PSC is missing,
which violates ACPI spec 6.3, section 7.3.6. Commit 7cd8407d53ef
("ACPI / PM: Do not execute _PS0 for devices without _PSC during
initialization") tried to workaround missing _PSC on defective
firmwares, but got reverted because of regression.

So the safest approach is to use acpi_device_fix_up_power_extended() to
put ACPI video and its child devices to D0 to workaround the issue.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217683
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
 - Wording change to make it clear it's a firmware issue.
 - Specify the device name in comment.

v2:
 - Wording
 - Bugzilla
 - Add comment

 drivers/acpi/acpi_video.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 62f4364e4460..1732780a672b 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2027,6 +2027,12 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	if (error)
 		goto err_put_video;
 
+	/*
+	 * HP ZBook Fury 16 G10 requires ACPI video's child devices have _PS0
+	 * evaluated to have functional panel brightness control.
+	 */
+	acpi_device_fix_up_power_extended(device);
+
 	pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
 	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
 	       video->flags.multihead ? "yes" : "no",
-- 
2.34.1

