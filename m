Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9C177CB1E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbjHOKZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbjHOKYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:24:53 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A95110E0;
        Tue, 15 Aug 2023 03:24:51 -0700 (PDT)
Received: from canonical.com (unknown [106.104.136.95])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C840C3F2A1;
        Tue, 15 Aug 2023 10:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1692095090;
        bh=xPBXiljRZrwLOlYKR27Sx0wADMyrpi1nE6ik4jFY4PQ=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=FxUCdyxdBev4F8UbKz8zNlwPqkk203pjFgQgeE4T2gFDPs3U1bnSf48ZLkYr/3NIX
         XBzrD+8D5gfvLQbm+pGQDSBeFvf5YWUvGE9tg3BVtjurKa4PLiAhBLzsr/DwZoGC33
         hzS3tfYe4FfqA+PbEXd7kz+zTrB9TCLiv+H7ne4ODPkUA4uAR5jnk1G8Dti3aFMp7h
         5XpXBXoKzHVhinUFdhbb0uiWon0Iw+B7BSVH0mD/AacKPyrIhkxBCsJeaTlp3Y1RVA
         SsV6DzJ0pLXeghJpxfhsodsYoR/eGNWsWYRWkZqfqjfaH736aUMlyp4rH5XMmCzQmE
         R8jK5U1zuaFZw==
From:   Ivan Hu <ivan.hu@canonical.com>
To:     s.shravan@intel.com, linuxwwan@intel.com, hdegoede@redhat.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: intel: int1092: intel_sar: fix _DSM argument4 type mismatch issue
Date:   Tue, 15 Aug 2023 18:24:45 +0800
Message-Id: <20230815102445.7101-1-ivan.hu@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Encountered a type mismatch as described below:
\_SB.WCCD._DSM: Argument #4 type mismatch - Found [Integer], ACPI requires
[Package]
This is because the argument#4(arg3) is integer.
According to the ACPI specification, the arg3 should be a package.
_DSM (Device Specific Method)
This optional object is a control method that enables devices to provide device
specific control functions that are consumed by the device driver.
Arguments: (4)
Arg0 - A Buffer containing a UUID
Arg1 - An Integer containing the Revision ID
Arg2 - An Integer containing the Function Index
Arg3 - A Package that contains function-specific arguments

The solution involves rectifying arg3 to be a package for the _DSM method.
Furthermore, the firmware needs to ensure that ACPI table arg3 is a package as
well. The suggested amendment is as follows:
If ((Arg3 == Zero))
{
    WDMC [0x02] = WCS0
}
should modify as,
If (((ToInteger(Derefof (Arg3 [Zero]))) == Zero))
{
    WDMC [0x02] = WCS0
}

Signed-off-by: Ivan Hu <ivan.hu@canonical.com>
---
 drivers/platform/x86/intel/int1092/intel_sar.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/int1092/intel_sar.c b/drivers/platform/x86/intel/int1092/intel_sar.c
index 6246c066ade2..8fffdce994aa 100644
--- a/drivers/platform/x86/intel/int1092/intel_sar.c
+++ b/drivers/platform/x86/intel/int1092/intel_sar.c
@@ -215,13 +215,17 @@ static void sar_notify(acpi_handle handle, u32 event, void *data)
 
 static void sar_get_data(int reg, struct wwan_sar_context *context)
 {
-	union acpi_object *out, req;
+	union acpi_object *out, req, argv4;
 	u32 rev = 0;
 
-	req.type = ACPI_TYPE_INTEGER;
+	argv4.type = ACPI_TYPE_PACKAGE;
+	argv4.package.count = 1;
+	argv4.package.elements = &req;
+	req.integer.type = ACPI_TYPE_INTEGER;
 	req.integer.value = reg;
+
 	out = acpi_evaluate_dsm_typed(context->handle, &context->guid, rev,
-				      COMMAND_ID_CONFIG_TABLE, &req, ACPI_TYPE_PACKAGE);
+				      COMMAND_ID_CONFIG_TABLE, &argv4, ACPI_TYPE_PACKAGE);
 	if (!out)
 		return;
 	if (out->package.count >= 3 &&
-- 
2.34.1

