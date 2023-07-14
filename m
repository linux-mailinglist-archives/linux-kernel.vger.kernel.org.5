Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A23A754115
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbjGNRru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbjGNRrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:47:42 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D08B270D;
        Fri, 14 Jul 2023 10:47:19 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-786bb09e595so75836739f.1;
        Fri, 14 Jul 2023 10:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356790; x=1691948790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZyx3eOZS66p/l1ekqweJ4x6pDgHSOvyvTBTGNC2XKI=;
        b=Qcb6uU1lNN9bgTq7uy9jZoAEBcREHAPUW2XFnbS/bPlS8mNigglLntyMuOVOTloOqZ
         fNSsWSQdwOQxC3ofst1/kmyItXvWc6kZmGyOGqWZTrI/IxXLD0WCZFJ8VEaqZ+2MJHHI
         5YpV64FKpXVHhFVfpY9BzvGrKl9rRLWymOD43T/rifux9DZKPqxWE5jkpxiNfw4GK8T2
         8Ps8o55HWCCBlF7AtnmfypF2WRSltp46HCkqm5bjzI7zkLGZtGG/yW8+zx2yq1lEdBNo
         twkKL8DRVwtOMoyyDInSJaZvTvzK3TBSmkdudYg6lsTYBPTlz6wV2JQkp3W5WTEGs4YW
         YV5g==
X-Gm-Message-State: ABy/qLYgQXO4o0Bd1cOEY/LepzPrIALqxrkzpmDBUZnLBefmqP5TNUsk
        34EKnu/orMNYbXGRSOnhIA==
X-Google-Smtp-Source: APBJJlE/vLL7hw1540hDUWgDuts5nMG5S1cadQvvGh0CS4HmHqYiA/2FCcR6l29BG1f/xzvUp0DNgQ==
X-Received: by 2002:a05:6e02:1148:b0:343:ef5e:8286 with SMTP id o8-20020a056e02114800b00343ef5e8286mr2226321ill.7.1689356789836;
        Fri, 14 Jul 2023 10:46:29 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k24-20020a02ccd8000000b0042b46224650sm2669864jaq.91.2023.07.14.10.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:46:29 -0700 (PDT)
Received: (nullmailer pid 4057534 invoked by uid 1000);
        Fri, 14 Jul 2023 17:46:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     devicetree@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwtracing: coresight: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:46:11 -0600
Message-Id: <20230714174611.4057415-1-robh@kernel.org>
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
 drivers/hwtracing/coresight/coresight-core.c     | 2 +-
 drivers/hwtracing/coresight/coresight-platform.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 118fcf27854d..9fabe00a40d6 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -17,7 +17,7 @@
 #include <linux/mutex.h>
 #include <linux/clk.h>
 #include <linux/coresight.h>
-#include <linux/of_platform.h>
+#include <linux/property.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
 
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 3e2e135cb8f6..d94b0e77bcfc 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -9,9 +9,8 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
+#include <linux/of.h>
 #include <linux/of_graph.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
 #include <linux/coresight.h>
-- 
2.40.1

