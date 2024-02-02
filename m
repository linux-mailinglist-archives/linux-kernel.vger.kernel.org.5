Return-Path: <linux-kernel+bounces-49348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4464D84690C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023701F229F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81A51799D;
	Fri,  2 Feb 2024 07:11:31 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAA21774A;
	Fri,  2 Feb 2024 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706857891; cv=none; b=rD2hvGqLvn8JQZ0trNaE46kvqAShAMZ3rwh1aOA4lzrYoWQXJndBvpme48JWj+a52WYRbgPXcY7RJ5domsbQ9Pv1RktS0jYSyQrPna2Wn9xdW9RtelXCXTFqkPnw/Sn0+9mdjgfECFX5ypKUXxPUzA8npCzn6JfSAK2OwEgl6EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706857891; c=relaxed/simple;
	bh=Fr3TDwvx1wqdBql10h+HOKFOZ1dlqTahAcc2UG3hHv0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KnoTfPFMUiX5rFUlFASO8g04g2LGzbANRH4pVX4c5RQtNZEeMVGTxK9f48ypNrB/PzHqoxZHocNyvgOOHSARHsHGqfju0uuCJF/TRqQjkv0OQjVQAytEhda7st4uujELlyWN0huTI8D8ELxkI4g/mqu9Dm3iz9Z/dlMtOsc1PUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TR6Pw2yMsz4f3jpl;
	Fri,  2 Feb 2024 15:11:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0A46A1A0172;
	Fri,  2 Feb 2024 15:11:19 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxCVlbxlRu7mCg--.30222S3;
	Fri, 02 Feb 2024 15:11:18 +0800 (CST)
Subject: Re: [PATCH v4] md/raid5: fix atomicity violation in raid5_cache_count
To: Song Liu <song@kernel.org>, Gui-Dong Han <2045gemini@gmail.com>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@outlook.com, stable@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240112071017.16313-1-2045gemini@gmail.com>
 <CAPhsuW64FjJEqTFKX9WVzrXvC4rpcjojBw5A3StUq0C20F_vyA@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e0c5f9d4-6b65-02f7-2a8c-0484fd1f9815@huaweicloud.com>
Date: Fri, 2 Feb 2024 15:11:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW64FjJEqTFKX9WVzrXvC4rpcjojBw5A3StUq0C20F_vyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxCVlbxlRu7mCg--.30222S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4fAF1xtr1UKrWkuFyUZFb_yoW8WrW5pF
	ZYya4UXr40ywnYy3yDZr4vgrWfCrZ8XF13Jw47W3Z7ZFZYkFWSyr17Jr15ury8A3y8JrZa
	vF9xu3s5urn7trJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/01/30 15:37, Song Liu 写道:
> On Thu, Jan 11, 2024 at 11:10 PM Gui-Dong Han <2045gemini@gmail.com> wrote:
>>
> [...]
>>
>>          raid5_release_stripe(sh);
>> -       conf->max_nr_stripes++;
>> +       WRITE_ONCE(conf->max_nr_stripes, conf->max_nr_stripes + 1);
> 
> This is weird. We are reading max_nr_stripes without READ_ONCE.

We don't need READ_ONCE() here because writers are protected by
'cache_size_mutex', there are no concurrent writers, it's safe to
read 'max_nr_stripes' directly.

Thanks,
Kuai

> 
>>          return 1;
>>   }
>>
>> @@ -2707,7 +2707,7 @@ static int drop_one_stripe(struct r5conf *conf)
>>          shrink_buffers(sh);
>>          free_stripe(conf->slab_cache, sh);
>>          atomic_dec(&conf->active_stripes);
>> -       conf->max_nr_stripes--;
>> +       WRITE_ONCE(conf->max_nr_stripes, conf->max_nr_stripes - 1);
> 
> Same here.
> 
>>          return 1;
>>   }
>>
>> @@ -6820,7 +6820,7 @@ raid5_set_cache_size(struct mddev *mddev, int size)
>>          if (size <= 16 || size > 32768)
>>                  return -EINVAL;
>>
>> -       conf->min_nr_stripes = size;
>> +       WRITE_ONCE(conf->min_nr_stripes, size);
>>          mutex_lock(&conf->cache_size_mutex);
>>          while (size < conf->max_nr_stripes &&
>>                 drop_one_stripe(conf))
>> @@ -6832,7 +6832,7 @@ raid5_set_cache_size(struct mddev *mddev, int size)
>>          mutex_lock(&conf->cache_size_mutex);
>>          while (size > conf->max_nr_stripes)
>>                  if (!grow_one_stripe(conf, GFP_KERNEL)) {
>> -                       conf->min_nr_stripes = conf->max_nr_stripes;
>> +                       WRITE_ONCE(conf->min_nr_stripes, conf->max_nr_stripes);
> 
> And here.
> 
>>                          result = -ENOMEM;
>>                          break;
>>                  }
> 
> Thanks,
> Song
> .
> 


