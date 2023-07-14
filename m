Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D12754094
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbjGNRkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbjGNRkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:40:17 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9D4359F;
        Fri, 14 Jul 2023 10:40:16 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-78363cc070aso83370139f.1;
        Fri, 14 Jul 2023 10:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356415; x=1691948415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wG/8q5xFWyXnYo87cfTZCB7vaY55UNr931bp9kogVs=;
        b=QHdbtvdeenL+OV5DA5WYLaQOrO14rJ35vwMrhBxpYuohDw17Z15X4G27QUOz+RN2Bx
         7xR9z7lO48gjmp2UelmKOrw1qCm0iUMrPreacV6PIrh6AWL7nhrZLjijyBb+0h92VbSo
         H7W3KGCEYbYBn7nMAJyi6FsA3SI7+UXNlupRG0ToMZ3CZtRNlsOw2VR2OH9VURI4DVvS
         S2H7fKolRO9x3sbZ60ouA3N473IBQYXQEQi4KH8fdBdhkqe/t31KN0KdRRmzGfK8CiNG
         yzE1aEA0bPSZV/hJRhsYphw/ziLxpSCnGOXiaivdMXdDXlOMq3gwoGMY5Cz4OdkOkfJI
         6MAw==
X-Gm-Message-State: ABy/qLYeqmnTSWnbaTSW4Iq9Lz01OkXoyxdEQaNInZi9PZ4ioiGZLFOy
        xVBSvXv1i7kP2jBc9Y+xcg==
X-Google-Smtp-Source: APBJJlH1ABKviOQ3klyYs/5okEJaPdSwOXPl2VLR63HMBrNOvjmqi4zLogp8x+sOD3uU5HMEnSlIHQ==
X-Received: by 2002:a05:6e02:148:b0:33b:c0d8:26af with SMTP id j8-20020a056e02014800b0033bc0d826afmr4984504ilr.7.1689356415616;
        Fri, 14 Jul 2023 10:40:15 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s7-20020a92d907000000b00345950d7e94sm2888274iln.20.2023.07.14.10.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:40:14 -0700 (PDT)
Received: (nullmailer pid 4039516 invoked by uid 1000);
        Fri, 14 Jul 2023 17:40:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arc: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:39:49 -0600
Message-Id: <20230714173949.4038981-1-robh@kernel.org>
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
 arch/arc/plat-axs10x/axs10x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arc/plat-axs10x/axs10x.c b/arch/arc/plat-axs10x/axs10x.c
index b821df7b0089..1feb990a56bc 100644
--- a/arch/arc/plat-axs10x/axs10x.c
+++ b/arch/arc/plat-axs10x/axs10x.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/of_fdt.h>
-#include <linux/of_platform.h>
 #include <linux/libfdt.h>
 
 #include <asm/asm-offsets.h>
-- 
2.40.1

