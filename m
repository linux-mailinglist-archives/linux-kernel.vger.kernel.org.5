Return-Path: <linux-kernel+bounces-62493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C50D8521A0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DC528236C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE5A4EB4C;
	Mon, 12 Feb 2024 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tNizHiIT"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D404EB23
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707777768; cv=none; b=O6pL0WdmcA/eZIzw7rD3y7ZYKGGuuvnYBeAHnS+7qaQhh8tUY/oy9AkankVuy0TJ/ExoB+4rtqAl9QWK4NZ4wX26GzMi4M9Bkrs3Rfrv9tQrMShy73B3k+RO+V9GwSqTiMvlK1ngeU7e+PX0evItZp6Z6ycJ3TMnBfzK4WmWMj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707777768; c=relaxed/simple;
	bh=e0gPUIkWXu2GXoStCrj5iVTRXASa+QcWboJpNbQHy2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/Db/1xRvG8xIm+pbZKpSwSojflxqM2XFY34jpIxtcfse+rQuFHjvGM9vbHZ3y3C+BZnmPH1g86Ib7PAJeCf+/oJPpLV+pfA5iFcznniQKGDkXFjVN4pr7V5VMOjaqWO8e/eT4dGez0CeGGz8mcNLnW4XPxuIu7wK8wQldC94+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tNizHiIT; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-46d34c22594so448229137.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707777766; x=1708382566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qwxet0SdK/KijzcEcZqFiBIv3Lx4sNueH8dt0TXMEA=;
        b=tNizHiITVRbSSUUNU/apd8Fiqnb6uSQvzTVtZfFwPiNOfQauwx2h5hEHj1OF0IHOnM
         xdxtVia8pphAW+g+QoBkLMP33SgIZHJ1KnI7enmDwhhiLSU+GiIlIeyC/uNvIl3ySI58
         SDTHdmbyfvSQsgi5BlX8oS+2J6bHooW/vUxXjwn5VK28IgP4+xGVhHFpTUYzpdHSidsw
         UW8ezw9Vm1MoqXnxfxPas3S5iYfAa2IGQbBIG3olPOgtIfU3RN9q5GXKOS9FY3ZR7TdO
         L0vJtC+XSkVxCLX093GF6BiLxgu15w7gl1xs/uE0+w1DXUuRb126I0btevJwx9dURvCK
         Lg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707777766; x=1708382566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qwxet0SdK/KijzcEcZqFiBIv3Lx4sNueH8dt0TXMEA=;
        b=w3qKiCdYHLPUyqdmvN/oyPxpvQ75MAhUrJvYC5UGMlakZ4/KAFwZTG/XJORXU4mRoX
         drUAX/5R2l9MuEI4CpPpGXla0lCiC8pyg3lgNjfQFGF8/epOw0xuiiK/Wyx6PAsNZ8bb
         bMGiKLnvLsxFpzXW6l5kW6b1WQZgppbEvxXRdgqxZdi6U1jkha5ot3NcGW1y0+ynJCZ3
         w4nqRek7rvLdZZTjKjamODMN3meyw6RQO11DhvVHfXHMGadtmzKXwS6g9MYOYtdnhzuc
         DZOkVRJr/oystGNn8kGZZJGC1Xu4Vdn8r4wA9McjZUBtyp+MjVYW4MWSCRyB1d5pGHGd
         wkfg==
X-Gm-Message-State: AOJu0YwKYCAb2WzvaqvodNG7RGHpld62YN6s5FyVqT7rqbuvMf4d8VYW
	ei9UVFhfokDF+QLRaSTQeHct9BoynfIJ4NOMHY+g6HG5+eHVjS9Bps787xiGVPyhooQ/BA85DrE
	7PGFyw07VNHCV6qWuaT6UTtiPvPoILVaZEGa0
X-Google-Smtp-Source: AGHT+IH2PFWckqE2GJ70cLraXtxiXeFdzwkuapkjt2RE/iVug7s4bx+SA7ex/sf/XeUJ6mzlBaAZrxr8mL3iAaLX638=
X-Received: by 2002:a67:f8d7:0:b0:46c:ae93:9c7 with SMTP id
 c23-20020a67f8d7000000b0046cae9309c7mr4378021vsp.18.1707777765979; Mon, 12
 Feb 2024 14:42:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210-zswap-global-lru-v1-0-853473d7b0da@bytedance.com> <20240210-zswap-global-lru-v1-2-853473d7b0da@bytedance.com>
In-Reply-To: <20240210-zswap-global-lru-v1-2-853473d7b0da@bytedance.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 12 Feb 2024 14:42:09 -0800
Message-ID: <CAJD7tkYdEWrrQj+MFNpDR6FHc60czXcuawh3dd1rSF=QQm6+yg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/zswap: change zswap_pool kref to percpu_ref
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 5:58=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> All zswap entries will take a reference of zswap_pool when
> zswap_store(), and drop it when free. Change it to use the
> percpu_ref is better for scalability performance.
>
> Testing kernel build in tmpfs with memory.max=3D2GB
> (zswap shrinker and writeback enabled with one 50GB swapfile).
>
>         mm-unstable  zswap-global-lru
> real    63.20        63.12
> user    1061.75      1062.95
> sys     268.74       264.44

Are these numbers from a single run or the average of multiple runs?
It just seems that the improvement is small, and percpu refcnt is
slightly less intuitive (and uses a bit more memory), so let's make
sure there is a real performance gain first.

It would also be useful to mention how many threads/CPUs are being used her=
e.

