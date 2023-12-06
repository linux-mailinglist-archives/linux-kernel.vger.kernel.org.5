Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510D580673E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376968AbjLFGPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376980AbjLFGPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:15:41 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAFAA8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 22:15:44 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c09f4bea8so32988395e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 22:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701843342; x=1702448142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j7sEYNm1NIi6fuTcFjAL1SvEUmLyjhdH04JqlSC9wHY=;
        b=JELCR676ijetLaSbfXkXdmhGKDSE80HlfI8HzpljhMI/ko7phz93VlML7EUsWyTjKh
         n0+hnKSzsq/BoBP90w0JfSW4ZvUbDDdXzyGankeJreQzxNe9nXf4JZAc7RAFpHKocYua
         LA1Ff87aiImBZyq32t01hemiqLj+FJq/r1ZbwwaqG77kxiEVxkNenk4SASTQ2o5888v5
         gF/ZlKskhneK1egIIcugYdjUKe11fo56qHDtpnubkdGrZal+SVdBD5kvDF9w5cD/MgUD
         U39KscmPXHng7JQjLOMCzc8jcr/FqBEcI5C82DoWs17w3rPlsKWb7cnI/7lDb3mBWMo1
         /+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701843342; x=1702448142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7sEYNm1NIi6fuTcFjAL1SvEUmLyjhdH04JqlSC9wHY=;
        b=IjDznblIJxEhPOmJyTaDx540B2xjMRaH8UPfzXM4Q91mzXQrxJmWQuOJRWVejLtbjg
         /yh9BLMu+OhXGSLGHaL9w249GXDbo+2/YH71M7WCvQTng+QGzV+M+1Rv5d35dVOOLMxY
         rvrEJ/S+b5E8p7RtbRWhrWpwisEnET7PRXvt0EZLybZIuGEVqE3w2LMg/G8Lk77pZUGa
         0Pl/khsTEHMAalgb4FUu6AuwxnFUpSJ86qYUylfzwYhtwJRWdpy5PeHU5EblCknGvvhC
         F0txK/iCjFSj+YhhJCgeHEZjCU8DTiX+KdOXx8YQ3eTpP5IEWuM7xjdcywAmFcd7i1oz
         V1VA==
X-Gm-Message-State: AOJu0YxqA4S6HBMJ2r8U7/cQIew0IEYrRUNvGyFF58cJf220X6YAR4LZ
        thy++s8cXg15dWY/WKRweel/cYArMg==
X-Google-Smtp-Source: AGHT+IEiyWHIPjrFf8SGzOlHwgeuFlN5+FpUAx++O6Nwp6xfT0Zqp/m5zUkReysn6V/PyYos9/Mvpg==
X-Received: by 2002:a05:600c:3093:b0:40b:5e59:da99 with SMTP id g19-20020a05600c309300b0040b5e59da99mr224245wmn.172.1701843342151;
        Tue, 05 Dec 2023 22:15:42 -0800 (PST)
Received: from p183 ([46.53.253.86])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b0040b4cb14d40sm24535902wmb.19.2023.12.05.22.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 22:15:41 -0800 (PST)
Date:   Wed, 6 Dec 2023 09:15:39 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86_64: test xmm/ymm register state after execve(2)
Message-ID: <7bbef366-c897-4cd2-ae69-d3e8019c5b3a@p183>
References: <ea599d98-7d26-4278-9d79-a115650289df@p183>
 <cd27c804-a289-4b6f-9dd1-5c4b3bdc564b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd27c804-a289-4b6f-9dd1-5c4b3bdc564b@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 12:39:32PM -0800, Dave Hansen wrote:
> On 12/5/23 06:21, Alexey Dobriyan wrote:
> > Test that xmm/ymm registers are cleared immediately after execve(2).
> > 
> > It is opportunistically named "check_xmm_ymm_zmm" because I don't have
> > AVX-512 machine but it will be trivial to extend without renaming stuff.
> 
> Hi Alexey,
> 
> This looks pretty useful.  I know we've had bugs in this area in the
> past.  Was there any recent motivation for this, though?  Just curious.

I found check_initial_reg_state.c with cool assembly but only general
registers being checked.

> > --- /dev/null
> > +++ b/tools/testing/selftests/x86/check_xmm_ymm_zmm.c
> > @@ -0,0 +1,176 @@
> > +/*
> > + * Copyright (c) 2023 Alexey Dobriyan <adobriyan@gmail.com>
> > + *
> > + * Permission to use, copy, modify, and distribute this software for any
> > + * purpose with or without fee is hereby granted, provided that the above
> > + * copyright notice and this permission notice appear in all copies.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
> > + * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
> > + * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
> > + * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
> > + * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> > + * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
> > + * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> > + */
> > +/* Test that xmm, ymm registers are cleared immediately after execve(2). */
> 
> Can this be trimmed down to a nice SPDX header?

I'd rather not.

This is standalone test program, not part of kernel proper, so if it's
copied somewhere than copyrights are retained. Another project might not
even use SPDX scheme.

> > +#include <stdio.h>
> > +#include <string.h>
> > +
> > +#if   defined __amd64__
> > +#elif defined __i386__
> > +#error "fix register count, SSE2 detection"
> > +#else
> > +#error
> > +#endif

> > +".Ltest_xmm:"
> > +	"movdqu %xmm0, xmm + 16 * 0;"
> > +	"movdqu %xmm1, xmm + 16 * 1;"
> 
> Does this work on systems without XMMs?  I know it's not common these
> days but it's possible, especially in VMs.

No. But I think all x86_64 systems have SSE2. So it is up to whoever will
port this test to i386.
