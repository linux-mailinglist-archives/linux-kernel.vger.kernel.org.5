Return-Path: <linux-kernel+bounces-71866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A29F85AC02
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69D9283EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E43350A7A;
	Mon, 19 Feb 2024 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+2vzDpX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AED50279;
	Mon, 19 Feb 2024 19:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371189; cv=none; b=WjxesGlG0NTxzu8g1zm+Amk76VgE+KtrPgDz/Ujio0Y8mUr+KExiNYN5+/vLGhFP82mZBFEju3wubkdfwt3omM/Mp0UtVL8kZSJ3vXpcYRwZbOygg4uZCCg1m1O4hFtE2keR3V6UvSm86GjkKY5G3RmvpbNLEdZ3ur1vMsn2LRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371189; c=relaxed/simple;
	bh=Ehc5L8hBGcIcn+OwCdC4voERoSkqrERXaAWhSpNBABs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uox8yIyKvPpTkwbHVVEnWS6XgwhFvLRkeHTBrIUq9Wg0WzpLcq9MEDkcCU3q/aka11u1hkKUAmcphlwSDVDNd9nq/hypZJtyq5WG7zY7LOrJTGMcLnKgoKK+Mkk7zauh6GDV+n4AvG2kByyIafc92qQ6VflNvoWa6gXXnI4PoN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+2vzDpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A16C433C7;
	Mon, 19 Feb 2024 19:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371189;
	bh=Ehc5L8hBGcIcn+OwCdC4voERoSkqrERXaAWhSpNBABs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A+2vzDpXPmRJGvHlVFmAkKZOs2ZRDL8WRVwLykplizeAHaU8uSf9OaEo6V1s78C+V
	 U6RjQ/9KRZKTADj3wu511vgcXojZJtGc1v+veSjnk0bdi/6EAMO7E2CFfvdhL2Cjcw
	 4qOU2zGdeCscwtAOdKlz3xIK4h/xYFSBA3/IJoWktXBOZ6JyP/3Nv7mGRMwQ9NBGXU
	 ttnnmOqDSak/wbLUVVO0XijZjb2PRu3T8jf9WZ/G4vtWJZLLqAr4/D8w3a1lBQjD16
	 mm4xaFpfDiLZKBBhI/C74KLTka+GD2821PmDi83Kbe3WiFfQ2qdhUkSdqKgfFQ/YZz
	 lTgLtI1zdnHiA==
Date: Mon, 19 Feb 2024 19:32:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-kernel@vger.kernel.org, David Laight <David.Laight@aculab.com>,
 linux-iio@vger.kernel.org
Subject: Re: [RESEND PATCH v2] iio: gts-helper: Fix division loop
Message-ID: <20240219193254.2800e00f@jic23-huawei>
In-Reply-To: <f1511679-0309-4aa6-bbfe-40d0d3374634@gmail.com>
References: <Zcn-6e-0-nh2WcfU@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi>
	<20240216135812.07c9b769@jic23-huawei>
	<dfe6e5da-b104-4acd-b323-4a7fa980de88@tweaklogic.com>
	<20240217162724.767f2ab6@jic23-huawei>
	<65582213-1091-4877-ae83-c9450a3610fa@tweaklogic.com>
	<f1511679-0309-4aa6-bbfe-40d0d3374634@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 09:22:24 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 2/18/24 07:26, Subhajit Ghosh wrote:
> > On 18/2/24 02:57, Jonathan Cameron wrote:  
> >> On Sun, 18 Feb 2024 01:09:33 +1030
> >> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
> >>  
> >>> On 17/2/24 00:28, Jonathan Cameron wrote:  
> >>>> On Mon, 12 Feb 2024 13:20:09 +0200
> >>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:  
> >>>>> The loop based 64bit division may run for a long time when dividend 
> >>>>> is a
> >>>>> lot bigger than the divider. Replace the division loop by the
> >>>>> div64_u64() which implementation may be significantly faster.
> >>>>>
> >>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >>>>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
> >>>>>
> >>>>> ---  
> 
> 
> > As I understand that you have already applied this patch but still,
> > 
> > Tested-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>  
> 
> Thank you Subhajit! Your effort is _very much_ appreciated! :)
I had to rebase the tree anyway to squash an unrelated issue, so
I added the tag whilst doing so.

Thanks,

Jonathan

> 
> Yours,
> 	-- Matti
> 


