Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E4D7E9CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjKMNP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjKMNP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:15:26 -0500
Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86755D6C;
        Mon, 13 Nov 2023 05:15:17 -0800 (PST)
Received: from [10.28.138.149] (port=17042 helo=[192.168.95.111])
        by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
        (envelope-from <kiryushin@ancud.ru>)
        id 1r2WmW-0000gj-5s; Mon, 13 Nov 2023 16:15:13 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
        by incarp1102.mail.hosting.nic.ru (Exim 5.55)
        with id 1r2WmW-00A2aA-2O;
        Mon, 13 Nov 2023 16:15:12 +0300
Message-ID: <b8c5f018-4883-4c14-84ab-0514edac2770@ancud.ru>
Date:   Mon, 13 Nov 2023 16:15:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Nikita Kiryushin <kiryushin@ancud.ru>
Subject: [PATCH] ACPICA: debugger: check status of acpi_evaluate_object in
 acpi_db_walk_for_fields
To:     Robert Moore <robert.moore@intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Errors in acpi_evaluate_object can lead to incorrect state of buffer.
This can lead to access to data in previously ACPI_FREEd buffer and
secondary ACPI_FREE to the same buffer later.

Handle errors in acpi_evaluate_object the same way it is done earlier
with acpi_ns_handle_to_pathname.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 5fd033288a86 ("ACPICA: debugger: add command to dump all fields 
of particular subtype")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
  drivers/acpi/acpica/dbnames.c | 8 ++++++--
  1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index b91155ea9c34..c9131259f717 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -550,8 +550,12 @@ acpi_db_walk_for_fields(acpi_handle obj_handle,
  	ACPI_FREE(buffer.pointer);
   	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
-	acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
-
+	status = acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could Not evaluate object %p\n",
+			       obj_handle);
+		return (AE_OK);
+	}
  	/*
  	 * Since this is a field unit, surround the output in braces
  	 */
-- 
2.34.1

