Return-Path: <linux-kernel+bounces-162034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E808B54EC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3656B1F22324
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3DA38FA6;
	Mon, 29 Apr 2024 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fL+hftWD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1647A2C19D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385889; cv=none; b=e7fcmZdWldImDDf2vb2C9QQbvc4YCuCWhd32XWBI7qL4/2TM6+Hi3yS7dYiYNu8hrlCBnKS1es06+puZT+LiHGcn2flGYmsJE5vNZacrrYe/WkQFQYFcwPHs4RihbLGslWMNUT8hKQHMM+flZ/53nvVWoxsCzpp21N0FCepY8vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385889; c=relaxed/simple;
	bh=Dp4WhcAEm3LjoebX3QhKlSxpYfp26vcYnT3xltjPvdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCGUi1Z6wEORIirA41zzKPMA07c/vpaHQ9tZgqWN9YE7/R2KxRAHHY5RUVI7rocLcAIyzpLjjaN6FwVcHQfbquA14LE1B6Rq/aFXd82jxDladb+/2WWRp9VzdHQnFpy05bPEFlXmRCrykqSRx5MfszWGJNwIJKsN+G0/atDGe/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fL+hftWD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714385886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3aeDuQ2ScmwkduPqNuDpZ1kq3jr/gZ/7h6UWkDfJo4=;
	b=fL+hftWDo4reqtaDorl3jcfhFpHAJqQxFWgW4ti8G25hefsqv8cGst1friQWehXroDjJIB
	oKPNUQQu291hjUGhtSO+24dDovRGGDwmEUxYgBzmb7cVDDmKTQUhAk1WS0XwNJMfBUB7Ab
	V1mIT9U9Pd1LVwm5F9wbW6JL+kEOZqY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-rh4CZOlCNQaiYCt-RUNZiA-1; Mon, 29 Apr 2024 06:18:05 -0400
X-MC-Unique: rh4CZOlCNQaiYCt-RUNZiA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6f3eb28c129so1042218b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714385884; x=1714990684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3aeDuQ2ScmwkduPqNuDpZ1kq3jr/gZ/7h6UWkDfJo4=;
        b=WEaVIoMKWXSAYeXQYudKz4Uej4StFBOFtwpksLAw/IOqmnKw9NcNd0YhNZAB5wn0rk
         tpuHeET3ZRt3Vzd/3dBNVBJQWEPkoX3GnGvzgMoBy3UhDD/bjKugNmyiW/NGnP5nDXnP
         LKtmc4WwY9Xsj1rabUuvbRnAj933HiejmxLOBqSC25AR5E1H4ywKCcBJ9MGnA/tI2P8t
         Yj1dFBW1SKKEedv+kdVs6lFYC5MIr52afKWl5yLqvqdI8g6cvHFyLYR6ewTxFg5EhHw5
         OstBG93e9DIkwlT4XIVXOj4kqaM0mSrDFQwzW4I0JbUltKnXkEKpFUpllQim6ITKW+EM
         ItcA==
X-Forwarded-Encrypted: i=1; AJvYcCWzeelGmfdqTd62YxZ288ks2ZRIoORDWd5ZxYArgJnG2t+UFD8KrJ/WGyCi1WMXYMhTCAbLjwdtFcmodddc2AzijpRr/kfyL8eAJIdq
X-Gm-Message-State: AOJu0Yy+dCK5QAbXTBkC35weGQFtufx95HcOSsdsGljIn+MIPhc4v5sZ
	VYZqRCJ7K28Wu4ySypTEiuRr0lwD9yp+WqsMSlZWh/Bo2rwhxLkI33Q0oBoK6Ink7QwyBVNqT53
	PEQH0FxXOGHnUy7BdSGm8AKoRKnqg/o1SlyqZFLrF7WIkGmoj5qasOdgf5GV3hj76S7TkJw==
X-Received: by 2002:a05:6a00:181a:b0:6f0:28a4:a871 with SMTP id y26-20020a056a00181a00b006f028a4a871mr12925343pfa.19.1714385883780;
        Mon, 29 Apr 2024 03:18:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7eC24ZKymDj34tQBxNz7Rb3a/lZm4YtKpVZG+eZcQITmkeRVRNQMXKkPx9ADzN0m+zHz5eQ==
X-Received: by 2002:a05:6a00:181a:b0:6f0:28a4:a871 with SMTP id y26-20020a056a00181a00b006f028a4a871mr12925319pfa.19.1714385883454;
        Mon, 29 Apr 2024 03:18:03 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id a15-20020aa780cf000000b006f0830a298dsm18919959pfn.156.2024.04.29.03.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 03:18:02 -0700 (PDT)
Message-ID: <aedb7cd5-56b3-4efe-b62c-ac3d7a9be740@redhat.com>
Date: Mon, 29 Apr 2024 20:17:57 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] vhost: Cleanup
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 jasowang@redhat.com, shan.gavin@gmail.com
References: <20240423032407.262329-1-gshan@redhat.com>
 <20240429025750-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240429025750-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/24 17:02, Michael S. Tsirkin wrote:
> On Tue, Apr 23, 2024 at 01:24:03PM +1000, Gavin Shan wrote:
>> This is suggested by Michael S. Tsirkin according to [1] and the goal
>> is to apply smp_rmb() inside vhost_get_avail_idx() if needed. With it,
>> the caller of the function needn't to worry about memory barriers. Since
>> we're here, other cleanups are also applied.
> 
> 
> Gavin I suggested another approach.
> 1. Start with the patch I sent (vhost: order avail ring reads after
>     index updates) just do a diff against latest.
>     simplify error handling a bit.
> 2. Do any other cleanups on top.
> 

My apologies, Michael. I didn't see your patch until now [1]

   [1] https://lore.kernel.org/virtualization/20240327155750-mutt-send-email-mst@kernel.org/

v2 was sent with your changes integrated and other cleanup are applied on
top of it. Please take a look when you getting a chance.

   v2: https://lore.kernel.org/virtualization/20240429101400.617007-1-gshan@redhat.com/T/#t

Thanks,
Gavin


