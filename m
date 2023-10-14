Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B937C930F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 08:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjJNGva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 02:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJNGv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 02:51:27 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58D1BF;
        Fri, 13 Oct 2023 23:51:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-991c786369cso451260766b.1;
        Fri, 13 Oct 2023 23:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697266284; x=1697871084; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vx7O+/mPyye+58XO3gfh4ede5Ey/i5cAVMi6RSAm2Fo=;
        b=eyom93PuMzfsRBELugxDlR2Fn26QgcRhWq4dav/jtTvJF4Cg4BqqBwrDltFOHUnwdV
         19q1iqpKHF1uF0lpU9PU8Dv+PpqmkVeNNfOjGwQecN4/wIZMLE1TUBKUPAPDBW339sX8
         VEsdV6UlIzgmebBtASK3E/jsWQGAyX9Gh7e/5W2cIQU9qiV5bVKrMj1T/ugDmght+7cz
         MFJxxi1spS0henp9x56z9uncH+dUZ19/yYNj4Mjzuzs7mKZUxcO91cMXt7WbshsL3jTd
         5gMNBYV3kzzUdPmv+FWi+SUKkpooGvoZDnaf26eUGEEEc9mXU+6AJOL2l8U6HqOwKzWT
         Bisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697266284; x=1697871084;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vx7O+/mPyye+58XO3gfh4ede5Ey/i5cAVMi6RSAm2Fo=;
        b=IcOIq5xQwCQ53a4YoRyzB0DlaHj2fjXNbhOh33qicgGmesRGI3dpw7aD9koiRRVn1r
         ejzCv+Hzbva6DdaYnXC/itHRk/pt25LPeJwTB1ysMTTfKv67ffWvGDmriUKfdWMYNE1w
         UIjpMgwXYRCCweWlOIJjMVnTe45wVxZvTXA/jkmJJpyo2zCphSgUFpmJWWiGxZpJXd+Q
         IACdVF3Q9odaI4xCH1+ABUaQosEyj3gdAQTKoPViwlAVhFkJUgOrPwEo0VlqjdxhnANA
         OfxqMthc9nisU5kMlPtiyYMNiVKvw3qHWVd+rt5sbvt602HNpHTK5L4JBEPJgHAJsWXW
         ScHA==
X-Gm-Message-State: AOJu0YynjYPf8EYHY8Yq9BTOSVUKfojGJAfZUOemhK6NBafXQlmKG/8E
        g0kn27xxx/j9OUZhDpCg/OcXu/3lar0=
X-Google-Smtp-Source: AGHT+IGHbW+Ptdwzy92Kz+QYUaTmu72lqWDKNL7sbirXYuuiSg/ZwJ9LU+rrZG32uOTt1WvTB/WsDw==
X-Received: by 2002:a17:906:3150:b0:9a1:f81f:d0d5 with SMTP id e16-20020a170906315000b009a1f81fd0d5mr23804043eje.54.1697266284068;
        Fri, 13 Oct 2023 23:51:24 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id b8-20020a1709063f8800b00997e00e78e6sm540548ejj.112.2023.10.13.23.51.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Oct 2023 23:51:23 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] pwm: bcm2835: allow pwm driver to be used in
 atomic context
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1697193646.git.sean@mess.org>
 <6ce73b2688f059e7169935699044104cf37b2425.1697193646.git.sean@mess.org>
 <84429d39-aa54-462d-85cd-c5d06a614a0e@gmx.net> <5203415.ElGaqSPkdT@steina-w>
 <20231013175140.dzlz4grrgngoyxbc@pengutronix.de>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <e3e1bca1-bffa-d97a-d4af-27a10c43c064@gmail.com>
Date:   Sat, 14 Oct 2023 09:51:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20231013175140.dzlz4grrgngoyxbc@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.10.23 г. 20:51 ч., Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Oct 13, 2023 at 01:13:50PM +0200, Alexander Stein wrote:
>> Am Freitag, 13. Oktober 2023, 13:04:48 CEST schrieb Stefan Wahren:
>>> Am 13.10.23 um 12:46 schrieb Sean Young:
>>>> clk_get_rate() may do a mutex lock. Since the clock rate cannot change on
>>>> an rpi, simply fetch it once.
>>>
>>> does it mean you checked all possible SoCs (BCM2835, BCM2836, BCM2837,
>>> BCM2711, BCM2712) for this change?
>>>
>>> Is it impossible that the real clock can never be influenced by turbo
>>> mode like SPI?
>>
>> Assuming the clock can change, which I would, then a clock notifier seems
>> appropriate. See [1] for an example.
> 
> I'm not a fan. If the clock changes, the output also changes. With a
> clock notifier you can soften the issue and reconfigure to something
> similar as the original wave form, but a glitch happens for sure.
> 

Right, but without notifier, everything rate related after the change 
will be wrong

Ivo

