Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D1C757018
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjGQW6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjGQW6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5E8133
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0081612BB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 22:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B99C433C7;
        Mon, 17 Jul 2023 22:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689634721;
        bh=zoQDrQx6VA0Kzn37i4rBJiv4CQt7POFa0ThlQ9tICnE=;
        h=From:To:Cc:Subject:Date:From;
        b=GFMEVdY2Jrl1RBbURPK007unlOIoSJJcTelXbKBZBbtIcQulwvmfinloecmRKDNPm
         TXsPCStrYxwiNuRCfvZkDdgQuCp4A3j2WG9zUve0vETv6sn1k1+8X7cPAPyKheI4O3
         TcxwjtWFn+hfpwqd9eQU1N9O5hG5rR+l9mMZ0FwgFSwfp0I+MnwoOO+J0k/DrqBMQE
         Igf79J0iGbExiXUqc43PQYk0CjdtLJzFI9NwzaEWRceoUJHN48a0K28Rk8IjU0v7wj
         ppK3YkwZ+LOYhY9iFr+DzZd5gNxMo7/Y4v+D5pP8GijhDZQYl4/mPGMqIy8HfvWx2T
         sRG/bXpHZ6mjg==
Received: (nullmailer pid 3212156 invoked by uid 1000);
        Mon, 17 Jul 2023 22:55:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mvebu: Explicitly include correct DT includes
Date:   Mon, 17 Jul 2023 16:54:56 -0600
Message-Id: <20230717225456.3212019-1-robh@kernel.org>
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
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-mvebu/kirkwood.c | 1 +
 arch/arm/mach-mvebu/pmsu.c     | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
index 8ff34753e760..73b2a86d6489 100644
--- a/arch/arm/mach-mvebu/kirkwood.c
+++ b/arch/arm/mach-mvebu/kirkwood.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/of_net.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <asm/hardware/cache-feroceon-l2.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 6f366d8c4231..79c5171f06ec 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -23,8 +23,8 @@
 #include <linux/kernel.h>
 #include <linux/mbus.h>
 #include <linux/mvebu-pmsu.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/resource.h>
 #include <linux/slab.h>
-- 
2.40.1

