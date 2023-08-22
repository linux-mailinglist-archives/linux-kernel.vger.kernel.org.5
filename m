Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89B4784848
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjHVRQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjHVRQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4978F3AA1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692724518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uX3hEgT9OaTc56WxcxfgV39D2MhUSnY7cY3oVqgL/Pg=;
        b=fp4HeX7d4oSzUTIfR2VR5PhEsugkc2pdYieZF158F7aAt9u3EE2WT2TShPmJNC7Ckkg9PV
        nryipzRMEtu1C18WUEO16A5lQp8rmG3O9aJJH2tnUp8nt/oR0KLrsV48ZzuRXWNy3qE+AY
        qGOgvg8m/NhKeg5smCISte3i4TI9ga4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-WNEdVCV_NpGqMBU0tf5EHw-1; Tue, 22 Aug 2023 13:15:16 -0400
X-MC-Unique: WNEdVCV_NpGqMBU0tf5EHw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2bcb2990ba0so30560741fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692724515; x=1693329315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uX3hEgT9OaTc56WxcxfgV39D2MhUSnY7cY3oVqgL/Pg=;
        b=WQm7k/ORiUEntZv4BaSwHvI2Tyt9ecqAHDt31/OIDn9PvRBPgf+XFAj4WEfQJOwFpP
         bto5gOkvusSBwuVxIkzEIjOMWTk9t3jcYFhJUWI/8U3YN+DvnRI5jxZh4CPsGyKd4iKe
         mUi7jXITjlOzJ7XA+dAQyH90FZNCk5Zedh9PKnd9/Ui8Q33pNotjqXSJQN13/V34tOHY
         BMsMZ6qo6Uo3T4ZJX51g9vC5kmnzd2ozdiiXn0cNeqer8bAt1m6OfLJpLBQox7Ejuq1o
         MNebQg2oIib3shfefdq4RPKL6knkeUIYphkFi5Re5w7lJ1+sWdTqcf2HeE2Pd2aciWRQ
         dX6g==
X-Gm-Message-State: AOJu0Yx4YywrKNy4YLmsu8SI+YjT2+jMo1cyHbz5vwTGrs6md7IQc/ZZ
        7ku3QOE6eef71Q7si1KJ7kmBXdA4fGF8oWFkzv7GWsY+UwvpGSAQOGJlynOhxjiOJR0LzADhc33
        H3WvT6EKnro82MQteAwvd9pXP
X-Received: by 2002:a2e:2c05:0:b0:2b9:f13b:613c with SMTP id s5-20020a2e2c05000000b002b9f13b613cmr8497906ljs.2.1692724515190;
        Tue, 22 Aug 2023 10:15:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTN5fVmP5BIKTyzLWBlSk4YFGPvgFKCPUnjP+nbGthtBmH6ALa59LF61kjvpYaIpJaGOBorw==
X-Received: by 2002:a2e:2c05:0:b0:2b9:f13b:613c with SMTP id s5-20020a2e2c05000000b002b9f13b613cmr8497891ljs.2.1692724514886;
        Tue, 22 Aug 2023 10:15:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id p25-20020a170906839900b0098884f86e41sm8509499ejx.123.2023.08.22.10.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 10:15:14 -0700 (PDT)
Message-ID: <38c2d9b2-304e-f1b2-af74-94c1f2eb3d52@redhat.com>
Date:   Tue, 22 Aug 2023 19:15:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/1] watchdog: simatic: Use idiomatic selection of P2SB
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20230822141859.2139630-1-andriy.shevchenko@linux.intel.com>
 <499aeb3a-f6cc-46b8-826f-237e6c5ace31@roeck-us.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <499aeb3a-f6cc-46b8-826f-237e6c5ace31@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/22/23 18:39, Guenter Roeck wrote:
> On Tue, Aug 22, 2023 at 05:18:59PM +0300, Andy Shevchenko wrote:
>> While it's pretty much theoretical to be otherwise, make sure
>> that P2SB is selected only for X86. This is idiomatic dependency
>> which is used by all others who select it. Use it for Simatic
>> as well.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> Hans, can you take this one as well ?

Yes, done:

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



>> ---
>>  drivers/watchdog/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index a75f6acb986b..751458959411 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -1685,7 +1685,7 @@ config SIEMENS_SIMATIC_IPC_WDT
>>  	depends on SIEMENS_SIMATIC_IPC && PCI
>>  	default y
>>  	select WATCHDOG_CORE
>> -	select P2SB
>> +	select P2SB if X86
>>  	help
>>  	  This driver adds support for several watchdogs found in Industrial
>>  	  PCs from Siemens.
>> -- 
>> 2.40.0.1.gaa8946217a0b
>>
> 

