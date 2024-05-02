Return-Path: <linux-kernel+bounces-167062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C818BA3FB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3711B1F22E10
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1217420B20;
	Thu,  2 May 2024 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQvHjgw0"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B701218EB0
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 23:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714692665; cv=none; b=NPuM4vsGyAi83jbOHYwUvvBejr9BupbOH6ZvlOX3nTdj2m/uSuAurn3c8/oSdY7boEG7O+qae8h6/w5QJ/cURu/QqTb9NMqdQV/i+rnuU0USsme9cWHIzEZOEzBPTnfWV09k42dWKGto61/JCGORViXwQRrpS8jF19fmE1/63z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714692665; c=relaxed/simple;
	bh=3jA9FiMGvPswA2/dZEI6TZO4drqp6gKMw/Gwzy3f4/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IiJq8IKV30I4BCQz/tEUr/EamHUg4gk9TRlMnLt76DdYOACAHjX0Hal1RVdUulT19q38uIGAcWHjQAl+CBm519FvYS3eZmZhxBQ9QjmR8PED++Rfo6Zo4vtUnPXkMvRU5runkB5oxFfnQ9oVjK/NpSm4XCtXAzdSzDpep29w9Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQvHjgw0; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7f16ff3aa5aso886234241.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 16:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714692662; x=1715297462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7HSYA3SAE5+eP7zUudXzBfNTptQeJcVL00rOgFP/iY=;
        b=CQvHjgw0hS9eITXtw4gMyLlgXq5Q0Y416olVacpfjot0YVhq/x2ER/ZYMkl6UzVVjq
         xsuSJNJC9yuSYOzlBtSKsoz9Iopy7FYH3Y1WKj7GVv/EgBtcylt7DA6ykiW8fxTSuxCN
         M14JCsbrqpV0qw6kYx0meolBEKEqjsadQRc5bBPOKji1MwOa2M8I8vGlrzzLsWDpbNrI
         Rghe1h3ibb7O028oE5HfEJa7mBTA7ldSIE8pg65o9FLy2HxHANvPXn1USNj5IBZTN7VM
         tnf5XxRsV36nqMJhrNaczNVli3WI0rQ0F0QA6YXT9zOdmEMORxs1m5y2wJCvfAcqjZ0Z
         kQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714692662; x=1715297462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7HSYA3SAE5+eP7zUudXzBfNTptQeJcVL00rOgFP/iY=;
        b=mBQYnRwg3x3dxgKo+S1hqKlRf99OqB7K9aOFObcDUmh+RL4dqkYh3ZfYt1BVUWDLDq
         t65xg65rWPmBnIOLLn+UJfGjQyVxK1Y3WloSPe3wb71SQ18duXkDClBNmbkKAvjh8Txn
         pEAMZ4Ra+ssiPhgfDsY7RKGElE8sANaIt5b2EbFEhpTaM1TOjHioNiIggrX68ds8Gly5
         aO04lP3/jZayJgmZk/ZsgLkFE+xBHZ40HVZRGcwbH8gtln5CPQT7j4MBW8rdjhQxjRCS
         IIieLooqeTkuj/b/B3y+aejAbH2vEHIcD0x44PSRsBJijc4FQ6p7YLucIRM/41K+Ad6x
         w8jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQuYlkFj4bneQPzlc3/0HuvN3hpmnjUq4k5kVQ64cCkQiY4UcAtLgIQCwBpp16eBEju1KfNkzt4Fab7fTDN1sMIaLbNpyqajsOgnlT
X-Gm-Message-State: AOJu0YwUzvh+zerGHB2N+N4DrqBsdeXYRVLYOrb6Md+U7J3NaIRpnRp8
	l4Am6cV30iDrr4e6XOem0CtbhRQsO66D4O4RZ4u/F3P5+7/l2+TLhm+te3TRbSO1YnOM6b5n8rA
	I5WLpbzFihoT56cPgcHBeLtSkPYA=
X-Google-Smtp-Source: AGHT+IFvFR+KtCwDF/iF8MGRYco7iaU0ctLQLNYm1AvCvx89JOMXySoFJmFYYC5bHfUN4zYCVqIOUqTRb8UfyJmo+rI=
X-Received: by 2002:a05:6122:469e:b0:4da:e777:a8e6 with SMTP id
 di30-20020a056122469e00b004dae777a8e6mr1356370vkb.14.1714692662103; Thu, 02
 May 2024 16:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501100446.1454264-1-usamaarif642@gmail.com>
 <CAKEwX=NKMOJQ2KuiBcs-62NzqAhRDOvEhWvAzjsAbUtg=65fvA@mail.gmail.com> <cc634240-bfa0-43c5-b34a-257411d0e6a1@gmail.com>
In-Reply-To: <cc634240-bfa0-43c5-b34a-257411d0e6a1@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 2 May 2024 16:30:49 -0700
Message-ID: <CAKEwX=P3CzkrkB8iQ5-BvgaFko03hUULtz=8z-qe_d3LZ7Ge2Q@mail.gmail.com>
Subject: Re: [PATCH] selftests: cgroup: add tests to verify the zswap
 writeback path
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 12:05=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
> On 01/05/2024 16:44, Nhat Pham wrote:
> > On Wed, May 1, 2024 at 3:04=E2=80=AFAM Usama Arif <usamaarif642@gmail.c=
om> wrote:
> >> The condition for writeback can be triggered by allocating random
> >> memory more than memory.high to push memory into zswap, more than
> >> zswap.max to trigger writeback if enabled, but less than memory.max
> >> so that OOM is not triggered. Both values of memory.zswap.writeback
> >> are tested.
> > Thanks for adding the test, Usama :) A couple of suggestions below.
> >
> >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >> ---
> >>   tools/testing/selftests/cgroup/test_zswap.c | 83 +++++++++++++++++++=
++
> >>   1 file changed, 83 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testi=
ng/selftests/cgroup/test_zswap.c
> >> index f0e488ed90d8..fe0e7221525c 100644
> >> --- a/tools/testing/selftests/cgroup/test_zswap.c
> >> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> >> @@ -94,6 +94,19 @@ static int allocate_bytes(const char *cgroup, void =
*arg)
> >>          return 0;
> >>   }
> >>
> >> +static int allocate_random_bytes(const char *cgroup, void *arg)
> >> +{
> >> +       size_t size =3D (size_t)arg;
> >> +       char *mem =3D (char *)malloc(size);
> >> +
> >> +       if (!mem)
> >> +               return -1;
> >> +       for (int i =3D 0; i < size; i++)
> >> +               mem[i] =3D rand() % 128;
> >> +       free(mem);
> >> +       return 0;
> >> +}
> >> +
> >>   static char *setup_test_group_1M(const char *root, const char *name)
> >>   {
> >>          char *group_name =3D cg_name(root, name);
> >> @@ -248,6 +261,74 @@ static int test_zswapin(const char *root)
> >>          return ret;
> >>   }
> >>
> >> +/* Test to verify the zswap writeback path */
> >> +static int test_zswap_writeback(const char *root, bool wb)
> >> +{
> >> +       int ret =3D KSFT_FAIL;
> >> +       char *test_group;
> >> +       long zswpwb_before, zswpwb_after;
> >> +
> >> +       test_group =3D cg_name(root,
> >> +               wb ? "zswap_writeback_enabled_test" : "zswap_writeback=
_disabled_test");
> >> +       if (!test_group)
> >> +               goto out;
> >> +       if (cg_create(test_group))
> >> +               goto out;
> >> +       if (cg_write(test_group, "memory.max", "8M"))
> >> +               goto out;
> >> +       if (cg_write(test_group, "memory.high", "2M"))
> >> +               goto out;
> >> +       if (cg_write(test_group, "memory.zswap.max", "2M"))
> >> +               goto out;
> >> +       if (cg_write(test_group, "memory.zswap.writeback", wb ? "1" : =
"0"))
> >> +               goto out;
> >> +
> >> +       zswpwb_before =3D cg_read_key_long(test_group, "memory.stat", =
"zswpwb ");
> >> +       if (zswpwb_before < 0) {
> >> +               ksft_print_msg("failed to get zswpwb_before\n");
> >> +               goto out;
> >> +       }
> >> +
> >> +       /*
> >> +        * Allocate more than memory.high to push memory into zswap,
> >> +        * more than zswap.max to trigger writeback if enabled,
> >> +        * but less than memory.max so that OOM is not triggered
> >> +        */
> >> +       if (cg_run(test_group, allocate_random_bytes, (void *)MB(3)))
> >> +               goto out;
> > I think we should document better why we allocate random bytes (rather
> > than just using the existing allocation helper).
> >
> > This random allocation pattern (rand() % 128) is probably still
> > compressible by zswap, albeit poorly. I assume this is so that zswap
> > would not be able to just absorb all the swapped out pages?
>
> Thanks for the review! I have added doc in v2 explaining why random
> memory is used.
>
>
> >> +
> >> +       /* Verify that zswap writeback occurred only if writeback was =
enabled */
> >> +       zswpwb_after =3D cg_read_key_long(test_group, "memory.stat", "=
zswpwb ");
> >> +       if (wb) {
> >> +               if (zswpwb_after <=3D zswpwb_before) {
> >> +                       ksft_print_msg("writeback enabled and zswpwb_a=
fter <=3D zswpwb_before\n");
> >> +                       goto out;
> >> +               }
> >> +       } else {
> >> +               if (zswpwb_after !=3D zswpwb_before) {
> >> +                       ksft_print_msg("writeback disabled and zswpwb_=
after !=3D zswpwb_before\n");
> >> +                       goto out;
> >> +               }
> > It'd be nice if we can check that in this case, the number of pages
> > that are "swapped out" matches the cgroup's zswpout stats :)
>
> I think with the method in v2, this might not be easily tracked as some
> metrics are all time (zswpout) while others are current.

Hmm would pgsteal be a good candidate for this purpose?
Just throwing out ideas - I'll leave this up to you to decide :)

