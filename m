Return-Path: <linux-kernel+bounces-108100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E9F8805F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1882E1F235E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3855F860;
	Tue, 19 Mar 2024 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/9TEUv5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663CB59B76;
	Tue, 19 Mar 2024 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710879266; cv=none; b=V0n1qSW33E7Ay6L+H6XTsRh1rtCt3Yfs+j8PMcxb+lEnGFdwlU1IHkV6ksGlZrzFD/xxqjJaqVy4n3GLJzLPqxn9MV0q2upF59C31ZqUiuvEGi+zwr8YUPhY0HdPfUDvSd1j7dRwd5G84ctw4hLoNZolK6NbYGan0QZpTe6zhlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710879266; c=relaxed/simple;
	bh=ebwK4AewbvdYrlguygz1sCJD50ZNfG7LlT4UwBmSljg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WIgQ7+0oi9TWbrShXSmnuC0tdhNmKo3kWPuWEfse7WgJ7wnC0bBPEzC0M0PyQ5AxbkvmmH5VXmOpou1PTGFJVm8arys5LzbEpsoM8G+aTcpKIISJepMCueVYJZB+9l6ZtXCat5SdY5jRSFhAt6BVxJQ2Df6ieEkZyNty72H2WO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/9TEUv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9564C433F1;
	Tue, 19 Mar 2024 20:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710879265;
	bh=ebwK4AewbvdYrlguygz1sCJD50ZNfG7LlT4UwBmSljg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=W/9TEUv5ynQeNhTOcfb5QoEObpcmBWvia6XYBn0FLbNSN3hZv63Qpb76WuNoxliWu
	 APAX8cfWjuIvY/SXyvxtMV2Jabbfy6oxq7Kbv5Na95o4QEZYAANhu94OUfwsVRm33q
	 8Y+aMTZSYeRXnDPFMz0RXPxHQ8hWgALaTRknAIo32VfpVxdbGy9OIE6Tv+s9vPXBaN
	 TcusYv4E4tuHh7P6CM3EPeMN10G86kGWqSQ0eBtTzu1ztpqVbDoaBmQsrTlT3HNzcc
	 G82rAYsI8jkHMnOp1IZaQHEGMn5oIP79MibfDT7NlNg9jonJPf5QS8kTy3L5dzf8Lg
	 81PaAeOqG5ckQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Mar 2024 22:14:22 +0200
Message-Id: <CZY02YNBTGYQ.3KG8NLH8X3RQE@kernel.org>
Cc: "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, "Sergey
 Shtylyov" <s.shtylyov@omp.ru>
Subject: Re: [PATCH] KEYS: prevent NULL pointer dereference in
 find_asymmetric_key()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roman Smirnov" <r.smirnov@omp.ru>, "David Howells"
 <dhowells@redhat.com>, "Herbert Xu" <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, "Andrew Zaborowski"
 <andrew.zaborowski@intel.com>
X-Mailer: aerc 0.15.2
References: <20240315103320.18754-1-r.smirnov@omp.ru>
 <CZX9T3TU6YU0.3JE9M7M3ENUE0@kernel.org>
 <b5f21d1175c142efb52e68a24bc4165a@omp.ru>
In-Reply-To: <b5f21d1175c142efb52e68a24bc4165a@omp.ru>

On Tue Mar 19, 2024 at 4:44 PM EET, Roman Smirnov wrote:
> On Tue, 19 Mar 2024 01:39:00 +0200 Jarkko Sakkinen wrote:
> > On Fri Mar 15, 2024 at 12:33 PM EET, Roman Smirnov wrote:
> > > With the current code, in case all NULLs are passed in id_{0,1,2},
> >=20
> > "current code" is not unambigious reference of any part of the kernel
> > tree. Please just write down the function name instead.
> >=20
> > > the kernel will first print out a WARNING and then have an oops
> > > because id_2 gets dereferenced anyway.
> >=20
> > Would be more exact":
> >=20
> > s/print out a WARNING/emit WARN/
>
> Okay, I'll prepare a second version of the patch.
>
> > > Note that WARN_ON() is also considered harmful by Greg Kroah-
> > > Hartman since it causes the Android kernels to panic as they
> > > get booted with the panic_on_warn option.
> >=20
> > Despite full respect to Greg, and agreeing what he had said about
> > the topic (which you are lacking lore link meaning that in all
> > cases the current description is incomplete), the only thing that
> > should be documented should be that since WARN_ON() can emit
> > panic when panic_on_warn is set in the *kernel command-line*
> > (not "option") this condition should be relaxed.
>
> Here's a link to the discussion:
> https://lore.kernel.org/all/2024011213-situated-augmented-64a4@gregkh/
> From the context, I thought WARN_ON() would be better removed.

Not sure what you are trying to claim here that goes against what I
just said.

>
> > >
> > > Found by Linux Verification Center (linuxtesting.org) with Svace.
> >=20
> > I'm not sure if this should be part of the commit message.
>
> I have already submitted patches with this line, some have been
> accepted. It is important for the Linux Verification Center to mark
> patches as closing issues found with Svace.
>
> > >
> > > Fixes: 7d30198ee24f ("keys: X.509 public key issuer lookup without AK=
ID")
> > > Suggested-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> >=20
> > Should be reported-by.
>
> The suggested-by tag belongs to Sergey because he suggested the fix,
> subject/description of the patch. The tag reported-by belongs to
> Svace tool.

1. I did not see any reported-by tags in this which is requirement.
2. Who did find the issue using that tool? I don't put reported-by to
   GDB even if I use that find the bug.
>
> Thank you for the reply.


BR, Jarkko

