Return-Path: <linux-kernel+bounces-31588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC0D833066
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC511C23C19
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084C158220;
	Fri, 19 Jan 2024 21:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CkHWVNUI"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28915813B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705700517; cv=none; b=md2gEGf3QHlkHpm6OB1abomGzqLdBPF16fbOpGqDrO5fFZjmJZv/JbAXeMGUslcNkEcy75yfdVobgA7kL5IOV/DNtCsVZ39opIebAuQGSFMr79bAjH5O67grUpjf7x2C1Pn8hVOyrj3UfOfPsn7GhoeQH8xurQcdRTZ9GzJTKIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705700517; c=relaxed/simple;
	bh=roPkJ72qX3D/LLSruXMXv6yBhUwpk53I1DWmelrkFy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogvEf8k0dC5xQCA+/6aQTZcr9NYOfe3dFcMdJoiadWs8jU6XRkkFyiziLCPlLIxp+qj+UlZ22C4H59GNe+OsGnuF5sKt7KQHB9GT/oKaScAQ27YUfW/D5KVtMSQRXBgLtLzqnv75Qu5mBJW6nwQUg4WqLOMOY7lhqPnELzxMoR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CkHWVNUI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so214986466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705700514; x=1706305314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcFWmlndrDxwQIucMkObmlK4y/TY+5k7KMu1h6SIT0E=;
        b=CkHWVNUIaL2edoS53MhpWx+DGGoYNEUzHdxnc88Yt0GH2G58XRj6dxicObHZ/7v+9Z
         jaCT5E5FjLn/WtZPv1afMp6Rdg7tEa/GdrqeZjotmpBRZtEtb96p8FWTlTPZQ7AbFrQL
         8xRR0i64yw7XaYaP09A5XCquozAG1eGGCC4sJY6vXbjOYM9jZYs37Cztscf+2PKhFGnc
         LzNoNoq4xXorDdegdckjLjq7Zj8YeVIRYW4M1XrwYedT5351WzondbeJnv1HWV+z8f1Y
         uNzZ7+Vv8md5G6SoisBZtmd6UedSAwOjsq57Z3rE0ANEHeBpd9xIObLlafvOIzZ188p0
         KJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705700514; x=1706305314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcFWmlndrDxwQIucMkObmlK4y/TY+5k7KMu1h6SIT0E=;
        b=cDrv5CoUBnVnpqU+PWPrzetSdQXFnOQWVNbCJxCdP3LEEVM64MjjRQstrJwEvUzlJ7
         BohKNkNE6LBb/klvLT6oz18a2Z0qsslkVT4EQMF8CD/MaN2rHn6dK1PEUF4azkN87i90
         UaDlsN1UKJ66c8RnR1L3scA7V98wIqR4HhF5hBDp71Ui0/X2q93mqsqyHQDwaQww+LK3
         6qjcp+3VLQZyG3TmZchL/GY/1ABGhpXxgohoewfnLRN97u44wRqdIWcbDST0aJAnnMr7
         hJVoRlASXN1LCUP+1G20LVKDw8K5Rk6xa82oTtxwshEwtwFvPAbQk/uzshzBnRp7gZb8
         8xiA==
X-Gm-Message-State: AOJu0YyieI+7y3R17iX6LsQ0hFt8QUd4+PdBQTza7rHn3YHGdOrTtrss
	YgNA99ZMbAJLVG4a5wLv+ZJwIzS2puo7qYO/MgksO5oEUAvXXdkDvCfCwwDHJDT06w57ZYcJr8M
	WGp7RFtDgcEzSmXOXLjI+gqEAF+QOFx6+LqDx
X-Google-Smtp-Source: AGHT+IEc+s1Tk1L/GNE2hQfOrba25VkpKklcVWURxF3gHpnWEpwyBWcoyjYwqZ6MB6C5WLi0zW8EfjEtdzKoGrNyIAM=
X-Received: by 2002:a17:907:c003:b0:a2b:2de2:8dd4 with SMTP id
 ss3-20020a170907c00300b00a2b2de28dd4mr565869ejc.15.1705700513697; Fri, 19 Jan
 2024 13:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <20240117-zswap-xarray-v1-1-6daa86c08fae@kernel.org> <CAJD7tkYEx57CPBoaN9GW4M3Mx-+jEsOMWJ02nLKSKD-MLb-WPA@mail.gmail.com>
 <CAF8kJuO5tAqwyKQK7AasWgs3Ohfc2osD9oX0m8YAkfsAZsjjyQ@mail.gmail.com>
 <CAJD7tkY6K8q1t-nzZ7oJu-f3OgS654PiOcQgU=E6f+0joYSzPA@mail.gmail.com> <ZarV0Iyq7Wor_Dvc@casper.infradead.org>
In-Reply-To: <ZarV0Iyq7Wor_Dvc@casper.infradead.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 19 Jan 2024 13:41:16 -0800
Message-ID: <CAJD7tkYTU10W4WX3HXzs3t4hKRLZ0saX0Nd8RDcaoYj58bzbsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: zswap.c: add xarray tree to zswap
To: Matthew Wilcox <willy@infradead.org>
Cc: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	=?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	=?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 12:04=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Fri, Jan 19, 2024 at 11:29:42AM -0800, Yosry Ahmed wrote:
> > I see, but it's not clear to me if the xarray is being properly
> > cleaned up in this case.
> >
> > Do we have to call xa_destroy() anyway to make sure everything is
> > cleaned up in the xarray? In that case, we can just do that after the
> > loop.
>
> You do not need to call xa_destroy().  xa_destroy() exists for two
> patterns: first, that you're storing values, not pointers in the tree,
> and you can just delete the tree without leaking memory.  second, that
> you do xas_for_each() { kfree(p); }; xa_destroy();  that's more
> efficient than xas_for_each() { kfree(p); xas_store(NULL); } as it
> batches the freeing of the nodes to the end.
>
> if your code is naturally structured so that you delete the entries
> after freeing them, you have no reason to call xa_destroy().

Thanks for elaborating. Based on this, I believe doing xas_for_each()
{ zswap_free_entry(); }; xa_destroy(); is both closer to the current
code structure and more efficient.

