Return-Path: <linux-kernel+bounces-149855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B658A96D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4B5283687
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D67515B555;
	Thu, 18 Apr 2024 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MI/tAaCr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F021515B543
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434308; cv=none; b=J/lT89tx89/gj8TOX/ehBrkVITyQTE0Y91VOPPMbdicNvOgnM7hKVGgXTVYa8CY8CvxCxBVJ4TMkn9eKO5ZcZw53FmtiYofC1xjKAy2HT7gJOrQ8kyuHJRdeJqXTkhsF9a+93AhZ7Mfz2zFgI9+IBrU4odVJHOejsfCN0KziCxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434308; c=relaxed/simple;
	bh=IYL6T+V3bODA/4KtalNC0fiFQICw8IbbpWhSWYj7wXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sK2a8I9db+3Zx64azQxXcGO+cObEYkqdaw6bIF23oSJuKPatgTPtWHi4yoT/yA7wXHDY9Tg0enr/J4it2FPRUe5er4g8rCf5Ams/L80gxeLJOb6smDGEZ7kDVl9C6y5vZdHXT3Gl47LkmQ8LOQbqKPuDLUvLEdhZ43fbEMMyyQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MI/tAaCr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713434305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zKPGI9ew2fkbkDGXx4HvqG1PWWY8ELG5N7Cy+nQnEhg=;
	b=MI/tAaCruDEksn8P0BzyI7M3F9ji4jy7513b8JtEFUdIUcEcAGMW5hCQglO1kX+H/LKtyC
	5sLfEIe7zLttlr1zhQAzXDHJbhLuFgmFPUS74oQYj3abRpR9eAzPdzBnHzEwjL+xlDb+Nt
	I17f28tXtCPArjIcIaSOIA+KrrSSoZU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-_Vf69qvNM-aKLu4t0LXbTA-1; Thu, 18 Apr 2024 05:58:24 -0400
X-MC-Unique: _Vf69qvNM-aKLu4t0LXbTA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5f44b50ed93so876810a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713434303; x=1714039103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKPGI9ew2fkbkDGXx4HvqG1PWWY8ELG5N7Cy+nQnEhg=;
        b=ih2dD1jMV5XljLlhOTZ0P4Tehga38iZ7MVfwEj3+9a6zRlkhXJMD5CNlKnJNZ2yG33
         9ZchBxrc0PofYQLbKmtsPB+WTgN7cPBMKkjI/h0ZLqEMf8IGPn1+ikLNW4dqNOMpc1wV
         5Hsec34H07NIeImFyiXD24NCqP/8DXlow0DWoIdGuylRi52Nl8C48SOuVxBiarP03ZRb
         MYD8JrykMcbE3P6Uq7bIxOiLf/0oLPpEzGLjvkxaPsGrPLWfS30uV95MFMoi1LYzZZAv
         03y+TQG7o63HC+NEGO3Zu7J7vt++zV8AUrrcPlwXNczGECj6gm8JDm4EGQJMCyqWYMND
         mb2A==
X-Forwarded-Encrypted: i=1; AJvYcCWR4aJqZqnNtKX5Rh4jZCqcypD3YDWyYlLRarp4FI8v+nM7zIcDTZVY9I1cuJiOLv1sN0UfmRgNPPIeeyVvBo6BxHFazJ1XAp45lAQx
X-Gm-Message-State: AOJu0YxOr/WeX1H6wapeH9Rr7O3RBlJDjHAY8h61TlbfNeQbfpMlnQMl
	BYxryBeuj2nJvGQGwa7F2IxMOwa8InddoTq6dpwn/44/tKiVqF81QBmArroGYwwG3o1A5OiiQj4
	jl/yiB+F3PrY3bPR7zFtKetmEw8IXcLAANCNq1JfYmCRgRcQhDUuHKvYMgeuEUGR/Nh0EQHe0vq
	tw2U3gMUT0MrVjWmFD7aKtnE6PyxrjIqArZuX/
X-Received: by 2002:a05:6a21:1644:b0:1a9:86dd:177b with SMTP id no4-20020a056a21164400b001a986dd177bmr3290231pzb.44.1713434303407;
        Thu, 18 Apr 2024 02:58:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa4dwQFhrk1w0SYLZzniPfi43GT7mCS2Xf+l6IkxifisTK5fxxbC7c3s1aLJXxzomHmCC4Yk8eG0UTt2+BxDo=
X-Received: by 2002:a05:6a21:1644:b0:1a9:86dd:177b with SMTP id
 no4-20020a056a21164400b001a986dd177bmr3290218pzb.44.1713434303098; Thu, 18
 Apr 2024 02:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3c0ab8eb94ad4b6fb4cb2159f0638650@kioxia.com>
In-Reply-To: <3c0ab8eb94ad4b6fb4cb2159f0638650@kioxia.com>
From: Xiao Ni <xni@redhat.com>
Date: Thu, 18 Apr 2024 17:58:11 +0800
Message-ID: <CALTww2_zw8=_wizsA=msnYsx-cKAHzHBB4maYp7T+GZmkAQvqg@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] md: avoid counter operation conflicts
To: tada keisuke <keisuke1.tada@kioxia.com>
Cc: "song@kernel.org" <song@kernel.org>, "yukuai3@huawei.com" <yukuai3@huawei.com>, 
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 2:21=E2=80=AFPM tada keisuke <keisuke1.tada@kioxia.=
com> wrote:
>
> Changes in v2:
>  - Add message of performance in cover.
>  - Fix a problem of error code initialization in patch 6.
>  - Fix a problem of sleeping during rcu_read_lock() in patch 9.
>  - Change base-commit from md-6.9 to md-6.10
>
> Currently, active_aligned_reads and nr_pending used as counters are atomi=
c types.
> Therefore, when inc/dec in a multi-core results in conflicts and READ I/O=
 becomes slow.
> To improve performance, use "percpu_ref" counters that can avoid conflict=
s and maintain consistency.
>
> Switch modes of percpu_ref to achieve both consistency and conflict avoid=
ance.
> During normal operations such as inc/dec, it operates as percpu mode.
> When consistency is required, it operates as atomic mode.
> The operations that require consistency are as follows:
>  - Zero check for the counter
>  - All operations in RAID 1/10
>
> Patches 1, 3, 6 change active_aligned_reads, and patches 2, 4, 5, 7 to 11=
 change nr_pending.
> nr_pending temporarily switch from percpu mode to atomic mode in patch 7.
> This is to reduce the amount of changes from patches 8 to 10.
> Finally, nr_pending switch from atomic mode to percpu mode in patch 11.
>
> We applied the patch to base-commit and used fio to compare IOPS.
> CPU: AMD EPYC 7313P (3.0GHz, 16cores)
> DISK: ramdisk x 3 (modprobe brd rd_nr=3D3)
> RAID: level 5
> fio config: bs=3D4k, rw=3Drandread, iodepth=3D128, numjobs=3D16
>
> without patch: 3.64 MIOPS
> with patch   : 3.84 MIOPS

Hi Tada

Thanks for the patch set. Have you done tests with nvme/ssd or hdd?
It's better to see the results with real disks.

Best Regards
Xiao
>
> Keisuke TADA (11):
>   add infra for active_aligned_reads changes
>   add infra for nr_pending changes
>   workaround for inconsistency of config state in takeover
>   minimize execution of zero check for nr_pending
>   match the type of variables to percpu_ref
>   avoid conflicts in active_aligned_reads operations
>   change the type of nr_pending from atomic_t to percpu_ref
>   add atomic mode switching in RAID 1/10
>   add atomic mode switching when removing disk
>   add atomic mode switching when I/O completion
>   avoid conflicts in nr_pending operations
>
>  drivers/md/md-bitmap.c   |  2 +-
>  drivers/md/md.c          | 48 ++++++++++++++++++---
>  drivers/md/md.h          | 62 +++++++++++++++++++++++----
>  drivers/md/raid1.c       | 37 +++++++++++------
>  drivers/md/raid10.c      | 60 ++++++++++++++++-----------
>  drivers/md/raid5-cache.c |  4 +-
>  drivers/md/raid5.c       | 90 +++++++++++++++++++++++++++-------------
>  drivers/md/raid5.h       | 17 +++++++-
>  8 files changed, 238 insertions(+), 82 deletions(-)
>
>
> base-commit: 9d1110f99c253ccef82e480bfe9f38a12eb797a7
> --
> 2.34.1
>
>
>


