Return-Path: <linux-kernel+bounces-137193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A5789DE98
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEAA3295BCE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE0113AD0F;
	Tue,  9 Apr 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f917Lgu3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D6136E3D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675589; cv=none; b=eVfixoZpxaSkDC8H5cBT+4TQO7GrVT07rPmZvrUhTv3a2GsUNqtHI2I4TlNqB/e8cWBZYcLu4dXTx0d7uLWGO7xPjjkOmHXrA1gSr70yErvaYxNriKhXg7i9BIAMYFPaD8EO6zRhOmix0rhBhQd/phs71Skg75/Oo/suDHULrB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675589; c=relaxed/simple;
	bh=NC/926e4LmZ9vho0qmp4hDEpof0tNd6IDDbH+eoix1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLPZNnixHFg0tRDFcCxql5TQ7P3ei2GGyJZTLMp5dUp7syOHwEsfZmIYFnFcQM+Ys0jxRaw+NoBeb2amft81xAqh6YjIwhTEwX9l47P8NmaigUudk4DMUJ0qh2lTr0g0aKaRP1b69wnv2n5TbYmb/1kXIhWc13+6TzpmaMl7SWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f917Lgu3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712675586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zm++LgeOR+PGpoACGSSCnqRxRPj2EsWJivVbDS0PipA=;
	b=f917Lgu3UADkbvfE3/G0GJhcIsbboJZBoJP5ZKImI2Txh3svUxx1sv6D64I7q6Trs6Q14D
	5xwqR7jCAUoWyiqgZsi/ZlLLHmF3lF/bWVy7OfxCHrew7Q5oHWXfIKC3iw3qeCRrM0mQMK
	StQrILSAdqz2uQcbGLMFiPTygYKKEOA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-6EhoJMKaPrKUiMVedMqBMg-1; Tue, 09 Apr 2024 11:13:05 -0400
X-MC-Unique: 6EhoJMKaPrKUiMVedMqBMg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343e54fc19bso2744805f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712675584; x=1713280384;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zm++LgeOR+PGpoACGSSCnqRxRPj2EsWJivVbDS0PipA=;
        b=e8mQidTSJhpqokY8ZmOEhfMa+TMi4jcldqCwW/fVCu00EZ9IC5C/lSmyffeHkKCrhm
         0TI+dMM7B0aMRIQgnGWVAypzALZvUs9VW37o7mWsb6Qaacp318Ut+3S9fKDJ3GY73p3R
         v1xPIK5yg6y5iV89ZEm9aU5t2Bx0+JCYcj26Pw4Owo4YiBwMxHFSpvV/bcDbT5gnsgbE
         9vROXpdzvQ99BlmdVs70iP0is/gqZVgCSWSBLodp1WrRJ+dFPdzI02R6ZU9L8Kum4efc
         dAVoc+JJzsR35WBavIWYUqL16nMebmBpoS3VPirqZNwZcGy4p2FZtg7s6/agK3aUk+O9
         neqg==
X-Forwarded-Encrypted: i=1; AJvYcCVKmrLw84WJqwXykdqPhToNxaMwNDh7ULey9Gy4TtZ3UDJdHIIVNTxNp4tBlrDmwWY54zK1B3FiZ/WT2Y2I/k5Xlo1qnNaWeIPofBeK
X-Gm-Message-State: AOJu0Yz/mgf3rXQVwohc+fxrPlJbvRpNOiZmd+5IWJykm4aDSf0MxJdM
	UQO4DvuZLF8KUMlmlAb9SaWLZh1waJLcnj4LS3cZjKZGTvpWSMltxUyb8E4L4qXtkwiprucyNnT
	/vpatQoy+8uo5f1nkzl8+EJ3ZV0phH5m+QX3t3D2lhK4EjlqMQStLxrQz7p75fA==
X-Received: by 2002:adf:a38d:0:b0:33e:363b:a7dd with SMTP id l13-20020adfa38d000000b0033e363ba7ddmr15082wrb.20.1712675583931;
        Tue, 09 Apr 2024 08:13:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb8ZPjxsWkDhyi2NU8MmyXvCFHArbZX26HhmJMR7u5e7Og3LligTNm/tmP/d8EemeQYMnJIA==
X-Received: by 2002:adf:a38d:0:b0:33e:363b:a7dd with SMTP id l13-20020adfa38d000000b0033e363ba7ddmr15053wrb.20.1712675583458;
        Tue, 09 Apr 2024 08:13:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:be00:a285:bc76:307d:4eaa? (p200300cbc70abe00a285bc76307d4eaa.dip0.t-ipconnect.de. [2003:cb:c70a:be00:a285:bc76:307d:4eaa])
        by smtp.gmail.com with ESMTPSA id i11-20020adff30b000000b0034334af2957sm11694935wro.37.2024.04.09.08.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 08:13:03 -0700 (PDT)
Message-ID: <1776b49b-3c0e-41a7-bbc5-19310c428429@redhat.com>
Date: Tue, 9 Apr 2024 17:13:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/31] x86/resctrl: Move ctrlval string parsing policy
 away from the arch code
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 Rex Nie <rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-4-james.morse@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240321165106.31602-4-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>   /*
>    * Check whether MBA bandwidth percentage value is correct. The value is
>    * checked against the minimum and max bandwidth values specified by the
> @@ -59,8 +68,8 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
>   	return true;
>   }
>   
> -int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
> -	     struct rdt_domain *d)
> +static int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
> +		    struct rdt_domain *d)
>   {
>   	struct resctrl_staged_config *cfg;
>   	u32 closid = data->rdtgrp->closid;
> @@ -138,8 +147,8 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>    * Read one cache bit mask (hex). Check that it is valid for the current
>    * resource type.
>    */
> -int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
> -	      struct rdt_domain *d)
> +static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
> +		     struct rdt_domain *d)
>   {
>   	struct rdtgroup *rdtgrp = data->rdtgrp;
>   	struct resctrl_staged_config *cfg;
> @@ -195,6 +204,14 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
>   	return 0;
>   }
>   
> +static ctrlval_parser_t *get_parser(struct rdt_resource *res)
> +{
> +	if (res->fflags & RFTYPE_RES_CACHE)
> +		return &parse_cbm;
> +	else
> +		return &parse_bw;
> +}

Besides what Reinette said, I'd have added here something that would 
fire in case someone adds something unexpected in the future, like

WARN_ON_ONCE(!(res->fflags & (RFTYPE_RES_CACHE|RFTYPE_RES_MB));

At the beginning of the function.


Apart from that, nothing jumped at me.

-- 
Cheers,

David / dhildenb


