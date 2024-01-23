Return-Path: <linux-kernel+bounces-36180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6B8839D18
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1509D289F92
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DAC53E3E;
	Tue, 23 Jan 2024 23:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PBLXQPc1"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2C3210F6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051707; cv=none; b=OL80b+qfeNAzIpkQZajhccdo2NsdCuwagQPD0IRNEAfdkG/kgEKPShaf3MOKG2ab3JjZakwerbs919y/wl1t9psTLCX9hQVqEnppx+0gXxzkUt8dcwb19kpvIuVZTPDX0vcynEQOY1kSnlG7wpO7STVcUbZ0Y5UR9RjPAa7M2is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051707; c=relaxed/simple;
	bh=cz0MLnl7Ag9SteMMeHbumZMDx2jrIxHsaC/lQvGe9mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1/Hrjq68B/EljUdamHUR6Hj8V8+wtNxYtmBXFjBuxv8gkE7NzYm8c7OPlDP7ZzhEsDrArYHHsOQtQZm9zLOiKjJ/L0W2SihJRsN4xunNjn4bFbwLwybMBWYjHvQDq3InX2amCc09Mba5NrY2hQN8dUFK1KWiu40rCP2zMdo16Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PBLXQPc1; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5fc2e997804so43136287b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706051705; x=1706656505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcYIFjLKHJPo13ATlbJMOamcmoz+SKTV6ypUYG09A6o=;
        b=PBLXQPc1RLHy0jaqWmI0btpjkJl/aP8DuvHWPJLsflwCD4K0lTKeeiDh7PzyW5F65S
         dQj8LHvCJ9/v9t5XycvEUdu7sL2PQwRVPgHZJlvhGhC/vsBWC5wJ3Dqj6ZxhSUoZOoc3
         Oh+eNtVM4ZcEFGf/iJByLB4g662h/b/fpUa/3lFsn8FmKws6vBRuFTq7TH69u4OhxwoU
         pYSGw945Z0xFIr7rWJUAYF8g21Bn3j2MGaWbBnctuoPoQZrVK6QCrBcgjRJ054cy68PW
         TC9B0RGV6J7kF2sIrZ/+xMsItD9k96fcyB3EeL/cU1x2K+gDyQyuU6N+7DSdulcT72is
         LtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706051705; x=1706656505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcYIFjLKHJPo13ATlbJMOamcmoz+SKTV6ypUYG09A6o=;
        b=O62KKFrwKXqVQQUgCxsu+SLkCEH0B7FHi3wqAIzKrKvj/86TBSz2EgpP3Mvzi4Y0H1
         pr7gOeVpFS4M3dY09Orbthz3NfkbilWDgOVRbPb+DWZtjNfBmvoGMtnyiUU5iwM9qsbv
         ExO/VheYG6Ju2zkNG3rWqqdWtDQO+QZytLkGRbR7jV8Vz2aNUxQTSL2UJ3dnCl3KNU2H
         djO7m5JmSULchsW26SfTHT3JtD/Vw1HmX06Iw59R0dZsshieIhGA31jjzZNqRqAzaH2n
         WNzCxoP5Lkg013GNykCxR46p85pLV3p4oBDFet+Ey3EWbI6WFfewyAp7M3m404rt+EVm
         MKSA==
X-Gm-Message-State: AOJu0YyxEklCyyrRsA4xP028Stl5sPGshS4QmJkWou438SvmY1jll3Ly
	dmqFl2K2LtC7DxeO2duu9JwdTM3w8rF/rBImW8oXHDQT75age4/nB86/XRwE7Y/1iB5jELDY7VC
	EMvu6DKV7sT3T8Zcnw9VhZqY/7DgXs4AqUtW7
X-Google-Smtp-Source: AGHT+IFtiRjfpSGEXBYjTqsANyxGwikn33+ecyOIytDLaYVUYpRNhhxsRUMFciY0EYcFBk/3s0c+GdxewEKWJiF/448=
X-Received: by 2002:a81:a115:0:b0:5ff:314a:99c with SMTP id
 y21-20020a81a115000000b005ff314a099cmr5300070ywg.5.1706051704761; Tue, 23 Jan
 2024 15:15:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124100506.67f0df5f@canb.auug.org.au>
In-Reply-To: <20240124100506.67f0df5f@canb.auug.org.au>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 23 Jan 2024 15:14:53 -0800
Message-ID: <CAJuCfpHJLWncN3rqNYbyTpcSeD_ykQxrKCM5y6HjU-zQw8bNRw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 3:05=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
>
> Hi all,
>
> After merging the mm tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> fs/proc/task_mmu.c: In function 'get_vma_snapshow':
> fs/proc/task_mmu.c:145:19: error: 'struct vm_area_struct' has no member n=
amed 'anon_name'; did you mean 'anon_vma'?
>   145 |         if (copy->anon_name && !anon_vma_name_get_rcu(copy))
>       |                   ^~~~~~~~~
>       |                   anon_vma
> fs/proc/task_mmu.c:161:19: error: 'struct vm_area_struct' has no member n=
amed 'anon_name'; did you mean 'anon_vma'?
>   161 |         if (copy->anon_name)
>       |                   ^~~~~~~~~
>       |                   anon_vma
> fs/proc/task_mmu.c:162:41: error: 'struct vm_area_struct' has no member n=
amed 'anon_name'; did you mean 'anon_vma'?
>   162 |                 anon_vma_name_put(copy->anon_name);
>       |                                         ^~~~~~~~~
>       |                                         anon_vma
> fs/proc/task_mmu.c: In function 'put_vma_snapshot':
> fs/proc/task_mmu.c:174:18: error: 'struct vm_area_struct' has no member n=
amed 'anon_name'; did you mean 'anon_vma'?
>   174 |         if (vma->anon_name)
>       |                  ^~~~~~~~~
>       |                  anon_vma
> fs/proc/task_mmu.c:175:40: error: 'struct vm_area_struct' has no member n=
amed 'anon_name'; did you mean 'anon_vma'?
>   175 |                 anon_vma_name_put(vma->anon_name);
>       |                                        ^~~~~~~~~
>       |                                        anon_vma
>
> Caused by commit
>
>   786cebbd51a4 ("mm/maps: read proc/pid/maps under RCU")
>
> from the mm-unstable branch.
>
> This build does not have CONFIG_ANON_VMA_NAME set.
>
> I have reverted that commit for today.

Yes, this problem was reported yesterday and I just posted v2 with a
fix: https://lore.kernel.org/all/20240123231014.3801041-1-surenb@google.com=
/
Thanks,
Suren.


>
> --
> Cheers,
> Stephen Rothwell

