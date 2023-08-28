Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A235E78B37E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjH1OrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjH1Oqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:46:55 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F993CEE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:46:43 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-56c2e882416so1448469a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693234003; x=1693838803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hojslKU89OGZiopVEeX/Q5HHgDBWv2GS+nilxQCP6n8=;
        b=SwJYHWYPwKXFib+Kkm1zjgKNgqrXVBVAQlTBxtUca7y62BreR+KFIzav7YfOE3UvUt
         ZpFRt1q98XWsQARhjOTBEp0SHn1CXFrHFrEYBOKHuWgHHmbUo/q4mUAm86Vi1B8Pl5Nn
         fqM/8LkVXTF+U+Aly963weoWPzzMAeKU53/NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693234003; x=1693838803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hojslKU89OGZiopVEeX/Q5HHgDBWv2GS+nilxQCP6n8=;
        b=DlHQt9PTrNY+aL/tAPZClKNODiqeRqIQeRPDFHOtjisY048g7oY/zKGGnKjnhum+RI
         gDqh0cP6GOlxy19MjQH4PNxrJQZM9zOIwvi2K395kWst69ZpyLIpzqq6u76TLIyMlL/f
         6f4ogs8n0Ac7J6e8Hfq6cgyDR4TmACMrTdo4h2zee/al3Yi4HAtHBSNTBLhLWsaRb4HD
         O5tzZ3FuI6DJFCe3Tw+jlvxwpdq4eyj1XZ3eOQ8ElTVobGUgst97SQJXYMo5zQkasTTG
         y66WUSVHQnIVugqf+/tq2Erlq+/evro/FTWmRamueEraCi7t1dPxZnoWJ8ogFmPvHtZF
         SvKA==
X-Gm-Message-State: AOJu0YzXLGLECzQWZTaS8NuKztKTJRLrzFPk6S5bVb+q6k8+JUwjdR1E
        8XSQNZTQk1IjTwyg3LgKreS8YMYIEsVb5rNm28v/Qw==
X-Google-Smtp-Source: AGHT+IGN02H1r1gE7l7bfLrtgLYA7dmiP7U2Qc3iX7gH1DRg+NhrHeWy+YV4uZCc4jjq2WKSVC39RoCgc1+lrQ4i964=
X-Received: by 2002:a17:90b:1204:b0:26d:37a:9f9d with SMTP id
 gl4-20020a17090b120400b0026d037a9f9dmr18694915pjb.29.1693234002890; Mon, 28
 Aug 2023 07:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230704153630.1591122-1-revest@chromium.org> <20230704153630.1591122-5-revest@chromium.org>
 <202308251535.551E797B1@keescook> <ZOtK7LwdDbVzCvjR@arm.com>
In-Reply-To: <ZOtK7LwdDbVzCvjR@arm.com>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 28 Aug 2023 16:46:31 +0200
Message-ID: <CABRcYmKa1ROu+kM8QMn0iM3JzTmojoOUR0bzRe0sfXukd3cEOg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] mm: Add a NO_INHERIT flag to the PR_SET_MDWE prctl
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
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

On Sun, Aug 27, 2023 at 3:09=E2=80=AFPM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> On Fri, Aug 25, 2023 at 03:38:36PM -0700, Kees Cook wrote:
> > On Tue, Jul 04, 2023 at 05:36:28PM +0200, Florent Revest wrote:
> > >  static inline int prctl_set_mdwe(unsigned long bits, unsigned long a=
rg3,
> > >                              unsigned long arg4, unsigned long arg5)
> > >  {
> > > +   unsigned long current_bits;
> > > +
> > >     if (arg3 || arg4 || arg5)
> > >             return -EINVAL;
> > >
> > > -   if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN))
> > > +   if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT))
> > > +           return -EINVAL;
> > > +
> > > +   /* NO_INHERIT only makes sense with REFUSE_EXEC_GAIN */
> > > +   if (bits & PR_MDWE_NO_INHERIT && !(bits & PR_MDWE_REFUSE_EXEC_GAI=
N))
> > >             return -EINVAL;
> > >
> > > +   current_bits =3D get_current_mdwe();
> > > +   if (current_bits && current_bits !=3D bits)
> > > +           return -EPERM; /* Cannot unset the flags */
> >
> > I was pondering why PR_MDWE_NO_INHERIT can't be unset, but I guess it
> > doesn't matter. Anything forked with have it off, and any process
> > wanting to launch stuff before locking down can just skip running the
> > prctl() until later.
>
> I had a similar doubt initially but then realised that the no-inherit
> mode won't be inherited and concluded it's ok.

Indeed. We previously discussed that in
https://lore.kernel.org/all/CABRcYmLt2KsCoD8WzyCTxuY=3D6ppuWEqyLSDRXSsmXSxP=
LHtEzQ@mail.gmail.com/
and I agreed this doesn't matter for our use case and this keeps the
code a lot more maintainable :)
