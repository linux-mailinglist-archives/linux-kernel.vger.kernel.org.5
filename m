Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C5D779094
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjHKNQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbjHKNQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:16:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383AC26B6;
        Fri, 11 Aug 2023 06:16:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC1436576A;
        Fri, 11 Aug 2023 13:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0F1C433C8;
        Fri, 11 Aug 2023 13:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691759767;
        bh=nukkFSLL4P8Jr+p/dmzT3QsEQ0EGjj5/yMaNaTXyids=;
        h=From:To:Cc:Subject:Date:From;
        b=Kk9odl1YytqoGOgtcDfjLlBMzw5GoL/OKM8j6hffFD3mw5FMyFVc3K9ILEbj2+081
         pudtq1NP5/tZa9Wexobiem93LieQudBbg0eQ0ZtMTvKFqc/JUIXG6/7qQjCcf4XzNO
         5HfPJF5svI+wL9XINgVDjKLj+ckSslUBaPJoyy+uVJLR8O3KII72czlYyb76JV7EOm
         AFgBt9FpIcTgeCBFdobX/DABISbmdUwwujnwPNSjjI9WjKlkrk+JK0VZEm5PCb11Hi
         EtP7oD+qUTFnYSRNGYNqoxIOGxzf4R8xlVmVvhkwsnprLvdBRmpN7sd1mlIcRaQ5Qq
         EkitZ1qtawnaw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Artur Weber <aweber.kernel@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] backlight: lp855x: fix unintialized function return
Date:   Fri, 11 Aug 2023 15:15:53 +0200
Message-Id: <20230811131600.2380519-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The function now returns an error code in some cases, but fails to initialize
it in others:

drivers/video/backlight/lp855x_bl.c:252:11: error: variable 'ret' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
        else if (lp->mode == REGISTER_BASED)
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/video/backlight/lp855x_bl.c:256:9: note: uninitialized use occurs here
        return ret;
               ^~~
drivers/video/backlight/lp855x_bl.c:252:7: note: remove the 'if' if its condition is always true
        else if (lp->mode == REGISTER_BASED)
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since this case should not actually happen, return the -EINVAL code.

Fixes: 5145531be5fba ("backlight: lp855x: Catch errors when changing brightness")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/backlight/lp855x_bl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index 61a7f45bfad84..ea4fa69e49a70 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -252,6 +252,8 @@ static int lp855x_bl_update_status(struct backlight_device *bl)
 	else if (lp->mode == REGISTER_BASED)
 		ret = lp855x_write_byte(lp, lp->cfg->reg_brightness,
 					(u8)brightness);
+	else
+		ret = -EINVAL;
 
 	return ret;
 }
-- 
2.39.2

