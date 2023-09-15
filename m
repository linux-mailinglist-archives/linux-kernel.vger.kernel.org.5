Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E807A1422
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjIODHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjIODHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:07:20 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E301270B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:07:16 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68fb7fb537dso1590425b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694747236; x=1695352036; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wKY3Aoi2PgZpKhtcgI0Xd+Aoh/mwMt/O7YmEKabdQBo=;
        b=jjYJI6QSwok/R2RrtVlfAWCU+YRPon6KopfIQ2uV3H67E/1fzB6sFQ1ARA6hQnummd
         BXuC/PxWd6r6YffprK8wzBvOm5mel//na9qnUDbOIsv/4heI0L6AaNdoWHKBejVHr0+2
         pxNPFla946/Db/EqNsrUJMPh6QdUvKPM+gYLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694747236; x=1695352036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wKY3Aoi2PgZpKhtcgI0Xd+Aoh/mwMt/O7YmEKabdQBo=;
        b=q6kx/lWS9Lfq0dpNIzvU9rN3ScL9XY+CCwwPt5xyIJMK4ZkWLiiGA2th5s1ZF7+iqR
         B4CPty8iyhyYJroBFlVmq2ynKgF8GL5+UwCw4NLMW1PRq00Hw80rBLIsNHUORR4yo3Vx
         vhPOE/dC7n/sdXUOOfgB8gIMi0wqYtCrPciqhDwQJ2B6a7Inr9s9N2P2GSfxe2C/GbtK
         aBFnsE29pzIhWz9z7U9LBsamkVKxotUSLYHAomIZiEKTl0AbFGGu99GiDpWhpnoqWu0U
         Kk12uByorDJ1VTRiMj8+zHm9GGb4DwvupxMrY0jXEdPeURAfOONcNZvln+lWLTvTiQNR
         rzTA==
X-Gm-Message-State: AOJu0YyenWS//PQB6GdoYpEpwDH9HeImTBDJVS2eKMTCvwAk/Dw2kX5f
        BCAqa7Z50Vz1yzEefHhc69LTZQ==
X-Google-Smtp-Source: AGHT+IHQ6bTYwQNjNKHv9wGc1xPEjyCRDqtscmHhZudz5CaRSthftSYDLFeug+NbG7cw29X1OwLAzA==
X-Received: by 2002:a05:6a20:9192:b0:157:e67c:6f with SMTP id v18-20020a056a20919200b00157e67c006fmr509458pzd.55.1694747235834;
        Thu, 14 Sep 2023 20:07:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jo13-20020a170903054d00b001bc68602e54sm2298693plb.142.2023.09.14.20.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:07:15 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:07:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] x86/tdx: refactor deprecated strncpy
Message-ID: <202309142006.EB4DE641A@keescook>
References: <20230911-strncpy-arch-x86-coco-tdx-tdx-c-v1-1-4b38155727f3@google.com>
 <69643667-4564-0266-1b26-13833191842c@intel.com>
 <CAFhGd8rohHPu+Zqr+w35=6=goUNC4ycvKk78N+7LSvNbnDnvuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8rohHPu+Zqr+w35=6=goUNC4ycvKk78N+7LSvNbnDnvuw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 03:01:16PM -0700, Justin Stitt wrote:
> On Mon, Sep 11, 2023 at 11:51 AM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 9/11/23 11:27, Justin Stitt wrote:
> > > `strncpy` is deprecated and we should prefer more robust string apis.
> >
> > I dunno.  It actually seems like a pretty good fit here.
> >
> > > In this case, `message.str` is not expected to be NUL-terminated as it
> > > is simply a buffer of characters residing in a union which allows for
> > > named fields representing 8 bytes each. There is only one caller of
> > > `tdx_panic()` and they use a 59-length string for `msg`:
> > > |     const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
> >
> > I'm not really following this logic.
> >
> > We need to do the following:
> >
> > 1. Make sure not to over write past the end of 'message'
> > 2. Make sure not to over read past the end of 'msg'
> > 3. Make sure not to leak stack data into the hypercall registers
> >    in the case of short strings.
> >
> > strncpy() does #1, #2 and #3 just fine.
> 
> Right, to be clear, I do not suspect a bug in the current
> implementation. Rather, let's move towards a less ambiguous interface
> for maintainability's sake
> 
> >
> > The resulting string does *NOT* need to be NULL-terminated.  See the
> > comment:
> >
> >     /* VMM assumes '\0' in byte 65, if the message took all 64 bytes */
> >
> > Are there cases where strncpy() doesn't NULL-terminate the string other
> > than when the buffer is full?
> >
> > I actually didn't realize that strncpy() pads its output up to the full
> > size.  I wonder if Kirill used it intentionally or whether he got lucky
> > here. :)
> 
> Big reason to use strtomem_pad as it is more obvious about what it does.
> 
> I'd love more thoughts/testing here.

This looks like exactly the right conversion: strtomem_pad() will do 1,
2, and 3 (and does it unambiguously and without allowing for a
possible-wrong "size" parameter for the destination buffer).

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
