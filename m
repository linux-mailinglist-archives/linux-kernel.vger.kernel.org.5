Return-Path: <linux-kernel+bounces-158018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB878B1A3C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39535286BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6453A29C;
	Thu, 25 Apr 2024 05:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BRBRiOrO"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF0B3A1BF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 05:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714022145; cv=none; b=UlPj1pOtkUXUgrkgeq88wEd/gAZe7FMwyNqq8FWw3PGZiSFq8ssvaWb+Fl/SzbGG50akT9cd46u9pK8+Ft5Bw9t6iTKKtOs2Z3vPzu1X5OM66/EsMXvKbutOyDFWbs7inPQuH8nElwy8yVfLwPAw0o/sSSfpP82O49iI3oaUh5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714022145; c=relaxed/simple;
	bh=KMml6kOnTgP5A7N4cMeQuHkBnwThjTY+lkYFRv3m4lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtq1l2cYdRfLivglLYIZES1JihY4W3IBNQIg2I1+MybHj0Ppj1YUsD+41/kQs6YUuthV0OaGMjhXdRPAP05LT1cgwOx7prIsLjgobrLyXh34RbyKtEx9n2VIwRcDO4LT4i/xH8V/P0tLCOEqode+fkfJRpQxthcjhLEfEMi48g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BRBRiOrO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e5715a9ebdso4419715ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1714022143; x=1714626943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNdUFtYR2xbr86vH1UwuLkPY/+I0PhhpA884pNqNeBA=;
        b=BRBRiOrO/0ZBdi6rDOWpLKIIojZHBhZm7QsyoAqowo+sVt8BDsvaEGq0Ocfg0gq/gb
         UoJzv2UlLwZ/dR7Ro5ZYZSV5teT5ivU1mbSfkwoOA72XOm2eqzktzkiWZmWAFtpF6KLr
         M4leknzkYM+c6XFYIaQi/KuE5Mv5gk+DIrjIchinNS1LdeId6bCEoJKRd3UAJnw3810J
         yGBmIhVdPrMhqHBIeXbqsUW/2J/9buwfqMboZUyyig7GkXodgW+20e8g2AArryz1At9K
         4fzCh5zpLy1NvrcnsEjXio7nEsKETLYaWhDi7KjFO/hr5epEncL1wm6Q05QAVuUdE7Vc
         YkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714022143; x=1714626943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bNdUFtYR2xbr86vH1UwuLkPY/+I0PhhpA884pNqNeBA=;
        b=LT0/kyXMpYtEfPucZ6Z5rhkcrs3s3oI9v+4tvUhZBc5JrY3HspOKmHYdWQErutYYlg
         r75ACs2XVPn+gu/iMCdLLK08qpTSsHelUKaEpMnKWegYf5V6/ZxvWPh7Bu6HOQwkVPAO
         K/KWpVFpas6K+DV+w6rxOXg3YBcGypeLdn+x5yM8X8qa4rr2Yr5SEuLa16oOrYYNIi/T
         FmlWyU3JQQm54zHc7Pkz0/8GzOk7BOyxYLsLsd1BPrXCYDBJlFioXC4xPJ9j8SnjKOAo
         Oc4zLuDlgmhzZ7i54nWXcTBYpA0ajepjN0ujuhQ6BwQgP0pC+A0sX/PAcUbWFRSpKaC9
         vpsg==
X-Forwarded-Encrypted: i=1; AJvYcCULDM0y1e57pmcgtykThrhwKgKuZdDf+hKTvtwT+ODaQKKeSPBF7g38Wr8kYANpR2LcONs2Wk0UufD08yjx3rUqSeSYBV+qTnXQCW+Y
X-Gm-Message-State: AOJu0Yx9uy3KRZ36toLm0EAkvzKTLOCgr9/mdQIYTOlEk7P6VXXVxFfb
	52OiNcF6hzIEc0tQxtmVFa96ndAA6BLT3DgSPQivWLfv4UdpJEG5dk6UUFpv/Lc=
X-Google-Smtp-Source: AGHT+IEQITLDZGcYmA+FjKYuiztsfCh0wLhqQI6Xcb/IceR3ZPd+qhouMoKXS2ZMMGdGKHN5UKg2Ig==
X-Received: by 2002:a17:903:41d0:b0:1e4:6243:8543 with SMTP id u16-20020a17090341d000b001e462438543mr5733230ple.5.1714022143006;
        Wed, 24 Apr 2024 22:15:43 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id f16-20020a170902ce9000b001e78d217fd9sm12826398plg.16.2024.04.24.22.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 22:15:42 -0700 (PDT)
Message-ID: <e1c97315-de7a-4222-9fd4-788e566b2eaa@bytedance.com>
Date: Thu, 25 Apr 2024 13:15:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] cachefiles: make on-demand read killable
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
 Hou Tao <houtao1@huawei.com>, zhujia.zj@bytedance.com
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-13-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240424033916.2748488-13-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/24 11:39, libaokun@huaweicloud.com 写道:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Replacing wait_for_completion() with wait_for_completion_killable() in
> cachefiles_ondemand_send_req() allows us to kill processes that might
> trigger a hunk_task if the daemon is abnormal.
> 
> But now only CACHEFILES_OP_READ is killable, because OP_CLOSE and OP_OPEN
> is initiated from kworker context and the signal is prohibited in these
> kworker.
> 
> Note that when the req in xas changes, i.e. xas_load(&xas) != req, it
> means that a process will complete the current request soon, so wait
> again for the request to be completed.
> 
> Suggested-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/ondemand.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 673e7ad52041..b766430f4abf 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -525,8 +525,25 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>   		goto out;
>   
>   	wake_up_all(&cache->daemon_pollwq);
> -	wait_for_completion(&req->done);
> -	ret = req->error;
> +wait:
> +	ret = wait_for_completion_killable(&req->done);
> +	if (!ret) {
> +		ret = req->error;
> +	} else {
> +		xas_reset(&xas);
> +		xas_lock(&xas);
> +		if (xas_load(&xas) == req) {
> +			xas_store(&xas, NULL);
> +			ret = -EINTR;
> +		}
> +		xas_unlock(&xas);
> +
> +		/* Someone will complete it soon. */
> +		if (ret != -EINTR) {
> +			cpu_relax();
> +			goto wait;
> +		}
> +	}
>   	cachefiles_req_put(req);
>   	return ret;
>   out:

