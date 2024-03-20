Return-Path: <linux-kernel+bounces-108667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F2E880E2E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D03281638
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A147B3B78B;
	Wed, 20 Mar 2024 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RwKB+aGj"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA4B3A267
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925248; cv=none; b=DExwKV53yJnBiw7YXJeyJlTtd5gVNPKpt225spRqvMm2Y+k1+8LWf3qENc2e/WoK+xpdx+W58EtS7KOwgcMkGuXKAzQCB2vaAR4oxezYDY+J+wrHf5eGSkglRVhSZKnIzwwVahCzoD6ct87FuJtilKBc+peC407Y700LtoF6G9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925248; c=relaxed/simple;
	bh=GxX4yjbT3GwdNMcd+Ct1bJeUSjEYV56Khz3rzfwa7t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIcRWkD2ooke4jxXkShTKgFU57B7i+UeIveAV9hPR1bb6VhRnAZ2gUTsvQ4/S1XwmzJkR/coFAb8Ec2/uotk9NPk+R/DZRE/SV8yprnLkaFydX7lbbAdW+BESDUY/f8R2/qj/g8ttA7EZYbbSUiKJ/Uq2JmOFSbvVXJU4uTWmgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RwKB+aGj; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6918781a913so30439286d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710925244; x=1711530044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/kfxvi+pcqoUxKaQPTH3Bpr3S7uOGIOTjzRG7qFRLM=;
        b=RwKB+aGjvpm7eBcuPr3Gnm865ospLRmCrVUBQG9ni39ylut7hbhl6nW2K81tLf8iaS
         dl0uZtaXM7OQrAIfm54qSqggnPCL9v6pKBCd1nmOiBiFEBJeOA9YxbfdMIcY1E/zQTER
         /sMlU75RseBNx38Nru1jLgrtZ6jBVhJVKKJ+q+yF1JYzAQc4XerRyvNZW5iMov4QEXW7
         G9JsrIlyg7fFX4MzuxZF54vIWgdEPwr4XRxusM1lM0Q72m64v8v39Bu5ISVCbkbHAQqX
         ilfW8HRPbLBtaaOSOTW5yKJq/1i91qPhPa5b3D9CzGSyj+qTaK/LDc7WKmjMj56DGLeY
         P6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710925244; x=1711530044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/kfxvi+pcqoUxKaQPTH3Bpr3S7uOGIOTjzRG7qFRLM=;
        b=c3QS5arJQU0tTIgk6mInUpanknjaDP1rLOe5Cd0QHxT8DF343BNNWLq7XIAH1KIauH
         vHpjc3kD0ED5NjXlYZELcdpyV1F0LJIkAczZ7SLrNXJVa7QIY6UAbSY7EGO4Kmg4/P4B
         p7CYkubRLtp1x+zJyjuCuK0tMFR/j46OgrqiHEm1NFKJ5c5An8C3pgL6diruTq6opCz4
         NZy2k8nWSL5u3h9xhc32iLuEgVmLYOCu9o1r+tBM+sNb1uiLmmlzFnj+Da4geKI8CoaI
         7/9QTUyRGQ9JEgW6OF6uQBlYHuHoVgyohAhcwDznVk7QlHwTFk6FndcVdlFVAMf6VHp/
         9EXA==
X-Forwarded-Encrypted: i=1; AJvYcCUxWg87ZjsayXSMFC0+SM+CKFAn5PWMo9QriyEGZew9ywyeCyaD4c5ZOKfE74Rwxw+LSlE7ySX3FyjOoLQ2hCVELM2uolU7bcIt7TUJ
X-Gm-Message-State: AOJu0YzSXrnzZifKZ1wyW1jdGcGFii8VE4MzG+bq7fL3drxz+hz9d0DG
	PySNRLyOkTiv1hRPvx7RJmDa0OWu+nIfCUXcm1ElynPyW43bZ+hnWYUMnQZllJPnWyeylOtbu4g
	HLkIMP74S25F6GyPMiLO2BCixpwFUQRhVWODY
X-Google-Smtp-Source: AGHT+IFdknojmj33zo7DdapbICyB2mCQMV+kbQUUiXIDADNB7MmHbe6o+HzLDwjHbEm02dNXS2xHPqnBmETMecUgavw=
X-Received: by 2002:a05:6214:183:b0:690:c334:a5ca with SMTP id
 q3-20020a056214018300b00690c334a5camr19018977qvr.59.1710925244501; Wed, 20
 Mar 2024 02:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319163656.2100766-1-glider@google.com> <20240319163656.2100766-2-glider@google.com>
 <CAHk-=wh_L4gKHEo6JVZxTZ7Rppgz1b5pt2MJyJ2mZ-A8-Mp0Qg@mail.gmail.com>
In-Reply-To: <CAHk-=wh_L4gKHEo6JVZxTZ7Rppgz1b5pt2MJyJ2mZ-A8-Mp0Qg@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 20 Mar 2024 10:00:05 +0100
Message-ID: <CAG_fn=Wms_wnbfFSD6YAmzBZKxh2anX1t=9ehPyoNE8JW-7MVw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] instrumented.h: add instrument_memcpy_before, instrument_memcpy_after
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org, Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 6:52=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 19 Mar 2024 at 09:37, Alexander Potapenko <glider@google.com> wro=
te:
> >
> > +/**
> > + * instrument_memcpy_after - add instrumentation before non-instrument=
ed memcpy
>
> Spot the cut-and-paste.
>
>              Linus

Nice catch, will fix.

