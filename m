Return-Path: <linux-kernel+bounces-70816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3053C859CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575E01C20E86
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DD0208DE;
	Mon, 19 Feb 2024 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aWwgAIiB"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D06B208C0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708327277; cv=none; b=pTZg/fX2tdTd+6EDOiUlAxe+xsa6Rf7jV1HWNZ6fTo29ZyuzzqCpaSt90b/e1fHFcrZ6i9BvT5yBgQ+04nB22QVJoM5b9VqzQwIJQx6yHlj6w6znLqFPNP1adV9EuwcITEQPKQAf/tUriHUQWORKfIzICYLx7UlaPrQ9ACaueDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708327277; c=relaxed/simple;
	bh=QN0mnIvLWaqPN7bppER4z5cXJNGlnW4ZBUQce0v0esE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWW1WLqzwQXE8oCOA+AWve2BXkV4JVoWI7JV/RzSSiq1MUYdlPRIvhfipS+zceNK2B/W9F46kOf7yqi/tKxRSwvYKatq29hxodd5v+2k+P41uZXn82pk+EvV1woRUqasSyZs9m53V7HUEvPChhyWc6HqdlRbLgfZqthkCwMlcp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=aWwgAIiB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4125df3c40aso13601475e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 23:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708327274; x=1708932074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PVqM0b0itzTgllW893u9sbLtVTXtg0oDYKDS5Qi+rsQ=;
        b=aWwgAIiBkKJcNNRvtZvPkgZaOkTx985uMBvssGNY/rsIMO33XFFNmESRpjFvUGVqME
         g8HqKinnK4V344I2D4E91zpJRbgLKtbqNpbvuMK0BlmrLVRRH5ALDD79PLQviQw19vGt
         i7vRXOpeFgTSSKhDV71KEVuEKbZO+vhSaJqjr+oeryEYALLaDc/OrFg/ycOcghx9MkSx
         YsEgTiW+eDbNn1JWvx4fCg0Hb3Mp6NQK9kvAN93nCUxMyQYDmtDt+lpeZt6tEuqcsMf/
         WpyeQ2STKU2tau1ubq7vMjh/WsPZYNCRA/3aI1sYrbPUNWxVp+k9FjWJeR6fZo12NaBQ
         czGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708327274; x=1708932074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PVqM0b0itzTgllW893u9sbLtVTXtg0oDYKDS5Qi+rsQ=;
        b=suvnyH1acVo87GJ289wyAuIbkycQG1uOU6QUVod440uSXw3Fj97dpvy2Rkmm2PxUUv
         bRhQmIcL8sWikpZRWtzTQzg993TLd704kH2vtEWGBqIB7cIDz5uHhCVqy+Wx+OQM1/F1
         rXA9R9dwnyZ2qLUtpq/vQbg0Nn7xDN4ePXCM61PCdz3oTZRjcYR1xjH5QraDaGiRwRsD
         N4obSeSxsPX7HdIho2v25JUO+xcdzgnoLDkXtVIzwKOzvpreo1gicgQYQkte/9gzDjn+
         o/LUwVrxsZXN3EeqcQB0CUPWYKJnkspalWETkekZtULF+WBEhcZCvak+TXEQhVRMP6j0
         3urA==
X-Forwarded-Encrypted: i=1; AJvYcCUOwFG3RvzWk9yG6iWVvKtXnW2e+wJFEm32C8zFtlzd05kmlTl/RA1e5Nk5MkxicC/72pMSQKsHj86fQPmD3QJv3+PoY79BA+3Cc4gx
X-Gm-Message-State: AOJu0YxIfNoJB/K1BVhj1Xt5TVv4z3U6QbDWA5Z00n9bIa2gA3XfaAsu
	YOmOjLaFtgr0jicFwyP18C+vr2rDFQo8NuikOIMMlu3vEC8DGDg4gQzJ6out
X-Google-Smtp-Source: AGHT+IETLfPHLLopGCD+sezW13FOiuvcS70DNbH9oqN5ZMR+lJmw7TXZAdysc+hTTzbuAYHtPBcg/Q==
X-Received: by 2002:a05:600c:1c0e:b0:412:698b:d7bd with SMTP id j14-20020a05600c1c0e00b00412698bd7bdmr222859wms.31.1708327273709;
        Sun, 18 Feb 2024 23:21:13 -0800 (PST)
Received: from [192.168.1.10] ([94.9.209.181])
        by smtp.googlemail.com with ESMTPSA id z19-20020a7bc7d3000000b00411e1574f7fsm10327647wmk.44.2024.02.18.23.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 23:21:13 -0800 (PST)
Message-ID: <89630027-f93c-4e1d-a9c0-a120b8f0bc9e@googlemail.com>
Date: Mon, 19 Feb 2024 07:21:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] fs/ntfs3: fix build without CONFIG_NTFS3_LZX_XPRESS
To: Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc: ntfs3@lists.linux.dev, almaz.alexandrovich@paragon-software.com
References: <20240214224500.811609-1-shiftee@posteo.net>
Content-Language: en-GB
From: Chris Clayton <chris2553@googlemail.com>
In-Reply-To: <20240214224500.811609-1-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi.

On 14/02/2024 22:45, Mark O'Donovan wrote:
> When CONFIG_NTFS3_LZX_XPRESS is not set then we get the following:
> fs/ntfs3/frecord.c:2460:16: error: unused variable ‘i_size’
> 
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> ---
>  fs/ntfs3/frecord.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index 3b42938a9d3b..7f27382e0ce2 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -2457,7 +2457,6 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
>  	struct ATTR_LIST_ENTRY *le = NULL;
>  	struct runs_tree *run = &ni->file.run;
>  	u64 valid_size = ni->i_valid;
> -	loff_t i_size = i_size_read(&ni->vfs_inode);
>  	u64 vbo_disk;
>  	size_t unc_size;
>  	u32 frame_size, i, npages_disk, ondisk_size;
> @@ -2509,6 +2508,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
>  		err = -EOPNOTSUPP;
>  		goto out1;
>  #else
> +		loff_t i_size = i_size_read(&ni->vfs_inode);
>  		u32 frame_bits = ni_ext_compress_bits(ni);
>  		u64 frame64 = frame_vbo >> frame_bits;
>  		u64 frames, vbo_data;
> 
> base-commit: 7e90b5c295ec1e47c8ad865429f046970c549a66

Mark - Thanks for the patch.
Alex - Fixes a build bug introduced by 4fd6c08a16d7f1ba10212c9ef7bc73218144b463.

Tested-by: Chris Clayton <chris2553@googlemail.com>

