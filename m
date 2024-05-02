Return-Path: <linux-kernel+bounces-166857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835C68BA0E5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6651C20AB0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F84F176FDF;
	Thu,  2 May 2024 19:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEajT4AC"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01CD59B56
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714677236; cv=none; b=CMO6y07Dv2Ii/rccQYD/xy0he7UQ/6zZo832U0yv0ZSLkzYGqJOEU6wOqWejlezhF0eyWDbjTk4MfrhLHOYvv3wk92wbI1/dfu3sKSAO2CI0mwFcFj5JHayyPLrqfjL2J6/LmfsFZaMBL5iwogoenS3BFU4dX4fa4AHdDtY0DEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714677236; c=relaxed/simple;
	bh=6KcPMckeF7kYmHTflHMwUGa4UKPLXNsKambdE0p6K68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pz8anWYJF4DYpDhPgOTW3cNrCYASqvCpC8XPbM2VuxPJoOkluE68Goqfxc9RV1ZG5EzAKRitVhbFNcFEcj19WoaBKsW2R5yxpCXU9VkTkjEQFROYqHZy/xTvPg1WNcUxB16M130Jl5J5uTS1paecYJBRenPCt6oCZ+VxVJeG8L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEajT4AC; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34e28e32ea4so539967f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 12:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714677233; x=1715282033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v7xERDFuJA/0OWgymjug68y27n1wkoWLTkEYX8JNLw8=;
        b=fEajT4ACHlEVav7EP4wO0Ls2QTwSrR/VMbmKsVXiF3iDB5aAOHo3cBMPqB7Q7fQXzw
         GEObIXQIB2WV+vQuuI9TrsTMl63PwhDBzGq0IUm+3XjyNz9TamCZvIgoRrZ4vuFJmch5
         lKHovAZN3IrEKIuigZiaNpBMagfdmu6zWDh1EUXWGokz1W9I5xkVQkLcObWiOGSR7RvZ
         qhDOXco4TciSkz5kOPBHC6Qi39+/scQSX+roq2dRKfhIfCyykUFGCFu2+goIjkLm7Jm9
         NZQp58Ej8LCUceNe2fMG3CHQiRyUv1dFEtlsjj0FbFn3xL57RwDzjlMO9KDN9U0gv2AM
         HkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714677233; x=1715282033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7xERDFuJA/0OWgymjug68y27n1wkoWLTkEYX8JNLw8=;
        b=eAY9gJqsjW2vjAqLgvxFWe0NrVdTuAOfNhwIhVbEARRdw9VxuEw8s1qy8mIjEjoncE
         AgSZyxpYLB5ghy5thWJyfSwyARNASpaMeOC/4OAsrZUCPRh7rh3gGzEBjvaWc8JWJQFP
         0WZUicv7dewN3uDwt+yz1uXADkHJQ/7mWNUYDMZQZN8z/uBG/huJFBNV/+vPytBrt8IC
         GtQEc73lItKKAudCKe3ScLmWya1/5+Iy9QqyMHbZYZGyp7ddk92KTPt++axfFOQbeflA
         5jlUxoNLp/lFpXP7ja/8dp4lowJYVljod9nkysYZJThoNakNuPJThzQqOaAP373E/zxO
         n5HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDXBchPcaKE0ZFviECz0cHQEjE8Rm5WCz5mzjp6nehuZzlp7WdOd54OIL24if83rnQk3CV+7r8NUER2ygWllEOiRYwzwfzDJ1ymima
X-Gm-Message-State: AOJu0Yw8XpnoHJQ0hdkaMicawQt5IjwwvQOZNsnZmVwvO50EkYHz5kVP
	Py/6AtM8092pNsqge6lsXwTNGTeaSprdG09dLhis/l9lVW0Lvz02
X-Google-Smtp-Source: AGHT+IG0sXFqYpDGCdmsA4nZVVkTR4Vc9mf/7tEkWAuYoVCeKkTXc/VOSbLpnPcnSqA/IVKlgsESPA==
X-Received: by 2002:adf:e88f:0:b0:34c:71a0:426c with SMTP id d15-20020adfe88f000000b0034c71a0426cmr490323wrm.37.1714677233059;
        Thu, 02 May 2024 12:13:53 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b75d:0:64:3301:4710:ec21? ([2a02:6b6a:b75d:0:64:3301:4710:ec21])
        by smtp.gmail.com with ESMTPSA id cx14-20020a056000092e00b0034a2d0b9a4fsm1927591wrb.17.2024.05.02.12.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 12:13:52 -0700 (PDT)
Message-ID: <1e9383d8-98a7-4ef4-9c30-4f068fc38db1@gmail.com>
Date: Thu, 2 May 2024 20:13:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: cgroup: add tests to verify the zswap
 writeback path
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com,
 chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <20240501100446.1454264-1-usamaarif642@gmail.com>
 <CAJD7tkZ_fmzo8RGGpiH+0uUZCC7Nbnny6iHHfBruk2oa21Pi9Q@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJD7tkZ_fmzo8RGGpiH+0uUZCC7Nbnny6iHHfBruk2oa21Pi9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 01/05/2024 18:15, Yosry Ahmed wrote:
> Hi Usama,
>
> On Wed, May 1, 2024 at 3:04 AM Usama Arif <usamaarif642@gmail.com> wrote:
>> The condition for writeback can be triggered by allocating random
>> memory more than memory.high to push memory into zswap, more than
>> zswap.max to trigger writeback if enabled, but less than memory.max
>> so that OOM is not triggered. Both values of memory.zswap.writeback
>> are tested.
> Thanks for working on this :)
>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>   tools/testing/selftests/cgroup/test_zswap.c | 83 +++++++++++++++++++++
>>   1 file changed, 83 insertions(+)
>>
>> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
>> index f0e488ed90d8..fe0e7221525c 100644
>> --- a/tools/testing/selftests/cgroup/test_zswap.c
>> +++ b/tools/testing/selftests/cgroup/test_zswap.c
>> @@ -94,6 +94,19 @@ static int allocate_bytes(const char *cgroup, void *arg)
>>          return 0;
>>   }
>>
>> +static int allocate_random_bytes(const char *cgroup, void *arg)
>> +{
>> +       size_t size = (size_t)arg;
>> +       char *mem = (char *)malloc(size);
>> +
>> +       if (!mem)
>> +               return -1;
>> +       for (int i = 0; i < size; i++)
>> +               mem[i] = rand() % 128;
>> +       free(mem);
>> +       return 0;
>> +}
>> +
>>   static char *setup_test_group_1M(const char *root, const char *name)
>>   {
>>          char *group_name = cg_name(root, name);
>> @@ -248,6 +261,74 @@ static int test_zswapin(const char *root)
>>          return ret;
>>   }
>>
>> +/* Test to verify the zswap writeback path */
>> +static int test_zswap_writeback(const char *root, bool wb)
>> +{
>> +       int ret = KSFT_FAIL;
>> +       char *test_group;
>> +       long zswpwb_before, zswpwb_after;
>> +
>> +       test_group = cg_name(root,
>> +               wb ? "zswap_writeback_enabled_test" : "zswap_writeback_disabled_test");
>> +       if (!test_group)
>> +               goto out;
>> +       if (cg_create(test_group))
>> +               goto out;
>> +       if (cg_write(test_group, "memory.max", "8M"))
>> +               goto out;
>> +       if (cg_write(test_group, "memory.high", "2M"))
>> +               goto out;
>> +       if (cg_write(test_group, "memory.zswap.max", "2M"))
>> +               goto out;
>> +       if (cg_write(test_group, "memory.zswap.writeback", wb ? "1" : "0"))
>> +               goto out;
>> +
>> +       zswpwb_before = cg_read_key_long(test_group, "memory.stat", "zswpwb ");
>> +       if (zswpwb_before < 0) {
>> +               ksft_print_msg("failed to get zswpwb_before\n");
>> +               goto out;
>> +       }
>> +
>> +       /*
>> +        * Allocate more than memory.high to push memory into zswap,
>> +        * more than zswap.max to trigger writeback if enabled,
>> +        * but less than memory.max so that OOM is not triggered
>> +        */
>> +       if (cg_run(test_group, allocate_random_bytes, (void *)MB(3)))
>> +               goto out;
> We set the zswap limit to 2M. So for this to work properly we need to
> guarantee that the 3M of random data will compress into more than 2M.
> Is this true for all possible zpool implementations and compression
> algorithms? How likely for this to break and start producing false
> negatives if zswap magically becomes more efficient?
>
> One alternative approach that I used before, although more complex, is
> to start by compressing the memory (i.e. through reclaim) without a
> zswap limit, and check the zswap usage. Then, fault the memory back
> in, set the zswap limit lower than the observed usage, and repeat.
> This should guarantee writeback AFAICT.
>
> Also, using memory.reclaim may be easier than memory.high if you
> follow this approach, as you would need to raise memory.high again to
> be able to decompress the memory.
>
Thanks for the review! I have sent a v2 with the method you described. I 
did like the simplicity of the method in this v1 a lot more, and we 
could have increased the random memory, which eventhough theoretically 
would mean it might not trigger a writeback if there was some new magic 
compression method, in practice it would always trigger it and work. 
Your suggestion which is in v2 covers both theory and practice :)


>> +
>> +       /* Verify that zswap writeback occurred only if writeback was enabled */
>> +       zswpwb_after = cg_read_key_long(test_group, "memory.stat", "zswpwb ");
>> +       if (wb) {
>> +               if (zswpwb_after <= zswpwb_before) {
>> +                       ksft_print_msg("writeback enabled and zswpwb_after <= zswpwb_before\n");
>> +                       goto out;
>> +               }
>> +       } else {
>> +               if (zswpwb_after != zswpwb_before) {
>> +                       ksft_print_msg("writeback disabled and zswpwb_after != zswpwb_before\n");
>> +                       goto out;
>> +               }
>> +       }
>> +
>> +       ret = KSFT_PASS;
>> +
>> +out:
>> +       cg_destroy(test_group);
>> +       free(test_group);
>> +       return ret;
>> +}
>> +
>> +static int test_zswap_writeback_enabled(const char *root)
>> +{
>> +       return test_zswap_writeback(root, true);
>> +}
>> +
>> +static int test_zswap_writeback_disabled(const char *root)
>> +{
>> +       return test_zswap_writeback(root, false);
>> +}
>> +
>>   /*
>>    * When trying to store a memcg page in zswap, if the memcg hits its memory
>>    * limit in zswap, writeback should affect only the zswapped pages of that
>> @@ -425,6 +506,8 @@ struct zswap_test {
>>          T(test_zswap_usage),
>>          T(test_swapin_nozswap),
>>          T(test_zswapin),
>> +       T(test_zswap_writeback_enabled),
>> +       T(test_zswap_writeback_disabled),
>>          T(test_no_kmem_bypass),
>>          T(test_no_invasive_cgroup_shrink),
>>   };
>> --
>> 2.43.0
>>

