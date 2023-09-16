Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82137A305E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 14:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbjIPM63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 08:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237073AbjIPM6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 08:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EBFCCC2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 05:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694869055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KC7JDTlfmFAD0Wa9Wi4FosKu5pCK9ry1gmbdRtC7VCY=;
        b=MWFANwF4KMvz7GdW7w5/f9cVWRIGpq+jdV8AmjbxwnNNtmxIkAA0p+q79MKAAMx7HzXXXX
        2J8PZsgN75QGHyI+LrHPuSHlevvzCH8BFm1hucgZOmVGOe2ad7cbyQrJ2WG+26txg+5+T0
        SYAXK5jMIN+idnSzuadEkyqT0VCo54E=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-akbolXrfMZ-sLpQsgk_Jjw-1; Sat, 16 Sep 2023 08:57:33 -0400
X-MC-Unique: akbolXrfMZ-sLpQsgk_Jjw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-52a3e9c53e7so2073740a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 05:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694869052; x=1695473852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KC7JDTlfmFAD0Wa9Wi4FosKu5pCK9ry1gmbdRtC7VCY=;
        b=ozT5oqZD+pBlLfDY3i+kg/xU6fW6GmfttZxrUvp6OK7j2RxO+Ou7aMdpfby6deuyAE
         ADJoBEzc+ueafHJuAbAtJCNvYKzb4UQnlxzI+BTJcjMfZtNlkJ4bXK9RIdJcUwxMNZxG
         RmA9wjlhUkRJDt4ICc4z7be4AVQEkPjq/oqX9lXaTj4eyil4azNwBpoOzfNOpFrTZKeE
         xRHITxPNFcKM/82hlagh0bntXA5hfy5dKwmaMU5VexPPrdgI9LCFyVEooN4HZSttbsgn
         1E7DQ3wlCeHS8/c/ypGYWoAMREfe+XJybUZhBeyCtfN1WLYdGTFAEAt7ZFmFcdcjFEAl
         CbhQ==
X-Gm-Message-State: AOJu0YwAVwVrmvKkk93DTv4ibe6Pu3WVmUCB12OR7uB61AgHIFRrFBZI
        o3lEhvPxCcIdKesZGhFjqJu13wFotkFV14kwDnI3+JC/+VfIocbHYU1SS6w7lvXZJx0qv5SF3Bv
        l9dnCBohoPadyTGDwDCehrXQL
X-Received: by 2002:a05:6402:1bc8:b0:530:be79:49e7 with SMTP id ch8-20020a0564021bc800b00530be7949e7mr1454770edb.37.1694869052626;
        Sat, 16 Sep 2023 05:57:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/GIl5kiuaOs3VrQ3Sgqr7hsif38wgYekmN13I57JUepauo6+ul+CJHn0HC8W6hpv7BfOtRA==
X-Received: by 2002:a05:6402:1bc8:b0:530:be79:49e7 with SMTP id ch8-20020a0564021bc800b00530be7949e7mr1454762edb.37.1694869052266;
        Sat, 16 Sep 2023 05:57:32 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i22-20020a05640200d600b0052595b17fd4sm3450003edu.26.2023.09.16.05.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 05:57:31 -0700 (PDT)
Message-ID: <aa108d68-cf89-9909-2574-5c748a218a77@redhat.com>
Date:   Sat, 16 Sep 2023 14:57:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] x86/platform/uv: Rework NMI "action" modparam handling
Content-Language: en-US, nl
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>,
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
References: <20230913180111.85397-1-hdegoede@redhat.com>
 <CAHp75VdTO2=2a_7tqH72tji=UWhmjNpaO+tE8sq+ufdjY6+Low@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VdTO2=2a_7tqH72tji=UWhmjNpaO+tE8sq+ufdjY6+Low@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/14/23 10:42, Andy Shevchenko wrote:
> On Wed, Sep 13, 2023 at 9:01 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Rework NMI "action" modparam handling:
>>
>> 1. Replace the uv_nmi_action string with an enum; and
>> 2. Use sysfs_match_string() for string parsing in param_set_action()
> 
> ...
> 
> Don't you need to include string.h?

Yes (pre-existing problem really, but still). Will fix for v3.

> 
> ...
> 
>> +enum action_t {
>> +       nmi_act_kdump,
>> +       nmi_act_dump,
>> +       nmi_act_ips,
>> +       nmi_act_kdb,
>> +       nmi_act_kgdb,
>> +       nmi_act_health,
>>  };
> 
>> +
>> +static_assert(ARRAY_SIZE(actions) == ARRAY_SIZE(actions_desc));
> 
> I believe with enum in place you don't need this, just add a terminator to it
> 
> enum action_t {
>    ...
>    nmi_act_max
> };
> 
> and use as an array size both arrays.
> 
> ...
> 
>> -       int i;
>> -       int n = ARRAY_SIZE(valid_acts);
> 
>> +       int i, n = ARRAY_SIZE(actions);
> 
> Since you are changing them, why not make them unsigned?

i is used to store the result of sysfs_match_string() which
returns a negative errno.

> 
> ...
> 
>> -       pr_err("UV: Invalid NMI action:%s, valid actions are:\n", arg);
>> +       pr_err("UV: Invalid NMI action:%s, valid actions are:\n", val);
> 
> As mentioned previously the val may or may not have a new line in it.
> I dunno about comma removal, but a new line presence can be easily checked.
> 
> Either way it's not so critical, hence removing comma. or replacing it
> by '-' (dash) may be enough.

I'll fix this for v3 by not printing the wrong val at all as suggested
by Steve Wahl.

Regards,

Hans

