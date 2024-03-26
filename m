Return-Path: <linux-kernel+bounces-119174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292BC88C51C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17C8B24568
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E778174C17;
	Tue, 26 Mar 2024 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="biB0ADQN"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BD612E1C4;
	Tue, 26 Mar 2024 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463260; cv=none; b=o6OmPWRvUS8OThKu7FMIRRYJjaws7HMaoyY2mcxQP1tDZdoeMMF3QvtRqzHwHSCUBxq+j/ydWsQ3w/wHa95SqIFHrZCjmlGr/nlh915P6JgqzhvRuI93Bab0xWqAtYqzkQp/4kIzm5+jsnljb5lWlCsZNjPpSX8OpAwOjUg0Kzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463260; c=relaxed/simple;
	bh=12uk9JBPJkgP4oZUtaa23Orcrd3+FrjVkoU50EYP62c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpSEw2Dyi/KAzq+qq17e+9XnyW3BZedTxuG1jl7a1WkW58LzvfC/hQcxCCGdIFtrK6j6CNkhMx4Ajbn2WItYrqYpjjqKwz8/PWA5UMxhDeuqRjirFlQXzKpjgdT8sYriRu1O9ZpIc0fVdy/UlHTn2tzpEK0zM40vuTQZcNwkQMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=biB0ADQN; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3CC6240E02A6;
	Tue, 26 Mar 2024 14:27:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UoaUWSbagnmz; Tue, 26 Mar 2024 14:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711463253; bh=yqEXdRp/uICuZOB9rxpV+/FX3m8aNIeHX6lg94eGg2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=biB0ADQN4TtFmm7CvgoU7ct1BwCMkFKlAURDjjPUUs25Zc5GG7L1UlI52oT/iTaC3
	 A9N8pdOJPu+V7yP7Pe4f8/nTXbXoLbaNiRGBD+QefkDbXr5eLh9QZ9xsvlo3K0TKzd
	 snR4RTHOpB92PlYNoE8YUGY/KMEzIxJLcVD1z6K+Vb8NhJhidSU+CO0+6X1CXKcjC1
	 2Hn0cNj3rLQHDzsNK2lm0tUeqiL/JCnZBrYZOe0XXgllTaYD1kNwOM71/yu7wtFc7e
	 EdyIbd/To5HyRnkQzuMsQFtOsEIPRPHpcn1Gz055AiIOnKZzBGV8z2VW5TYK1JEHXZ
	 HpGVoLciUGEpbg5F0RWmKzGomUIR1fa2s1ucZRIOYKxgOP2WOgxKTHeOdYqLM+b3CB
	 wIAoTMe/gm39sZe8xB4jaIG3nrfoapwZOeSAhxM/9mfE3ejpVBkHPXC3Ue82YdgmzV
	 o8rEONxQOhOUqpV6rWahbfREvvAbSX8eEDSVsIBpKQmcAO7xSZu0hJyHvAzhvf8yzJ
	 UqPH7QEjSkkawjtGnlX91wczBxzQgJ+pc4Cuu+PSdxqsDj+VzgraG1Mub8c88nZCqZ
	 CO2ONTneuIk/OEQ3v2cnW62igN/UmhX4KF0LiaH9I5JQLgt0jpxqLoDmRRgpmk69DS
	 +64FbPK2CbXvR5+8pbH2hjyQ=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 066CF40E024C;
	Tue, 26 Mar 2024 14:27:28 +0000 (UTC)
Date: Tue, 26 Mar 2024 15:27:23 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"anthony s . k ." <akira.2020@protonmail.com>
Subject: Re: [PATCH] RAS/AMD/FMPM: Fix build when debugfs is not enabled
Message-ID: <20240326142723.GHZgLbS_Es_1kfqK5t@fat_crate.local>
References: <20240325183755.776-1-bp@alien8.de>
 <eede2586-f143-4107-a065-2860ed413d0a@amd.com>
 <20240326140759.GGZgLWv3UZVpHZ5c98@fat_crate.local>
 <adacb412-a043-4512-a8d3-1a0f6f40e9f4@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adacb412-a043-4512-a8d3-1a0f6f40e9f4@amd.com>

On Tue, Mar 26, 2024 at 10:22:05AM -0400, Yazen Ghannam wrote:
> The goal of the module is to save and restore records across reboots.

I guess... although when you think about it, you'd want to dump records
and see what got restored. But ok, strictly speaking, I guess debugfs is
optional...

> Sorry, I mean that if there's another user of ras_get_debugfs_root()
> that doesn't depend on CONFIG_DEBUG_FS.

That is true.

> Okay, will do.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

