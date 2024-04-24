Return-Path: <linux-kernel+bounces-157150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F30D98B0D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49DD28D11B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEA615EFCC;
	Wed, 24 Apr 2024 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JV/gmdrH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1E615ECF2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970809; cv=none; b=O1h/tHxrL1qB0pV2t2QD60kdkxXQX4ywwnXkLh1Lq8nhhRQC++mpBW8NmUv8r37tMKvrpEtcO1UHs7HD7QRSoh4M70xBWCInKO4dVViESGXgj8ClNRIYbJnGiws2VsOh1nPCQ98pjgseAjwkX0RztHOYGS10vUY5rjMnG0NBiHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970809; c=relaxed/simple;
	bh=HbeLFgYMbY3fvLwSSHVsTyw/vxvbrbgTYsDGY2uu+NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrIpMa5j6yfycj276OBPWn9XixM5xx0fcq0IuuyKZVcqVn7sIp8I7YWlQ2LBswvhY1LD3sLggV8uhyMnoPn0CPzEvH5jYJDk9u3fNhf2Cx9AR9YLmIwO17fazrGxyd5FGzXpqUGITofp4l0VCjURaKcIAOoENWc2tmdjL8CHemQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JV/gmdrH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713970807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AACVR4+VD5pqjzSTVkZFPhaGQO2PX5f9ps+iv0GpKB8=;
	b=JV/gmdrHcxCAcqg3wBZl3pwE3pWIVEMBlbmmvaFCAIrDDFG4VHic+vl6PoexryFt+XN7l0
	hhqShLdcJkpcsOL1koLMjOUwi/NhCSvjXQ7EiQ8SoiN5OUZYnh/zvyFNdLCSbyCRQkwhoH
	GqR8h3BI/W2kTWmKnKkcwgZ5/mCtln4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-Vttmp6F0NjKiitHNMM-w1w-1; Wed, 24 Apr 2024 11:00:05 -0400
X-MC-Unique: Vttmp6F0NjKiitHNMM-w1w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-349cafdc8f0so4229488f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713970804; x=1714575604;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AACVR4+VD5pqjzSTVkZFPhaGQO2PX5f9ps+iv0GpKB8=;
        b=D6c/h++Z+jQqtH+UfDUksyri9FLXuLL7VyFBb/fZX/a6AKDfcLPNq3u9JjA7xUWdrp
         Ja7Ed4toqLTeCQCvfPM4Yrz729BdNXP+ZIJdOqtnOkfs2kWeuir2+uGIBo/fxeIYf061
         x/7Elx0a27r7sEgIu+I6OkLUjAkGErNDkzEiNH8SPwKRDZ5Ev2wTnRSI5dW51Sj35d0i
         sQZXEV+jAh/cxhLx9CNNLxtB+BPK+1yu1fbztv+hHUSlptvEeMGW1zeB0ltKUBO3kTuf
         8E+8CFpEFfX1BxaBndPd8cZQ1g47lEWbYPkvf7nQZFRNjh/8d+rx7uF6MUIU0UNdaMr/
         Sgaw==
X-Forwarded-Encrypted: i=1; AJvYcCXcGTIG2Wh9ud3JouQJrGKAwkOcnph2DIX6HZaUNrcJjIP4SiOR/mM3g4pTBkfYH72lkRzn4IrRhuL+rW8/aNzxFn+MrKqxcbQOF2Qj
X-Gm-Message-State: AOJu0YyJvFVLy9ueEobGsk2t+bVj85Vld5fubaMJpY/4eY4+Tkf7qxtS
	zVgTrUUnFyNMG/6D90qOBJfN/15Kv0O4GEGJ/iZq72Es1jw0w9uMLoVyCJbrLm60+EMXfA0U9Or
	4c9fNGLNtqWsolfaI7gvjHMS5OqhMcWwRjMkg8dF3yz6MWKoeKWOKwkTkN6oFCg==
X-Received: by 2002:adf:e2cc:0:b0:346:e590:1a0f with SMTP id d12-20020adfe2cc000000b00346e5901a0fmr1914840wrj.61.1713970803788;
        Wed, 24 Apr 2024 08:00:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPKgIoWIxrYChI5nqX2vCG5MKtJZib53GnlMqLycfcYc0tqWCZ/sazzmgkcaCf5twfUB31jQ==
X-Received: by 2002:adf:e2cc:0:b0:346:e590:1a0f with SMTP id d12-20020adfe2cc000000b00346e5901a0fmr1914818wrj.61.1713970803328;
        Wed, 24 Apr 2024 08:00:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:1f00:7a4e:8f21:98db:baef? (p200300cbc70d1f007a4e8f2198dbbaef.dip0.t-ipconnect.de. [2003:cb:c70d:1f00:7a4e:8f21:98db:baef])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d6912000000b0034997769ae4sm17386642wru.15.2024.04.24.08.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 08:00:02 -0700 (PDT)
Message-ID: <ab18a4b1-bcbf-4417-b43a-5feae3b5ba66@redhat.com>
Date: Wed, 24 Apr 2024 17:00:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm: introduce per-order mTHP split counters
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: 21cnbao@gmail.com, ryan.roberts@arm.com, baolin.wang@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240424135148.30422-1-ioworker0@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240424135148.30422-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.04.24 15:51, Lance Yang wrote:
> Hi all,
> 
> At present, the split counters in THP statistics no longer include
> PTE-mapped mTHP. Therefore, we want to introduce per-order mTHP split
> counters to monitor the frequency of mTHP splits. This will assist
> developers in better analyzing and optimizing system performance.
> 
> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
>          split_page
>          split_page_failed
>          deferred_split_page
> 
> Thanks,
> Lance
> ---
> 
> Lance Yang (2):
>   mm: add per-order mTHP split counters
>   mm: add docs for per-order mTHP split counters
> 
>   Documentation/admin-guide/mm/transhuge.rst | 16 ----------------

We really have to start documenting these, and what the sementics are.

E.g., is split_page_failed contained in split_page? Is 
deferred_split_page contained in split_page?

But also: just don't call it "split_page". Drop the "_page".

split
split_failed
split_deferred

?

-- 
Cheers,

David / dhildenb


