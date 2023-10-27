Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9C47D926D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345610AbjJ0IoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345733AbjJ0In5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:43:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19133270D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:43:07 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1caad0bcc95so14659055ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1698396186; x=1699000986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I8Z8Oh3gdRlB/N1ZloJxSC+0ZqQd6KqcjVdWkl49i+w=;
        b=JY8hi2tX2SGl4wfEcPkB1R/yzEsWKfsymHjfB8/jGEeKP8bThK5jAivQgXHNTN43+V
         /jNVVr92YnXqExx96OTF3ZwYr8svZZBilBl8JRtMUUxnj+ci/UlP4sxrcELAkcX9Tb2Z
         XeKR89JC660eF6No3e2Gv9EtwKkIfmmuTes4Ue2Q1KzBtYQ7PIFiJ3MavffVJ4gxiSZn
         5nsjzmmKdKG5LYmDS14ttmErXk/IU1HW9zGjLMrnKrJ6Q1MXW9l8pqntQYB+I9i8oW4R
         DggKMe3z82Cx/h+c2281GfooJNEsWVKPBjW50X2CfneuD45BWCqj173zVIO+gU9QyLgC
         kb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698396186; x=1699000986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8Z8Oh3gdRlB/N1ZloJxSC+0ZqQd6KqcjVdWkl49i+w=;
        b=vXBWo5P+cfFD8jntN40BweqRilJKAYVo7oLFgvFkDfqcvEf2aMQm2PpSWRZDFsh/ET
         PJY/B73t1edopoPElES+VPiC8Nos+2lipXrBsadFFlW2TJck5hWGgh4ZNxfy3tbQhDCM
         Bw3wjTHdnkiQRE6LdAfWv2yXpYz3WTkGafL4WtSfWO3Lj7HJlwSuRD+daOYCDX1Knwp6
         CYFJnW4ljVVAs9bA4yAOWR0kkRNl3rOXWe2DGZTkAkd2tyx1yE4v8XxO9yWrKU38QqtB
         SjYCH/zAb6EB13/16NVMB71Kmf60w0+bfW2yi1Dx9VVtBEp93ybFrQ6BeKz3bN3YL80T
         tfnw==
X-Gm-Message-State: AOJu0Yy+p01TNF5ZhaGu5V3nKtoLdYVk6keVTcKOp3EjAZ0XrRkVwRbj
        A4COBcyGeXWZXInEhEtUL0CWmw==
X-Google-Smtp-Source: AGHT+IGL2gi63ZRFYsvlE9G8W39H3vCbkvv3yCAzfWzA4Y+L4r3Oa/kbKAd4dmnqQF71gOvraR80FQ==
X-Received: by 2002:a17:902:c40a:b0:1bc:5924:2da2 with SMTP id k10-20020a170902c40a00b001bc59242da2mr2391603plk.56.1698396186551;
        Fri, 27 Oct 2023 01:43:06 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:bfe6:93ca:47b7:e8ec? (2403-580d-82f4-0-bfe6-93ca-47b7-e8ec.ip6.aussiebb.net. [2403:580d:82f4:0:bfe6:93ca:47b7:e8ec])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001c736746d33sm1004158plg.217.2023.10.27.01.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 01:43:06 -0700 (PDT)
Message-ID: <9e55b561-a0ad-4503-9f20-b7c98507afa0@tweaklogic.com>
Date:   Fri, 27 Oct 2023 19:12:59 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light Sensor
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>
Cc:     Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
 <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
 <d7ba077d-6bcd-4e04-b678-51e4bbc935ca@linaro.org>
Content-Language: en-US
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <d7ba077d-6bcd-4e04-b678-51e4bbc935ca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/23 18:43, Krzysztof Kozlowski wrote:
> On 27/10/2023 09:45, Subhajit Ghosh wrote:
>> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor with als
>> and clear channels with i2c interface. Hardware interrupt configuration is
>> optional. It is a low power device with 20 bit resolution and has
>> configurable adaptive interrupt mode and interrupt persistence mode.
>> The device also features inbuilt hardware gain, multiple integration time
>> selection options and sampling frequency selection options.
>>
>> v1 -> v2
>> - Renamed probe_new to probe
>> - Removed module id table
> 
> This is fourth version of this patchset, not second, so v4.
> 
> Best regards,
> Krzysztof
> 
Hi Krzysztof,

1. This patch set adds support for APDS9306 Light sensor,
2. In v0 of this patch series I was told to combine the avago,apds9300.yaml
    and avago,apds9960.yaml as they look similar, then add my apds9306
    support into it.
3. I assumed that the squashing operation of apds9300 and apds9960 schemas
    are a separate operation and submitted a separate patch to do that, please
    follow the link
    Link: https://lore.kernel.org/all/20231019-hurry-eagle-0ffa95b1a026@spud/
4. Conor reviewed the patch and said that it would be better that I handle all
    these operations in apds9306 driver (this) patch series rather than submitting
    a new patch.
    "Ahh apologies then. The best course of action would likely be to include
     the patch merging the two bindings in your series adding the third user."
5. As per this patch series -- RFC->v0->v1-v2

I have formatted the commit messages wrongly which might be the source of all the
confusion. I'll fix it. Please let me know the best course of action, I am not well
versed with this process. Thank you for reviewing.

Regards,
Subhajit Ghosh
