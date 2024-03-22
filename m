Return-Path: <linux-kernel+bounces-111672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D697E886F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90657284B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00514DA05;
	Fri, 22 Mar 2024 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsMClaxW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24B9482E4;
	Fri, 22 Mar 2024 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119820; cv=none; b=fHEfA+o9g9YL6MHnxiH0+CMRuoEGGpIXRhO00Qg3a9HNg+6jgN7QQD58jeDeH2WU4ctK6OZQojhfqEaktbWo/MrUJU1Zi3cZuID/yCEXdUDCaaXrNaPUhyYX5gGvvy0kEgT6B0jsE1XdczahcvT1v716HIxDWh02lLXPzI6/Mwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119820; c=relaxed/simple;
	bh=wLpygW9FYxva6ods0rOQA5KWZKfQ7KIT6Udekt7Xvzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtNdujTpJP7Q4eFOp+OdRtzGSfQXCYah33qkT8ncN8sNtitqNTWyX+3Ju4X69jRyMRrKmo29LZE9eWjlCtiK2foQzYgFXvelUMtNd62HS4WN2AYeKc40Lm2YkbU72j7ShsrSW5LaIJvoANVlHHV37H2fqBRbdz2it0P/ykhw7YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsMClaxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677EEC433C7;
	Fri, 22 Mar 2024 15:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711119819;
	bh=wLpygW9FYxva6ods0rOQA5KWZKfQ7KIT6Udekt7Xvzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HsMClaxWIL79OYvoZ8cCAZo3NCiLqVUVbM8EsiW5QpNgi93yEvJawTHzns5ULfJCO
	 n00xPAvdfP0vMk06wppenLie8WV1EIjMZueUVspAQwVEmI/p2+aA3KDQK1DUESxRaW
	 1acKFSnQkigbvo4uCcwwFDlVPgBW7lZzMB4r0dLyKweS5jummg5uz+yUlwrXwf05ba
	 bfd6ZO/dqMDWuKkXAUs209wP8DGJflrkBVylnANK/kTyBSK4eyPaKmoKxVbCor5lDs
	 EPK2D8hNL7Qu/eF2buvDTZ13shSleFGNj79wORHDYxPPTtkgXskAfoagKcoA6d9A33
	 WlEuxdWcIUeMQ==
Date: Fri, 22 Mar 2024 08:03:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, David Laight <David.Laight@aculab.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Cameron
 <jic23@kernel.org>, Kees Cook <keescook@chromium.org>, Lukasz Czapnik
 <lukasz.czapnik@intel.com>, Paolo Abeni <pabeni@redhat.com>, Pucha
 Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>, Dan Williams
 <dan.j.williams@intel.com>
Subject: Re: [PATCH net] ice: Fix freeing uninitialized pointers
Message-ID: <20240322080337.77a10cfd@kernel.org>
In-Reply-To: <82b49991-eb5a-7e8c-67e0-b0fd932f40b4@inria.fr>
References: <e5172afb-427b-423e-877a-10352cf4a007@web.de>
	<F2FBADE8-EDF9-4987-A97B-CF4D2D1452E0@inria.fr>
	<b9dc2c7a-2688-4a7b-8482-1e762c39449c@intel.com>
	<20240321184828.3e22c698@kernel.org>
	<82b49991-eb5a-7e8c-67e0-b0fd932f40b4@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Mar 2024 03:24:56 -0400 (EDT) Julia Lawall wrote:
> > At present I find this construct unreadable.
> > I may get used to it, hard to say.
> >
> > Also I don't see the benefit of the auto-freeing construct,
> > I'd venture a guess that all the bugs it may prevent would
> > have been caught by smatch. But I'm an old curmudgeon stuck
> > in my ways. Feel free to experiment in Intel drivers, and we'll
> > see how it works out =F0=9F=A4=B7=EF=B8=8F =20
>=20
> In my experiments with of_node_put, there seem to be many functions where
> removing the frees makes the function much more readable.  But
> kmalloc/kfree may be used in different contexts, where the management of
> the memory is a smaller percentage of the overall code.  So the tradeoffs
> may be different.

Good point! References are likely a very good use case for this sort
of thing. The act of bumping a counter lacks the feeling of lifetime
we get with an object :(

