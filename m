Return-Path: <linux-kernel+bounces-123413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCCE890838
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B681F232BF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEFC1350C6;
	Thu, 28 Mar 2024 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z8LJgOgn"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F1B130E3B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711650439; cv=none; b=GYatNWIExwtxGdBtHrpGFCygyzw8/qyFrAlcmJyNrHOel1eLbDc+Wn3v3wrdGsqvCaSFJQ/GjQHtlGVg6GQe3+1u77iMTp7i9GBhcSBdXrYGkUIAjh1uOXl4MjO6qNW4wOps6bH6EJxcKPqEuPKvlZac3FLSijnuPkEBHaYExcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711650439; c=relaxed/simple;
	bh=gqw95WreaXzk3tMtnlHwBkwwBSkVdhBkoy3UNovDKa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b70gVPS60ErCoJihU92V99LeWXXpvSizy6MSk1B4ec9cO2IW8zeVSbjbSLQHmmfziyIPO3vSVgEfv4P2boeY+5L5jngbmx9F29VRBBU7yubvVb4yzBEbcPcp5NgEyZjP14Hwu5UL8McZwEizUfxIyijq1LfK8Wl8gBo+LKwE+90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z8LJgOgn; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56beb6e68aeso1251a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711650434; x=1712255234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85okgPI5wmbRinylcWdySXAu6sDEJZPcZsliJr3EhXc=;
        b=z8LJgOgnrwMqle+GIquH01Fabr8jP4LsXvMPDVfpqJmtQbRVcAOmb9hi8P9DM2vYB/
         9/8aCRzvhIoEP7q8fVyjIXdY1G+NNDuZNNNErMi3NNzOz7nJmLHHkxD7p4GC7k3QxsMz
         NxQCOtPevO/USSxnjRQPzdpz6wSa2DF++8BepS++RKdAW9VhHBwmdMsTwJqZahvKUSGb
         A+IF244xSG0KKVMOeABtEFEvQ0AVoSsV9nUzKJCMTV86RiTdF9locAxPj4cDSevWKtUP
         9nuFRoD7/cC05LRDAMdBFP9U6dIANqfolcMfPReR2RpJN6923ZUZtVQlalah/H7za/lk
         4l+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711650434; x=1712255234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85okgPI5wmbRinylcWdySXAu6sDEJZPcZsliJr3EhXc=;
        b=g6dMcIEBLPWJb+gBkKeL/jqL2mzj7JzgRqzqTM27eJmx+8kaWC0XWD8pO8JTM1Ntw+
         2ZExHOMNS6uyP6qSlKads6xXSaq0XTr1enZ6F/BP0uxdwNHMNNgu96UlR8pG6m/Hvr9f
         q2cbANuetMpjEGfKJTN2A8fPlBzDJIByTEjEfZSGiLunaRS1UvHzH6KYmIX5ICBmWpck
         EoG4aFL2dwZKU0WXCPD2BhqpFonaFZr37n75Y66x0kT4bZoQEjcn9bfRBicwDvqgFCgd
         XCAd/4qb3LDUnXtoCfgVdK4MoP2j09z9lzMFWpGAmynaNawAZji5aCWkdJ2dPgrmVA2T
         0MBg==
X-Forwarded-Encrypted: i=1; AJvYcCV3tCe64LmY2/6RhYz7CcTCIievGdL3obBBX0zicUZwoNuVMRw6JTioZEcwQhngKfylSH+nqSk9m+5gG4U8hxiRu5OV0UXU65AZ9j6l
X-Gm-Message-State: AOJu0YwMquhLxzKOyV8ZZxdYKXX/SHgJ1SSkvgmsNc3hcMPdpBLXGndu
	DV0NieI7eBm52fmG6Y5SRbuT1rTsZ64MzJAbYGqOkmtpiNJuvrKN+LHf+nvBIxnaOfYMdjCgFFq
	Whyl1gmZ7XOuAUHHpUrpjlMjnH7r4wqJv8QmD
X-Google-Smtp-Source: AGHT+IHv6+ovKmGeILX0PNxbWAx4gi+qItJhFc9E/82fPI5xJuf6KrzJPUedneSe7yPE7D3rJKz2FyvDSWy8TPjOzGc=
X-Received: by 2002:aa7:cd1a:0:b0:56c:53ac:b34 with SMTP id
 b26-20020aa7cd1a000000b0056c53ac0b34mr15774edw.1.1711650434337; Thu, 28 Mar
 2024 11:27:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328142004.2144568-1-jackmanb@google.com>
In-Reply-To: <20240328142004.2144568-1-jackmanb@google.com>
From: Daniel Latypov <dlatypov@google.com>
Date: Thu, 28 Mar 2024 11:27:01 -0700
Message-ID: <CAGS_qxr_vdix2mnoZve+L4EZv4wO-XdnJ1burnn7fM-at6EuEg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Clarify test filter format
To: Brendan Jackman <jackmanb@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brendan Higgins <brendan.higgins@linux.dev>, davidgow@google.com, rmoar@google.com, 
	corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 7:20=E2=80=AFAM 'Brendan Jackman' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> It seems obvious once you know, but at first I didn't realise that the
> suite name is part of this format. Document it and add example.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  Documentation/dev-tools/kunit/run_wrapper.rst | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentatio=
n/dev-tools/kunit/run_wrapper.rst
> index 19ddf5e07013..e75a5fc05814 100644
> --- a/Documentation/dev-tools/kunit/run_wrapper.rst
> +++ b/Documentation/dev-tools/kunit/run_wrapper.rst
> @@ -156,13 +156,20 @@ Filtering tests
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  By passing a bash style glob filter to the ``exec`` or ``run``
> -commands, we can run a subset of the tests built into a kernel . For
> +commands, we can run a subset of the tests built into a kernel,
> +identified by a string like ``$suite_name.$test_name``. For

Apologies for the overly terse docs, that's my fault :)
I'm wondering if we can further improve it while we're here.

Note, the format for the glob is: $suite_name[.$test_name].

This current wording and examples (before and after this change) might
make the user think otherwise, i.e. that it works like
  effective_name =3D suite_name + '.' + test_name
  return glob_matches(effective_name, filter_glob)

E.g. given a test name like `suite.test_name` and glob=3D'suite*name'
they might expect it to match, but it does *not*.

The logic actually works like:
  suite_glob, test_glob =3D split(filter_glob)
  if not_glob_matches(suite_name, suite_glob):
     return False
  if test_glob and not glob_matches(test_name, test_glob):
     return False
  return True

Perhaps expanding the list of examples to cover more of the edge cases
could help get the right intuition?

E.g. perhaps these:
  kunit.py run <suite_name>  # runs all tests in a specific suite
  kunit.py run <suite_name>.<test_name>  # run a specific test

  kunit.py run suite_prefix*  # what the current example shows
  kunit.py run *.*test_suffix  # matches all suites, only tests w/ a
certain suffix
  kunit.py run suite_prefix*.*test_suffix # combined version of above

Thoughts?

Thanks,
Daniel

