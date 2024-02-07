Return-Path: <linux-kernel+bounces-55988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF04284C481
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CAAE1F23BCE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36EC15E97;
	Wed,  7 Feb 2024 05:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWuRugET"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C371CD1E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 05:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707285187; cv=none; b=oMOLdV10HeEtgmnLbNM6efOu3lMGtH2SaVc3Pvx5V5fb/Yxeb7fTIeKic4DD5fRHDuDu+bBSi5kZUeu7B2DaxIuZeTMYvh9KmMJRfNyZuGO+3/m8HzHmfQgI50omSRrS3Z2/pQ6R8FrTGdj7hul2X864iOOtpSC2TAJeLPDkFrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707285187; c=relaxed/simple;
	bh=TByPXr7dTrWn79s6knx+N7D+PQY5JFNqw/lbqQ/BLu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idfckvNERy9xiT9f70qG8HA0aipd4Tgz+0jYAZgNaDO8/Yo0s2pvvNASO2U1X59i5agJqM7F6wP3WFaePLfWbvypu8VmMoRxWA7dhKmOZ/atPGUg5T7gi21atw7rABnSsENJ6NniDcXWkLCJpHwxWlkFiwFjCd0mKPhXqXS+J8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWuRugET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95342C433B2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 05:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707285186;
	bh=TByPXr7dTrWn79s6knx+N7D+PQY5JFNqw/lbqQ/BLu8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VWuRugET//9iAp/Ke71ta5Mw+Tv2qJhWf15UxvbSj0TSVqxTEBbPmHLgEQ+JVkSIM
	 kUFxfCxYrI1riZdm8Ly6YT6Y1s3tC52RZ+8Mlad9bVxVVk/l/31zDlUvC6Rv15MqMf
	 e3ShULMeNqWM2QtQc3gUnQlWIZiiGGuS3/aG5GVbUznOQonCUGf3Gb4EAZmwQZ6L0F
	 fPFqddC1SEczggTj5W5P0Isu67iSGaZf5mR4INZoiAO/4AKlWP9fH9twJzpQK8R/Ya
	 dJYJpvo3qwHPmRT6miGDDhZ7dcQ2pX/yDGuUvNKPa/7sV+XAYFxIIT7J1g4vWO7p3d
	 yyrRvl2OKUOsQ==
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-363b2cc9372so652185ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 21:53:06 -0800 (PST)
X-Gm-Message-State: AOJu0YwxJlLaCZ43jgTa5oyD58MhZBQeOXxs1+ocwd0WbHTQ/RwuUFYl
	RiIvN4bJs0GKhHEPNRlwsogUe+NNpojDlWM4GC3u1fHK2TUJtJ6226njlsISCDGBwu+mZ10UxAN
	tI8gTcC9cd+WD9GBlGI8qppI+o+J9ZJ4LWCjY
X-Google-Smtp-Source: AGHT+IEItXQ2dsvOVA3WJNrIak4YuH04DcNdDXg3J9pUKtIGPzVHGjWe8iOrcecC+5xCvWGBzwk+7+XwjhYU0roWuR4=
X-Received: by 2002:a05:6e02:1d04:b0:363:b0fb:322 with SMTP id
 i4-20020a056e021d0400b00363b0fb0322mr6273507ila.0.1707285185861; Tue, 06 Feb
 2024 21:53:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207033857.3820921-1-chengming.zhou@linux.dev>
 <CAF8kJuOCbuFemoFNUYeNGYzYJ7eGLka6Y6OvSg8h61vXUfYdLw@mail.gmail.com> <CAJD7tkbc7j8B3X8YfQ9r00D3ojJvJg+YwNuAF6P=jyCyrGy_=Q@mail.gmail.com>
In-Reply-To: <CAJD7tkbc7j8B3X8YfQ9r00D3ojJvJg+YwNuAF6P=jyCyrGy_=Q@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 6 Feb 2024 21:52:54 -0800
X-Gmail-Original-Message-ID: <CAF8kJuN=yN-fgv3RgQYq2kEbsUr5=bD1fbWVE5QNRTGAO9JgJg@mail.gmail.com>
Message-ID: <CAF8kJuN=yN-fgv3RgQYq2kEbsUr5=bD1fbWVE5QNRTGAO9JgJg@mail.gmail.com>
Subject: Re: [PATCH v3] mm/zswap: invalidate old entry when store fail or !zswap_enabled
To: Yosry Ahmed <yosryahmed@google.com>
Cc: chengming.zhou@linux.dev, hannes@cmpxchg.org, nphamcs@gmail.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chengming Zhou <zhouchengming@bytedance.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 9:46=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> > > @@ -1608,14 +1598,12 @@ bool zswap_store(struct folio *folio)
> > >         /* map */
> > >         spin_lock(&tree->lock);
> > >         /*
> > > -        * A duplicate entry should have been removed at the beginnin=
g of this
> > > -        * function. Since the swap entry should be pinned, if a dupl=
icate is
> > > -        * found again here it means that something went wrong in the=
 swap
> > > -        * cache.
> > > +        * The folio may have been dirtied again, invalidate the
> > > +        * possibly stale entry before inserting the new entry.
> > >          */
> > > -       while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) =3D=
=3D -EEXIST) {
> > > -               WARN_ON(1);
> > > +       if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) =3D=3D -=
EEXIST) {
> > >                 zswap_invalidate_entry(tree, dupentry);
> > > +               VM_WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dup=
entry));
> >
> > It seems there is only one path called zswap_rb_insert() and there is
> > no loop to repeat the insert any more. Can we have the
> > zswap_rb_insert() install the entry and return the dupentry? We can
> > still just call zswap_invalidate_entry() on the duplicate. The mapping
> > of the dupentry has been removed when  zswap_rb_insert() returns. That
> > will save a repeat lookup on the duplicate case.
> > After this change, the zswap_rb_insert() will map to the xarray
> > xa_store() pretty nicely.
>
> I brought this up in v1 [1]. We agreed to leave it as-is for now since
> we expect the xarray conversion soon-ish. No need to update
> zswap_rb_insert() only to replace it with xa_store() later anyway.
>
> [1] https://lore.kernel.org/lkml/ZcFne336KJdbrvvS@google.com/
>
Ah, thanks for the pointer. I miss your earlier reply.

Acked-by: Chris Li <chrisl@kernel.org>

Chris

