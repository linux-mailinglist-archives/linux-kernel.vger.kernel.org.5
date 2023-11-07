Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2667E4927
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343513AbjKGTY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjKGTYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:24:55 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A0F8F;
        Tue,  7 Nov 2023 11:24:53 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4487901a12.3;
        Tue, 07 Nov 2023 11:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699385092; x=1699989892; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Oj9MZK4wUctOna3bEFza6Z8b7j977JaPhxo3SsWBCcs=;
        b=hRmnF0HxJQlzX2rJ/l91O1Hj/lSzJWjviXUTLNiXN+nPFMwlzHrDhu8QS5eoQYKqjR
         x4d5+NdudTo9quXM2mRqSuVKBvCZJECOTr3oV7huyZQwqG+84od7ZPL+GAxoOnm5QwDP
         nwMUG/hyNZx4tVqLM1hsuYoUvO62osIzkXDZmSydF6JoGfQhifvF92rKjdwdphaNjJBY
         eu8KhRJS1kWeNMCBmj35k9JItSWJnPWqMgZCphYf6fEvcFxuGmOQFm3lsKNbz6/w+dv/
         OjTxVJDnlp0nmxIH5f4FtMEO9uAkbnPQbtHONX5AcYOIb4iP1SDPzviYyUYGR/oLGK7M
         uJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699385092; x=1699989892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oj9MZK4wUctOna3bEFza6Z8b7j977JaPhxo3SsWBCcs=;
        b=ETPwHFdYX6YyeMe0X7FTTgnGdy2oPTy/Z108M6ilxeHq09Kul9rgrKUsFAA0nPuMHO
         HXFhdQ1Jbarcn/J8cC/A+DIAibJMgkcrxB3EXPmFmjgW7pr9yCyLTCnXWfLpA+k7QKwq
         0b21ln2CWKcJXsFBUcwbEm7+C6b1U4BUCJKDQkZcpQUcIylXmNvmOJDsNBCt50IfYheX
         shyDZ/hU+2bEiZjulvi5Y1OE94Jyrr1IfM6kxSwMUZm56n/O98HCeZ8PHw2/7GNHsq22
         UjnjKxKEQm7+3TTxnlN2uRH/69xCce3vUS/YIHTlEQwC/F1Yp6oL5WC+gEekPIogQwPL
         JDLQ==
X-Gm-Message-State: AOJu0YyExpeoE6RY5I7FrK1Oq0hupIM3qSNt1nJDtqV6QYr32vslYQGj
        cy8gk54ySmow0NF/paGLCc/8IYUgyH/L/w==
X-Google-Smtp-Source: AGHT+IGS33QtOaJIzJHkuOlPXXHZVu17ZHfO5B5Wi3fl8+b8Sh2g+W26KPqZgEFwcz7/OXBcrsHtQw==
X-Received: by 2002:a05:6a20:2590:b0:16b:977d:f7cf with SMTP id k16-20020a056a20259000b0016b977df7cfmr39259363pzd.36.1699385092348;
        Tue, 07 Nov 2023 11:24:52 -0800 (PST)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id kx14-20020a170902f94e00b001bc6e6069a6sm172531plb.122.2023.11.07.11.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 11:24:51 -0800 (PST)
Date:   Tue, 7 Nov 2023 11:24:49 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev, linux-hardening@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [alobakin:pfcp 11/19] include/linux/bitmap.h:642:17: warning:
 array subscript [1, 1024] is outside array bounds of 'long unsigned int[1]'
Message-ID: <ZUqPAZC4sS455xtx@yury-ThinkPad>
References: <202310170708.fJzLlgDM-lkp@intel.com>
 <bd7fe929-c6fc-42be-9d2f-3f53ec21fd10@intel.com>
 <ZUkvOCxyiin_77qd@smile.fi.intel.com>
 <0a29df6b-bc27-43e9-a97d-57ecabb29a9e@intel.com>
 <CAG_fn=VtA6e3oGm4WVnxmy9yMBab780-U_4VoHSqm4tcd2UTzQ@mail.gmail.com>
 <ca0ad357-727b-4f41-a3d6-2c48a9dd5836@intel.com>
 <e3b4b1a6-5383-4bfb-ba83-ab27d58dae29@intel.com>
 <ZUqCpmDgKFbscRgW@yury-ThinkPad>
 <457b9cbb-9a5f-47ef-9eac-3e4f135d6a96@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <457b9cbb-9a5f-47ef-9eac-3e4f135d6a96@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 07:52:19PM +0100, Alexander Lobakin wrote:
> From: Yury Norov <yury.norov@gmail.com>
> Date: Tue, 7 Nov 2023 10:32:06 -0800
> 
> > On Tue, Nov 07, 2023 at 06:24:04PM +0100, Alexander Lobakin wrote:
> >> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> >> Date: Tue, 7 Nov 2023 17:44:00 +0100
> >>
> >>> From: Alexander Potapenko <glider@google.com>
> >>> Date: Tue, 7 Nov 2023 17:33:56 +0100
> >>>
> >>>> On Tue, Nov 7, 2023 at 2:23 PM Alexander Lobakin
> >>>> <aleksander.lobakin@intel.com> wrote:
> >>
> >> [...]
> >>
> >>> I tested it on GCC 9 using modified make.cross from lkp and it triggers
> >>> on one more file:
> >>>
> >>> drivers/thermal/intel/intel_soc_dts_iosf.c: In function 'sys_get_curr_temp':
> >>> ./include/linux/bitmap.h:601:18: error: array subscript [1,
> >>> 288230376151711744] is outside array bounds of 'long unsigned int[1]'
> >>> [-Werror=array-bounds]
> >>>
> >>>> to give the compiler some hints about the range of values passed to
> >>>> bitmap_write() rather than suppressing the optimizations.
> >>>
> >>> OPTIMIZER_HIDE_VAR() doesn't disable optimizations if I get it
> >>> correctly, rather shuts up the compiler in cases like this one.
> >>>
> >>> I've been thinking of using __member_size() from fortify-string.h, we
> >>> could probably optimize the object code even a bit more while silencing
> >>> this warning.
> >>> Adding Kees, maybe he'd like to participate in sorting this out as well.
> >>
> >> This one seems to work. At least previously mad GCC 9.3.0 now sits
> >> quietly, as if I added OPTIMIZER_HIDE_VAR() as Yury suggested.
> >  
> > What's wrong with OPTIMIZER_HIDE_VAR()? The problem is clearly on GCC
> > side, namely - it doesn't realize that the map[index+1] fetch is
> > conditional.
> 
> It's totally fine for me to use it, this one is just an alternative
> (well, a bit broken as per below).

OK, guys, that's even worse. The 12 and 13 don't fire the warning
because Warray-bounds is explicitly disabled for gcc-11+. Check
0da6e5fd6c372 ("gcc: disable '-Warray-bounds' for gcc-13 too"). I'll
test how gcc-10 builds it, and if it's broken too, it's worth to shift
the threshold in init/Kconfig.

Let me check it later today.

[...]

> Oh you're right, I didn't think about this. Your approach seems optimal
> unless hardening folks have anything else.
>
> I don't see bitmap_{read,write}() mini-series applied anywhere in your

I'll not take the code unless there are real kernel users for it. Your
compressor is still under development AFAIK, so I'm going to pull
bitmap_read/write with ip_tunnel series, if it comes first. 

> tree, maybe Alex could incorporate your patch into it and resubmit?

Yes, that's what I asked him to do. But let's put it on hold while I'm
testing different compilers.

Thanks,
Yury
