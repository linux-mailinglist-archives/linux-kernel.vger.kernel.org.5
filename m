Return-Path: <linux-kernel+bounces-4606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0953C817FDD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BFE8B2375E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A488E6D3F;
	Tue, 19 Dec 2023 02:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Bq5G6vTX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A35A4C8A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 02:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42778277d9aso846211cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 18:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702953282; x=1703558082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9QkIhhrk9atF5NzOy+uO1AzHmVd/CKbg5xM+XgezA8=;
        b=Bq5G6vTX7AycPA46eJnEM4NUP/4HEhiaK6kq19V/+8BxJido1YAqNmCyZKiX6mli7r
         QOQmIINFqvmqZ3ZtnyBJd3mwQkZ1cXkUIrvepJ+ElL6N0PoQQe03PhIpSZMUH1IVJoAr
         LkgSGriQkYrOat2c5yhYFNCbjW6SOi2EYcR6Ke0ZMCRZQ1SU3itAoGnA5AShqi4TFo+i
         MfwXxhc0w5YYsKFApu9chd6c4ZhUK4I8NHhfUqlvgPWtoramXoY2eBN80WRaLi0MNS4O
         UJxtBK7hRatrzvTTPeItWCKT1nqnWkbb2Rkgtmq8V/V3Mn83lGq9ptutCbNDc6CMvlOb
         11rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702953282; x=1703558082;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D9QkIhhrk9atF5NzOy+uO1AzHmVd/CKbg5xM+XgezA8=;
        b=gEGz//7374XMu5AgUWnJNBYtYdwtsIxniXqU34E3MqUm4IXqvy09N0e9wJOcUzVZ6Q
         JgZN0jlUz5o4Z6K4nuw+uI1ixAOpTQ5R9tndN9R8ceoH5Gz0B0BmIaxiYqxfuqNj0OGx
         Kygz7qvt7OELnwcpkdp5y4eBfGOnF3HaYVSQn71mgS3/BtD4I+kIOiayclyYQ3r+y8UE
         EQCxtYY1MlglP3+QWGVh8u+9+nXMwynUaXxIj73BxJ71uG67+W4WH0xgRI4XQeA8N4V2
         EX6bv5ndxh1gOx0wjQCerJTO4Bgp99VMJCnBPMMyaUOlNchnMYJVaxtOC8ZZ4Bv5G+Qm
         D04Q==
X-Gm-Message-State: AOJu0YwHFRhobQDnXLCjdHYYDaWsQz3vCKGFznVyrIm8OBChrZq9MJ0a
	vFHBXGeOpOUss3fptRr8XMM1ZQ==
X-Google-Smtp-Source: AGHT+IHsFgkgz+k2eXh+Ho5A/KHaCd16u7/K+YstrOpkAJ59a8FRHMBI1Q/QtcqiaOOXoo/87BlMaw==
X-Received: by 2002:ac8:5790:0:b0:425:8637:f81a with SMTP id v16-20020ac85790000000b004258637f81amr22848990qta.71.1702953282222;
        Mon, 18 Dec 2023 18:34:42 -0800 (PST)
Received: from [10.84.146.214] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id qc12-20020a17090b288c00b0028b6f522fedsm252431pjb.43.2023.12.18.18.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 18:34:41 -0800 (PST)
Message-ID: <00ffc2e3-446b-473e-89b9-a859f36e43dd@bytedance.com>
Date: Tue, 19 Dec 2023 10:34:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] maple_tree: Avoid checking other gaps after getting the
 largest gap
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20231215074632.82045-1-zhangpeng.00@bytedance.com>
 <20231218202014.mpotsekdkszasn4t@revolver>
 <20231218202845.buffbdq3vhpiv2py@revolver>
Cc: maple-tree@lists.infradead.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Peng Zhang <zhangpeng.00@bytedance.com>
From: Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20231218202845.buffbdq3vhpiv2py@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/12/19 04:28, Liam R. Howlett 写道:
> * Liam R. Howlett <Liam.Howlett@Oracle.com> [231218 15:20]:
>> * Peng Zhang <zhangpeng.00@bytedance.com> [231215 02:46]:
>>> The last range stored in maple tree is typically quite large. By
>>> checking if it exceeds the sum of the remaining ranges in that node, it
>>> is possible to avoid checking all other gaps.
>>>
>>> Running the maple tree test suite in user mode almost always results in
>>> a near 100% hit rate for this optimization.
>>
>> This should only be triggered for right-most nodes and root though,
>> correct (mas->max  == ULONG_MAX from just before this)?
Yes, only for right-most nodes and root.
>>
>> I wonder if it's worth special case checking the first gap if the node
>> min is 0 as well.  Might be worth looking at, but this patch is
>> certainly worth doing.
> 
> Actually, not just when the min is 0, we have a special case close to
> here for slot 0 so we could just check the same sort of thing there.
I think that the first slot in a node does not have any special
significance. It has a lower probability of being the largest gap,
so it may not be worth considering.
> 
>>
>>>
>>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>>
>> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>>
>>> ---
>>>   lib/maple_tree.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>>> index c9a970ea20dd..6f241bb38799 100644
>>> --- a/lib/maple_tree.c
>>> +++ b/lib/maple_tree.c
>>> @@ -1518,6 +1518,9 @@ static unsigned long mas_leaf_max_gap(struct ma_state *mas)
>>>   		gap = ULONG_MAX - pivots[max_piv];
>>>   		if (gap > max_gap)
>>>   			max_gap = gap;
>>> +
>>> +		if (max_gap > pivots[max_piv] - mas->min)
>>> +			return max_gap;
>>>   	}
>>>   
>>>   	for (; i <= max_piv; i++) {
>>> -- 
>>> 2.20.1
>>>
> 

