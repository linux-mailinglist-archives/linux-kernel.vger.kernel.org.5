Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33897986F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 14:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjIHMXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 08:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjIHMXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697291BEE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 05:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694175781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BhPlFmfDjkoScE/z9HkGq4pyZVDlNbtxuDngmMfLCU4=;
        b=dMbCZGTWXIJ9tbmM/t7DuixG6vSPCAHLwxNkxzcm7jlEDSTid8X76o8z2PQnpHPostgCh+
        fA6CHGzLzxrmlalahEMt87OuN4lFNUcTrsCVuoXoXf7lMmK+pvco3maYMfl9i7XU7JwoRz
        zGLx4aSH5tG5XmIIeqSU5u2iZuydq9I=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-5HAR7KecNBahP_zJ9B0kSg-1; Fri, 08 Sep 2023 08:23:00 -0400
X-MC-Unique: 5HAR7KecNBahP_zJ9B0kSg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a9e12a3093so270938866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 05:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694175779; x=1694780579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhPlFmfDjkoScE/z9HkGq4pyZVDlNbtxuDngmMfLCU4=;
        b=PmatUIUavAu7AmYJbPOZ8AnNm2RFLtNcPdfp+p+pHgePqgJnEd02sdYDjqp6NdeJDn
         yv2LcdL8XET/KCWrUbsSqlFHQxGuPDyLwlo8gW3xhxfUB4JYlcJIRSqO6ZJmhKrk3Zl5
         RnPz2AJ8ynN0nz26oCQZPxNzFRNoDmsej0cBeLPzZ5pbgrrCAMmuyaEV8xDG5+mIQXuu
         zYDnbgJ7KZQbqSQ7yy1gfykP/rzStRFKyuKJsYXHobXwYXgEOUgTKcgpglmZdZ70fOeL
         5Of3PVTdCeEcKEAckHQnwYIIWTCDc7OJFg2GwNZc6ZWx/gRzFi/Ja1JBKxoosXdbwlVh
         NpDQ==
X-Gm-Message-State: AOJu0YymLJZel1qOLyvRoun2IrnPVeqVp+RB88AfS1WdJOFPXiGtzfTe
        DUgmWLib6FBiQUV2iBbTjpmmsZJS2Av7oscE8q/PcNyhQo/mTRpqKh5rdxNJZBLI620sm9ACDqA
        0at7KtFsUpbdBu0sPD89+vbop
X-Received: by 2002:a17:906:9bdb:b0:9a9:f06d:9029 with SMTP id de27-20020a1709069bdb00b009a9f06d9029mr3022418ejc.32.1694175778867;
        Fri, 08 Sep 2023 05:22:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd/1NRhIs49SZXm3jKoUoVGtZpXWs07IbJqMUJVNj2/7BA/w2F4bIjrIpaXglqAXPkeeZHgA==
X-Received: by 2002:a17:906:9bdb:b0:9a9:f06d:9029 with SMTP id de27-20020a1709069bdb00b009a9f06d9029mr3022393ejc.32.1694175778528;
        Fri, 08 Sep 2023 05:22:58 -0700 (PDT)
Received: from [192.168.0.224] (host-82-53-135-115.retail.telecomitalia.it. [82.53.135.115])
        by smtp.gmail.com with ESMTPSA id lc18-20020a170906f91200b0099329b3ab67sm978419ejb.71.2023.09.08.05.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 05:22:57 -0700 (PDT)
Message-ID: <6e095f34-d14a-d81b-5c23-9886b8c799cd@redhat.com>
Date:   Fri, 8 Sep 2023 14:22:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Prevent RT-throttling for idle-injection threads
To:     Atul Kumar Pant <quic_atulpant@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ashayj@quicinc.com, quic_rgottimu@quicinc.com,
        quic_shashim@quicinc.com
References: <20230808112523.2788452-1-quic_atulpant@quicinc.com>
 <20230811111719.17f9965a@gandalf.local.home>
 <20230908095527.GA2475625@hu-atulpant-hyd.qualcomm.com>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20230908095527.GA2475625@hu-atulpant-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/23 11:55, Atul Kumar Pant wrote:
> On Fri, Aug 11, 2023 at 11:17:19AM -0400, Steven Rostedt wrote:
>> On Tue,  8 Aug 2023 16:55:23 +0530
>> Atul Pant <quic_atulpant@quicinc.com> wrote:
>>
>>> Hi all,
>>> We are trying to implement a solution for thermal mitigation by using
>>> idle injection on CPUs. However we face some limitations with the current
>>> idle-inject framework. As per our need, we want to start injecting idle
>>> cycles on a CPU for indefinite time (until the temperature/power of the
>>> CPU falls below a threshold). This will help to keep the hot CPUs in the
>>> sleep state until we see improvement in temperature/power. If we set the
>>> idle duration to a large value or have an idle-injection ratio of 100%,
>>> then the idle-inject RT thread suffers from RT throttling. This results
>>> in the CPU exiting from the sleep state and consuming some power.
>>>
>>> The above situation can be avoided, if we can prevent RT throttling on
>>> the injected CPU. With the currently available sysctl parameters,
>>> sched_rt_runtime_us and sched_rt_period_us, we can prevent RT throttling
>>> by either setting sched_rt_runtime_us equal to sched_rt_period_us or,
>>> setting sched_rt_runtime_us to -1. Since these parameters are system
>>> wide, so it will affect the RT tasks on non idle-injected CPUs as well.
>>> To overcome this, will it be feasible to have these two parameters on a
>>> per CPU basis? This will allow to selectively disable RT throttling on
>>> idle-injected CPUs.
>> I wonder if the deadline scheduler that Daniel is working on would help in this case?
> 		Are you referring to this thread regarding SCHED_DEADLINE server?
> 		https://lore.kernel.org/all/cover.1686239016.git.bristot@kernel.org/T/#u
> 

Yep, but the v4... this will replace rt throttling, and it already has per-cpu arguments.

https://lore.kernel.org/lkml/20230906082952.GB38741@noisy.programming.kicks-ass.net/t/

-- Daniel

