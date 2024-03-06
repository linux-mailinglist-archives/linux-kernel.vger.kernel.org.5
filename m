Return-Path: <linux-kernel+bounces-94128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCE4873A54
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244B51F2A61F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E99137913;
	Wed,  6 Mar 2024 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsFRTQzv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721B0133402;
	Wed,  6 Mar 2024 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737691; cv=none; b=uDC+vRWAvnWK5MfSW4ZquE8sYba/PEjXCQd8GQmeM3TKGZY3B5Ygx/UEnJ32f6YIL8aAKInvipEytH6mt5B8Sr5ZltQH46bZxRRYmbbxXQWjBDKOC6OeM/Dqz0PKzWNemkFZhmYmNhJUUbBCxcJCkg7RiDfYk3TnV34f6+hI6Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737691; c=relaxed/simple;
	bh=Eaa55yDXYFoWYz+1rNnd/PDQyHXIOYuxXTsqcegs6Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/eHGnSV/hoY1Ogz5VnVuHqtca+4fqc+L38QBTZ8jg1E8eTZngOQl7W+N9n5JYCJ17heg75w+W6pEXaaVFzlwngAKC/CNX+5Ibb0in9S35qngNdSBVWyWtxOIiUEf6WS69axFTU3gJldrKg78G03o2L8EhasbDOLBYfAQCX4boI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsFRTQzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C807FC433C7;
	Wed,  6 Mar 2024 15:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709737691;
	bh=Eaa55yDXYFoWYz+1rNnd/PDQyHXIOYuxXTsqcegs6Xs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FsFRTQzvVXaavYNt61l5ipwROnYjPwyOkMJxEtOf0KbEN82/t7n/04RHKZDK0/sH6
	 YKNBiq+YDDKJJuWqmdxCDe0xNzKEdk3+xThK61YkUTIKTW0NVHN7ejLp9VAo8/VLe9
	 /0nRchOpOoGiTVTuQpJgwkphwuJUndKxUVg0V7AhdUqb4bIQQ3zAQNBw5GwHlkAPbE
	 B5uE4AHvXR3DgrlK/D41lW2X2lN+dAnskcuac3SRujXPSU5iESHWPbqGWm87tVzlUO
	 EpiVm0g6ugKWcynJWUgpBks68W+jSw9yaH0ffkfVm+GY504SYqPQdLT+cEsZ4Whp09
	 G7RH7L2N6+Z0w==
Date: Wed, 6 Mar 2024 07:08:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Lena Wang (=?UTF-8?B?546L5aic?=)" <Lena.Wang@mediatek.com>
Cc: "horms@kernel.org" <horms@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>,
 "jiri@resnulli.us" <jiri@resnulli.us>, "Shiming Cheng (=?UTF-8?B?5oiQ6K+X?=
 =?UTF-8?B?5piO?=)" <Shiming.Cheng@mediatek.com>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
 <davem@davemloft.net>
Subject: Re: [PATCH net v4] ipv6: fib6_rules: flush route cache when rule is
 changed
Message-ID: <20240306070809.05211f10@kernel.org>
In-Reply-To: <b642c63273f0dd25dbde3a48aa61903f74ac6b92.camel@mediatek.com>
References: <09f2ab1b7946339da5092e10aa216e07c579c60b.camel@mediatek.com>
	<20240304204511.2026a56b@kernel.org>
	<d0621b969918ef41412b26d7e9a4918aaf4023d4.camel@mediatek.com>
	<20240305152301.GN2357@kernel.org>
	<b642c63273f0dd25dbde3a48aa61903f74ac6b92.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Mar 2024 07:28:39 +0000 Lena Wang (=E7=8E=8B=E5=A8=9C) wrote:
> > The primary branch is main these days.
> > If you are using master than it may well be stale.
> >=20
> > For reference, the current HEAD commit is.
> >=20
> > 4daa873133d3 ("Merge tag 'mlx5-fixes-2024-03-01' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux") =20
>=20
> Hi Simon,
> I clone a latest netdev main branch (on the 4daa873133d3) and make a
> new patch diff. However it is totally same with PATCH v4.
>=20
> Could you please help to check where the stale code is?=20

It's not the diff, your email setup corrupted the patch.
Please try resending with git send-email ?

