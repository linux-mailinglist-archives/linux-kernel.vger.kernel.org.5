Return-Path: <linux-kernel+bounces-117079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ED988A6C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DDE322286
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AD012C54A;
	Mon, 25 Mar 2024 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Oiw+hr5r"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BDC5491F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371681; cv=none; b=dUTHxMDnjRiaewwQ3XadfvszlxPS1nVfO4s+ZGE6H5yOzgkuoJCF45gw5UzT/QjCOqUehvpoOMmMTAyRp00niahu8FUfzzgBhcPBBTFJ5Gc75/SqSYi9awqb3aOIr9En+DwdMsw8VX2i3/1w7yh7rIxJwYipHmrpP9A0LyqKzQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371681; c=relaxed/simple;
	bh=Jl8zeqekL23lRQDKdX9WM1om9PFZa5CLgdi+FLFFkuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEbT4DGwxbcQNj+enZc6ak9aWcmHWmbRVY6ZseRTdv/KdFH2dtUaApbK9WQ/gT70FqxNCY6jc/C0dcyDwe/FXaCWrU6kUNkJl1VRmhGQpkvfc08bHIMw0XQTc+7cEO6rYKi1ReGUbl+oD2BgQOqWtmXjhh5qZ9KO7aOvwzSN0D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Oiw+hr5r; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ED5CF40E016C;
	Mon, 25 Mar 2024 13:01:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ksQ5kpI5SPSF; Mon, 25 Mar 2024 13:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711371672; bh=GCEB1dQnF5fIbuI6zSj2Yk/4XupLJNkzhxrMVpb3WdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oiw+hr5rTkDM1tWJFX+upW8bWM4Nv/0iZ5EzxZgCNSDfSn0i/tVXZYFqICQsDZQR1
	 YtUe8vdhkw6OLfIZyDcBaYqE6R/iu/S6QYxFkClsyjKygEoH3MEoX8Iy3hK/MsN2Tv
	 ynR4AbCw/KWCW9bWN3mafMML292zyt9XZCNsblXODc2fkq882rUEn1YbLxj3wzZ8hw
	 q3nZ3o2f+L7jwBMoydRqqLAkbsI6buKPcze4qCJLJ7NhWk9i0HIBfifHVCAvvdwM9z
	 vRhF3JoUP2fzTW7m9eSdoHFLGhPCkco2nQozIb6yS4nlOLHzWRVnRPed94R8g9qmlY
	 0vxWvCzvRZi1P6khnBZdN6xzoQ3sIv6ETR1TTqNWfpwmzIehIkVEC1XBiLnbFp6pSf
	 nmhE7Jz48To3GWxgB5C4ivzLAols6YLpHT+jZ906htFAcsu/AcgogW3YaFCmH/kGDL
	 iwuqF6ZfFwXidZhZ/Cs0U4xyyaHsIgmdLuVYKerUZ6P4XEl1UPJUMdcXybf7VtPlXa
	 UogA27vkUNOTINTcszWPg+RCki0LDb6HhheYORKvA9T4/wlZMhjd4jMnqKGkl7cgkh
	 kKSVRGYnOoUYcrRuiaWnyIRQ5xduersiZ9H9cec0gY4jur3fuVzoz1zHbQLgPUWQzZ
	 SBK97JCu7Lb69SdyNHfg59v8=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B3BE640E0174;
	Mon, 25 Mar 2024 13:01:08 +0000 (UTC)
Date: Mon, 25 Mar 2024 14:01:07 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	X86 ML <x86@kernel.org>
Subject: Re: [PATCH -v2] x86/CPU/AMD: Improve the erratum 1386 workaround
Message-ID: <20240325130107.GCZgF1k8FFzNKqyvkK@fat_crate.local>
References: <20240321120548.22687-1-bp@alien8.de>
 <20240321120548.22687-2-bp@alien8.de>
 <79125c93-285c-43f8-ac05-87c34c99e6bb@maciej.szmigiero.name>
 <20240324200525.GBZgCHhYFsBj12PrKv@fat_crate.local>
 <cfcdae85-8ebd-4723-a15c-8010e6d20d0f@maciej.szmigiero.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cfcdae85-8ebd-4723-a15c-8010e6d20d0f@maciej.szmigiero.name>

On Mon, Mar 25, 2024 at 01:45:58PM +0100, Maciej S. Szmigiero wrote:
> I have tested the updated patch now, including negative test by
> increasing the required microcode version by 10, and can confirm that
> this version works properly too.

Thanks, lemme queue it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

