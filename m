Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF857756A0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjHIJo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHIJo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:44:57 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61373ED;
        Wed,  9 Aug 2023 02:44:56 -0700 (PDT)
Received: from canonical.com (unknown [10.101.194.165])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 396803F1C2;
        Wed,  9 Aug 2023 09:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691574294;
        bh=hOaugecDmx8s0gF6A+lggXyk/CKpYFWeAHRtbZ38wmQ=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=krEUXcKKWwLdM/4fRl825m892/v34MgmuwWro79QtqU8vpVBCmCF0NywZfAFHmF9N
         QkWBtzJjoQgbsnsA62vPlYe3buqGZVVjWJOowOzDHUu6Ca4oiaM3PKfELpUlTgco4p
         ax6sFCJNerT2298+r2rpbA05jEDvE8wTvyn0JYZFVJM1uHldg4vDG9JVk3NKyHoQOG
         QWQXYz9ahOiQatA0zoR8+IROgC3b8lGiyPCHVpbFfc3jBqJVC8px+KFSPOdnmN0xLG
         y+RqJYd341kMgcxEADfL/U922Ol4O0a5z0u4WrXSzJZpRnAHBHRV3KaZbpYvcktYj9
         X1/CGGxf2us4Q==
From:   Ivan Hu <ivan.hu@canonical.com>
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: thermal: extend the acpi maximum handles for _PSL method
Date:   Wed,  9 Aug 2023 17:44:51 +0800
Message-Id: <20230809094451.15473-1-ivan.hu@canonical.com>
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

Several platforms encountered the following kernel message:
ACPI: \_TZ_.BATZ: Invalid passive threshold

This issue arises due to the failure of the acpi_evaluate_reference function
in drivers/acpi/thermal.c while evaluating the ACPI _PSL method.

status = acpi_evaluate_reference(tz->device->handle, "_PSL",
			 NULL, &devices);
if (ACPI_FAILURE(status)) {
	acpi_handle_info(tz->device->handle,
			 "Invalid passive threshold\n");
	tz->trips.passive.valid = false;
} else {
	tz->trips.passive.valid = true;
}

However, the root cause lies in the _PSL method returning packages with a count
exceeding ACPI_MAX_HANDLES in acpi_evaluate_reference.

As per the ACPI specification, the _PSL (Passive List) method is defined under
a thermal zone and evaluates to a list of processor objects to be used for
passive cooling. And it will return a variable-length Package containing a list
of References to processor objects.

Signed-off-by: Ivan Hu <ivan.hu@canonical.com>
---
 include/acpi/acpi_bus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 23fbe4a16972..dc7b38826113 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -13,7 +13,7 @@
 #include <linux/property.h>
 
 /* TBD: Make dynamic */
-#define ACPI_MAX_HANDLES	10
+#define ACPI_MAX_HANDLES	32
 struct acpi_handle_list {
 	u32 count;
 	acpi_handle handles[ACPI_MAX_HANDLES];
-- 
2.34.1

