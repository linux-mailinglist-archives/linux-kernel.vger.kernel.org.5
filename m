Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71551758B65
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjGSCdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGSCdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:33:39 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203411FE8;
        Tue, 18 Jul 2023 19:33:16 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 685C041314;
        Wed, 19 Jul 2023 02:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689733995;
        bh=coNK51IF4YKf75VmW+r/k/vCwNZWQgu3CZj6SU+JB84=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=eSCoOQZFXLB8H6YUMZDfzMvmYLT/w5QwfEqSkRC1dBmRpgvB7u+88nmm+aPG8qRmb
         QgIAW+/q4DEne7I7ic7PIQeJQ0lnSDt/l3tdxs9/s3yI9H7caygSryUcbTKiJb46v/
         tFGb5O0pjAP4CmtYdpuaJ6ttp+QGhbG19rBTPkM97ET2Ggny1a/H3cK/wXfPPn6hUC
         51GYbJM8ZKJTYx+zxIqukIkDElsyEyMnoEu82ZFDRmMvkKsxkg8ueWsAweQbp9HXiH
         0irZDTjBaXGWp3zY7X+Vi8g5YPCNtI5TmTOWyq2ZBeRjifrxXRefpis0ojcg5gwjBi
         9ki5OR1MhpBhA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rafael@kernel.org, lenb@kernel.org, hdegoede@redhat.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI: video: Put ACPI video and its child devices to D0 at boot
Date:   Wed, 19 Jul 2023 10:32:23 +0800
Message-Id: <20230719023223.2971481-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Screen brightness can only be changed once on some HP laptops.

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

_PS0 doesn't get invoked for all ACPI devices because of commit
7cd8407d53ef ("ACPI / PM: Do not execute _PS0 for devices without _PSC
during initialization"). For now use acpi_device_fix_up_power_extended()
to put ACPI video and its child devices to D0 to workaround the issue.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217683
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Wording
 - Bugzilla
 - Add comment

 drivers/acpi/acpi_video.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 62f4364e4460..bac614e9fe56 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2027,6 +2027,13 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	if (error)
 		goto err_put_video;
 
+
+	/*
+	 * Some HP laptops require ACPI video's child devices have _PS0
+	 * evaluated to have functional panel brightness control.
+	 */
+	acpi_device_fix_up_power_extended(device);
+
 	pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
 	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
 	       video->flags.multihead ? "yes" : "no",
-- 
2.34.1

