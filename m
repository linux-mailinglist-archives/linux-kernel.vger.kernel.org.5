Return-Path: <linux-kernel+bounces-34643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCFE8385AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75548B2AA56
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CDA52F7B;
	Tue, 23 Jan 2024 02:36:58 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1C52F90;
	Tue, 23 Jan 2024 02:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705977418; cv=none; b=V5nCyEp7pq+Td8OOpDR4h7qRbcByC1aXoCoNxy1xHpGoMX0zM9Ba2mxjbOs1yeSREmMAEbiLXzzEwPz33/h+JGT3U/vSYpQgue+SF4Ob5b7GJrnFZHpwtBHrlFlQjuYbrWiCA5ccK9NKgFIRiSbmzf4rgZHYUn5voNYjmKPV7CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705977418; c=relaxed/simple;
	bh=ZzHhTy4oVqbqk4rjHHtCAYK6n4KCr+YmeWtTcRgougs=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=C2v0OyiB4IM0fxaY9cLIldTYBbCmpsBAOx286RTuy/txxBfaQ2claPQodzE8cHyQcspBDDBGUbA2KOpRDzxoH+nLolIGCNAnedj6v2z+s8OS86/rEqE45A1k/xGyA/QAB3rKxA3idy9piH/LW59M3PKB2E0pdRMla+EZ0Feospc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TJrmx75ZRzNlNk;
	Tue, 23 Jan 2024 10:36:01 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CBBE18005E;
	Tue, 23 Jan 2024 10:36:53 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 10:36:37 +0800
Subject: Re: [PATCH v2 1/7] string.h: add str_has_suffix() helper for test
 string ends with specify string
To: Steven Rostedt <rostedt@goodmis.org>
References: <20240122074015.4042575-1-yebin10@huawei.com>
 <20240122074015.4042575-2-yebin10@huawei.com>
 <20240122110759.29c50a19@gandalf.local.home>
CC: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <65AF2634.2090705@huawei.com>
Date: Tue, 23 Jan 2024 10:36:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122110759.29c50a19@gandalf.local.home>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/1/23 0:07, Steven Rostedt wrote:
> On Mon, 22 Jan 2024 15:40:09 +0800
> Ye Bin <yebin10@huawei.com> wrote:
>
>> str_has_suffix() is test string if ends with specify string.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   include/linux/string.h | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/include/linux/string.h b/include/linux/string.h
>> index 433c207a01da..e47e9597af27 100644
>> --- a/include/linux/string.h
>> +++ b/include/linux/string.h
>> @@ -405,4 +405,24 @@ static __always_inline size_t str_has_prefix(const char *str, const char *prefix
>>   	return strncmp(str, prefix, len) == 0 ? len : 0;
>>   }
>>   
>> +/**
>> + * str_has_suffix - Test if a string has a given suffix
>> + * @str: The string to test
>> + * @suffix: The string to see if @str ends with
>> + *
>> + * Returns:
>> + * * strlen(@suffix) if @str ends with @suffix
>> + * * 0 if @str does not end with @suffix
>> + */
>> +static __always_inline size_t str_has_suffix(const char *str, const char *suffix)
>> +{
>> +	size_t len = strlen(suffix);
>> +	size_t str_len = strlen(str);
>> +
>> +	if (len > str_len)
>> +		return 0;
>> +
>> +	return strncmp(str + str_len - len, suffix, len) == 0 ? len : 0;
>> +}
> I understand why you are returning the length of the suffix, as it matches
> str_has_prefix(). But as the user of this will likely need the length of
> the "str" too, we should either return the length of the string, or the
> index of where the suffix was found.
>
> /**
>   [..]
>   @index: The index into @str of where @suffix is if found (NULL to ignore)
>   [..]
> */
> static __always_inline size_t str_has_suffix(const char *str, const char *suffix, size_t *index)
> {
> 	size_t len = strlen(suffix);
> 	size_t str_len = strlen(str);
>
> 	if (len > str_len)
> 		return 0;
>
> 	if (index)
> 		*index = str_len - len;
>
> 	return strncmp(str + str_len - len, suffix, len) == 0 ? len : 0;
> }
>
> -- Steve
Thank you for your advice.
Return the index of where the suffix was found is useful. I'll modify it 
according to your suggestion.

-- Ye Bin
>> +
>>   #endif /* _LINUX_STRING_H_ */
> .
>


