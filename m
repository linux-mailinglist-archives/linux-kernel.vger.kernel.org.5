Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3717A31DF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 20:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjIPSVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 14:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbjIPSVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 14:21:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BD8CE6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 11:21:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9adb9fa7200so622079366b.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694888494; x=1695493294; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTdyb3zvatPdaFJlPoz0gdD5HKKgZ3y8QEX/wWGYg5M=;
        b=QpkTPR8XiGZ29rzL5rat9BsWqhdJz5cSPb60q9FUdHVTNF4YUcDOXyRka/Fqga8OeM
         qHXYKEp0TA8nSlwW5K2rTiDAFFr97J+i4yJRcOyf71C0yIT9lBE8/EneCl/37UKRDM3O
         qv6o9dJisXVXONmdZPoSSdlBsrx8KlvE+euGdg8V9RXpgJO64KIW1e+x6u1gm5PPICzb
         HX9RezJIB8HrU5iQiZDO+r9dNNapnPySW5M2eBXoygPTEtX9GegagkSQxlJjpPbyI6wP
         CWRGMYIgHc6OWA4An1myijlxxhx87HdeAbtR/96aFo7RwSkkkcdtUfIYH9BleP+5Qzs4
         O6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694888494; x=1695493294;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTdyb3zvatPdaFJlPoz0gdD5HKKgZ3y8QEX/wWGYg5M=;
        b=wFsG/w7NTy6yYGY8eoWdfcYV2Y7XU2fogTeQcxBzoTYZkVnM8G/NwRR+CYJbD0YQ0t
         XCzL2xM8QAhbx8LOi6XmltBEUzyw5JH9h4IAKtV9MHy9wbrXmiSQ2+OqEOef+L0ipg/4
         JYeM/90lc+UGAR5tMQl9p7CP4ZI2alc149Fp64I9SetF+V8jKtB5pdAjxR5bEz3uMydC
         1cMHgfE4It8uxSlqHU9DhRgyb7VX3F3axCgfFBTOreuWD1R/0hUrDAi7XLt7DWQj7IhG
         qfzUyFpI2MmB1FtpbJbOh+EHziQsF4mCAdUsQwmoW7IgnIiBtcUylff83PVyLEusxW7Q
         0C0g==
X-Gm-Message-State: AOJu0Ywn32Yg34DnJP1cgDtBOuVBcsz7v/yJ4MO/HGG11DFEy5MfmqZm
        R+LRhlxsvPpGiEsAFrKN/rVyF4hKfg==
X-Google-Smtp-Source: AGHT+IFqF4m/kwNi2KZ3OjlqMt0CyFqdxsmR4W1ZGkRfaL54yc/jzwaSl5/Lj+YXarYWsxjJMSX6fQ==
X-Received: by 2002:a17:906:5a5f:b0:9a5:9305:83fb with SMTP id my31-20020a1709065a5f00b009a5930583fbmr6797477ejc.34.1694888493805;
        Sat, 16 Sep 2023 11:21:33 -0700 (PDT)
Received: from p183 ([46.53.254.83])
        by smtp.gmail.com with ESMTPSA id rl20-20020a1709076c1400b009adc81c0c7esm2830391ejc.107.2023.09.16.11.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 11:21:33 -0700 (PDT)
Date:   Sat, 16 Sep 2023 21:21:31 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] extract and use FILE_LINE macro
Message-ID: <ebf12ac4-5a61-4b12-b8b0-1253eb371332@p183>
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

Extract nifty FILE_LINE useful for printk style debugging:

	printk("%s\n", FILE_LINE);


It should not be used en mass probably because __FILE__ string literals
can be merged while FILE_LINE's won't. But for debugging it is what
the doctor ordered.

Don't add leading and trailing underscores, they're painful to type.
Trust me, I've tried both versions.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/fortify-string.h |    2 +-
 include/linux/stringify.h      |    2 ++
 include/linux/timer.h          |    3 +--
 sound/pci/asihpi/hpidebug.h    |    9 ++++-----
 4 files changed, 8 insertions(+), 8 deletions(-)

--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -643,7 +643,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 				     __q_size_field, #op),		\
 		  #op ": detected field-spanning write (size %zu) of single %s (size %zu)\n", \
 		  __fortify_size,					\
-		  "field \"" #p "\" at " __FILE__ ":" __stringify(__LINE__), \
+		  "field \"" #p "\" at " FILE_LINE,			\
 		  __p_size_field);					\
 	__underlying_##op(p, q, __fortify_size);			\
 })
--- a/include/linux/stringify.h
+++ b/include/linux/stringify.h
@@ -9,4 +9,6 @@
 #define __stringify_1(x...)	#x
 #define __stringify(x...)	__stringify_1(x)
 
+#define FILE_LINE	__FILE__ ":" __stringify(__LINE__)
+
 #endif	/* !__LINUX_STRINGIFY_H */
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -77,8 +77,7 @@ struct timer_list {
 		.entry = { .next = TIMER_ENTRY_STATIC },	\
 		.function = (_function),			\
 		.flags = (_flags),				\
-		__TIMER_LOCKDEP_MAP_INITIALIZER(		\
-			__FILE__ ":" __stringify(__LINE__))	\
+		__TIMER_LOCKDEP_MAP_INITIALIZER(FILE_LINE)	\
 	}
 
 #define DEFINE_TIMER(_name, _function)				\
--- a/sound/pci/asihpi/hpidebug.h
+++ b/sound/pci/asihpi/hpidebug.h
@@ -29,16 +29,15 @@ enum { HPI_DEBUG_LEVEL_ERROR = 0,	/* always log errors */
    the start of each message, eg see linux kernel hpios.h */
 
 #ifdef SOURCEFILE_NAME
+#undef FILE_LINE
 #define FILE_LINE  SOURCEFILE_NAME ":" __stringify(__LINE__) " "
-#else
-#define FILE_LINE  __FILE__ ":" __stringify(__LINE__) " "
 #endif
 
 #define HPI_DEBUG_ASSERT(expression) \
 	do { \
 		if (!(expression)) { \
 			printk(KERN_ERR  FILE_LINE \
-				"ASSERT " __stringify(expression)); \
+				" ASSERT " __stringify(expression)); \
 		} \
 	} while (0)
 
@@ -46,7 +45,7 @@ enum { HPI_DEBUG_LEVEL_ERROR = 0,	/* always log errors */
 	do { \
 		if (hpi_debug_level >= HPI_DEBUG_LEVEL_##level) { \
 			printk(HPI_DEBUG_FLAG_##level \
-			FILE_LINE  __VA_ARGS__); \
+			FILE_LINE " " __VA_ARGS__); \
 		} \
 	} while (0)
 
@@ -70,7 +69,7 @@ void hpi_debug_data(u16 *pdata, u32 len);
 	do { \
 		if (hpi_debug_level >= HPI_DEBUG_LEVEL_##level) { \
 			hpi_debug_message(phm, HPI_DEBUG_FLAG_##level \
-				FILE_LINE __stringify(level)); \
+				FILE_LINE " " __stringify(level)); \
 		} \
 	} while (0)
 
