Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077E47AF652
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 00:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjIZWcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 18:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjIZWaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 18:30:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE645FFB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:16:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-405621baba7so69064845e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695762982; x=1696367782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6KWZPT1cVuVAxwKDV1pCBXg/18ZoYQrcOIuq4Q9pEZ8=;
        b=Za+ZYEJ2KrP1Q69UqsS+32GjP/LE/LfefHFmzNosRQW9MWImQ+t8jTjsEVfIQDx9RZ
         ffFRNEohk0wRiBqhtCa/4q9NoW8rqQrbYAF/JVCi9iV40bBp/w8zF+EcHGO6SrA13vs7
         z/GRHcWv+RDDtHCYebJ8/ak2525YRov/IFfJ0l8i9hqxso2SYXuljW6WytFDWQK6qo73
         gpvUAWGI1f/isG3bPntWSCE76NIM8uG2cHWs2DYluvaaCuQnZeI09mkBQy/H+4fKUYSw
         AP38jQ5m84Ha+HJNUujYRRCi3r/Uck5vrvBTJF/7lWzTzniQyhfRQ6OdlffWgtrzVyfc
         GncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695762982; x=1696367782;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6KWZPT1cVuVAxwKDV1pCBXg/18ZoYQrcOIuq4Q9pEZ8=;
        b=UCTuKI995ZS/4h5oeldzKg9jPSDy+XrQpel7nyGzAJba+tz04tH21MO1QX0+uFjvG+
         wB9L8scdXPqsZC5/nVuClVSqKv1EaNmWkUtRkeo+e6Kn9hfW570eAFQhkJ9TEtVoNu7q
         GvwZJOBOKDxAcEgK3rypDuQfadoKJLhT+EUYFXCagu1L+5SCuzbOl3IiC1PAS2YyR3Gc
         j7WX+LI2X7evQZcR7+dOOtrnExcTu3QGRIhRFVwTZttoC1zt+y/26c1sH50JPuAL3UBc
         QPybs0/t1fNdpUP6ptfCa41awXyMNzGH/u8udnuJ4CQjIXLxG8ANQEp1zq6AZx5d6Lzi
         8ITw==
X-Gm-Message-State: AOJu0YxjFE2Apz59pEhyy+CQqcjlMQA3gcCQ9/paiPrd71xxgllJb4Ey
        wVuUKWHr1J6JU0nZye7QCAxE7A==
X-Google-Smtp-Source: AGHT+IHhT+JIEvulFq13sJ8dtu11qYoMwlAEUeIVyQAx9mWJQ2iwa0eRkCvZjWPXS0mYic7qN0JwVQ==
X-Received: by 2002:adf:e3ca:0:b0:31f:98b4:4b4d with SMTP id k10-20020adfe3ca000000b0031f98b44b4dmr9718944wrm.42.1695762981581;
        Tue, 26 Sep 2023 14:16:21 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id c2-20020adfe702000000b003217c096c1esm15555497wrm.73.2023.09.26.14.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 14:16:20 -0700 (PDT)
Message-ID: <eaf3cef4-628f-8f6c-b77d-c8b2ee62f50b@linaro.org>
Date:   Tue, 26 Sep 2023 23:16:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 02/13] ACPI: thermal: Collapse trip devices update
 functions
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <1957441.PYKUYFuaPT@kreacher> <3534976.iIbC2pHGDl@kreacher>
 <38ea14aa-ecc2-c40e-34ea-05b348158cfb@linaro.org>
 <CAJZ5v0iww__Kd2e8bSarXL5ugjL1zuCaXgOfzLp-VGdmHBBabQ@mail.gmail.com>
 <CAJZ5v0gA1488TeNTHNFb0yCjfqFBe8cEWZNteBmk6m_Eo4QTsQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gA1488TeNTHNFb0yCjfqFBe8cEWZNteBmk6m_Eo4QTsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2023 20:04, Rafael J. Wysocki wrote:
> On Tue, Sep 26, 2023 at 7:56 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Tue, Sep 26, 2023 at 7:18 PM Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>>>
>>> On 21/09/2023 19:49, Rafael J. Wysocki wrote:
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> In order to reduce code duplication, merge update_passive_devices() and
>>>> update_active_devices() into one function called update_trip_devices()
>>>> that will be used for updating both the passive and active trip points.
>>>>
>>>> No intentional functional impact.
>>>>
>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> ---
>>>>    drivers/acpi/thermal.c |   53 ++++++++++++++++++-------------------------------

[ ... ]

>>>> +     if (index != ACPI_THERMAL_TRIP_PASSIVE) {
>>>> +             method[1] = 'A';
>>>> +             method[2] = 'L';
>>>> +             method[3] = '0' + index;
>>>> +     }
>>>
>>> Could be index > 9 ?
>>
>> I can add a check, but it will never be called with index > 9 anyway.
> 
> To be more precise, update_trip_devices() is called in two places,
> acpi_thermal_init_trip() and acpi_thermal_update_trip_devices().
> 
> Both of these are called either with ACPI_THERMAL_TRIP_PASSIVE passed
> as index, or from a loop over indices between 0 and
> ACPI_THERMAL_MAX_ACTIVE-1 inclusive.

Ok, thanks for clarifying


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

