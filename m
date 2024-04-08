Return-Path: <linux-kernel+bounces-135740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C4789CA9B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72441289250
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6E6143C47;
	Mon,  8 Apr 2024 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSoxZIyQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BB963CB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596634; cv=none; b=i4iONPL7B8R4gGa4kVKzXXaDPQDRCyctNLkcTElC2ezr36XC/CvREtqavEUX0CdG7wNJuReHpYDvnJy00MgMv9dBBM0H+hGHUwNms0b8OWuQ4khJ19NbB6vUkwm5mfJrpZjyzPGvFXQ3h/OXOWrlDN+KhZs1YTpNC0GWkKskDwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596634; c=relaxed/simple;
	bh=xF4xeuz99ep8htCfVfsU9KUXsF8OcTckfAdeLONyRZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omsNy37Gt/Cwy67t2sSJ0teL02WE4ARh5Qko3L0t+5CuQBAgdqRH85k0dnLxEk9GoRYYHcyLhcbwPXz6jKiyVP5+iiokE0kh/A0T4+rrF5rol5b+izj/x0naDyzK9XNGgoGCTaAKoHo8NeoxX4ruID2OGLEZ0oGiOgPXdbs5JKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iSoxZIyQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712596631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WW0XvdmjMS/v2Hm/5i1sBEwUsjS5WooxJxuAgT2dOlY=;
	b=iSoxZIyQ75MWFP+IDBSc7I0pnTQE7htSMADhB/BCI1lubf2wy8lMIXoGmp4GnEDy5pVLLf
	+tHrYQWCIlSs7/ycngLM81EAt6nVNegWcL6aaK0DbawY/drhdcjthbKzm1K/zctA7TaCaA
	HM14sc5pjEM9vdA5+HbP/Ig3EEQCQz8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-DnGhOwyYMJeXyjzvqyw4sg-1; Mon, 08 Apr 2024 13:17:10 -0400
X-MC-Unique: DnGhOwyYMJeXyjzvqyw4sg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-56e5417ea5fso754583a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 10:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712596629; x=1713201429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WW0XvdmjMS/v2Hm/5i1sBEwUsjS5WooxJxuAgT2dOlY=;
        b=INNpks3IyfdWlDDpeePHvkuyYB57rDtdos25eGvfH3BOGOtrslusCmkLNnqS0R5XrJ
         P5LKG6SeN0yRmnPG19LpXt6aSIv/deZ3o2xFOjBug0cdFfMowTKMvFQzUZkCkneAJ2wP
         KoYYiySmjH2W8mEpdfgpE1GjfD61THnyWYyRnHgdq5hXgGfn9BBFzKChnTZ+n/AwX3pC
         VTaEp7HCWz0v9K/Id7TYAVLiV5RKHWkhWmPTOabPyYc8oAFG586LJl0VxGTljXmZ+zPU
         jxR5UigGo7MEt9pZN74LLXNM807o6YDHc6qcUOJi7yFNECAIkvOTq5zvgcummKp+SeAI
         qQ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7FbHQXYinFAdbh9DqxqFCwRqGyl7U9FV7IO7A2uqBdXcWse3bNcxNt2T5Cdj1j6R00pJ57l/UyGko4o2fTZIT09zP9Xs8Rr2ZWLtD
X-Gm-Message-State: AOJu0Yz8jx33W3poA1BnxkPG4+OjnwwlmO3pMDQzej03HRCsk687Ulle
	lu8gzTWDPTN2/WU8h89Bi2q7Mt8YnZemBzjcdAx8F76fa1OP5hSsfj+lRRAx6VcGg944EzyRFI+
	wny0zNoigBL0c1LrPsxypyT//JqRSpZr1HcUSOYloUmOuShN18WBz2AhCssZFInJXquYsQdqfVn
	f7qBcaW+SfQjch/SnCH/TrNXrNdVFYKyxx1Jko
X-Received: by 2002:a50:bae3:0:b0:56d:eef4:28f0 with SMTP id x90-20020a50bae3000000b0056deef428f0mr8272257ede.20.1712596629302;
        Mon, 08 Apr 2024 10:17:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAF1+hbaATpPBSLsawJT9hD9ZY/wEezf8GBaxPQ4bTaPU4MyEkTrtk9mJjETJCu6N8z9MdWpNoScSpWk06qzY=
X-Received: by 2002:a50:bae3:0:b0:56d:eef4:28f0 with SMTP id
 x90-20020a50bae3000000b0056deef428f0mr8272229ede.20.1712596629007; Mon, 08
 Apr 2024 10:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
 <20240408-hid-bpf-sleepable-v6-3-0499ddd91b94@kernel.org> <ed027c1d54cb588914602a84fa12dfb2a9a403bd.camel@gmail.com>
In-Reply-To: <ed027c1d54cb588914602a84fa12dfb2a9a403bd.camel@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Mon, 8 Apr 2024 19:16:57 +0200
Message-ID: <CAO-hwJJtrNDcJVcsU_XpS_HxXgwVXYQiAoia_UKnd1-rjCGguw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v6 3/6] bpf/helpers: introduce
 bpf_timer_set_sleepable_cb() kfunc
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 4:31=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2024-04-08 at 10:09 +0200, Benjamin Tissoires wrote:
> [...]
>
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index fd05d4358b31..d6528359b3f4 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
>
> [...]
>
> > @@ -2726,6 +2764,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> >  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> >  BTF_ID_FLAGS(func, bpf_dynptr_size)
> >  BTF_ID_FLAGS(func, bpf_dynptr_clone)
> > +BTF_ID_FLAGS(func, bpf_timer_set_sleepable_cb_impl)
>
> Note:
> this hunk does not apply cleanly on top of current master.
> The line 'BTF_ID_FLAGS(func, bpf_modify_return_test_tp)'
> was added to the list since last time current patch-set was merged.


Oops, thanks for the update.

Just to be clear, I already mentioned it in the cover letter, but this
series is not intended to be merged just now (thus RFC again). The
plan is to add a new bpf_wq API on the side, and compare it with this
v6 to see which one is best, because I am trying to force the
workqueue API into a timer, when it's getting further and further away
from each other.

Cheers,
Benjamin


>
>
> >  BTF_KFUNCS_END(common_btf_ids)
> >
> >  static const struct btf_kfunc_id_set common_kfunc_set =3D {
>


