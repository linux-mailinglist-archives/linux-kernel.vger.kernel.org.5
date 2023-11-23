Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4660D7F58C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjKWHAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKWHAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:00:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AE2B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:00:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F59C433C8;
        Thu, 23 Nov 2023 07:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700722816;
        bh=gtU+Ip4vBdqkXNcVYMAHTdA7Yf0OaFIdHF1c43xiML0=;
        h=From:To:Cc:Subject:Date:From;
        b=O8dtWN9vYKsRY/QVCQnJOZQMygs9qZR3wKEwAqgHsbtp3o9Uz8TuFWQhWw85jtvUI
         XXAGrFMsnzJ2LKoaVjLqUGMYPMMJ/jNPe5VrslWFx9QWIUoKSVlyURITZdFufAyv45
         mGY/lb0py1rl6lxM52ZFUn46m6W3AbHjnrhG0Dr84YSj8Prx+c4z9zbTgAIkwFYR9U
         O69VHy8DBgf6FPoL4o40OT8DuBtUFqJ+4m2zBa4n9ZhEW1h9ZBb5xDmCVqh/KINU9J
         HWsGLxOsUuBs6vCzxdLvGl8YkcF4RY4l9GkjVpBZktIRdFMDhvxH348Fxs5uPFQPiU
         IIShg0B1Izf6A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: thermal_lib: include "internal.h" for function prototypes
Date:   Thu, 23 Nov 2023 07:59:57 +0100
Message-Id: <20231123070010.4013969-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added functions are declared in a header that is not included
before the definition:

drivers/acpi/thermal_lib.c:46:5: error: no previous prototype for 'acpi_active_trip_temp' [-Werror=missing-prototypes]
   46 | int acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp)
      |     ^~~~~~~~~~~~~~~~~~~~~
drivers/acpi/thermal_lib.c:57:5: error: no previous prototype for 'acpi_passive_trip_temp' [-Werror=missing-prototypes]
   57 | int acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp)
      |     ^~~~~~~~~~~~~~~~~~~~~~
drivers/acpi/thermal_lib.c:63:5: error: no previous prototype for 'acpi_hot_trip_temp' [-Werror=missing-prototypes]
   63 | int acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
      |     ^~~~~~~~~~~~~~~~~~
drivers/acpi/thermal_lib.c:69:5: error: no previous prototype for 'acpi_critical_trip_temp' [-Werror=missing-prototypes]
   69 | int acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp)
      |     ^~~~~~~~~~~~~~~~~~~~~~~

Fixes: 6908097aa5a7 ("ACPI: thermal_lib: Add functions returning temperature in deci-Kelvin")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/thermal_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/thermal_lib.c b/drivers/acpi/thermal_lib.c
index 646ff6bda6dd..4e0519ca9739 100644
--- a/drivers/acpi/thermal_lib.c
+++ b/drivers/acpi/thermal_lib.c
@@ -9,6 +9,7 @@
 #include <linux/acpi.h>
 #include <linux/units.h>
 #include <linux/thermal.h>
+#include "internal.h"
 
 /*
  * Minimum temperature for full military grade is 218°K (-55°C) and
-- 
2.39.2

