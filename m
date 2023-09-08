Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEB3798BDC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245614AbjIHSCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245695AbjIHSCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:02:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34112690;
        Fri,  8 Sep 2023 11:01:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9E9C43391;
        Fri,  8 Sep 2023 18:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196054;
        bh=QHkqxQuF5g5yQOxy9JLwWisHm4xeq+bCIzYItndb6zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sf84edZRT7A1CpaA0fCFXyLsctHgzn1+eJCbjzVIQCfgait5o41vKviYGAtt0+WeR
         mr9VwNslWNpQdBmf+H5CxJBYrUUyJQaVGphHA/ku3F1aH3TX14lbTDznpZ9IEHyAaB
         PnK0FaBvvUo1b3QVxx5fowCfTBE5vr6+6llu26QwyvrQon6bfE6X4I3ciXkUZy5Pm+
         TX6bhmSuhOtaktkJgxUlRmy4+WE4XSlO1H8ruUp2gjNLJP77hV+i9pR0wTda29mJO3
         GxMVMgMtcAMoXUjMEOnVYYsKSVKWGfYOR8njtrPssV30OtkKOv9VyHdF9PqFiiRTHR
         cPUR/WCOye1+Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        philipp.zabel@gmail.com, andriy.shevchenko@linux.intel.com,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 14/16] ACPI: x86: s2idle: Catch multiple ACPI_TYPE_PACKAGE objects
Date:   Fri,  8 Sep 2023 13:59:51 -0400
Message-Id: <20230908175953.3457942-14-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908175953.3457942-1-sashal@kernel.org>
References: <20230908175953.3457942-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
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
index ce62e61a9605e..9a179bb5823a0 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -113,6 +113,12 @@ static void lpi_device_get_constraints_amd(void)
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

