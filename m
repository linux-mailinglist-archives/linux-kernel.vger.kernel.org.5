Return-Path: <linux-kernel+bounces-3916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3135817518
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920EA28506F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DF63D559;
	Mon, 18 Dec 2023 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsGzLhld"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A2815485;
	Mon, 18 Dec 2023 15:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE153C433C8;
	Mon, 18 Dec 2023 15:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702912673;
	bh=gdw2rG1kHMxFAFPOz78qJY9ASvmd2ILrgUQz0xLeORE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=qsGzLhldjXDOoUeKXNf619KvH5SkEYA4I+fGoUcCNWOxv3vJIetK15Ui3BnVr9wMZ
	 qk3TzhQEXcftcZv4sXkPWxKO0PAqCo0srqyRoZ3iXVY56jfeL+Eo80+m6SXtQ+jBK5
	 Fy8IJ66lZwBfnXeoaNJ+14DUjs5uI5K1ZNGfuCao1I9tN6kH+08lZfSZy8aVQnTsiS
	 XoL5mfU/MpW+kFx+Becsv72a06N92eq/iESC8IA6nsVq9Axk62nC4QgTKxzj9CqNes
	 N3uq+ZVW8cEXxp1D3KBVHT9oNNfzYyp0bYQFMYU5EmZhNEjzGPsCbkMJonYgSDOnip
	 5ljboZDb0DhNw==
From: Kalle Valo <kvalo@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,  "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  "open
 list:MAC80211" <linux-wireless@vger.kernel.org>,  "open list:NETWORKING
 [GENERAL]" <netdev@vger.kernel.org>,  open list
 <linux-kernel@vger.kernel.org>,  Jun Ma <Jun.ma2@amd.com>
Subject: Re: [PATCH] wifi: mac80211: Use subsystem appropriate debug call
References: <20231215145439.57286-1-mario.limonciello@amd.com>
Date: Mon, 18 Dec 2023 17:17:49 +0200
In-Reply-To: <20231215145439.57286-1-mario.limonciello@amd.com> (Mario
	Limonciello's message of "Fri, 15 Dec 2023 08:54:39 -0600")
Message-ID: <87frzzsfoi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mario Limonciello <mario.limonciello@amd.com> writes:

> mac80211 doesn't use dev_dbg() but instead various macros from
> net/mac80211/debug.h. Adjust wbrf code to use wiphy_dbg() instead.
>
> Cc: Jun Ma <Jun.ma2@amd.com>
> Reported-by: kvalo@kernel.org
> Closes:
> https://lore.kernel.org/amd-gfx/8bd60010-7534-4c22-9337-c4219946d8d6@amd.com/T/#mfe2f29372c45130d27745912faf33d9f7ce50118
> Fixes: d34be4310cbe ("wifi: mac80211: Add support for WBRF features")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  net/mac80211/wbrf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/mac80211/wbrf.c b/net/mac80211/wbrf.c
> index a05c5b971789..12c23e14f884 100644
> --- a/net/mac80211/wbrf.c
> +++ b/net/mac80211/wbrf.c
> @@ -23,8 +23,8 @@ void ieee80211_check_wbrf_support(struct ieee80211_local *local)
>  		return;
>  
>  	local->wbrf_supported = acpi_amd_wbrf_supported_producer(dev);
> -	dev_dbg(dev, "WBRF is %s supported\n",
> -		local->wbrf_supported ? "" : "not");
> +	wiphy_dbg(wiphy, "WBRF is %s supported\n",
> +		  local->wbrf_supported ? "" : "not");
>  }

This won't work, I still see the debug message:

[  333.765867] ieee80211 phy0: WBRF is not supported

The issue seems to be that mac80211 defines DEBUG in
net/mac80211/Makefile:

ccflags-y += -DDEBUG

That -DDEBUG should be cleaned up, but I think separately. It's just
that I cannot come up with any good proposal, all the macros in
net/mac80211/debug.h require sdata and we don't have that in this stage.
Any ideas?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

