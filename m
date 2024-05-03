Return-Path: <linux-kernel+bounces-168431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356A88BB881
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6670B1C2336E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5E784FDA;
	Fri,  3 May 2024 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bytY8/uF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E54F58ACC;
	Fri,  3 May 2024 23:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714780202; cv=none; b=R3OBF8TA6RzOEbgM1EdhTSr4iPQYgEVseBkJzEKgIe4VOAAB4wvrTuHm9iYbdCemV34UfwmfvR6KvSIVUk5SOIKQuIur9Yl5BlCsPgrEsLtZ0f+H1IzgI1TPAg3uKvVeAghIegH4EfGlmi4kGU0T0M8dL5j0mN/m/ZdiqYPOfN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714780202; c=relaxed/simple;
	bh=2YpmUB6M3pSqN3NzsLH/1Ao0GXXtZMFte53gEx/HtJU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bG9P5qkFAhHLfXHipBaBIV61PUJ17QZQfMK+xPFc/ENom9H2LXydjyPRaB/IETUcx3aJBWV5ISu3CHt+AzG4OsZY3CqMC4T8LayW4CXZq+W4IQ5vfqYJ+hKIviSuB3nO9VBWDP0SIOUxtFmnxC3cIhWoFOLblBclsn5IWanNRgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bytY8/uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4487FC116B1;
	Fri,  3 May 2024 23:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714780201;
	bh=2YpmUB6M3pSqN3NzsLH/1Ao0GXXtZMFte53gEx/HtJU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=bytY8/uFZrCn37wOWEy3wId3z3QN5E14L9yhJt0D+EYhIdXPHW10GivvdAUibjWAA
	 77KVVH3Tr9z7QsqxN0i872jVu1dAILURmwjlJTWvaar2F8qu8RxIOl8G77Aqoaqa/0
	 aqyVah3WabniMmvfn87oH4SsqR89Jl3PoOTVaDzrRS5e9wj1Z3/XgEsgVdimvLPJnV
	 SuCq3OGEbTxS6eIfgRhzEM9EWoCrrb8enpHUWhY3BtcZ3z31i+NGloYB8XJBC8I67u
	 ASayxzLM3AoyBfXDr47x+3Y7ijNWI1FocxZmes/1RWmOfLQL90MMjOEADJmZ3PvaUf
	 ksE3KLiIxNtfQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 May 2024 02:49:58 +0300
Message-Id: <D10EUK2TUF57.1E87NSEA2ZYU@kernel.org>
Cc: "Lukas Wunner" <lukas@wunner.de>, "Stefan Berger"
 <stefanb@linux.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <davem@davemloft.net>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: ecc - Protect ecc_digits_from_bytes from
 reading too many bytes
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.17.0
References: <20240426225553.3038070-1-stefanb@linux.ibm.com>
 <D0W3MTR0CY08.Q2UIYE4N274L@kernel.org> <Zi8UXS1MD5V58dnN@wunner.de>
 <D0WIZTMRKHSJ.1Z4ZV54DLVWAB@kernel.org>
 <ZjS83WIPglXiUH3n@gondor.apana.org.au>
In-Reply-To: <ZjS83WIPglXiUH3n@gondor.apana.org.au>

On Fri May 3, 2024 at 1:30 PM EEST, Herbert Xu wrote:
> On Mon, Apr 29, 2024 at 01:14:15PM +0300, Jarkko Sakkinen wrote:
> >=20
> > Yeah, sure, that would be even better, or even memzero_explicit()?
>
> memzero_explicit should only be used for stack memory.

BTW, is this in kernel documentation? It's a guideline really
and would be nice to have reminder, that's all.

BR, Jarkko

