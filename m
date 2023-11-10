Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C087E8324
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346482AbjKJTsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbjKJTrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:47:46 -0500
Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003FB6A48;
        Fri, 10 Nov 2023 11:45:24 -0800 (PST)
Received: from [10.28.138.149] (port=40524 helo=[192.168.95.111])
        by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
        (envelope-from <kiryushin@ancud.ru>)
        id 1r1XRP-0007NN-6C; Fri, 10 Nov 2023 22:45:20 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
        by incarp1102.mail.hosting.nic.ru (Exim 5.55)
        with id 1r1XRP-00H8mB-2j;
        Fri, 10 Nov 2023 22:45:19 +0300
Message-ID: <ea6ef128-fa22-44b3-bd10-c136bc89c036@ancud.ru>
Date:   Fri, 10 Nov 2023 22:45:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Nikita Kiryushin <kiryushin@ancud.ru>
Subject: [PATCH] ACPI: OSL: Initialize output value
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>,
        Bob Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buffer variable for result (value32) is not initialized.
This can lead to unexpected behavior, if underlying platform-specific
raw_pci_read fails to report error (uninitialized value will be treated
as valid pci-read result), or exposition of unexpected data to PCI 
config space reader.

Zeroing of buffer value addresses the later problem and makes the 
behavior in the former case somewhat more predictable.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c5f0231ee6b0 ("ACPICA: Fix acpi_os_read_pci_configuration prototype")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
  drivers/acpi/osl.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index c09cc3c68633..d3c0f7f01a29 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -788,7 +788,7 @@ acpi_os_read_pci_configuration(struct acpi_pci_id 
*pci_id, u32 reg,
  			       u64 *value, u32 width)
  {
  	int result, size;
-	u32 value32;
+	u32 value32 = 0U;
   	if (!value)
  		return AE_BAD_PARAMETER;
-- 
2.34.1

