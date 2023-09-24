Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA687AC9D1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjIXNnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjIXNno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:43:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D3A2D65;
        Sun, 24 Sep 2023 06:18:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94262C433A9;
        Sun, 24 Sep 2023 13:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561506;
        bh=gszbO0Lx/8kVOY7YbEReDpylr2edA7MLpqwjKJN//SM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eDgb3StoFZD/eSBUL4bCAQAbQC1FEpWkcHJWy0cz90eXGUM8rEjL4dSJyhfhhGXz2
         puOkBpEa9BRR2NvaXqViX03j/q+5993FSZJT9QqBBujjgQpNjiSNDQzSQs907KyFD4
         Ufn2MziwyO66VxZdd8gQ0wPBipO+dxCxAjMPn6qoMYk6W38ktuXM31JM5P7tAiW6JM
         dxMEltSPOTV6NcnPiAcwwS/H6LPKAhbdsdwSwKhLpULEVnwea3N1BYFFG0off44pwz
         VNluRtWhna72PL7sq2+25yPck4tMCcwEuK8TyS2NOiUpzgU9frbdUJDPOr5ZNhMQM0
         yrjxC8spErH8g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Luke D. Jones" <luke@ljones.dev>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>, corentin.chary@gmail.com,
        ilpo.jarvinen@linux.intel.com, markgross@kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 18/28] platform/x86: asus-wmi: Support 2023 ROG X16 tablet mode
Date:   Sun, 24 Sep 2023 09:17:35 -0400
Message-Id: <20230924131745.1275960-18-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131745.1275960-1-sashal@kernel.org>
References: <20230924131745.1275960-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.55
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Luke D. Jones" <luke@ljones.dev>

[ Upstream commit 4106a70ddad57ee6d8f98b81d6f036740c72762b ]

Add quirk for ASUS ROG X16 (GV601V, 2023 versions) Flow 2-in-1
to enable tablet mode with lid flip (all screen rotations).

Signed-off-by: Luke D. Jones <luke@ljones.dev>
Link: https://lore.kernel.org/r/20230905082813.13470-1-luke@ljones.dev
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-nb-wmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index fdf7da06af306..d85d895fee894 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -478,6 +478,15 @@ static const struct dmi_system_id asus_quirks[] = {
 		},
 		.driver_data = &quirk_asus_tablet_mode,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS ROG FLOW X16",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "GV601V"),
+		},
+		.driver_data = &quirk_asus_tablet_mode,
+	},
 	{
 		.callback = dmi_matched,
 		.ident = "ASUS VivoBook E410MA",
-- 
2.40.1

