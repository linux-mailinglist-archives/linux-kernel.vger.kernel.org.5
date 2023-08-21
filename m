Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0B278303A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbjHUSYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjHUSYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:24:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D71CA1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:24:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68a41035828so1024046b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692642253; x=1693247053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=seteuGpcBse2ip/YWMi7ds+57ad0gDSrYe5f4YnZVwA=;
        b=EndZbmweDApqZ/7xY3TyeqW3K1mvn5GqL2Mpb1c6mYZVYGVgeLLj624SvOOy2iUSlN
         fXh9sXUPABvWqDHvb2mNV2wofRuVmASgqFIN74FEcJ4xq0Ur0ATsSXDGD/DqN7w5jtuY
         v6W628ybxPyQq4ck8z748yG3ehFOvCOwsPd04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692642253; x=1693247053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seteuGpcBse2ip/YWMi7ds+57ad0gDSrYe5f4YnZVwA=;
        b=F89UzSacbsSABxQCpydGNxJYMDDm19VTVOs+aKs3zbwv2L2+27yrFn9hbU8Mv7o4Jp
         kvH9lPkOER3WdGWlIjEC6fca2uEsP8T4P3H0VqcquGYUEg/nz3y2ug6QBtVoRE5BmtSR
         mUTHVCaDeTECOFFaMKXpr17JRq9jueFOO1mrslLO/hUlR3G2c6iZkChTj6ueYUZbq/G2
         hXepW7RkYME8MLszI4z9LlYN26SBQN118gVo0RXhEmyGnjhQjz+N+3TJ1nLgAWggkAyk
         40qlWdhT4bNf46d1YOgTh+oAUBle9KvnXcGTZVlKfjxQvejrkxmGTph2bUKallnmbu+n
         3z7Q==
X-Gm-Message-State: AOJu0YxBq1udXyeeG4u633llzqKn3eSyB0qYndwKvag5+/1INSUM9QeH
        DJDYUeWv83rdVjjLjGshdDQVf96tnoUUgLBtoco=
X-Google-Smtp-Source: AGHT+IFkxHViApiX6n76q1N/c/QZV5gsdueKxegzHv2e5VSFHU2BW9oPDCMi2Q+JdMtTxK2f09ac0A==
X-Received: by 2002:aa7:888f:0:b0:687:82a4:49f8 with SMTP id z15-20020aa7888f000000b0068782a449f8mr6041955pfe.30.1692642253578;
        Mon, 21 Aug 2023 11:24:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q15-20020a63ae0f000000b00563ff7d9c4bsm6696945pgf.73.2023.08.21.11.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:24:12 -0700 (PDT)
Date:   Mon, 21 Aug 2023 11:24:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH next v3 0/5] minmax: Relax type checks in min() and max().
Message-ID: <202308211113.4F49E73109@keescook>
References: <01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com>
 <202308141416.89AC5C2@keescook>
 <2dd09c4033644239a314247e635fa735@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dd09c4033644239a314247e635fa735@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 08:55:55AM +0000, David Laight wrote:
> From: Kees Cook
> > Sent: 14 August 2023 22:21
> > 
> > On Fri, Aug 04, 2023 at 10:50:59AM +0000, David Laight wrote:
> > > [...]
> > > I also suspect that many of the min_t(u16, ...) are actually wrong.
> > > For example copy_data() in printk_ringbuffer.c contains:
> > >         data_size = min_t(u16, buf_size, len);
> > > Here buf_size is 'unsigned int' and len 'u16', pass a 64k buffer
> > > (can you prove that doesn't happen?) and no data is returned.
> > 
> > Stars aligning... this exact bug (as you saw in the other thread[1]) got
> > hit. And in the analysis, I came to the same conclusion: min_t() is a
> > serious foot-gun, and we should be able to make min() Just Work in the
> > most common situations.
> 
> It is all a question of what 'work' means.
> To my mind (but Linus disagrees!) the only problematic case
> is where a negative signed value gets converted to a large
> unsigned value.
> This snippet from do_tcp_getsockopt() shows what I mean:
> 
> 	copy_from_user(&len,...)
> 	len = min_t(unsigned int, len, sizeof(int));
> 
> 	if (len < 0)
> 		return -EINVAL;
> 
> That can clearly never return -EINVAL.
> That has actually been broken since the test was added in 2.4.4.
> That predates min_t() in 2.4.10 (renamed from min() in 2.4.9
> when the 'strict typecheck' version on min() was added).
> So min_t() actually predates min()!
> 
> > It seems like the existing type_max/type_min macros could be used to
> > figure out that the args are safe to appropriately automatically cast,
> > etc. e.g. type_max(u16) <= type_max(unsigned int) && type_min(u16) >=
> > type_min(unsigned int) ...
> 
> That doesn't really help; min(a,b) is ok if any of:
> 1) is_signed(a) == is_signed(b).
> 2) is_signed(a + 0) == is_signed(b + 0)  // Converts char/short to int.
> 3) a or b is a constant between 0 and MAXINT and is cast to int.
> 
> The one you found passes (1) - both types are unsigned.
> min(len, sizeof (int)) passes (3) and is converted to
> min(len, (int)sizeof (int)) and can still return the expected negatives.

It seems like the foot-gun problems are when a value gets clamped by the
imposed type. Can't we just warn about those cases?

For example:

	int a = ...;
	unsigned int b = ...;
	int c = min_t(unsigned int, a, b);

This is goes bad when "a < 0". And it violates your case (1) above.

But this is also unsafe:

	unsigned int a = ...;
        u16 b = ...;
	unsigned int c = min_t(u16, a, b);

Both are unsigned, but "a > U16_MAX" still goes sideways.

I worry that weakening the min/max() type checking gets into silent errors:

	unsigned int a = ...;
        u16 b = ...;
	u16 c = max(a, b);

when "a > U16_MAX".

Looking at warning about clamped types on min_t(), though I see tons of
int vs unsigned int issue. (e.g. dealing with PAGE_SIZE vs an int).

-Kees

-- 
Kees Cook
