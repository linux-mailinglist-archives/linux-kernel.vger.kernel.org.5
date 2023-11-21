Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B32B7F28CD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjKUJXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjKUJXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:23:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81171185
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:23:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBE8C433CD;
        Tue, 21 Nov 2023 09:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700558601;
        bh=J9+0GAdeqi0Ihu8k/yKWMGuJLA+L/8D5q4AyXvnWFUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=joL4lNeeXdT8sgymVjfPxJdGEgdmJMXdx1lxwxLRpzs9JPGNAmnht0AnabfVbu479
         1k/dvSQKu37gIQKySa8+yCQv4AO5mmQhV5b4sb6aSxTgWlDMoJwGSUUwUU1dN/kVGe
         wrRTKvMy8ZwK2sDFLF7bdedr8jBGVSU5t/USoo+hTzaDcVOraZJ2mSPXKio9X6Ksbz
         M/5DphpvnwANBpsAoI3OZoTNVz1kbiPX/Apb+tQP+cTpipXiCpTySfnOeAmTIc5qAE
         FOrggxWRY9i/kzp+EHW6TuOWdKfcWDxeQlgaKpBpfiERpVNGqxt+liG/CtpuSLRrq5
         FRaTfyApDjMVQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 10/17] tty: hso: don't initialize global serial_table
Date:   Tue, 21 Nov 2023 10:22:51 +0100
Message-ID: <20231121092258.9334-11-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121092258.9334-1-jirislaby@kernel.org>
References: <20231121092258.9334-1-jirislaby@kernel.org>
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

'serial_table' is global, so there is no need to initialize it to NULLs
at the module load. Drop this unneeded for loop.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 drivers/net/usb/hso.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index 48450fe861ad..f088ea2ba6f3 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -3227,13 +3227,8 @@ static struct usb_driver hso_driver = {
 
 static int __init hso_init(void)
 {
-	int i;
 	int result;
 
-	/* Initialise the serial table semaphore and table */
-	for (i = 0; i < HSO_SERIAL_TTY_MINORS; i++)
-		serial_table[i] = NULL;
-
 	/* allocate our driver using the proper amount of supported minors */
 	tty_drv = tty_alloc_driver(HSO_SERIAL_TTY_MINORS, TTY_DRIVER_REAL_RAW |
 			TTY_DRIVER_DYNAMIC_DEV);
-- 
2.42.1

