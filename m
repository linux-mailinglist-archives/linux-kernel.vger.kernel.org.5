Return-Path: <linux-kernel+bounces-98661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83E9877D86
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C92CB21233
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0839E2209F;
	Mon, 11 Mar 2024 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qn95L+Ym"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DA614F75
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151290; cv=none; b=Te63ODOWPAJK08TNVYL9hllz0TPNWDflTEPJ6yYNiD31enNNaMGLhvXhaZydIl15Xbc2Gxd7a/TqZJ1/YD6klgPSusCcYDsj328uUEmh8BlISVJeOZZrOyoSlfuSH4fMJnroxlhzRmGr13Jbmfb6BmSFfIJSNdlE4b+cjaIL3bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151290; c=relaxed/simple;
	bh=zjVrxa7jT6Alb18qUv/5fbPGQg11qSCep3Z1UEbuvQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nocPsLXvLUQ+45OO/CPngmItsp+tvWG9ZjmfznGFK78EZjIgQ8xpNbyv8hTZCj5zfVZQg5tVddFkhz3Z7/uBYR3GyM2PCUORsTjbl694DytrPL5uNNHDWlH3EXlzO70ViJuWMNbz7/zNon35thVXP5Ck/kBc6M6XTTQ/4eoZZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qn95L+Ym; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4d37e76a3dfso2660434e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710151288; x=1710756088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjVrxa7jT6Alb18qUv/5fbPGQg11qSCep3Z1UEbuvQw=;
        b=Qn95L+YmJWgFvbI/EOSjFPvsTDQ7Sz11cyxo9XxwXfFNNR+Qxux4z8G7GrsGXXgdQQ
         LO77pZjvUIfdwHzy8QKm9rwJE+GKHWcGX61y6Kb1vna12S59jrjitQ4iWT/GewD76Wk1
         jIjI1X1N1wdWKNzi9jmxgiwAal+Y8MQgcX2BA89w9tGM4H5wSSpZ5u0rWo/M+5cWwwho
         h3iJbcOwRBmS7eZPDuwV+LqFeuomBQlw+IlPC65sFYqhQAL+3z2+5wyg4bhheUqhZWPT
         2a7lycIgyWIY38TqIAVF2XuorMAhpKgv4XnR0DQ5rYgG827Hn1bBsQfP89YAvzPHZXzM
         FPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710151288; x=1710756088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjVrxa7jT6Alb18qUv/5fbPGQg11qSCep3Z1UEbuvQw=;
        b=JpGfxbRYcJyt82OgdB6eXnhQ54+qUktAPszwEWc0OWWPMPbbNQxK5JyHmPdoahu9h/
         LTKtWh/tb3Af6ee+kEHNCGUrkgRXw8PknowjKx83RyvNgCCvSySGZXrxMp4JqX/PdRpD
         FJdj3sNzChcIAV/LxF9ZRs3qAyu/VtdkpKqicpbJGPaWxJ0VXa9mL6dhdlUTAgK35w31
         Ze0BT2urSguKBQ9S3XSDpGO+BBSFd8sKd0GT2dfjbQitUhF5DITODCBYSqt41yeg8AmY
         MWx9zuObr9WFpkBCL46/WAxbx/ruGMqveGVkG7Xxw9CW6dh8n8w/81sOLn/tdSOuDZJu
         XplQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtMKQrl39/EcbudSIkIBHtkJMouIUF62LMefNpVD1it4HYAvi4USl8kpnNS/uKgOXwHUIdJPzSjhlHeUXw7kzMVdxA1WB3x1I/GZ/e
X-Gm-Message-State: AOJu0YwuhplGOUJedEnGJsmC60GdsGUn1ZB6xFGn/KkXDQNkVTZoer3z
	pE0Pa8pbDQt1JwyjK2SEerkIXBlAvQPBCc302M97w07hwHp1upX5kBX9xpIJC/fGmcta+MYY/zW
	w+e5sLbhXPUULuTfTXVB3fnhweTs=
X-Google-Smtp-Source: AGHT+IGxp3cW+5nvOi2fDqLJuWZzS8i8Sc1PON+TaPD2t8dC1BxYiROYmtRJuAZ0N1ha9jWhKW0w3EUwD8w4EtiPhZ8=
X-Received: by 2002:a05:6122:449b:b0:4b9:e8bd:3b2 with SMTP id
 cz27-20020a056122449b00b004b9e8bd03b2mr3514927vkb.2.1710151286195; Mon, 11
 Mar 2024 03:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307061425.21013-1-ioworker0@gmail.com> <CAGsJ_4xREM-P1mFqeM-s3-cJ9czb6PXwizb-3hOhwaF6+QM5QA@mail.gmail.com>
 <03458c20-5544-411b-9b8d-b4600a9b802f@arm.com> <CAGsJ_4zp1MXTjG=4gBO+J3owg7sHDgDJ8Ut51i1RBSnKnK0BfQ@mail.gmail.com>
 <501c9f77-1459-467a-8619-78e86b46d300@arm.com> <8f84c7d6-982a-4933-a7a7-3f640df64991@redhat.com>
 <e6bc142e-113d-4034-b92c-746b951a27ed@redhat.com> <d24f8553-33f2-4ae7-a06d-badaf9462d84@arm.com>
 <CAGsJ_4za-2xpg21phWi2WWLF1iPXhoc1xM__FDTwYYBBKsTPgw@mail.gmail.com>
 <a07deb2c-49e1-4324-8e70-e897605faa9d@redhat.com> <b1bf4b62-8e9b-470f-a300-d13c24177688@arm.com>
 <b174d4e1-e1ef-4766-91bc-de822eee30fb@redhat.com> <CAGsJ_4xXS0MsxRVTbf74DY_boQVUE2oP=AP6JmdXZSqsAOZzRQ@mail.gmail.com>
 <f3b1cb43-cb33-4db4-a3dd-0c787e30b113@arm.com> <CAGsJ_4wGe9SdMvojw_2XchEttrbww3RttoOENoF-O4bLWUd_rw@mail.gmail.com>
 <60dc7309-cb38-45e3-b2c0-ff0119202a12@arm.com> <CAGsJ_4yaJ5weXd8N=zwoo1xa8jvEdZnFOGQ0pjUXB1EUsrRTcA@mail.gmail.com>
 <37bc1a30-7613-4404-b123-c351e36fc800@arm.com>
In-Reply-To: <37bc1a30-7613-4404-b123-c351e36fc800@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 11 Mar 2024 18:01:14 +0800
Message-ID: <CAGsJ_4xWyA1qtTR=iNukJ7=RqqJAxc2hXZSX6LtP3WbcEK5g9Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>, 
	Vishal Moola <vishal.moola@gmail.com>, akpm@linux-foundation.org, zokeefe@google.com, 
	shy828301@gmail.com, mhocko@suse.com, fengwei.yin@intel.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 5:55=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> [...]
>
> >>>>> we don't want reclamation overhead later. and we want memories imme=
diately
> >>>>> available to others.
> >>>>
> >>>> But by that logic, you also don't want to leave the large folio part=
ially mapped
> >>>> all the way until the last subpage is CoWed. Surely you would want t=
o reclaim it
> >>>> when you reach partial map status?
> >>>
> >>> To some extent, I agree. But then we will have two many copies. The l=
ast
> >>> subpage is small, and a safe place to copy instead.
> >>>
> >>> We actually had to tune userspace to decrease partial map as too much
> >>> partial map both unfolded CONT-PTE and wasted too much memory. if a
> >>> vma had too much partial map, we disabled mTHP on this VMA.
> >>
> >> I actually had a whacky idea around introducing selectable page size A=
BI
> >> per-process that might help here. I know Android is doing work to make=
 the
> >> system 16K page compatible. You could run most of the system processes=
 with 16K
> >> ABI on top of 4K kernel. Then those processes don't even have the abil=
ity to
> >> madvise/munmap/mprotect/mremap anything less than 16K alignment so tha=
t acts as
> >> an anti-fragmentation mechanism while allowing non-16K capable process=
es to run
> >> side-by-side. Just a passing thought...
> >
> > Right, this project faces a challenge in supporting legacy
> > 4KiB-aligned applications.
> > but I don't find it will be an issue to run 16KiB-aligned applications
> > on a kernel whose
> > page size is 4KiB.
>
> Yes, agreed that a 16K-aligned (or 64K-aligned) app will work without iss=
ue on
> 4K kernel, but it will also use getpagesize() and know what the page size=
 is.
> I'm suggesting you could actually run these apps on a 4K kernel but with =
a 16K
> ABI and potentially get close to the native 16K performance out of them. =
It's
> just a thought though - I don't have any data that actually shows this is=
 better
> than just running on a 4K kernel with a 4K ABI, and using 16K or 64K mTHP
> opportunistically.

 I fully agree with this as my Ubuntu filesystem can run on 4KiB, 16KiB and
64KiB basepage size as its elf files are 64KiB aligned. so I would expect
new Android apps/middleware move to 64KiB ABI though it might want to
change the base page size to 16KiB instead.
I believe this is the case.

Thanks
Barry

