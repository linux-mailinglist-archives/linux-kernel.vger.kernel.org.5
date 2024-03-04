Return-Path: <linux-kernel+bounces-90343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 718C586FDF0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7C76B20DB6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFCB224F5;
	Mon,  4 Mar 2024 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZkovaIf"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2292208A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545677; cv=none; b=H895fldvzkqAx5sVCu4DkzM657vYtRQOGihO2paVuuN5g0nTwsW1i5w4MGPky934l5K6DwAoeeA7v60y1tPsDwza0uy8dtTSYugx7yHgeRGoiovKBbAmoxOIgKfghMz89L103kg+GvkZ2eayhtDM4HREmMF1nHkV7y6b4bLOZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545677; c=relaxed/simple;
	bh=ZtdvcX/E3Mi9kbZrfMUEg6nRfIoROdD5wqIV9+hHHtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PueWWfvEC5slcbQ/99Hfs9zZqQwM982xf3orSUBUdWq6JG3u7tb1ZGAOPeuHHp1civy4Exu4ptWWTUulMm8SeaC1kmZKBTANvr82KygePsWciD8jA5b/9Cy4ogS0FZTU80MSu8iDIcKYZO7z4i0TWawMGolEiARbU+khj51aEE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZkovaIf; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso4387998276.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 01:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709545675; x=1710150475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtTAWlcolDm95CcOT0+kG8RlO6Oklc2LqcK+9/CqwVk=;
        b=QZkovaIfmXwrK7E29cgggKvk1pUb0dClHIgt1zHP/6kWm1nah8ljKYRfQAcJ5cT4rr
         GxUUYbHtpoxndeoDdAAz6z00VdJoymBlaMuRvaZlHqvsjJydaWJFIrr0h/pKnoFQ7rkE
         zo1Ju2qwElkWVqlrVpbOK7IZvv1mNhKYSRi49RQ9qpKemJTd8WbspfL/NP+eGzYUeOiO
         JqarDvb55CSTh2o/v3i2DC6Ly7XmDxqD+DA3wT/FJ0ix0ssuygcvigvnxgZynWIh5ACs
         UhcIJI8OcTgpdOzaynwm1fNjL5NQYaptgA5HtSwNp+w7Jqq5KauEGTjqWtjAayFAHPTI
         zMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709545675; x=1710150475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtTAWlcolDm95CcOT0+kG8RlO6Oklc2LqcK+9/CqwVk=;
        b=vGsEf8x6j4Eps/UvCqDvuEAmyfPRFQj1MuWYrSX0KpQI5mo3IcM/q7Q3qJe2OWkJd2
         VBgMJ/Cd5eSObkj9CFu0+rRvn8J/KxA/PDEp1sdVM77HswDIFrGWKPsh+Bxv2amooPZt
         Sv6JKgszAETwcnHERWlQcuBd+7TftJ27vtVv6Crobz+nVZQ6DAmP3ddtiyqb/WpbWZBb
         9mOM/e7GAZdkr8oiXWQPBkzQ710jumqJaIV/IQcPcHxlXxjMTokmta2pSpPNhXJadZhA
         uLU6O0UP+XTGxC1QjbHqLI1XXkfkyS9WbsKsRVSuUr8osJ/vUuIBQjAtP+ccrETKQUWd
         hTtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9k2YDvdbERYgylSYiOFZoqqspZHZOfIT/6n1SbxFaTc7nwUzKGpTVbVPVj5JgTO2zm5K0jJ82Qqx+hn/wvQ694cThhCMA18fsZKKI
X-Gm-Message-State: AOJu0YxOU15BaTW5bvghR8KrDApMCkdbol4XcSPcV3yG2mCsNRwueOUs
	N4YQXgyDImt6ubq7UyCexyBJ21kNAExdOp5DReQYfQDxSKiAJyG1abR2wRFJ1QLfAYSIphRE5YL
	SZ3PTC7c92uIU5nl9cEh0a1nDpiO/utsOVZ2X
X-Google-Smtp-Source: AGHT+IHL15XlGsEqhMGIf1JQplfo0RmMQX3BCz1GHbz7gpTbQgXwyDmwg6jmYWyvdoTcYHLQdIu3AoU06gJbvuyEn60=
X-Received: by 2002:a05:6902:1345:b0:dcc:84ae:9469 with SMTP id
 g5-20020a056902134500b00dcc84ae9469mr5836261ybu.64.1709545674900; Mon, 04 Mar
 2024 01:47:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208152808.3712149-1-howardyen@google.com>
 <20240213055426.GA22451@lst.de> <CAJDAHvZGnzKPLaovRcq_Os1Fcixp2o1kY9GFV8VXztrmKahejQ@mail.gmail.com>
 <20240220055241.GA7554@lst.de> <CAJDAHvbOnAvW5f6oJUnuy2_5-vS7uJc13GQSNX_Nc25GJXSp-Q@mail.gmail.com>
 <20240223063723.GB11004@lst.de> <CAJDAHvZ4-mh8uMyq0NiPgWKGt=pS3teoJ0=ofCKZmLeqLXUVgA@mail.gmail.com>
 <602448f1-60a9-41a1-85d2-1205250985d3@arm.com>
In-Reply-To: <602448f1-60a9-41a1-85d2-1205250985d3@arm.com>
From: Howard Yen <howardyen@google.com>
Date: Mon, 4 Mar 2024 17:47:18 +0800
Message-ID: <CAJDAHvZte_566hLgoQSXKK9FhS1HTFpbHVd_0dFKN0i0n_+FMA@mail.gmail.com>
Subject: Re: [PATCH v3] dma-coherent: add support for multi coherent rmems per dev
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com, gregkh@linuxfoundation.org, 
	andriy.shevchenko@linux.intel.com, rafael@kernel.org, broonie@kernel.org, 
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:31=E2=80=AFPM Robin Murphy <robin.murphy@arm.com=
> wrote:
>
> On 27/02/2024 1:39 pm, Howard Yen wrote:
> > On Fri, Feb 23, 2024 at 2:37=E2=80=AFPM Christoph Hellwig <hch@lst.de> =
wrote:
> >>
> >> On Wed, Feb 21, 2024 at 05:27:58PM +0800, Howard Yen wrote:
> >>> The reason why I tried to propose this patch is that in the system I'=
m
> >>> working on, where the driver utilizes the coherent reserved memory in
> >>> the subsystem for DMA, which has limited memory space as its primary
> >>> usage. During the execution of the driver, there is a possibility of
> >>> encountering memory depletion scenarios with the primary one.
> >>>
> >>> To address this issue, I tried to create a patch that enables the
> >>> coherent reserved memory driver to support multiple coherent reserved
> >>> memory regions per device. This modification aims to provide the
> >>> driver with the ability to search for memory from a secondary region
> >>> if the primary memory is exhausted, and so on.
> >>
> >> This all seems pretty vague.  Can you point to your driver submission
> >> and explain why it can't just use a larger region instead of multiple
> >> smaller ones?
> >>
> >
> > The reason why it needs multiple regions is that in my system there is
> > an always-on subsystem which includes a small size memory, and several
> > functions need to run and occupy the memory from the small memory if
> > they need to run on the always-on subsystem. These functions must
> > allocate the memory from the small memory region, so that they can get
> > benefit from the always-on subsystem. So the small memory is split for
> > multiple functions which are satisfied with their generic use cases.
>
> I don't really see how that aligns with what you've implemented, though.
> The coherent allocator doesn't have any notion of the caller's use-case,
> it's just going to allocate from wherever it happens to find space
> first. Thus even the calls which would somehow benefit from allocating
> from the "primary" region will have no way to guarantee that they will
> actually allocate from there if it's already been consumed by callers
> who didn't need that benefit but just happened to get there first.
>
> Really that sounds like a case for having specific named memory-regions
> and managing them directly from the relevant driver, rather than trying
> to convince the generic dma-coherent abstraction to do things that don't
> really fit it. Otherwise I'd be slightly concerned that you're expecting
> to bake secret undocumented ABI into DMA API implementations where some
> particular order of allocations must guarantee a particular
> deterministic behaviour, which is really not something we want.

Thanks for the response.

The original problem I tried to resolve is the use-case explained in
the previous reply, and I was thinking of implementing it in a generic
way. Then I tried to submit this patch. As you mentioned here, it
provides the benefit that if somehow the "primary" region has no way
to guarantee for the callers. And my use-case is one of its uses.


---
Best Regards,

Howard

>
> Thanks,
> Robin.
>
> > But in specific use cases, they required more memory than their
> > pre-allocated memory region, so I tried to propose this patch to give
> > it the ability to get the memory from another larger memory to solve
> > the issue.
> >
> > I'll upload the next version to show the modification in the driver.
> >
> > ---
> > Best Regards,
> >
> > Howard



--=20
Best Regards,

Howard

