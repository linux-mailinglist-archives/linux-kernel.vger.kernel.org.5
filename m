Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666647E713A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344773AbjKISJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjKISJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:09:12 -0500
Received: from relay164.nicmail.ru (relay164.nicmail.ru [91.189.117.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DC0CE;
        Thu,  9 Nov 2023 10:09:07 -0800 (PST)
Received: from [10.28.138.151] (port=11776 helo=[192.168.95.111])
        by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
        (envelope-from <kiryushin@ancud.ru>)
        id 1r19Sf-00020H-DZ; Thu, 09 Nov 2023 21:09:01 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
        by incarp1103.mail.hosting.nic.ru (Exim 5.55)
        with id 1r19Sf-001rie-0S;
        Thu, 09 Nov 2023 21:09:01 +0300
Message-ID: <430a1271-a45c-4f5a-90c7-a62703ac7cf4@ancud.ru>
Date:   Thu, 9 Nov 2023 21:08:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Nikita Kiryushin <kiryushin@ancud.ru>
Subject: [PATCH] ACPI: LPIT: fix u32 multiplication overflow
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In lpit_update_residency there is a possibility of overflow
in multiplication, if tsc_khz is large enough (> UINT_MAX/1000).

Change multiplication to mul_u32_u32.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: eeb2d80d502a ("ACPI / LPIT: Add Low Power Idle Table (LPIT) support")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
  drivers/acpi/acpi_lpit.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
index c5598b6d5db8..794962c5c88e 100644
--- a/drivers/acpi/acpi_lpit.c
+++ b/drivers/acpi/acpi_lpit.c
@@ -105,7 +105,7 @@ static void lpit_update_residency(struct 
lpit_residency_info *info,
  		return;
   	info->frequency = lpit_native->counter_frequency ?
-				lpit_native->counter_frequency : tsc_khz * 1000;
+				lpit_native->counter_frequency : mul_u32_u32(tsc_khz, 1000U);
  	if (!info->frequency)
  		info->frequency = 1;
  -- 2.34.1

