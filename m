Return-Path: <linux-kernel+bounces-79428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F61A862213
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3621B23A20
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCE9C148;
	Sat, 24 Feb 2024 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBwhNIaF"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2576C122
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708739235; cv=none; b=HaslJO+zZzlHostsv0O36RWbZveh7xB/H8We3GZHmisx2nbj/Dsa0dTv/ImWHF6YmU/+JpVmyQ68S1HHOeTQ60/NwGXENWDClBsOWeeuRrDPiZVo7lx0ln13cBW8lFygBgmFjLUktHIkuGJGSewOJ973sK2FB9iw2OTb8EMc2No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708739235; c=relaxed/simple;
	bh=vFpzgojmUbe9cDCthy2dUr66zBP2Jp8OIks+itwmIvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpKff5D3mFSRXtvlq+1s69H0AMIbL6wKX0CeA89TYbCSypBUQleXqUG2ugjSZhk2cduJDPixvwcsHc10+AOjBr7Kj7VPYhqkql6gCvaZMkemcScU5ijGcFWNz/+SN3a24tGkPF1lrgPSYv54j247+nOSwNAPvIQdHbmvpjCcs5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBwhNIaF; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso1276726a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708739233; x=1709344033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkj8iOEXqlkPOJBxGRSAsQOYHNO+Nb1TKrnbkl8DtW8=;
        b=KBwhNIaFn1MgQccK0rj2Da9sg98BGI06ownBvdVtmNTlbqzRHBsY5nMplxLHj1pCwQ
         p1rHFaqOj9JTTIDBUaiNOml8PYKF+xaF/3u5FqZi/n5yjL5qelHckCOSAw9HQm+WaaAx
         kA7JpZbMZHkqBF/5N/oC2LeEDGxqyFr4UqU2tTFtGlMMpBVkpY/x/Oi4KlctPAgnHzgL
         HpkyK/8QIyDVE5myjBbKLxx7PgARLyVPWjSNw+cdyCqKxyfbugkryo9r4kQBpiipz6a+
         w1lclmEnGGgBjDPWEZo14agZ/E7bb1+Dy2fFMOo2F3WXxKFVMybkiqJurOLZPGoqkfiu
         oEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708739233; x=1709344033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkj8iOEXqlkPOJBxGRSAsQOYHNO+Nb1TKrnbkl8DtW8=;
        b=ABixtZ/4NR8t6FaaXCIe/kauy78kx0xQxam99p/nJCwC6Jvcf5ziObZ4EbMZeIVi2A
         cZXe31Ny3ZlIapD+zfwHi3za6s/p/W6vUJeb44dKFxAIehLfyG++gb8peYhxmGKVJx+5
         8FZMWquz1YncIUfNgCzkk/FVwAHgT35EvAs+p6G+AWej6X6QKMxto+be0f5lBSlDwQhp
         8ngJl2gDOo1i/bXVwen0cS1cNAAOtY0+1zjX8CGTV+MX1ReaiPTIAw/fkbRwFD/dMJCF
         NWujFcOKfL0xPh5LQUAmDEZ+PczApgrMXaA5n5Hrm0DKOqU5xSSjETnUKsmGosOJ5yyX
         ioRg==
X-Forwarded-Encrypted: i=1; AJvYcCU8KkQLcM1C7WPpEA5FLj28z6YoxahmM7wkpJYDcd2+wA2TmQWIwmvv6SEp9lA73d3rOHo+ax6bbnhwJSnpXTT2WwoGRoDYCnYwRDJF
X-Gm-Message-State: AOJu0Yzaa919Pfrf2ibNMWMancaajTyh9lwKDn9A9WkWa4pUr2sb7Jm+
	Az7Bs3DCbuS6QA6W/TnuvnepoFIEl70bP/To3SBKh0bAKpc7wn3fHeNreFXHL/cc5LLVTxWsECy
	0hukD/yQssY976RTM+dFx6Wd8Ioc=
X-Google-Smtp-Source: AGHT+IEP7gcCCpQNjrEB28hlDf4J34twTAsEPpYz/mnuIH65dfjWR+Yl75K0kg95K+//RlWFyXjwqXAG9AS0OZ8vnmU=
X-Received: by 2002:a17:90a:d242:b0:299:4a62:548a with SMTP id
 o2-20020a17090ad24200b002994a62548amr1690765pjw.34.1708739232891; Fri, 23 Feb
 2024 17:47:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129054551.57728-1-ioworker0@gmail.com> <CAK1f24keWtJNVv37r2vNsqnmMLRMvF-F76WR5RD_Y-BbAgEaYQ@mail.gmail.com>
 <CAK1f24nk19eciysFqvTd=rqpiKePhstDWEEQ_mvT89WCDNrWNQ@mail.gmail.com>
 <CAHbLzkoNFn6UE4Hn0gXTm2pLHD7pK4gYUe1zVh3247m30A5u2g@mail.gmail.com> <20240222131151.4d24563d58240e76a3b535db@linux-foundation.org>
In-Reply-To: <20240222131151.4d24563d58240e76a3b535db@linux-foundation.org>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 23 Feb 2024 17:47:01 -0800
Message-ID: <CAHbLzkoJLGMbTsksNyj=u+15VWvVJFdM5K09ObN75wSd7K2t4g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with
 MMF_DISABLE_THP check
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lance Yang <ioworker0@gmail.com>, mhocko@suse.com, zokeefe@google.com, 
	david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 1:11=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 22 Feb 2024 12:23:21 -0800 Yang Shi <shy828301@gmail.com> wrote:
>
> > > VMA Count |   Old   |   New   |  Change
> > > ---------------------------------------
> > >     50     |   23us  |    9us  |  -60.9%
> > >    100     |   32us  |    9us  |  -71.9%
> > >    200     |   44us  |    9us  |  -79.5%
> > >    400     |   75us  |    9us  |  -88.0%
> > >    800     |   98us  |    9us  |  -90.8%
> > >
> > > IIUC, once the count of VMAs for the process
> > > exceeds page_to_scan, khugepaged needs to
> > > wait for scan_sleep_millisecs ms before scanning
> > > the next process. IMO, unnecessary scans could
> > > actually be skipped with a very inexpensive
> > > mm->flags check in this case.
> >
> > Thanks for following up on this, can you please capture all the
> > information in the commit log?
>
> I added it.
>
> --- a/txt/mm-khugepaged-bypassing-unnecessary-scans-with-mmf_disable_thp-=
check.txt
> +++ b/txt/mm-khugepaged-bypassing-unnecessary-scans-with-mmf_disable_thp-=
check.txt
> @@ -9,6 +9,24 @@ and the MMF_DISABLE_THP flag is set later, this scanning=
 process
>  becomes unnecessary for that mm and can be skipped to avoid redundant
>  operations, especially in scenarios with a large address space.
>
> +On an Intel Core i5 CPU, the time taken by khugepaged to scan the
> +address space of the process, which has been set with the
> +MMF_DISABLE_THP flag after being added to the mm_slots list, is as
> +follows (shorter is better):
> +
> +VMA Count |   Old   |   New   |  Change
> +---------------------------------------
> +    50    |   23us  |    9us  |  -60.9%
> +   100    |   32us  |    9us  |  -71.9%
> +   200    |   44us  |    9us  |  -79.5%
> +   400    |   75us  |    9us  |  -88.0%
> +   800    |   98us  |    9us  |  -90.8%
> +
> +Once the count of VMAs for the process exceeds page_to_scan, khugepaged
> +needs to wait for scan_sleep_millisecs ms before scanning the next
> +process.  IMO, unnecessary scans could actually be skipped with a very
> +inexpensive mm->flags check in this case.
> +

Thanks, Andrew.

>  This commit introduces a check before each scanning process to test the
>  MMF_DISABLE_THP flag for the given mm; if the flag is set, the scanning
>  process is bypassed, thereby improving the efficiency of khugepaged.
>

