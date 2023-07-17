Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03294757024
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjGQXAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjGQXAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:00:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE591981
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51757612FE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68024C433C8;
        Mon, 17 Jul 2023 23:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634812;
        bh=MEiv1XO5K8mi2ZdTkf/xnwnFqxVhWUJFvFcGHpWtU+4=;
        h=From:To:Cc:Subject:Date:From;
        b=LADelvwcPBbRFhDqogEGDousdIMe4Gy/YLiiXw7lbd9i5jfMdvDxcDF59nJeVcX+j
         iZqSQ9KU9t8fiQHXLcH0hxMPV7fOJwbv/XAMrZexIYUkCf0nHxuox6De1eH6Jf1Wdm
         MHGsS2j3olh/b1SDVUvYf96tJ+O9qjict5JpjJM//YVqgI7HhK7BYFcLFTYqljzLZk
         /v03AUZskMrWeHHTSCubWLImMwS+21vbDY3YuTC4tr5wD7yAA3zijiF6Y3ymCJmuij
         6HvR5PzBD6P1s0QbVPqnbgn2qu6T1Gm0H8mUy6tHgidw/eyLVNP2mUnF6CfVi1NqGb
         e1mvEOe6fAFqQ==
Received: (nullmailer pid 3210866 invoked by uid 1000);
        Mon, 17 Jul 2023 22:54:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Michal Simek <michal.simek@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: zynq: Explicitly include correct DT includes
Date:   Mon, 17 Jul 2023 16:53:58 -0600
Message-Id: <20230717225358.3210536-1-robh@kernel.org>
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
 arch/arm/mach-zynq/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynq/pm.c b/arch/arm/mach-zynq/pm.c
index 8ba450ab559c..61ad965ef3ac 100644
--- a/arch/arm/mach-zynq/pm.c
+++ b/arch/arm/mach-zynq/pm.c
@@ -8,8 +8,8 @@
  */
 
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include "common.h"
 
 /* register offsets */
-- 
2.40.1

