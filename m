Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4762D7B43AF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 23:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjI3VBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 17:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjI3VBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 17:01:17 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7C4DA
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 14:01:14 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bd04558784so9265137a34.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 14:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696107674; x=1696712474; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=27IFQu1p2zMt99rhR1KNh/9hYoodXsLNJNCuaLad3CU=;
        b=mC1plnhN4obD+IInLbOK4yXBMt5I6FMCWPwGOanr+jskgKt0UfxY9VyzjJ804y3+X6
         OIZK7uv3zwDA9kx4d65wiwqaSS8oTG/1zJQjJjHybNRhFTEdqM4QoY6xbHDcI3JWfQH2
         mOlUj2i6ngRz0f7nwHu0Tv3XlqmenExAg5njs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696107674; x=1696712474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27IFQu1p2zMt99rhR1KNh/9hYoodXsLNJNCuaLad3CU=;
        b=N0DoH3LQfqj7qHezEClGSAQhymK0F6X/cA+0HyWiYJBMsGff5zZT55+v1uN1G+IHYE
         VXCbzH/u6jJJTtULaCh3Nw1laywdxtcB2xwgBK3/zQWY8QjktZXry1kFuarCTV1Ms0Sx
         FXKetYFBG/hwuMZAAiIrWP7/ayHuDJPl0Cg72OyOdkl7xVlHkLvSwGLKkK2cPabxltpE
         FiD0fQyh1FqiNAXmNGo0TsKJ+q1bDGHy2I7pJuIvI6r1UAc2+DqHUZ7QXKc3BW28cLtL
         WU81yN0pHKlzLj5D1ZNjBhM0nT/x4EeCBP2hFBUJW/TfdTEONLZHJoeDPtkH3DJAVc0C
         lv0Q==
X-Gm-Message-State: AOJu0YwLndM205Z6400ZVWc59jjZPwh5fxsognlk7fTkT9xG7JTA9rcB
        qRRqMcP1XItEnV9eyfXMoIugWg==
X-Google-Smtp-Source: AGHT+IFeOcxaHIbtr3OOPjBvPc8vpAIKWTbtjxf4uBFCfxJieFURN+yasje/os/U6MRlxkFgpLgoBg==
X-Received: by 2002:a05:6830:2091:b0:6c4:c607:7346 with SMTP id y17-20020a056830209100b006c4c6077346mr8189210otq.23.1696107674143;
        Sat, 30 Sep 2023 14:01:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ey1-20020a056a0038c100b0068a13b0b300sm17483758pfb.11.2023.09.30.14.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 14:01:13 -0700 (PDT)
Date:   Sat, 30 Sep 2023 14:01:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: mm: Update mmap_rnd_bits_max
Message-ID: <202309301400.4E1AD87@keescook>
References: <20230929211155.3910949-4-samitolvanen@google.com>
 <20230929211155.3910949-6-samitolvanen@google.com>
 <202309291452.66ED9B4D83@keescook>
 <CABCJKufxUVoO+yJ+513W5FOFu6u45N=6wZe6a69u+8LU6A_N2Q@mail.gmail.com>
 <20230930-emporium-share-2bbdf7074e54@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230930-emporium-share-2bbdf7074e54@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 10:02:35AM +0100, Conor Dooley wrote:
> On Fri, Sep 29, 2023 at 03:52:22PM -0700, Sami Tolvanen wrote:
> > On Fri, Sep 29, 2023 at 2:54 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Fri, Sep 29, 2023 at 09:11:58PM +0000, Sami Tolvanen wrote:
> > > > ARCH_MMAP_RND_BITS_MAX is based on Sv39, which leaves a few
> > > > potential bits of mmap randomness on the table if we end up enabling
> > > > 4/5-level paging. Update mmap_rnd_bits_max to take the final address
> > > > space size into account. This increases mmap_rnd_bits_max from 24 to
> > > > 33 with Sv48/57.
> > > >
> > > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > >
> > > I like this. Is RISCV the only arch where the paging level can be chosen
> > > at boot time?
> > 
> > I haven't seen this elsewhere, but I also haven't looked at all the
> > other architectures that closely. arm64 does something interesting
> > with ARM64_VA_BITS_52, but I think we can still handle that in
> > Kconfig.
> 
> AFAIU, x86-64 can do this also:
> 
> 	no4lvl		[RISCV] Disable 4-level and 5-level paging modes. Forces
> 			kernel to use 3-level paging instead.
> 
> 	no5lvl		[X86-64,RISCV] Disable 5-level paging mode. Forces
> 			kernel to use 4-level paging instead.

Ah-ha! Okay, well, then let's track this idea:
https://github.com/KSPP/linux/issues/346


-- 
Kees Cook
