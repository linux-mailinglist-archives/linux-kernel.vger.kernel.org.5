Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36187F095A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjKSWPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjKSWPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:15:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CFC12D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:15:14 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-408434ce195so10205325e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700432112; x=1701036912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FBjgqP02grvuhK+DBWx2eCwwUqM0RvQ4/hJhGy33ZEM=;
        b=M736zl4dlOdlC50+k1J76gPktOl1YCJUrqarqc82756GcXcrvA73zsEViSV2QVqYX5
         TpNFofVC6qc0k4nUAnkNaXaiqIac2yeDV4qDCq2+wLH9F9C+FFn5sYFz97MkhKBmuiFX
         J8mtIlWR9sUiF2ToF/2hNSx7WRjCsZiUHA1wwV9N43qNsgrIDaBwJaw3vTXTOWXSmlTT
         gzPr4eoJ3rv4GRu1VLkAIDhfEzow8Bu5cMBD5El+0gLMZeHQYngUnp3ljXnxjGkAlTHu
         xUYkthLBJ+7rkTAOjOEYNXBs0KIwkkFw1JvFgv1Y9GqmsaZHtmQoVhAxuyhQfzwD7F9e
         Xlog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700432112; x=1701036912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBjgqP02grvuhK+DBWx2eCwwUqM0RvQ4/hJhGy33ZEM=;
        b=a6DHStp0gE2wqVTF3pLCrjdEn52GbJRo9f71SuXMu9SjGfxRH4z4GFzA30D/9RAfJj
         WdjkRzMFfyQ5jUhwXDR9c4gFQCz/8Ln6D1MydWQZGNVSqV5ey/C/IOPPSBDVguim52p/
         u/SqzeANXyh29HCjBf8qHPImOyMxRSnC5XfC9PH2+rFX9jnyCroNQFL4HkRaBTtNll22
         yr7cgzlZQhx4zGJHvRWFF3sDOTymjQ+i9t5bjaHu5b0EZeWECVuypCdkN8Ez+/iuYxAg
         KPKq1nKjR55yleU+8wxNDw6akn37rLNFkjKVdgCHWbIdzJwBmufq28WtOtnW3fLjt+n0
         qGSw==
X-Gm-Message-State: AOJu0Yziw2z5lPTPvIVUBiFBr/vdTsb5TXRRAydP6YMxZRbTFs+z3W/C
        Ol11ffH7qGcn41pmE/lJRfA=
X-Google-Smtp-Source: AGHT+IE2p6BOd31Q9tTqJcohhMYsWkZHaI6dEiTvJ2SqrnQkH+c3ZKtU4Yx8vMMvQEDSp5zmb4RR2Q==
X-Received: by 2002:a5d:5588:0:b0:32f:820c:44b0 with SMTP id i8-20020a5d5588000000b0032f820c44b0mr4468016wrv.0.1700432112255;
        Sun, 19 Nov 2023 14:15:12 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id s5-20020adfdb05000000b0032d8eecf901sm9221008wri.3.2023.11.19.14.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 14:15:12 -0800 (PST)
Date:   Sun, 19 Nov 2023 23:15:10 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/14] staging: rtl8192e: Remove unused macros
 IS_EQUAL_CIE_SRC and friends
Message-ID: <6d514e946983fb8ef4a3d7d3cb2774261a593d2f.1700431464.git.philipp.g.hortmann@gmail.com>
References: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused macros IS_EQUAL_CIE_SRC, UPDATE_CIE_WATCHDOG,
UPDATE_CIE_SRC and IS_COUNTRY_IE_VALID.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.h b/drivers/staging/rtl8192e/dot11d.h
index 0ca803be3965..fd0a2df189bf 100644
--- a/drivers/staging/rtl8192e/dot11d.h
+++ b/drivers/staging/rtl8192e/dot11d.h
@@ -52,15 +52,6 @@ static inline void copy_mac_addr(unsigned char *des, unsigned char *src)
 #define GET_DOT11D_INFO(__ieee_dev)			\
 	 ((struct rt_dot11d_info *)((__ieee_dev)->dot11d_info))
 
-#define IS_COUNTRY_IE_VALID(__ieee_dev)			\
-	(GET_DOT11D_INFO(__ieee_dev)->country_len > 0)
-
-#define IS_EQUAL_CIE_SRC(__ieee_dev, __address)		\
-	 ether_addr_equal_unaligned( \
-		GET_DOT11D_INFO(__ieee_dev)->country_src_addr, __address)
-#define UPDATE_CIE_SRC(__ieee_dev, __address)		\
-	copy_mac_addr(GET_DOT11D_INFO(__ieee_dev)->country_src_addr, __address)
-
 #define GET_CIE_WATCHDOG(__ieee_dev)				\
 	 (GET_DOT11D_INFO(__ieee_dev)->country_watchdog)
 static inline void RESET_CIE_WATCHDOG(struct rtllib_device *__ieee_dev)
@@ -68,8 +59,6 @@ static inline void RESET_CIE_WATCHDOG(struct rtllib_device *__ieee_dev)
 	GET_CIE_WATCHDOG(__ieee_dev) = 0;
 }
 
-#define UPDATE_CIE_WATCHDOG(__ieee_dev) (++GET_CIE_WATCHDOG(__ieee_dev))
-
 void dot11d_init(struct rtllib_device *dev);
 void dot11d_channel_map(struct rtllib_device *ieee);
 
-- 
2.42.0

