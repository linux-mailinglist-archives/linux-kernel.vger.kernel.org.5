Return-Path: <linux-kernel+bounces-99614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777A4878AC5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03D228225D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4455812A;
	Mon, 11 Mar 2024 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCVVhgFm"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD0C54736
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710196261; cv=none; b=VI8VPYdSDcTpc9XFNtHOIVGE2GLf3jaKIdNanjAHe1Hd2Egx2xNgGzx/V4nWfbFx0qE23xWBkYFp24ZK/uSTRVx4KcGVPXMeQU9w1Qy6asXA16Jq5dsiGDHVGG2kvEkt7DKhXHenDmftlfc3FVUYqYClW6Gq4BH0Bx/2VX2Zrfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710196261; c=relaxed/simple;
	bh=ccEPIRBsx8Z3efNFka2XMIqeialKRn15JJ1iLrYfxvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKlWuuMLA+shmEFYCU0y3xvBGVc0DQ+/Z/XORFSQup0ktyTNhcRxx6KRxlaq69B7MeuBewj58zuptzrNnV7WEIJvKPmhYNMSRslnJ4PW4NOu4YQUduTZR1EKplg754zJY6Q6nqmZBBOsiokBr/y7OMYOUowC3aL6Jv2op/OShqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCVVhgFm; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7db9cad9dbcso1911034241.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710196259; x=1710801059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbQrm7vb6lcaupZxQt2vA7yORilaHaySRWOgYMwjdKI=;
        b=iCVVhgFmxe+WZE+TAj4BCW82fEJYnPIf+NYJPwaabVzgd2KICeE4HG9V1TZTxqwvrl
         3ytTAqzx0bovpevdhxTms/UInZcku7du06WXzgESNpcoCuEYwidKvg5hiRfERcZ9HRuA
         V0P2UfqNTHjPjPb0F3nFCgAnV9I/Buo+P20lp/QQJHma+i+0v6KxPMVvaspHH5GdU5eg
         KwONdDQ1Rp4g85XObJh3Ccl1Hf2U7zq8RYf64SSRxz0BjRtD8CmbTDu6Ap2tJkjKvtzD
         hm1HyDT1AmShI6Lb2esUSVQ47OUJe+vJoXaCwsBy3XE+sajMR9pcNTMf3icVzQzo6x0N
         i09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710196259; x=1710801059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbQrm7vb6lcaupZxQt2vA7yORilaHaySRWOgYMwjdKI=;
        b=ulo88/8hXh+xFBZ6FX8OaOyP4cccVFoV8COyY7lw0D5wlPfXbyJhNVstNIJT26y28a
         3JTKhFwuvEoUEJfxENbGB28jcLKpMq2vQmtZweADMwhLBMIR5FJAvTWGSU6HmcB0Qg0q
         FULZVsMH2QHQjFsWacg4DZYb0D6fQO1JbsFMYOzojgnBIBGMFXAhcrobmflRehP/aePL
         Pp24P2GD3xEp/Xr/Ozqe/V74YpoGOeaNlKBF2tbEjt6Z6DpGsP8nr2rvIXVzCTkAtAvC
         oOBBNujDqjzK9/HRdMKmcyTW61aw2gCfwgXjpa/XiitJ9P8NTPq04mU7YTjZ6saXyq+J
         mDiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBlRw0SBa8tFl+oWEuSPItRJBDgMi/GgPM0lAdsHrAj0hPjXFvA4+Drh7IZxX1SkU4Iwjkkttc83UDg8JyJgA6Fy3MlwJs3ApJNhuy
X-Gm-Message-State: AOJu0Yyhr8AAzZsZqe8K6SvmanKo8TX9xKG3KyCOJ3T9IvUrqGeSa5h6
	RfhHowlYwQBYEgs9o2204aT0d1FcuosEAcCwR729DdmNpGpiS1lIVkJHWLPMvAYqzANaQXwqi7Q
	HqAhx5sAnZZeMjctxSvUi6otxNPo=
X-Google-Smtp-Source: AGHT+IHpWeNRmtXpj0XUQvDlRqFRbkrPZRGONY17K7X3qg/HBjfAXo0NJmE8vv3shR2KQiFJH37T66AFsBDIlEIG+Yw=
X-Received: by 2002:a05:6102:3565:b0:473:23ae:c11f with SMTP id
 bh5-20020a056102356500b0047323aec11fmr2870966vsb.1.1710196259114; Mon, 11 Mar
 2024 15:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311150058.1122862-1-ryan.roberts@arm.com> <20240311150058.1122862-6-ryan.roberts@arm.com>
In-Reply-To: <20240311150058.1122862-6-ryan.roberts@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 12 Mar 2024 06:30:40 +0800
Message-ID: <CAGsJ_4zq4jdDdG6Cne6SESSmJQJnGwaQF5y3BHOaLHFdED0zYg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] mm: vmscan: Avoid split during shrink_folio_list()
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 11:01=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> Now that swap supports storing all mTHP sizes, avoid splitting large
> folios before swap-out. This benefits performance of the swap-out path
> by eliding split_folio_to_list(), which is expensive, and also sets us
> up for swapping in large folios in a future series.
>
> If the folio is partially mapped, we continue to split it since we want
> to avoid the extra IO overhead and storage of writing out pages
> uneccessarily.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/vmscan.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index cf7d4cf47f1a..0ebec99e04c6 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1222,11 +1222,12 @@ static unsigned int shrink_folio_list(struct list=
_head *folio_list,
>                                         if (!can_split_folio(folio, NULL)=
)
>                                                 goto activate_locked;
>                                         /*
> -                                        * Split folios without a PMD map=
 right
> -                                        * away. Chances are some or all =
of the
> -                                        * tail pages can be freed withou=
t IO.
> +                                        * Split partially mapped folios =
map
> +                                        * right away. Chances are some o=
r all
> +                                        * of the tail pages can be freed
> +                                        * without IO.
>                                          */
> -                                       if (!folio_entire_mapcount(folio)=
 &&
> +                                       if (!list_empty(&folio->_deferred=
_list) &&

Hi Ryan,
After reconsidering our previous discussion about PMD-mapped large
folios, I've pondered
the possibility of PMD-mapped Transparent Huge Pages (THPs) being
mapped by multiple
processes. In such a scenario, if one process decides to unmap a
portion of the folio while
others retain the entire mapping, it raises questions about how the
system should handle
this situation. Would the large folio be placed in a deferred list? If
so, splitting it might not
yield benefits, as neither I/O nor swap slots would increase in this
case by not splitting it.

Regarding PTE-mapped large folios, the absence of an indicator like
"entire_map" makes it
challenging to identify cases where the entire folio is mapped. Thus,
splitting seems to be
the only viable solution in such circumstances.

>                                             split_folio_to_list(folio,
>                                                                 folio_lis=
t))
>                                                 goto activate_locked;
> --
> 2.25.1

Thanks
Barry

