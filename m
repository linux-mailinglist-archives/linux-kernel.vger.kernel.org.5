Return-Path: <linux-kernel+bounces-158998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5378B27F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF771F21B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C2F150990;
	Thu, 25 Apr 2024 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppFh1xjW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE1A14D457;
	Thu, 25 Apr 2024 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068825; cv=none; b=mCjujPIbcto8YbFR533NDsdaC6fGK1enDHHAGCNZPRp0rfUUoujOYxepeVIEUF538IENhnGW+NzJlHL0iavS1J/E5BbmUtjT2jjF5nDGVMrhqQgw+j8uniSmUfzD8FxJgy7DbLFUKN2Gv0lb3+SlqHhAHa3kfRR06Zy5+cUeis8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068825; c=relaxed/simple;
	bh=3jpA0jxtOrM/Uqkdg7yxRM62YlSKAnUiGdGNzloi//4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3gt/I003tbSU4c3OB4nrLMQI0GWd5zDUp1YIE0wBfgrsJlF1sAbksm982dS6PKDqq2nGV46IyOGrJgs493CRLOCD0gbf6Fgn/AkfV0kQhPe1Z2Lqd/Yr6wFK+Dn3o2+SPRR7dDKw65k4Ni484iIOZXh65NAOH8IiLF2sm7GIqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppFh1xjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A35C113CC;
	Thu, 25 Apr 2024 18:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714068824;
	bh=3jpA0jxtOrM/Uqkdg7yxRM62YlSKAnUiGdGNzloi//4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppFh1xjWf2kci1FJhtjIrbEINq9USZ4fYIi8a+kYjfczOXkx3LmJ6AXUDy51ynuwK
	 tgpzVirWkM798pCefQbee4sl4FkDYdAO0m8qjX0LdrdaAfzvKuECTIj/7KqePQNbyR
	 4XeC64zewqCWapZ14rt/FdWJIi3JIFJlGyqQvHC5STJiqWAqtKz8fjVh5UPOBvVsI9
	 UrmtHG+oFGXaAvna5kjygKMn9LLDOQ7FlelZTFh/es67PFyUd7PVvUv44hYdqNnyEr
	 ECF6rv66wFKaPb3KolI2i1AvRNTHe5FwMoyqudb2k+1pd7uoPBqegjb3Adxk4dAIH1
	 ObHdNUgyXjhmg==
Date: Thu, 25 Apr 2024 11:13:42 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: nl80211: Avoid address calculations via out of
 bounds array indexing
Message-ID: <20240425181342.GA657080@dev-arch.thelio-3990X>
References: <20240424220057.work.819-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424220057.work.819-kees@kernel.org>

On Wed, Apr 24, 2024 at 03:01:01PM -0700, Kees Cook wrote:
> Before request->channels[] can be used, request->n_channels must be set.
> Additionally, address calculations for memory after the "channels" array
> need to be calculated from the allocation base ("request") rather than
> via the first "out of bounds" index of "channels", otherwise run-time
> bounds checking will throw a warning.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> ---
>  net/wireless/nl80211.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index f391b4055944..f1ed0981147e 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -9163,6 +9163,7 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
>  	struct wiphy *wiphy;
>  	int err, tmp, n_ssids = 0, n_channels, i;
>  	size_t ie_len, size;
> +	size_t ssids_offset, ie_offset;
>  
>  	wiphy = &rdev->wiphy;
>  
> @@ -9208,21 +9209,20 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
>  		return -EINVAL;
>  
>  	size = struct_size(request, channels, n_channels);
> +	ssids_offset = size;
>  	size = size_add(size, array_size(sizeof(*request->ssids), n_ssids));
> +	ie_offset = size;
>  	size = size_add(size, ie_len);
>  	request = kzalloc(size, GFP_KERNEL);
>  	if (!request)
>  		return -ENOMEM;
> +	request->n_channels = n_channels;
>  
>  	if (n_ssids)
> -		request->ssids = (void *)&request->channels[n_channels];
> +		request->ssids = (void *)request + ssids_offset;
>  	request->n_ssids = n_ssids;
> -	if (ie_len) {
> -		if (n_ssids)
> -			request->ie = (void *)(request->ssids + n_ssids);
> -		else
> -			request->ie = (void *)(request->channels + n_channels);
> -	}
> +	if (ie_len)
> +		request->ie = (void *)request + ie_offset;
>  
>  	i = 0;
>  	if (scan_freqs) {
> -- 
> 2.34.1
> 

