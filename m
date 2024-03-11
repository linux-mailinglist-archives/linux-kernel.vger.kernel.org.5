Return-Path: <linux-kernel+bounces-98617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF30C877CB5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 778DCB20B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8F417C77;
	Mon, 11 Mar 2024 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjhv/Zpo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F761756E;
	Mon, 11 Mar 2024 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149302; cv=none; b=UjnhXsy1VReydPp4jXVnxiHIDbAn9OZjcV+5ln6TXlX1mF5I36jTZEoOZ4LrxVmVgJDh9AYeDmz5B338ZPog2cnkBozTb20b0qnoD9G6mkgmO/p04hYfuKjk8r112vI2juHidK83gh/LfuNHQMP5iQiTfsF5vg9T+CTQIV6qtVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149302; c=relaxed/simple;
	bh=CZz1SStjRYa5gA+pzYzI6DScrjzAK34yLiBd3eSn7OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upkXqZEcGVCBSuQDPtsnWFg3ZqjJIzFyX0bL1w2Ee1EZtJfbfiV92KMiqUi1GeLboUO7lV/wr6bTzMgvsCuxJE4jCf8x06ZaZrMQ210hkVEkaQlUwfgYjRStAkjeBsMkc3zIDwhCG5HL2iXX9PyWcXO9a0LAim5d6LYicb/Tg8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjhv/Zpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3B3C433F1;
	Mon, 11 Mar 2024 09:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710149302;
	bh=CZz1SStjRYa5gA+pzYzI6DScrjzAK34yLiBd3eSn7OM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tjhv/ZpoX12XOo2I3gSu3TeIMfANUFWUOVc4WeeGSxZgUmENDriqsmt0LHKJPQahW
	 5+cqskLul9dHqf4b/MnLh+nEYmlfzIBHSi6LBIbobzryCARnp8/7w/4y4zR2UkUCwu
	 +3kTbnD9Egt084iRhv/Ymlzaip7ektKyhNzaLvrm2+z6Y1yrYxMxB4PTZL4bRKQCFR
	 HYy0eP1kmXTrboVGrG8wwVY8lLnqtr21SIm6JY2LzTpZVTGXprB8FN9sX1vv3SOOrL
	 bKm7+dwwemS/fvVDUhFInhTUWMNUKx7Tsh+Tlgzm431kz4m9jyf7U7FAytxvdXdA2F
	 mBBiA+qZ6w0dw==
Date: Mon, 11 Mar 2024 09:28:13 +0000
From: Simon Horman <horms@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] overflow: Change DEFINE_FLEX to take __counted_by
 member
Message-ID: <20240311092813.GJ24043@kernel.org>
References: <20240306235128.it.933-kees@kernel.org>
 <20240308202018.GC603911@kernel.org>
 <202403091230.ACF639521@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403091230.ACF639521@keescook>

On Sat, Mar 09, 2024 at 12:32:45PM -0800, Kees Cook wrote:
> On Fri, Mar 08, 2024 at 08:20:18PM +0000, Simon Horman wrote:
> > On Wed, Mar 06, 2024 at 03:51:36PM -0800, Kees Cook wrote:
> > > The norm should be flexible array structures with __counted_by
> > > annotations, so DEFINE_FLEX() is updated to expect that. Rename
> > > the non-annotated version to DEFINE_RAW_FLEX(), and update the
> > > few existing users.
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > 
> > Hi Kees,
> > 
> > I'm unclear what this is based on, as it doesn't appear to apply
> > cleanly to net-next or the dev-queue branch of the iwl-next tree.
> > But I manually applied it to the latter and ran some checks.
> 
> It was based on v6.8-rc2, but it no longer applies cleanly to iwl-next:
> https://lore.kernel.org/linux-next/20240307162958.02ec485c@canb.auug.org.au/
> 
> Is this something iwl-next can take for the v6.9 merge window? I can
> send a rebased patch if that helps?

Thanks Kees,

I think that would help in the sense that from my POV it would
be more in fitting with the usual workflow for netdev patches.

But if the iwl maintainers think otherwise then I have no objections.

> 
> > > @@ -396,9 +396,9 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
> > >   * @name: Name for a variable to define.
> > >   * @member: Name of the array member.
> > >   * @count: Number of elements in the array; must be compile-time const.
> > > - * @initializer: initializer expression (could be empty for no init).
> > > + * @initializer...: initializer expression (could be empty for no init).
> > 
> > Curiously kernel-doc --none seems happier without the line above changed.
> 
> I've fixed this up too:
> https://lore.kernel.org/linux-next/202403071124.36DC2B617A@keescook/
> 
> -- 
> Kees Cook
> 

