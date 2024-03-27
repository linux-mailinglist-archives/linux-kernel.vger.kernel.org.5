Return-Path: <linux-kernel+bounces-120330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6A488D5E2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B7D1C240EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C764818C3D;
	Wed, 27 Mar 2024 05:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H4dWE6S3"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F211862A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 05:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711517430; cv=none; b=jUapcaGtGK8JICjKK6mMYGXzNS6s4B3yNQSQ52ub4pBbh7Zgw/4F+TWHXC5qoub1MbrYH0v4B8QwcdN9KgoX7nzCxVAijlXpnjuxI1VRrchJblUcyNiUnzC1+Gq1xBslb8ut16RfvPKK77RIXvGxgmf/zMp1SJrRdVOTaLghhRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711517430; c=relaxed/simple;
	bh=byCnV2tPaGestbeTssXGbJuf2T1qGlLsaVMMKNfKmYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbSOuLgA1Cf5XmzJO186SMF4fTP/DS8QA3H0XDHBky7Ghbsk425BlcYxXWw9zJVrZrYNZCg8wrOwMgfpRBGBlBLSEnNb3XGfaQIRwq1Zl6DufTPWEeAxygGNInCwF8HN/uCID5gKmzKQ4OtIfcQsmBbPHma0ZDaWFAnKMDNgPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H4dWE6S3; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-db3a09e96daso5914615276.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 22:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711517427; x=1712122227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46OYyrCzIWWF/3s+Ae2ZfY3Ah+E/dlrHPDoFMxmXEao=;
        b=H4dWE6S3Lc3hqYO1sKhYJkiR4ngLzZyvVYtVjk6tIfKr94pOSJBpX5TTFsn7qYvlqb
         VPUk3MEbLH79NgTN4KlgF69RpOnzgt64bma8ky1bdkLKz6yRqJdo+3poLI2znug6HJ+S
         c7lvf8mJ/TgvvdoM5IR00+p5dNOXx94t1fpD4EURBZQ13rgSyBqg2KpoRXL5EEQIPvhw
         XnWPmRFobyuzkiu8XR3Ze9Y/2qbllEz0WZx9Qc+3ylbpajK/ppXIK7txR5jtctgzHBLE
         oV8Zg30mKW/0y7ooBsaBI/uo3LynSKdk0OkbJddTzA7VHi8B/02eBs6O28OsMBnXvmop
         cLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711517427; x=1712122227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46OYyrCzIWWF/3s+Ae2ZfY3Ah+E/dlrHPDoFMxmXEao=;
        b=HFTTqE5vdu+YTdCRjR6wbXeMqXMv2KTd03BX/b8497TMwlhOHhCyv0Cx21vA1M137m
         0NaJMytHzvGLnEjzD4baNjODCPqQYRLiFWVCW/+V40ZHGf91b+dGQSAudtKYFFan0pNT
         TDnw+D4wBIkjIWj0hZAOWj6yoeyWD9fdev69HwSJh1b08iJkyGwJUJh+PMInvCucXUMI
         ObGc9Rr4YxOdWLoEpPipLmJXHRWhQa3nESHiC0f3Yd4Qk4oJ/e8ERXWhK90CcX85hJ1Q
         w5WFykgRN/8gYZzSChPEIr2PSp0xXLzhF9iDQzoRXz6JnAaxXxq61fN+FUZVBKrQcFj/
         jPrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrSX8Rfl/JMoK9ly/u/XZfFxzsmgK5sw+rkH67/zPNyiacb9vcc7mXOVKRGt30m96OkmWONzbSshLGJ7rS9S+EAI6IBgYBFENglIlG
X-Gm-Message-State: AOJu0Yx2vHGWSF8z2Oijt0v1/qtMgOYewBaEG9Hsgtm6R5Vaz+Dr2LH8
	MNGwPVBxWJ2B088TpK2NTf7M1NsdO9+aOBvwnA32H90rjV4sZfn51LClHr4MAx6I2pO0NdpjfgP
	KBYrJ43NqnmH5bVRsJs8tH2UdsN5sNMcu3ccN
X-Google-Smtp-Source: AGHT+IFT6iFfr000Obf+QkmvoSbVZfaj9pcC2FQUNkJVJksAYv7Nlrl9Jv8X4rApffkwMtrulh3M2VuGxqjpuh7DHmA=
X-Received: by 2002:a25:db42:0:b0:dc6:be64:cfd1 with SMTP id
 g63-20020a25db42000000b00dc6be64cfd1mr104510ybf.36.1711517426957; Tue, 26 Mar
 2024 22:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com> <20240321163705.3067592-15-surenb@google.com>
 <ZgI9Iejn6DanJZ-9@casper.infradead.org> <CAJuCfpGvviA5H1Em=ymd8Yqz_UoBVGFOst_wbaA6AwGkvffPHg@mail.gmail.com>
 <ZgORbAY5F0MWgX5K@casper.infradead.org>
In-Reply-To: <ZgORbAY5F0MWgX5K@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 26 Mar 2024 22:30:14 -0700
Message-ID: <CAJuCfpFaiQjOr5jWiNbz_B3ycrgNTfw+Vbpyk9EHqvek4bDPsA@mail.gmail.com>
Subject: Re: [PATCH v6 14/37] lib: introduce support for page allocation tagging
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
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 8:24=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Mar 25, 2024 at 11:23:25PM -0700, Suren Baghdasaryan wrote:
> > Ah, good eye! We probably didn't include page_ext.h before and then
> > when we did I missed removing these declarations. I'll post a fixup.
> > Thanks!
>
> Andrew's taken a patch from me to remove these two declarations as
> part of marking them const.  No patch needed from you, just needed to
> check there was no reason to have them.

Sweet! Thank you, Matthew!

