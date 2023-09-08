Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCD4798C18
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343532AbjIHSEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237834AbjIHSEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:04:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748052118;
        Fri,  8 Sep 2023 11:03:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C4AC43140;
        Fri,  8 Sep 2023 18:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196226;
        bh=Ds2ca48eHKWVFliQolWPpkkuET/933RQElw9rithIac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ONbGZhilE1qzWQeFNPiofpHO42926ANPe8OXjSvxO0zkf+2vptM7gT+8/3/PqCC0H
         h7NVFc1YOuxMVtLRZfc32Opa5daJH8dX0CcwaVCM1w3NKLQCKN0ccmFjoxmGh//Xee
         P7Rp/Jyl/c/pmcg1P4sPIBUKFym5wPqpUFv8+HP7f8sQkX+oCK157//Hk1qCWAoK4/
         ihCLVdsx4LBycUVGlnWscfOxpZhoRZtue2T5kXjXkuDBZqZugo3qmrhCv8VGN2Hh5i
         jQdHkjaLqlbK83EOZEAYV1tgLD1e7EQaiwfpkP6tbQZ3uXybGVCr4EBKdu0bAFQ3WS
         pRanooE4nDNyQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 7/8] ACPI: video: Add backlight=native DMI quirk for Apple iMac12,1 and iMac12,2
Date:   Fri,  8 Sep 2023 14:03:18 -0400
Message-Id: <20230908180320.3458596-7-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908180320.3458596-1-sashal@kernel.org>
References: <20230908180320.3458596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.194
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 8cf04bb321f036dd2e523e993897e0789bd5265c ]

Linux defaults to picking the non-working ACPI video backlight interface
on the Apple iMac12,1 and iMac12,2.

Add a DMI quirk to pick the working native radeon_bl0 interface instead.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1838
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2753
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/video_detect.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 28e816be4753e..a5cb9e1d48bcc 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -357,6 +357,24 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "iMac11,3"),
 		},
 	},
+	{
+	 /* https://gitlab.freedesktop.org/drm/amd/-/issues/1838 */
+	 .callback = video_detect_force_native,
+	 /* Apple iMac12,1 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,1"),
+		},
+	},
+	{
+	 /* https://gitlab.freedesktop.org/drm/amd/-/issues/2753 */
+	 .callback = video_detect_force_native,
+	 /* Apple iMac12,2 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,2"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
 	 .callback = video_detect_force_native,
-- 
2.40.1

