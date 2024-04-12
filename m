Return-Path: <linux-kernel+bounces-142702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B3A8A2F21
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60A9DB2199B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824D15FB9D;
	Fri, 12 Apr 2024 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0hAfYUT"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA4150275
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927801; cv=none; b=n4dhCCqlTNRbZJqNc8fdeZLWLlFJxkcKYPjAJOMlBTd8gUwjP8fBii6xUUFFgkXQQxvlrY453+xU2jEBRr++fNx9ndehVyxEG0c2aJ0RQds0TPaZ5yClePb2VgcR+mLYI2pmYBkCBlSmSeTF/QKGDfZt3kKriovPFc39cwJXlRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927801; c=relaxed/simple;
	bh=hApvbrCwG3hE+CVKThibuZd8SR12xLIttliyhEwoRiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5qCpMgeEU7Ud5rriCNgmHpTDSdXm2THi8lURlYXd4LwJHhBKtrgeuVAWZka7Q3tBgxDE9R7wI/v05GiBrsCHBNG5CjGkKuNVZmg4OuDGHXha1xK3NjXYO9hbcQw2aygOHPwxAEMROcvH8pDbzWybOxGl5IiWZaYM6qDlSW4S24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0hAfYUT; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c61101874eso276490b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712927799; x=1713532599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaYxYtWvNMFaNldP/aYNqxGnYuMXv6GVR7VYUwwylGk=;
        b=i0hAfYUT0/Wk24rTWvEEd1tZXY7Fa1ladATttNl4fOcOHFQ6N8hzcUkaGrQ8uEtytV
         IkqOD0W+VJmjkPDJ2WLpFXVmrl7QxrfMXQkklB8Ocj+3e23yOe2Il1P23THNsGQWf8dh
         l+d3tBXs3/dbivG22vjfZnThpn6DAR3QYC3HeA3lWVZfSNZNYA2Vc0ko+v34NlHnQ0Zq
         Dkg5yuSYcuVrDla7r1tVDpCReP6O0XyZ+Bb7YWTg9yjawHeMFG25/UaiY1PegiUkmVu0
         WZ56o/7NFhA6Op1X3+aw67N3NzxfDkNq5xUJfzF5KPHTC71+6e8O4RPLulNuZXZI0StX
         EPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712927799; x=1713532599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RaYxYtWvNMFaNldP/aYNqxGnYuMXv6GVR7VYUwwylGk=;
        b=hWtIXjZRm2eY9mSr0J/KnLodCi2cNmAyiGxRVaZ4MwgVnr1Nso6eBIBDwNMvsps0O/
         1uXeifNnOQvopg+ix9wQwza2Al6VRUXNUCnaMVdSjEqmLs9BEdoMXGv+WkGJQZUbwIsZ
         McsRy1KqCpXBQCXPKX6wP6gfQFAlVCXm1D8N++sVxX5LgpmJEZnwhzhaEZO6s3NsHsDJ
         y1ixcsZZS0Wgu0KbwFLn3v0Q++qrCnKfkYZeuQfHmH3byUdNpuBppueB2m85tgMEDSEE
         JgoFdJweyfyTQRlhR+p6uQqwgmUArJ11s9DR3bdTKgfJpuTJLlqRlpWcUpqSAdnvrAoe
         t7jg==
X-Forwarded-Encrypted: i=1; AJvYcCVx30GHOzUNd1Qoq0WrWBnDjk8BbUbMKwfQ4sTGMhOwbfXNdjOdXjU81PxY0sESOEhUl8eDLgiVM4pNYckYwthcr0YoUoE0s3wMW+8M
X-Gm-Message-State: AOJu0YwN4f9T6g762qr8393dLTRuUX06MSYRB64XBrRCn5Bo+xwdCCZS
	n/VVnQHIH6rWipzz0o5OhCHsLLnXYvqhDWVZCArRxAP36/AWC6H8uQa5/HCHUczG8CkD64XkxSG
	df4JJUeCc/56d7PcrJ0Rk0cb2B1g=
X-Google-Smtp-Source: AGHT+IFDlRFnfXi1bBqNb6N3frPAReRPsPCLumbfedSGtSCvNR8lgoxsFYGeR/zhRMKi+xGAPf3L8PF+2wDDs+u6Joo=
X-Received: by 2002:a54:4e82:0:b0:3c6:500:a14f with SMTP id
 c2-20020a544e82000000b003c60500a14fmr2595421oiy.5.1712927799490; Fri, 12 Apr
 2024 06:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412114858.407208-1-21cnbao@gmail.com> <20e36996-0c78-4b81-8e91-1035d5ce0652@redhat.com>
In-Reply-To: <20e36996-0c78-4b81-8e91-1035d5ce0652@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 13 Apr 2024 01:16:28 +1200
Message-ID: <CAGsJ_4wk7RWiiNGVKdzMgD==tDmeWVBqpm-kRUFMHSz_rUVqXw@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] mm: add per-order mTHP alloc and swpout counters
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cerasuolodomenico@gmail.com, 
	chrisl@kernel.org, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	peterx@redhat.com, ryan.roberts@arm.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, yosryahmed@google.com, 
	yuzhao@google.com, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 12:54=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 12.04.24 13:48, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > The patchset introduces a framework to facilitate mTHP counters, starti=
ng
> > with the allocation and swap-out counters. Currently, only four new nod=
es
> > are appended to the stats directory for each mTHP size.
> >
> > /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
> >       anon_fault_alloc
> >       anon_fault_fallback
> >       anon_fault_fallback_charge
> >       anon_swpout
> >       anon_swpout_fallback
> >
> > These nodes are crucial for us to monitor the fragmentation levels of
> > both the buddy system and the swap partitions. In the future, we may
> > consider adding additional nodes for further insights.
> >
> > -v6:
> >    * collect reviewed-by tags for patch2/4, 3/4, 4/4, Ryan;
> >    * move back to static array by using MAX_PTRS_PER_PTE, Ryan;
> >    * move to for_each_possible_cpu to handle cpu hotplug, Ryan;
> >    * other minor cleanups according to Ryan;
>
> Please *really* not multiple versions of the same patch set on one a
> single day.

Ok. I will leave more time for you to review the older versions before movi=
ng
to a new version.

For v5->v6,  it is quite a straightforward re-spin though I can understand
it might be a bit annoying if you got v6 while you were reading v5.

>
> --
> Cheers,
>
> David / dhildenb

Thanks
Barry

