Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EF280A118
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573539AbjLHKeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbjLHKdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:33:47 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FE62D49
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:33:39 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50be24167efso2193150e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702031618; x=1702636418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h4cT1vPyF4MV6Slk3a0U6oOkB8CmE1BrFIZp/eFFbf4=;
        b=QHnmlIRjhtK+UkcUFdtli+wgOIrK27ehHSn9m2hldHYTEjb4JHzhILK7mkhHv5OT9+
         ueQXwKLwr1YOC8q9UBS3LImd91u+xlbfyBsuXANw76fv+hemMxly3zilqAYZvxpZlyXf
         7KPplqR+pMmTUFj8XQM7eTNcQRuKDEcTXC58TMw+ahvk3vGi13aWW41KmfrNj+yszxL1
         gy5TMGKRIq7tV6QpJHqLaRYlcEB5xhK5QRQ7q/rNNZm1k3YX69k1SYgrfKWQPhMHS9Wq
         MWnNufZAsrX5YkR2JWHXCq1oZxmjlDa1VbLtvx4Iq9Yd25vSTzPQuNVj6xEZ0IIWkQrU
         WNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702031618; x=1702636418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4cT1vPyF4MV6Slk3a0U6oOkB8CmE1BrFIZp/eFFbf4=;
        b=uounVRTZQ+UN88NXcoBwO4FOv03KZVsLg0pX0ozR3kSDXpLrAjhnEqlCxk6VdPGEr7
         3ACVy1Z73LFi/+3oA5ADRNwJuarj11+P0bSF2ge13KC+gUrujYt2nGPWDz+nkoZCu9Df
         PVTfimsf1MZwBz7S2oP+Gn1l+gYZHlUpkXu4660qwPKqe/rPIFZLBc4RmtsOnOelDFwe
         WK70mhcuMa/CaBEETk4u+0VJRca18WsVFMaQK5jQsEKN7NEefMHckm/phG2af38s9NFt
         c15ogDkVUu3g2yAvMxJSQ+1BPZJAflYpA2HZPVf1IRVfAdZZ7SeYocezGKKS/YQM4AAg
         z5vg==
X-Gm-Message-State: AOJu0YybJ1GSfXttDH5ZyUC5rn92ZzRhEOPbmgQGwf/ZK2DldfRgywXP
        +XLDht++sP4VYnhuNyObXC37sA==
X-Google-Smtp-Source: AGHT+IE1x+vEB0enFOFbtTJdwklZj+bcAzaYQcqHhZJJEoKhfkAXGO7EL1aO6WM7utpSS1pYmNwbYA==
X-Received: by 2002:ac2:4a84:0:b0:50b:f51a:299d with SMTP id l4-20020ac24a84000000b0050bf51a299dmr1077926lfp.18.1702031617898;
        Fri, 08 Dec 2023 02:33:37 -0800 (PST)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id y1-20020ac24e61000000b0050bff86c497sm176842lfs.23.2023.12.08.02.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:33:37 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] drivers: acpi: arm64: thermal_cpufreq: export module
Date:   Fri,  8 Dec 2023 11:33:32 +0100
Message-ID: <20231208103332.2829631-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following build error shows up when building an allmodconfig kernel
on arch=arm64:

ERROR: modpost: "acpi_arch_thermal_cpufreq_pctg" [drivers/acpi/processor.ko] undefined!
make[3]: *** [/next/scripts/Makefile.modpost:145: Module.symvers] Error 1
make[3]: Target '__modpost' not remade because of errors.
make[2]: *** [/tmp/next/Makefile:1876: modpost] Error 2
make[2]: Target '__all' not remade because of errors.
make[1]: *** [/tmp/next/Makefile:243: __sub-make] Error 2
make[1]: Target '__all' not remade because of errors.
make: *** [Makefile:243: __sub-make] Error 2
make: Target '__all' not remade because of errors.

Solve the issue by export acpi_arch_thermal_cpufreq_pctg() since the
function are used in function 'acpi_thermal_cpufreq_config()'.

Fixes: a02f66bb3cf4 ("ACPI: Move ACPI_HOTPLUG_CPU to be disabled on arm64 and riscv")
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/acpi/arm64/thermal_cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/arm64/thermal_cpufreq.c b/drivers/acpi/arm64/thermal_cpufreq.c
index d524f2cd6044..582854914c5c 100644
--- a/drivers/acpi/arm64/thermal_cpufreq.c
+++ b/drivers/acpi/arm64/thermal_cpufreq.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/acpi.h>
+#include <linux/export.h>
 
 #include "../internal.h"
 
@@ -18,3 +19,4 @@ int acpi_arch_thermal_cpufreq_pctg(void)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(acpi_arch_thermal_cpufreq_pctg);
-- 
2.42.0

