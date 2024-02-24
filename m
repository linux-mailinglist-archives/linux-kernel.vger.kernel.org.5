Return-Path: <linux-kernel+bounces-79470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E421D8622A9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 05:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50ECCB21793
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 04:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C6F14AA9;
	Sat, 24 Feb 2024 04:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="uvBEBBUW"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913894414
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 04:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708750746; cv=none; b=IpUThErlpT5ojmwon41S5vO6ykA/t4TblwS8tcC0UkguR9j2UWKrqVltIpYsy3ZzJdnXISAd9vaarJL2wKpIrBZdSyybf1FICs6W72vvrwqIO+tEgzURx37f3heJCSYg9BEq/9AAdayrGAihWtyUjQTuKNXPm8YtW21iL5BmqRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708750746; c=relaxed/simple;
	bh=UVnMe3riV2mEE9PMTOsDaFkqLCkxkOumV5ClPcR8WmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFfZf3CvQNxlYbP4K8fvXxuCFvcagp8V/9y32iyf4mWODudBx0OcUJTfI+ObeoeHQwg/RvMHnHXwIrSJlPe2c7Q85yAIHRGqWCeLrP2RMBhI3SAlsUQGQbqxnbkKFEoejd23tN+kYwxc+KK+GKx4+yhhmbEOMLk7BjsWQieBXuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=uvBEBBUW; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68facd7ea3dso5384686d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708750742; x=1709355542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0DR/r8YGEcoi+M428q3lMVHPYxJfzAFlwNC1nO7OJA=;
        b=uvBEBBUWCuMsLEwcgOxq5oDfofFs/y9yvwH4glSkTAiDpPbk16VkzDpjwdEU8HWCfd
         Uex3k1tIvnHvm5oAnQEIuYtO97+Zcugyy9jcOHYP09UxfjU6RymnCuHLh7goMP9w0oDF
         N9RLWABUtwrNfD8soOmmm2iwiCy3W9WYEZIds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708750742; x=1709355542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0DR/r8YGEcoi+M428q3lMVHPYxJfzAFlwNC1nO7OJA=;
        b=hSj9Tk86xmq6eaf+Fh8DiFm9EbaswhGHwB5OAH6e4EkOZte33eGEMwzYQuC6NJQ4MO
         VmmQOO+vakWrS8i7t9j2f/vWj1EM66Tr2pyctHuPGlDazvLhXlQBUbKz2AJ4zdwJepQM
         hZTwFrwmAz1432Cjcs+h7flMn4DjfHE3pBAvAFAZL8oZdlVgrfuFmUv5z75glLCAEeLp
         T85itTFQEpv6QsbUSgS6d94qpxoy27X/sQeXpfmSm1KqK2q61dWRpgHFuhfLbkNmhxNy
         Ke1v7+Us+1LJ/31rj5Ox5/MGTqIu1UNROfcpwjH/Gx/BxJsBmJe3RzZdo6Sv8OcIsw5P
         YNPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVLFiMxtP/gLWLSvDsJlOPImNN4ufrQBz8Ff5QRvsbJSsAOuIxRnF2BnhtuCa9Vadf4/U0lLBQu+/UPEcY5xTkstFC27yLFr+EpP1x
X-Gm-Message-State: AOJu0YwKxIvl1pDUidrRw9u74AfYNkuTctvzLlEpfBxVlorveKf2B0d8
	BqI0fuUYMU3jnEl+gR6JxnDhCdlhqFF5ONVb0lJE+FJnyHDLiuK7vgL4ZYjjnBE=
X-Google-Smtp-Source: AGHT+IFSX+n9PnM8+ZEtqzUGuqdnEg8aQSqj+a21ftSVDlhZaELMIT3DL+QZnBBMwUTpSh71NIqyIA==
X-Received: by 2002:a0c:de08:0:b0:68f:e855:5502 with SMTP id t8-20020a0cde08000000b0068fe8555502mr780228qvk.31.1708750742494;
        Fri, 23 Feb 2024 20:59:02 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.76])
        by smtp.gmail.com with ESMTPSA id qm16-20020a056214569000b0068fef023e6esm92590qvb.88.2024.02.23.20.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 20:59:01 -0800 (PST)
Message-ID: <cfe9394d-8144-48d0-a8f1-de9fb54eabc5@joelfernandes.org>
Date: Fri, 23 Feb 2024 23:58:58 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Neeraj's email address
Content-Language: en-US
To: neeraj.upadhyay@kernel.org, paulmck@kernel.org, frederic@kernel.org,
 boqun.feng@gmail.com, josh@joshtriplett.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240224045730.29812-1-neeraj.upadhyay@kernel.org>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20240224045730.29812-1-neeraj.upadhyay@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/23/2024 11:57 PM, neeraj.upadhyay@kernel.org wrote:
> From: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> 
> Update my email-address in MAINTAINERS and .mailmap entries to my
> kernel.org account.
> 
> Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> ---
>  .mailmap    | 3 ++-
>  MAINTAINERS | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 08f28f2999f0..dd6ea71c9271 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -441,7 +441,8 @@ Mythri P K <mythripk@ti.com>
>  Nadia Yvette Chambers <nyc@holomorphy.com> William Lee Irwin III <wli@holomorphy.com>
>  Naoya Horiguchi <naoya.horiguchi@nec.com> <n-horiguchi@ah.jp.nec.com>
>  Nathan Chancellor <nathan@kernel.org> <natechancellor@gmail.com>
> -Neeraj Upadhyay <quic_neeraju@quicinc.com> <neeraju@codeaurora.org>
> +Neeraj Upadhyay <neeraj.upadhyay@kernel.org> <quic_neeraju@quicinc.com>
> +Neeraj Upadhyay <neeraj.upadhyay@kernel.org> <neeraju@codeaurora.org>
>  Neil Armstrong <neil.armstrong@linaro.org> <narmstrong@baylibre.com>
>  Nguyen Anh Quynh <aquynh@gmail.com>
>  Nicholas Piggin <npiggin@gmail.com> <npiggen@suse.de>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 189184ecdb11..1006a6973320 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18461,7 +18461,7 @@ F:	tools/testing/selftests/resctrl/
>  READ-COPY UPDATE (RCU)
>  M:	"Paul E. McKenney" <paulmck@kernel.org>
>  M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
> -M:	Neeraj Upadhyay <quic_neeraju@quicinc.com> (kernel/rcu/tasks.h)
> +M:	Neeraj Upadhyay <neeraj.upadhyay@kernel.org> (kernel/rcu/tasks.h)

Reviewed-by: Joel Fernandes <joel@joelfernandes.org>

thanks,

 - Joel



