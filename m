Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6159477351A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 01:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjHGXkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 19:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjHGXj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 19:39:59 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BDB1736
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 16:39:58 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bbc06f830aso34262865ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 16:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691451598; x=1692056398;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0l+sCpHwJioTYF/wfHRNJdNAUkK21XwVbEV3jke4+es=;
        b=dXsftWzX5+Hu4twrL1n/Mo54tTI+wzGtnBu1CLPrmVntA19h9YdrWv34e6mRkH7DdU
         1969sylXKdmjK0xJ4TqcjxyND+jT9oEGt+HDYRRKu/Cw3IOnJt/we8cjsnh3UH3SZGN1
         5WfC0t1j0f5wDUm0oCa6ZXsUGiS5NcpQEHUu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691451598; x=1692056398;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0l+sCpHwJioTYF/wfHRNJdNAUkK21XwVbEV3jke4+es=;
        b=VmFem4hradBLTpM34ZPefhlAldX9W/N9Q7/Nygrd5nbZui4h3jdHQvQONta6O+n4s5
         R8fHrzh9i3ZcGAXO+vc8XLIUAF/0KK5EAISvWWduqcr049Iuq903fKdtlfgZY8NJsRSU
         DNfB5X8DTp9DMk/9AYhe6cwXRdShzf8XHTN81cx/Fb2SchnQhhD7Rp1laOcDvxcWj/5v
         2rwcrE/SEy5W1QDA0roTkoAhTBt03BS8oFjGmvQhk5sH7zXesN1nzu0o1iNEP17bpGSh
         2V2u0iKfyBWKZ3W0Og6S7RypR4EZiOtkJLTmLZ9C379uLlfzPGWZZx6dGmZWmOxSziRi
         Oybw==
X-Gm-Message-State: AOJu0YxoS4RV+oIGd1vLNeBhwdkVGZDDsMZte/jHkiD2LPpFrfV19Eoh
        canRoAK+QAE6IUi9WdUq5NZ1yw==
X-Google-Smtp-Source: AGHT+IGdMQVeL0uHk5iGceyUJ4IMfMXBfpY5lj7Xb2/D1CXzdymvrVtvYnilTL43ah4FuOYOA8JvkQ==
X-Received: by 2002:a17:902:ec8e:b0:1bb:cd5a:ba53 with SMTP id x14-20020a170902ec8e00b001bbcd5aba53mr10052640plg.14.1691451598065;
        Mon, 07 Aug 2023 16:39:58 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902ea1100b001b552309aedsm7252666plg.192.2023.08.07.16.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:39:57 -0700 (PDT)
Date:   Mon, 7 Aug 2023 16:39:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Justin Stitt <justinstitt@google.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-hardening@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] um: refactor deprecated strncpy to strtomem
Message-ID: <202308071636.AF290F0@keescook>
References: <20230807-arch-um-v1-1-86dbbfb59709@google.com>
 <CAGG=3QVUqVdkzBo-=vGWprPBUhuV8p3bRSx3Qsvtqx_LDct05w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGG=3QVUqVdkzBo-=vGWprPBUhuV8p3bRSx3Qsvtqx_LDct05w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 03:36:55PM -0700, Bill Wendling wrote:
> On Mon, Aug 7, 2023 at 2:18 PM Justin Stitt <justinstitt@google.com> wrote:
> >
> > Use `strtomem` here since `console_buf` is not expected to be
> > NUL-terminated. We should probably also just use `MCONSOLE_MAX_DATA`

How is it known that console_buf is not a C-string?

> > instead of using `ARRAY_SIZE()` for every iteration of the loop.
> >
> Is this change necessary? I have a general preference for ARRAY_SIZE,
> because a change in size is less likely to be overlooked (unless that
> goes against the coding standard).

I would prefer this stay either ARRAY_SIZE or sizeof, as it keeps it
tied to the variable in question.

> 
> > Also mark char buffer as `__nonstring` as per Kees' suggestion here [1]
> >
> > Finally, follow checkpatch's recommendation of using `min_t` over `min`
> >
> > Link: https://github.com/KSPP/linux/issues/90 [1]
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Notes:
> > I only build tested this patch.
> > ---
> >  arch/um/drivers/mconsole_kern.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
> > index 5026e7b9adfe..fd4c024202ae 100644
> > --- a/arch/um/drivers/mconsole_kern.c
> > +++ b/arch/um/drivers/mconsole_kern.c
> > @@ -4,6 +4,7 @@
> >   * Copyright (C) 2001 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
> >   */
> >
> > +#include "linux/compiler_attributes.h"
> 
> nit: Should this include be in angle brackets?
> 
> #include <linux/compiler_attributes.h>

True, though this shouldn't need to be included at all. What was
missing?

> 
> >  #include <linux/console.h>
> >  #include <linux/ctype.h>
> >  #include <linux/string.h>
> > @@ -554,7 +555,7 @@ struct mconsole_output {
> >
> >  static DEFINE_SPINLOCK(client_lock);
> >  static LIST_HEAD(clients);
> > -static char console_buf[MCONSOLE_MAX_DATA];
> > +static char console_buf[MCONSOLE_MAX_DATA] __nonstring;
> >
> >  static void console_write(struct console *console, const char *string,
> >                           unsigned int len)
> > @@ -566,8 +567,8 @@ static void console_write(struct console *console, const char *string,
> >                 return;
> >
> >         while (len > 0) {
> > -               n = min((size_t) len, ARRAY_SIZE(console_buf));
> > -               strncpy(console_buf, string, n);
> > +               n = min_t(size_t, len, MCONSOLE_MAX_DATA);
> > +               strtomem(console_buf, string);
> >                 string += n;
> >                 len -= n;
> >
> >
> > ---
> > base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
> > change-id: 20230807-arch-um-3ef24413427e
> >
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> >

-- 
Kees Cook
