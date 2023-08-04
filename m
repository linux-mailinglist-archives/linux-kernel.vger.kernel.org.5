Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2048A77037F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjHDOtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjHDOtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:49:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68821AC;
        Fri,  4 Aug 2023 07:49:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFC036204A;
        Fri,  4 Aug 2023 14:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FD6C433C8;
        Fri,  4 Aug 2023 14:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691160557;
        bh=5jNma6EJcC5phJznMqJTbx+lwzq7XAJ5Kfv3ZCZUWmY=;
        h=From:To:Cc:Subject:Date:From;
        b=L2JSfEknsRbFkqEVkb0X86W2G877TRKEjnpxqoV91s+/nLk9gZDlPUqBocJ8Le219
         dOWpO85O9TDxoYqQewybY/wgDtsXJnPILAYSLSzFoa8YxSCzVgcF6+fgaJXwURg1aw
         z16EaSBETZSSQejQN5vtCYFbUF5KswMVOMNI7Z52xhPpP7UA5EEfdT5PUU8hB9hquS
         CLd7GvdGS21KRJBbIZ61sI1vPrsZhUguSsT2FtpEVM3+jjQZTpdJOc5RpIZpiRQ/e2
         FJhaRWgFtDDAm11FcA3/Aatvv+sh6YeDRiQZPbOF0IGqGg5U2TNQY4HQPr/rPXKnZr
         lZhpSD8jSxA+g==
Received: (nullmailer pid 1339206 invoked by uid 1000);
        Fri, 04 Aug 2023 14:49:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kernel test robot <lkp@intel.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwrng: xgene: Add explicit io.h include
Date:   Fri,  4 Aug 2023 08:48:44 -0600
Message-Id: <20230804144844.1338640-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0788257aeebe ("hwrng: Explicitly include correct DT includes")
removed an implicit include of io.h. On most architectures, there's
still an implicit include of it, but not on s390. Enabling COMPILE_TEST
in commit 1ce1cd8208ad ("hwrng: Enable COMPILE_TEST for more drivers")
exposed this.

Fixes: 0788257aeebe ("hwrng: Explicitly include correct DT includes")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308042049.8R2tNRoo-lkp@intel.com/
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/char/hw_random/xgene-rng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/hw_random/xgene-rng.c b/drivers/char/hw_random/xgene-rng.c
index c25bb169563d..99f4e86ac3e9 100644
--- a/drivers/char/hw_random/xgene-rng.c
+++ b/drivers/char/hw_random/xgene-rng.c
@@ -14,6 +14,7 @@
 #include <linux/hw_random.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
-- 
2.40.1

