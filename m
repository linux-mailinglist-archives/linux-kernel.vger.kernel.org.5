Return-Path: <linux-kernel+bounces-58031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A7E84E071
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325B31F26F6F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2F971B41;
	Thu,  8 Feb 2024 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uz3QtunK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81D36BFC2;
	Thu,  8 Feb 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394292; cv=none; b=bsFLrpSBr4vefHzr671qyQRGapRZ3m+80RpnnIjRQg/nAkLPN7eHHAbBIduhTNeGwnC5nMtSz45N6L7S8/gBqs0Om4IJgQtzgSHdrCVQL8FaRMboz2NhV/2evWnqwd1+LhzjIcxp7I1k0xdypAG4SGeYl8eAmCCvc+SysnxrExk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394292; c=relaxed/simple;
	bh=Y5mb87bfIecKDPigGFFDcBn7FIohiyxS2vG0T0P/zF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibGpJ7ruDywLsw8yBtJRP5ft6A3iT8WKGmbE4Ngue/2seQ0l+djIKUkA5f1CluTjPa2iXPoB03zEaa80fzd+SO1Y8dW6Us6q9s5u8PudUSqkdOe6+I4+FlZu3k4QW6sfUczWhEpeG5pGp1MXTSFrYwL51dNpnX+HtMT98JsZK/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uz3QtunK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAF6C433F1;
	Thu,  8 Feb 2024 12:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707394292;
	bh=Y5mb87bfIecKDPigGFFDcBn7FIohiyxS2vG0T0P/zF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uz3QtunKhCW+rx23zeGl0a4Y4+yjbToRCKcnRHh2AozrVZQrrWiBeSm7Z4WquCNCq
	 qrsXs2xfQK4+Gn/QtbtJXDPToZC2wW/xbA8G8kg7S6DMOAqFH1iFdjC6jptoCq8wur
	 PVK4Q9XEwL2o1B7CKe2AUsgJBZYdzYBc+g/HmfV0rCx5cc8Mi+pL4/wqTNr+NK1JYw
	 jVd5rsJNyZ7gC8Rh4499PzBTdkJ4Lfbt8Qx1mn9WMYYdzUgcrYq/hviJOBslUKoHpn
	 dfFpeSqXB4rGxHHXJrOMfM+7rBY7F5onzltGhLph5tzJlzUa0UPwZiL8Y/kdPQDnEK
	 S+TKnYexIh4Pw==
Date: Thu, 8 Feb 2024 12:11:28 +0000
From: Simon Horman <horms@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Sam Creasey <sammy@sammy.net>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net/sun3_82586: Avoid reading past buffer in debug output
Message-ID: <20240208121128.GI1435458@kernel.org>
References: <20240206161651.work.876-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206161651.work.876-kees@kernel.org>

On Tue, Feb 06, 2024 at 08:16:54AM -0800, Kees Cook wrote:
> Since NUM_XMIT_BUFFS is always 1, building m68k with sun3_defconfig and
> -Warraybounds, this build warning is visible[1]:
> 
> drivers/net/ethernet/i825xx/sun3_82586.c: In function 'sun3_82586_timeout':
> drivers/net/ethernet/i825xx/sun3_82586.c:990:122: warning: array subscript 1 is above array bounds of 'volatile struct transmit_cmd_struct *[1]' [-Warray-bounds=]
>   990 |                 printk("%s: command-stats: %04x %04x\n",dev->name,swab16(p->xmit_cmds[0]->cmd_status),swab16(p->xmit_cmds[1]->cmd_status));
>       |                                                                                                               ~~~~~~~~~~~~^~~
> ...
> drivers/net/ethernet/i825xx/sun3_82586.c:156:46: note: while referencing 'xmit_cmds'
>   156 |         volatile struct transmit_cmd_struct *xmit_cmds[NUM_XMIT_BUFFS];
> 
> Avoid accessing index 1 since it doesn't exist.
> 
> Link: https://github.com/KSPP/linux/issues/325 [1]
> Cc: Sam Creasey <sammy@sammy.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

..

