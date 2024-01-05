Return-Path: <linux-kernel+bounces-17558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D341824F60
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4AC1C21D64
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255EE2030C;
	Fri,  5 Jan 2024 07:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="acBnulpf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F29521343;
	Fri,  5 Jan 2024 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id Lf0CrISoa2jhsLf0CrWboE; Fri, 05 Jan 2024 08:52:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704441146;
	bh=t/oh2/wi/UPIqXbHxhouAM8Ei5nFVNd01scfNMRmZt8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=acBnulpfwzQhiJnYvkh8ZbK1hXLIiDrx1P4Bjjt6RRRAB5dvo+yJqhKXzbJ10eQfw
	 ilNJDhwVBr7YkbWLcTw9cYTjJMxpbNClwnOQHcGAWkQXbhdotnIHNevu6tZiugSQGb
	 xnPB1pv2A/2KIhlCyRaVz2mDAts6N4TrQAuCW5JKhA780ZA20xjHXxkWWXnjopP7H8
	 cq0SdBGEIQBZ1Nmt+DCEtGLW0kVIEf6EgL4eKhF5mnOuigAtlOTb6cl4McxRt8VL28
	 /ixx5fWyOn6X0qiM1ilypCpgrz9t2WDZ0d4xM5PikvJ4NgKVCnaKGumPzQacnkHLXR
	 cWWU3FrZ+HXOQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 05 Jan 2024 08:52:26 +0100
X-ME-IP: 92.140.202.140
Message-ID: <e09c4a19-262e-440c-98d5-92d2f33fb12b@wanadoo.fr>
Date: Fri, 5 Jan 2024 08:52:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/2] PM / devfreq: Fix buffer overflow in
 trans_stat_show
Content-Language: fr
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Jonghwa Lee
 <jonghwa3.lee@samsung.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, stable@vger.kernel.org
References: <20240104215521.10772-1-ansuelsmth@gmail.com>
 <9d57f4ea-67d1-48b5-92df-c5556f95f5d6@wanadoo.fr>
 <659735f1.050a0220.efb5.1c0d@mx.google.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <659735f1.050a0220.efb5.1c0d@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/01/2024 à 23:44, Christian Marangi a écrit :
> On Thu, Jan 04, 2024 at 11:19:44PM +0100, Christophe JAILLET wrote:
>> Le 04/01/2024 à 22:55, Christian Marangi a écrit :
>>> Fix buffer overflow in trans_stat_show().
>>>
>>> Convert simple snprintf to the more secure scnprintf with size of
>>> PAGE_SIZE.
>>>
>>> Add condition checking if we are exceeding PAGE_SIZE and exit early from
>>> loop. Also add at the end a warning that we exceeded PAGE_SIZE and that
>>> stats is disabled.
>>>
>>> Return -EFBIG in the case where we don't have enough space to write the
>>> full transition table.
>>>
>>> Also document in the ABI that this function can return -EFBIG error.
>>>
>>> Cc: stable@vger.kernel.org
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218041
>>> Fixes: e552bbaf5b98 ("PM / devfreq: Add sysfs node for representing frequency transition information.")
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> ---
>>>    Documentation/ABI/testing/sysfs-class-devfreq |  3 +
>>>    drivers/devfreq/devfreq.c                     | 57 +++++++++++++------
>>>    2 files changed, 42 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
>>> index 5e6b74f30406..1e7e0bb4c14e 100644
>>> --- a/Documentation/ABI/testing/sysfs-class-devfreq
>>> +++ b/Documentation/ABI/testing/sysfs-class-devfreq
>>> @@ -52,6 +52,9 @@ Description:
>>>    			echo 0 > /sys/class/devfreq/.../trans_stat
>>> +		If the transition table is bigger than PAGE_SIZE, reading
>>> +		this will return an -EFBIG error.
>>> +
>>>    What:		/sys/class/devfreq/.../available_frequencies
>>>    Date:		October 2012
>>>    Contact:	Nishanth Menon <nm@ti.com>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 63347a5ae599..8459512d9b07 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -1688,7 +1688,7 @@ static ssize_t trans_stat_show(struct device *dev,
>>>    			       struct device_attribute *attr, char *buf)
>>>    {
>>>    	struct devfreq *df = to_devfreq(dev);
>>> -	ssize_t len;
>>> +	ssize_t len = 0;
>>>    	int i, j;
>>>    	unsigned int max_state;
>>> @@ -1697,7 +1697,7 @@ static ssize_t trans_stat_show(struct device *dev,
>>>    	max_state = df->max_state;
>>>    	if (max_state == 0)
>>> -		return sprintf(buf, "Not Supported.\n");
>>> +		return scnprintf(buf, PAGE_SIZE, "Not Supported.\n");
>>
>> Hi,
>>
>> maybe using  sysfs_emit_at() could be even cleaner and less verbose?
>>
> 
> If you notice this change is done in the second patch of the series.
> This patch still use this more generic way to permit this to be
> backported on stable kernel. (older kernel doesn't have sysfs_emit_at()
> hence it can't be backported)

Ok. Thanks for the clarification.

> 
>>>    	mutex_lock(&df->lock);
>>>    	if (!df->stop_polling &&
>>> @@ -1707,31 +1707,52 @@ static ssize_t trans_stat_show(struct device *dev,
>>>    	}
>>>    	mutex_unlock(&df->lock);
>>> -	len = sprintf(buf, "     From  :   To\n");
>>> -	len += sprintf(buf + len, "           :");
>>> -	for (i = 0; i < max_state; i++)
>>> -		len += sprintf(buf + len, "%10lu",
>>> -				df->freq_table[i]);
>>> +	len += scnprintf(buf + len, PAGE_SIZE - len, "     From  :   To\n");
>>> +	len += scnprintf(buf + len, PAGE_SIZE - len, "           :");
>>> +	for (i = 0; i < max_state; i++) {
>>> +		if (len >= PAGE_SIZE - 1)
>>> +			break;
>>> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%10lu",
>>> +				 df->freq_table[i]);
>>> +	}
>>> +	if (len >= PAGE_SIZE - 1)
>>> +		return PAGE_SIZE - 1;

[1]

>>> -	len += sprintf(buf + len, "   time(ms)\n");
>>> +	len += scnprintf(buf + len, PAGE_SIZE - len, "   time(ms)\n");
>>>    	for (i = 0; i < max_state; i++) {
>>> +		if (len >= PAGE_SIZE - 1)
>>> +			break;
>>
>> I'm not sure that adding all these tests is needed. It could save some
>> cycles in the worse case (when buf could overflow), but in fact wastes
>> cycles in the normel case.
>>
> 
> Consider that cpufreq stats does the same exact checks and I feel the 2
> thing should be equal (given they do the same exact task)

Make sense.

But I think that show_trans_table(() could also save some tests.
I agree with you that limiting these tests to at most 1 per loop should 
be already a first step.


Also surprising to me, is that if the output is too big, at [1] (above) 
we silently truncate it, and at [2] (below) we return an error.

CJ

> 
> Also with case of -EBIG, I would expact the thing to be very big and
> exiting early might be beneficial, for normal stats I would expact only
> a few cycle added. Myabe we can reduce them just for the for cycle?
> 
>>>    		if (df->freq_table[i] == df->previous_freq)
>>> -			len += sprintf(buf + len, "*");
>>> +			len += scnprintf(buf + len, PAGE_SIZE - len, "*");
>>>    		else
>>> -			len += sprintf(buf + len, " ");
>>> +			len += scnprintf(buf + len, PAGE_SIZE - len, " ");
>>> +		if (len >= PAGE_SIZE - 1)
>>> +			break;
>>> +
>>> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%10lu:",
>>> +				 df->freq_table[i]);
>>> +		for (j = 0; j < max_state; j++) {
>>> +			if (len >= PAGE_SIZE - 1)
>>> +				break;
>>> +			len += scnprintf(buf + len, PAGE_SIZE - len, "%10u",
>>> +					 df->stats.trans_table[(i * max_state) + j]);
>>> +		}
>>> +		if (len >= PAGE_SIZE - 1)
>>> +			break;
>>> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%10llu\n", (u64)
>>> +				 jiffies64_to_msecs(df->stats.time_in_state[i]));
>>> +	}
>>> -		len += sprintf(buf + len, "%10lu:", df->freq_table[i]);
>>> -		for (j = 0; j < max_state; j++)
>>> -			len += sprintf(buf + len, "%10u",
>>> -				df->stats.trans_table[(i * max_state) + j]);
>>> +	if (len < PAGE_SIZE - 1)
>>> +		len += scnprintf(buf + len, PAGE_SIZE - len, "Total transition : %u\n",
>>> +				 df->stats.total_trans);
>>> -		len += sprintf(buf + len, "%10llu\n", (u64)
>>> -			jiffies64_to_msecs(df->stats.time_in_state[i]));
>>> +	if (len >= PAGE_SIZE - 1) {
>>> +		pr_warn_once("devfreq transition table exceeds PAGE_SIZE. Disabling\n");
>>> +		return -EFBIG;

[2]

>>>    	}
>>> -	len += sprintf(buf + len, "Total transition : %u\n",
>>> -					df->stats.total_trans);
>>>    	return len;
>>>    }
>>
> 


