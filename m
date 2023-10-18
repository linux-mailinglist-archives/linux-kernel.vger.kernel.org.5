Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0967CDE99
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344957AbjJROM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbjJROMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:12:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B90184;
        Wed, 18 Oct 2023 07:12:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8E7C433CB;
        Wed, 18 Oct 2023 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638330;
        bh=Fx7fqmGEpgzMOCUel/RgkUToOINnPMIGufOHI4Fg6FE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WqQo4qeQEPn45dKZf+Tcf06LXqWzPSwS3VO26C0yCK83+xvObw4rlH3nspTdLtNnb
         52OOPpmlh+twbgI5TL2XoEGgW04ROFYghkT+d1Jt9F6e8DE77dg8y4qMgzdyivfkCN
         62m08eGetHiyVTump8UIrr+ifY7N3mGRrMFsUVCIqzR1jEzY5+GJt037222hHp4ZsB
         Vmj8p/oPAx85dBDeJu05NC/EPNMWUmxFVk/g+hg+ySakLckfzbpOU2/dHtAaBpljo9
         XvmDtQ3XRqCbv0sXDFN4FqfixAEL1miIkA7t1Tjkui0+Gu7USY+Vi9yUtXsehtV4Hy
         ee423FnVnMtsQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 06/31] ACPI: EC: Add quirk for the HP Pavilion Gaming 15-dk1xxx
Date:   Wed, 18 Oct 2023 10:11:23 -0400
Message-Id: <20231018141151.1334501-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141151.1334501-1-sashal@kernel.org>
References: <20231018141151.1334501-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.7
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

[ Upstream commit cd4aece493f99f95d41edcce32927d70a5dde923 ]

Added GPE quirk entry for the HP Pavilion Gaming 15-dk1xxx.
There is a quirk entry for 2 15-c..... laptops, this is
for a new version which has 15-dk1xxx as identifier.

This fixes the LID switch and rfkill and brightness hotkeys
not working.

Closes: https://github.com/systemd/systemd/issues/28942
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 660834a49c1f9..c95d0edb0be9e 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1913,6 +1913,17 @@ static const struct dmi_system_id ec_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP 15-cx0041ur"),
 		},
 	},
+	{
+		/*
+		 * HP Pavilion Gaming Laptop 15-dk1xxx
+		 * https://github.com/systemd/systemd/issues/28942
+		 */
+		.callback = ec_honor_dsdt_gpe,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Gaming Laptop 15-dk1xxx"),
+		},
+	},
 	{
 		/*
 		 * Samsung hardware
-- 
2.40.1

