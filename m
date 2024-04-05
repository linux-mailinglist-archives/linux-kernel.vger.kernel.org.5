Return-Path: <linux-kernel+bounces-133661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D4689A70E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B8A1F21923
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798B1175559;
	Fri,  5 Apr 2024 22:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEsePj8C"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6619917554D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 22:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712354654; cv=none; b=m7hqeiwseg8uVkemxWSG12G7aPZ9t5DiB5KGHTvg1lvlahjt8X2PGtQuthJaicyqgkcvalICOc5TZWj07DWok30UBRzT55/OMVuwPz+IY+NsKiQpa40YKsEKVAWLHraAs8y/rU2gBnlmAm2kDPuj/sXz38awuQWRpwxxSG0XvgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712354654; c=relaxed/simple;
	bh=qxo1/yqNlK/uqSWUMYu5FdFHnhznfqlj26MmxlTPIc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcWGWAz6wXghhEw33ft5Rv1ExkBmJ9Gw/3S2SNys/9cizfjmbYO7RZyy+kfEXP6pzH9sUVz1RSLbTHGw1Ib4420sglUPph+L33WZoJyaKDETT62GKPzC/yiyaG5av2degbv2xqW06tnY9q3ZVrdektraOQ5gDZ9II2xrzQQ/jkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEsePj8C; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a4f7a648dbso1397533eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 15:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712354652; x=1712959452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvvf4g26OzQ7AjS7BC0DWpau/lYPZIFPXocYGg3AheM=;
        b=GEsePj8CKMQsykYy2+qofB/XMMjada6EX391AJqq8xrl+FVsZaRHBFQNL0g41YwEjr
         Xn6Y2vz+KSQRGaEwKBvegAsgUTVW+o4ySW1ToRKwdJEHEnw2uGTWICYeqsut1X/E1ljk
         N5NzllT94U+jmn5LeJYIitmorXUbwYTMH54d/MZmSRqQYykIXPh62hw2qgaXzY7oIk4C
         MnkL/mWa5r1g7RBr8vlFKhLj17YsvOD+53XR8aYnWIoYRkCMIn4jAcvpj7mYxy/YVMnD
         CLl4h4TycnbJHqVY/zXkb65hAFSVXpg/4xSqUnQ7a+fFFxUHVypWZN8K5oKZHyCzaK8w
         Rq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712354652; x=1712959452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvvf4g26OzQ7AjS7BC0DWpau/lYPZIFPXocYGg3AheM=;
        b=MYeCCIxHS5P3kbUWfHJGr+zfFpZqa/j6QgstWbBH1rR79epRUfrbEHYmDaw7KmB4Wd
         l7pibI3YfIsQ3ykKAje+kh0K2wRV0ZJg/4CiRfjMLbMCq3qOjIL+szLZ18SZ1fKM9ilI
         6hjYeu5GNblSyS7wWjrqwJgDxpTX3dPmhN3CeDYS/GWCowwT/hVh+MKTc2utTHi8vVaU
         LcDBRSJMj+s/c8Hh/dMmFYF3BTDCeAGLSNH8hK6sg2PH5iia87DfaqJwS2qXsxz6JsQD
         tV1OqeF8R6MD0NXuLim2wPwp+Rt9IJPXK3zIMiFnflea16Su0UUxgfmzb3z0dXgStcMw
         XGZA==
X-Forwarded-Encrypted: i=1; AJvYcCVxEX/PmfRN4U4wd2c8rgydPLUL/DBx+w7i4NDiFsaK1zyEVi/lPIQ1jK9SKRKviIBlrD2BMpHjAkH1S594rXraYMYhj0JWMGry+Nxl
X-Gm-Message-State: AOJu0YzSM34ljhoU2Hqm7Y5hUMMGvLlHm3684KGLozU4rDgJYN76SR7K
	zPbR4G7J3GF13JW1/FrfdcxDjpW+N5adm9jljE5Bf9vLeBdP2hnBdynK3jgeR8sm4dxNVLo6uEe
	If0sWK1fm9QnP90MEbV3U7ISVc8Q=
X-Google-Smtp-Source: AGHT+IHvjFxH0+jgB0lMROHxOkAjg9FGDRQxW2XIaxWhyBPsgkgcaFWFHZcxsEAJoN8TKZL0gINjC0BfClmWG0dCcoo=
X-Received: by 2002:a05:6359:4194:b0:183:fb08:7fcf with SMTP id
 ki20-20020a056359419400b00183fb087fcfmr2743281rwc.7.1712354652248; Fri, 05
 Apr 2024 15:04:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405102704.77559-1-21cnbao@gmail.com> <20240405131140.8881aae1af0d877dc70c8ea9@linux-foundation.org>
In-Reply-To: <20240405131140.8881aae1af0d877dc70c8ea9@linux-foundation.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 6 Apr 2024 11:04:01 +1300
Message-ID: <CAGsJ_4zpKmha2YtnsuDdda9_w4MtPZrk=SbdnBhJbdoA9HbogA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] mm: add per-order mTHP alloc and swpout counters
To: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com, ryan.roberts@arm.com
Cc: linux-mm@kvack.org, cerasuolodomenico@gmail.com, chrisl@kernel.org, 
	kasong@tencent.com, peterx@redhat.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, yosryahmed@google.com, 
	yuzhao@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 9:11=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
org> wrote:
>
> On Fri,  5 Apr 2024 23:27:02 +1300 Barry Song <21cnbao@gmail.com> wrote:
>
> > The patchset introduces a framework to facilitate mTHP counters, starti=
ng
> > with the allocation and swap-out counters. Currently, only four new nod=
es
> > are appended to the stats directory for each mTHP size.
> >
> > /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
> >       anon_alloc
> >       anon_alloc_fallback
> >       anon_swpout
> >       anon_swpout_fallback
>
> Please let's get these documented?

Sure, I will do it.

Furthermore, after careful consideration, I suggest renaming anon_alloc to
anon_fault_alloc and anon_alloc_fallback to anon_fault_fallback. This
renaming is consistent with the naming convention observed in
thp_fault_alloc and thp_fault_fallback in vmstat. Additionally, this
modification will facilitate the handling of large folio swap-ins.

/sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
           anon_fault_alloc,
           anon_fault_fallback,
           anon_swpin_alloc,
           anon_swpin_fallback,

Otherwise, without this renaming, it would be difficult to
differentiate fault_alloc
from swpin_alloc.

Hi David, Ryan,
I would also appreciate your input on the modification I am considering.

> Documentation/admin-guide/mm/transhuge.rst seems to be the place, and
> under Documentation/ABI.

Thanks
Barry

