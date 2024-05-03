Return-Path: <linux-kernel+bounces-167575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6408BAB7D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7BA1C22030
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C50815218F;
	Fri,  3 May 2024 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1XCaBfR"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B7617758
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714734997; cv=none; b=k4L8/FrRl/rzf1uVD9uZiLGgERuUo9jv/KIdEyHH2H06g3JJrfk05snywKKlcM9nJqmaLe2WHvoTxoWceF8gaqV6OijBbSNrIFG7OxWqSvhb1gDBryesxOgBO3cvfWDG2NbJNrqBQt3mQcm/WB74Cu0MFgs0zYXumN0DGeEGn/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714734997; c=relaxed/simple;
	bh=owl0UqkpYfCOWUOEHk4SMqHY1zmY5oqdfKZk2B2W+Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCt93FKkgRyS3nOiips9Uja26EGUhngjn8yUvuzDubNdjeN0kru2VOVRGLvr2DNU24Gns1ELE6tgsEcGFFezTiMd9nnqqWObzayh2pMsW9QvlQDyulpzyEIIVU/yXrTuYxQ/Kg2xbQ1z3TSa8ok7Ity+stA8uVxSrt5bBmGFxSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1XCaBfR; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51f40b5e059so1883353e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 04:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714734993; x=1715339793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eb+xzn111ko7br6Rv+Ab3g9AwNQcxovpEvUU1HG7Y40=;
        b=J1XCaBfR/jq9Bag9lZpwVq+11r+HSCuEcqLn0M/dLeKAyNwqZIJpxac4nFxLk6m1ye
         0f/QBunaqrI7SVaTNIfhyczAslq04EBjwoewLtixn2uHGBMDvQI7DZc08Y/qg3QrPOaj
         ilDTTf2/6GAis2uLlHYgfuC28trPkZwELjHgCg0KhcJtxEZXuiiBenREZ3mevrml3uB/
         JlxgBGlHCvHrQXCZl9KpAMhKXyXA96CQEVVP6SKWVIMptCdOWl7jfXVGM50bUe35n3lv
         yumuuQeuW6wngWUKB0WPHUOr4yA7QxbMVJuTBGEgCYDwxAIOe8Nenf+rMolIEUkyKHO5
         HDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714734993; x=1715339793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eb+xzn111ko7br6Rv+Ab3g9AwNQcxovpEvUU1HG7Y40=;
        b=cOVCi8kFPlCatWn530cYrz0UnKzXF3zRJWfJslY+qS/LsVOKgCFXVLZ/W3EVsz2lI9
         ntaF7BsubUV5GesQF/NKiIT5y9zoqIbHz8V/aAjqdjLKQnf9xn1XuQVC5pfXbOsHHKMK
         sRBSvjGI6oU3y3Jl/8/szZjh4iRNfx7g1/IOTxzm58HLDWhBsErJ5nzDGV415vBvJPVm
         4jVOrbwO3J+z55wIsjHuFh8d3JSIxfxIJh0umHoh6nda9OzW73xSlZCMYVB+UV46Hi+/
         hMgTKCZrDrhAGJBHapb3liSWrZXcrgMwwtbandVToti3H8IFxT/3FhPjk2YqmPVLNs4S
         MfKA==
X-Forwarded-Encrypted: i=1; AJvYcCUxR+uvpJ/RVMnR+IAXySj4zc3EzAOg2zCiDjX7BtGcBhErK4juZgS171MmDXdqiN+pT2BiCrvVDVpgokBntixZRUvNqpk4fFUvuCJG
X-Gm-Message-State: AOJu0YxDUeIJWRPSY2J1rNjlQcbZDnwkd+AR/IzX2U0FIDLZoAbJqeKx
	Bz4tVzaijlmrnE34zt7HKNLgCjXOJ0l0CBjf0gGv6xOVW/u41it1
X-Google-Smtp-Source: AGHT+IGi0W+YmKQJDwxXSpcwYiXSiYGwe77f+H5HvZp62ZIkGwt7vARw516WD4uKceoJzGMlHweyOg==
X-Received: by 2002:a05:6512:715:b0:51f:315c:75e0 with SMTP id b21-20020a056512071500b0051f315c75e0mr1340644lfs.44.1714734992894;
        Fri, 03 May 2024 04:16:32 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:f792])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402160600b005722ce89ae2sm1575017edv.38.2024.05.03.04.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 04:16:32 -0700 (PDT)
Message-ID: <10bf047a-88b8-4502-a7e2-1ae35f8d57ec@gmail.com>
Date: Fri, 3 May 2024 12:16:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] selftests: cgroup: add tests to verify the zswap
 writeback path
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com,
 chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <20240502190223.3975970-1-usamaarif642@gmail.com>
 <20240502190223.3975970-2-usamaarif642@gmail.com>
 <CAJD7tkbevtBCcWUQYZwyqM7WMjLfN+BNE3LwQjFzNkOEgRO1cw@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJD7tkbevtBCcWUQYZwyqM7WMjLfN+BNE3LwQjFzNkOEgRO1cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 03/05/2024 03:36, Yosry Ahmed wrote:
> On Thu, May 2, 2024 at 12:02 PM Usama Arif <usamaarif642@gmail.com> wrote:
>> Initate writeback with the below steps and check using
>> memory.stat.zswpwb if zswap writeback occurred:
>> 1. Allocate memory.
>> 2. Reclaim memory equal to the amount that was allocated in step 1.
>>     This will move it into zswap.
>> 3. Save current zswap usage.
>> 4. Move the memory allocated in step 1 back in from zswap.
>> 5. Set zswap.max to half the amount that was recorded in step 3.
>> 6. Attempt to reclaim memory equal to the amount that was allocated,
>>     this will either trigger writeback if its enabled, or reclamation
>>     will fail if writeback is disabled as there isn't enough zswap
>>     space.
>>
>> Suggested-by: Nhat Pham <nphamcs@gmail.com>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>   tools/testing/selftests/cgroup/test_zswap.c | 125 +++++++++++++++++++-
>>   1 file changed, 124 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
>> index f0e488ed90d8..cd864ab825d0 100644
>> --- a/tools/testing/selftests/cgroup/test_zswap.c
>> +++ b/tools/testing/selftests/cgroup/test_zswap.c
>> @@ -50,7 +50,7 @@ static int get_zswap_stored_pages(size_t *value)
>>          return read_int("/sys/kernel/debug/zswap/stored_pages", value);
>>   }
>>
>> -static int get_cg_wb_count(const char *cg)
>> +static long get_cg_wb_count(const char *cg)
>>   {
>>          return cg_read_key_long(cg, "memory.stat", "zswpwb");
>>   }
>> @@ -248,6 +248,127 @@ static int test_zswapin(const char *root)
>>          return ret;
>>   }
>>
>> +/*
>> + * Initate writeback with the following steps:
>> + * 1. Allocate memory.
>> + * 2. Reclaim memory equal to the amount that was allocated in step 1.
>> +      This will move it into zswap.
>> + * 3. Save current zswap usage.
>> + * 4. Move the memory allocated in step 1 back in from zswap.
>> + * 5. Set zswap.max to half the amount that was recorded in step 3.
>> + * 6. Attempt to reclaim memory equal to the amount that was allocated,
>> +      this will either trigger writeback if its enabled, or reclamation
>> +      will fail if writeback is disabled as there isn't enough zswap space.
>> + */
>> +static int initiate_writeback(const char *cgroup, void *arg)
>> +{
>> +       char *test_group = arg;
>> +       size_t memsize = MB(4);
>> +       int ret = -1;
>> +       bool wb_enabled = cg_read_long(test_group, "memory.zswap.writeback");
>> +       long zswap_usage;
> Nit: Reverse christmas tree (i.e. is usually more aesthetically
> pleasing, but it isn't consistently followed but up to you. You can
> separate the declaration and initialization of wb_enabled to do that
> if you choose to.
>
Thanks for the review. Will change it in next revision.


>> +
>> +       if (cg_write(test_group, "memory.max", "8M"))
>> +               return ret;
> Why do we need to set this?
Not needed, will remove.
>> +
>> +       /* Allocate random memory to enusre high zswap memory usage */
> typo: ensure
>
>> +       char *mem = (char *)malloc(memsize);
>> +
>> +       if (!mem)
>> +               return ret;
>> +       for (int i = 0; i < memsize; i++)
>> +               mem[i] = rand() % 128;
> I am curious, what compression ratio do you observe in practice with
> this? Is there a risk of pages becoming totally incompressible and
> skipping zswap? One way to guarantee the page compressibility is to
> add a bunch of zeros. I usually fill half of it with zeros and half of
> it with random data. Not sure if this is actually required though.
>
With the default zswap parameters, zswap.current is 3491645, so about 
1.2:1. I had tried a few different zswap parameters and compression was 
still taking place. I initially tried the method from allocate_bytes, 
but the compression was too high with all the zeros and zswap was a 
really small value. Will switch to your method in next revision.

>> +
>> +       /* Try and reclaim allocated memory */
>> +       if (cg_write(test_group, "memory.reclaim", "4M")) {
>> +               ksft_print_msg("Failed to reclaim all of the requested memory\n");
>> +               goto out;
>> +       }
>> +
>> +       zswap_usage = cg_read_long(test_group, "memory.zswap.current");
>> +
>> +       /* zswpin */
>> +       for (int i = 0; i < memsize; i++) {
>> +               if (mem[i] < 0 || mem[i] > 127) {
>> +                       ksft_print_msg("invalid memory\n");
>> +                       ret = -1;
>> +               }
>> +       }
> I understand this correctness check is not strictly needed, but it is
> very weak right now. There is a 50% chance that corruption will be
> missed because the range we are checking is half the possible values.
>
> If we want a reliable correctness check, perhaps we should fill the
> page with increasing known values instead. Then after zswpin, we can
> check that the data is exactly what we filled in the first place.
>
> Is there any value in using random data here? If there is, we can
> store a second copy of the array to compare against instead.
So my thought over here was not to do a correctness check for zswap, 
just to access memory to do zswpin. Switching to the method in the 
comment above, we can do a correctness check as well, so will add that 
in next revision.
>> +
>> +       if (cg_write_numeric(test_group, "memory.zswap.max", zswap_usage/2))
>> +               goto out;
>> +
>> +       /*
>> +        * If writeback is enabled, trying to reclaim memory now will trigger a
>> +        * writeback as zswap.max is half of what was needed when reclaim ran the first time.
>> +        * If writeback is disabled, memory reclaim will fail as zswap is limited and
>> +        * it can't writeback to swap.
>> +        */
>> +       ret = cg_write(test_group, "memory.reclaim", "4M");
>> +       if (!wb_enabled && ret)
> Should we assert that ret is -EBUSY if !wb_enabled instead? Right now
> any error code will pass. The test will also pass if reclaim succeeds
> while writeback is disabled, which is not correct behavior.
I believe its -EAGAIN, but yes will change it.
>> +               ret = 0;
>> +out:
>> +       free(mem);
>> +       return ret;
>> +}
>> +
>> +/* Test to verify the zswap writeback path */
>> +static int test_zswap_writeback(const char *root, bool wb)
>> +{
>> +       int ret = KSFT_FAIL;
>> +       char *test_group;
>> +       long zswpwb_before, zswpwb_after;
>> +
>> +       test_group = cg_name(root,
>> +               wb ? "zswap_writeback_enabled_test" : "zswap_writeback_disabled_test");
> Why do we need different cgroup names? The tests do not run in
> parallel, do they?
>
It makes the tests independent of each other (for e.g. if cg_destroy for 
any magical reason fails for one of the tests, the cgroup creation of 
the other test wont be affected). Plus, I found it easier for debugging 
to examine cgroups after the test was executed. But no strong 
preference, will change it to one name.

>> +       if (!test_group)
>> +               goto out;
>> +       if (cg_create(test_group))
>> +               goto out;
>> +       if (cg_write(test_group, "memory.zswap.writeback", wb ? "1" : "0"))
>> +               return ret;
>> +
>> +       zswpwb_before = get_cg_wb_count(test_group);
>> +       if (zswpwb_before < 0) {
> Should we assert zswpwb_before == 0 instead?
Sure, will do in next revision.
>> +               ksft_print_msg("failed to get zswpwb_before\n");
>> +               goto out;
>> +       }
>> +
>> +       if (cg_run(test_group, initiate_writeback, (void *) test_group))
> Nit: initiate_writeback() is not a very descriptive name because it
> may or may not trigger writeback.
>
>> +               goto out;
>> +
>> +       /* Verify that zswap writeback occurred only if writeback was enabled */
>> +       zswpwb_after = get_cg_wb_count(test_group);
>> +       if (wb) {
>> +               if (zswpwb_after <= zswpwb_before) {
> If we assert zswpwb_before == 0 above, this can be simplified. Also, I
> think a single condition is enough, the message contents can be
> inferred by which test failed.
>
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
>> @@ -425,6 +546,8 @@ struct zswap_test {
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

