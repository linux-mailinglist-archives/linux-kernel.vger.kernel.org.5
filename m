Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00B7781CC7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 09:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjHTHZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 03:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjHTHZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 03:25:21 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472B21995
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 00:21:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68a3f1d8be2so248015b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 00:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692516085; x=1693120885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2GjKlgrr0th7ky2xTqHRqanB89DFHlsIAVq6xB4FtkI=;
        b=Llw5jlEyl3YJi8wPXC3XEdwm80JhWBms1Hxwa7M375oPxtMMsDMpdXnno3QM8UkHij
         rd5tvbNpbUehZhZHZZdanPyF/mwJrwHcJJY9lUX7AsUS45F0JW/gpleCdp1WSL6ZAiN/
         P98p+J84mIm2om+7bduqY7/h185yDO9UEyjeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692516085; x=1693120885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GjKlgrr0th7ky2xTqHRqanB89DFHlsIAVq6xB4FtkI=;
        b=USHiiTD2sCJ+o/iBBMZetXSdRwFhDtDFUMJwZMhH3n9gijXS/IFAzjGoCC1AeQsMwi
         hcMuMyutJfI4sUfwtHNtgXq0Ccd0Gad7eSiPrRFwQl0hfbvoDM30qydVN2U8b7QY019x
         JB/t3o9JtEeRY3929TbhN6x7dBK0SMWHG+plYAEnEF3f68sYSOb/1vA16kQ0TAwkdKrf
         fUbAHZcyec1JLT2f/Ph5cLDiA7QFgTzi6Xnta6W84zsF7ejNS5Otx5n5gvqzHVIUi1JR
         yV99ZkDyspGkwvSbGel8PxL/ICWLllOUivo5+BPpuHUYyFtMPCOxGvamS+wJ64UxyUiZ
         M5Lw==
X-Gm-Message-State: AOJu0YzZgRQX7po1N3d+M7SHncPRbxTjB1fd8b4tj5ZXHweefENX1pkh
        7GCkB6fScIjjKjXe9sEV6ep08g==
X-Google-Smtp-Source: AGHT+IGIQAjbE3hh0ICrLFqCMNEeMJMax+giGMT6cu4dqkwKnm2z/qwkPtiVoEYnad5tcQ5DceDh6A==
X-Received: by 2002:a05:6a00:b4e:b0:687:6184:def4 with SMTP id p14-20020a056a000b4e00b006876184def4mr5234317pfo.21.1692516084499;
        Sun, 20 Aug 2023 00:21:24 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id j6-20020aa78d06000000b0068991abe1desm4150966pfe.176.2023.08.20.00.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 00:21:23 -0700 (PDT)
Date:   Sun, 20 Aug 2023 16:21:19 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Tomasz Figa <tfiga@chromium.org>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] kconfig: introduce listunknownconfig
Message-ID: <20230820072119.GM907732@google.com>
References: <20230817012007.131868-1-senozhatsky@chromium.org>
 <CAK7LNASJWKSsdzn5ccgWaC35-XvHGU7pnE6C=eZFDbqrrghtdQ@mail.gmail.com>
 <20230820024519.GK907732@google.com>
 <CAK7LNAS9KC1GjPgadMEivSpy4TMYU8mQ+BrtfJpNs2kvhK18yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAS9KC1GjPgadMEivSpy4TMYU8mQ+BrtfJpNs2kvhK18yA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/20 14:11), Masahiro Yamada wrote:
> > That doesn't seem cover the cases that I'm concerned with. I don't see
> > anything related to "!sym" in the patch.
> >
> > What will KCONFIG_VERBOSE do if it reads the following config file?
> >
> > // assuming that both config options were valid and existed in the old
> > // kernel, but were removed/renamed in the new kernel
> >
> >  $ cat .config
> >  CONFIG_DISABLE_BUGS=y
> >  # CONFIG_ENABLE_WINAPI is not set
> >
> >
> > I'd like to see warnings for both lines, even for config that is not
> > set, because it maybe we set by a build script depending on USE flags
> > for instance, so that build target may still refer to non-existent
> > config.
> 
> 
> I did not say Ying Sun's patch covered your case.
> 
> I just meant I dislike your approach.

Sure, OK.

> After his patch is applied, please come back with a similar approach

I guess Ying Sun's patch cannot be extended to cover these extra cases?

What the preferred approach would be? Do we want a new KCONFIG_FOO env
variable that changes behaviour of one of the targets? E.g.

	KCONFIG_LIST_MISSING=1 make oldconfig

and then have conf list symbols and terminate with exit(1) if there are
some unrecognized symbols?

We have "listnew", so "listmissing" sort of fits as a new target.

> if you want to address your case in the mainline kernel

Yes please, we want an upstream solution for the problem in question.
