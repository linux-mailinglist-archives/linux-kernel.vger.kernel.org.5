Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1240D81187A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442409AbjLMP71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjLMP7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:59:25 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83971B9;
        Wed, 13 Dec 2023 07:59:31 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5c69ecda229so3832304a12.2;
        Wed, 13 Dec 2023 07:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702483171; x=1703087971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7t/IBYcxcZn26VUq/ox2cXPfMGFXBFP5p9RWCWJmVpc=;
        b=GRks4ymibZjMCnNx4IXOuj1gAk9a9/3caOiYPW3xutT+k6MLfnXRBw59xfV+H/Wmtx
         gQh+HGHBHN42vO8C5TPiDSTuuA+nXuYPfW3zJrEyKdmsgfOvidZmN+pZiZj6RrhOleKK
         EAOwAWxWaUNPmCoo2sbSOfPPleaFZMmOJgbZxr5hd6d+HoLVtxzU6bDT7o5EzxsPDnvD
         /Td+8tTYnMw9nUDJ2bW/9XJtJlOPkpwCpXlkKfMN2wEka/neZ6JHfQWRZrYnH6yhx+Qa
         RQ2viOUH7nkM9LpfvY4I6VnN8eZZUkTJidMxXMqAuAtLjWp75M/58SUDfDkj6aY0BKXH
         ezLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702483171; x=1703087971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7t/IBYcxcZn26VUq/ox2cXPfMGFXBFP5p9RWCWJmVpc=;
        b=JtVK++99kOLnmPWRcynhbYccoeYOJuun7HbudsCPG8RvZn6cqsyspFzRHJrLQ21Lvb
         GZFZ8wzjti5rG2pf5urttMzBxI9/M8MuqjfhuDHD9Dd0h+QcHlPFAxOYgjcr9BnAl45J
         c/KkINXtWnAhrOToImlzUQEvndP0FfIAeDBTgyBnVQ6jzE4vwicgdCHE20cym5F7Prsn
         muOaJUuT9jtH961M1h2CoOUg+xMreNV9jxeU2a1NuZiyFSXxMTSdjpbauxHxxL8gOTy3
         cNn5l3KNZLcZpnk3o6hTAH2sk23GXA28FIYOF9zybji6LaGkKlTJmemrzLzOEomRtsUy
         GP/w==
X-Gm-Message-State: AOJu0Yzs7P41xzgx1OZJ5pyj5K0BjDNyQW7/f6SmgrjuzrvtGWVvjOiH
        zQdl2N+cERDvH4R6e02XdFQ=
X-Google-Smtp-Source: AGHT+IH3WNLtvYo6YQYwxojy0A3ep03IXCsjYXYhamREgqphSx+qRQgqXiVYHrKZpGfCHAlB+J3ZfA==
X-Received: by 2002:a05:6a20:daa1:b0:18f:97c:9262 with SMTP id iy33-20020a056a20daa100b0018f097c9262mr5236339pzb.71.1702483170840;
        Wed, 13 Dec 2023 07:59:30 -0800 (PST)
Received: from rigel (194-223-186-106.tpgi.com.au. [194.223.186.106])
        by smtp.gmail.com with ESMTPSA id c10-20020a62f84a000000b006d0d83a11c9sm1074841pfm.202.2023.12.13.07.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:59:30 -0800 (PST)
Date:   Wed, 13 Dec 2023 23:59:26 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH 1/4] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
Message-ID: <ZXnU3tMYCc2Rw8Qv@rigel>
References: <20231212054253.50094-1-warthog618@gmail.com>
 <20231212054253.50094-2-warthog618@gmail.com>
 <ZXm3rayrcvfO1t1Z@smile.fi.intel.com>
 <ZXm_WsIpgIyOUNHt@rigel>
 <CAMRc=Mfri8K4ZqcHb_eQY6gi+q_-uBZc2wiMrrb-+a7Tric3FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mfri8K4ZqcHb_eQY6gi+q_-uBZc2wiMrrb-+a7Tric3FA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 04:40:12PM +0100, Bartosz Golaszewski wrote:
> On Wed, Dec 13, 2023 at 3:27 PM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Wed, Dec 13, 2023 at 03:54:53PM +0200, Andy Shevchenko wrote:
> > > On Tue, Dec 12, 2023 at 01:42:50PM +0800, Kent Gibson wrote:
> > > > Store the debounce period for a requested line locally, rather than in
> > > > the debounce_period_us field in the gpiolib struct gpio_desc.
> > > >
> > > > Add a global tree of lines containing supplemental line information
> > > > to make the debounce period available to be reported by the
> > > > GPIO_V2_GET_LINEINFO_IOCTL and the line change notifier.
> > >
> > > ...
> > >
> > > >  struct line {
> > > >     struct gpio_desc *desc;
> > > > +   struct rb_node node;
> > >
> > > If you swap them, would it benefit in a code generation (bloat-o-meter)?
> > >
> >
> > Didn't consider that placement within the scruct could impact code
> > generation.
> > Having the rb_nodes at the beginning of struct is preferable?
> >
>
> I suppose it has something to do with 0 offset when using
> container_of(). Not sure if that really matters though.
>

There are other fields that get the container_of() treatment, but node
does look to be the one most used, so probably makes sense to put it
first.

> > > >  };
> > >
> > > ...
> > >
> > > > +struct supinfo {
> > > > +   spinlock_t lock;
> > > > +   struct rb_root tree;
> > > > +};
> > >
> > > Same Q.
> > >
> >
> > Same - I tend to put locks before the field(s) they cover.
> > But if the node being first results in nicer code then happy to swap.
> >
> > > ...
> > >
> > > > +static struct supinfo supinfo;
> > >
> > > Why supinfo should be a struct to begin with? Seems to me as an unneeded
> > > complication.
> > >
>
> I think we should keep it as a struct but defined the following way:
>
> struct {
>     spinlock_t lock;
>     struct rb_root tree;
> } supinfo;

That is what I meant be merging the struct definition with the variable
definition.  Or is there some other way to completely do away with the
struct that I'm missing?

> >
> > Yeah, that is a hangover from an earlier iteration where supinfo was
> > contained in other object rather than being a global.
> > Could merge the struct definition into the variable now.
> >
> > > ...
> > >
> > > > +                   pr_warn("%s: duplicate line inserted\n", __func__);
> > >
> > > I hope at bare minimum we have pr_fmt(), but even though this is poor message
> > > that might require some information about exact duplication (GPIO chip label /
> > > name, line number, etc). Generally speaking the __func__ in non-debug messages
> > > _usually_ is a symptom of poorly written message.
> > >
> > > ...
> >
> > Yeah, I wasn't sure about the best way to log here.
> >
> > The details of chip or line etc don't add anything - seeing this error
> > means there is a logic error in the code - we have inserted a line
> > without erasing it.  Knowing which chip or line it happened to occur on
> > wont help debug it.  It should never happen, but you can't just leave it
> > unhandled, so I went with a basic log.
> >
>
> We should yell loudly in that case - use one of the WARN() variants
> that'll print a stack trace too and point you to the relevant line in
> the code.
>

Ok, so any suggestion as to which WARN() variant would make the most sense?

> > >
> > > > +out_unlock:
> > > > +   spin_unlock(&supinfo.lock);
> > >
> > > No use of cleanup.h?
> > >
> >
> > Again, that is new to me, so no not yet.
> >
>
> Yep, please use a guard, they're awesome. :)
>

Will do.

Thanks,
Kent.
