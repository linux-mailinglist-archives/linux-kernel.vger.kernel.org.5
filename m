Return-Path: <linux-kernel+bounces-69363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD578587F0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7AAC1F2244B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6DD145345;
	Fri, 16 Feb 2024 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fr+cdO3g"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0FD145B18
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118512; cv=none; b=CvNVw9pnt+hCaHKXgaD3jvg9ojDTT2zVbrKxxZI1BkCd/kQIRRy/dF3+rqCVCm/v6fmohDp9vvZpk3XhjTmytMMpmcoqn1oA2Hz5lBlnmUWoEhk8J+Js/vntKKtc3tPsS/z+rO7qB5oTgBhkduaGf+nQXrFYQYbadxDWM9k8NjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118512; c=relaxed/simple;
	bh=8RkIdklDyDDa8h8JrnVfHzosWxPgtS0o2uyCwRZpqro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHSuCPGNfnrJw2M0odQuLdDgYpdHwngoqcESMPPEnNsIS0zpyBp4tsA2buafkqXuXLilaTOBnSy0srGLw127us5TbfqCjMW20A3M5AbjSrrCDSgsPJIUZprydl37oXT/5H/3XBYEG9GRZWL4AcSyOdspyZfoUcF3VC2nqT2r/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fr+cdO3g; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1db562438e0so22865825ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708118510; x=1708723310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rtsFfzG8a5Y4gKlVc4iSnotBnYQWJOU2Pi/S9waSvFY=;
        b=fr+cdO3gU2g2Jzz9eIVWQCdnY7kih0gn2m0N+DsRcYsxRG2umJf0xApOZ7Jo8QmZeU
         yUR3nlJ8Wc2erGfOAhoNPfE152p9DdMVPywICl2KAVuqUJIDNfUT+ymcvH2f4IWu2oey
         Ty7+54DGru9WZ9ap4H+jYpm3yS7LBSrlnwbMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708118510; x=1708723310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtsFfzG8a5Y4gKlVc4iSnotBnYQWJOU2Pi/S9waSvFY=;
        b=GQArT3I8oF6kCp34MaQEz4IkhVtAvINoNwUf++X+ae/fxLcQqsozrL2GOyUt2Xl+Nf
         Sn5+boM6f+EVme44KAvAJj4UGy9uUJxe5rUCnC1k93fVmu8BGpZ31rbZ2x6vWyQJKmUN
         LKA0BgFdY77kp0Bo1yyfhEj7/sbDyPaBAc+7lBC+K8hHAVNACZ2Lptw+g4A1PQDXjNa3
         DeZtgc4kVnZhpcBYG3IKFI9QqbGBan76mF1EasL1K37EfmoUOwZr2g7x+Fn1ISm4NnSU
         HsKDU37DOAdhoqXg72E/dPuJ1sWCgw92aBk2HlrGrcgzEyQpMQAKicGoT7X12fAnsbg2
         zJOg==
X-Forwarded-Encrypted: i=1; AJvYcCVZSvgQkIkdnN9iQjIUWQd2rfL6x7yG0M8rhv+HsSrON7pQ5uY8isXzI8+FYkA579+R7fsRdcdnuumYZ1BP5GQ7rhYFsXvW3sMaPEec
X-Gm-Message-State: AOJu0Yz/9uoSH8PDU2A7qaW6yY6F8vDVC+OX/F93rUhQim67u4N7+J6A
	XrP8T4ETGUFdelIghDErIrIpoU85Xw3IWamOINZCP+Yu7URu+gMmD18lLc6w0Q==
X-Google-Smtp-Source: AGHT+IHTg+sL3pxx87dFYUZnA4CdOFoi6N++WUXNc0EriN4rhXpqlCmCapRn7SKh0gVSuZ2EqKK3rw==
X-Received: by 2002:a17:902:784e:b0:1d9:ba26:effc with SMTP id e14-20020a170902784e00b001d9ba26effcmr5713961pln.51.1708118510303;
        Fri, 16 Feb 2024 13:21:50 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y12-20020a170903010c00b001d974ffa1fcsm292574plc.173.2024.02.16.13.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 13:21:49 -0800 (PST)
Date: Fri, 16 Feb 2024 13:21:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andi Kleen <ak@linux.intel.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] fs/select: rework stack allocation hack for clang
Message-ID: <202402161321.B0B1D6F@keescook>
References: <20240216202352.2492798-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216202352.2492798-1-arnd@kernel.org>

On Fri, Feb 16, 2024 at 09:23:34PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A while ago, we changed the way that select() and poll() preallocate
> a temporary buffer just under the size of the static warning limit of
> 1024 bytes, as clang was frequently going slightly above that limit.
> 
> The warnings have recently returned and I took another look. As it turns
> out, clang is not actually inherently worse at reserving stack space,
> it just happens to inline do_select() into core_sys_select(), while gcc
> never inlines it.
> 
> Annotate do_select() to never be inlined and in turn remove the special
> case for the allocation size. This should give the same behavior for
> both clang and gcc all the time and once more avoids those warnings.
> 
> Fixes: ad312f95d41c ("fs/select: avoid clang stack usage warning")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

