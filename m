Return-Path: <linux-kernel+bounces-131222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC6A8984C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109E51F22B89
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3064276033;
	Thu,  4 Apr 2024 10:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/8I5Ko0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE1E8F7D;
	Thu,  4 Apr 2024 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225403; cv=none; b=jBrfotwFT9G895WVGYAp9Ck/TYPMqBLz5sB6wU9wRI3as52D58a3Ea394aM4UDTqm33rH49BUP+byUCr+A2tWY6NR/eLCZ03bKK5f9EbyRaz7pukhj1+6tEleLjIugUpTNjsg8xUNTpvAcmRDkjhjabdM6LcBOIgEW2e95IhwBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225403; c=relaxed/simple;
	bh=7ku57jYBMU3f3GFHQDbWobp23rUfjoEc/FmJNJWQa0Y=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=bxb3wKRIifDHxGPVBNQfAP1IRnjJLcVt0JH6THGnV4EB1dw8JiXlCUDqJPuRfy7B0ZZLcQI3COQroo4SGKgJxPvXSeifSjTs+HO1z95rkpE2NsiK956eBQCDegofHw/oYdAEgk3D3L8ebEB6crBrG/MRHkz8bbknxujMiqkKY3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/8I5Ko0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DE7C433C7;
	Thu,  4 Apr 2024 10:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712225402;
	bh=7ku57jYBMU3f3GFHQDbWobp23rUfjoEc/FmJNJWQa0Y=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=j/8I5Ko0CkW1KY/op4sNJeVizsbfMrmE09fQnLFh0GU+rosQR68skwVr0SeLQgA3o
	 o9dKeJ9ld5JF9vzVxiHpWOCm8f+KRvJvDSqu6w+WybTWRRAU26hDBX/HjrSLJovncg
	 73704cHi/arCBR/pdtHFPkLLaFwsiRDCtSV03kFJn8AKF3oqv8rxKrFqH0276r2jp4
	 HbUVPJJiofZ7opnPSvlrPKqx/t3FO0PUvEeF2zl7Y/ZbFLyrqDVGMMZX29cnGKTNHz
	 iHobXrZVwcvp2uLEYVRjlUfK3OQnaPKVwISj2fX2AfRanKXM6bUOYGJAt/jLuVweu1
	 MC4lpat7jeoSw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] [RESEND] wifi: carl9170: re-fix fortified-memset
 warning
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240328135509.3755090-2-arnd@kernel.org>
References: <20240328135509.3755090-2-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Johannes Berg <johannes.berg@intel.com>, linux-hardening@vger.kernel.org,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgen?=
	=?utf-8?q?sen?= <toke@toke.dk>, linux-wireless@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Colin Ian King <colin.i.king@gmail.com>,
 linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171222539868.1806092.7724292391480667322.kvalo@kernel.org>
Date: Thu,  4 Apr 2024 10:10:00 +0000 (UTC)

Arnd Bergmann <arnd@kernel.org> wrote:

> The carl9170_tx_release() function sometimes triggers a fortified-memset
> warning in my randconfig builds:
> 
> In file included from include/linux/string.h:254,
>                  from drivers/net/wireless/ath/carl9170/tx.c:40:
> In function 'fortify_memset_chk',
>     inlined from 'carl9170_tx_release' at drivers/net/wireless/ath/carl9170/tx.c:283:2,
>     inlined from 'kref_put' at include/linux/kref.h:65:3,
>     inlined from 'carl9170_tx_put_skb' at drivers/net/wireless/ath/carl9170/tx.c:342:9:
> include/linux/fortify-string.h:493:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   493 |                         __write_overflow_field(p_size_field, size);
> 
> Kees previously tried to avoid this by using memset_after(), but it seems
> this does not fully address the problem. I noticed that the memset_after()
> here is done on a different part of the union (status) than the original
> cast was from (rate_driver_data), which may confuse the compiler.
> 
> Unfortunately, the memset_after() trick does not work on driver_rates[]
> because that is part of an anonymous struct, and I could not get
> struct_group() to do this either. Using two separate memset() calls
> on the two members does address the warning though.
> 
> Fixes: fb5f6a0e8063b ("mac80211: Use memset_after() to clear tx status")
> Link: https://lore.kernel.org/lkml/20230623152443.2296825-1-arnd@kernel.org/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

066afafc10c9 wifi: carl9170: re-fix fortified-memset warning
61752ac69b69 wifi: ath9k: work around memset overflow warning

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240328135509.3755090-2-arnd@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


