Return-Path: <linux-kernel+bounces-5751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B9A818F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2A528492B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1270038F82;
	Tue, 19 Dec 2023 17:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="BMf+Ql/c"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB7D37D22;
	Tue, 19 Dec 2023 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id FeJbrhqYW2UQhFeJbrRRBY; Tue, 19 Dec 2023 18:55:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1703008540;
	bh=rTD6xzBqwx9cf0sR+icSknwqdpHbRxYA35sj8sLWN/I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BMf+Ql/cyX4tDJ4LZbGkJap+tCfXfDvEvc3RQ8uz68KTvJnH9lCg3hsyFeRlGmwSQ
	 JVgHkEMt0lbUA1jo5hf1NUZRVQD2f0iBAJKXas9sXQCNUqJKDCfs6h7dIPgyiqmJz/
	 Wwn2eBNgv79fs7/nDxpmWwo4gsVELvSp2RE+Y13c23tEtEajRa5t2iM1I3p6srdSF0
	 0L38m4w3j2lip87ReGvLEAWdCHcYZ5CMq4SnHRlS7eYFZdPv8ABhzh2/5l/99m6YFG
	 h7/7mwn36onmPz5MrlIn+jCKpCvqOZkT/BIFk8Si+l7Z7H56g4thbXjZaORjHTG0k3
	 sk9yGnX+zm4eg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Dec 2023 18:55:40 +0100
X-ME-IP: 92.140.202.140
Message-ID: <6eccd268-9042-4887-9131-b5932c72b6c4@wanadoo.fr>
Date: Tue, 19 Dec 2023 18:55:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/callthunks: Fix some potential string truncation in
 callthunks_debugfs_init()
To: Sohil Mehta <sohil.mehta@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <8c2b24df3c077e55b2a4d91a7ffd08fa48e28d0a.1702803679.git.christophe.jaillet@wanadoo.fr>
 <4d4e488d-45d6-4496-b165-c349c67d4f11@intel.com>
Content-Language: fr, en-US
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <4d4e488d-45d6-4496-b165-c349c67d4f11@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 19/12/2023 à 12:02, Sohil Mehta a écrit :
> On 12/17/2023 2:31 PM, Christophe JAILLET wrote:
>> When compiled with W=1, we get:
>>    arch/x86/kernel/callthunks.c: In function ‘callthunks_debugfs_init’:
>>    arch/x86/kernel/callthunks.c:394:35: error: ‘%lu’ directive writing between 1 and 10 bytes into a region of size 7 [-Werror=format-overflow=]
>>      394 |                 sprintf(name, "cpu%lu", cpu);
>>          |                                   ^~~
>>    arch/x86/kernel/callthunks.c:394:31: note: directive argument in the range [0, 4294967294]
>>      394 |                 sprintf(name, "cpu%lu", cpu);
>>          |                               ^~~~~~~~
>>    arch/x86/kernel/callthunks.c:394:17: note: ‘sprintf’ output between 5 and 14 bytes into a destination of size 10
>>      394 |                 sprintf(name, "cpu%lu", cpu);
>>          |
>>
>> So, give some more space to 'name' to silence the warning.
> 
> It might be useful to specify that "some more space" hasn't been
> arbitrarily decided. It took me a few minutes to figure that out.
> 
> With the max cpu number being 4294967294 with 10 characters, a total of
> 14 chars would be enough to print "cpu%lu".

 From my POV, it is what the gcc warning already says, but I (or anyone 
else) can tweak the wording to make it more explicit.

Let me know if you want a v2.

CJ

> 
> 
>> (and fix the issue should a lucky one have a config with so many
>> CPU!)
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   arch/x86/kernel/callthunks.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> Apart from that, please feel free to add:
> 
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> 
>> diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
>> index cf7e5be1b844..26182a7d12b3 100644
>> --- a/arch/x86/kernel/callthunks.c
>> +++ b/arch/x86/kernel/callthunks.c
>> @@ -388,7 +388,7 @@ static int __init callthunks_debugfs_init(void)
>>   	dir = debugfs_create_dir("callthunks", NULL);
>>   	for_each_possible_cpu(cpu) {
>>   		void *arg = (void *)cpu;
>> -		char name [10];
>> +		char name[14];
>>   
>>   		sprintf(name, "cpu%lu", cpu);
>>   		debugfs_create_file(name, 0644, dir, arg, &dfs_ops);
> 
> 
> 


