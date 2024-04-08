Return-Path: <linux-kernel+bounces-135909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945D489CCF8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F3B285825
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B011146D60;
	Mon,  8 Apr 2024 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bjZ/Ieo3"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3CE142E86
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 20:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712608514; cv=none; b=S53mmh6t15nA1K5YJz1EDWv9PXetJYJDZikLUNjNAyYoOHivMlSKn9xjCp7vWsIqAFcrX1I3e5LmfXaFGgADWLh2r63HOB+zcKXY2K+lMW3ZhkP0KnwhmmrHC863O6ZHE6xqcNoQm4pjAWIc5hKMuFHfe5ZrVTAq7SIFZmmRpBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712608514; c=relaxed/simple;
	bh=OcEhbhHITIrHOZAIdPPlDfaPIGAgz7UAoS2jk9MSk8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnFzS5D5WTXSdRN9yasi7vkkWjos0JANjSIDD4z9jH6yWXoifPM3zLJR9H339DHxO8u83EfEgsOlpb4L7oO0hQAQI7KbzOb2amhVX53CRiKddLKem4/2RIcttcDFg20HRXU/MC8J4kmRy6EdR5P680SdNUkZXGhKVuW2Rs82Tvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bjZ/Ieo3; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36a0cc66deeso11207055ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 13:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712608512; x=1713213312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZHkRhGYH9MwQZSzDBZ5+pjbW/9T1NNKYEiPQeECsdM=;
        b=bjZ/Ieo3kZ22VvrabHehxYuyCSJ3PyWwJkJHMmRxwEFMyLmnShObhZHAQsWGAqM9C6
         kO/dS77Qg9Sd18qlLE2ncS/qYsP0ny7+qtHCEoTUwxNB3tVGjfEa4akmO+YApogYLPpC
         xVrCL/ZyQjjdgtC79QCHczKkj1o24lHW/lD8gNYEgG7RZQd85KaPzCO3qqzTk3n6YDUb
         oZrL+NP/xsW6XgTagXvxyXpinlXmTf1EadZhQFS66sESuXFSD9WOxAZ7Fq+9/5lPc2ak
         B8i0E8t12trLHbMaE4mYFzTYH9XfMHnWBT6IP0jgAM7vIMuhHkc7FNxm2JgFN9wqX8tn
         CBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712608512; x=1713213312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZHkRhGYH9MwQZSzDBZ5+pjbW/9T1NNKYEiPQeECsdM=;
        b=m0wRipN7JRiWdgco7pNlrtZHRcpEwjrhScLnIH/LiWqqfqtdn5rg9wBkDIB1wjbfg1
         fD5/x+7kVl1J2QQnpOaiVHheJbhc2JUDvvtErmxy+arQ5D/LEWp5LBIO1LJRaClOmabd
         q9VeRJSEKC87h5L74UG57HNxwrO3UkKPA40olDVoz9Sj++C3vUcXPQpm+uYJenccjWoq
         6mYH4sRLVuubOxfAQJyLR5DvDnI1T+ulP+FSQasc+CFj/+keXCI+nstOuEXvQt6VDM4i
         UDSRPye90ZnbuKHlQTpIdbIwuU2noxpt/j1nuA6u5/LXY33IpErSrj95OVfbWE73TyBa
         9+tw==
X-Forwarded-Encrypted: i=1; AJvYcCVco8Ogl1AylUPE9zKlTTHqv5Y/Qgwf7266fBNillelqd08uxZ2o12XIzoo9X2+2LFaY3yO69lwyH3wWoo99q+V7D3fnRbW7HO7lqcS
X-Gm-Message-State: AOJu0YxSsku86kLJAXaIOBrCgJuJ/r0TnG3WxR6bs7EA27n4yp+tOVEO
	1FuWQw2xaTLIj08jO9OsFS8Wvazo191PrRVQ3+k/n3yrk/yMSYa+N+mbAqYUGg==
X-Google-Smtp-Source: AGHT+IGOzQ90wEzQVaj79jiCZtAwqyU686xC2bmO8snxJyhVXZL9zo3Xh37CLodsWqK2+hCyUPT+9A==
X-Received: by 2002:a05:6e02:18cf:b0:36a:1725:e123 with SMTP id s15-20020a056e0218cf00b0036a1725e123mr9252317ilu.14.1712608512197;
        Mon, 08 Apr 2024 13:35:12 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id r10-20020a92d44a000000b0036a2855e238sm525616ilm.78.2024.04.08.13.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 13:35:11 -0700 (PDT)
Date: Mon, 8 Apr 2024 20:35:09 +0000
From: Justin Stitt <justinstitt@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Franziska Naepelt <franziska.naepelt@googlemail.com>, 
	Johannes Berg <johannes.berg@intel.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Aloka Dixit <quic_alokad@quicinc.com>, Erick Archer <erick.archer@gmx.com>, 
	Yang Yingliang <yangyingliang@huawei.com>, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH 2/3] [v2] staging: rtl8723bs: convert strncpy to strscpy
Message-ID: <5tivf4xqef52ivneq6ucs2au2ld62ruwmjddhrhrgnltr3q3vj@iykmv323noqq>
References: <20240408194821.3183462-1-arnd@kernel.org>
 <20240408194821.3183462-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408194821.3183462-2-arnd@kernel.org>

Hi,

On Mon, Apr 08, 2024 at 09:48:10PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-9 complains about a possibly unterminated string in the strncpy() destination:
> 
> In function 'rtw_cfg80211_add_monitor_if',
>     inlined from 'cfg80211_rtw_add_virtual_intf' at drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:2209:9:
> drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:2146:2: error: 'strncpy' specified bound 16 equals destination size [-Werror=stringop-truncation]
>  2146 |  strncpy(mon_ndev->name, name, IFNAMSIZ);
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This one is a false-positive because of the explicit termination in the following
> line, and recent versions of clang and gcc no longer warn about this.
> 
> Interestingly, the other strncpy() in this file is missing a termination but
> does not produce a warning, possibly because of the type confusion and the
> cast between u8 and char.
> 
> Change both strncpy() instances to strscpy(), which avoids the warning as well
> as the possibly missing termination. No additional padding is needed here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Helps with: https://github.com/KSPP/linux/issues/90

and for the bots...
Link: https://github.com/KSPP/linux/issues/90

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
> v2:
>   use the two-argument version of strscpy(), which is simpler for the constant
>   size destination. Add the third instance in this driver as well.
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 5 ++---
>  drivers/staging/rtl8723bs/os_dep/os_intfs.c       | 2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index 65a450fcdce7..3fe27ee75b47 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -884,7 +884,7 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
>  		goto addkey_end;
>  	}
>  
> -	strncpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
> +	strscpy(param->u.crypt.alg, alg_name);
>  
>  	if (!mac_addr || is_broadcast_ether_addr(mac_addr))
>  		param->u.crypt.set_tx = 0; /* for wpa/wpa2 group key */
> @@ -2143,8 +2143,7 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
>  	}
>  
>  	mon_ndev->type = ARPHRD_IEEE80211_RADIOTAP;
> -	strncpy(mon_ndev->name, name, IFNAMSIZ);
> -	mon_ndev->name[IFNAMSIZ - 1] = 0;
> +	strscpy(mon_ndev->name, name);
>  	mon_ndev->needs_free_netdev = true;
>  	mon_ndev->priv_destructor = rtw_ndev_destructor;
>  
> diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> index 68bba3c0e757..55d0140cd543 100644
> --- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> +++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> @@ -415,7 +415,7 @@ static int rtw_ndev_init(struct net_device *dev)
>  	struct adapter *adapter = rtw_netdev_priv(dev);
>  
>  	netdev_dbg(dev, FUNC_ADPT_FMT "\n", FUNC_ADPT_ARG(adapter));
> -	strncpy(adapter->old_ifname, dev->name, IFNAMSIZ);
> +	strscpy(adapter->old_ifname, dev->name);
>  
>  	return 0;
>  }
> -- 
> 2.39.2
> 
>

Thanks
Justin

