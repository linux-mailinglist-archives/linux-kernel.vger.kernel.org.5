Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347597D8398
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjJZN3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjJZN3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:29:09 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A264AB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:29:07 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66d0252578aso6550486d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698326946; x=1698931746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=snTafHfsgjf8lsDX9AHXwAIrIsctXzmxm7Qr74Zy0VM=;
        b=zNWfqiOe7r2Hq1mTkgbvHS/FQkp0HcwaCfFfnLbTO3AwR4mpnR1P/+NxaYck5QaUeE
         qjA7vEpX/97tLhdh26yc5dfY+NHRRaaIb43HsnkqwW7V8zcLR2C/fFRxrPb1ClzQVhcK
         ZxLUx6/OKvmpj1S7ZFeoPc5Tlz30RcjCQbDpaNwu5J/Zj/FacrPkzfUpbegcLWPVSgTh
         5lmJSvKl4GPIs9IRYkqlgjaJv9yjY3cc1EUq6lPJvppUpCiLbUxRHptpOVYn35qfGx+x
         +GxwfpbsJOqFFldelI+YjPPNtjJZrqtlwPKSStDJAFUp0scdpHE0wnfUMmZBKrHfipdA
         qhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698326946; x=1698931746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snTafHfsgjf8lsDX9AHXwAIrIsctXzmxm7Qr74Zy0VM=;
        b=hDQnfSEeb+MEm7klTymVMFWKbPTHqf7PH+8O2yfNFfo4inqZULa9Bzn4J/ZMgNn8i4
         9g8mqrzjbMgOi/3w51VtyTbka66JYpNykw+DjKXHy3tV5YNop9i9/HZJMB2g0H5XtZcz
         rnuFqFhwmbZWIHgs7mXNEw3ozdKR5ZCPNmgsJhhq6DAZKIng0T4n1lhcJEOvtn64jHON
         XT4WS8GjkUmuotZgMQFcv19wUbfMp3l8ehGjMAyrkGdhjphPZHhyGMrfgkxGpSbhhZ1D
         w6LgbOgI0joSxuLEf14ucuP4ByXZk68kPf83RjZc14qQkwTTKRYWDdYXTFICWSSGP7uL
         vceg==
X-Gm-Message-State: AOJu0YzeaFHw66BEwzKspVZoditEjE3WTYrgxH5fKVfEQjzh86b45Sum
        pq8Ii37hRdNbVDfUx1nVrlv76Blof2V5GmLBosHMcw==
X-Google-Smtp-Source: AGHT+IH2b2WoEFwUUfYPKiMPVOobwiiT9bsutQD4He5i3Q7sIJnGoQADx8W2DOXE3LSFL26fj6KZzMS4ltE/l/MIGLA=
X-Received: by 2002:a05:6214:d8a:b0:65d:6a5:1a3f with SMTP id
 e10-20020a0562140d8a00b0065d06a51a3fmr24310498qve.43.1698326946425; Thu, 26
 Oct 2023 06:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231025083812.456916-1-glider@google.com> <ZTpYbCa0Qmry0HGH@smile.fi.intel.com>
In-Reply-To: <ZTpYbCa0Qmry0HGH@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 26 Oct 2023 15:28:25 +0200
Message-ID: <CAG_fn=Uv+ox4a1x=-w8DTU_Pj9VPh9TYhBRcDsPh+=Kc2Jsg5w@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] lib/bitmap: add bitmap_{read,write}()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >   *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to u64[] dst
> >   *  bitmap_get_value8(map, start)               Get 8bit value from map at start
> >   *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
> > + *  bitmap_read(map, start, nbits)              Read an nbits-sized value from
> > + *                                              map at start
> > + *  bitmap_write(map, value, start, nbits)      Write an nbits-sized value to
> > + *                                              map at start
>
> I still didn't get the grouping you implied with this...

Given your second reply, I can disregard this one, right?

>
> >   * Note, bitmap_zero() and bitmap_fill() operate over the region of
> >   * unsigned longs, that is, bits behind bitmap till the unsigned long
>
> ...
>
> > +/**
> > + * bitmap_read - read a value of n-bits from the memory region
> > + * @map: address to the bitmap memory region
> > + * @start: bit offset of the n-bit value
> > + * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG
> > + *
> > + * Returns: value of nbits located at the @start bit offset within the @map
> > + * memory region.
> > + *
> > + * Note: callers on 32-bit systems must be careful to not attempt reading more
> > + * than sizeof(unsigned long).
>
> sizeof() here is misleading, We talk about bits, BITS_PER_LONG (which is 32),
> here it's better to be explicit that reading more than 32 bits at a time on
> 32-bit platform will return 0. Actually what you need is to describe...
>
> > + */
> > +static inline unsigned long bitmap_read(const unsigned long *map,
> > +                                     unsigned long start,
> > +                                     unsigned long nbits)
> > +{
> > +     size_t index = BIT_WORD(start);
> > +     unsigned long offset = start % BITS_PER_LONG;
> > +     unsigned long space = BITS_PER_LONG - offset;
> > +     unsigned long value_low, value_high;
> > +
> > +     if (unlikely(!nbits || nbits > BITS_PER_LONG))
> > +             return 0;
>
> ...this return in the Return section.
>

Parameter description for @nbits actually mentions BITS_PER_LONG
already, so would it be ok to drop the Note: and extend the Returns:
section as follows:

+ * Returns: value of nbits located at the @start bit offset within the @map
+ * memory region. For @nbits = 0 and @nbits > BITS_PER_LONG the return value
+ * is undefined.

?

(Yury didn't want the zero return value to be part of the contract here).
