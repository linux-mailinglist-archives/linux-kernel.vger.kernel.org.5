Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438CA7E4E3E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjKHAtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKHAs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:48:59 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F140101;
        Tue,  7 Nov 2023 16:48:57 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc2f17ab26so47273225ad.0;
        Tue, 07 Nov 2023 16:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699404536; x=1700009336; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=18JM1b7xLIQkGXOSDK5xxBygzDFioarE6h8s0jDKM+I=;
        b=QPl3nUdv8is+Kk4ugbrBedDOj7Mk+1AFDlGy1HshYhrwEHtlO1iB1Dq5QN+GNyX7hd
         woJ0T801yr1bt1++2wU2eNLXjNOvg2rwCVmtJi/9EgsJGQtjbXtrCKhDDzo1maqBUz7E
         qlJOzn5KAIy9FH7V2cze+sVYbLn+bJuSBbPfUD+D5Xk/aPhkjnJzPvddIQY/Dpw2y4eo
         kOt0YJlA9IHFENlUhOSrbfRbIsoE97CyV5WyvVrJAFD/rHPPxaivd5INUtn2kJY7HIUk
         uPQIsDqknf5Wcq1h/1kxJS7evob4v0JyfgZg5rxSKyRxPOY6CLhKELmC6ZzmRH3u3GbR
         hPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699404536; x=1700009336;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18JM1b7xLIQkGXOSDK5xxBygzDFioarE6h8s0jDKM+I=;
        b=UYRXZ60bY6TgvS5/D3hPeBvff2XuVSuPSJmIDeUbFeRZX1/+c2Vlh78L7AeRAUa/SN
         +cOgUXXTs/sdQ2faratW2Q+wfwg/N7NlY+dDwmQ5Cbh77LFloRJf6I6R2x1nHmXeOs6y
         m+JLGsXbKuEI/JLeEC0Gsi8M/kKevQEITbtprjbkz8r75DzF+iUKTROP4Yr30gu+3ygp
         bLlgcAhpL8YY60h7yGauYUm6vG+ReoDKU1lZi0NYrlQHPnuxrTrZYNKIKCQiPzk2yEt4
         Vj/Ix+AkVTBzIWaeD0ywB7IXSuUuFKcpkaAmu9B99hfx7jaLgjLn+0QSo8gerCF2Ly0i
         11FQ==
X-Gm-Message-State: AOJu0Yw2mgLYOhipJJjOuxU66Aew4B9wlU2LT59AfJo4BatA8n9AnXeA
        N3LTdqzXpnwSS+BUYIuv5UI=
X-Google-Smtp-Source: AGHT+IG96hzG2AKirC4O7eyjqxCTKaKtvWQtVmb+bCuNcRu92pj6zIRSFuqq8E0AYCSe+LCImFmTIQ==
X-Received: by 2002:a17:902:f806:b0:1ca:3e40:beae with SMTP id ix6-20020a170902f80600b001ca3e40beaemr658898plb.38.1699404536433;
        Tue, 07 Nov 2023 16:48:56 -0800 (PST)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id k18-20020a170902c41200b001cc41059a11sm405990plk.196.2023.11.07.16.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 16:48:56 -0800 (PST)
Date:   Tue, 7 Nov 2023 16:48:51 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev, linux-hardening@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [alobakin:pfcp 11/19] include/linux/bitmap.h:642:17: warning:
 array subscript [1, 1024] is outside array bounds of 'long unsigned int[1]'
Message-ID: <ZUra8/56s5ozTayN@yury-ThinkPad>
References: <202310170708.fJzLlgDM-lkp@intel.com>
 <bd7fe929-c6fc-42be-9d2f-3f53ec21fd10@intel.com>
 <ZUkvOCxyiin_77qd@smile.fi.intel.com>
 <0a29df6b-bc27-43e9-a97d-57ecabb29a9e@intel.com>
 <CAG_fn=VtA6e3oGm4WVnxmy9yMBab780-U_4VoHSqm4tcd2UTzQ@mail.gmail.com>
 <ca0ad357-727b-4f41-a3d6-2c48a9dd5836@intel.com>
 <202311071521.099CAEA58@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202311071521.099CAEA58@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 03:25:01PM -0800, Kees Cook wrote:
> On Tue, Nov 07, 2023 at 05:44:00PM +0100, Alexander Lobakin wrote:
> > From: Alexander Potapenko <glider@google.com>
> > Date: Tue, 7 Nov 2023 17:33:56 +0100
> > 
> > > On Tue, Nov 7, 2023 at 2:23 PM Alexander Lobakin
> > > <aleksander.lobakin@intel.com> wrote:
> > >>
> > >> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >> Date: Mon, 6 Nov 2023 20:23:52 +0200
> > >>
> > >>> On Mon, Nov 06, 2023 at 05:31:34PM +0100, Alexander Lobakin wrote:
> > >>>
> > >>>>> | Reported-by: kernel test robot <lkp@intel.com>
> > >>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202310170708.fJzLlgDM-lkp@intel.com/
> > >>>
> > >>>> Not sure how to approach this :z It was also captured on the version you
> > >>>> sent 2 weeks ago, so this could've been resolved already.
> > >>>
> > >>> Is it in the repository already? if so, we should revert it.
> > >>> Otherwise you have time to think and fix.
> > >>
> > >> Nah, neither Alex' series nor mine. And I'd say this should rather be
> > >> resolved in the functions Alex introduce.
> > >>
> > >> Thanks,
> > >> Olek
> > > 
> > > Sorry, I couldn't reproduce the problem using the instructions at
> > > https://download.01.org/0day-ci/archive/20231017/202310170708.fJzLlgDM-lkp@intel.com/reproduce
> > > locally, maybe that's because I only have gcc-11 and higher.
> > > 
> > > But if I'm understanding correctly what's going on, then GCC will be
> > > reporting the same issue in the following code:
> > > 
> > > =======================================================
> > > #include <stddef.h>
> > > #include <stdbool.h>
> > > 
> > > #define BITS_PER_LONG 64
> > > #define unlikely(x) x
> > > #define UL(x) (x##UL)
> > > #define GENMASK(h, l) \
> > >         (((~UL(0)) - (UL(1) << (l)) + 1) & \
> > >          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
> > > 
> > > #define BIT_WORD(nr)            ((nr) / BITS_PER_LONG)
> > > #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
> > > #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
> > > 
> > > inline void bitmap_write(unsigned long *map,
> > >                                 unsigned long value,
> > >                                 unsigned long start, unsigned long nbits)
> > > {
> > >         size_t index;
> > >         unsigned long offset;
> > >         unsigned long space;
> > >         unsigned long mask;
> > >         bool fit;
> > > 
> > >         if (unlikely(!nbits))
> > >                 return;
> > > 
> > >         mask = BITMAP_LAST_WORD_MASK(nbits);
> > >         value &= mask;
> > >         offset = start % BITS_PER_LONG;
> > >         space = BITS_PER_LONG - offset;
> > >         fit = space >= nbits;
> > >         index = BIT_WORD(start);
> > > 
> > >         map[index] &= (fit ? (~(mask << offset)) :
> > > ~BITMAP_FIRST_WORD_MASK(start));
> > >         map[index] |= value << offset;
> > >         if (fit)
> > >                 return;
> > > 
> > >         map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
> > >         map[index + 1] |= (value >> space);
> > > }
> > > 
> > > unsigned long foo(unsigned int n) {
> > >     unsigned long bm[1] = {0};
> > >     bitmap_write(bm, 1, n, 2);
> > >     return bm[0];
> > > }
> > > =======================================================
> > > (see also https://godbolt.org/z/GfGfYje53)
> > > 
> > > If so, the problem is not specific to GCC 9, trunk GCC also barks on this code:
> > > 
> > > =======================================================
> > > In function 'bitmap_write',
> > >     inlined from 'bitmap_write' at <source>:15:13,
> > >     inlined from 'foo' at <source>:47:7:
> > > <source>:40:12: warning: array subscript 1 is outside array bounds of
> > > 'long unsigned int[1]' [-Warray-bounds=]
> > >    40 |         map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
> > >       |         ~~~^~~~~~~~~~~
> > > =======================================================
> > > 
> > > If this is true for the code in drivers/gpio/gpio-pca953x.c,
> > > suppressing the report for GCC 9 won't help for other versions.
> > > Given that this report is isolated in a single file, we probably need
> > 
> > I tested it on GCC 9 using modified make.cross from lkp and it triggers
> > on one more file:
> > 
> > drivers/thermal/intel/intel_soc_dts_iosf.c: In function 'sys_get_curr_temp':
> > ./include/linux/bitmap.h:601:18: error: array subscript [1,
> > 288230376151711744] is outside array bounds of 'long unsigned int[1]'
> > [-Werror=array-bounds]
> > 
> > > to give the compiler some hints about the range of values passed to
> > > bitmap_write() rather than suppressing the optimizations.
> > 
> > OPTIMIZER_HIDE_VAR() doesn't disable optimizations if I get it
> > correctly, rather shuts up the compiler in cases like this one.
> > 
> > I've been thinking of using __member_size() from fortify-string.h, we
> > could probably optimize the object code even a bit more while silencing
> > this warning.
> > Adding Kees, maybe he'd like to participate in sorting this out as well.
> 
> I'm trying to find all the pieces for this code, so I might be working
> from the wrong version or something, but I think this is the change:
> https://github.com/alobakin/linux/commit/66808fb20fed014a522b868322d54daef14a6bd8

This is the series:

https://www.spinics.net/lists/kernel/msg4985590.html

The relevant part of the function is:

+	offset = start % BITS_PER_LONG;
+	space = BITS_PER_LONG - offset;
+	fit = space >= nbits; // true if offset + nbits <= BITS_PER_LONG
+	index = BIT_WORD(start);
+
+	map[index] &= XXX;
+	map[index] |= value << offset;
+	if (fit)
+		return;
+
+	map[index + 1] = YYY;
 
Some background for you:

'fit' means that the requested part of bitmap fits into a single
machine word. For example, on 64-bit machine:

        DECLARE_BITMAP(map, 64); // unsigned long val[1];
        bitmap_write(map, val, 60, 4) // fit == true
        bitmap_write(map, val, 60, 8) // fit == false

It's possible that user may overrun the array boundary, like in the
2nd case, and compiler may correctly warn about it.

But in this case...

The code in question is:

        #define bitmap_set_value8(map, value, start)           \
                bitmap_write(map, value, start, BITS_PER_BYTE)
        #define BANK_SZ 8

        for (i = 0; i < NBANK(chip); i++)
                bitmap_set_value8(val, value[i], i * BANK_SZ);

Here nbits is always 8, and start is multiple of 8. With that, we're
always writing into a single word (fit == true), and 'idx + 1' path
is never hit. This makes me think that it the warning here is false
positive. Is that correct?

> and the induced warning is correctly analyzed in this thread (i.e. GCC
> can't convince itself that it'll never reach the out of bounds access).
> Does this work?
> 
> -	if (fit)
> +	if (fit || index + 1 >= __member_size(map))
>  		return;

I already commented this in the other email in this thread - this would
silence a true warning where people break the boundary:

        bitmap_write(map, val, 60, 8);

And as far as I can see, __member_size() implies some runtime
overhead, which I'd like to avoid.

Thanks,
Yury

