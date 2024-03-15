Return-Path: <linux-kernel+bounces-104592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C57587D093
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B23C5B20E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EFF3FB9B;
	Fri, 15 Mar 2024 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BK1grvRy"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609713D575
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517634; cv=none; b=tI94xL5LGiHgE/y51StRHDIeBoQ/LSRUph42toRGzU25uJL10yRGCOvI9ivuJg0GRfp1Hnd3p5rQL1UFWaPE3qK1ZZA6kHz5lkud1N6VtVi6fwidGlcHLFp/E97pHqZDFAvto+Y/B5ndHjYnJpnPnqgzoRf9LJstmdEU2Mw5sK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517634; c=relaxed/simple;
	bh=wNtT6+0t+kGzkNhG5FyRgYZZ74DtQijFGV7l7mpb0Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqTGgCFLOZirYaJtdim4k+pdXDjiyxBIAnv/ca0vj8BHpGgrUxihrgBRQCfLRedWriL8jWPL1yl+JSlqKJYA1gitUi+MKLCPoWPDdvuYaVMlgggJT8eCYVkpccNYjSFvHMxZ4GXNtwblF0yamlYfL6Hu0/ONPGHRR71mEw+teuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BK1grvRy; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-609f3ca61e0so24125527b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710517631; x=1711122431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hTYJR/EPYVQveJbg5FctPr1PKFKWOQ5oCn+BSWzHW0=;
        b=BK1grvRy0GHfMYHQ/RADrgIOOArUHGsc9V9yMuEKUvHDWqdM6klTeI+9Z7Oam/sMoo
         Zs22/qsOuClHiTVqN7YvL/pFRDkWcsLJG3YdL0ZYBd17g4wf5f8aY51KGl26wOY17FH5
         kSrgnTgXtBg1H+IERx/QKVpNEp2fNdolrXUDJAWoMQwo/VkMHNldV/x9SYE+lgYVloK7
         TF2QoIVu4k8YJSGWZ/z/zvoyo2bHgLm2yOAps6MBjiHnpF9Xlkh/Aqo5kly72MY7s+Su
         mtst0LviU8A/+0YeiJwKtd+oq6cUXloRNoOqWuAG+lOG+LVr066k02W5V0atYmHs0t7y
         +S3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710517631; x=1711122431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hTYJR/EPYVQveJbg5FctPr1PKFKWOQ5oCn+BSWzHW0=;
        b=T+oAEMAdY+K/IlgNiJMjZSAdIpl5NYB9HWTG88DA3sMQDlMIOJ19VlwkzpNM0d9vIy
         xTKj8I8W25On0wsTuIkOTp/tMcU+cBfmKU6spULMLkdqKIThfUpuCwJ6Q5mH9vFCfDa9
         3fK7Tc8tikQPLg7IaM6rq2oyr/Luk+zu1wmfQ0blfgZaF10KQzaIEFynVJNpq4hK2IiK
         Rb6i7H1IKx53xcq3HODoRbb/Yzmhwnluo2DeJJCTLrdelfj7EAJSi0EdpAvag37d0xS3
         7eMJtQFm1TkTiFuR25PS/munVoCNSUpKGwExEBsCiAXWruZaFddBx/oU50QQsoK7PSSS
         a6Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVfRHebXEPnvfyY8D0FfVhX9gNMvej9Ttf0uqNWnkO0BYfOZ3/VWa7zdhWZ4a9eFoxbHr+hh4qwYygNfI8RnwoGfHGDfYC5efJii4dx
X-Gm-Message-State: AOJu0YyYAEHacUEMBmWyhFudGRVQ/LL4HzvB+wwdg13R3XdGHYDqakJm
	UgUmvewROst1G25RkeZ4qbqzZeuZUWAaoZliIP30qEr5NI2xYCAyImf7qXBGRR90Kv/6CjfB9dA
	8oZQDwgdOfMWd+ZHD4JTey5T0PelTegru5BZ9
X-Google-Smtp-Source: AGHT+IEwiyjib3jLb0fcW3RfIFy8PuKVxjXiqnQa/2aHEZk0YzBmdn1yExjQqvOF2tJR6SyIA+70XUnt7nI7TF8fE6Y=
X-Received: by 2002:a25:ad5f:0:b0:dc7:4f61:5723 with SMTP id
 l31-20020a25ad5f000000b00dc74f615723mr4966380ybe.39.1710517631010; Fri, 15
 Mar 2024 08:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com> <20240306182440.2003814-15-surenb@google.com>
 <ZfRaBJ8nq57TAG6L@casper.infradead.org>
In-Reply-To: <ZfRaBJ8nq57TAG6L@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 15 Mar 2024 08:47:00 -0700
Message-ID: <CAJuCfpEpMwfEgrsMALqpzH=3FL0WxrXY1bRkvezMdCw2BAtQRg@mail.gmail.com>
Subject: Re: [PATCH v5 14/37] lib: introduce support for page allocation tagging
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 7:24=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Mar 06, 2024 at 10:24:12AM -0800, Suren Baghdasaryan wrote:
> > +static inline void pgalloc_tag_add(struct page *page, struct task_stru=
ct *task,
> > +                                unsigned int order)
>
> If you make this "unsigned int nr" instead of order, (a) it won't look
> completely insane (what does adding an order even mean?) and (b) you
> can reuse it from the __free_pages path.

Sounds good to me.

>
> > @@ -1101,6 +1102,7 @@ __always_inline bool free_pages_prepare(struct pa=
ge *page,
> >               /* Do not let hwpoison pages hit pcplists/buddy */
> >               reset_page_owner(page, order);
> >               page_table_check_free(page, order);
> > +             pgalloc_tag_sub(page, order);
>
> Obviously you'll need to make sure all the callers now pass in 1 <<
> order instead of just order.

Ack.

>

