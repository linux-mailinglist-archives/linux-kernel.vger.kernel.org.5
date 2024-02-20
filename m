Return-Path: <linux-kernel+bounces-72277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501B285B187
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BE1281E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F07B47F4B;
	Tue, 20 Feb 2024 03:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XEH3dvn2"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA41B4C610
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708400400; cv=none; b=uPEQBmXhF1y/vsB4Azn0IxEKEhRchLUrlLKG4WJ+WZRt8nHm58Rdnx8vTPp+JK8nOnK2ozYYwgaK8Y1tZleh92vJ+wxVESlbDLSEwQdrcguyw1DRv1d6aVLqRzxU2FgHP19+Xvsv/mrGOd/N0k1pVF+/SMhUns50lH5pXlDtQhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708400400; c=relaxed/simple;
	bh=yOKGA8wab/Ee/bmU7v/Q9RlZRsEjbjN+OuIsJAHhMJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBcna4n+mjV35jxuPg7mc9T4daX/01mMJZ24UlrtVwlcXhr++vBeEDosUyZOcV5QzkFLBuGJqDsoYklGKyyql4uHDlxL3fLA2zckBh7P3HYVUiX5U89te2pFIHoTkLcIEuuMbdCL7Ie1TLmZOHo9hsh6JLoAnOwufdIdFrIkLNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XEH3dvn2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc139ed11fso2499455ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708400398; x=1709005198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=61gdFIOyAEtp7pfCHFQh+Fc/gqgVzNiO4CpvePAyVXw=;
        b=XEH3dvn2pyH9j/S3WIMYsYramXGUDwDF4/ForYALcYwrSi0DYKi8Dozn295l+a5kSV
         KoUAKCInuykmN2GPY52KsUuChoSUVXkZWWxu5Fst6ZjddOCAsu0wGLO6xdmOA20XbFnN
         0//gzBxGoK1UfGUADANBy6oWYdcb9jxjNxw7OWJdjK3UtFSNSoVrqm4waiEsoK1FzQir
         DzqbeX1mfm3riJuiYsfy9+8SReLlo03OpB2xfk2WfeIvQJu2lC7ydhZxX2wz4pJQjL4c
         xs1K288WRBMA59YBGqsiB/aQWp0hIMEG0vsHYPhoIXEKWHiO1zDa91U+hpj6HiqpsHqk
         ljnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708400398; x=1709005198;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=61gdFIOyAEtp7pfCHFQh+Fc/gqgVzNiO4CpvePAyVXw=;
        b=fQRyAStMJYIdr+MVHghpE8WWbj0KPMNwmZaCisF5LFL/yEYbXSD82bmlxvfgZiQkiN
         VszOAOLNZUaDZs3y348w9Chf6wRBfoRxmLTAdFC9+aCo9Lt8IqI6GWqxjlRPIlqMRACi
         cNqUH3sMhslD673ECEv4lpOpaliPFIZBLofb+T45tKSysfihnBi/AxnLkbmmrO9OMpqq
         k3KLuzu7J24+ykbSU72SgME0YCTZhJg5iL19nxKiDnYrDjXGoRdLEGjKPw7x7xMfYkgP
         2cihjbfXb4FzjKQOTBXWnYsII8luaRfwKzrLsQ4jr2Jpf/kmO0Ua/iW+vYaebNevZ/Rb
         L9wA==
X-Forwarded-Encrypted: i=1; AJvYcCWPmCUsO+wEN5JHE2IIPnN5LPPm5uJOwMNRCWdVRML/C6TepZjosxwYvo2wvUkejfaqJlOfXzHbJn28rdx1NO/r0CSIno7yo1RP1ImP
X-Gm-Message-State: AOJu0YyxM+6JW0CFZ+hLI72qDEjOJ8D3YCGdvXxXvq2dg+TH754FZtXA
	Hiq26QKpVCqZzWebXZ9Z+oSsVjhtIgIBkgQP7wnSICK6Z3wrQUdVFPKIU0sIbcc=
X-Google-Smtp-Source: AGHT+IE2sqpkSGfsSyNt6OWk0KJ2ruc4yfEQBvhsEdatEOo2TxXHxnvqxWaQkQEoRQvOPY4CQbPr4A==
X-Received: by 2002:a17:903:24f:b0:1d9:4106:b8b5 with SMTP id j15-20020a170903024f00b001d94106b8b5mr17488773plh.11.1708400398198;
        Mon, 19 Feb 2024 19:39:58 -0800 (PST)
Received: from [10.254.101.216] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id jx3-20020a170903138300b001d752c4f36asm5153333plb.78.2024.02.19.19.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 19:39:57 -0800 (PST)
Message-ID: <d99989d0-e2d6-490a-8f60-c08b98b12896@bytedance.com>
Date: Tue, 20 Feb 2024 11:39:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: Re: [linus:master] [sched/eevdf] 2227a957e1:
 BUG:kernel_NULL_pointer_dereference,address
Content-Language: en-US
To: Chen Yu <yu.c.chen@intel.com>
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
 kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, aubrey.li@linux.intel.com,
 Honglei Wang <wanghonglei@didichuxing.com>, Aaron Lu <aaron.lu@intel.com>
References: <202401301012.2ed95df0-oliver.sang@intel.com>
 <23cbb613-c8a2-4f07-b83b-fa3104bef642@bytedance.com>
 <8b21e697-c9b9-49aa-a7ad-e88a5d7f9c92@antgroup.com>
 <5f8f4222-a706-45b1-8eb2-fd4553cc57d8@bytedance.com>
 <ZdNLCYnJzPM2Ih2j@chenyu5-mobl2>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <ZdNLCYnJzPM2Ih2j@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Chen,

On 2/19/24 8:35 PM, Chen Yu Wrote:
> On 2024-01-31 at 20:28:19 +0800, Abel Wu wrote:
>> On 1/31/24 8:10 PM, Tiwei Bie Wrote:
>>> On 1/30/24 6:13 PM, Abel Wu wrote:
>>>> On 1/30/24 3:24 PM, kernel test robot Wrote:
>>>>>
>>>>> [  512.079810][ T8305] BUG: kernel NULL pointer dereference, address: 0000002c
>>>>> [  512.080897][ T8305] #PF: supervisor read access in kernel mode
>>>>> [  512.081636][ T8305] #PF: error_code(0x0000) - not-present page
>>>>> [  512.082337][ T8305] *pde = 00000000
>>>>> [  512.082829][ T8305] Oops: 0000 [#1] PREEMPT SMP
>>>>> [  512.083407][ T8305] CPU: 1 PID: 8305 Comm: watchdog Tainted: G        W        N 6.7.0-rc1-00006-g2227a957e1d5 #1 819e6d1a8b887f5f97adb4aed77d98b15504c836
>>>>> [  512.084986][ T8305] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>>>>> [ 512.086203][ T8305] EIP: set_next_entity (fair.c:?)
>>>>
>>>> There was actually a NULL-test in pick_eevdf() before this commit,
>>>> but I removed it by intent as I found it impossible to be NULL after
>>>> examining 'all' the cases.
>>>>
>>>> Also cc Tiwei who once proposed to add this check back.
>>>> https://lore.kernel.org/all/20231208112100.18141-1-tiwei.btw@antgroup.com/
>>>
>>> Thanks for cc'ing me. That's the case I worried about and why I thought
>>> it might be worthwhile to add the sanity check back. I just sent out a
>>> new version of the above patch with updated commit log and error message.
>>
>> I assuming the real problem is why it *can* be NULL at first place.
>> IMHO the NULL check with a fallback selection doesn't solve this, but
>> it indeed avoids kernel panic which is absolutely important.
> 
> I tried to reproduce this issue locally but with no luck. It might

Me either, with a x86 machine. Staring at the dmesg provided by Oliver,
I guess the bug is arch-specific.

> be related to lkp's environment so I'm thinking of adding the following
> change into lkp's test repo to help narrow down: when the pick_eevdf() finds
> an NULL candidate, print the whole rb-tree, including each entity's vruntime,
> min_vruntime, deadline, etc. So we can figure out why we failed to find a proper
> entity, thoughts?

It helps, but not in all ways IMHO. There might be someone else manipulating
the rbtree under improper locking, and if it is the case, the time of debug
could be late.


