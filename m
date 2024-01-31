Return-Path: <linux-kernel+bounces-45630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749D9843339
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293401F27DB9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570786AD9;
	Wed, 31 Jan 2024 02:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZouvvPjc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CE363B9;
	Wed, 31 Jan 2024 02:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667282; cv=none; b=NoxWp57mQdxr8yoHqtxEmRvAGH951EnSXIb8rz/DH8br4oRpIyeOvER+bNO5j/weMwaebG7OGrcVYzULVbuT7CXCOFTXYNkWN5shnGurYA/IzyMb3K1ON19zp79zRPu3sV1t3gW+q+rpN7DPhwkD9WqfKMsvxjOgkjbOC7pGwpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667282; c=relaxed/simple;
	bh=Q4yhgEhtIEYSfwUmAoh8WuwX6zuMgT7HY8EbWFZ9mL0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdaVpf5BjAMJbVv8h9EMNmuwjmj+8VNDnTnsdEPxHKuYP5uzzP3EDkZ4DEk2oE5REY3P7P8/kpTLlbUDZtlb0lAuo0hHhRXzJ9sJOg3eaPLb2Lmt2eeq+8tq4PUHNUs7lYwQKi/p0JBuLH4za7qyieHluHl7oU7EtqxSIZppDvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZouvvPjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2C0C433F1;
	Wed, 31 Jan 2024 02:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706667282;
	bh=Q4yhgEhtIEYSfwUmAoh8WuwX6zuMgT7HY8EbWFZ9mL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZouvvPjc55LPYVq7D+8n2VVtEE46cd2K4RLI5fk2oQVuXC7M3Sr4ciVhXfckl+Pdk
	 9EeqstGFq40zspfS6n8S10oi965QJXs5Yl+5/ZWnqk/6WfJTRE0U6gnjqULVO0FcF3
	 CDyvKfFjBJyUai090LbPOiR4cnyvFki1yv4FhM5c+x5MtzP/XvT/s5Bme5Wn7d+aqN
	 tEr386Wfig6WBd0zfjydPUqJ/4hdJkbDyccCoRKYm2RbiSxGYmdbvQBEwd1fdnhet8
	 5uyKreGGWETzgPzRpnTicqeQ7AwA2kQ8JQP+PvKrSNTCUUSRsQ+p4qJnVXfHIB2p9v
	 lhGY4sOltTGsQ==
Date: Tue, 30 Jan 2024 18:14:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 weiwan@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 horms@kernel.org, andrew@lunn.ch, leit@fb.com, Uwe =?UTF-8?B?S2xlaW5lLUs=?=
 =?UTF-8?B?w7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, Kees Cook
 <keescook@chromium.org>, Johannes Berg <johannes.berg@intel.com>, Emmanuel
 Grumbach <emmanuel.grumbach@intel.com>, Justin Stitt
 <justinstitt@google.com>, Li Zetao <lizetao1@huawei.com>, Francois Romieu
 <romieu@fr.zoreil.com>, Rob Herring <robh@kernel.org>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Ruan Jinjie <ruanjinjie@huawei.com>,
 linux-wireless@vger.kernel.org (open list:TI WILINK WIRELESS DRIVERS)
Subject: Re: [PATCH net 1/9] wifi: fill in MODULE_DESCRIPTION()s for wlcore
Message-ID: <20240130181435.13f6e2cc@kernel.org>
In-Reply-To: <170662101207.2289851.7564186430529596261.kvalo@kernel.org>
References: <20240130104243.3025393-2-leitao@debian.org>
	<170662101207.2289851.7564186430529596261.kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 13:23:34 +0000 (UTC) Kalle Valo wrote:
> > W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> > Add descriptions to the TI WLAN wlcore drivers.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>  
> 
> These patches go to wireless-next, not net. But no need to resend because of this.

FWIW I've been taking these thru net (or wireless in your case)
rather than the -next tree. There's zero chance of regression
here and the warnings are annoying. But up to you.
-- 
pw-bot: au

