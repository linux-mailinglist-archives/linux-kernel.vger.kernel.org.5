Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D9E7A497D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241915AbjIRMXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241423AbjIRMXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:23:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B50BA0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695039742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZJHCjeshTod0mBtUAlW/a8kmwzZB3bOBG+U2CpfWvjM=;
        b=Ysi2lrAI56m+64okCocfwVDXjg+2CrFMwkn0qV/QYyTE+ZhnhKDsLhEbknM1HN/JDlTCVp
        bD0NSTCWN7dYzJEmgiEUAcg2E4/uVJ9Www9KZoZHUIxhSMVnjj176mwAnUrqcNbtp3FsF8
        t2m0kZ8GXMSHbbakcMDlR7/uiUfaiY4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-OYAdsIBvMiWsgAvpgYUXSg-1; Mon, 18 Sep 2023 08:22:21 -0400
X-MC-Unique: OYAdsIBvMiWsgAvpgYUXSg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30932d15a30so2951404f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695039740; x=1695644540;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJHCjeshTod0mBtUAlW/a8kmwzZB3bOBG+U2CpfWvjM=;
        b=e8sfRdWHFldJA7I7GPK/jEGvxi/bXPFaGUKRgEv1B2bKmHkSJqoFGI8hOaKWmMMcVo
         XJXgO37UHx1B+W5Wm0a52rT2FqzrUdHeL+9q1bIDtcANi1l1kkmY9fymasoYWLebWQPH
         ANmTSb30vCXSQWX4+Yc0TV5xN1wCTD1/jr6YYVfVbx1TTiTAdgdZKzYDLP9FWXMbCyJ3
         uQzQLZi7EoXdXJ4oEYGNavenJFoHCHtBxBAuzqgoGx2dI5u4l0w14eH4fSP/laAQizHC
         k/8vZqQXj5ke18F/2fzAsgcKxDleOQKIQlP2NBRENJJ+TgyEfja/GY7p76wZQsyaWhrx
         mIkg==
X-Gm-Message-State: AOJu0Ywk/BBEB7RvVI1t3JcYt4KGmYOAgec0+wwXQi6orTjyTNu3vdX2
        l87Qo2uCwtICxBvHZDp9exEb2/MA/vpaRftVjS4TB6mBgASGxMMIHJT08SFAwXS++G+sfDJhMIw
        IUJYzSQbbt7m6KoeG6W2mQKfv
X-Received: by 2002:a5d:4a50:0:b0:317:6175:95fd with SMTP id v16-20020a5d4a50000000b00317617595fdmr6802157wrs.43.1695039739845;
        Mon, 18 Sep 2023 05:22:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJhpmJ38m8RKDJrG8Pabddv8tBjaD+dmtUhuyWEuM1UhdpBXuZ6K+XdRqKtojUWAkoaJr5Vg==
X-Received: by 2002:a5d:4a50:0:b0:317:6175:95fd with SMTP id v16-20020a5d4a50000000b00317617595fdmr6802141wrs.43.1695039739495;
        Mon, 18 Sep 2023 05:22:19 -0700 (PDT)
Received: from vschneid.remote.csb (anice-256-1-26-111.w86-203.abo.wanadoo.fr. [86.203.135.111])
        by smtp.gmail.com with ESMTPSA id q11-20020adff50b000000b0031c71693449sm12572024wro.1.2023.09.18.05.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 05:22:18 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, quentin.perret@arm.com,
        srikar@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, pierre.gondois@arm.com, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v3] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
In-Reply-To: <bd8a3c47-80f5-61f3-b884-85a7ee92767d@linux.vnet.ibm.com>
References: <20230913114807.665094-1-sshegde@linux.vnet.ibm.com>
 <xhsmhil8cvi7s.mognet@vschneid.remote.csb>
 <7c6dd2ec-b9a9-b364-5a29-05336127e519@linux.vnet.ibm.com>
 <xhsmhfs3fve7k.mognet@vschneid.remote.csb>
 <bd8a3c47-80f5-61f3-b884-85a7ee92767d@linux.vnet.ibm.com>
Date:   Mon, 18 Sep 2023 14:22:17 +0200
Message-ID: <xhsmha5tjvfgm.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/23 23:40, Shrikanth Hegde wrote:
> On 9/15/23 5:30 PM, Valentin Schneider wrote:
>> On 14/09/23 23:26, Shrikanth Hegde wrote:
>>> On 9/14/23 9:51 PM, Valentin Schneider wrote:
>>>> On 13/09/23 17:18, Shrikanth Hegde wrote:
>>>>> sysctl_sched_energy_aware is available for the admin to disable/enable
>>>>> energy aware scheduling(EAS). EAS is enabled only if few conditions are
>>>>> met by the platform. They are, asymmetric CPU capacity, no SMT,
>>>>> valid cpufreq policy, frequency invariant load tracking. It is possible
>>>>> platform when booting may not have EAS capability, but can do that after.
>>>>> For example, changing/registering the cpufreq policy.
>>>>>
>>>>> At present, though platform doesn't support EAS, this sysctl is still
>>>>> present and it ends up calling rebuild of sched domain on write to 1 and
>>>>> NOP when writing to 0. That is confusing and un-necessary.
>>>>>
>>>>
>>>
>>> Hi Valentin, Thanks for taking a look at this patch.
>>>
>>>> But why would you write to it in the first place? Or do you mean to use
>>>> this as an indicator for userspace that EAS is supported?
>>>>
>>>
>>> Since this sysctl is present and its value being 1, it gives the
>>> impression to the user that EAS is supported when it is not.
>>> So its an attempt to correct that part.
>>>
>> 
>> Ah, I see. Then how about just making the sysctl return 0 when EAS isn't
>> supported? And on top of it, prevent all writes when EAS isn't supported
>> (perf domains cannot be built, so there would be no point in forcing a
>> rebuild that will do nothing).
>
> Yes. That's another way. Thats what I had as possible approach in 
> https://lore.kernel.org/lkml/d2c945d6-c4f0-a096-0623-731b11484f51@linux.vnet.ibm.com/
>

Thanks for the link; and apologies for bringing up topics that have been
discussed already.

>
>
>> 
>> I can never remember how to properly use the sysctl API, so that's a very
>> crude implementation, but something like so?
>> 
>> ---
>> 
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 05a5bc678c089..dadfc5afc4121 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -230,9 +230,28 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
>>  	if (write && !capable(CAP_SYS_ADMIN))
>>  		return -EPERM;
>> 
>> +	if (!sched_energy_enabled()) {
>
> Use of sched_energy_enabled won't work as Pierre has indicated. 
>
> Instead this can be done by adding those checks in a helper function to
> do similar checks as done build_perf_domains. 
>
> I can send v4 with this approach if it makes more sense. Please let me know.
>

So what I'm thinking is the standard approach seems to be to keep the knobs
visible, but change how reads/writes to them are handled.

For instance, SMT support has

  /sys/devices/system/cpu/smt
    /control
    /active

And a system with CONFIG_HOTPLUG_SMT=y but no actual hardware SMT will
have:

    /control = notsupported
    /active  = 0

So IMO it would make sense to keep sched_energy_aware around, but make it
read 0 and prevent writes for systems that have the software support
compiled but don't have the actual hardware support.

In a pinch it also helps to know if CONFIG_ENERGY_MODEL was selected,
though that's obvious enough with CONFIG_SCHED_DEBUG=y.

