Return-Path: <linux-kernel+bounces-108995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1AA881320
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF49A1C22A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258D044371;
	Wed, 20 Mar 2024 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRbn/q83"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B710E3D54C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944032; cv=none; b=c8od6RejfCb76z2qwJpnw6otkPIm/pkl8oOf4i1OMzuAm9XQIl0n9HhsKpAHd/CpBNZHhyw0sqJCPcb+PqHQ9loENIoRRH1YhBZit2Jkp9s5Qyv+DjxKR2eEGKRdkLU4HDIQlMnRnK7S2MKBGUtdWRa4pWIi3fZst6S+6slhiKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944032; c=relaxed/simple;
	bh=J9hjvDCN4WzlGYmX6kl6Iw741PMgYH0/6A6sf+t9ias=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3CVzjq+5pIJeu1msKT6jdembxbZy34RmTZMCTnOkYsrJmvZZ2VMCgcLktTs0tQNF7y2y++XLyEP1U1N31mHQt5wdElYWNV1UDdML2/VVuy/ErfEGN/CRPG+qkCTtGn9LuWgNuax68nv5+6xOvHEBHSGq6dBQm4KWXDf1o2UMa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NRbn/q83; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710944029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SWFh6+NY0TCHwmjI+olVuTfenQq3vt0jGsa5LqXaGxU=;
	b=NRbn/q83gZcvQogAqkYqSvki2sL09fqj6iv+kXY/iFxyS2EAbaU3WAdTXukD/sVYCyk1If
	atvkYxCjrzPrWsrtaDGqkaSG1vGSx9YPp5kSmk4j+lu0LStNmIs+b9RqBZKqr6g8xBuwG9
	fGkQKEZA15mLYXUPnIgNragJmKrbymA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-WTdAu9QMOgmNitqCmEEt2A-1; Wed, 20 Mar 2024 10:13:43 -0400
X-MC-Unique: WTdAu9QMOgmNitqCmEEt2A-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d599dba7fbso22096521fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 07:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710944021; x=1711548821;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWFh6+NY0TCHwmjI+olVuTfenQq3vt0jGsa5LqXaGxU=;
        b=oQk+2jZyXCd9h4Z4mKrXmK8QOHfzIhJoieBBrbO19KOqxNOkC5ttTF672ckbz52YvB
         rBZ/DtKBnxW2wwYCcUxhYDu5Ikju5JFeEB0KCK7NggDIHIF24c6mO8FmPqCNtVuXMsDh
         sUQDBBF5s/nIoutInkL86vd5YJ7EzN7idEC0UcmMjHcBlhDmO7x3StOqUD4pPr0I2ikv
         eCznGRZD9MwEX7O7K2+R1fZFpt/RKiEb1IsGBiSBNOL8/hjnxDOpPl0augiT7icq6004
         VbGhZM4ToVx/46CmRQixXdRX3vrPeKDjhCLEH/7zSkEgeg9Crb0mCpAhvoUO50VZth31
         x7hA==
X-Forwarded-Encrypted: i=1; AJvYcCXkObT0qz72i7pizTcwdxwWSu+CXLFZOaIY0I3uKi8rLFpaBSyYWtnAsAiMav6nNGXJ8L2geTqzch82i1RM0XJ+AzNPib3iXNtNEqtt
X-Gm-Message-State: AOJu0Yzv0ofGDhn3CDV5xHVtnLZtAP7gi01jrF8gZH+FZ99jZLOyH80x
	4/B1zlqGLTvXHZcqvsg5ZI5Dyb2b32rVGb7JlJjPUDqzUej01YC6u5NL8x00CtcRSf46IzlUROI
	1psZEEgowoOAWzmGd179nrmO3R7w3aS5XucheTj8kd1/3NHZPSdTuaIUkf9bM/A==
X-Received: by 2002:a2e:9acd:0:b0:2d4:2bee:e550 with SMTP id p13-20020a2e9acd000000b002d42beee550mr11356983ljj.28.1710944021426;
        Wed, 20 Mar 2024 07:13:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxlPNAYGknobF2IlWpXtE6yUiPMvMQJQu6vzfkeiQqwiYMWWRflPDRUeUG3IGwwFkeczVWjA==
X-Received: by 2002:a2e:9acd:0:b0:2d4:2bee:e550 with SMTP id p13-20020a2e9acd000000b002d42beee550mr11356970ljj.28.1710944020965;
        Wed, 20 Mar 2024 07:13:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:c400:9a2:3872:9372:fbc? (p200300cbc709c40009a2387293720fbc.dip0.t-ipconnect.de. [2003:cb:c709:c400:9a2:3872:9372:fbc])
        by smtp.gmail.com with ESMTPSA id g13-20020a05600c4ecd00b0041468c50ca2sm2361629wmq.36.2024.03.20.07.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 07:13:40 -0700 (PDT)
Message-ID: <f4ddda40-0ee5-4c0e-9487-c58914d79180@redhat.com>
Date: Wed, 20 Mar 2024 15:13:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] mm: swap: free_swap_and_cache_nr() as batched
 free_swap_and_cache()
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-3-ryan.roberts@arm.com>
 <42ae8cdf-2352-4bb9-9b22-aed92a2c9930@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <42ae8cdf-2352-4bb9-9b22-aed92a2c9930@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.03.24 12:10, Ryan Roberts wrote:
> Hi David,

I'm usually lazy with review during the merge window :P

> 
> I hate to chase, but since you provided feedback on a couple of the other
> patches in the series, I wondered if you missed this one? It's the one that does
> the batching of free_swap_and_cache(), which you suggested in order to prevent
> needlessly taking folio locks and refs.
> 
> If you have any feedback, it would be appreciated, otherwise I'm planning to
> repost as-is next week (nobody else has posted comments against this patch
> either) as part of the updated series.

On my TODO list!

-- 
Cheers,

David / dhildenb


