Return-Path: <linux-kernel+bounces-71499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B60685A63E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E28D1C21B53
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474FB1E89E;
	Mon, 19 Feb 2024 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Kjis16DY"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF701E539;
	Mon, 19 Feb 2024 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353757; cv=none; b=tdEN6WNBl3TYjz7G+8RpADsUlyht4wuUVKDiMM/DV2fo0rJ3dANnAHX0djsF8SCRWpEFvWtGeXvdpdQ9PQiMQddYNxbGczHw1vWat4ToD8zVnEiL76Qb28HniFMYVw1cccm2RaKvlxmqTfEq2ynXiB4Kxfa+//0LzrR+K83CRFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353757; c=relaxed/simple;
	bh=cip1i8B8DD/QCl1/kX5cfjQXuF4t6MqqTcxz1cJ2xxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqmbkJ2e2dBnJ2YhqtUEJ7aj2n8lnOj518ZHuRH98gNrmlbuVImeDsJRoQr9O136rtuJ9LW8/K2K8/FpxgqFQecjWgbu8TDNGveBoTjn30JxAI6tz3sQQCDF6emTpViwTPy+HRrAohDz8sEp6OrJOXR+UmqtcR3h+DQ2jWZNjwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Kjis16DY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 71A8B40E01BB;
	Mon, 19 Feb 2024 14:42:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cdxkXbQoPgnP; Mon, 19 Feb 2024 14:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708353744; bh=wruQZ2Y3NvX4XlylYHQfJUkxVCtOk9vrXRhRqlWChRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kjis16DYQ0GRshMDdxyqTHD9DgkaWwsjHND2me2yOdvnnMPRR2/e982pSTYP1Eyek
	 PgMNc2GfUl9MEhwEfZVYV08K+MiYYlCdxsKtqv+TRoc6rr3+74P0bT1y2EXCLfRQQ2
	 WSH7U7znko67VTvHhGEBTboIO0ChOnO7F7k87axPgJ/9Blrh9hWHpgF970csuNtRHw
	 SatLMWWtWhaOy+lBH5f9EZiCIVchvkSJ4cBlzcRUv4phzFBfBN9bpv2VzA7o21hMON
	 KnSo3E9stWVpTQ8eayHYKA1Yo57c6uY8m3eoqHl1TnKUoRPccr/RCfbWr3Ktz7W1Y0
	 ttacL2eiRKkVJPSq5eYRLGp3B+fXhbpYi2Ainn3JQiP4eIpgbqnmvjgYrByg9CSdbQ
	 kvbxlghor+gde7jf6MGW9dF6au7pkkQvLAwRmNhkDieQnTO2hmF7QN9tlgZv0e9pQS
	 eqdUymv9pyuDOgZB/DS2riUc2I+nYcHZv4ew27Pskx2MSMi45tcxZqh2l131IAOsN0
	 cDLb8mas7esDKxuHH6PjwqNXXGaybTPD/Isneo3IYY+FhA7G50qyd9jZaYEx3CUs5B
	 cU6erxJrb986YJAQipwSZcRHBrL/8AK7auHUDkAOS17Ttky048RCMx4Q3UqMGJ+GW7
	 6gvsLewOguEotjgi19mGVS1k=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC80540E01A9;
	Mon, 19 Feb 2024 14:42:15 +0000 (UTC)
Date: Mon, 19 Feb 2024 15:42:10 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brendan Jackman <jackmanb@google.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Lai Jiangshan <laijs@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	Kevin Cheng <chengkev@google.com>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [tip: x86/entry] x86/entry: Avoid redundant CR3 write on
 paranoid returns
Message-ID: <20240219144210.GDZdNowiz8Tr9j8acY@fat_crate.local>
References: <20240108113950.360438-1-jackmanb@google.com>
 <170612139384.398.13715690088153668463.tip-bot2@tip-bot2>
 <CA+i-1C1OpZQTS3EQa8fEc5BTzcLNMcgrwt0b9mR_jqiY0-zV3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+i-1C1OpZQTS3EQa8fEc5BTzcLNMcgrwt0b9mR_jqiY0-zV3A@mail.gmail.com>

On Mon, Feb 19, 2024 at 11:49:46AM +0100, Brendan Jackman wrote:
> [Apologies if you see this as a duplicate, accidentally sent the
> original in HTML, please disregard the other one]
> 
> Hi Thomas,
> 
> I have just noticed that the commit has disappeared from
> tip/x86/entry. Is that deliberate?

$ git fetch tip
$ git log -1 --oneline tip/x86/entry
bb998361999e (refs/remotes/tip/x86/entry) x86/entry: Avoid redundant CR3 write on paranoid returns

Looks there to me. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

