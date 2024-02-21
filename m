Return-Path: <linux-kernel+bounces-74117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3916885D026
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75DF28688F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1D439FEF;
	Wed, 21 Feb 2024 05:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBmBb39G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2B538F9B;
	Wed, 21 Feb 2024 05:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494778; cv=none; b=g7ujdowp1EfAET48VfmIiHnv37ZvjO5uJkmC7ZGAxbCXQekhc77RGilST2oJK4/fhW4n8rGgHTO3z5OeXGoy5+Vp8jJ/9ljL71FASxeK4nbKVw2OefJ5W2Ba/E4xQeJaeydESjDh3VY1/b30G/rkhJp1nlkkpaPwPKaXw9zB9kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494778; c=relaxed/simple;
	bh=/zkd7k96N4tcJWUeLIevIqp0tQF7/q7P9ifjzEPwe40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcwXCDRpEs+NxY+u3QIQeIH2IgOwLH7OQVQXpSjKARM1iPVR9uBAafBR4sYuXoyqLQtZaBa6cKE1yf+dFeSEjKtRnQckqjkykuznphZf2rhv9H+YqUm59TEjZnUYYHegIbuMUij1g9RNcbbbx5gzx3+bAWDahKiBvqfmihTY1BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBmBb39G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CE4C433C7;
	Wed, 21 Feb 2024 05:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708494778;
	bh=/zkd7k96N4tcJWUeLIevIqp0tQF7/q7P9ifjzEPwe40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBmBb39GuX+FS9MGL5n70U3rBjmO45yVy0q+TDf3jwRAfH06i2SkR+BEJNHwOe2Fw
	 NNEjWTYq7HCOs0CA1XAgMsUtltLVo7IZHBCmDp8EclKrKH0B1/LUbtXqReZDgdCJYO
	 Ht7+dDxqdSTjyjruWX/EszL4VIabOYcrTJXYosTpvy+Ucfqrf7oNMGXxpIN+C0qcXq
	 TTCvfhpwRnjxXesU+NM0ybsmOhpkuHZCqT2w9iOjqoJQFwfZPNuQZ2HCdzL+inaniF
	 SXAash94SkZnqliS+ZA7DgEhzCTZe6muRqR4PC59ERBOE4O7xkJaq1YuPEluTvySl3
	 ciLW0u3Eq16VQ==
Date: Tue, 20 Feb 2024 21:52:56 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Subject: Re: [Resend PATCHv9 1/1] block: introduce content activity based
 ioprio
Message-ID: <20240221055256.GB14358@sol.localdomain>
References: <20240221052624.573287-1-zhaoyang.huang@unisoc.com>
 <20240221054124.GA14358@sol.localdomain>
 <CAGWkznHTY-ROF-D2w8BjGabfzw1yAqoGsHz321BUKrRBcWuqaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWkznHTY-ROF-D2w8BjGabfzw1yAqoGsHz321BUKrRBcWuqaw@mail.gmail.com>

On Wed, Feb 21, 2024 at 01:50:55PM +0800, Zhaoyang Huang wrote:
> On Wed, Feb 21, 2024 at 1:41 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Wed, Feb 21, 2024 at 01:26:24PM +0800, zhaoyang.huang wrote:
> > > +/*
> > > + * bio_set_active_ioprio_folio is helper function to count the bio's
> > > + * content's activities which measured by MGLRU.
> > > + * The file system should call this function after bio_add_page/folio for
> > > + * the buffered read/write/sync.
> > > + */
> > > +#ifdef CONFIG_BLK_CONT_ACT_BASED_IOPRIO
> > > +void bio_set_active_ioprio_folio(struct bio *bio, struct folio *folio)
> >
> > How did you test this?  Nothing calls this function, so this patch can't
> > actually be doing anything.  Are you planning to update any filesystems to use
> > this?
> Thanks for asking. I verified this patch in an Android based 6GB RAM
> system by modifying EROFS/F2FS/EXT4's aops API which I didn't
> upstreaming yet. I would like to recommend this to the desired fs if
> this is accepted.

This patch needs to come with a user.  Unused code can't be accepted.

- Eric

