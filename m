Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1504A7BF9F7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjJJLlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjJJLlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:41:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F48A9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696938059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7b+DAP28sjjsKl/NqKK+vQ1oprFAwolNlLR6iIJGZc4=;
        b=IfyY5dGZQiYpREyiZ9Vc1j0UapH1v4A0RN/m8AFP2mqkJqvP3ikgZsf9u6Kq/QZBIQ5zXA
        /IoCBw52r90Xat308XUWIJcPZmG42215ViW2EzHHWCtHht6ZmbMmIGuZkmOT/fkLwhYbC9
        guq1i+aQtvhrT9yPZ+Y50NH0Fw3IxLA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-dZptYBrWP9-I7eOBbCEa8w-1; Tue, 10 Oct 2023 07:40:58 -0400
X-MC-Unique: dZptYBrWP9-I7eOBbCEa8w-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-531373ea109so2012174a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696938057; x=1697542857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7b+DAP28sjjsKl/NqKK+vQ1oprFAwolNlLR6iIJGZc4=;
        b=jF0KE8F6iKQmYAGi0pOm/l1cH7AKE3nNdSwTBct519HmFrAe3eBdxlhhZICNe/u01c
         Q3VcL4GLWWANtyqewbLAka1mx2ktq4jAowxxB1UPbhlG0iZ+OxAf4B6VHzoHB7OtQgBZ
         yQpIleDHPn99HlBTVllvhil3paHekxJ38Xo/FY7AKEBrUxqkK1R6MDYUXY4jywgK/MiT
         A6Qsoj/DfTds2lPq52Sktc8ZKcD+h6qEyyucG98WX6bYHhsPJIwA0Ib1qBwqVCAupmdJ
         grdKroSXCTrrOKCtudQHCmXfcXvXeQLQ8BZyMAM1Ld5ktb0AjO7jD6WDatVNqpG6FllI
         wyIg==
X-Gm-Message-State: AOJu0Yw8GHivc/2HHjubRxt6kGzImno2ECdIXXZw/V1Fa270Jniy2bX8
        d8KHb90u32be/K2wnG7EZDFBoopvPO7mfkWecjWkmsMrVvlw0wk9nPaHy/Up3Ns54moVqt9+Pyd
        p0mav6NxdCHdxYMXtokUBg697
X-Received: by 2002:a05:6402:1a28:b0:522:3849:48d8 with SMTP id be8-20020a0564021a2800b00522384948d8mr16557034edb.9.1696938057298;
        Tue, 10 Oct 2023 04:40:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPF6rjIP1ClGozgmSVb/QcNq4AcdaAeAz8RfeTFDOEmM1d6yjpTu+LVxF0w32sc6yh+3zyzQ==
X-Received: by 2002:a05:6402:1a28:b0:522:3849:48d8 with SMTP id be8-20020a0564021a2800b00522384948d8mr16557009edb.9.1696938056965;
        Tue, 10 Oct 2023 04:40:56 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:4783:a68:c1ee:15c5? ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
        by smtp.googlemail.com with ESMTPSA id w15-20020aa7cb4f000000b0052a063e52b8sm7516724edt.83.2023.10.10.04.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 04:40:56 -0700 (PDT)
Message-ID: <5c19c422-41ad-430b-664c-15f3e2087922@redhat.com>
Date:   Tue, 10 Oct 2023 13:40:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] kvm/sev: make SEV/SEV-ES asids configurable
To:     Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jos=c3=a9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
Cc:     seanjc@google.com, skhan@linuxfoundation.org,
        dave.hansen@linux.intel.com, kvm@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, tglx@linutronix.de,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20231010100441.30950-1-jose.pekkarinen@foxhound.fi>
 <2023101050-scuff-overstay-9b43@gregkh>
Content-Language: en-US
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <2023101050-scuff-overstay-9b43@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 13:35, Greg KH wrote:
> On Tue, Oct 10, 2023 at 01:04:39PM +0300, José Pekkarinen wrote:
>> There are bioses that doesn't allow to configure the
>> number of asids allocated for SEV/SEV-ES, for those
>> cases, the default behaviour allocates all the asids
>> for SEV, leaving no room for SEV-ES to have some fun.

In addition to what Greg pointed out (and there are many more cases that 
have to be checked for errors, including possible overflows), why is it 
correct to just ignore what's in CPUID?

Paolo

> "fun"?
> 
> Also, please use the full 72 columns for your changelog.
> 
>> If the user request SEV-ES to be enabled, it will
>> find the kernel just run out of resources and ignored
>> user request. This following patch will address this
>> issue by making the number of asids for SEV/SEV-ES
>> configurable over kernel module parameters.
>>
>> Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
>> ---
>>   arch/x86/kvm/svm/sev.c | 28 +++++++++++++++++++++++-----
>>   1 file changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index 07756b7348ae..68a63b42d16a 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -51,9 +51,18 @@
>>   static bool sev_enabled = true;
>>   module_param_named(sev, sev_enabled, bool, 0444);
>>   
>> +/* nr of asids requested for SEV */
>> +static unsigned int requested_sev_asids;
>> +module_param_named(sev_asids, requested_sev_asids, uint, 0444);
>> +
>>   /* enable/disable SEV-ES support */
>>   static bool sev_es_enabled = true;
>>   module_param_named(sev_es, sev_es_enabled, bool, 0444);
>> +
>> +/* nr of asids requested for SEV-ES */
>> +static unsigned int requested_sev_es_asids;
>> +module_param_named(sev_es_asids, requested_sev_asids, uint, 0444);
> 
> Why more module parameters?  Why can't this "just work" properly without
> forcing a user to make manual changes?  This isn't the 1990's anymore.
> 
> 
>> +
>>   #else
>>   #define sev_enabled false
>>   #define sev_es_enabled false
>> @@ -2194,6 +2203,11 @@ void __init sev_hardware_setup(void)
>>   	if (!max_sev_asid)
>>   		goto out;
>>   
>> +	if (requested_sev_asids + requested_sev_es_asids > max_sev_asid) {
>> +		pr_info("SEV asids requested more than available: %u ASIDs\n", max_sev_asid);
> 
> Why isn't this an error?
> 
> thanks,
> 
> greg k-h
> 

