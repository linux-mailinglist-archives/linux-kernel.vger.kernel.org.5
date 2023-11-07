Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F947E3FF9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbjKGNW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjKGNW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:22:27 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B0C92
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:22:24 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-5845213c583so2891379eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 05:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699363344; x=1699968144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VY4YJsEGOak3+/jF/9NUyuTCsmVfDICPRDm+qZKQykI=;
        b=Z+Fe6MINMkraoRHXrzTqjtRJIhzHlMcYjUHqHnnqJQASBHSTTQD7dXSmmppC9p5Qad
         Bbfiqarz4orA5B8COLI+jhLkXOjTEb/ry8nvQSdsAs502rN8dn8F6nSd1Z++6FGYSKis
         PidcR08VWHIJRVmIuRGC2YQ50d6GX3JV6eqa2VEfBcDNf6ZrMKefZz6TJExR7hOUm4zO
         kdhszac+Fy/tw/SBcjVmp4qfF+MermmYmliSqmtJJc+L5Ay0no9c1ZGzCHaU65WqfOOf
         ZegGe0HqhcsGZBwaRsGQ9rPun/iMg6s8cZ/mKbEFRrzR4zxmNX5zoohEGiHT1T+6bxme
         BT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699363344; x=1699968144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VY4YJsEGOak3+/jF/9NUyuTCsmVfDICPRDm+qZKQykI=;
        b=YKJkWHsHzqPlUIkTQXd8L8wSyq5IkJtxlPsA8XjROkRvwJRWpxPd+S/4kM/QqH2L/G
         Ob52SqgkSdUpjjsiz0a9Xc6cmY9SYby0PS5OfLNO+YNecENDhVPoo8hJgM1Hv7f4PFlU
         VdeLzzcaEpyAWaiXqQOl+gWGHnNVpzxh6xzL9jLwEKwvXrrAsai7bLg9u0gJJSShxTGg
         fDJ4vOCYHSms6bwhX/m5RqGa7yRspvqRe+oDMZCCgG8cKmLcPowUgy51jFIQi1aR78LB
         8GHVA3uHgljXD+C/yhTp3qo1Ni9qJRsyRWo+ApVlZhPYolA14jN7DWBMov5Y4w+CVhjT
         Z+jw==
X-Gm-Message-State: AOJu0Yyj/QZQ5Z4ZeOG5GoO9igO1W8UULRbKWA0WR3nxbDcxBPKo0rEi
        t98kzaludxbcsQUybvy3xdY=
X-Google-Smtp-Source: AGHT+IFT7Oy9WktgHsiKgbgYbIMS3nEk8quzxpemI7iwlASDHcKTkrP6mUS9D/07NTWddfCN0l1X7Q==
X-Received: by 2002:a05:6358:918e:b0:16b:55bf:9ab0 with SMTP id j14-20020a056358918e00b0016b55bf9ab0mr11992003rwa.8.1699363343685;
        Tue, 07 Nov 2023 05:22:23 -0800 (PST)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id x8-20020a631708000000b00578afd8e012sm1353304pgl.92.2023.11.07.05.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:22:23 -0800 (PST)
Date:   Tue, 7 Nov 2023 05:22:20 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [alobakin:pfcp 11/19] include/linux/bitmap.h:642:17: warning:
 array subscript [1, 1024] is outside array bounds of 'long unsigned int[1]'
Message-ID: <ZUo6DLwy5FoDkZlX@yury-ThinkPad>
References: <202310170708.fJzLlgDM-lkp@intel.com>
 <bd7fe929-c6fc-42be-9d2f-3f53ec21fd10@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd7fe929-c6fc-42be-9d2f-3f53ec21fd10@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 05:31:34PM +0100, Alexander Lobakin wrote:
> BTW, I have this in my inbox:
> 
> From: Kernel Test Robot <lkp@intel.com>
> Date: Tue, 17 Oct 2023 08:14:51 +0800
> 
> > tree:   https://github.com/alobakin/linux pfcp
> > head:   9183a3eb639912169a3d3e2be4f25556b465919b
> > commit: c8a652cdcc0964510f108726b3da0784d1bc0cd2 [11/19] bitmap: make bitmap_{get,set}_value8() use bitmap_{read,write}()
> 
> So it happened after I converted bitmap_{get,set}_value8() so that they
> use bitmap_{read,write}().
> 
> > config: x86_64-randconfig-004-20231017 (https://download.01.org/0day-ci/archive/20231017/202310170708.fJzLlgDM-lkp@intel.com/config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310170708.fJzLlgDM-lkp@intel.com/reproduce)

[...]
 
> >      643 |  map[index + 1] |= (value >> space);
> >          |                 ^~
> >    In file included from include/linux/kasan-checks.h:5,
> >                     from include/asm-generic/rwonce.h:26,
> >                     from ./arch/x86/include/generated/asm/rwonce.h:1,
> >                     from include/linux/compiler.h:246,
> >                     from include/linux/build_bug.h:5,
> >                     from include/linux/bits.h:21,
> >                     from include/linux/ioport.h:13,
> >                     from include/linux/acpi.h:12,
> >                     from drivers/gpio/gpio-pca953x.c:11:
> >    drivers/gpio/gpio-pca953x.c:1032:17: note: while referencing 'val'

It looks like a gcc-9 false-positive. I tried gcc-12 and gcc-13, and
they both looks OK. Below is the fix that works for me.

Can you please test the following patch and add it to your series?

Thanks,
        Yury

From 2a883221ddbd18796ddef0125e9e3022a56edd7b Mon Sep 17 00:00:00 2001
From: Yury Norov <yury.norov@gmail.com>
Date: Tue, 7 Nov 2023 05:05:17 -0800
Subject: [PATCH] bitmap: suppress false-positive -Warray-bounds in
 bitmap_{read,write}

bitmap_{read,write} conditionally accesses map[index + 1], carefully
checking before that it's a safe dereference. But still, gcc-9 emits
-Warray-bounds.

Gcc-12 and gcc-13 are both OK with this code. So fix it for gcc-9 with
OPTIMIZER_HIDE_VAR().

Reported-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310170708.fJzLlgDM-lkp@intel.com/
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 945a680816cc..0b1a07ff1080 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -592,6 +592,11 @@ static inline unsigned long bitmap_read(const unsigned long *map,
 	if (unlikely(!nbits || nbits > BITS_PER_LONG))
 		return 0;
 
+#if CONFIG_GCC_VERSION < 100000
+	/* Suppress gcc-9 false-positive -Warray-bounds */
+	OPTIMIZER_HIDE_VAR(map);
+#endif
+
 	if (space >= nbits)
 		return (map[index] >> offset) & BITMAP_LAST_WORD_MASK(nbits);
 
@@ -634,6 +639,11 @@ static inline void bitmap_write(unsigned long *map, unsigned long value,
 	fit = space >= nbits;
 	index = BIT_WORD(start);
 
+#if CONFIG_GCC_VERSION < 100000
+	/* Suppress gcc-9 false-positive -Warray-bounds */
+	OPTIMIZER_HIDE_VAR(map);
+#endif
+
 	map[index] &= (fit ? (~(mask << offset)) : ~BITMAP_FIRST_WORD_MASK(start));
 	map[index] |= value << offset;
 	if (fit)
-- 
2.39.2

