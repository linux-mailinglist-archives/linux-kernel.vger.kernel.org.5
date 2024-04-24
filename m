Return-Path: <linux-kernel+bounces-157237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC6C8B0EEF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B04294FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBB715F336;
	Wed, 24 Apr 2024 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTuPmSx1"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7D41422AF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973634; cv=none; b=m5PP4+SQy/E/w93UAU2TsSoCWuTK66NuS35EkQCkGwVpH8QC9iasZ6Om/N1eQq7UbIqlsQ5eU9BufDXa7BD/SaSQD97aOz5fkWY16ldKQidMI7uXmjcGaQb3We16yHpsUO8OvFWcKc9fd+PvbBLeS2k1ubiQqevXIvo/W8hOS24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973634; c=relaxed/simple;
	bh=vO1WEk1IfrQ74RLtZrMBSriX+BAuVhG8i7srJ7+E87g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLMHwyvY/uMHxD7mKqwfBteW4HjXl6Q8VJlrg/C61/YeZhZM0QySakmSaqhfsiqydoHofzZrb6NspNjPN9r9zglRwkvJyCzu85yiH8wKYqafrbN6fxUqrGe4y+emE1wMMvA49CjbL7szpC7Z3amglj45KJFuIIltguVDgvkdQeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTuPmSx1; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-572040691c9so70743a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713973631; x=1714578431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCifhvSmEG7DOCXgTsfn1cm9CMTgVX4fQMep4eOKQI8=;
        b=VTuPmSx13c6Pzv+WVa0ZgMVGvoyirEcgsGTiOhUMmzHtZhZKYSpUbJiTwqYWeR4zlx
         Xdo8SzaZVy6ruZgu153yFtvSKpLA7lopUXpFAyyBqujYcth1qUn8iHJp29d4vFvK4FRh
         vUpAO6GpH9C2vsdjLzMfp62E+2nOd1K7Vgc/zc3iE/PKsAcQtqT4ZLjkTODLMoL+6YS6
         QgwlauBjPp1/9+DC0lFOLB/sp4sQgY3S2sLawbKCJr3Qzg8ey9/ZHtdEc/J5n+yZbYGj
         FXFvr4mzaCpVZVXcZWjVkkTGD5UzVQaGi9tx379z9u6MhtuvxSq/qvw6Z0SAbqZe6bGQ
         1+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713973631; x=1714578431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCifhvSmEG7DOCXgTsfn1cm9CMTgVX4fQMep4eOKQI8=;
        b=uTZS5NVQlhfcLkT5Q+xevWVlGiOPBEJ9R2u3Z/YkhFPDjIQAlqo+9ckg5ZhqqftBHC
         WgTeWtC4c3R6+tr5p0wzBXDjZEIs+60+xttyO5TIWMHIACgQqgLYLjzg+6Bps3puVXP6
         b3dPLK52CKxznRAfns2Oqgdvqp/AnJVBhMTOy5RWZesSmCe9jTAGyCoVhTTcAZ3VOv6L
         J9mJiPUjTRzv1Mjlvo+Bsj+bkB5TfqvwiAmXx+XNe08mKISr28ssKxvI9KroA2DsOHOl
         QmJzWBPcylYFMb62j2/WLYM1IALKvBzU1Hs0D18UH2W//kiitmzTWBt6Sb6wKgyU9CyY
         J05Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbuH10dOGcjKOcE9yFIBmP/pFHrH9GDCJhsC4hSO8GipDrokhaS0/FhNejNN5eJBwpEJiQaA9uav8SRVG5WCY7aBthUIp3O8EfwbT5
X-Gm-Message-State: AOJu0YzrcyoP/TzHb0wY+HZ0TROFG8vUsHuD+bNVLRcDqcFHBkC+PO3N
	JKQ0yzG7BtxbZUCZb6yyMYxsmFaxXc8Dmy/IQya/oSHN2MnKRNSBs5/phyMC1bsEFoOtGpP+QUo
	bpqYUw0JTNSIRzAgOq8pg0S5vL6A=
X-Google-Smtp-Source: AGHT+IE3POg2oAfA/0A94xs7ybQw6w91ypxqoQrWYfj71qo6cCYukbDX3hHQaUgnDr8RCuW1BCGjzNulrbZaxWonG5k=
X-Received: by 2002:a50:d543:0:b0:56d:fc50:ec50 with SMTP id
 f3-20020a50d543000000b0056dfc50ec50mr43929edj.13.1713973631300; Wed, 24 Apr
 2024 08:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422055213.60231-1-ioworker0@gmail.com> <ZiiHSwG_bnLJbwfb@casper.infradead.org>
In-Reply-To: <ZiiHSwG_bnLJbwfb@casper.infradead.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 24 Apr 2024 23:46:59 +0800
Message-ID: <CAK1f24kaHcKOS1ajfLney-1+Pqrwrk_0LWqRr2DmZ+41YBzXug@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/vmscan: avoid split PMD-mapped THP during shrink_folio_list()
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, maskray@google.com, ziy@nvidia.com, 
	ryan.roberts@arm.com, david@redhat.com, 21cnbao@gmail.com, mhocko@suse.com, 
	fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Matthew,

Thanks for taking time to review.

On Wed, Apr 24, 2024 at 12:15=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Apr 22, 2024 at 01:52:13PM +0800, Lance Yang wrote:
> > When the user no longer requires the pages, they would use
> > madvise(MADV_FREE) to mark the pages as lazy free. IMO, they would not
> > typically rewrite to the given range.
> >
> > At present, PMD-mapped THPs that are marked as lazyfree during
> > shrink_folio_list() are unconditionally split, which may be unnecessary=
.
> > If the THP is clean, its PMD is also clean, and there are no unexpected

"If the THP is clean, its PMD is also clean" can be confusing - sorry. It s=
hould
be modified to "If the THP and its PMD are both marked as clean".

Thanks,
Lance

> > references, then we can attempt to remove the PMD mapping from it. This
> > change will improve the efficiency of memory reclamation in this case.
>
> Does this happen outside of benchmarks?  I'm really struggling to see
> how we end up in this situation.  We have a clean THP without swap
> backing, so it's full of zeroes, but for some reason we haven't used the
> shared huge zero page?  What is going on?
>

