Return-Path: <linux-kernel+bounces-137181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D50889DE2C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E972C1F2B609
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0956F136986;
	Tue,  9 Apr 2024 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFdZheS3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A8913667A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675171; cv=none; b=LieXqrJ2qWGPqj7Gm2ghN1faoXKzha/Z2eMnR3wkGYfpG7TuSaciipALvJeKC3IWRcACoUQdApznsFH6TqC9FY+lngpeVXjXdJ8SyXMT69e0eC5gTjJT65WKBO8qUKS930BjO+uajcxnBOM4rtJsH1v86oFPi5OdobeZ468W3ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675171; c=relaxed/simple;
	bh=Rp/1ZCAfH5EecZBSkTFZvOyJWMwuFdCkMGwrr4Dvcis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVXWTezGC2lLKVykD7X+jrMwjMd0ArfL82/AvDH0FBso4Xsp1Z0g3TB2ouDteGQi+1e2tsPrFEBJEHwqB+6RQXjIn4T8zpReLd1MZWRxbeaYLHaKMmb/qmNNotmmznFPoC61YOLu796c3vLt4+YQi8irHffXCHiO4Y748NpchVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFdZheS3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712675168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z0A3orY9Fr7ZsIhzJ/Pi6emHyuKP07s0iN1UUfgLSzU=;
	b=AFdZheS3WuTBoHiQtNMFYoi7ftRlAmExg3mtmSoHHW3g9Vz2bRrjnAIb6FfTs0aJKgPWcj
	mth1A26zGgE/NyZxHSRFRaPBzqSY+rQm2beQRAXFt8WQ0qzX6T51rfPyr9nf79yGsFFRF/
	zk0CqcVgCH28rS7IkcF7vpgYqC/ZIQg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-tNdc0nHeO7a9O4AqnGZv9A-1; Tue, 09 Apr 2024 11:06:06 -0400
X-MC-Unique: tNdc0nHeO7a9O4AqnGZv9A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343d02b62ddso3037435f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712675165; x=1713279965;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z0A3orY9Fr7ZsIhzJ/Pi6emHyuKP07s0iN1UUfgLSzU=;
        b=P/iTPiCt3unFBq76vkGWyAoFr3jgDBCzzeeIkeBaMZqd75Y5rZohUS2/uJ3LdmfPKx
         xLXG0NcJuOR9NZoSsQagpvnssp+AQ8F6JihXZ/HnEASog/NMLBceVhqZZ5MSgBtA9zwL
         vzQnjhE4lEW6bmAi4J9qlP5z5zrxiwmTSHwgYT1xfROu30+7pp0ndWnrdgsZq0ZfwGr+
         +Kz35bRX27eZ2hrE0sjGUINtFsXtx7oGcxYZcOPrR+aVPAIBoFkvprY+cM956OeHbkBt
         Syc2SS/CxsCErrJFAjJplvW8IruMGOuHRZabUbxtMN5KE4pXxlMVzKipL4euLKbVm7mZ
         uMpA==
X-Forwarded-Encrypted: i=1; AJvYcCUrk8GXdc6tn4BLY7Y0IdQ+NascutTk+WHL21LnZLawNR+kCIxkBGEKcwyBtx7tPAEnbKMn964Ve8J+jUYUG3SmIuNYbDs4/zo3XDVL
X-Gm-Message-State: AOJu0Yw2sR5n/q0odnqf88bJHG7+zMjKweYkOjBTk7N+UUUBn4iFLNuS
	Eni1/ceXJ95HAUre4qnN/x+0I6FiuBQglVpOIPRbBiqeRzFt3aLcNswStw0psetmCu/ymmLe1DV
	65pkmc0fxE03bpZiFl/6zNrSToWKXDH24zEn/ZwyuKdrenwB4VZ8/rn9w9fed0y2Ub7hTAg==
X-Received: by 2002:adf:efd1:0:b0:343:9293:7542 with SMTP id i17-20020adfefd1000000b0034392937542mr7488854wrp.45.1712675165654;
        Tue, 09 Apr 2024 08:06:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMOrILadEEH07ACcQnOfd3tfPeGAGxJUIUOzpD1JfUp/6YInfzVXvs9annYmWtsF068i/U3w==
X-Received: by 2002:adf:efd1:0:b0:343:9293:7542 with SMTP id i17-20020adfefd1000000b0034392937542mr7488834wrp.45.1712675165247;
        Tue, 09 Apr 2024 08:06:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:be00:a285:bc76:307d:4eaa? (p200300cbc70abe00a285bc76307d4eaa.dip0.t-ipconnect.de. [2003:cb:c70a:be00:a285:bc76:307d:4eaa])
        by smtp.gmail.com with ESMTPSA id z15-20020a5d4c8f000000b00343daeddcb2sm11764677wrs.45.2024.04.09.08.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 08:06:04 -0700 (PDT)
Message-ID: <735f18df-0f63-44ba-adfc-70ead9ce9495@redhat.com>
Date: Tue, 9 Apr 2024 17:06:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/31] x86/resctrl: Fix allocation of cleanest CLOSID
 on platforms with no monitors
To: Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 Rex Nie <rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-2-james.morse@arm.com>
 <1e19965c-51f2-4f7a-8d29-e40f4e54a72c@redhat.com>
 <8d1d39ca-60f0-47e9-a090-f630c6df19ae@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8d1d39ca-60f0-47e9-a090-f630c6df19ae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.04.24 17:02, Reinette Chatre wrote:
> Hi David,
> 

Hi,

> (Thank you very much for taking a look at these)

I'm planning on reviewing more; as most of resctrl is code I haven't 
really read before, I'm not able to make progress as fast as I normally 
would in core-MM ... :)

> 
> On 4/9/2024 1:05 AM, David Hildenbrand wrote:
>> On 21.03.24 17:50, James Morse wrote:
>>> commit 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by
>>> searching closid_num_dirty_rmid") added a Kconfig option that causes
>>> resctrl to search for the CLOSID with the fewest dirty cache lines when
>>> creating a new control group. This depends on the values read from the
>>> llc_occupancy counters.
>>>
>>> This support missed that some platforms may not have these counters.
>>> This causes a NULL pointer dereference when creating a new control
>>> group as the array was not allocated by dom_data_init().
>>>
>>> As this feature isn't necessary on platforms that don't have cache
>>> occupancy monitors, add this to the check that occurs when a new
>>> control group is allocated.
>>>
>>> The existing code is not selected by any upstream platform, it makes
>>> no sense to backport this patch to stable.
>>>
>>
>> It's weird to not see RESCTRL_RMID_DEPENDS_ON_CLOSID appear in any Kconfig file.
>> I guess it will all make sense once the refactoring is done :)
> 
> This is done later in this series where patch #29, "fs/resctrl: Add boiler
> plate for external resctrl code", introduces it to fs/resctrl/Kconfig.

Oh, already in this series, great!

-- 
Cheers,

David / dhildenb


