Return-Path: <linux-kernel+bounces-112001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4258873FA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D161C22700
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2583A7BAF8;
	Fri, 22 Mar 2024 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H1fcSheb"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB651E514
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711136287; cv=none; b=CjbJz73Ym7iIkaDdqeROxAKtnQOWIxzSvs/qdC8l8HOwwinVNZ1VqhwauAHE4iHi4XuoXzZjDk+Q53Oz/KVfqK1FjPgaNpBbw6G8ERcs8l6ZUPjatlwfVLpj25tL+lSSW7yQDNFOeb9XYnvGPxHa7DfNEATPVfDUQvfBPn+o0lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711136287; c=relaxed/simple;
	bh=Xdakqsi/D2JKyIKkGYWtlGPF0xjppXCKwXZBXILelig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRxi4H+ACa9f0+b30pJqptFji1EX2OLHYXxG2QEa/w+BSaRobNlz/RPvZvesdCyiOWWrf5npYiQt4CBX6SyKNsqd6EYr60BlDA4QWwNjMbnMWS++nrrmPnzPgcVy4hy48YNpX2VI75Ap+NW1Mxh7PfxGs3aO5KnQOUcl3tLYWo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H1fcSheb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a472f8c6a55so133957966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711136284; x=1711741084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xdakqsi/D2JKyIKkGYWtlGPF0xjppXCKwXZBXILelig=;
        b=H1fcSheb3nQCegSXsagopNkAVqrcdKpxNhxBC5PfmlsoCvR9UKWWAmJ81uzjHfnfW1
         5Cz3bqw+ScwzCLrlbJdCbbovdY2QhY8GZINMAD/+XjEtJnAYCbSVO9NRn2Ebrsff/PG6
         zkgr+KmaHUxKSjye87tGdTI6MnnJv4XwQVE/q132N7M4ZnjpimrwL5yGyGrujAnqN5LI
         OJLlXG0XpPq1k7iQPuSv8D47TNJzKNR6U55XVjmq8WKPX0gY8iD8sjPajhOr1Y926XEE
         RtnlE0qZgSBu58z79ibXlI6eJlmzpZtunomzG/UlPhudUNZpe0B0kL5W089RBsAYWy0C
         osaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711136284; x=1711741084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xdakqsi/D2JKyIKkGYWtlGPF0xjppXCKwXZBXILelig=;
        b=Ubc0pcqbYD921SM+MS9+uZaCDV4kuZQOE8K9gHAKu+QmDs5IJqQw1apuP5AjcjhPvC
         3wpJX4s5vEQRABv6X/JLa1OiCoDf24gF/vITAkNRusv3BJleMXD8G5UVbdhVwJH2N2cC
         LprepNRhMarg9kpAdipYCxqchDl+Hjo3uXPOSF9se8HULw4GoWMXZfiAEMHZJoBMSlDE
         2fir8j2K+inveCOuuqDmOk3OC6yecQBegq4nt6v7S6z2lvXNEzARTYFydV6JlyMFn7yC
         FEMQ+zfZbJbriaOGbKuQP+GDQ/Gp1hUsc1TR6qiocvze4gJleUU9dcQu8Ozw5jMMNNeK
         vpEg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ5VxMmvr4ooh8ryjI9vddyog06tKNq0vXvb7IC0QiT5L94AZDTxl+6JZSXzmsfOIRry7H8ymjL5w6O70sya92+L7JqmEgVu0ehZfK
X-Gm-Message-State: AOJu0Yx6SvPSs4TEnkPzKtVtZv2qqGqDsuW8HpdVGmyU11YAGSaM+h17
	ojTU14kwzXZA6HxX11Au+0+q7IT5bVqWWmcnbFGnWm5glCHtA9uKSs1BUiI+2E+iFQChrVZCySc
	j4FCmHw/3wM/mOcPACue1BUlOYGN+P/6Sv9V1
X-Google-Smtp-Source: AGHT+IHNQ/xrFFDBiym2V/Gucwz1XpBVJI5RJdnaPo6OVHJ4qICFJQa3VnkiRG9jjQj6TIigduFuMJERwpG9Hvat9Z8=
X-Received: by 2002:a17:906:ac7:b0:a47:2333:80b9 with SMTP id
 z7-20020a1709060ac700b00a47233380b9mr504939ejf.47.1711136283960; Fri, 22 Mar
 2024 12:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322163939.17846-1-chengming.zhou@linux.dev>
In-Reply-To: <20240322163939.17846-1-chengming.zhou@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 22 Mar 2024 12:37:27 -0700
Message-ID: <CAJD7tkYuYEsKFvjKKRxOx3fCekA03jPpOpmV7T20q=9K=Jb2bA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: add folio in swapcache if swapin from zswap
To: chengming.zhou@linux.dev
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 9:40=E2=80=AFAM <chengming.zhou@linux.dev> wrote:
>
> From: Chengming Zhou <chengming.zhou@linux.dev>
>
> There is a report of data corruption caused by double swapin, which is
> only possible in the skip swapcache path on SWP_SYNCHRONOUS_IO backends.
>
> The root cause is that zswap is not like other "normal" swap backends,
> it won't keep the copy of data after the first time of swapin. So if
> the folio in the first time of swapin can't be installed in the pagetable
> successfully and we just free it directly. Then in the second time of
> swapin, we can't find anything in zswap and read wrong data from swapfile=
,
> so this data corruption problem happened.
>
> We can fix it by always adding the folio into swapcache if we know the
> pinned swap entry can be found in zswap, so it won't get freed even thoug=
h
> it can't be installed successfully in the first time of swapin.

A concurrent faulting thread could have already checked the swapcache
before we add the folio to it, right? In this case, that thread will
go ahead and call swap_read_folio() anyway.

Also, I suspect the zswap lookup might hurt performance. Would it be
better to add the folio back to zswap upon failure? This should be
detectable by checking if the folio is dirty as I mentioned in the bug
report thread.

