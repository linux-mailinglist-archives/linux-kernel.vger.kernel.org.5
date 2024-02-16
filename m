Return-Path: <linux-kernel+bounces-68977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 225588582E4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907C81F23F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FCA130AC9;
	Fri, 16 Feb 2024 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="odMN4+Dt"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911DD43687
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101916; cv=none; b=or8kpMN3UEoS+pG/VLmcnRsrnInpuovr1r0tgPSoMpRTNzvYpq79990G12Hd5yK0zEfK4I7Fc6UctvfEdYjvVgHi0qjb945OSNllVbOS50ZAjFJAFJAKujrmtZZFzPJx3cZm934TxPP5za6mFYLMKbb7nuKFDgZQIDbq7E/EGDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101916; c=relaxed/simple;
	bh=KRDASqWMP4FmjtwV9SInKRI/O/iLjYCFWTgDjM85YK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgcLnTxlQh5pvguaxbJCl+/aw8xnEAWQMHsPIpnNVPl34xyaIGyslfjlHXq72vqi8sqlbAs6nSk0XKjAq4VgA4X+JLEI48w6kRHBSP2rVqH7h1PM7szxk8yFnDvBC0CjoeAKTVkgO2s9cj+vTSvmxkk1q+O9neH/meFJoAcoWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=odMN4+Dt; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60777bcfed2so17554607b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708101912; x=1708706712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqMJBdmCbC/RM9PRo3lm7SAMuIGxpy4kB2I1M6Qh1Sw=;
        b=odMN4+DtMaBIStE4V0Gyk/UdKuc7ha27bLtVpyKeudQ9H4WmsUbUnmcdYXlqTfrfDn
         j9AwL5xlt2PQKP7dtoW1QcmMal0BhWC/mDIYq9XqLTtm7EfYEQvCSqgCWpp0ozd6Vqrg
         i1dx5OlytEq1OancQA2b9D8xXm/I9JPwkS+R+SZQpKobemBHc8DEbuX2szRF/uKCRBaf
         sXrsyU1dK7oMYLr2haBccjYZ9QD9wISsnJJInmLY+cLGrH9KocGpj0Er0ZlQdW8n/HDP
         /DFOKd6aiWUU34XSpFPxjfdAOnZ7XoZokv78cq3Mw/hMC/zSho7RbgbfLkxzdqwl7zlS
         Sd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708101912; x=1708706712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqMJBdmCbC/RM9PRo3lm7SAMuIGxpy4kB2I1M6Qh1Sw=;
        b=dLPmWEvmcYK2QClGsMrB+BiXHz5UXoFwfJIvVynxMOsJ93Ey5dtIzyYSiiYwdVffOf
         yXkyuii8qzArWXpgsDHwo5DL8jx4Qghk5w2E+8jXwJsbYCZWBdREU+k1KjcikLOjyNwv
         ZHf+KyOfJsfXAojL0PeKOzf+z1dDnhe7WFhmxqV8JgFiKj4DpcPVu6hpE59FLgzXy+kU
         A34PMeYYQ4xDdgaWxDcdYuCf5WSOsfip4nWynnODSSXfb6RMH9n3DJSoMxHwecV0WWip
         Nrln0/jYXREywJ7VgPELTLpRyANnqc9E4F4wqoX/w0VjCvfLl6TdG8Apvecb6Vy8WzA+
         JGBw==
X-Forwarded-Encrypted: i=1; AJvYcCXa/k8SYmzCmYbFJ8a71Qy+RqgmLBlHs4AilnW+zuzYiIwdhaw+/vx880sg8ickBeZAe8B3jSwn4WV5I2dxL5w6RA0E+0CoPqM+uluy
X-Gm-Message-State: AOJu0YwLSfPJ7PObewHij6yz6ujfmsyN2lPSJXOy6yHR5th6WcTxeqDf
	/40PAdgI7iJLPI9doe6S+d8b53CVhXcAAxIop/kupQz+T8iw4ez2oedgRUoMs7q2tAK2ar5O7A0
	eX8DmDRTn1DLJsK3V7NR/wu5N+8e7I+zlPdMN
X-Google-Smtp-Source: AGHT+IG8/ofM2uf/y914CU8c22R1iloHjqFZxLjTIvqCNCo3t1Vtfj5gxB8K/liUcdy0qkkmiNCjnhDlVc5UviII96I=
X-Received: by 2002:a0d:d489:0:b0:607:d02f:3587 with SMTP id
 w131-20020a0dd489000000b00607d02f3587mr6663621ywd.4.1708101912180; Fri, 16
 Feb 2024 08:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-15-surenb@google.com>
 <039a817d-20c4-487d-a443-f87e19727305@suse.cz>
In-Reply-To: <039a817d-20c4-487d-a443-f87e19727305@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Feb 2024 08:44:58 -0800
Message-ID: <CAJuCfpE_JUmLWJwbiJh1qX-YMCwgVvUthrF30o=sY_YtaVvgjw@mail.gmail.com>
Subject: Re: [PATCH v3 14/35] lib: introduce support for page allocation tagging
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 1:45=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/12/24 22:39, Suren Baghdasaryan wrote:
> > Introduce helper functions to easily instrument page allocators by
> > storing a pointer to the allocation tag associated with the code that
> > allocated the page in a page_ext field.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Co-developed-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > +
> > +#ifdef CONFIG_MEM_ALLOC_PROFILING
> > +
> > +#include <linux/page_ext.h>
> > +
> > +extern struct page_ext_operations page_alloc_tagging_ops;
> > +extern struct page_ext *page_ext_get(struct page *page);
> > +extern void page_ext_put(struct page_ext *page_ext);
> > +
> > +static inline union codetag_ref *codetag_ref_from_page_ext(struct page=
_ext *page_ext)
> > +{
> > +     return (void *)page_ext + page_alloc_tagging_ops.offset;
> > +}
> > +
> > +static inline struct page_ext *page_ext_from_codetag_ref(union codetag=
_ref *ref)
> > +{
> > +     return (void *)ref - page_alloc_tagging_ops.offset;
> > +}
> > +
> > +static inline union codetag_ref *get_page_tag_ref(struct page *page)
> > +{
> > +     if (page && mem_alloc_profiling_enabled()) {
> > +             struct page_ext *page_ext =3D page_ext_get(page);
> > +
> > +             if (page_ext)
> > +                     return codetag_ref_from_page_ext(page_ext);
>
> I think when structured like this, you're not getting the full benefits o=
f
> static keys, and the compiler probably can't improve that on its own.
>
> - page is tested before the static branch is evaluated
> - when disabled, the result is NULL, and that's again tested in the calle=
rs

Yes, that sounds right. I'll move the static branch check earlier like
you suggested. Thanks!

>
> > +     }
> > +     return NULL;
> > +}
> > +
> > +static inline void put_page_tag_ref(union codetag_ref *ref)
> > +{
> > +     page_ext_put(page_ext_from_codetag_ref(ref));
> > +}
> > +
> > +static inline void pgalloc_tag_add(struct page *page, struct task_stru=
ct *task,
> > +                                unsigned int order)
> > +{
> > +     union codetag_ref *ref =3D get_page_tag_ref(page);
>
> So the more optimal way would be to test mem_alloc_profiling_enabled() he=
re
> as the very first thing before trying to get the ref.
>
> > +     if (ref) {
> > +             alloc_tag_add(ref, task->alloc_tag, PAGE_SIZE << order);
> > +             put_page_tag_ref(ref);
> > +     }
> > +}
> > +
> > +static inline void pgalloc_tag_sub(struct page *page, unsigned int ord=
er)
> > +{
> > +     union codetag_ref *ref =3D get_page_tag_ref(page);
>
> And same here.
>
> > +     if (ref) {
> > +             alloc_tag_sub(ref, PAGE_SIZE << order);
> > +             put_page_tag_ref(ref);
> > +     }
> > +}
> > +
> > +#else /* CONFIG_MEM_ALLOC_PROFILING */
> > +
> > +static inline void pgalloc_tag_add(struct page *page, struct task_stru=
ct *task,
> > +                                unsigned int order) {}
> > +static inline void pgalloc_tag_sub(struct page *page, unsigned int ord=
er) {}
> > +
> > +#endif /* CONFIG_MEM_ALLOC_PROFILING */
> > +
> > +#endif /* _LINUX_PGALLOC_TAG_H */
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 78d258ca508f..7bbdb0ddb011 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -978,6 +978,7 @@ config MEM_ALLOC_PROFILING
> >       depends on PROC_FS
> >       depends on !DEBUG_FORCE_WEAK_PER_CPU
> >       select CODE_TAGGING
> > +     select PAGE_EXTENSION
> >       help
> >         Track allocation source code and record total allocation size
> >         initiated at that code location. The mechanism can be used to t=
rack
> > diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > index 4fc031f9cefd..2d5226d9262d 100644
> > --- a/lib/alloc_tag.c
> > +++ b/lib/alloc_tag.c
> > @@ -3,6 +3,7 @@
> >  #include <linux/fs.h>
> >  #include <linux/gfp.h>
> >  #include <linux/module.h>
> > +#include <linux/page_ext.h>
> >  #include <linux/proc_fs.h>
> >  #include <linux/seq_buf.h>
> >  #include <linux/seq_file.h>
> > @@ -124,6 +125,22 @@ static bool alloc_tag_module_unload(struct codetag=
_type *cttype,
> >       return module_unused;
> >  }
> >
> > +static __init bool need_page_alloc_tagging(void)
> > +{
> > +     return true;
>
> So this means the page_ext memory overead is paid unconditionally once
> MEM_ALLOC_PROFILING is compile time enabled, even if never enabled during
> runtime? That makes it rather costly to be suitable for generic distro
> kernels where the code could be compile time enabled, and runtime enablin=
g
> suggested in a debugging/support scenario. It's what we do with page_owne=
r,
> debug_pagealloc, slub_debug etc.
>
> Ideally we'd have some vmalloc based page_ext flavor for later-than-boot
> runtime enablement, as we now have for stackdepot. But that could be
> explored later. For now it would be sufficient to add an early_param boot
> parameter to control the enablement including page_ext, like page_owner a=
nd
> other features do.

Sounds reasonable. In v1 of this patchset we used early boot parameter
but after LSF/MM discussion that was changed to runtime controls.
Sounds like we would need both here. Should be easy to add.

Allocating/reclaiming dynamically the space for page_ext, slab_ext,
etc is not trivial and if done would be done separately. I looked into
it before and listed the encountered issues in the cover letter of v2
[1], see "things we could not address" section.

[1] https://lore.kernel.org/all/20231024134637.3120277-1-surenb@google.com/

>
> > +}
> > +
> > +static __init void init_page_alloc_tagging(void)
> > +{
> > +}
> > +
> > +struct page_ext_operations page_alloc_tagging_ops =3D {
> > +     .size =3D sizeof(union codetag_ref),
> > +     .need =3D need_page_alloc_tagging,
> > +     .init =3D init_page_alloc_tagging,
> > +};
> > +EXPORT_SYMBOL(page_alloc_tagging_ops);
>
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

