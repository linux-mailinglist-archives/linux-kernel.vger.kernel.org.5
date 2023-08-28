Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5694778B37D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjH1OrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjH1Oqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:46:49 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD3F1AE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:46:28 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1447821a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693233988; x=1693838788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3W8WPUKeCWcmTDKarduQ/2aLZmm8oldR8kHDCbdPKY8=;
        b=KEeGZiqgbuuApzkXzkp2+QqoLcf3pKMI0JHyN8rbRBspGLttAE4LXMsw+L8mq9rAf3
         nZyoJz7Sz2I1Cbp7oVxJOmIwxjY9IM5uBW1jqW5ILSx1w0KclmXizFsNXN7BToWHqwGg
         9TQpgHDLSW70Ur84j4O8Kle7cTnwgfdPJ1xBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693233988; x=1693838788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3W8WPUKeCWcmTDKarduQ/2aLZmm8oldR8kHDCbdPKY8=;
        b=B0xUbsJI5+mQULmkPAGVbGpTXx1RJ9FwjsvEE2CD3fC2B3jiJjEc1IlABWx1oD4584
         CP9IpmbVwkLiiYRwLlJxnzzKsFTpVTYvr3rdtlNiHUK3ykETxfkc6Pn03jcaG8TwX7zK
         zGr4H6zvwFHC4Om+GYwws80D66p2OO+1r7NoBVoFt/1bTJ/EY+ylAPatJhk8pWG6XE1V
         gjoetg+RgtEo6vvEdX04BwEe8HlVBp+1x8TfkK4zOCzwvCbJD/1nB1bPWXYC05riH3wN
         5Vy3tWaCXR0PZsrJ0TyF+bxWY5VhWsVIVEHLg5wk5ms8Xy6qqfUBwHRcoc7b8c7fA5Al
         aJJw==
X-Gm-Message-State: AOJu0Yx4AsVx5v4RbDpZsXBdmcpj24H5MonKRfujHMQ+hKBVtEL5tGeI
        sF7wqEpDOUnKILMAdktDgVYaNdrKZL7kwj/JnnxHjw==
X-Google-Smtp-Source: AGHT+IHSsuoA6r7noAsoTIFSQ0k+xX+8toZpL/0fxKRqr994kNitNc18FpuEhPUbOb3w78hu1POFQ5NuJV7ut5D+m3o=
X-Received: by 2002:a17:90a:9f88:b0:268:b66b:d9f6 with SMTP id
 o8-20020a17090a9f8800b00268b66bd9f6mr18698842pjp.18.1693233988257; Mon, 28
 Aug 2023 07:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230704153630.1591122-1-revest@chromium.org> <20230704153630.1591122-3-revest@chromium.org>
 <202308251526.E350861ED@keescook>
In-Reply-To: <202308251526.E350861ED@keescook>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 28 Aug 2023 16:46:16 +0200
Message-ID: <CABRcYmLZ7NLGi0dJck3rBgJBJ0sS1Doaf9LKzALav6JSMgh=bg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] kselftest: vm: Fix mdwe's mmap_FIXED test case
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 12:28=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Tue, Jul 04, 2023 at 05:36:26PM +0200, Florent Revest wrote:
> > I checked with the original author, the mmap_FIXED test case wasn't
> > properly tested and fails. Currently, it maps two consecutive (non
> > overlapping) pages and expects the second mapping to be denied by MDWE
> > but these two pages have nothing to do with each other so MDWE is
> > actually out of the picture here.
> >
> > What the test actually intended to do was to remap a virtual address
> > using MAP_FIXED. However, this operation unmaps the existing mapping an=
d
> > creates a new one so the va is backed by a new page and MDWE is again
> > out of the picture, all remappings should succeed.
> >
> > This patch keeps the test case to make it clear that this situation is
> > expected to work.
> >
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Fixes: 4cf1fe34fd18 ("kselftest: vm: add tests for memory-deny-write-ex=
ecute")
> > ---
> >  tools/testing/selftests/mm/mdwe_test.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/sel=
ftests/mm/mdwe_test.c
> > index d0954c657feb..91aa9c3099e7 100644
> > --- a/tools/testing/selftests/mm/mdwe_test.c
> > +++ b/tools/testing/selftests/mm/mdwe_test.c
> > @@ -168,13 +168,10 @@ TEST_F(mdwe, mmap_FIXED)
> >       self->p =3D mmap(NULL, self->size, PROT_READ, self->flags, 0, 0);
> >       ASSERT_NE(self->p, MAP_FAILED);
> >
> > -     p =3D mmap(self->p + self->size, self->size, PROT_READ | PROT_EXE=
C,
> > +     /* MAP_FIXED unmaps the existing page before mapping which is all=
owed */
> > +     p =3D mmap(self->p, self->size, PROT_READ | PROT_EXEC,
> >                self->flags | MAP_FIXED, 0, 0);
> > -     if (variant->enabled) {
> > -             EXPECT_EQ(p, MAP_FAILED);
> > -     } else {
> > -             EXPECT_EQ(p, self->p);
> > -     }
> > +     EXPECT_EQ(p, self->p);
> >  }
>
> This is just validating the MDWE doesn't block a MAP_FIXED replacement?

Yes! :)

In v4 I modified the description just a little bit to state that out clearl=
y.
