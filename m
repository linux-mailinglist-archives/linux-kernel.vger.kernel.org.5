Return-Path: <linux-kernel+bounces-72175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8793585B077
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA111F229C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7110418625;
	Tue, 20 Feb 2024 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pIS3n9ge"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D5B10785;
	Tue, 20 Feb 2024 01:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708392045; cv=none; b=JkruFHhTsU2BGm1k18FmqBw2JnD95rDQCQEi5xajTrK9kUC6CHrWykp55PvySqG6hONr8o/TU3ekLmpsiyTqmlS+wUz+0wj1LlzHqEEq2R4ZZHGm0PDNM949XOM5QA3pgwjnXrt9aIj16ruiddDb+Voli7HH7C0DAzoJvK/uA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708392045; c=relaxed/simple;
	bh=YhnbEJ7jin2iVNo4/mthW0jds5uM2TXHowDul2uC1vE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VxqNjuSU7uAvsBKJ5ZQiAxQBn+YFpPz8DDXqqsKL4mWh5cuj/GehiHNkQj23DuFU9Pv5yWcQAImYdW5Dk+CjEnvvwx9aKqvlRPaQYIUokmQjmPTXdO/Pk0mjV8ZKmEklHr0VX++mHG9J7aeJyNmIGwy/t4iZIf6o08yqyfxArEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pIS3n9ge; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708392040; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=P8a2KvIDAcw/ShinP4C6CMkfEvY7pIx3fK2igf/0yLQ=;
	b=pIS3n9ge38ON6xk6rHCC688tbxdt+oKg07XcJPL+EGuM5VO4BYfeXlcRjiYyIQTb4ngknLLOfKG83xL4SlEeEN6+HSl7ODj7vRUKWwTCXynF5Sh6MVes6u7noscVISdvnS8nP+BMzbpQSDLTN5TbqpMwL2JAw0nQprKFjbBXF2M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W0upqYR_1708392038;
Received: from 30.221.128.233(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W0upqYR_1708392038)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 09:20:39 +0800
Message-ID: <15d7f21d-c4b9-45e3-8608-4a7b929865f7@linux.alibaba.com>
Date: Tue, 20 Feb 2024 09:20:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/15] net/smc: introduce virtual ISM device
 loopback-ism
To: Wenjia Zhang <wenjia@linux.ibm.com>, wintera@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jaka@linux.ibm.com, Gerd Bayer <gbayer@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <20240111120036.109903-4-guwen@linux.alibaba.com>
 <0be9c41b-19f9-437a-9a3a-8ed15cbbd155@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <0be9c41b-19f9-437a-9a3a-8ed15cbbd155@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/2/16 22:11, Wenjia Zhang wrote:
> 
> 
> On 11.01.24 13:00, Wen Gu wrote:
>> This introduces a kind of virtual ISM device loopback-ism for SMCDv2.1.
>> loopback-ism is implemented by software and serves inter-process or
>> inter-container SMC communication in the same OS instance. It is created
>> during SMC module loading and destroyed upon unloading. The support for
>> loopback-ism can be configured via CONFIG_SMC_LO.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   net/smc/Kconfig        |  13 +++
>>   net/smc/Makefile       |   2 +-
>>   net/smc/af_smc.c       |  12 ++-
>>   net/smc/smc_loopback.c | 181 +++++++++++++++++++++++++++++++++++++++++
>>   net/smc/smc_loopback.h |  33 ++++++++
>>   5 files changed, 239 insertions(+), 2 deletions(-)
>>   create mode 100644 net/smc/smc_loopback.c
>>   create mode 100644 net/smc/smc_loopback.h
>>
>> diff --git a/net/smc/Kconfig b/net/smc/Kconfig
>> index 746be3996768..e191f78551f4 100644
>> --- a/net/smc/Kconfig
>> +++ b/net/smc/Kconfig
>> @@ -20,3 +20,16 @@ config SMC_DIAG
>>         smcss.
>>         if unsure, say Y.
>> +
>> +config SMC_LO
>> +    bool "SMC_LO: virtual ISM loopback-ism for SMC"
>> +    depends on SMC
>> +    default n
>> +    help
>> +      SMC_LO provides a kind of virtual ISM device called loopback-ism
> Don't forget to update "s/virtual/emulated/" later. ;-)
> 
> <...>

Yes, new version will change all virtual ISM to Emulated-ISM. Thank you.

