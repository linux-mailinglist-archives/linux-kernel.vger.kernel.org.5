Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F29D756722
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjGQPE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjGQPEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:04:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02276E7F;
        Mon, 17 Jul 2023 08:04:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 952E26105C;
        Mon, 17 Jul 2023 15:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C921C433C8;
        Mon, 17 Jul 2023 15:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689606294;
        bh=kRV/xSf86iTldaNK/Wk2zNVVTiDcvdiI33s7jGOYRsM=;
        h=From:To:Cc:Subject:Date:From;
        b=EKyWMGofhVGHC07otPIzcKxMQP9WkSc0w09sua0P48+YuirRmJ9+cumJ+PYMUZZq6
         Fmrg2Uhqv8vo79m9hav8qbQTKKilWJNCOo3DmGYEfxybMb/aIsYo+3eVzpJ/BHFI6R
         9/pKQe75PGK6U7bF+of2BeS/U4in0wIupcYlqX7/dnIDfpS1jyGkCgjUmuNUu34nrO
         i2QZDIQFGiWGX9QySp2w5ngK86PKv3jU6rr4Vx8WoBUrKCLfMjqHlKBVmVbWumM6jF
         uIBvHkkLShoM54a9k3A3Pht4DHOFTjiMVrBD8swttw1Rt5t04BINnTJi/uSqdl5qV0
         hfTisV50GKvkQ==
Received: (nullmailer pid 1750720 invoked by uid 1000);
        Mon, 17 Jul 2023 15:04:52 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cdx: Explicitly include correct DT includes
Date:   Mon, 17 Jul 2023 09:03:55 -0600
Message-Id: <20230717150355.1749845-1-robh@kernel.org>
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
Note that drivers/cdx/ is missing a MAINTAINERS entry. Please add one.

 drivers/cdx/controller/cdx_controller.c | 3 ++-
 drivers/cdx/controller/cdx_rpmsg.c      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index dc52f95f8978..bb4ae7970e21 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -5,7 +5,8 @@
  * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
  */
 
-#include <linux/of_platform.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/cdx/cdx_bus.h>
 
diff --git a/drivers/cdx/controller/cdx_rpmsg.c b/drivers/cdx/controller/cdx_rpmsg.c
index f37e639d6ce3..04b578a0be17 100644
--- a/drivers/cdx/controller/cdx_rpmsg.c
+++ b/drivers/cdx/controller/cdx_rpmsg.c
@@ -7,7 +7,8 @@
 
 #include <linux/rpmsg.h>
 #include <linux/remoteproc.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/cdx/cdx_bus.h>
 #include <linux/module.h>
 
-- 
2.40.1

