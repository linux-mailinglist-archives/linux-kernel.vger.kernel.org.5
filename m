Return-Path: <linux-kernel+bounces-22905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5EF82A530
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC22284DF8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7710CED4;
	Thu, 11 Jan 2024 00:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N86QjvFN"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C079EBB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bc1414b48eso5250649b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704931662; x=1705536462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TShArdENafTOCTnI/LZrgLzX+BUXpRaca4Iuv2KbFTM=;
        b=N86QjvFNOBl6smc2FKWY7Jbopu9SnKSwBRQT9yrd6EgOSx682/a1ohT6JVQfs4m4tH
         UfEcWeTW+VBbhtCc4UZMYKb6sahAcan6WPBcbc/hAsi772h5ch14EeDDP+m5V0wkZnFR
         HSRMDEXO6d7dQgStFx+PjhYMwW7UnJATPydKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704931662; x=1705536462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TShArdENafTOCTnI/LZrgLzX+BUXpRaca4Iuv2KbFTM=;
        b=ncqzplIp3l2jeHG1cPLT+oHH+MLFwGmBmP2So35z6dp7mSm0/5cgu4sa1Qzom5CpFP
         mq+zxVMJT8QhR9nbGL0uRQZ25IGfuXFJgjL8+EoipgTo9MHrTbCPiHrllE2U2fbwC17J
         idZ/ZlccRFmtYtRG1w7F6IHRIpa/LWMLGgkMjOF5syjUp1InFoovEpF4Y1Pew1gb1p8U
         5gGjF+vZIdJPdla1oGG1Pnm6N7qSuRKhAUTwl4q1rckQj/3K4MZmABmu0ccQtpLAOtHn
         HmpvqVlk5f4PouJnaKnZxfeT3feqMCwipaQZkJqOEfHBmk9d9lXaXAaJRZMJoAwTU2B/
         64uQ==
X-Gm-Message-State: AOJu0YxNNSeKf/NK8F/cQMmuRPJhM/jxeR2mW9me8DR8WJX75CMWURlL
	AcJGp4Gn3yKEq4fgYciG+6iemPIxR+Nk
X-Google-Smtp-Source: AGHT+IF4wsWW4fsdG3n0P/pFi84A5z4SQ8M8M+ff5o1gwQ0sPG0mgKcVKIK/ayHuiVxMzj7fz7a14Q==
X-Received: by 2002:a05:6808:3605:b0:3bd:48a1:c49f with SMTP id ct5-20020a056808360500b003bd48a1c49fmr416053oib.27.1704931662499;
        Wed, 10 Jan 2024 16:07:42 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g5-20020a62f945000000b006d997b5d009sm3997315pfm.69.2024.01.10.16.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 16:07:41 -0800 (PST)
Date: Wed, 10 Jan 2024 16:07:41 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Tanzir Hasan <tanzhasanwork@gmail.com>,
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/2] lib/string: shrink lib/string.i via IWYU
Message-ID: <202401101606.A31647E@keescook>
References: <20231214-libstringheader-v2-0-0f195dcff204@google.com>
 <20231214-libstringheader-v2-2-0f195dcff204@google.com>
 <20240109214910.oeopqq5j2gyl33dc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109214910.oeopqq5j2gyl33dc@google.com>

On Tue, Jan 09, 2024 at 09:49:10PM +0000, Justin Stitt wrote:
> On Thu, Dec 14, 2023 at 09:06:13PM +0000, tanzirh@google.com wrote:
> > This diff uses an open source tool include-what-you-use (IWYU) to modify
> > the include list changing indirect includes to direct includes.
> > IWYU is implemented using the IWYUScripts github repository which is a tool that is
> > currently undergoing development. These changes seek to improve build times.
> >
> > This change to lib/string.c resulted in a preprocessed size of
> > lib/string.i from 26371 lines to 5259 lines (-80%) for the x86
> > defconfig.
> >
> 
> Tanzir, I wonder if you could include some of the symbol names used for
> some of these more esoteric headers. Let me describe what I mean:
> 
> Andy talks about "why <vdso/...>" and perhaps some comments (in your
> patch message, not in the source itself) about which symbols are being
> used from these headers would serve useful. I believe IWYU can generate
> this information and should clear up some confusion or lead to better
> suggestions from reviewers if we understand why a header is being
> included.

If there aren't any other objections, I'd like to pick this up in my
tree after the merge window closes.

> 
> At any rate, this builds for me doing randconfigs on x86_64 with these
> KCONFIG_SEEDs
> 1: 0x3DD9D136
> 2: 0xB4440EE4
> 3: 0x98778270
> 4: 0x8C237F26
> 5: 0x244F8A64
> 6: 0x5A5C5E5C
> 7: 0xA77896BC
> 8: 0x9B5FF0D5
> 9: 0x24F23F6A
> 10: 0x35C0A107
> 
> I applied your patch on top of 5db8752c3b81bd33.
> 
> Tested-by: Justin Stitt <justinstitt@google.com>

Thanks for the testing!

-Kees

> > Link: https://github.com/ClangBuiltLinux/IWYUScripts
> >
> > Signed-off-by: Tanzir Hasan <tanzirh@google.com>
> > ---
> >  lib/string.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/lib/string.c b/lib/string.c
> > index be26623953d2..7fe1acefb1a1 100644
> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -16,16 +16,16 @@
> >
> >  #define __NO_FORTIFY
> >  #include <linux/types.h>
> > -#include <linux/string.h>
> > -#include <linux/ctype.h>
> > -#include <linux/kernel.h>
> > -#include <linux/export.h>
> > +#include <linux/bits.h>
> >  #include <linux/bug.h>
> >  #include <linux/errno.h>
> > -#include <linux/slab.h>
> > -
> > +#include <asm/rwonce.h>
> > +#include <linux/linkage.h>
> > +#include <linux/stddef.h>
> > +#include <vdso/limits.h>
> > +#include <linux/string.h>
> > +#include <linux/ctype.h>
> >  #include <asm/unaligned.h>
> > -#include <asm/byteorder.h>
> >  #include <asm/word-at-a-time.h>
> >  #include <asm/page.h>
> >
> >
> > --
> > 2.43.0.472.g3155946c3a-goog
> >
> Thanks
> Justin

-- 
Kees Cook

