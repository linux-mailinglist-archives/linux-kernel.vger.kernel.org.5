Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C88F78245A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbjHUHVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjHUHVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:21:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A84121;
        Mon, 21 Aug 2023 00:20:53 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so51517011fa.2;
        Mon, 21 Aug 2023 00:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692602451; x=1693207251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq36Dbq1HY2z5NlqPV7zgKLt6oReU56/omua8/ySzLI=;
        b=cgcU6UqwnSLtbvAZe/OZa5h/lTndnLn8O/4Ozbeb20OgiKvvNVTDOK66QNWTko5H6H
         PND1VdxYMH/aVh3SlzZb9XCjvbT4WSJePbYzgLjfgjv6jp8N592qbI5NAPtH+AhK92F0
         ggVeNvoR4EMf769CU6ziBs1oiwtrMyRlTu9YJWQELlI0ZKckqmDTALNgpDy3/1nIDdsZ
         /bjch+vLfgCV3rfOoaxCHmdDMiltpHXStGGGEIHRUaIk4d0KhX8ilq6pAPE7WJJ+FlaM
         4aq4N/5sdsJNuA+hS3AV3IF12ORfCaJEf9DyE40c1Qs5OkaURHxrppIEVrDT9B49Tv48
         jKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692602451; x=1693207251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nq36Dbq1HY2z5NlqPV7zgKLt6oReU56/omua8/ySzLI=;
        b=Nsxhl1IIReoFwXnqPfHrZO12X5eYhSFQeqYGf7vMG9gmziNSBh0pTg3HGdYI3oQUu0
         29MPYYIIua/jTurlBIWmgjNMHs/ELSsBdQkVTn+DUZlKx3p3vm05LWIQr3BeGRBqD1hq
         jp7w5kuiDHv1NYyuaVh2IyoDtmFeWI8DSqdzoDB5+rr2k46D4hTLEkm3w63+tLHROtLr
         6YBtEIFC0DGdX7w09iVgDl713Yc5gl5euKaXba6anaKZyeG1bQnjB/gQaVWwCi8R9fp+
         JLDu7xoaC8oBYlTHOP/q+dNKBFEHzQh455m90RRYdNAs3jUJurJvQ+x2CcjgUFKJ2zH5
         Lobw==
X-Gm-Message-State: AOJu0Yx4+fWLUSwnemRKetuTV6Kc8wiWlskcmbGtj/x4yKJIYx4t6d3t
        HUD+PmkB+5R0ei2l2lFT09wtboP+pTD3+g==
X-Google-Smtp-Source: AGHT+IE6lprPnniAsTnl0nA7dumKbexfHrUUAM9JOPQzP46HU8eo3vXedEKxbWQlOJKWYViJAMU90g==
X-Received: by 2002:a05:6512:1081:b0:4fb:8f79:631 with SMTP id j1-20020a056512108100b004fb8f790631mr3856240lfg.46.1692602450988;
        Mon, 21 Aug 2023 00:20:50 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c22d500b003fee777fd84sm6769656wmg.41.2023.08.21.00.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 00:20:50 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Guo Ren <guoren@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-openrisc@vger.kernel.org
Subject: [PATCH 5/8] openrisc: Include cpu.h and switch_to.h for prototypes
Date:   Mon, 21 Aug 2023 08:20:04 +0100
Message-Id: <20230821072007.2698186-6-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230821072007.2698186-1-shorne@gmail.com>
References: <20230821072007.2698186-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with W=1 enabling -Wmissing-prototypes the compiler
warns:

  arch/openrisc/kernel/process.c:100:6: error: no previous prototype for 'arch_cpu_idle' [-Werror=missing-prototypes]
  arch/openrisc/kernel/process.c:240:21: error: no previous prototype for '__switch_to' [-Werror=missing-prototypes]

Fix these by adding the approrpiate header files to process.c which
brings in the prototype definitions.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/linux-kernel/20230810141947.1236730-17-arnd@kernel.org/
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index a07512de0169..86e02929f3ac 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -14,6 +14,7 @@
  */
 
 #define __KERNEL_SYSCALLS__
+#include <linux/cpu.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
@@ -38,6 +39,7 @@
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/spr_defs.h>
+#include <asm/switch_to.h>
 
 #include <linux/smp.h>
 
-- 
2.39.1

