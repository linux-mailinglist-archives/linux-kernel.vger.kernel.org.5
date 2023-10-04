Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322177B7CB0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241778AbjJDJ5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjJDJ5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:57:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ED8B7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696413374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t3llrRzvIKILbc5TgXedn7Q8bVVVp8C9PO7vaMagqQM=;
        b=KfOgvGhtWWXIDiHsVzot17IqnJqvP0CbNDUekwdQzS4/laUj2w9PX5kinjz7QGC+RcqOg2
        WJFNXwhFuPayArBfwjvc0ttyYwU6WuqqYuVo9A3qefM165hb8aTeVC2fc9YKbDL1maSbk5
        1aiZdVC7ImJG3rfBs4xtbpIRWZ38b9c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-qFRuRX92NemM2NI2simB4A-1; Wed, 04 Oct 2023 05:55:58 -0400
X-MC-Unique: qFRuRX92NemM2NI2simB4A-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-533ca50404bso1607340a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 02:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696413357; x=1697018157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3llrRzvIKILbc5TgXedn7Q8bVVVp8C9PO7vaMagqQM=;
        b=l2ujlvLyV7dKZdI1LlEU6jT/G2ZX7U8nlP3T3ovhaNrI5+utGxIIp9Fcx/tFUIo7Ye
         QQZITGz7Iv2adbC5vFvicv0UOelgnBRSfqB8JsN7yLUs6NSYIYi/VC769WN71lp6Zi/+
         yBzu+qox6oslf8uK1oYgirap5189Z2KDWFPj3/OEZfS8Y6mh2NwvTgHSMPKnXvfSWBDv
         wI6XSmovUoOqJsr51HOmSL85RZIAASEAa5MDEimwZTZatWkcN0KH5CQHRTb7jC3plyq5
         j2BwN10at34nlWRB3ptTLrdnt1n7Tgn/UgpduKol+rhtdcdLnR7cc7806gwFr926pr25
         kpmQ==
X-Gm-Message-State: AOJu0YxFtiTHXwwNuwu5kbxMoIzpbn3PNNatuZAaxd8WXcgSWalpTYjc
        Y9AjB7Vu52h0yswvqF43Eknb3xvCfYegFLyFYjOf4fAin9XuZyFIrRd7OJaWxHmexuhO2EixRb0
        LfAu9EO8UdhOVDkXStXY3tguN
X-Received: by 2002:a50:fb12:0:b0:536:e03f:62b6 with SMTP id d18-20020a50fb12000000b00536e03f62b6mr1522887edq.30.1696413357193;
        Wed, 04 Oct 2023 02:55:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9V7fiXYUDKWE6UMTUNBgtOKzLLtTO5ZqS9lXx9adtCMpIzRBwm8IhSJIk/MU1t/HJfHyOtg==
X-Received: by 2002:a50:fb12:0:b0:536:e03f:62b6 with SMTP id d18-20020a50fb12000000b00536e03f62b6mr1522871edq.30.1696413356839;
        Wed, 04 Oct 2023 02:55:56 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id dy26-20020a05640231fa00b005256771db39sm2170533edb.58.2023.10.04.02.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 02:55:56 -0700 (PDT)
Message-ID: <bce65f65-66d9-3242-4656-7b2266a0e010@redhat.com>
Date:   Wed, 4 Oct 2023 11:55:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] platform/x86/intel/ifs: release cpus_read_lock()
Content-Language: en-US, nl
To:     Jithu Joseph <jithu.joseph@intel.com>, markgross@kernel.org
Cc:     ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev
References: <20230927184824.2566086-1-jithu.joseph@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230927184824.2566086-1-jithu.joseph@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/27/23 20:48, Jithu Joseph wrote:
> Couple of error paths in do_core_test() was returning directly without
> doing a necessary cpus_read_unlock().
> 
> Following lockdep warning was observed when exercising these scenarios
> with PROVE_RAW_LOCK_NESTING enabled:
> 
> [  139.304775] ================================================
> [  139.311185] WARNING: lock held when returning to user space!
> [  139.317593] 6.6.0-rc2ifs01+ #11 Tainted: G S      W I
> [  139.324499] ------------------------------------------------
> [  139.330908] bash/11476 is leaving the kernel with locks still held!
> [  139.338000] 1 lock held by bash/11476:
> [  139.342262]  #0: ffffffffaa26c930 (cpu_hotplug_lock){++++}-{0:0}, at:
> do_core_test+0x35/0x1c0 [intel_ifs]
> 
> Fix the flow so that all scenarios release the lock prior to returning
> from the function.
> 
> Fixes: 5210fb4e1880 ("platform/x86/intel/ifs: Sysfs interface for Array BIST")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

Thank you for your patch/series, I've applied this patch
(series) to the pdx86 fixes branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in the pdx86 fixes branch once I've pushed
my local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans





> ---
>  drivers/platform/x86/intel/ifs/runtest.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
> index 1061eb7ec399..43c864add778 100644
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c
> @@ -331,14 +331,15 @@ int do_core_test(int cpu, struct device *dev)
>  	switch (test->test_num) {
>  	case IFS_TYPE_SAF:
>  		if (!ifsd->loaded)
> -			return -EPERM;
> -		ifs_test_core(cpu, dev);
> +			ret = -EPERM;
> +		else
> +			ifs_test_core(cpu, dev);
>  		break;
>  	case IFS_TYPE_ARRAY_BIST:
>  		ifs_array_test_core(cpu, dev);
>  		break;
>  	default:
> -		return -EINVAL;
> +		ret = -EINVAL;
>  	}
>  out:
>  	cpus_read_unlock();
> 
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072

