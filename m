Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575E37CE5E0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjJRSH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjJRSHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:07:24 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2B411F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:07:22 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b497c8575aso5214766b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697652442; x=1698257242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XonaI8Xf/SLuA38iJr1RRfWuXVp5bhd8ehTmRJBXQ1A=;
        b=jsCio2pz4AKPS9kJon3SZ6ovCU2LvJeLcwusI5VA/Moj02q2JBhz1LuFon1sDDZqYw
         DRpBpOM9zmUXRqNU6zPaqWbVz+Pqq15nCuAC1jxTa1YJzYctIgJqE36uy/79gYi20s/A
         JSuc1+uqTrC7k4bGSQstiHJ3bWCe2vipn+7ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697652442; x=1698257242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XonaI8Xf/SLuA38iJr1RRfWuXVp5bhd8ehTmRJBXQ1A=;
        b=Pbi6js98tIXCmkSCH49LQ4CdYHrtoSeLE5kEp5OiKtxzpsWmqDGscLrfSR3LG87gg+
         b27s6sw/GQNYr802xT8+MOWRchfkavIb/4cgA/sFxtuidhjDGwM6fF8vRerM2L+1G/hp
         qbAgxQm5XT5tpRLE96FLWHF5z4YDaeUZ900u8Y0wQFLvl/G67KAwAUkMzdFukDBEKNUf
         RJFyEDJlSZ7dwdV/F2NwQNKPcARzkZeSGnO/pIrnZQcGIxknY4qZGvzf2kB4MHulbTw/
         ORRQGiT1u+/8EBUacRvaXgbo7uvQ/GYAsLzksm1xruZhA9lQbAPtRij9Fsjv7vAL/zLF
         /8Sw==
X-Gm-Message-State: AOJu0Yxsxpy66mWqC1+Y14vp9aQPVBQ08ReT7e8R+J26ewNINlOJBbOL
        l/hSAXpH2QrVBYkwzdFUcdQSgg==
X-Google-Smtp-Source: AGHT+IH3BprO2nrkOewTORYho++pGOdbQRZC1bN7WJi6N5dcshuFmh5PGHUbgMWTD3QbJWjs+bYJHA==
X-Received: by 2002:a05:6a00:b46:b0:6be:4e6e:2a85 with SMTP id p6-20020a056a000b4600b006be4e6e2a85mr7147729pfo.30.1697652442150;
        Wed, 18 Oct 2023 11:07:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x26-20020aa79ada000000b0069309cbc220sm3625673pfp.121.2023.10.18.11.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:07:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] string: Adjust strtomem_pad() logic to allow for smaller sources
Date:   Wed, 18 Oct 2023 11:07:17 -0700
Message-Id: <20231018180709.work.293-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2772; i=keescook@chromium.org;
 h=from:subject:message-id; bh=Rt1eV6YjyZR8hPzO/9qK3HhySIUW19g/DhKIx9uJ9jQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlMB7VZWKyUdda+qSVCCbnpliyQcdpJPLHtjhC6
 wQ+xa1Q9k2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZTAe1QAKCRCJcvTf3G3A
 JvLtD/4vR8iWSvia1DQYbZ8m+tqzhImzUGpErsH/KDBTULSjLG+5iWaI1Sk4C2zSlqEzo7SqEXM
 Kt3AZDESIQynRLJky5h+GNObiXryvBdfesyvC1ycPKr5Aror8ouzxAFzwgl6IRtNFLsn5z/9+VX
 5chlFTq8xtubHLh3BXGvqQvKjRAdzDVBCGx9x5g/7rLJGaBD3rhJj6eYMsJpvwmFDc6EEyG8HKD
 YxeBhJLkHBSnkMpFRVYspLGVmsEa+lvAOHwfQa15huGvb4AtnJsoS85L0hXWbzNfjp5aDB1TzzL
 +38CUoVhtBzuAnEyXBWadZV06HbXyl6M3PEFE7kF+w47SGFXJ85SCN9Gm44sTyZDDxiUsLoiWjy
 6jeKdH4O6pGyXuXlEnpEEBsIzmxzVF9Rl74P5e7vC7Eli1Jz7ILMVEpbrINStNOOkUBizb7oalu
 ZEIQrRlZWjm0Q+iD1y5oFExoM0edBPWIgBsi0qnWyQdnSFJk+2iySCuSaQczSAvorCWOukEZlRy
 iF3WFmv3J2WdEgXos+iuNxMbZalvvBAHYgdQleYGEoG2pdBz73lTvz3/bH2+Y4B/WTgvUwVjLre
 ljV/6yoBVamHn6dHWUj1x6AFevYMlr897FIZ07lhgqZpRDCBzmMjPvQNMCEC8mRyTvmsO0EiXNq
 HaRyCCV cae/bc5Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd noticed we have a case where a shorter source string is being copied
into a destination byte array, but this results in a strnlen() call that
exceeds the size of the source. This is seen with -Wstringop-overread:

In file included from ../include/linux/uuid.h:11,
                 from ../include/linux/mod_devicetable.h:14,
                 from ../include/linux/cpufeature.h:12,
                 from ../arch/x86/coco/tdx/tdx.c:7:
../arch/x86/coco/tdx/tdx.c: In function 'tdx_panic.constprop':
../include/linux/string.h:284:9: error: 'strnlen' specified bound 64 exceeds source size 60 [-Werror=stringop-overread]
  284 |         memcpy_and_pad(dest, _dest_len, src, strnlen(src, _dest_len), pad); \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../arch/x86/coco/tdx/tdx.c:124:9: note: in expansion of macro 'strtomem_pad'
  124 |         strtomem_pad(message.str, msg, '\0');
      |         ^~~~~~~~~~~~

Use the smaller of the two buffer sizes when calling strnlen(). When
src length is unknown (SIZE_MAX), it will use dest length, which is what
the original code did.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Fixes: dfbafa70bde2 ("string: Introduce strtomem() and strtomem_pad()")
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/string.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index dbfc66400050..9e3cb6923b0e 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -277,10 +277,12 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
  */
 #define strtomem_pad(dest, src, pad)	do {				\
 	const size_t _dest_len = __builtin_object_size(dest, 1);	\
+	const size_t _src_len = __builtin_object_size(src, 1);		\
 									\
 	BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||		\
 		     _dest_len == (size_t)-1);				\
-	memcpy_and_pad(dest, _dest_len, src, strnlen(src, _dest_len), pad); \
+	memcpy_and_pad(dest, _dest_len, src,				\
+		       strnlen(src, min(_src_len, _dest_len)), pad);	\
 } while (0)
 
 /**
@@ -298,10 +300,11 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
  */
 #define strtomem(dest, src)	do {					\
 	const size_t _dest_len = __builtin_object_size(dest, 1);	\
+	const size_t _src_len = __builtin_object_size(src, 1);		\
 									\
 	BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||		\
 		     _dest_len == (size_t)-1);				\
-	memcpy(dest, src, min(_dest_len, strnlen(src, _dest_len)));	\
+	memcpy(dest, src, strnlen(src, min(_src_len, _dest_len)));	\
 } while (0)
 
 /**
-- 
2.34.1

