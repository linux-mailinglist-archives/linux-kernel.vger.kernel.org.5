Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE3779EFBC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjIMRCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIMRCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:02:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05B7AB7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694624498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rb8UC+tm5KMJfYE6aFVhYiKKfOMEDoFxStg0uI7kmV0=;
        b=ib2QrV6+Wjv0U8vBTQQD9kK5YSka9CH/7pJ///Fn4tDoK/kSONs3BtqduCMdS6on8nUsER
        ymHqk+026QsVeRY2uNQt2RaNrqI0QEcJIXRT7lkeMgKCxN1cP40A6xsl8UtrIGdGHn6M9/
        2Zp8cOMyZDa2YDFXscqY6hTz57JD/p8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-twOzCWlwMbCE6PFGyKb9eQ-1; Wed, 13 Sep 2023 13:01:35 -0400
X-MC-Unique: twOzCWlwMbCE6PFGyKb9eQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5007ac1c653so7539285e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694624493; x=1695229293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rb8UC+tm5KMJfYE6aFVhYiKKfOMEDoFxStg0uI7kmV0=;
        b=VIIvfy30ZBY7i034oCZaxKcYvrPdJ7X+uEskPFPnkMuFfS3UFWojhDNTYHRyY0Yodn
         0/GTEFvvfz3S4RRqHiy6pAJv7E/vHlNg+AvnU2SFw4eiDzHby4SGycU5J2j/WVuDlQ7e
         88fUWZHZJE9VNFq+wJLpSbgfABj4nABGjhy17fovrDC//4WwLy9N2bDB4kcw2bJTDx/3
         pSfspcf4HfBwOIsuf29soTsTDu4L4KLdTDAZm3hVXu3uB0oyjUPHDDTi6tebjhC3mLGL
         FMW+Qh2MtfPzhXBbEJRV2BinzZlz62Ek0YBlXOw9XH8GfL3ZgEAxQOCq+G1qSAi2z8oj
         27JQ==
X-Gm-Message-State: AOJu0YyfcmlDMD+gAaeLBlWIxHLOocBrXbTTc0LQRZKwtAPI7Vo9n+uT
        FaC83F8nVxcEHSvch+8A807WjEqxAS111DdroySqulrbBRLqh+N0Bipkpxv2XmBguVX3LJk/fno
        UIIsrDFfcQc0khQ8vETAojS5m
X-Received: by 2002:a05:6512:34c6:b0:501:c1d4:cf68 with SMTP id w6-20020a05651234c600b00501c1d4cf68mr2415289lfr.15.1694624493114;
        Wed, 13 Sep 2023 10:01:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJz+BW5iYTzC25TRIo1wwelPsjfd35it1jxFo//nrPRPFRrC/jK3at0dL3NengGRvhof78XA==
X-Received: by 2002:a05:6512:34c6:b0:501:c1d4:cf68 with SMTP id w6-20020a05651234c600b00501c1d4cf68mr2415265lfr.15.1694624492777;
        Wed, 13 Sep 2023 10:01:32 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id pv26-20020a170907209a00b00992d122af63sm8668947ejb.89.2023.09.13.10.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 10:01:32 -0700 (PDT)
Message-ID: <4f41e78e-5e47-0726-c64a-82559d1f799b@redhat.com>
Date:   Wed, 13 Sep 2023 19:01:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] x86/platform/uv: Use sysfs_match_string() for string
 parsing in param_set_action()
To:     Steve Wahl <steve.wahl@hpe.com>
Cc:     Justin Ernst <justin.ernst@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Justin Stitt <justinstitt@google.com>
References: <20230913151656.52792-1-hdegoede@redhat.com>
 <ZQHpC/oKLwfJuvRu@swahl-linux>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZQHpC/oKLwfJuvRu@swahl-linux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 9/13/23 18:56, Steve Wahl wrote:
> On Wed, Sep 13, 2023 at 05:16:56PM +0200, Hans de Goede wrote:
>> Remove the custom, hard to read code to:
>>
>> 1. Make a copy of "val" with any potential '\n' at the end stripped
>> 2. Compare the copy against an array of allowed string values
>>
>> Linux has the sysfs_match_string() helper exactly for cases like this,
>> switch to this.
> 
> Hans,
> 
> I like this patch, compiling and testing now.
> 
> I was wondering, as long as we're in the neighborhood, how you feel
> about changing the stored variable uv_nmi_action to an int or enum
> rather than a string, since it can only be one of 6 values, and the
> string compare while processing an NMI strikes me as inefficent.
> 
> It could extend this patch, or be done as a follow on.  And I'm
> willing to supply the effort if you want me to.

I must admit I did not look at the code consuming uv_nmi_action
and I did wonder why this was not an enum from day 1.

I'll prepare a v2 of this patch which changes uv_nmi_action
to an enum.

Note I can compile test this only, so I gope you will be able to
test the v2 a bit more thoroughly :)

Regards,

Hans


