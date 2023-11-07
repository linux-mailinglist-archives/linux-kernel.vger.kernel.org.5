Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59427E3BE1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjKGMKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjKGMKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:10:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515C819B3;
        Tue,  7 Nov 2023 04:08:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0230EC433C9;
        Tue,  7 Nov 2023 12:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699358907;
        bh=yPLGWN1o9Bc6chGb2jLGWZc6z/T/QbfwF9PwpzrOdwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DxUBU804WrZFNHe6a4AJHcnRYlEUdCjHHCf4mcjB2sNf3+t/ysCVLBhpHdHIcfTZI
         wYD4WT7Shl8u0qo+K8VoWNpu8P6RWrTpiwM9nR/rBMATB8r2CUsjMFbpkt+CTOZ2E+
         TGjTQpe4MqX4QrXJRF+Ij5o73w2LHcWgmiSVD5HVsarZsF9qBN1Rqh4fYA3Tbv4GNo
         wo4yHPC3o6JE+gPTv+TbX2CvogY9da7wAALVtlkTunSnB4yDCQflCr+NAV13snSt0B
         Dg+OPF97vUprqyHKEmqzfRvGLFIIVHhG1jkUY2FfMj3lQ9AuuQcTOB+TJVCvr/0Iu0
         EWY9ZQA+a2r0Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jonathan Denose <jdenose@chromium.org>,
        Jonathan Denose <jdenose@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 26/31] ACPI: EC: Add quirk for HP 250 G7 Notebook PC
Date:   Tue,  7 Nov 2023 07:06:13 -0500
Message-ID: <20231107120704.3756327-26-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120704.3756327-1-sashal@kernel.org>
References: <20231107120704.3756327-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Denose <jdenose@chromium.org>

[ Upstream commit 891ddc03e2f4395e24795596e032f57d5ab37fe7 ]

Add GPE quirk entry for HP 250 G7 Notebook PC.

This change allows the lid switch to be identified as the lid switch
and not a keyboard button. With the lid switch properly identified, the
device triggers suspend correctly on lid close.

Signed-off-by: Jonathan Denose <jdenose@google.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index c95d0edb0be9e..a59c11df73754 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1924,6 +1924,16 @@ static const struct dmi_system_id ec_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Gaming Laptop 15-dk1xxx"),
 		},
 	},
+	{
+		/*
+		 * HP 250 G7 Notebook PC
+		 */
+		.callback = ec_honor_dsdt_gpe,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP 250 G7 Notebook PC"),
+		},
+	},
 	{
 		/*
 		 * Samsung hardware
-- 
2.42.0

