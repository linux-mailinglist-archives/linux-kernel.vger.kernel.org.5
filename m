Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D10C758651
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjGRUzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGRUzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:55:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B760198C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:55:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 085B360DC7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 20:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEBBC433C8;
        Tue, 18 Jul 2023 20:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689713733;
        bh=M0onE6i8LADYq4rymohE2xl3aT/2qhOS8gY865csRy0=;
        h=From:To:Cc:Subject:Date:From;
        b=rJQp7xnFkUhyUlWzwfc8LOJrz5AAYmmUWLnoteAmgx5CkfAAWovFMQ7sticHzqUHA
         oTLADBDkF0KqqJOJhZKWV2qWxn71ZBWTITUkyaafBgKJLDwp18Ymx3BnaWJPHMt5+Z
         QEoNYWiABtPCMU+D7mxdXEUUe0INufQ4y4jqyAUY7hHwOghTSwxp3B63PlzA+Lev2J
         Tb20ezYHeAJvRcU+9AIHhnW1PKu2oGbFcnrH9bq8mUbBG/7nfgQ2Jq8rr6v3SpRUtz
         wj/2VgE/A9kwLAL+ZXXUnI5S/uHCA59zMr/obUskTSePowWXi72GbZMzHP5SWmvWuh
         sO+Z2t9ogI9iA==
Received: (nullmailer pid 1791507 invoked by uid 1000);
        Tue, 18 Jul 2023 20:55:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] fsi: Explicitly include correct DT includes
Date:   Tue, 18 Jul 2023 14:55:08 -0600
Message-Id: <20230718205508.1790932-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
v2:
 - I inadvertently had a dependency in my tree partially updating the
   headers. That's squashed in now.
---
 drivers/fsi/fsi-occ.c     | 2 +-
 drivers/fsi/fsi-sbefifo.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index abdd37d5507f..da35ca9e84a6 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -15,7 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/fsi-occ.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 9912b7a6a4b9..4bae52c98620 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -22,8 +22,8 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
-- 
2.40.1

