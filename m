Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF40754113
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbjGNRsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbjGNRrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:47:45 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B603A96;
        Fri, 14 Jul 2023 10:47:24 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-345f1e0abf9so9291905ab.3;
        Fri, 14 Jul 2023 10:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356803; x=1691948803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFbBoaA1fWC8AyIt0h8Dq7hGWKkGohWfmADxlBaqeLk=;
        b=VrXQUHPedJD0I1T6BJ4Tb5ieNnWCi2AQoUmoK2U/yTaHwGvLTAE8cm+W9tfNcQ4efw
         dVLubUQbANU+V94vK90+vrFadjmJhd2J1hsw/2AaUm7xrDBN3EhLbPeUdyAvUSqllquQ
         JBDxCEqssTP3uGWt1GpGgaq4/zmOR/NQ67S85KdPAfyaGOHT18Bcs9L61cqGenAVoQNZ
         maSj3L+IpooBQhjbNvCYlzbtF1QiLek6ShD9bJT7wdQKz9b6Ha6ZRoGz0pvzzhBdVPhd
         7IHOFqztJjhM/+BxX86kbS3RioVYFZNpboBwPXBs21k1aGV/XbNZAmsBfLcndPNIDeoZ
         ElEw==
X-Gm-Message-State: ABy/qLbVnNQ+hv4oRJTXf2nIUL0KsWeerdBSVvjcNEEAtfW0CWBKJi52
        OC8VLtScFLVUwcBmeUTvEA==
X-Google-Smtp-Source: APBJJlEeiilEW5h0B13gLjUnKrGnndNPG2UJn7IQVCJcGFSBD8VSbN8xbH+4UrnAGOld1DOdGVlw6Q==
X-Received: by 2002:a05:6e02:1025:b0:345:66f5:3404 with SMTP id o5-20020a056e02102500b0034566f53404mr5407820ilj.0.1689356803343;
        Fri, 14 Jul 2023 10:46:43 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m8-20020a92cac8000000b003423af2fda6sm2840440ilq.83.2023.07.14.10.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:46:42 -0700 (PDT)
Received: (nullmailer pid 4057877 invoked by uid 1000);
        Fri, 14 Jul 2023 17:46:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jeremy Kerr <jk@codeconstruct.com.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Przemys=C5=82aw=20Gaj?= <pgaj@cadence.com>
Cc:     devicetree@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] i3c: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:46:23 -0600
Message-Id: <20230714174623.4057784-1-robh@kernel.org>
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
 drivers/i3c/master/ast2600-i3c-master.c | 1 -
 drivers/i3c/master/i3c-master-cdns.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/i3c/master/ast2600-i3c-master.c b/drivers/i3c/master/ast2600-i3c-master.c
index 09ed19d489e9..01a47d3dd499 100644
--- a/drivers/i3c/master/ast2600-i3c-master.c
+++ b/drivers/i3c/master/ast2600-i3c-master.c
@@ -8,7 +8,6 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index 01610fa5b0cc..49551db71bc9 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -22,7 +22,6 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
-#include <linux/of_device.h>
 
 #define DEV_ID				0x0
 #define DEV_ID_I3C_MASTER		0x5034
-- 
2.40.1

