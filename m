Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592347B2636
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjI1UCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjI1UCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:02:10 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A90C193
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:02:08 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57b5f0d658dso6668273eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695931327; x=1696536127; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0V247y8yeLoBjWDsuqch/JlEyLUSRAVzGZC74cFQUw8=;
        b=Gtd/uqYFdfbnnkqe7bPqN3jvk9AtZdismsRhWA0B1AVjC/3yrjP4KJqt9cBBOaZVgd
         1ff9QA6X4sxI/NU8YmWOK3PXY1TVklQm4G6uhYNPBRBK85cif9pWR7+eLtRrXOrVgVKk
         JzIGTWBAgDB7ybyk+QVq+071Vm5q5/ZUOHDoTYENO5hyPrpX2rUAxL4RZigX58cssnuC
         aUsNWh1wAOYlSaUaT7RPWz1JlwAh7QLrinyMT9tr+C3ciJDtaZxgn43MWJBMlSKJwfqi
         CNeF5qvdJJgy8VAUoexU6s3RCaqR2h4avDxfL+jwCx05RKLudMUDq9m32nlV9yyOan0r
         9OQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695931327; x=1696536127;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0V247y8yeLoBjWDsuqch/JlEyLUSRAVzGZC74cFQUw8=;
        b=kxn3lBk9kOjubPhLckUgWnrryDnfsspYzXwy5gM70bE30asCSUUwXelOKB4b/VVkep
         jPE+eGwF+27bSc5g1yxs5dTeVzBW3wP2ZNOSO9+2N7eotAQPx4AgUaNGtFtncDSsog6W
         JasXevtF9EpKUWlDhdlPssa/LjU2/V3Mkix/HeoRZsidTvBjtPF7V16+PaPO+i85ivfP
         TeErQj3XXmj4SSPNtWWaZIRQAtueKqm1+NEpdDmoiZ0462p0cZfQkAnUgVOQz9nti60z
         v3EoBf293I95di7WmQEHd2Wk0InzXDtkq8zdnKnSCR81MHd506tztRGppkQSSOa7FZCd
         j4Zw==
X-Gm-Message-State: AOJu0YzEd/VwDBY1BJj/aiv7jCway7jKL4Fsszw+rFlm0Ftp7N+pausc
        kTvT1CZfOvYEjby2il10yy8=
X-Google-Smtp-Source: AGHT+IF33Ob533HQwv9+K0z/hvoiedzYKpGG5mNhW5Qso0gt8HHPBZK6D5+ab++F8DIMh63M1yfaIg==
X-Received: by 2002:a05:6358:3406:b0:141:d2d:6da7 with SMTP id h6-20020a056358340600b001410d2d6da7mr2291314rwd.17.1695931327490;
        Thu, 28 Sep 2023 13:02:07 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id p19-20020a639513000000b00578afd8e012sm12517132pgd.92.2023.09.28.13.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 13:02:07 -0700 (PDT)
Date:   Thu, 28 Sep 2023 12:59:54 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, pcc@google.com,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        eugenis@google.com, Syed Nayyar Waris <syednwaris@gmail.com>,
        william.gray@linaro.org
Subject: Re: [PATCH v5 2/5] lib/test_bitmap: add tests for
 bitmap_{read,write}()
Message-ID: <ZRXbOoKHHafCWQCW@yury-ThinkPad>
References: <20230922080848.1261487-1-glider@google.com>
 <20230922080848.1261487-3-glider@google.com>
 <CAG_fn=UeFoyhZvPJ7pGPrc5011D9h1e4ioffat4eUfVHP6Hd-Q@mail.gmail.com>
 <ZRF7r0ZjxcL9C8U8@smile.fi.intel.com>
 <CAG_fn=V8Mx89dOfKf88nEq9V9i_kMYaOdGjd3DQVOWnYrandyA@mail.gmail.com>
 <CAG_fn=WX+yAFHtbsxSvd41P61jjWtFEePqOs_1AKGJcgaWfVag@mail.gmail.com>
 <3bc8fda47dc04e3b8cfd0e3f6fc7bbee@AcuMS.aculab.com>
 <CAG_fn=XCXYZhC+ER5mhMyE2YD-__1oj+uvPB4pyz4X7tmiq=3w@mail.gmail.com>
 <CAAH8bW-9ZWB=i0RWAWBXguOkguLHZGp7fLg7An73NqFnVmtgFw@mail.gmail.com>
 <CAG_fn=UWJ30ATV0mruPm__+qcuqB9yieMsG_EiFcmty_MZyEqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=UWJ30ATV0mruPm__+qcuqB9yieMsG_EiFcmty_MZyEqQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 05:14:55PM +0200, Alexander Potapenko wrote:
> On Thu, Sep 28, 2023 at 4:43 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> >
> >
> > On Thu, Sep 28, 2023, 10:20 AM Alexander Potapenko <glider@google.com> wrote:
> >>
> >> On Wed, Sep 27, 2023 at 9:51 AM David Laight <David.Laight@aculab.com> wrote:
> >> >
> >> > ...
> >> > > Overall, unless allocating and initializing bitmaps with size
> >> > > divisible by sizeof(long), most of bitmap.c is undefined behavior, so
> >> > > I don't think it makes much sense to specifically test this case here
> >> > > (given that we do not extend bitmap_equal() in the patch set).
> >> >
> >> > Bitmaps are arrays of unsigned long.
> >> > Using any of the APIs on anything else is a bug.
> >> > So it is always wrong to try to initialise 'a number of bytes'.
> >> > The size used in the definition need not be a multiple of 8 (on 64bit)
> >> > but the allocated data is always a multiple of 8.
> >> >
> >> > Any calls to the functions that have a cast of the bitmap
> >> > parameter are likely to be buggy.
> >> > And yes, there are loads of them, and many are buggy.
> >>
> >> I got rid of the casts in the bitmap test, but they remain in
> >> mtecomp.c, where 16-, 32-, 64-byte buffers allocated by
> >> kmem_cache_alloc() are treated as bitmaps:
> >> https://lore.kernel.org/linux-arm-kernel/20230922080848.1261487-6-glider@google.com/T/#mdb0d636d2d357f8ffe6ac79cef1145df3440f659
> >>
> >> Having them allocated by bitmap_alloc() won't work, because on Android
> >> bitmap_alloc() will allocate the buffers from the kmalloc-64 cache,
> >> defeating the purpose of the compression.
> >>
> >> Would it be better to extend the bitmap.h API so that it is possible
> >> to allocate from a kmem cache (which would in turn require
> >> bitmap_kmem_cache_create() to ensure the alignment requirements)?
> >
> >
> > So all that is wrong then. Bad on me, I'd spend more time looking into your driver code...
> >
> > We already have bitmap_(from,to)_u(64,32),
> > And you can use them. For 16-bit you have to add helpers yourself. But it's not a rocket science.
> >
> 
> So e.g. for compressing something into a 16-byte buffer using bitmaps
> I'd need to:
> 
> 1) Allocate the buffer: buf = kmem_cache_alloc(...)
> 2) Allocate the bitmap: bitmap = bitmap_alloc(16*8, ...)
> 3) Fill the bitmap: mte_compress_to_buf(..., bitmap, 16)
> 4) Copy the bitmap contents to the buffer: bitmap_to_arr64(buf, bitmap, 16*8)
> 5) Deallocate the bitmap: bitmap_free(bitmap)
> 
> instead of:
> 
> buf = kmem_cache_alloc(...)
> mte_compress_to_buf(..., (unsigned long *)buf, 16)
> 
> , correct?
> 
> Given that the buffer contents are opaque and its size is aligned on 8
> bytes, could it be possible to somehow adopt the `buf` pointer
> instead?

I didn't find an explicit typecasting where you're using
mte_compress_to_buf(), but now after hard 2nd look I see...

Firstly, now that in the documentation you are explicitly describing the
return value of mte_compress() as 64-bit frame, the right way to go would
be declaring the function as: u64 mte_compress(u8 *tags).

And the general pattern should be like this:

  unsigned long mte_compress(u8 *tags)
  {
          DECLARE_BITMAP(tmp, MTECOMP_CACHES_MAXBITS);
          void *storage;
          ...
          if (alloc_size < MTE_PAGE_TAG_STORAGE) {
                  storage = kmem_cache_alloc(cache, GFP_KERNEL);
                  mte_compress_to_buf(r_len, r_tags, r_sizes, tmp, alloc_size);
        
                  switch (alloc_size) {
                  case 16:
                          bitmap_to_arr16(storage, tmp, 16);
                          break;
                  case 32:
                          bitmap_to_arr32(storage, tmp, 32);
                          break;
                  case 64:
                          bitmap_to_arr64(storage, tmp, 64);
                          break;
                  default:
                          pr_err("error\n");
                  }
                  result = ((u64)storage | cache_id) & MTE_HANDLE_MASK;
                  goto ret;
          }
          ...
  }
        
Yeah, it looks cumbersome, but this is the right way to go if you need a
reliable BE-compatible driver. I think it will be less scary if you wrap
the switch with a helper, and/or move it inside mte_compress_to_buf(),
so that the mte_compress will stay unchanged.

Anyways, hope the above helped.

Thanks,
Yury
