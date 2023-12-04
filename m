Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD7F803601
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjLDOGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbjLDOG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:06:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6DAF0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701698794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iP3CozqrLy0elTpkysoSjmWyp3cgCvt5iYfHQDtR2bY=;
        b=aNqftzjp2kDAdqUqCjSX/yUMRS89IHcFGMoz7DW9U55jUJz18pE29VgyWvHi8clqAPHSGI
        Hy0q2JcBfqsstYIKGcnnNoXC6mhgdoeOZ75NWwKVNu2mtNOGRj5aMT/UVSe9mRjINueAh7
        wL5S8lwKIzQFlEj6KJYChj2++zn6/X0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-JGcVchWOO_-IaCQAH7sWlg-1; Mon, 04 Dec 2023 09:06:29 -0500
X-MC-Unique: JGcVchWOO_-IaCQAH7sWlg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1a582df193so273800666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701698788; x=1702303588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iP3CozqrLy0elTpkysoSjmWyp3cgCvt5iYfHQDtR2bY=;
        b=GL7sdN0Q68q3F1tpKvw9qICimML/MldJcH3basY1pJr6OSIMVF8CUu3PkHXhK7PzNY
         ld0LI7NYUXQ0S39/avmJwGCl18U1pRgkJ2/qRR0Q2CaQWbG/fOdzReRTlz1h4JCWnTcm
         7zKgXuc4G/L2j46uNT66LgyTmbt/l9EW9h186HvCtGT4Jglp9Y3kijl/8+oOhBUqkmi3
         cdIRzgVkUHkvqHQV5bO5612aF3S31F4yTD4L6DANjkqcsV2f9FNXeD8Xyz8bQ9YyMljw
         RrKG0mzL6gR28y1omJJrDjz80zAQgqpCiLGDt29ozUTqshIS8FyH4TPojyZtEc2RMQbs
         5bdQ==
X-Gm-Message-State: AOJu0YwF94Idp5oOeVkAGId/Iu066tstxSKgCtEYNIrDxtqf619wxoE6
        qNJyz6RucZe/ATdBOJbjS7FArt2yJEdGSXJ17+ToHmsuK9dOqjIz/xp+INFimll7K4ZeY1uU3HU
        5JGtXy3y/NveRLT5KzgOQSs0c
X-Received: by 2002:a17:907:a1a4:b0:a19:a409:37f3 with SMTP id om36-20020a170907a1a400b00a19a40937f3mr4028373ejc.76.1701698787970;
        Mon, 04 Dec 2023 06:06:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXAAxBoQkos/LUHu6WztgWbNUZ+1f6cABFS8k0RcUbcpnslt++Dhqr0L63KVtgnFx5Z0/G5w==
X-Received: by 2002:a17:907:a1a4:b0:a19:a409:37f3 with SMTP id om36-20020a170907a1a400b00a19a40937f3mr4028356ejc.76.1701698787653;
        Mon, 04 Dec 2023 06:06:27 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id sa12-20020a1709076d0c00b009fd585a2155sm5307858ejc.0.2023.12.04.06.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 06:06:27 -0800 (PST)
Message-ID: <f981896a-1c90-4475-84e8-7d459ffb97ed@redhat.com>
Date:   Mon, 4 Dec 2023 15:06:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] TPMI update for permissions
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231130214751.3100418-1-srinivas.pandruvada@linux.intel.com>
 <e84824057954fa8593783c4433f5b535f0da6490.camel@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <e84824057954fa8593783c4433f5b535f0da6490.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On 12/1/23 00:24, srinivas pandruvada wrote:
> On Thu, 2023-11-30 at 13:47 -0800, Srinivas Pandruvada wrote:
>> Process read/write and enabled state for feature drivers. When a
>> feature
>> is disabled, don't create a device to load a feature driver. When a
>> read
>> is blocked then don't load feature drivers. When write is blocked
>> continue
>> to function in read only mode.
>>
>> v2:
>>         Dropped patch platform/x86/intel/tpmi: Add additional TPMI
>> header fields
>>         Addressed other review comments, details are in each patch
>>
> lkp@intel.com is complaining that these patches can't be applied. I
> will fix any issue after review and post v3 if required.

Thanks.

I guess this may conflict with or depend on:

"[PATCH V6 00/20] intel_pmc: Add telemetry API to read counters"

which I have just merged into pdx86/review-hans, please make
sure your next version on top of pdx86/review-hans.

Regards,

Hans


> 
> Thanks,
> Srinivas
> 
> 
>> Srinivas Pandruvada (5):
>>   platform/x86/intel/tpmi: Don't create devices for disabled features
>>   platform/x86/intel/tpmi: Modify external interface to get
>> read/write
>>     state
>>   platform/x86/intel/tpmi: Move TPMI ID definition
>>   platform/x86: ISST: Process read/write blocked feature status
>>   platform/x86/intel-uncore-freq: Process read/write blocked feature
>>     status
>>
>>  .../intel/speed_select_if/isst_tpmi_core.c    | 25 +++++++++++++
>>  drivers/platform/x86/intel/tpmi.c             | 35 +++++++++--------
>> --
>>  .../uncore-frequency/uncore-frequency-tpmi.c  | 15 ++++++++
>>  include/linux/intel_tpmi.h                    | 18 ++++++++--
>>  4 files changed, 72 insertions(+), 21 deletions(-)
>>
> 

