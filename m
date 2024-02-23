Return-Path: <linux-kernel+bounces-79021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCF9861C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE4F1C23396
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E661448E7;
	Fri, 23 Feb 2024 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpCi4S7E"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1294A13F010
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716414; cv=none; b=nQfdBbdgGgoNjM0aLj9N/FUyL3QJS+AwRoetvvZPM3+X50DYqZQHmopuD57u3VLlis2+PFAlQ3fOzrksA7FZ/j9ol578liAYr5WVecEssYIJkxUo324dKe15HcSy3zSSnFLh/J3Pm9e2N+M0A2s2b1PzqPU8R4qBSezoEw8SF5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716414; c=relaxed/simple;
	bh=R6zUV9LQ644WPBwU2nAdaKkCRupl6ITF2pP4ziWZMV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBBSq6NPYEYjThQK3zxT7RlDmtwBA+kH+eiDQCcUSwIPYIM6aH7LrpaHyZJ7HsrW2GoJaxHD+/gF0HmVn3JAwvW2ySpkqnSHDkw1OdGN9QdEbevu48b7Xg7VcTf24Rt46Ipeq0arjixZVOev24UWHRSk0Ox1sen/Vl6VFb15GHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OpCi4S7E; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60822b444c9so9491617b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708716412; x=1709321212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6zUV9LQ644WPBwU2nAdaKkCRupl6ITF2pP4ziWZMV0=;
        b=OpCi4S7EIle74AF4FZHaIEyLZXNxInq/DezUptdf3Dtyp+NkJo+dehUdZWG2qusLIi
         bt8qF0ES+0LRUSPqWcX3BhMdXjaIdmafbMwRL9IPIvSNXVQcek1Jj0OLzR/dzhi+w7to
         dAXnDGoFer1u6qbebk7TeotLVef6+Rz6kG/IIQYYpJYnHAms2nBdwshn2RMbFLixh9yV
         eZZ0uK4Fjh1XP2wbWR9k7FrQhpvdHVp19ivE5SZkX2rlJbmBquB+IxJZ7azGQfDfOpLl
         DtRq+AvFDvwCsisaBmPWMyn88TDIfYFY/bu64HZB+J1w9y9ZRnJSSKlJoV24LCl5T0vH
         ZewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708716412; x=1709321212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6zUV9LQ644WPBwU2nAdaKkCRupl6ITF2pP4ziWZMV0=;
        b=OAerv0IDt5ZIpAnC43EKvy9Mi8v655kJyZeEK8rIIymEg1Nnb2hiOfB5drdQi4zhKg
         Ksg9nKNTz/H/EBUWhn55z04DCCCqFlDR1qUKV8N9L2j/lELd2pxSdz0TQC2l2E6UkNwU
         ICIR7RZh4UdyceGALhroJk+VjKGR2U8KTbmti2GUW4KOOzdW+HUNqe6qHWBeJgRAEGur
         n7QKYNFT0Ls21qqXAywtJVicYw/bDvv6YiHN2wzcJK6uRDR0XlnMONGj84dSkSXHFLLH
         dl/pKgwUSXwC8kizNJxbeYEfYUX7+4Z1FA8xp0fVxF/nHOTNjNOG3nLBlSXsjCK+ceVW
         bAZA==
X-Forwarded-Encrypted: i=1; AJvYcCVows5Xb/UjE/0Ov0Ao1sFgF8nYR5Z3ajewDPIqYa7+3aiDcNbjgojz6fI/yZGX9ETEVEutorinY2tvYKyycdir44JuP/kz1Ejv5f2d
X-Gm-Message-State: AOJu0Yx5UxnQLVVcjIc8rteNb6I4IsAommWhETo58j9TIu3uT1zQ7NOW
	awiJ82F98SKQ7X6QoM3bP+gar1ooMAkKhqgV3KxrLke33p37MmCH5wrJ0dzKIQAEN2GtTJY6YmN
	QkUtT2mBOFoxI3dWOYWNglbuvG+AWlxVd0Xwv
X-Google-Smtp-Source: AGHT+IE/Pl6hrmaYgXKRMYbWWj3alWqUpkDIYPYsJjZVZ7mPx6TO4HEVqSuGco97bbBAS2NUd8BFNQPQR2paQWXSoCg=
X-Received: by 2002:a25:2653:0:b0:dc6:b088:e742 with SMTP id
 m80-20020a252653000000b00dc6b088e742mr843579ybm.8.1708716411749; Fri, 23 Feb
 2024 11:26:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-7-surenb@google.com>
 <Zdc6LUWnPOBRmtZH@tiehlicka> <20240222132410.6e1a2599@meshulam.tesarici.cz>
In-Reply-To: <20240222132410.6e1a2599@meshulam.tesarici.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 23 Feb 2024 11:26:40 -0800
Message-ID: <CAJuCfpGNoMa4G3o_us+Pn2wvAKxA2L=7WEif2xHT7tR76Mbw5g@mail.gmail.com>
Subject: Re: [PATCH v4 06/36] mm: enumerate all gfp flags
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
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

On Thu, Feb 22, 2024 at 4:24=E2=80=AFAM 'Petr Tesa=C5=99=C3=ADk' via kernel=
-team
<kernel-team@android.com> wrote:
>
> On Thu, 22 Feb 2024 13:12:29 +0100
> Michal Hocko <mhocko@suse.com> wrote:
>
> > On Wed 21-02-24 11:40:19, Suren Baghdasaryan wrote:
> > > Introduce GFP bits enumeration to let compiler track the number of us=
ed
> > > bits (which depends on the config options) instead of hardcoding them=
.
> > > That simplifies __GFP_BITS_SHIFT calculation.
> > >
> > > Suggested-by: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> > I thought I have responded to this patch but obviously not the case.
> > I like this change. Makes sense even without the rest of the series.
> > Acked-by: Michal Hocko <mhocko@suse.com>
>
> Thank you, Michal. I also hope it can be merged without waiting for the
> rest of the series.

Thanks Michal! I can post it separately. With the Ack I don't think it
will delay the rest of the series.
Thanks,
Suren.

>
> Petr T
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

