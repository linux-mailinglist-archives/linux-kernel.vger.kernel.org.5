Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AE87B3C1C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjI2Vuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 17:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Vuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:50:50 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609E9E6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:50:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c724577e1fso46134535ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696024248; x=1696629048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nG8l3KmiLJUoQAJEoFfRXqVxZP9ikMMyfFYzlsqPkOg=;
        b=it+Yh6OVEOmZWjq5k6VvGtayvLGekUQU2USYgjkXiygYlODihzgWrPUOnjYXvFXpgo
         RTzgAHQYffiaCJyruMjltP3BEXYjqbRY/3NrlNbkju5iJANheEEUVDa/G4mLVOyATMK8
         Dm9OH0dGQhK3I5O/YWblBFpIay8Rkf/i0IoZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696024248; x=1696629048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG8l3KmiLJUoQAJEoFfRXqVxZP9ikMMyfFYzlsqPkOg=;
        b=ODt+6zCM6PuQyOjCk8IClboeEP+ceh5n/juYCBWwZ7ucDQ/E3J4KqOxj5QB/b+bkoE
         DWZTXa+k+heEpsTLO3qFZTrnSE2AhBdY3FoKlRRQ2FENhgKMePbRnEG9r28T0/WkAJ6C
         +t0/FSLt4XXUfkhmHnMUiXmu+uvwsJ95kg3S8ygIsJJfvahCKhxDBhYuebxg3ULLUNQv
         BqWWWGVyJ/Nw2/jUJoHerbLcON0mhv14gFf+XfFU7D293XCYShdZ+vG3df5m/MaC3lgv
         unhZsrHRocHcY0jV5DpbYCeoMsRpQ5YTKe6CLf1ja1M1KGIIA/aey89MaNSZ5J0e6MB2
         kPcw==
X-Gm-Message-State: AOJu0YwwIr9vroZNrffH0GTjHtdnX6Gqa2IuiRMy2UJsHki6HtrgweA0
        OMBZ5w7BiCfI+/b1TJx4a8greQ==
X-Google-Smtp-Source: AGHT+IEep4U5eUTvZ2vvdTI5sayk+fxXL86fIIJEm0vaQsIdIR5u4n4IJv4dpYP1T65IKznGbt0Rhw==
X-Received: by 2002:a17:902:9b8e:b0:1c6:845:27c5 with SMTP id y14-20020a1709029b8e00b001c6084527c5mr5158004plp.61.1696024247858;
        Fri, 29 Sep 2023 14:50:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902d3c400b001c737387810sm3659271plb.31.2023.09.29.14.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 14:50:47 -0700 (PDT)
Date:   Fri, 29 Sep 2023 14:50:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Hansen <dave.hansen@intel.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] x86/tdx: refactor deprecated strncpy
Message-ID: <202309291449.FC5C4AE27@keescook>
References: <20230911-strncpy-arch-x86-coco-tdx-tdx-c-v1-1-4b38155727f3@google.com>
 <169601242377.3008066.9973846266706309040.b4-ty@chromium.org>
 <51164807-4860-b1cc-e3de-4230795808df@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51164807-4860-b1cc-e3de-4230795808df@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 02:27:39PM -0700, Dave Hansen wrote:
> On 9/29/23 11:33, Kees Cook wrote:
> > On Mon, 11 Sep 2023 18:27:25 +0000, Justin Stitt wrote:
> >> `strncpy` is deprecated and we should prefer more robust string apis.
> >>
> >> In this case, `message.str` is not expected to be NUL-terminated as it
> >> is simply a buffer of characters residing in a union which allows for
> >> named fields representing 8 bytes each. There is only one caller of
> >> `tdx_panic()` and they use a 59-length string for `msg`:
> >> |	const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
> >>
> >> [...]
> > This appears to be trivially correct, so I can take it via my tree.
> 
> Sorry about that, I was being clear as mud as to what I wanted to see
> here.  I was hoping for another more clear changelog at least.
> 
> The changelog makes it sound like there's a problem with not
> NULL-terminating 'message.str' when there isn't.  That makes it hard to
> tell what the patch's goals are.

Ah! Thanks, sorry. I thought it was resolved.

> As far as I can tell, the code is 100% correct with either the existing
> strncpy() or strtomem_pad(), even with a >64-byte string.  This _is_
> unusual because the hypervisor is nice and doesn't require NULL termination.
> 
> Would there be anything wrong with a changelog like this?
> 
> 	strncpy() works perfectly here in all cases.  However, it _is_
> 	deprecated and unsafe in other cases and there is an effort to
> 	purge it from the code base to avoid problems elsewhere.
> 
> 	Replace strncpy() with an equivalent (in this case)
> 	strtomem_pad() which is not deprecated.
> 
> In other words, this fixes no bug.  But we should do it anyway.

Sounds good; thanks! Justin, can you respin with these changes?

-Kees

-- 
Kees Cook
