Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBF481257E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443005AbjLNCtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjLNCtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:49:04 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77ED18D;
        Wed, 13 Dec 2023 18:48:50 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7b45ab9e084so319168939f.2;
        Wed, 13 Dec 2023 18:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702522130; x=1703126930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sN1Y7WcSaLQMLijDMl3xv5IoXDMoGtBRoqudyg9OXAI=;
        b=N0u43h5gYkRtQAMyjdzgZm2YXSZn8zUkGmkEnqg4PXqXB//kV2VHje4AYkgbPIWymb
         3i9S6RbCvWnrDQYWS5RAalvrWMAtH9XTg3+EDrCACMpXEsD3N4mahrcsY3ii+Uvba6C0
         FWCrmuQ/MQEGTSvDSotqDrlnczpbv7+jV2KzlM8McTKHV/iOUBZwX2sDrGiU0tiLBzKS
         aRYbUGB8EoDKOt2F5CZwGpfLx84WsZZm0uHi0uWHBMIFRS6kaEoIZ+l8IZz6ARx33Y08
         uKhGdfLJQ9t/4B7V6tuNQhl4cc7Dy4pw8NnkGZDBteUR+jn6unixKrI47CqXpD5p7K6v
         GHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702522130; x=1703126930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sN1Y7WcSaLQMLijDMl3xv5IoXDMoGtBRoqudyg9OXAI=;
        b=sxTjaHWqYkcb4owNAhYBxkyGEC11RsfEtzm4ni4wSIFpaHHFISYxrB63OSkn74GzKD
         92lA4xojLfBBG6n7AZ8TUqD17Brk1f7oFR92KbsBM1SElTsPkG1KWtYTTlS4DXY/qAGN
         EGqXznH2k85YW7UXlLybqNRngc9JEPwiNbnxmCAGP4C3gMaKao23VB96t3cbFx2s3EQu
         WEmDbH0m5Eh319bKkIfYT2kzRooj9oZjdmuZ3HXYA6kpDHYdqMvLmQpilJ1hpWC1pa4w
         RshjATiisI2uZ3Qrk36aZsAecCf4iZZqE5hOx9SbVWPyba6ShmtrQ1ZLxf7h9Z6IV5CL
         aPKw==
X-Gm-Message-State: AOJu0Yw8FKNUxrTIjn4SLUPyZIgV4e3Ysa9sK6Krrf4nMF4Cplb+LsUU
        gWaVVYfVAo19wfZB0+8g7X0=
X-Google-Smtp-Source: AGHT+IEXRG3V6shfxHFbYX2s3HftithXAitcUvLKtpPf95bYI57mWEOBIF148K4iNNfK2UfX1O2Zuw==
X-Received: by 2002:a05:6e02:1be1:b0:35d:65e0:a433 with SMTP id y1-20020a056e021be100b0035d65e0a433mr13284653ilv.2.1702522130052;
        Wed, 13 Dec 2023 18:48:50 -0800 (PST)
Received: from [192.168.255.10] ([203.205.141.87])
        by smtp.gmail.com with ESMTPSA id i18-20020a17090332d200b001d076ebf328sm11285033plr.8.2023.12.13.18.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 18:48:49 -0800 (PST)
Message-ID: <9d8c8900-699e-4879-8aca-d9371e77f097@gmail.com>
Date:   Thu, 14 Dec 2023 10:48:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf header: Set proper symbol name for vdso when
 build-id event found
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <20231201111506.37155-1-likexu@tencent.com>
 <f50149fb-967c-4987-8d08-d6bb2a69bcf3@intel.com>
Content-Language: en-US
From:   Like Xu <like.xu.linux@gmail.com>
In-Reply-To: <f50149fb-967c-4987-8d08-d6bb2a69bcf3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2023 3:26 am, Adrian Hunter wrote:
> On 1/12/23 13:15, Like Xu wrote:
>> From: Like Xu <likexu@tencent.com>
>>
>> If using perf-record to sample a cpu-cycles:P event on a hypervisor process
>> when '--kcore' is not enabled, user may find some surprise in perf-report:
>>
>> # perf report -i perf.data -v:
>> # Overhead Command   Shared Object            	Symbol
>>      99.71%  vcpu0    arch/x86/kvm/kvm-intel.ko  0xffffffffa10d1e30 B [k] 0x0000000000034ed0
>>
>> build id event received for vmlinux: d12116149f511f7dbd0b21c45d38d3d2ec09b87f [20]
>> build id event received for kvm-intel.ko: a8fc0213abbafd97b10ce58ce84bec8519f9abce [20]
>> build id event received for [vdso]: 4d56e381df8d2c051f6bc1ef69c0118c59d5c49f [20]
>>
>> # perf report:
>> # Overhead  Command  Shared Object     Symbol
>> # ........  .......  ................  .......................................
>> #
>>      99.71%  vcpu0    [kvm_intel]       [k] 0x0000000000034ed0
>>       0.10%  vcpu0    [kernel.vmlinux]  [k] __lock_acquire.isra.29
>>
>> Users may be curious as to how 0x34ed0 was generated and wondered if this
>> RIP came from the guest application but perf-script-D does not point to any
>> samples of this address.
>>
>> Based on perf/tool implementation, this is actually an offset pointing to
>> the vdso object (in this case it is the assembly __vmx_vcpu_run defined
>> in arch/x86/kvm/vmx/vmenter.S). The pattern is not reproduced on perf-tool
>> of some distributions, and git-bisect quickly identified the possible root
>> cause, which leds to this straightforward fix and after this change:
>>
>> # perf report -i perf.data -v:
>> # Overhead Command   Shared Object            	Symbol
>>      99.71%  vcpu0    arch/x86/kvm/kvm-intel.ko  0x34ed0            B [k] __vmx_vcpu_run
>>
>> # perf report:
>> # Overhead  Command  Shared Object     Symbol
>> # ........  .......  ................  .......................................
>> #
>>      99.71%  vcpu0    [kvm_intel]       [k] __vmx_vcpu_run
>>
>> The fix also gets commit 1deec1bd96cc ("perf header: Set proper module name
>> when build-id event found") lit again.
>>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Ian Rogers <irogers@google.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Fixes: b2fe96a350de ("perf tools: Fix module symbol processing")
>> Signed-off-by: Like Xu <likexu@tencent.com>
>> ---
>>   tools/perf/util/header.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>> index e86b9439ffee..a33d589511ff 100644
>> --- a/tools/perf/util/header.c
>> +++ b/tools/perf/util/header.c
>> @@ -2305,8 +2305,8 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
>>   
>>   			if (!kmod_path__parse_name(&m, filename) && m.kmod)
>>   				dso__set_module_info(dso, &m, machine);
>> -
>> -			dso->kernel = dso_space;
>> +			else
>> +				dso->kernel = dso_space;
> 
> This is undoing some of b2fe96a350de ("perf tools: Fix module
> symbol processing") without explanation.

Thanks for your comments.
W/ this fix, "perf test -v object" looks OK.

> 
> Symbols in the .noinstr.text section don't seem to be
> being resolved, so that could be the issue.  perf synthesizes
> an MMAP record from /proc/modules, which works for .text
> but perhaps not for .noinstr.text

Not sure if it covers the potentially broken features you mentioned above,
would you be willing to provide a more detailed test command ?

> 
>>   			free(m.name);
>>   		}
>>   
> 
