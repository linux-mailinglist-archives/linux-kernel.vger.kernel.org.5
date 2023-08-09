Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E307F776091
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjHIN2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjHIN2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:28:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204DD1728;
        Wed,  9 Aug 2023 06:27:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe4ad22eb0so48009435e9.3;
        Wed, 09 Aug 2023 06:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691587676; x=1692192476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8Y1G49lBNQm8I61OnbJNB7Y67Rqrzuj0UzklKCPsaE=;
        b=LRLOMkzq5roM5+UL4g24JUK02KJZ1tOyaeAU+G/++qDurykvmZs+k5ToiSnichUqEk
         cUdyvurpRYxwlIy2uQA34E9ug3E4QUF5feALGH3VTp0TBgx+yGcXUIMUIDnlgLBUX48C
         ruOh9y/mgCf1ARxdu2q+MDxvEw0s9HyN68BRdrfPYZ7YZeohcB0sbvG5C+r4iqXdPyai
         ptyD7QmhbiuAe82unuLMetKaRt8X7pznMl7qCmLi0jO2fPjFr6zSghRsE3Cx8Zvx+xVc
         9HnxpplXvU9U5D1IUPk62u0CCiGGNdr5PWo/gqjA8Jlm7PdMWn+wlfXCDRaoe4feejP8
         lcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691587676; x=1692192476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8Y1G49lBNQm8I61OnbJNB7Y67Rqrzuj0UzklKCPsaE=;
        b=aATVRoDGkrQNhhvedIhCx4cIsZgKr3EZZW3GFVwaUIS7IKMCHAAt6Vp4t9LaBP3KoJ
         m5ctqLnW7Qy8wncsZOGskNUybEh7UUYHbXIWFCrFtYMxFpVMWb4Y4h1Y+4Ilc7yvRFen
         lXgd8c/+tbpqNZnasOdO1mx/uhqjhPM0qy/2Mgnfq4lYPi0giKEAZw429b0yRYNL5K4Q
         HCvHG6o4hkOhjrgRic8vZQVTAVq9lPjBS5pJrA0u3/KxdCuOkUqFGnjk6OFIdlkHS2n/
         NXvbk/1MWOMd++wIK9ttGiaLveDT3KZA7eWDQ6kbEk+vo3WVWXeFG7y7Lm7Km2t6Zdi/
         XfiQ==
X-Gm-Message-State: AOJu0Yz9wiG4GFrgpkNaFWIUXZS4Kg9Rs5o8kIBKCHS76Ny/CbVnBoGY
        AM8cHm2U2YyejIG9w11nSmE=
X-Google-Smtp-Source: AGHT+IHDxGd450rRdsFhBnDQgcJyvMYyTZ+kwjhYbRwkfXfZOLa5tVOHOjbRM12m2W0onKTwRwDXew==
X-Received: by 2002:a1c:4b1a:0:b0:3fb:e573:4172 with SMTP id y26-20020a1c4b1a000000b003fbe5734172mr2307215wma.31.1691587676297;
        Wed, 09 Aug 2023 06:27:56 -0700 (PDT)
Received: from suse.localnet (host-95-233-25-82.retail.telecomitalia.it. [95.233.25.82])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c021400b003fe1e3937aesm1990130wmi.20.2023.08.09.06.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 06:27:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation/page_tables: Add info about MMU/TLB and Page Faults
Date:   Wed, 09 Aug 2023 15:27:53 +0200
Message-ID: <2443562.jE0xQCEvom@suse>
In-Reply-To: <CACRpkdYcAWDZV0GkdP6gEJv971wjYQ-8WweHkreTJ-w7sfKKQg@mail.gmail.com>
References: <20230728120054.12306-1-fmdefrancesco@gmail.com>
 <CACRpkdYcAWDZV0GkdP6gEJv971wjYQ-8WweHkreTJ-w7sfKKQg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=C3=AC 7 agosto 2023 11:40:30 CEST Linus Walleij wrote:
> Hi Fabio,
>=20
> I'm back from vacation! Overall this documentation looks good and
> in line with the reset in this section.
>=20
> On Fri, Jul 28, 2023 at 2:01=E2=80=AFPM Fabio M. De Francesco
>=20
> <fmdefrancesco@gmail.com> wrote:
> > +One cause of page faults is due to bugs (or maliciously crafted=20
addresses)
> > and +happens when a process tries to access a range of memory that it
> > doesn't have +permission to. This could be because the memory is reserv=
ed
> > for the kernel or +for another process, or because the process is tryin=
g=20
to
> > write to a read-only +section of memory. When this happens, the kernel
> > sends a Segmentation Fault +(SIGSEGV) signal to the process, which usua=
lly
> > causes the process to terminate.
> This "segmentation fault" (SIGSEGV reads "signal segmentation violation)
> is actually a bit hard to understand for people not familiar
> with the 1970ies hardware.=20

Linus,

Actually, I see a lot of "Segmentation fault (core dumped)" because I still=
=20
develop in user space.

Stupid distractions are enough to get that message printed...

#include <stdio.h>
#include <malloc.h>

int main() {
        int *p1, *p2;
        p2 =3D malloc(sizeof(int));
        *p2 =3D 9;
        printf("*p2 is %d\n", *p1);
        return 0;
}

fabio@suse:/tmp> gcc -o test test.c=20
fabio@suse:/tmp> ./test
Segmentation fault (core dumped)

=46urthermore, everybody can still type "man signal.h" (document written in=
=20
2017) and lookup the table of the POSIX signals and see that SIGSEGV is for=
=20
"Invalid memory reference.".=20
>
> [Snip]
>
> Other programs and the kernel memory are also in inaccessible segments,
> so accessing any of the own segments in the wrong way, or another programs
> segment, or an unmapped segment (virtual memory) would all result in the
> SIGSEGV opaque message "segmentation fault"
>=20
> I don't know how to reflect this in a good way in the documentation
> though, maybe
> copy/paste/edit some of my text or I can try to write something as an
> additional patch if you prefer.

I suspect that people is much more used to get more "Segmentation fault" th=
ese=20
days than in the 1970's (when developers probably were a little more carefu=
l=20
with pointers - at least this is what I have heard about this subject :-)).

BTW, please feel free to change / extend this paragraph with a follow up=20
patch.

Thanks for your comments,

=46abio
> Yours,
> Linus Walleij




