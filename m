Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024F57541FD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbjGNR7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbjGNR6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:58:14 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A61B3AB3;
        Fri, 14 Jul 2023 10:57:50 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34574eb05f4so9442925ab.0;
        Fri, 14 Jul 2023 10:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357106; x=1691949106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9vz/mWa/+cByZPURTvStFUERA+7Xy0Vz92TG7IhWkM=;
        b=R1HAESUhNQiRX3Qti8IjtTXB5y4/dNDA1XZEnnIpeccQ2v3fEkrPw4PBVerRG8a9+K
         +ABlnaCk/v1WrpCUsR5bbua85MaBiE7WgQWNciQ+zdnhj2z7Wkmjj5uDhvBfLL6ILv6h
         qtnSpf4hwuZGvk0BNSslyP7q6OiUriCXq0OTL/+M4qt9X+wDIakKSR9VT1hyYTMDTTGg
         qtlWLb6J1A4Nhj9+3YYs98EJmwg79xD17j1hAaIod6yyJ4lRdTfDXYYp56HhGR5mDhde
         Om6QgWsMrph0bvrwxsaKTeAk66ITIheyE2u800CB0vTtzIBJf0YKZrrA3GR5ao64hjlN
         kutw==
X-Gm-Message-State: ABy/qLbzkhH8sG/LrZ5IHLte6C+W0Xbc8fc8Imhe5j2HJiNaSKK0x2ye
        vWZKQ/gdagPJnXXyBM/RwO3u23zMLVve
X-Google-Smtp-Source: APBJJlE37xc/kV0NKvwHyDG1Ui55uzAVAT7oE656KH7D7w+v9kW/47HiuN63NExOKww0ErwWKxmD9A==
X-Received: by 2002:a92:d08f:0:b0:345:f07b:b670 with SMTP id h15-20020a92d08f000000b00345f07bb670mr5110230ilh.16.1689357106212;
        Fri, 14 Jul 2023 10:51:46 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u16-20020a92da90000000b00342093347d8sm2853065iln.76.2023.07.14.10.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:51:45 -0700 (PDT)
Received: (nullmailer pid 4066556 invoked by uid 1000);
        Fri, 14 Jul 2023 17:51:08 -0000
From:   Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/genalloc: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:50:56 -0600
Message-Id: <20230714175056.4066297-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,MISSING_HEADERS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
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
 lib/genalloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/genalloc.c b/lib/genalloc.c
index 0c883d6fbd44..5cb300530556 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -32,7 +32,9 @@
 #include <linux/rculist.h>
 #include <linux/interrupt.h>
 #include <linux/genalloc.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/vmalloc.h>
 
 static inline size_t chunk_size(const struct gen_pool_chunk *chunk)
-- 
2.40.1

