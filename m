Return-Path: <linux-kernel+bounces-108098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450DE8805EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765641C227CF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8BA5A0FA;
	Tue, 19 Mar 2024 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lar24pDF"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8080757339
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710879210; cv=none; b=qPBHyeqJ7VNVQyxyiJedBOe6pUjLsK7he4OhAHKFcod2aCUXL9xiFQolsr631LBuXYhRmezG3CElqgCcjj5fWLWAIEHj0/pvFIq3wRBBq27t7QKPW2pjHJxh9+Pq0NM+SW4GSwhYtG8KTUX3HUVgCqKAMqnskAHH4Z42CwlZZnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710879210; c=relaxed/simple;
	bh=+sQCudOZfuqXiUUoG5vR5ACJJLNxAMax7xwD1W4e41A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWRFHku7HI1dtjk78pPi/lH+4WCnZH9almGsiufVUZ1Tut+YpuajxwnSZ+YIL5OZ9p4TtwWDiBHubvytnL7Jk09CXUTWn3VL/fI2zGHJyskyApiO1EAWamTWLB/HczPf4aSze4pK37jKyNtZmU+QFa8W23p5AL24NRkgMD9Ar7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lar24pDF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1deddb82b43so46015ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710879208; x=1711484008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TmjIUAWre/OnPAbZKoo/CqmH4il78nzu/N6uFzuSi8=;
        b=lar24pDFUtX0vMzb51TSzwEnwoyRetN5jsA51ZK+b/N1rz662USWBlivjRosZbUgVu
         VuvOm2WMWPJktHRQI0tmukLK7fj6iW5Cn01nfso20ZqHRt5HJHykOyU680fvDrY3upXz
         Ehhw2tyJOaDF6zLunagaC4gD2vjE+PtWF19b2B4GKeidnrh5OYceD/tYIVdc3jceA3zx
         EoS9/z47ERCRLxCGKGSwEjZmoD8l0sUXDjMGS26CAQR0x20ZE6mCmJ8/zU3eVAlKIpd3
         xa18f/j3Y0FeeLx2JzNNkzSAkxbnHczZ1P/HWr91ZwCiO/6z+aaXVCeODoPFk8dM8gH2
         9nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710879208; x=1711484008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TmjIUAWre/OnPAbZKoo/CqmH4il78nzu/N6uFzuSi8=;
        b=Bg8tMvIMH9n+U/2pG3DqD9EmaHduFI36D6TPCdD8Eh9PHrXlq3hB2Dh+b1bSUDk3k/
         2DNdi6i5DzA1A3+P1bBe7UhP/YVcTGBA6UKHKVqzgTH8jGJK8gO/IeVbtsnFnpcUA9w/
         ewwp1lViexuzCKpFimTGiO4qg/38QoBcnFjKWdurMUzV6avpAaudJDg5p8EXOolonv8O
         Pi0sqkuqntEKNhekEsmxOmonA65Y/YW10TBISsxXdNmMaTRC13OyJktt0/UEfK4a3R/3
         7bYAUovYdcGxhB2Yu8SJswvY3mUYwJeJnJYGKXg082w9u58KaGw+Feki5CUVKAvcFXvy
         L18A==
X-Forwarded-Encrypted: i=1; AJvYcCVWsrR/RVXLivfUme2Mv6+G1qJe5xRiMlcLK81eG8pg2nZsyMQBC+uCRTbedrZ9Wk/QZjpF5e8/GKRXqw9jxnbpxJ4fX625wJ9fkY1Z
X-Gm-Message-State: AOJu0Yy7pBFvseydyhUXSJuSbfz8NSBqv6dXh5Nx8YfdayDFE6qPs1oR
	8o+uyRUTh4gRTMRR5FoVyY+7+UP9/Bz5qCgrNGFE3FZHU88nRr8QUPj9ISk9otyk9qEAEXRdrWo
	Jyyy6QQeGjHFI/aI697XbKoRKKOzlJKt1nCnq
X-Google-Smtp-Source: AGHT+IEw7XqscOujrExd+TjwtySjz62M3/jll6P8bD2QCyweYla8m9DhRt5lU7Qo9n5jCXQMEtTIf22XYc74lAhBJZ8=
X-Received: by 2002:a17:902:ea11:b0:1de:ed50:41f8 with SMTP id
 s17-20020a170902ea1100b001deed5041f8mr65676plg.22.1710879207491; Tue, 19 Mar
 2024 13:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319180005.246930-1-visitorckw@gmail.com> <20240319180005.246930-3-visitorckw@gmail.com>
In-Reply-To: <20240319180005.246930-3-visitorckw@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 Mar 2024 13:13:16 -0700
Message-ID: <CAP-5=fXvQoOOpCTm1FXqatzv-wCTYxAymjAu5Veb2fBZE6KivQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] bcache: Fix typo
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: colyli@suse.de, kent.overstreet@linux.dev, msakai@redhat.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	akpm@linux-foundation.org, bfoster@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	jserv@ccns.ncku.edu.tw, linux-bcache@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 11:00=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.co=
m> wrote:
>
> Replace 'utiility' with 'utility'.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  drivers/md/bcache/util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/bcache/util.c b/drivers/md/bcache/util.c
> index ae380bc3992e..410d8cb49e50 100644
> --- a/drivers/md/bcache/util.c
> +++ b/drivers/md/bcache/util.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * random utiility code, for bcache but in theory not specific to bcache
> + * random utility code, for bcache but in theory not specific to bcache
>   *
>   * Copyright 2010, 2011 Kent Overstreet <kent.overstreet@gmail.com>
>   * Copyright 2012 Google, Inc.
> --
> 2.34.1
>

