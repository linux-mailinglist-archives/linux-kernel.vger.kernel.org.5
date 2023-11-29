Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2398C7FDABE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjK2PE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjK2PE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:04:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC56BE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701270303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8z5muuD6V1KzLPtZY1t02hDIxFyhn4XoZnCFtfZqR98=;
        b=jMSIZZpyvz7PnqZVd3huWCedlHw1XXWWvhM0+yXp9zV3HtAL+GIwIiKOma1mATTU/xtGnx
        8Zx8IKBjJrjkgYrWVI2Up5/wZ1cbIwncOEaJCnai2hGBtS7z9lHj7IDVEZhLTwHVfd7cgf
        oEAFyOsDWx4MNw+UntExCZtSsu3Ep6I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-PMYPSCRiMb2M_IDFvHyGyQ-1; Wed, 29 Nov 2023 10:05:01 -0500
X-MC-Unique: PMYPSCRiMb2M_IDFvHyGyQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-77dc5712a8fso180031085a.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701270300; x=1701875100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8z5muuD6V1KzLPtZY1t02hDIxFyhn4XoZnCFtfZqR98=;
        b=KRAbmJrVRhff/QhWwIbmnaDy6jLybOYUXtHPUunzhG8h0KClDmcfgL8L0y2obMS8Py
         9+xm5UdbyP3Ubd3tTHaWUzY1yUkGJFkKKio0gsR3LpHOZtTdAkic4P59UK0FUr6a4bSu
         CNgrfCYKN3KfKnfifa5iWy+VyEGwo/8wU2KAt8oksNy7YB6uV2YXZ8ROHltHr3pk0+oG
         oxJdghix7x0BOBtSwMjrswgfLVS46lXIJ+i9RvoktbHZe5A/K75hJV1RSNYMgMtqvK7W
         4ybER11XAEcezBpypBw2V08LRTfwur+zzTop4jMeImZyt2jCaW6Pfdf2K2d36phrnwO7
         0Jlg==
X-Gm-Message-State: AOJu0YzKNNEZOf9iOZ4juq6m9X20S30qxD1kQLf3WLudshHfZZCy5+N9
        Lw3XncOCUPtUNX90PHT1KUUbZ8+1kPnyNattibylfYZ0e0l/UcERbRVJsXGNfkhsrgLvrNOLE8n
        rJC7HLf00y5HbP+5OJ6HOPBCOLknF7K4+
X-Received: by 2002:a05:620a:5236:b0:77b:9dd3:2f90 with SMTP id dc54-20020a05620a523600b0077b9dd32f90mr17517937qkb.34.1701270300474;
        Wed, 29 Nov 2023 07:05:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvYpEYtE1T0sVGQwzqNs5Yi4iXvBXcBME7iILi/8YhHs4ze5Gl0mMk/l8xbMuZGRLRaaZmzQ==
X-Received: by 2002:a05:620a:5236:b0:77b:9dd3:2f90 with SMTP id dc54-20020a05620a523600b0077b9dd32f90mr17517904qkb.34.1701270300022;
        Wed, 29 Nov 2023 07:05:00 -0800 (PST)
Received: from [192.168.40.28] ([216.212.61.246])
        by smtp.gmail.com with ESMTPSA id ea11-20020a05620a488b00b0077d93c7c785sm3781530qkb.119.2023.11.29.07.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 07:04:59 -0800 (PST)
Message-ID: <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
Date:   Wed, 29 Nov 2023 10:03:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc:     Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
        Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv> <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
From:   Donald Dutile <ddutile@redhat.com>
In-Reply-To: <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan,
hi!

On 11/29/23 3:10 AM, Baoquan He wrote:
> On 11/28/23 at 10:08am, Michal Hocko wrote:
>> On Tue 28-11-23 10:11:31, Baoquan He wrote:
>>> On 11/28/23 at 09:12am, Tao Liu wrote:
>> [...]
>>> Thanks for the effort to bring this up, Jiri.
>>>
>>> I am wondering how you will use this crashkernel=,cma parameter. I mean
>>> the scenario of crashkernel=,cma. Asking this because I don't know how
>>> SUSE deploy kdump in SUSE distros. In SUSE distros, kdump kernel's
>>> driver will be filter out? If latter case, It's possibly having the
>>> on-flight DMA issue, e.g NIC has DMA buffer in the CMA area, but not
>>> reset during kdump bootup because the NIC driver is not loaded in to
>>> initialize. Not sure if this is 100%, possible in theory?
>>
>> NIC drivers do not allocation from movable zones (that includes CMA
>> zone). In fact kernel doesn't use GFP_MOVABLE for non-user requests.
>> RDMA drivers might and do transfer from user backed memory but for that
>> purpose they should be pinning memory (have a look at
>> __gup_longterm_locked and its callers) and that will migrate away from
>> the any zone.
> 
> Add Don in this thread.
> 
> I am not familiar with RDMA. If we reserve a range of 1G meory as cma in
> 1st kernel, and RDMA or any other user space tools could use it. When
> corruption happened with any cause, that 1G cma memory will be reused as
> available MOVABLE memory of kdump kernel. If no risk at all, I mean 100%
> safe from RDMA, that would be great.
> 
My RDMA days are long behind me... more in mm space these days, so this still
interests me.
I thought, in general, userspace memory is not saved or used in kdumps, so
if RDMA is using cma space for userspace-based IO (gup), then I would expect
it can be re-used for kexec'd kernel.
So, I'm not sure what 'safe from RDMA' means, but I would expect RDMA queues
are in-kernel data structures, not userspace strucutures, and they would be
more/most important to maintain/keep for kdump saving.  The actual userspace
data ... ssdd wrt any other userspace data.
dma-buf's allocated from cma, which are (typically) shared with GPUs
(& RDMA in GPU-direct configs), again, would be shared userspace, not
control/cmd/rsp queues, so I'm not seeing an issue there either.

I would poke the NVIDIA+Mellanox folks for further review in this space,
if my reply leaves you (or others) 'wanting'.

- Don
>>   
>> [...]
>>> The crashkernel=,cma requires no userspace data dumping, from our
>>> support engineers' feedback, customer never express they don't need to
>>> dump user space data. Assume a server with huge databse deployed, and
>>> the database often collapsed recently and database provider claimed that
>>> it's not database's fault, OS need prove their innocence. What will you
>>> do?
>>
>> Don't use CMA backed crash memory then? This is an optional feature.
>>   
>>> So this looks like a nice to have to me. At least in fedora/rhel's
>>> usage, we may only back port this patch, and add one sentence in our
>>> user guide saying "there's a crashkernel=,cma added, can be used with
>>> crashkernel= to save memory. Please feel free to try if you like".
>>> Unless SUSE or other distros decides to use it as default config or
>>> something like that. Please correct me if I missed anything or took
>>> anything wrong.
>>
>> Jiri will know better than me but for us a proper crash memory
>> configuration has become a real nut. You do not want to reserve too much
>> because it is effectively cutting of the usable memory and we regularly
>> hit into "not enough memory" if we tried to be savvy. The more tight you
>> try to configure the easier to fail that is. Even worse any in kernel
>> memory consumer can increase its memory demand and get the overall
>> consumption off the cliff. So this is not an easy to maintain solution.
>> CMA backed crash memory can be much more generous while still usable.
>> -- 
>> Michal Hocko
>> SUSE Labs
>>
> 

