Return-Path: <linux-kernel+bounces-95911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777EF8754DD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32331284C7F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62184130AC4;
	Thu,  7 Mar 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WMld6wYv"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD0612FF7C;
	Thu,  7 Mar 2024 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831356; cv=none; b=f4Fc/EuWAc8OoCJsuwRpz1+QYlFYYN9wulZJIKz8EG6pkjgMtENcxC/kCvnYjM9jxpBp6b3B6FB7ChZgxvNHNbM1rV+Aim2HFKmf7xXniWFYKvAvMaFolYHkuZiW9xEGzhGg/uhW7RCt4l9QC+wkDeNcb1w5DUJFdfBHNQMC/TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831356; c=relaxed/simple;
	bh=32IuzPCj0UkQGwwVnuiUmbWNQ5uEirPqYiBDMvrYo18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUz6S46ZZYmlLT+SKGUx5K0IsEkcRGe3/+SdJKyjdWd+dLGLo6nt2KmnQ38+KhkBWsdjgyCbortk6doVzYzvVis4rCTYK1tZVCZkBmBmaNBDAIDHlFzgrVqA+kZ/58Pmwm0P1Byhj66RGomq23fegOaWGAdjZQEIvmitiRx2OiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WMld6wYv; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CF38040E01B5;
	Thu,  7 Mar 2024 17:09:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IpIiJIZkOhQv; Thu,  7 Mar 2024 17:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709831349; bh=VocYFkSZYiIlvx5UjmxfB2VV9eY/7DqMl+HAFYEOhQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMld6wYvbF4f183CbcrLcUYI6Yj9Xbn6NtQB3pmIBaP+mmYZrFiTOW+OeH6Du10dh
	 iScv07jqwR+yfUisYkNGlm/MRQJfXPcj/IO4G8oQ2R3HlzxXvq8uaT8YoBfs+VjOiz
	 xij8WSJ1Vo0W3Q7wR7dsHJRtcMwm3N6i6NGCjN5satDk41vCigbk1WXNCTyTJ40MW/
	 UgWhDfiHehUPnuZHgEtLiRl06KYkFCqJ/cCbioAF2noiIgLhBPq00VODxg9jELkUti
	 9+I4ELXu3i8jCXLpAXiE3nkqEwYRP9AFdzW/8HhywuCLDHzrm0Lk+TyKlmXUbMGULj
	 Td2BGNTms3cWuM7l3TXjIfKFSjIE73CCvrbEKD5JYf79XDsAMny4FMjIiWf/hkudP9
	 PFz0wCkljgTEfQjMbIt56F6js5QQ69rG/SEeoKCwe/76uLwiKf7QkCSgCjdoKls0p+
	 akk5TG3m5HwEpxo2qZ7I2Wf2wcev+fvkPwUSqSvESEJy5xqngydSb59AuqbH+iTiIS
	 MnQnZodUBYCcCg0IWGBGo1cXLbJbR3DO9uv9RVK7iX00jEHf0E5wjmK8+BvGarB5Q3
	 H7r7XkxfkdgorO9TKwdCXE3F5AwnN7pcHbh2B4boSOdae3wSil3J4rdp6iihUH7ygo
	 zv2GOSX8gzi6n55YnrXTi4VI=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8EB3B40E0174;
	Thu,  7 Mar 2024 17:09:02 +0000 (UTC)
Date: Thu, 7 Mar 2024 18:09:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Tony Luck <tony.luck@intel.com>, "Naik, Avadhut" <avadnaik@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/mce: Dynamically size space for machine check
 records
Message-ID: <20240307170901.GBZen0re6AvpscLaTM@fat_crate.local>
References: <20240307000256.34352-1-tony.luck@intel.com>
 <20240307121634.GAZemwIgbKKJGaUVFg@fat_crate.local>
 <3c2afc2b-85d7-4c2b-8a32-1a6b0f225328@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c2afc2b-85d7-4c2b-8a32-1a6b0f225328@intel.com>

On Thu, Mar 07, 2024 at 08:59:53AM -0800, Sohil Mehta wrote:
> I was about the suggest the same thing and maybe slightly more. By
> initializing ret when really needed, I find the code a bit easier to
> follow. No strong preference here.

Except that "really needed" is done this way:

> diff --git a/arch/x86/kernel/cpu/mce/genpool.c
> b/arch/x86/kernel/cpu/mce/genpool.c
> index cadf28662a70..83a01d20bbd9 100644
> --- a/arch/x86/kernel/cpu/mce/genpool.c
> +++ b/arch/x86/kernel/cpu/mce/genpool.c
> @@ -118,22 +118,21 @@ int mce_gen_pool_add(struct mce *mce)
> 
>  static int mce_gen_pool_create(void)
>  {
> -	int mce_numrecords, mce_poolsz, order;
> +	int mce_numrecords, mce_poolsz, order, ret;
>  	struct gen_pool *tmpp;
> -	int ret = -ENOMEM;
>  	void *mce_pool;
> 

	ret = -ENOMEM;
>  	order = order_base_2(sizeof(struct mce_evt_llist));
>  	tmpp = gen_pool_create(order, -1);
>  	if (!tmpp)
> -		return ret;
> +		return -ENOMEM;
> 

	ret = -ENOMEM;
>  	mce_numrecords = max(MCE_MIN_ENTRIES, num_possible_cpus() * MCE_PER_CPU);
>  	mce_poolsz = mce_numrecords * (1 << order);
>  	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
>  	if (!mce_pool) {
>  		gen_pool_destroy(tmpp);
> -		return ret;
> +		return -ENOMEM;

before each block, so that it is clear what this particular block is
going to return on error.

But those assignments get redundant so the current way is fine, I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

