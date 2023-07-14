Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5D47540A4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbjGNRlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbjGNRlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:41:13 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89584420E;
        Fri, 14 Jul 2023 10:40:49 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-785ccf19489so87695239f.3;
        Fri, 14 Jul 2023 10:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356448; x=1691948448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFT9PNMmBztDXyn5rk0S0F3jD8xFge6alwT8Dw67VL8=;
        b=WobTP2wlki2RRB2C/X2wBS5UvzvKOFbCqWDXytEQOwr2BPobWt19lHNG31W3EktBki
         gl7at0UVDMJMia+vK1ANssvp0dNU/5kmCfEuwyNoJB+h18bNIKqbp+1Y2zUhnxwvGm5G
         OQGSjfaDTAwXY1v3c85V++KfQAya1wc4zmVN7cgryl6FHXeE6+78yEaQk9M+lEmSej/N
         vgVvF9/spTwDr27JB1+26MEFOkRGayJ45ToUtZg6tUhSPn1iBhrad12zQiU7ieWs2AzK
         cSWnSfRbUNEqwODhaRy7KvW+s4q7+aIvbSErw0PkNMQcAyZ+5FOjwZbfgv56xKeQY9cZ
         eQfg==
X-Gm-Message-State: ABy/qLabzZOdQVh6iPvBbzIq/0Vm4cxXZe2ToIqrDWULqn52BSq1MuYD
        uWKkOoswBdgR3yJ7i7Qt89GBz/yp7Q==
X-Google-Smtp-Source: APBJJlGrW4Xkq9w+FZdPIVXMOKSnncY2lY6BFJdgiocWd1cYlyqL8tnMFmiSkP40ud3r7hlTdCtMag==
X-Received: by 2002:a92:de0e:0:b0:347:70a8:1749 with SMTP id x14-20020a92de0e000000b0034770a81749mr4817126ilm.24.1689356448356;
        Fri, 14 Jul 2023 10:40:48 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w17-20020a92c891000000b0034233fd80d3sm2889354ilo.22.2023.07.14.10.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:40:47 -0700 (PDT)
Received: (nullmailer pid 4040658 invoked by uid 1000);
        Fri, 14 Jul 2023 17:40:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:40:43 -0600
Message-Id: <20230714174043.4040561-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/riscv/kernel/cpufeature.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index bdcf460ea53d..d75941be9826 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -13,7 +13,6 @@
 #include <linux/memory.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <asm/acpi.h>
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
-- 
2.40.1

