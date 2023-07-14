Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5007540D1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbjGNRpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbjGNRpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:45:38 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E163D3C19;
        Fri, 14 Jul 2023 10:45:05 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-77a62a84855so87545139f.1;
        Fri, 14 Jul 2023 10:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356700; x=1691948700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+VnY1SVHoOF4Oa9Wkp3gC6amJUnVTlmssx6HJDixzk=;
        b=OCN+0AMRfqPpEPo/ACOs9pLXk5GlM/cR+bj+jsyuC7m1y84BwVRilYXg+kuO62nmNs
         W3sRY69O7pTQZP7dqDycTqFTj0dmUHVCulRhUk4l/FPiqTzPmvr465pD/PskqtPFpo0T
         1NNA0vQZZ4n8JQV0UxM67zDy3GujEwAhDZQdyE22M31KIEFewrb79y6GQ9VBYi3izcLU
         +naa4JwLrZkQIxIo2aHurKUGhZ79P9ZY0R6qnhx4s45YzA+Nd9cVjsf7XBYKaYQoMcSi
         3Eev2sKwdGsbllzY7dMMx/WFlCxoXpqq0tck7wHtWyi0ZYqsQUCA0mMKeGPxNafl1NhU
         fcFA==
X-Gm-Message-State: ABy/qLZkIuyShsIRmeglFnkMgr4XY/U0OlvYdIFI8LbgbYia1vkmsq4l
        JCrIBtVJq0s1MyOyKOPixfYAFD0leA==
X-Google-Smtp-Source: APBJJlGaSlSc5nvpef7wL6QQP41H/qskDMxt+Zu36PIkzrgzIpflxafdpAZ5u4efy5787lsIkqgTLA==
X-Received: by 2002:a5d:87c6:0:b0:785:ccfe:b68f with SMTP id q6-20020a5d87c6000000b00785ccfeb68fmr5428381ios.4.1689356699834;
        Fri, 14 Jul 2023 10:44:59 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id v6-20020a5ec206000000b00786450bb4edsm2672026iop.35.2023.07.14.10.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:44:59 -0700 (PDT)
Received: (nullmailer pid 4055431 invoked by uid 1000);
        Fri, 14 Jul 2023 17:44:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>
Cc:     devicetree@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fsi: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:44:55 -0600
Message-Id: <20230714174455.4055341-1-robh@kernel.org>
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
 drivers/fsi/fsi-occ.c     | 1 -
 drivers/fsi/fsi-sbefifo.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index 73a747437cde..da35ca9e84a6 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -15,7 +15,6 @@
 #include <linux/mutex.h>
 #include <linux/fsi-occ.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 3db6718054fd..4bae52c98620 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -23,6 +23,7 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
-- 
2.40.1

