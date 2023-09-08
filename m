Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C002D798C30
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjIHSFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244181AbjIHSFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:05:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6182269A;
        Fri,  8 Sep 2023 11:04:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0625FC4166B;
        Fri,  8 Sep 2023 18:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196266;
        bh=L0zSuJOhdB2hQ7Bko3h9ZixT0pDP7Rg3T3Sw4Zlh9oE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=knO0gHS3GSsgVwC7396ovywKH1TKwz2dazKqn4dRmSpVu3vub7n9nD1VulmqDvYDe
         ALVDk26cxrWBQ+l98Wl7S1Pz12Eexl0nuUDKqXLcg5/WqxduVfHhOf0Qfiw+FnjpRt
         jJxoq02hxc3tdxlieD/xRoA7X22kM2pUrV6AlxROwQ1FA2gt2LiVQMLZiILP7kzDFf
         Iv58wWozqeW2/VUD/pqm6PgU82C/rfeYP/ZEVhgKPYx8BGnUm27PSJMV7GsbBiESmT
         lrwmZY6Mv+nGaPem5NzvTcgbX+FuI/EFZDx/aa5S2QogWCA07DYnrrsFrulBDB1NAo
         4mfb8ghGblmtw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 2/3] ACPI: video: Add backlight=native DMI quirk for Lenovo Ideapad Z470
Date:   Fri,  8 Sep 2023 14:04:19 -0400
Message-Id: <20230908180421.3458860-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908180421.3458860-1-sashal@kernel.org>
References: <20230908180421.3458860-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.325
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

[ Upstream commit 96b709be183c56293933ef45b8b75f8af268c6de ]

The Lenovo Ideapad Z470 predates Windows 8, so it defaults to using
acpi_video for backlight control. But this is not functional on this
model.

Add a DMI quirk to use the native backlight interface which works.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1208724
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/video_detect.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index b4f16073ef432..866bc20c82397 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -294,6 +294,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_BOARD_NAME, "Lenovo IdeaPad S405"),
 		},
 	},
+	{
+	 /* https://bugzilla.suse.com/show_bug.cgi?id=1208724 */
+	 .callback = video_detect_force_native,
+	 /* Lenovo Ideapad Z470 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Z470"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1187004 */
 	 .callback = video_detect_force_native,
-- 
2.40.1

