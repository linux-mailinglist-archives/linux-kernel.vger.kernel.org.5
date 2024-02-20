Return-Path: <linux-kernel+bounces-73374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB49D85C19B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF201C20A29
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6F476413;
	Tue, 20 Feb 2024 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEk0WWiB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AC47640E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708447499; cv=none; b=hZl+6PdxFYFA4jkNCb/QtoBxUicI+u8SXV2VqrO8GLCnxwkezJNRqTIe0hBnKAJMUWAi6LdYYnfR84INUUeSsIrMdrEbZ01GiD30hTZdqnRIIwwpI3o6VERWTqkeGiZmdQfjou4rvhiL/1GucEbizR1NW1pfrVJLR4RwDl2yxtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708447499; c=relaxed/simple;
	bh=CjH+6PgHWEOYqYXxllInAGxR2UMIFwwCpAknFU8MG5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vC7vzQwdOIXDyuE1q337+yKKyyJFHnVCA/lqm4JfiF5TxQ3hEWZbk9BtXezYuAkJMGj2qHjsGC9SQ5u5XQp3WU+iC+Mhx4sK1MK2Ud+BF5c1yrGKYfgY4YKeg3pDmDz3wv4kL2BI7KH75fHb1gzjPgHcDhwor9yHObQoXXfQfTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UEk0WWiB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708447496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=W0b9dFkQR2dCyovQiJIgphd8uee5rDy/BEugZxx0fbI=;
	b=UEk0WWiBCXfw4efcCc7FMcv/aCQ7qeEeG05QYi3dU+YkTh9qjiY5lJnPm+Qe6xp+fMHnpC
	W0UoLLVXWpbk3fCgn/xIQkZMzBc+W7agN30htcJgwFWExlt8wv90+aPPL0xsbx92Z3J39w
	3P9HmFE6kpiaGvXL+rpY218EbIB0ZaE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-SJYZ-yMnONSyN256_oY2qQ-1; Tue, 20 Feb 2024 11:44:53 -0500
X-MC-Unique: SJYZ-yMnONSyN256_oY2qQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4125670e7d1so15193065e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708447492; x=1709052292;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0b9dFkQR2dCyovQiJIgphd8uee5rDy/BEugZxx0fbI=;
        b=o8ilqokp5s+h/MYS/J6b4tistYvvUpfvMe0XPZXVkuyFg7xfm9Uazj4yEwpaUdzl7M
         mRAC3WpsZ+W5cz+GKTPfnessrqOLZfP6OvcQ3W+viCpkf1zPMfevYAyMXET6gv4YeXSM
         YUX4pX6MSj7gn3NVSy9/LeOxn70D7z81eSJaNq6ErvFSdtxIrzl+6zvAa5IiKqna6zbx
         jH/sSaYL6Ph4GXFH2lp9U0O1pOTnbjV/RpQerLKc43kRYuTF7iO0NqnPoC5knmdzD9bB
         vVbgDBOXp5AdhYYo/XLGf7iI9dLFacPVdXMCOTMavZu7b6Y4ZGubARrR5aqwmz/63sfr
         E0Zg==
X-Forwarded-Encrypted: i=1; AJvYcCX4wDD9511wVrZb4mUGH7cL/Ru17QMlpPH/am6t61PePHHGyRYGh2qR5iZ2k8NXHr+L/uFdsw5MAmMWF56PHv3G5MUxh+z6L6xElh2q
X-Gm-Message-State: AOJu0Yw/wzYpBRdwmlC6Gmj0EW/LMivlre/w+bdacSu1Vb/xYd/t6RLF
	vRdK1ES0ljEDL0YNnIeyrZiB/lL+ijT7B97vMQV480VoWJelKRYOvu7zkpDcEouz8mzgTiMCkb3
	pCkjcSiwEa/U58dSLvsVN/2bKvtbh/Ye+on/L5Pkd1abeeNJH/JPYu1QoieDSuw==
X-Received: by 2002:a05:600c:358b:b0:412:6e83:b89d with SMTP id p11-20020a05600c358b00b004126e83b89dmr2219968wmq.8.1708447492214;
        Tue, 20 Feb 2024 08:44:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEX8Q2qvsZbQW9Hxvoq538E7rm1JI6oSBlTgiATvrgebXfhsXYiJz+t7g2P/7h71aEOFftHtw==
X-Received: by 2002:a05:600c:358b:b0:412:6e83:b89d with SMTP id p11-20020a05600c358b00b004126e83b89dmr2219948wmq.8.1708447491824;
        Tue, 20 Feb 2024 08:44:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c72a:bc00:9a2d:8a48:ef51:96fb? (p200300cbc72abc009a2d8a48ef5196fb.dip0.t-ipconnect.de. [2003:cb:c72a:bc00:9a2d:8a48:ef51:96fb])
        by smtp.gmail.com with ESMTPSA id v16-20020a05600c471000b004126f8c68eesm2518805wmo.3.2024.02.20.08.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 08:44:51 -0800 (PST)
Message-ID: <b504ff21-4941-49e5-b1cb-3e5ed5177836@redhat.com>
Date: Tue, 20 Feb 2024 17:44:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/24] x86/resctrl: Use __set_bit()/__clear_bit()
 instead of open coding
Content-Language: en-US
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
 dfustini@baylibre.com, amitsinght@marvell.com
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240213184438.16675-10-james.morse@arm.com>
 <b5bc883a-8a8a-4f07-a6ff-b1bd02ffc99d@redhat.com>
 <91b58253-f682-49f7-914d-8faf1ce181ef@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <91b58253-f682-49f7-914d-8faf1ce181ef@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.02.24 17:27, James Morse wrote:
> Hi David,
> 
> On 20/02/2024 16:00, David Hildenbrand wrote:
>> On 13.02.24 19:44, James Morse wrote:
>>> The resctrl CLOSID allocator uses a single 32bit word to track which
>>> CLOSID are free. The setting and clearing of bits is open coded.
>>>
>>> Convert the existing open coded bit manipulations of closid_free_map
>>> to use __set_bit() and friends. These don't need to be atomic as this
>>> list is protected by the mutex.
> 
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index dcffd1c4a476..bc6e0f83c847 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -111,7 +111,7 @@ void rdt_staged_configs_clear(void)
>>>     * - Our choices on how to configure each resource become progressively more
>>>     *   limited as the number of resources grows.
>>>     */
>>
>> That comment talks about "free CLOSIDs in a single integer". Once could think about
>> rephrasing that to "free CLOSIDs in a simple bitmap."
>>
>>> -static int closid_free_map;
>>> +static unsigned long closid_free_map;
>>>    static int closid_free_map_len;
>>>      int closids_supported(void)
>>> @@ -130,8 +130,8 @@ static void closid_init(void)
>>>          closid_free_map = BIT_MASK(rdt_min_closid) - 1;
>>
>> Now that we use "unsigned long", I was wondering for a second if we should use "proper"
>> bitmap functions here like
>>
>>      bitmap_fill(closid_free_map, rdt_min_closid);
>>
>> and converting the alloc path (replace ffs() in closid_alloc()):
>>
>>      closid = find_first_bit(closid_free_map, closid_free_map_len);
>>      if (closid == closid_free_map_len)
>>          return -ENOSPC;
>>      __clear_bit(closid, &closid_free_map);
>>
>> (would get rid of the closid-- in closid_alloc())
> 
> Yup. I have this as something to post after all the MPAM changes as it's not necessary to
> get MPAM going. The patch[0] uses the bitmap APIs you suggest to remove the fixed limit on
> the number of CLOSID/PARTID.
> MPAM systems are being built with more than 32, but will work without that patch.

Make sense, thanks!

-- 
Cheers,

David / dhildenb


