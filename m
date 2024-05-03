Return-Path: <linux-kernel+bounces-167167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D308BA528
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30B41F2157E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83277134A9;
	Fri,  3 May 2024 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CvCkqmHf"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E6BA2F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 02:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714702050; cv=none; b=Qz2FfUnBpQeQkxP+7+5U7uvJ4xMn5Kfhq0BOJqCSOEcF+rzPQGYB6krelYX103XMwhatsVMjK+qwoxCzHlThmUtPKAnB9WoNyGJaYcF4SraLk2W+dovWSdC1mg3qWyee9Nf4BDNt0zZUGRoLinQCE34RJITXD/UeOQRzMw7VBFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714702050; c=relaxed/simple;
	bh=hs4PEv8xh7/XhwxrVOthopcHb4VoKw8p8nCkkni6bmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBM9SfHPAerFX3nROSWw2oMtkOpOmtMw/umCQ4+HwK/loG9iPv4uuADwO+ZAnE0e5aHts3wj5dEF/FJdFuizFOp7Pg1BxWZn5bI3pM+/loWm03mL+n6DvaZocX49blYI+nz0NDX0m3HiPE8sFDMmGgGFXHEdUlbQqu1n49RV0Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CvCkqmHf; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516d4d80d00so10856578e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 19:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714702047; x=1715306847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJrtYsU7ekXDKHkSe8mX9YgTBJPSi4fRDqN6RMmLDgA=;
        b=CvCkqmHfC+Ilx3fsOItT81C7Az/dsKBK6xwCLx30sK7+JftINEwbOFIYqkLFW1dPEo
         HXjwp+qoRTukREKMMLJnFAnfR42YjoprrAxwQjP0DVciurYciGqPO/NuDRjiV79R2Dz7
         26bXssEawy0UYudduJTuA7iVKLXhEvB+RfuPlu9W3EYN1SNoFdon4Ac/H22TD7szaWKX
         RvZ5+UvkblCBF9mChP5mIYHPIUrdfgFKWfDtffbviXN6DselsZQ1rAH1PhVyq7nYjncr
         o2f4GGf9XyC2ozS6lkhX8tWT8YjiwiN3lpcrGM21IYEYgcj5ERdPRXpUOXOYk8BxGu11
         PWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714702047; x=1715306847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJrtYsU7ekXDKHkSe8mX9YgTBJPSi4fRDqN6RMmLDgA=;
        b=OGflZYXui/tWIC5fFyAOukQ0hKM3GkOl1Mgp9dUJ8JdtYWYFJBaqAUsSGpofVMx+T9
         45WYJoMS0sF/4bF69sfkWS+gvoCVwQqv2n7gjmGtfp46ScwF5o/ctr4ptjLoHje5Uorm
         RrXbwg8mp0WYTysLcvBYZc1xncqFrtwPDfRiJKpPYTShXwZqb+SsqJE408H07xUh/+hY
         7dauZFyiKKQOXz9tw9D563JxTAfAJq6I4b2ztd5dhDghBAbt4Cvui1vRofq/s1lW5NgG
         qBuN37oogEI7+6Zevwa9Au/cgBsX977buopmUybqf/AuBebLUj+yDWyqMzyGn9cG5kni
         dgWA==
X-Forwarded-Encrypted: i=1; AJvYcCVmpBCVUpSwFljpKxaiKFiAZrhQqnIq8xG+Npt6nFV46FHI+6BvQn8zrQGJMoCuUOq1FshShZdVUNITFw/2VyFn8De5j+8V4vXxfOlb
X-Gm-Message-State: AOJu0YxM31UddMqarz3bVOFomYXXdnI7UxJGWFuuo2e5futeTKSAccua
	ZM8awDLOG3my1J437wrNuGQt40p1q+HP1vBBUkWyPUpuXJR6Hdgj8cL+9y+Fhxr4bVRRqWxgUr+
	RQBE+Vvz7s9lPXNytCz7ESSVqstsX0lyVdfGT
X-Google-Smtp-Source: AGHT+IH3BNa+OfWhcjhYgjYPNeUgQUqIL3S8QOwfCsVAA9Rubgu4KLI4vw8am1ku907CHfrHR/bze4P6anRW1GMqaaE=
X-Received: by 2002:a19:9118:0:b0:518:a55b:b612 with SMTP id
 t24-20020a199118000000b00518a55bb612mr812100lfd.54.1714702047015; Thu, 02 May
 2024 19:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502200529.4193651-1-usamaarif642@gmail.com> <20240502200529.4193651-2-usamaarif642@gmail.com>
In-Reply-To: <20240502200529.4193651-2-usamaarif642@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 2 May 2024 19:06:50 -0700
Message-ID: <CAJD7tkbgknhot8Kz9jpF=0z1OHiLH5s3PfmbHd=TetrK7PtC6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selftests: cgroup: remove redundant addition of
 memory controller
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 1:05=E2=80=AFPM Usama Arif <usamaarif642@gmail.com> =
wrote:
>
> Memory controller is already added in main which invokes
> the test, hence this does not need to be done in test_no_kmem_bypass.

nit: The memory controller is "enabled", not added. Same for the subject li=
ne.

>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  tools/testing/selftests/cgroup/test_zswap.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/=
selftests/cgroup/test_zswap.c
> index cd864ab825d0..19ac29c533e0 100644
> --- a/tools/testing/selftests/cgroup/test_zswap.c
> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> @@ -485,8 +485,6 @@ static int test_no_kmem_bypass(const char *root)
>         trigger_allocation_size =3D sys_info.totalram / 20;
>
>         /* Set up test memcg */
> -       if (cg_write(root, "cgroup.subtree_control", "+memory"))
> -               goto out;
>         test_group =3D cg_name(root, "kmem_bypass_test");
>         if (!test_group)
>                 goto out;
> --
> 2.43.0
>

