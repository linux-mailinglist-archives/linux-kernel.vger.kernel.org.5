Return-Path: <linux-kernel+bounces-109361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A776B88180F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C292834F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C631685650;
	Wed, 20 Mar 2024 19:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2Fc3H+J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC3653E2C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963722; cv=none; b=gf5RyfgCb96jXt9qZJNoOucKg5cZzMPqYHuNhWEWeBUuHTVH0FoKL6KVTYac62XdfXvnJd41lUoODif5OzkvA8UJ7EyXhr/eqz5jFPmxRYdAtEI+PnPYBd4oeaSPI4bnI6naUdysosBnWWavKUmQbAp4LiTgyzAcq405ocjxabE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963722; c=relaxed/simple;
	bh=w5Yuh9BjXp5GoGMUuDtJBbyXbQeDSwEhm62Pk+ikl2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tE9kuGmu0wg0Es4ywsn8k93hHvd+74XsqAdB6h97vvu7eT0TPfmDa0DoIaN8Fyaih9yhB+sk/blPECKB24N2km5L/62wTpAU4w3Gdlrs7fHFYVa+Yqepv5MIg83bvH6/tBjhR8tLXVE95ncciQvOuLoGXoWaWQo4gfuklExyD4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2Fc3H+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F06C433A6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710963721;
	bh=w5Yuh9BjXp5GoGMUuDtJBbyXbQeDSwEhm62Pk+ikl2M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B2Fc3H+JI069j5/n3AEGv4loJnpcmwuGOkRsr07w/GXrXu4bZOdQVKk/P/UU/Kp9B
	 lDUkMk6Lp110B590dZ3vyefynuj8cDOWkDO+eHGdR3fo1WbN8Us3P+iK4kycU26O8h
	 d6LYf7vn+3wvm/DJkNFmETNAWDGmObhomjp9GFktypi6ZEoiR7v0IB1PKwBgEX0sO+
	 SHdUkooG3pG5BL2FlUO7FPY6L0yEfLH8RFHOWRTktD4UXYQ7/4hODxz+ft+jr+uABP
	 8D6LSTe2knqVbUq8yAYyP0FoKy9LqiAZSjwxeSlZaX355FE+TNzi6HVNa8zY/tJFi+
	 prYCrtQ9EoCmQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d23114b19dso3351151fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 12:42:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWq5OPozFQsfCqYfoTtX7RunF2V4yLzKoFSVh+tTLU/fs9G+7FbNCplVx+f5E6KP5mOcxnCBRXcxywIj34opY07VDkTeFNYmY7DCvL
X-Gm-Message-State: AOJu0YxS+BGVNjMYUSsf6xuLKi1lOsjorD3hl/u7D7QmwWGpz5S9i9wx
	MqoyzadGij+HXfR496x2wbxDZKU2x3UhaBNJsHg4PdeX/GqxLyI2kpshMgEY9lYD+7ulssBO/gM
	TY/4YOD6Nqsq1GFi/x+qCGG+u2w==
X-Google-Smtp-Source: AGHT+IEuEA/Ge7xSFr+tZYv3Qh9H+zVKCOSSZILoz1pxl5dhujyttD81clYU9kygGRZj2V94JF/mXjdXwkpmowv9gZw=
X-Received: by 2002:a05:651c:820:b0:2d4:7532:92f2 with SMTP id
 r32-20020a05651c082000b002d4753292f2mr10587672ljb.45.1710963720595; Wed, 20
 Mar 2024 12:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319-zswap-xarray-v7-1-e9a03a049e86@kernel.org>
 <Zfp-iWaDfqeCOElt@google.com> <CANeU7Q=yxf0dnerTOZfe_ioeCbjnZd2Fpb-szvW7-Q1BzCUpOw@mail.gmail.com>
 <ZfqPK7AVunq2SC1l@google.com> <20240320100803.GB294822@cmpxchg.org>
 <Zfs06maKhjH_gXqL@google.com> <20240320192558.GF294822@cmpxchg.org> <Zfs6TP8pdmNHcDfA@google.com>
In-Reply-To: <Zfs6TP8pdmNHcDfA@google.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 20 Mar 2024 12:41:48 -0700
X-Gmail-Original-Message-ID: <CANeU7Q=AXzG05BPcKPJvMDzmc8QK4UDKz+zaLQAx=RCrcsBkVA@mail.gmail.com>
Message-ID: <CANeU7Q=AXzG05BPcKPJvMDzmc8QK4UDKz+zaLQAx=RCrcsBkVA@mail.gmail.com>
Subject: Re: [PATCH v7] zswap: replace RB tree with xarray
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Nhat Pham <nphamcs@gmail.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 12:34=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> > you can expect it to be coherent.
>
> Fair enough, but don't we still need a barrier there? Couldn't some
> initializations still be reorder after zswap_lru_add()?

I am under the impression that the lru list handling function already
handles the barrier. If an explicit barrier is needed, wouldn't all
other lru callers have barriers sprinkling all over the place?

Chris

