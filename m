Return-Path: <linux-kernel+bounces-123686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09379890CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76BD3B2277A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D936913AA39;
	Thu, 28 Mar 2024 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BVFisEnO"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DA0137779
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711662651; cv=none; b=MYo3T7bBJWupFgZiz873XDwvbDZLvWtyIjCmX7PCsU6LiGNPxLZwZ3cR6asNPJIsyLYNnwa1Xl+t3xbzZx+B81XAs4Ngess0EVgekiXIK+1k1t0ZF/CNXU39yXiDgodjcfsvshuZ48X047f1oJWLyO/1hrr0zLcC2zuNpylSPSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711662651; c=relaxed/simple;
	bh=AaG/JQ942744By6JWnpn1/mB71bmQP7Qf4tM7JpBi3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GG8HqsEfk5vgn5a1oi+xCjJyG0pRy2vimwmg99oCLiBIPtuvegeVKc0bRP4B0lfYjESZsv09VhdYtib8xE+QNYS63OjDMjdncnS+EXA/kPCwKbZI8Ms6Yhjl/AZK36DOAdqizjkBE7rP6KVVioweGIpuchwq+amItKtR+wXWNGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BVFisEnO; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a4f7a648dbso799544eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711662649; x=1712267449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9VNKqIZeu5aRMq+EcvLmL1iZpaTvAUz76/b2Q6IYI4=;
        b=BVFisEnOj6o3zIgtDl2rkZ1dNUmJESvVH14PV41cPjpWHSi/XaQ2rmvr0WSlsLg350
         s6iSJalUYEJlHpfj1QZ3s8O1eiJ7bG9obOEy00gw13Km7mDNbq266NdZGAPoZXL7t80d
         mtj2BVvwIM4xI942JI0YWH+0lDsKpNUhpxKu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711662649; x=1712267449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9VNKqIZeu5aRMq+EcvLmL1iZpaTvAUz76/b2Q6IYI4=;
        b=bJwO9zWotJP90QXC6yxlNkQ20ONVFBpbd0y06HZ+cWUuMJgMS72SxtA77XMKws2ZAH
         ZUJSlGJKgslm53sxVU1UGU6ujFOi1I03inHdqBbRRXmlz5mL7GN1B5JoIG9rG8Aa/cBR
         X5I9ZOgVz7/uZvtwgopaJD5ge7x0Dg3euX6JfNlvwhWR9x2OZzGZbjbFR8/8reFAfKlY
         MZloU3VTmiESEBChuzd76HXZNZpfWGowNvyTiuaaTh6T9GfGYpP9wuueckSw9uRg9iPX
         6CHx7Ah3QVyForexbjyKAGIz5RKsdYORdwkYZ/Ko2WaE7caLSnR4ZHXmHFbSWDRDjCFX
         58eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL5j974ACQMFnGd2qmaAh4FW0TdzRcWCKiMF/YwhUFtlVuYcSmOOECrtpYxE+docQ0PJFI1ifK/yyrxWNcC+a6WpvSGH/6dalLavA7
X-Gm-Message-State: AOJu0YwP9I4M8pAX2zvXTgDXxfKoAEp/A87LjuymU8Mxorzri9cqliSF
	K9AO3DsmIfcvDGmOsg3yDY4GfiQKpYffY9J9Ty7WofTEo4KOam0EFUspfjaS6g==
X-Google-Smtp-Source: AGHT+IGJ/A8B+g2+nP/nK7KddniHxRqwqdU/PivvhTlgMDDkbuncjn3iau7BevP2DI44v43cswmPHg==
X-Received: by 2002:a05:6359:4594:b0:17e:9c8c:2c25 with SMTP id no20-20020a056359459400b0017e9c8c2c25mr728796rwb.7.1711662648877;
        Thu, 28 Mar 2024 14:50:48 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t62-20020a632d41000000b005dc85821c80sm1739857pgt.12.2024.03.28.14.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 14:50:48 -0700 (PDT)
Date: Thu, 28 Mar 2024 14:50:47 -0700
From: Kees Cook <keescook@chromium.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Hancheng Yang <hyang@freebox.fr>, Remi Pommarel <repk@triplefau.lt>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] wifi: ath9k: work around memset overflow warning
Message-ID: <202403281450.CAD08A9B@keescook>
References: <20240328135509.3755090-1-arnd@kernel.org>
 <20240328135509.3755090-3-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328135509.3755090-3-arnd@kernel.org>

On Thu, Mar 28, 2024 at 02:55:05PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-9 and some other older versions produce a false-positive warning
> for zeroing two fields
> 
> In file included from include/linux/string.h:369,
>                  from drivers/net/wireless/ath/ath9k/main.c:18:
> In function 'fortify_memset_chk',
>     inlined from 'ath9k_ps_wakeup' at drivers/net/wireless/ath/ath9k/main.c:140:3:
> include/linux/fortify-string.h:462:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   462 |                         __write_overflow_field(p_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Using a struct_group seems to reliably avoid the warning and
> not make the code much uglier. The combined memset() should even
> save a couple of cpu cycles.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

