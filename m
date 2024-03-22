Return-Path: <linux-kernel+bounces-110866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDAE8864F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE5B1C21255
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2A43C39;
	Fri, 22 Mar 2024 01:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaFzIh36"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D559565C;
	Fri, 22 Mar 2024 01:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711072603; cv=none; b=buN1fciXtwkJY6IwfrT6xy+dDybajTzMPQn2tLFrBFUbv8rphbUKg4yU0dwJetY4tu9+o/ctWjn64y5UNXa3kERXNck+IwEG3uk4Uf0wZWy3sGnxzI2ombWrjSG8AoNQ4xGTPCULYUJRCZOGbCV8TRZd9HjjQ0Iq0JgnhAxOVy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711072603; c=relaxed/simple;
	bh=VoG0W9cXpUwH6re37sUzDR/3HQQQ2d4OzANWiCt7eqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZ4bSgB9+sSyvSkwATpbUPFvSBXi9/hTuKqQruvcbRd1ejbbIk3vToXdkHBSWZFto0sd3PvmVmy4lU5QgobefduuRCkeIeFt2+gXbJ4hJqdYR8h72IYybg5ULCvJErTSd5e+8e5yjw7/+Ys+1tgd0XWH3OvcRHfemTpGg1Sgfng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaFzIh36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52266C433C7;
	Fri, 22 Mar 2024 01:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711072602;
	bh=VoG0W9cXpUwH6re37sUzDR/3HQQQ2d4OzANWiCt7eqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LaFzIh363xEb2xBjcqJ3SOcCyKEL/L67LYR5OhXklrOKxt3Nz/OGhpLG05Yuobz7p
	 UvoMEhEA7v+/3aJsiURC9gCniS1REFMiJdsce1HmxK1xdVDh1SKv6KrGz/NH0tEhY9
	 2Y3pzzk+2cPes5r3lzCLxMBaBy3oIFhHAyy/4qxnTqtZpnyJlGMBHoWuV6Doeo8Puk
	 B1Zj9RhDpuiP7JXzUOY8kv5T5b+aqlTmWUfBVOHtRQv8yY2MQbmqlwAf8kigBwwtou
	 mK8/k2zw/4vl236jVzvXqwSQqM8Jy6AvMcZ8gj/yTO237VDOyAML220QcqcJ2MiqO0
	 9cAKzemKsVqTA==
Date: Thu, 21 Mar 2024 18:56:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, <kernel-janitors@vger.kernel.org>,
 <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>, "Maciej
 Fijalkowski" <maciej.fijalkowski@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, David Laight <David.Laight@aculab.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jiri Pirko <jiri@resnulli.us>, "Jonathan Cameron"
 <jic23@kernel.org>, Kees Cook <keescook@chromium.org>, Lukasz Czapnik
 <lukasz.czapnik@intel.com>, Paolo Abeni <pabeni@redhat.com>, "Pucha
 Himasekhar Reddy" <himasekharx.reddy.pucha@intel.com>, Dan Williams
 <dan.j.williams@intel.com>
Subject: Re: [PATCH net] ice: Fix freeing uninitialized pointers
Message-ID: <20240321185640.6f7f4d6b@kernel.org>
In-Reply-To: <20240321184828.3e22c698@kernel.org>
References: <e5172afb-427b-423e-877a-10352cf4a007@web.de>
	<F2FBADE8-EDF9-4987-A97B-CF4D2D1452E0@inria.fr>
	<b9dc2c7a-2688-4a7b-8482-1e762c39449c@intel.com>
	<20240321184828.3e22c698@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Mar 2024 18:48:28 -0700 Jakub Kicinski wrote:
> On Thu, 21 Mar 2024 15:27:47 -0700 Jesse Brandeburg wrote:
> > The gist of it is that we should instead be using inline declarations,=
=20
> > which I also agree is a reasonable style for this. It more clearly show=
s=20
> > the __free(kfree) and the allocation (kzalloc, kcalloc, etc) on the sam=
e=20
> > (or virtually the same) line of code.
> >=20
> > I'm curious if Jakub would dislike this less? Accept? =20
>=20
> At present I find this construct unreadable.
> I may get used to it, hard to say.
>=20
> Also I don't see the benefit of the auto-freeing construct,
> I'd venture a guess that all the bugs it may prevent would
> have been caught by smatch. But I'm an old curmudgeon stuck
> in my ways. Feel free to experiment in Intel drivers, and we'll
> see how it works out =F0=9F=A4=B7=EF=B8=8F

On further reflection, yes, of all the bad options moving the
declarations inline in this particular case is probably the
least bad option.

