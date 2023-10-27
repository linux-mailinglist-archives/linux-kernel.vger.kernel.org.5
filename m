Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A17F7D9AED
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346043AbjJ0OOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJ0OOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:14:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679AAFA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:14:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9d10972e63eso17802766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698416041; x=1699020841; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lp1+7YjGbDfdS0f0bEXkOm+6Hu4+gGbqezgHyNjvf+s=;
        b=iaCzi8PufDrBJdH+/UqKgny6/v3FLqMP+OYyJxVJljZ/QPeXnxAiiJ9dzGi0hyABi+
         YM5paK3Ru87L3pv8PzYEii55LDnh71FFGQvQJHnUzfw60zavNp105SIBT5jx9rHqQvZO
         kAr2TQG6t53Pb3kHNpxKu/E7TNpRRkIN2gSx9Z782JnlPIJo55heX5ZeIh4r5AeykOTM
         AKHpfeGnOtYSFvA9+GhUBtdQBP5xtrLPfn7E/8H7VWbECd+a6uCb51n345nHuulire/h
         urNc0EgjGeeXDU8HO9TxevEHOBwOThn94RW9U4xnmO9+F+GFoD7HfbyRiBns8Flf7Evu
         EwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698416041; x=1699020841;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lp1+7YjGbDfdS0f0bEXkOm+6Hu4+gGbqezgHyNjvf+s=;
        b=ll0rfK6EJcynn3L6+eVwXy+BsTBqyXhM0sgEMOmLPYAC1eixZBf6V/RDxN3WszoYw4
         Ul4Pc7TW/d2p2nQ+Bt8yemAythIo/MLuAC5al+FNjr4aGPEFQlCuFhycFCAP9uVKC5Gn
         EL4fDWlQI28WuxlC8i93j/thYYKwXr9Pnu1dPgtlZc1KqGaXZgwPX9m8c22GX0L78GL2
         vhZulMBwIQhh7O66iCGSfzkhwLRpEs9IsfCwNXtfT98Sx5QfQ22anst9azxpRyQGV3La
         GDssjzRawhEd3Co4LpXWOHFfMFi1jJYtI8/yADScB6Qh8u8zjLszgXq2W/afpIXWt/29
         m5eQ==
X-Gm-Message-State: AOJu0YzOfDsSuIV4Nvf/jBKccaP8fCtz/WtVHiEhU8MsQ0gpaEw13f0j
        ncfSK7gZkFOQBrQNQQXAcgva85u/7w==
X-Google-Smtp-Source: AGHT+IFm2sqord7670qVo/SBS/wQ388v7E/lsVwGsFlgEu3zbX2xntvIVXxrtka76KpR+Djidwfb+A==
X-Received: by 2002:a17:907:26c4:b0:9b2:aa2f:ab69 with SMTP id bp4-20020a17090726c400b009b2aa2fab69mr2157182ejc.30.1698416040533;
        Fri, 27 Oct 2023 07:14:00 -0700 (PDT)
Received: from p183 ([46.53.253.206])
        by smtp.gmail.com with ESMTPSA id ox9-20020a170907100900b009b65b2be80bsm1250046ejb.76.2023.10.27.07.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:14:00 -0700 (PDT)
Date:   Fri, 27 Oct 2023 17:13:58 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vsprintf: uninline simple_strntoull(), reorder arguments
Message-ID: <82a2af6e-9b6c-4a09-89d7-ca90cc1cdad1@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* uninline simple_strntoull(),
  gcc overinlines and this function is not performance critical

* reorder arguments, so that appending INT_MAX as 4th argument
  generates very efficient tail call

Space savings:

	add/remove: 1/0 grow/shrink: 0/3 up/down: 27/-179 (-152)
	Function                            old     new   delta
	simple_strntoll                       -      27     +27
	simple_strtoull                      15      10      -5
	simple_strtoll                       41       7     -34
	vsscanf                            1930    1790    -140

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 lib/vsprintf.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -60,7 +60,8 @@
 bool no_hash_pointers __ro_after_init;
 EXPORT_SYMBOL_GPL(no_hash_pointers);
 
-static noinline unsigned long long simple_strntoull(const char *startp, size_t max_chars, char **endp, unsigned int base)
+noinline
+static unsigned long long simple_strntoull(const char *startp, char **endp, unsigned int base, size_t max_chars)
 {
 	const char *cp;
 	unsigned long long result = 0ULL;
@@ -95,7 +96,7 @@ static noinline unsigned long long simple_strntoull(const char *startp, size_t m
 noinline
 unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base)
 {
-	return simple_strntoull(cp, INT_MAX, endp, base);
+	return simple_strntoull(cp, endp, base, INT_MAX);
 }
 EXPORT_SYMBOL(simple_strtoull);
 
@@ -130,8 +131,8 @@ long simple_strtol(const char *cp, char **endp, unsigned int base)
 }
 EXPORT_SYMBOL(simple_strtol);
 
-static long long simple_strntoll(const char *cp, size_t max_chars, char **endp,
-				 unsigned int base)
+noinline
+static long long simple_strntoll(const char *cp, char **endp, unsigned int base, size_t max_chars)
 {
 	/*
 	 * simple_strntoull() safely handles receiving max_chars==0 in the
@@ -140,9 +141,9 @@ static long long simple_strntoll(const char *cp, size_t max_chars, char **endp,
 	 * and the content of *cp is irrelevant.
 	 */
 	if (*cp == '-' && max_chars > 0)
-		return -simple_strntoull(cp + 1, max_chars - 1, endp, base);
+		return -simple_strntoull(cp + 1, endp, base, max_chars - 1);
 
-	return simple_strntoull(cp, max_chars, endp, base);
+	return simple_strntoull(cp, endp, base, max_chars);
 }
 
 /**
@@ -155,7 +156,7 @@ static long long simple_strntoll(const char *cp, size_t max_chars, char **endp,
  */
 long long simple_strtoll(const char *cp, char **endp, unsigned int base)
 {
-	return simple_strntoll(cp, INT_MAX, endp, base);
+	return simple_strntoll(cp, endp, base, INT_MAX);
 }
 EXPORT_SYMBOL(simple_strtoll);
 
@@ -3648,13 +3649,11 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 			break;
 
 		if (is_sign)
-			val.s = simple_strntoll(str,
-						field_width >= 0 ? field_width : INT_MAX,
-						&next, base);
+			val.s = simple_strntoll(str, &next, base,
+						field_width >= 0 ? field_width : INT_MAX);
 		else
-			val.u = simple_strntoull(str,
-						 field_width >= 0 ? field_width : INT_MAX,
-						 &next, base);
+			val.u = simple_strntoull(str, &next, base,
+						 field_width >= 0 ? field_width : INT_MAX);
 
 		switch (qualifier) {
 		case 'H':	/* that's 'hh' in format */
