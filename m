Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6925A7EA6B5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 00:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjKMXJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 18:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjKMXI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 18:08:58 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E287D48
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:08:55 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507a0907896so6972263e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699916934; x=1700521734; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ACmx3TNz3KrSPf31LlnpB3IxofbprNijom9dYNvkSxs=;
        b=QFerk8wXy69JkWtiT+9/uJFQWJp29vYvZW8IcP4rKjX0BZp1NgmEYbTQrQJ5Ms50nE
         pM1Pae2eNbYnxO3frMsRctKmb+up6NkUnXaGWWUHY6kxeQqPdHE+vXU7DG/UbatRpB5K
         rlGomcLOaQhz0T6EsEtqSUzoYlhy0Fuml+S2zY9PIRpsCT/HECn011fRg4fUan+f7Fze
         zv6dRIdW4E1qcdulOBGEoD6obA5D4u+3qGWwlC45FkeCqYdrDT4tcrth5+2VbVDcZfnX
         W3zbUBOw8yYW58ujyZWBTX7xyvPBmSxRiTS+Rxg1mKzO5F8fRGR0uf0EUa/hikuQ4+uF
         rZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699916934; x=1700521734;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACmx3TNz3KrSPf31LlnpB3IxofbprNijom9dYNvkSxs=;
        b=OvQN9UrRJiSlk2kwt6ZZagtFAsnz1qL8K3byHVfCuL7WhOZXRjI4OE8VUTxPq3wjum
         f5cTEQJik3RGySVZDC+iI25/TT0JMywMEmTc8Z8DP1Bs+KihSsQYdNay35ZUtyeSFPb6
         1K+U6cEUIhqubNQ/3dGjldw1ALshiFIQL7VhhLLcOcQmh3BXypO2I74Tpy8St3n5B/j3
         LMdN8dpN82LizEJirKAYZeRTFG1hA6+Y3Ae3RvfGe28M6u9MpKZUudG3dPglOzlUsqJB
         2YO6Kym8y9IahJBdfMoCh0YzTqKsBPYqqXrLi7OWPwWxAxWLnP62pOPXFWmfusPYECfe
         joeA==
X-Gm-Message-State: AOJu0YxyExRiV7i7C7PpQTp+SDLXC389euHxMkpXGJEQQPzgobXugxH0
        sN64qD2ViEqfOGC2jk7YUHBAKg==
X-Google-Smtp-Source: AGHT+IHTUId+0HJ4T45+iwtwHrEWqjSbHl2ub84wm4qF/7cvEBUNB/FCXGvBhq2OudQkog7DHYvxzQ==
X-Received: by 2002:ac2:43a6:0:b0:509:38de:9917 with SMTP id t6-20020ac243a6000000b0050938de9917mr5282007lfl.21.1699916933673;
        Mon, 13 Nov 2023 15:08:53 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id m9-20020ac24ac9000000b0050307bf2bcdsm1114292lfp.247.2023.11.13.15.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 15:08:53 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 00:08:47 +0100
Subject: [PATCH] ACPI: acenv: Permit compilation from within the kernel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org>
X-B4-Tracking: v=1; b=H4sIAH6sUmUC/x2MQQqAIBAAvxJ7Tmi1DvaV6GC52kJZKEUg/j3pM
 jCHmQyJIlOCsckQ6eHEZ6iCbQPrZoInwbY6yE4qRFTCxEMsN++20gtDQ6+clYhaQ22uSI7f/zf
 NpXyuNDVMXwAAAA==
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit a103f46633fd the kernel stopped compiling for
several ARM32 platforms that I am building with a bare metal
compiler. Bare metal compilers (arm-none-eabi-) don't
define __linux__.

This is because the header <acpi/platform/acenv.h> is now
in the include path for <linux/irq.h>:

  CC      arch/arm/kernel/irq.o
  CC      kernel/sysctl.o
  CC      crypto/api.o
In file included from ../include/acpi/acpi.h:22,
                 from ../include/linux/fw_table.h:29,
                 from ../include/linux/acpi.h:18,
                 from ../include/linux/irqchip.h:14,
                 from ../arch/arm/kernel/irq.c:25:
../include/acpi/platform/acenv.h:218:2: error: #error Unknown target environment
  218 | #error Unknown target environment
      |  ^~~~~

One solution to make compilation with a bare metal compiler
work again is to say the file is used with Linux from within
the kernel if __KERNEL__ is defined so I did that.

Fixes: a103f46633fd ("acpi: Move common tables helper functions to common lib")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/acpi/platform/acenv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 337ffa931ee8..76444ffdc549 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -156,7 +156,7 @@
 
 #endif
 
-#if defined(_LINUX) || defined(__linux__)
+#if defined(_LINUX) || defined(__linux__) || defined(__KERNEL__)
 #include <acpi/platform/aclinux.h>
 
 #elif defined(_APPLE) || defined(__APPLE__)

---
base-commit: 9bacdd8996c77c42ca004440be610692275ff9d0
change-id: 20231113-arm-build-bug-ae543fd21199

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

