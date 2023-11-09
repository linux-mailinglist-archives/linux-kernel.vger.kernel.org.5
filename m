Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B677E6B7D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbjKINth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjKINtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:49:35 -0500
Received: from relay163.nicmail.ru (relay163.nicmail.ru [91.189.117.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E1930CF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 05:49:31 -0800 (PST)
Received: from [10.28.138.148] (port=33836 helo=[192.168.95.111])
        by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
        (envelope-from <kiryushin@ancud.ru>)
        id 1r15PS-0005CE-BH; Thu, 09 Nov 2023 16:49:26 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
        by incarp1101.mail.hosting.nic.ru (Exim 5.55)
        with id 1r15PS-00E7MJ-1K;
        Thu, 09 Nov 2023 16:49:26 +0300
Message-ID: <262a7526-9e0a-4688-85b4-8546a6580ad0@ancud.ru>
Date:   Thu, 9 Nov 2023 16:49:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Nikita Kiryushin <kiryushin@ancud.ru>
Subject: [PATCH] ACPI: video: check for error while searching for backlit
 device parent
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, Matthew Garrett <mjg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If acpi_get_parent called in acpi_video_dev_register_backlight fails
(for example, acpi_ut_acquire_mutex fails inside acpi_get_parent),
this can lead to incorrect (uninitialized) acpi_parent handler being
passed to acpi_get_pci_dev for detecting parent pci device.

Check acpi_get_parent result and set parent device only in case of success.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9661e92c10a9 ("acpi: tie ACPI backlight devices to PCI devices if 
possible")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
  drivers/acpi/acpi_video.c | 12 ++++++------
  1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 0b7a01f38b65..1d550887349a 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1717,12 +1717,12 @@ static void 
acpi_video_dev_register_backlight(struct acpi_video_device *device)
  		return;
  	count++;
  -	acpi_get_parent(device->dev->handle, &acpi_parent);
-
-	pdev = acpi_get_pci_dev(acpi_parent);
-	if (pdev) {
-		parent = &pdev->dev;
-		pci_dev_put(pdev);
+	if (ACPI_SUCCESS(acpi_get_parent(device->dev->handle, &acpi_parent))) {
+		pdev = acpi_get_pci_dev(acpi_parent);
+		if (pdev) {
+			parent = &pdev->dev;
+			pci_dev_put(pdev);
+		}
  	}
   	memset(&props, 0, sizeof(struct backlight_properties));
-- 
2.34.1

