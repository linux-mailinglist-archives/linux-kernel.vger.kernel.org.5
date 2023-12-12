Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE9B80F982
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377574AbjLLVgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377564AbjLLVg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:36:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A364CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:36:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13DFC433C7;
        Tue, 12 Dec 2023 21:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702416993;
        bh=7eLZmT4c+fhFsyeFMw0JfCmjrU8I9lIkdJtLdS55xkI=;
        h=From:To:Cc:Subject:Date:From;
        b=jogJziO6KMjsDBdgTJ3ForpAxZ2uFB69WZGXd3/IfFyg5tI+o5RHURJQ5VRTxE6Fr
         C7Zbo3zE8fb2bRohJVE808bYOONGZLkZg+KBkwOZb/yHfUpsimO4JHhTJed8xjn6Od
         F2HFZr0skIQJQRqzTV/DbxXbxZG6TLjbK3B3fG+kEHSmDbz7rMlQSFjus3J1wPqEko
         RqOhl9hRq8kXc/4jUEJunbPBlWk+qDiAjxoZ9XlsuqqVrTkeEcADCMv/QhZvgLqX1e
         zZ85U+5FZbgw/vVOC6RlquCAdfIJMGzs6J0yNJuKc0qayPp5USq1o1vZsSITFzKmYm
         c8mZD3flToCpw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] media: i2c: mt9m114: add CONFIG_COMMON_CLK dependency
Date:   Tue, 12 Dec 2023 22:18:04 +0100
Message-Id: <20231212213625.3653558-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

With clang-16, building without COMMON_CLK triggers a range check on
udelay() because of a constant division-by-zero calculation:

ld.lld: error: undefined symbol: __bad_udelay
>>> referenced by mt9m114.c
>>>               drivers/media/i2c/mt9m114.o:(mt9m114_power_on) in archive vmlinux.a

Avoid this by adding a Kconfig dependency that avoids the broken build.

Fixes: 24d756e914fc ("media: i2c: Add driver for onsemi MT9M114 camera sensor")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/i2c/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index aae05142e191..b224c37bfd77 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -228,6 +228,7 @@ config VIDEO_MT9M111
 
 config VIDEO_MT9M114
 	tristate "onsemi MT9M114 sensor support"
+	depends on COMMON_CLK
 	select V4L2_CCI_I2C
 	help
 	  This is a Video4Linux2 sensor-level driver for the onsemi MT9M114
-- 
2.39.2

