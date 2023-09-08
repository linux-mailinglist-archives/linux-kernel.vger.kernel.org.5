Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CB9798BEB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245697AbjIHSCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242110AbjIHSCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:02:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694322114;
        Fri,  8 Sep 2023 11:02:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AD2C433BD;
        Fri,  8 Sep 2023 18:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196116;
        bh=cWfzasjKc6OYRtp8td5HXClSIfRavFdl20grMYcqxao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lp87JbxawyP2SnMp1OJrIByNaKDV86lYwVoTVWY7KgTN1dkYfKy+XkoBNhcS7Phme
         j5g3IYg77mCDjHkK9dldUSfqFZ+z2dN5p7ANxjhHqZcmm3mE97myspeW2Vu3ycF10z
         2XL+8cybJIflb1xp4S9k0uPB8H+HT4gAuEnMMhbY+TsU1LUxNJzhHbKdx+z66bpZMq
         onzPypMSJJG03UwI9dlZOz235NSyWhGG+y8RbM2aGx+8epoiXTtwlmnszee9ZavtTK
         uiA9phy4BhW7tUcGwCH9xqxcvpGOAhCrg/74bWAqK/gIlpNn8KJJowEMytyJIL2pX7
         M0RwLfOgP9GYA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        philipp.zabel@gmail.com, andriy.shevchenko@linux.intel.com,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 12/13] ACPI: x86: s2idle: Catch multiple ACPI_TYPE_PACKAGE objects
Date:   Fri,  8 Sep 2023 14:00:58 -0400
Message-Id: <20230908180100.3458151-12-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908180100.3458151-1-sashal@kernel.org>
References: <20230908180100.3458151-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 883cf0d4cf288313b71146ddebdf5d647b76c78b ]

If a badly constructed firmware includes multiple `ACPI_TYPE_PACKAGE`
objects while evaluating the AMD LPS0 _DSM, there will be a memory
leak.  Explicitly guard against this.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/s2idle.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index e499c60c45791..2e0778ddd0ad8 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -112,6 +112,12 @@ static void lpi_device_get_constraints_amd(void)
 		union acpi_object *package = &out_obj->package.elements[i];
 
 		if (package->type == ACPI_TYPE_PACKAGE) {
+			if (lpi_constraints_table) {
+				acpi_handle_err(lps0_device_handle,
+						"Duplicate constraints list\n");
+				goto free_acpi_buffer;
+			}
+
 			lpi_constraints_table = kcalloc(package->package.count,
 							sizeof(*lpi_constraints_table),
 							GFP_KERNEL);
-- 
2.40.1

