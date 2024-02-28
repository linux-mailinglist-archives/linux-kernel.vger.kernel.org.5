Return-Path: <linux-kernel+bounces-85022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5687586AF3B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A13E1C24CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512EE1487DC;
	Wed, 28 Feb 2024 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IG+kZR2z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0167973515
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123738; cv=none; b=CTgavOmV9GYLqNONPsMTxzkW2uBewhAzPkacnrc7x1O/4CZQqVaBBpfghRFU3nkURp7411BYQe2RVjM/C8ZyQ+5wUqGhqDG4kZ9LACx05QI40TnaIBKoo3Ku7+Df/kwbN6Vh/GOUYoznDaQ/0mBE+HCG+tez3bt8xdtYgqfu5VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123738; c=relaxed/simple;
	bh=foL0RQpwU9W61mkkBioqi4654qXiuIpQE/3zmH03wk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0Bq+c6h1raVQjgwJaP+nZiHuA8UbCLyixbFy3ZZGeUYMQ5up1N3J/XrOBkDfq2Ab+pRq0bj+hBbklzWCD+goSkNOtqR13LjYOf6iKrxqYgisuk/DMt3x/ntu0sVBAm1/bk1lgpQyq6O3gF78vLWMiz7ZtEiSpx9MHxu7e640MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IG+kZR2z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709123735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0nKkfEqQcevoAqU5/3pnr5go0HmLBqkrwWYNjYP7RdE=;
	b=IG+kZR2zPcBbZr0AHtGiT9pWo8vKN+MWgepIUcPQ4w01ltP1VircmsH10Cbo1KcpKgx8F1
	XlwEK43ft3rrGrhgk3ulsk8jO0Txc3rtYiRoh0vlsrgVMEhpAMAm8gOMk1oVHcaUF2mBa2
	lz4NhoFJgWMlvP2jTGNM++pESF4Guc8=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-1kLNoWxaPhqs84Y7XP9C-Q-1; Wed, 28 Feb 2024 07:35:34 -0500
X-MC-Unique: 1kLNoWxaPhqs84Y7XP9C-Q-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5a032e40f41so4888237eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 04:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709123733; x=1709728533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nKkfEqQcevoAqU5/3pnr5go0HmLBqkrwWYNjYP7RdE=;
        b=gkjImbwBlsw+620LbA16952Owtr2TN9+36QFuCK3EnW/b8kBHYKaWMXFIfxA2QO8t9
         Q0qOih2LW3tnu2ysD6N4HcFWj8otcBRnp/etYPq3Nx24/ijvhMNZTxoPbwwgiv4axH0T
         9/DumKB/nvImJdX4WT7fBxxtVoLQDpmuMHy+g9g2pU4OKIsNUYl05yIkjriSitbHn6Yx
         6p6NeHnuxHoT1tjF4VVjWyvnTTny+saI66E6LZ2v3DoDZu1zY+xjR5h+zoVR+JowH75S
         ICDUU0b9cBOGf+zJLK0s4pf9zKVb2iqpoHuVGV6YYJ8wRxq+5uydX0OORDcd8bUFgDMZ
         dLiw==
X-Forwarded-Encrypted: i=1; AJvYcCUsNRWwIh52NoC0ZAQnjs8CvhEDNBuS2T+PD9qZICBNkMZ8r22CB7k9nGWxVLH5DeTOXGVVmKf9tG3Mdn5o5tNMLfQf3KzahRIEysl1
X-Gm-Message-State: AOJu0YwGjjBFGQzzcK9sc/PyW4f6yfFt38sKnbFYdnPrdEHiJRhi9AIf
	BGrtzzBoADKeoGU6ALL7SoevXKESIW5F+OZO0CYSm8nlY1kqpydBZvlpCo64IiZ2oYxlhNk9S6n
	TiERy7jk/04/I76Rr+8c+WvdEFN9La8GhybqivP22xg/o1NfbChz/42kCg9Zf0JSwQEDllr5AZ4
	c4m4M9W4qSByHny/nzh3LKw4uDiQcUwMFEi2QZ
X-Received: by 2002:a05:6358:9991:b0:17b:5e32:6009 with SMTP id j17-20020a056358999100b0017b5e326009mr15677559rwb.11.1709123733549;
        Wed, 28 Feb 2024 04:35:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeRsYySUjU+B6O2Z36vB/yO0JBrMVskwe4Vu2AhHXgdTjvOGoSVrhIduUtiVTrLN2XIRvgK5Rt000TLfAIZ8c=
X-Received: by 2002:a05:6358:9991:b0:17b:5e32:6009 with SMTP id
 j17-20020a056358999100b0017b5e326009mr15677545rwb.11.1709123733270; Wed, 28
 Feb 2024 04:35:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228114333.527222-1-yukuai1@huaweicloud.com>
In-Reply-To: <20240228114333.527222-1-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Wed, 28 Feb 2024 20:35:21 +0800
Message-ID: <CALTww2_NF6yMF7Ppc3DFj+-yERqM3gDy+Xt9u1_Pu56iw0zLbQ@mail.gmail.com>
Subject: Re: [PATCH md-6.9 v3 00/11] md/raid1: refactor read_balance() and
 some minor fix
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: paul.e.luse@linux.intel.com, song@kernel.org, shli@fb.com, neilb@suse.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 7:49=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Changes in v3:
>  - add patch 2, and fix that setup_conf() is missing in patch3;
>  - add some review tag from Xiao Ni(other than patch 2,3);
> Changes in v2:
>  - add new conter in conf for patch 2;
>  - fix the case choose next idle while there is no other idle disk in
>  patch 3;
>  - add some review tag from Xiao Ni for patch 1, 4-8
>
> The original idea is that Paul want to optimize raid1 read
> performance([1]), however, we think that the original code for
> read_balance() is quite complex, and we don't want to add more
> complexity. Hence we decide to refactor read_balance() first, to make
> code cleaner and easier for follow up.
>
> Before this patchset, read_balance() has many local variables and many
> branches, it want to consider all the scenarios in one iteration. The
> idea of this patch is to divide them into 4 different steps:
>
> 1) If resync is in progress, find the first usable disk, patch 5;
> Otherwise:
> 2) Loop through all disks and skipping slow disks and disks with bad
> blocks, choose the best disk, patch 10. If no disk is found:
> 3) Look for disks with bad blocks and choose the one with most number of
> sectors, patch 8. If no disk is found:
> 4) Choose first found slow disk with no bad blocks, or slow disk with
> most number of sectors, patch 7.
>
> Note that step 3) and step 4) are super code path, and performance
> should not be considered.
>
> And after this patchset, we'll continue to optimize read_balance for
> step 2), specifically how to choose the best rdev to read.
>
> [1] https://lore.kernel.org/all/20240102125115.129261-1-paul.e.luse@linux=
intel.com/
>
> Yu Kuai (11):
>   md: add a new helper rdev_has_badblock()
>   md/raid1: factor out helpers to add rdev to conf
>   md/raid1: record nonrot rdevs while adding/removing rdevs to conf
>   md/raid1: fix choose next idle in read_balance()
>   md/raid1-10: add a helper raid1_check_read_range()
>   md/raid1-10: factor out a new helper raid1_should_read_first()
>   md/raid1: factor out read_first_rdev() from read_balance()
>   md/raid1: factor out choose_slow_rdev() from read_balance()
>   md/raid1: factor out choose_bb_rdev() from read_balance()
>   md/raid1: factor out the code to manage sequential IO
>   md/raid1: factor out helpers to choose the best rdev from
>     read_balance()
>
>  drivers/md/md.h       |  11 +
>  drivers/md/raid1-10.c |  69 ++++++
>  drivers/md/raid1.c    | 539 +++++++++++++++++++++++++-----------------
>  drivers/md/raid1.h    |   1 +
>  drivers/md/raid10.c   |  58 ++---
>  drivers/md/raid5.c    |  35 +--
>  6 files changed, 437 insertions(+), 276 deletions(-)
>
> --
> 2.39.2
>
Hi Kuai
This patch set looks good to me. By the way, have you run mdadm
regression tests?
Reviewed-by: Xiao Ni <xni@redhat.com>


