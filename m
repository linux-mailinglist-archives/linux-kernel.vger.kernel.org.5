Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B173C7A5B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjISHhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjISHhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:37:34 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF624128;
        Tue, 19 Sep 2023 00:37:25 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4468258a12.1;
        Tue, 19 Sep 2023 00:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695109044; x=1695713844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B5Q+PIUsVT07rv58SrL1HUGBcimCQz1X9byNoTtq1Ic=;
        b=MW78N5ym5TpFYA2W/diCfF7ucDPiIANQ9LMGeFswrEEtyiIE3EYGfh3HV/3wQxYzM9
         M3GfYup6Bk5xeVvKQKTWSYVgasQTA8dS0LoY0TWE/gjnNK3fKB/Zj04XqO6QWCzZCJas
         Ev1ulcpScXGR6b5nv5gzmWBwrvoZb74ZFajZW8ZEWE4HJQYkzCN6t9Rs+JHnl3HWzXjK
         yKoL59qDBLDZqS8LyGuOFrgRBPw1EZKjo1RzKiDOXWe/PNXtfKiyIDu/Jb9EZGQTfVIX
         9u+AYInFNfGWcjRHp3VIexC8GPUgq1OSJq1V0QOYuI63VGLiwFiThniX6AmGD2+wU31G
         ZXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695109044; x=1695713844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5Q+PIUsVT07rv58SrL1HUGBcimCQz1X9byNoTtq1Ic=;
        b=DzW+luMYFh/t//fkbmHwa8BKBzzeF1pGHiQeNXAbTIVMQzxdWtrmkMNPZT4TheVtxx
         tl10tqChMBnrpr8fLD3YjaW5jToh8sg7tg6x2wI1S9OTSjQqhkaSxu3MDhVAq5e9z2+w
         gLv6Owq/UB25a9RM5HRv6AUP6cIPccSO8XBcGObSpP94b/WlJS1Si++XUgvdhkuAINmq
         2tnra2p+XiT9Bd/FUjzysZuMv1Mb+ONVA9luuKO1NdusKvE7HchsGeZjYfBkIlhjB66v
         2VLl8y7h44ixit1eHD6QFg/iif9r8Y4/6jCS3Fu7ZYniNB0vzD2aBSgk0b5s49CVOpOd
         sCHg==
X-Gm-Message-State: AOJu0YxuwrGe58MSOvbPeDzpC6dEemPnXse4FyS1jbry2kvEdoeij2Wz
        MbMmTaquOdh5jc5mcJ3BPTJ5H5TXirbnYg==
X-Google-Smtp-Source: AGHT+IFcEMyiCEcPXR+JeTg/wf2LOitaa8tmyj1qD8SIcaUMPMWpnCsN1cO7mSwaf67EG7nyYBMTqg==
X-Received: by 2002:a05:6a20:d405:b0:13a:6bca:7a84 with SMTP id il5-20020a056a20d40500b0013a6bca7a84mr11755987pzb.44.1695109044242;
        Tue, 19 Sep 2023 00:37:24 -0700 (PDT)
Received: from sol (14-203-18-151.tpgi.com.au. [14.203.18.151])
        by smtp.gmail.com with ESMTPSA id c12-20020a170903234c00b001bbfa86ca3bsm5272367plh.78.2023.09.19.00.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 00:37:23 -0700 (PDT)
Date:   Tue, 19 Sep 2023 15:37:17 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     brgl@bgdev.pl
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4] gpio: sim: fix an invalid __free() usage
Message-ID: <ZQlPre4nnydZyDAm@sol>
References: <20230918145533.14642-1-brgl@bgdev.pl>
 <ZQhtWNaCiHVu5yzL@smile.fi.intel.com>
 <CAMRc=MfkzdFgwEuNGJYgxyCA_b__Ds-jA4S+jVT1ULJ9DTRhOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MfkzdFgwEuNGJYgxyCA_b__Ds-jA4S+jVT1ULJ9DTRhOw@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:31:36AM -0700, brgl@bgdev.pl wrote:
> On Mon, 18 Sep 2023 17:31:36 +0200, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Mon, Sep 18, 2023 at 04:55:33PM +0200, Bartosz Golaszewski wrote:
> >> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>
> >> gpio_sim_make_line_names() returns NULL or ERR_PTR() so we must not use
> >> __free(kfree) on the returned address. Split this function into two, one
> >> that determines the size of the "gpio-line-names" array to allocate and
> >> one that actually sets the names at correct offsets. The allocation and
> >> assignment of the managed pointer happens in between.
> >
> > ...
> >
> >> +	unsigned int size = 0;
> >>
> >>  	list_for_each_entry(line, &bank->line_list, siblings) {
> >> +		if (!line->name || (line->offset >= bank->num_lines))
> >>  			continue;
> >>
> >> +		size = line->offset + 1;
> >>  	}
> >>
> >> +	return size;
> >
> > So, now the function iterates over all lines and returns the size of the last
> > match, correct?
> >
> > Why not
> >
> > 	list_for_each_entry_reversed() {
> > 		if (line->name && ())
> > 			break;
> > 	}
> >
> > 	return size;
> >
> > ?
> 
> Because the line objects are not sorted by offset. They are added at the end
> of the list in the order the user creates their corresponding configfs groups.
> 

Then your patch is also broken as it uses the last named entry,
not the named entry with the greatest offset??

Cheers,
Kent.
