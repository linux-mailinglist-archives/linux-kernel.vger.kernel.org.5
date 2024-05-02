Return-Path: <linux-kernel+bounces-165878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB1F8B92D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEDC28407D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FA510F4;
	Thu,  2 May 2024 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxbAJYlk"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40394802
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 00:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714609854; cv=none; b=BI4y8KxFQkhXBRB/wkLoZitQsgiRcEir3dgWaWUJrcfBUCvWaR3ipj+tNmjY2pRFGb1+m/ZgfJNYIdvkXQnS5BsDoDPnduAzO/2PbUH7dbcMpnbWlbMIbOimVWiJ9ySDilpQWFZ5qiTjV4Xg4fO08O6c2etsO5r7OMoNJO1UdhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714609854; c=relaxed/simple;
	bh=XNc3xiDlFWmdQwJ9TuKuemRnBD5csEPygZcV/iRKUKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOQCuVMt+DX/6PKe5oA2/bq3Od6DygjvJN40TMsBVjW0Y02CHE9Rr3pnvqXgaSxfcYHALabqOpvCjeazN6kyp7r6hX929bHLOZFIr/9aQ7p6M2RMCYrqtT/GEp0PKOuV6G0WintmLbBZy1Sc5cg532M75MALBEVMR0+qax8JM+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxbAJYlk; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2dd7e56009cso95302761fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 17:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714609851; x=1715214651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kp562e4y9SulzbDyJ0IEKx2QOZQ2mnPE6n/S2UPXGwA=;
        b=bxbAJYlk7GhKArC9lKsM5vW2dTx66PZs9zNtN7A1hsnDDe2y3NhMXRTy4S0t7WCBSm
         dBlGmSImJdLxA40kvjdaHYGJSGHCJnzSUarlghIW1EbjlagiQu0G6DH2teinVESYX591
         XLuuOjPldNmghEJTlJlCLHo5h88bjFhYTYsB/1gxmLhShWkX4VeT5HeH6lIBk7rXRvwj
         Qnw+Rkt2GTPImfDRs9z1SmiKM5H/S+0H5C/TFuA2WjGeSOMfXszVkg+0B4knpDScTYmx
         homzQWG2WJs51O6lCDhBh/QZejx8LT67VGU1lSPfZqDSkOY3jDIL+6R58clBpy4CdjU1
         vIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714609851; x=1715214651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kp562e4y9SulzbDyJ0IEKx2QOZQ2mnPE6n/S2UPXGwA=;
        b=ASYrkA7OuKWmAOD9FeCgiIpipGUm4tefPrfTzC4rtgcT3Du5yujq785fo/pTnf6KVY
         9H6xcIkZiXMbd+HFl9FWONw/APpzOkyaZGzd+GgydUs13rrsW99MPMlVqam/lXMbMDJZ
         bdVe34UAURx41zsRzppqkocRd3DS9ob3HM0u+zKWnQKfLlU6nhxhr7kxyLBdj526Vx4j
         LkCP5ouTflK0CtqCvC8Y2+Ec9PbgyCluTN0LSUOB/tnTsq7cw+vzQj+TvxW8l19livix
         apmYR050xLLQQOFl2+UM63/qtujUCxn2kAMpttMijis+qzeWicNTdzwkhhweXKzrD61+
         nOQg==
X-Forwarded-Encrypted: i=1; AJvYcCUc0gnz/ELFpW5Vk9p9x6anzQoOZGmAGWd4dM7504vw86mGO91ZfCOqnI2pXkKIRqQ2JuulqB9CK11cF+C7lnZZNnl0fn7vnOJhlYaH
X-Gm-Message-State: AOJu0YxpbQFcSjYuFTP0BCPDxAeZt4oU5cZx7oDgQKg5VWWdkPORdFQ7
	Vo85r2VzrdQNlIaRMndF5sG0jOBe/qWDN+1h0nzpmISy36sAPAFJmPVmtDlq1JGAal5pT6hz6Sg
	rFgs7yJIfK9m0fgE+X9axMeTPTuQ=
X-Google-Smtp-Source: AGHT+IGGzcny3DlV2Jm68J5B2kaFqlbDfTOvJloIoTmsdrcqI3Z7BEoNjeV/hDuJrOs9REavq38NZ/ZnvoNuUHWyg5Y=
X-Received: by 2002:a05:651c:2049:b0:2df:49b:27f1 with SMTP id
 t9-20020a05651c204900b002df049b27f1mr269940ljo.4.1714609850999; Wed, 01 May
 2024 17:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501042700.83974-1-ioworker0@gmail.com> <20240501160803.60988-1-sj@kernel.org>
In-Reply-To: <20240501160803.60988-1-sj@kernel.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 2 May 2024 08:30:39 +0800
Message-ID: <CAK1f24k1qcTUnaZ-ZoT7GWkpWk-vDUjVb+yL9QWZAvfSLxEsCQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Reclaim lazyfree THP without splitting
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, maskray@google.com, 
	ziy@nvidia.com, ryan.roberts@arm.com, david@redhat.com, 21cnbao@gmail.com, 
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, libang.li@antgroup.com, 
	wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 12:08=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> Hi Lance,
>
> On Wed,  1 May 2024 12:26:57 +0800 Lance Yang <ioworker0@gmail.com> wrote=
:
>
> > Hi all,
> >
> > This series adds support for reclaiming PMD-mapped THP marked as lazyfr=
ee
> > without needing to first split the large folio via split_huge_pmd_addre=
ss().
> >
> > When the user no longer requires the pages, they would use madvise(MADV=
_FREE)
> > to mark the pages as lazy free. Subsequently, they typically would not =
re-write
> > to that memory again.
> >
> > During memory reclaim, if we detect that the large folio and its PMD ar=
e both
> > still marked as clean and there are no unexpected references(such as GU=
P), so we
> > can just discard the memory lazily, improving the efficiency of memory
> > reclamation in this case.
> >
> > Performance Testing
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > On an Intel i5 CPU, reclaiming 1GiB of lazyfree THPs using
> > mem_cgroup_force_empty() results in the following runtimes in seconds
> > (shorter is better):
> >
> > --------------------------------------------
> > |     Old       |      New       |  Change  |
> > --------------------------------------------
> > |   0.683426    |    0.049197    |  -92.80% |
> > --------------------------------------------
> >
> > ---
> >
> > Changes since v3 [3]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  - mm/rmap: integrate PMD-mapped folio splitting into pagewalk loop
> >     - Resolve compilation errors by handling the case where
> >       CONFIG_PGTABLE_HAS_HUGE_LEAVES is undefined (thanks to SeongJae P=
ark)
>
> I confirmed that the issue I reported before is disappeared with this ver=
sion
> of the patchset.  For the fix,
>
> Tested-by: SeongJae Park <sj@kernel.org>

Hey SJ,

Thanks for taking time to confirm! I appreciate your feedback!

Thanks,
Lance

>
>
> Thanks,
> SJ
>
> [...]

