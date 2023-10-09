Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F4F7BE840
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377477AbjJIRdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378148AbjJIRdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:33:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E35FD8;
        Mon,  9 Oct 2023 10:32:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671D5C433CA;
        Mon,  9 Oct 2023 17:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696872777;
        bh=k9GQF3dFjUZ/8wGvGz0nYy9OjUlIAHfJQ/PEH5MjWN0=;
        h=From:To:Cc:Subject:Date:From;
        b=tf1eMtFdYCl04xz1yl70rIFn+Qf2Gn9KQUiqG26EMJ7qIeQfM/MJZKZ3dpzZiEmo5
         N+uAT1ywuxKsVD1QCtqdSTedCp2fKGQhsn0KyOEwC8FA8tKIVtbndM+j0rKEIuyq9L
         fC5xtS0YsS+MpMO4QeJhpA+DcXxrgzZEDtA0HZq5nWwmsVAVRIRS6u1KglmSLHBsId
         URS4Y5okmGJ5JcRwvyuPyCMeu6uGgs1JGbm/Syq0S4wy9EkKaa8HReyFLzRDBwqDK8
         X4GMlSebCiaKviSDDzjeLwhkB0DJWx36SqK55Hoi+U4eJuteIF6i65V/iIby0VLbaK
         j404VSRK1dxgA==
Received: (nullmailer pid 2535184 invoked by uid 1000);
        Mon, 09 Oct 2023 17:32:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: pxa: Explicitly include correct DT includes
Date:   Mon,  9 Oct 2023 12:29:17 -0500
Message-ID: <20231009172923.2457844-22-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 drivers/pwm/pwm-pxa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 1e475ed10180..78b04e017c49 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -24,7 +24,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/pwm.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 
 #include <asm/div64.h>
 
-- 
2.42.0

