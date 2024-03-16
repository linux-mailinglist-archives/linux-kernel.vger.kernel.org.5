Return-Path: <linux-kernel+bounces-105013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC6D87D79D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E98E1F22D8C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2114B28F5;
	Sat, 16 Mar 2024 00:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JPPP50Ww"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526691849
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 00:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710549921; cv=none; b=BqW7Y77QtcwVmx0UfBqOP7mjVGVBbrhdUTOoKGJmqmZ3rnuzmI4+ebi7o2oKGxRNrQnIGCg4vYoNBgnWStAtKTvbQc1ujL3n8Ds6accOThWj9/AtvKr4bYnokWQLuWgLSIzHiQmnRTi0TXSl7PidvmNvxak8FxTqQo6nnT8n1pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710549921; c=relaxed/simple;
	bh=ikdpcG3s6vcAdkZ0n587iRP3Ajn7m0gt3MNdiwxr64k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4p2xXfoEMwBtWS6UpmKIRZZummSPqgmu6ET1G41NpkhG7FSRBYvBuWkJLWb/M2XDNW59g0ORlRUASqHVV27z2ljghkBEzaIhxGMQX5ID83+z5Ll5xnDe+9cfltjtLGTk8gwg6ljuZtn4q4giTD3mNgNy7fGSdxzZWQWIZyE8yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JPPP50Ww; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e6b54a28d0so2229795b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710549916; x=1711154716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T4D22NDDYXjcVVv2x/lMl+1OA7JpB6ktf6eG4KwdW+U=;
        b=JPPP50WwH2chx8GKPfnnklU10Jx1cbZhGPmKKq5qo0uM3idZbhM6IYPM4QTlW9gN6s
         k9Kn72GsVVngbHqYMR511UljZRgLa2OVbsaPsrlbTRiTOMPx6CSnmh6p+3TO5aCEg8uQ
         gxnYOx0FfLfjhvuSls7gD/jk+Lj4Ix4kj78Js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710549916; x=1711154716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4D22NDDYXjcVVv2x/lMl+1OA7JpB6ktf6eG4KwdW+U=;
        b=gzzoNUWH/+ftY+5KFrO5SR8DCpYFoCVLq94Pke/N2GkjSLPudaULcx13TbbK+NegTI
         RSXOsYIi7l9S6ax9IgqgKHp2SGOK8WShhBbaQYI4DDCLLGYgun8SZk32lqKuNtNgmZcN
         mMrGNNjiAl0GlATR2SroHJJ/Am/qGElnsBDnTOKqWFOC9NlJS0Jc3RmHyDskoN1upsso
         hn8IfxXDnRtijUQfEx1lhN8XCU8AardbmrayIozQXvfetAqYMFsbJJpo+gjtTgHcd6QL
         AxnM3Ljt4wMlzWY+ykjps8nYE9RQQC6pVNmKEMoumXto0QctY/L7FlgGTw6OcA3oyNWM
         MCJA==
X-Forwarded-Encrypted: i=1; AJvYcCV6+9NJZR1HFWSWwsBFjhOAlM91sds2LY+RsIdxogfkPT++7LQZKC2cEdxH49JWvQXyuycRMIjDAiLEkoOs8zd6UmiMGvIIivcIvVJR
X-Gm-Message-State: AOJu0YxQO6VUkz0j6MWPTh3AhyXBe2hS7iydOi7tR3fGUmn6CD9/9y+Z
	iqYS+0Tsl/vQh1hukXACy5yirx94aGXHHDVcO2aAbeGeZ/V7vD9RRURBWvihjQ==
X-Google-Smtp-Source: AGHT+IGWNc1KDBy7VkK3qFWBa04hU4d9qOrF+azes+R7KjCdS0ce2m4rS/8o6Yr1mA+ci7+fi6nEbw==
X-Received: by 2002:a05:6a00:928c:b0:6e6:cf40:2d6a with SMTP id jw12-20020a056a00928c00b006e6cf402d6amr5427781pfb.1.1710549916527;
        Fri, 15 Mar 2024 17:45:16 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:39af:f807:ea8f:1b15])
        by smtp.gmail.com with UTF8SMTPSA id a26-20020a62e21a000000b006e6529c7d75sm3996201pfi.3.2024.03.15.17.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 17:45:16 -0700 (PDT)
Date: Fri, 15 Mar 2024 17:45:15 -0700
From: Brian Norris <briannorris@chromium.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v9 2/2] wifi: mwifiex: add host mlme for AP mode
Message-ID: <ZfTrm7bxMykHO-M-@google.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <20240306020053.18054-3-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306020053.18054-3-yu-hao.lin@nxp.com>

On Wed, Mar 06, 2024 at 10:00:53AM +0800, David Lin wrote:
> Add host based MLME to enable WPA3 functionalities in AP mode.
> This feature required a firmware with the corresponding V2 Key API
> support. The feature (WPA3) is currently enabled and verified only
> on IW416. Also, verified no regression with change when host MLME
> is disabled.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Quick pass for now; nothing jumps out at me today, but I'll give a
better look/Ack next week:

> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c


> @@ -3951,12 +3974,43 @@ mwifiex_cfg80211_tdls_cancel_chan_switch(struct wiphy *wiphy,
>  	}
>  }
>  
> +static int
> +mwifiex_cfg80211_uap_add_station(struct mwifiex_private *priv, const u8 *mac,
> +				 struct station_parameters *params)
> +{
> +	struct mwifiex_sta_info add_sta;
> +	int ret;
> +
> +	memcpy(add_sta.peer_mac, mac, ETH_ALEN);
> +	add_sta.params = params;
> +
> +	ret = mwifiex_send_cmd(priv, HostCmd_CMD_ADD_NEW_STATION,
> +			       HostCmd_ACT_ADD_STA, 0, (void *)&add_sta, true);
> +
> +	if (!ret) {
> +		struct station_info *sinfo;
> +
> +		sinfo = kzalloc(sizeof(*sinfo), GFP_KERNEL);

Couldn't this just be stack allocation?

		struct staion_info sinfo;

		cfg80211_new_sta(priv->netdev, mac, &sinfo, GFP_KERNEL);

I'm not sure you need to kzalloc() something here, if you're freeing it
a few lines later.


> +		if (!sinfo)
> +			return -ENOMEM;
> +
> +		cfg80211_new_sta(priv->netdev, mac, sinfo, GFP_KERNEL);
> +		kfree(sinfo);
> +	}
> +
> +	return ret;
> +}

Brian

