Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ED27F28D0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjKUJYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjKUJXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:23:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20D511A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:23:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06674C43391;
        Tue, 21 Nov 2023 09:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700558605;
        bh=422VxiK87dzWUOJytz3EHqN1a+RdqnMf/xYBks1K7os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WIeSXUZT5Zd5gFDKfkN2dEKBartK8soImgPbg3Uw3mVQJGUDkMXZjRr1FVhiWsEBf
         mI01vMF8t9qicENnYiI8BcFj0H5r9gHIPA6fM3DLtQTboflHR77aRN8HXEWwBiduvJ
         EwhIrWEMWNmKMAy476pHRxEUgq/PNfx3VwHRkuYdplHm7VmlqcCuGr6eJq8i6Mg9v3
         XAPHv9sA7Gi7FqPgIusC9aKm3YX1piTyGc+IqlITUw3N3u4DGEBlNG15EUpkBsGS4j
         tP6mb8x8tSnUy84ZCeDHhxXkUFHFS0MV7FPHmCc9fb604bzuiQr998K6BHVcQiipxh
         cOAWxcm3u32cA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 12/17] tty: nozomi: remove unused debugging DUMP()
Date:   Tue, 21 Nov 2023 10:22:53 +0100
Message-ID: <20231121092258.9334-13-jirislaby@kernel.org>
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

DUMP()'s only use is commented out. Remove the macro completely along
with this unused use.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/nozomi.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index 02cd40147b3a..b247341bd12f 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -65,24 +65,8 @@ do {							\
 #define DBG3(args...) DBG_(0x04, ##args)
 #define DBG4(args...) DBG_(0x08, ##args)
 
-/* TODO: rewrite to optimize macros... */
-
 #define TMP_BUF_MAX 256
 
-#define DUMP(buf__, len__)						\
-	do {								\
-		char tbuf[TMP_BUF_MAX] = {0};				\
-		if (len__ > 1) {					\
-			u32 data_len = min_t(u32, len__, TMP_BUF_MAX);	\
-			strscpy(tbuf, buf__, data_len);			\
-			if (tbuf[data_len - 2] == '\r')			\
-				tbuf[data_len - 2] = 'r';		\
-			DBG1("SENDING: '%s' (%d+n)", tbuf, len__);	\
-		} else {						\
-			DBG1("SENDING: '%s' (%d)", tbuf, len__);	\
-		}							\
-	} while (0)
-
 /*    Defines */
 #define NOZOMI_NAME		"nozomi"
 #define NOZOMI_NAME_TTY		"nozomi_tty"
@@ -754,8 +738,6 @@ static int send_data(enum port_type index, struct nozomi *dc)
 		return 0;
 	}
 
-	/* DUMP(buf, size); */
-
 	/* Write length + data */
 	write_mem32(addr, (u32 *) &size, 4);
 	write_mem32(addr + 4, (u32 *) dc->send_buf, size);
-- 
2.42.1

