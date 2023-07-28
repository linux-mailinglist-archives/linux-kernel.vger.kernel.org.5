Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E46766EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbjG1Nte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbjG1NtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:49:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF162D60;
        Fri, 28 Jul 2023 06:48:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 022A462130;
        Fri, 28 Jul 2023 13:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FFCC433C7;
        Fri, 28 Jul 2023 13:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690552136;
        bh=ybAewDSIihhc9NHGhos2fH++UkcTbQSngJl7W7DzYpc=;
        h=From:To:Cc:Subject:Date:From;
        b=oDxPzCSS6ehCZesw8RUEPFEJvyhTJvVh/bwVCf/zMFZ8ahhmcU1v6L0qxMJrJC2L1
         w826i3oZYo16kjtBfSrcWXLvw6+wzJ2+FfBRzoHEUuji3Bv8PjcYMMN/M7wq19U5om
         pTRClACtk8Rf797gBpL8u1ns1MFtNCc1p/zQy208F+rrB4NmB91JIcbgVi4933dC8U
         dsVa93vqJe190+Jrf2LYiyNfjf4nPqBs721jYiR33v0p1IF6WIRgVG4e0ltAL9hYdm
         tH3MGCT6juqTCo29mUJHmtAxdLhsC170M6MBzonGxxguVNCrDMDSXp3MimuOTrf00F
         fwPwf68IjUrHw==
Received: (nullmailer pid 3224739 invoked by uid 1000);
        Fri, 28 Jul 2023 13:48:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Airlie <airlied@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] char: Explicitly include correct DT includes
Date:   Fri, 28 Jul 2023 07:48:45 -0600
Message-Id: <20230728134845.3224553-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it was merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
 - Split out hw_random, ipmi and tpm
---
 drivers/char/agp/uninorth-agp.c | 1 +
 drivers/char/bsr.c              | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index 62de7f4ba864..84411b13c49f 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -3,6 +3,7 @@
  * UniNorth AGPGART routines.
  */
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/init.h>
diff --git a/drivers/char/bsr.c b/drivers/char/bsr.c
index 12143854aeac..70d31aed9011 100644
--- a/drivers/char/bsr.c
+++ b/drivers/char/bsr.c
@@ -6,11 +6,10 @@
  * Author: Sonny Rao <sonnyrao@us.ibm.com>
  */
 
+#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/cdev.h>
-- 
2.40.1

