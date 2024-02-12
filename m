Return-Path: <linux-kernel+bounces-62204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0ED851CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A96A1F23B79
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FE140C15;
	Mon, 12 Feb 2024 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JFDhUgd0"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D7341233
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763198; cv=none; b=slrTrGIpoyX6l3J/7xTD4+0R7In9DCOc/hZQKR7Dd+mzHv/Hz6h1+pMoePdbksaiH4LM8DZ4+OVVzLutI//hZWMzoxYHfZY5aE/o+8BQlZNciXv3EqmC65nhVOxPiuubNkC5E+Zoopbkog34qk26XPcVX7TydGxttvw+GD+FCfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763198; c=relaxed/simple;
	bh=7KtAdzkHlAnlWvBMfwT8WuB4d0+O69tA+YUmbppsXYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KF/JtiYsbbMtBcjw8OHFeNHRjW/GuarxNSUYtkNGGwdqx/WQ5OicI2DFMVZHmsB7QKDBwiyxFPGzAWJmdQdDZuUr8p8rKBCQv/eIJObhz39ZW8xJv3IVWyMBKksX91Pe0ocH6dAOehae1ivMsucQ3xxTauw/vTDvl60NkJlWLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JFDhUgd0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d7232dcb3eso25797475ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707763196; x=1708367996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YijPAo9UAwvKC5x3U10lyWMs/fUv03XEPORJYdFtyCY=;
        b=JFDhUgd0nlRV6kKZ2ZArI8mQDAHMqmA1jv5I5v7A9PDsiow3lsndcAw7Y4feSypY2f
         2PzwTAxVtQ255Qa1BuIQ0huvSTe0kwf1LQ1NT8WGwpT7Tq2vSWZCi24W2GOMHCe3t9cO
         poTjyzd8xXGu4WtfK3Kfu18NKr2vPV36eahYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707763196; x=1708367996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YijPAo9UAwvKC5x3U10lyWMs/fUv03XEPORJYdFtyCY=;
        b=cdcLEUPf5AtxNrZCHT070iPJIMnvXMyruZrLnDZoKzdR2Eu5h5fFhVgwG2P3gnOudC
         k7OaP/0GtBTuVFLyybgSQcqxVyoHBNJJyT5sq8XS0+JkvqOtB6frXV9AJP1Wl0t68VB0
         HWFUiaq0IvCVKPoq7MR2Ai4pZ5RHx1/rrPAprvWL4Cm9Z3HHhsAC7MgFMHGp90abmgJV
         HR2UZnNjUlyN89ATANXJPtJKE3T2vXowoiPcpOZXO5hYX7zqGSmjZPfU/OxRJBVp8DVg
         aYpE2S0i0W/H8jtZCFG6MMZtvK+SH5PVCjUjwsHaBYMChB46Fm5A2Tvldyb8MhhIidDz
         1cew==
X-Gm-Message-State: AOJu0YwiYREVy0lXzk/j8hbG7c4XpJnx0MD6iSUNnaT6BrhQN2mVAvgW
	B1iEIDaSfpn69z4JTos3DyZFMRqljJFtUgI0XAD66C06+BD923BtqkSycyKyoQ==
X-Google-Smtp-Source: AGHT+IFNcP+SAxS7irWemqCnEtzUPbDRNv7kDAYXRdvsinYmZVPoZxaqJoA4GLxcd3SxCHhrzLfHKA==
X-Received: by 2002:a17:903:643:b0:1d9:f5dd:2480 with SMTP id kh3-20020a170903064300b001d9f5dd2480mr6438396plb.54.1707763196526;
        Mon, 12 Feb 2024 10:39:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkSQrFxcWP1o0ZHsxTq6YWmTvkekg3UtzXbispm3ZC82vaz4gnDazH6bGYamsNT0Ix+wPRjHrJzl/hnlZnJTjvX2ya1cGzvLypKkd5rsfVF8Luo3EZGRKp3Sa1DRT66UK0NL7/w1w1ZkEFX06lirixckwb5i5dUm9xWEvGP3ukeMVkNNxLjpB7IYca0F/BJ6SgGeCABxuSjpSgPKeijZrq/CxNmOpX10wEqvU9WDEypPV5ePHIVPlm7DWOI3yCm90l4uWFb0L2gaLgrHbv59EnaeSyGULKK2SQRKTZ9idGsg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ky14-20020a170902f98e00b001d95eec000esm664121plb.27.2024.02.12.10.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 10:39:55 -0800 (PST)
Date: Mon, 12 Feb 2024 10:39:55 -0800
From: Kees Cook <keescook@chromium.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Qian Cai <quic_qiancai@quicinc.com>, mptcp@lists.linux.dev,
	netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] configs/debug: add NET debug config
Message-ID: <202402121039.E14DF37@keescook>
References: <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>

On Mon, Feb 12, 2024 at 11:47:14AM +0100, Matthieu Baerts (NGI0) wrote:
> The debug.config file is really great to easily enable a bunch of
> general debugging features on a CI-like setup. But it would be great to
> also include core networking debugging config.
> 
> A few CI's validating features from the Net tree also enable a few other
> debugging options on top of debug.config. A small selection is quite
> generic for the whole net tree. They validate some assumptions in
> different parts of the core net tree. As suggested by Jakub Kicinski in
> [1], having them added to this debug.config file would help other CIs
> using network features to find bugs in this area.
> 
> Note that the two REFCNT configs also select REF_TRACKER, which doesn't
> seem to be an issue.
> 
> Link: https://lore.kernel.org/netdev/20240202093148.33bd2b14@kernel.org/T/ [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>   - It looks like this debug.config doesn't have a specific maintainer.
>     If this patch is not rejected, I don't know if this modification can
>     go through the net tree, or if it should be handled by Andrew.
>     Probably the latter? I didn't add [net-next] in the subject for this
>     reason.

Adding these seem reasonable. I touched debug.config last, so I can take
it via the kernel hardening tree if netdev doesn't want to take it.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/configs/debug.config | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
> index 4722b998a324..509ee703de15 100644
> --- a/kernel/configs/debug.config
> +++ b/kernel/configs/debug.config
> @@ -40,6 +40,12 @@ CONFIG_UBSAN_ENUM=y
>  CONFIG_UBSAN_SHIFT=y
>  CONFIG_UBSAN_UNREACHABLE=y
>  #
> +# Networking Debugging
> +#
> +CONFIG_NET_DEV_REFCNT_TRACKER=y
> +CONFIG_NET_NS_REFCNT_TRACKER=y
> +CONFIG_DEBUG_NET=y
> +#
>  # Memory Debugging
>  #
>  # CONFIG_DEBUG_PAGEALLOC is not set
> 
> ---
> base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
> change-id: 20240212-kconfig-debug-enable-net-c2dc61002252
> 
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 

-- 
Kees Cook

