Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097BD7CF671
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjJSLQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjJSLQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:16:25 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4575F11B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:16:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so4103161b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1697714184; x=1698318984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sAnUoey8f2fAlcA64pZt7TpkGrm2kpPx8+dtgGFHVW8=;
        b=fx42ypQOc3rHVgMKPPkF9KJj+cV3gbIuQ6YFMJLdtFN4KwK4RaJewYHSMihB2qJ2Ma
         C2BGvi20FLg9Oxi1LEsBFbYHsbeD8NqKGvQJIf8mgiYUxFV6/wZnWVEcCCgXqgKtCejv
         rNFOK6KFGeqtUlOK4U5vYDnLjazuxF8zdhvOGHft6vs7yZti7DzrMQ1mamas9qXm3KUo
         etTzTlLRsib9Fbxq6aPJq0h71q1qxQAhAoyQ3EXvfROuabS4N3J4YVhLAetmMssP08wF
         Qxue2TAAJoznVjx+FUe6Piia9tnmi4Qbq4rB/W/KUkF5euBzKVvnkvWtuBkQ9QfkrIGI
         zfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697714184; x=1698318984;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAnUoey8f2fAlcA64pZt7TpkGrm2kpPx8+dtgGFHVW8=;
        b=TE/qw/WYK6YznpEew3YTxGSkrfYlo3AhhzXgrt3xVwUtl0sgCeNGClGw7LIHjlMYPA
         kR7Nu5IkOg87HqLNs0DX8hFDrPqJV/mw9MVqLtBbXWoNWkc9fSShKXh7Dy+vESbVp5H/
         1wgL99GICgDAlu49PlXTQcA0YE9v4dQyJzPkx+Qzi5sTq0wNholBBbCbahr4gR4wnFwO
         NZ7Dq2B9VmVh+AgYqTPjEUvBD+JBXIjyk+5aNPMAvRHa4lWoe6tUTiNFmPEoPbK7urhH
         +WSZBZ/nHu/sT7UerHEfEYwBDLiOjOYtc3cZg3HJ2QU3e2RRvPwEyLoMYQLOcsdFsm8J
         4oJw==
X-Gm-Message-State: AOJu0YwwO0rgt5K+X4Yfqn6NaACxdLmmi6Ujb3yNBu8lHKpT2ts3yCE3
        7/aEZErcF9A2znMWi9pF+dMmAQ==
X-Google-Smtp-Source: AGHT+IEdgUYVhwk+hQedV6eZvAiFZLxaNtxLNrge4xvkAKGXUjQS80bNVpCeBl/1/TMUSDGIKy3xiQ==
X-Received: by 2002:a05:6a20:3d8b:b0:158:1387:6a95 with SMTP id s11-20020a056a203d8b00b0015813876a95mr1960369pzi.19.1697714183661;
        Thu, 19 Oct 2023 04:16:23 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:43ac:2324:cc6e:9fa5? (2403-580d-82f4-0-43ac-2324-cc6e-9fa5.ip6.aussiebb.net. [2403:580d:82f4:0:43ac:2324:cc6e:9fa5])
        by smtp.gmail.com with ESMTPSA id jb11-20020a170903258b00b001bc21222e34sm1672782plb.285.2023.10.19.04.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 04:16:23 -0700 (PDT)
Message-ID: <6b721019-c98e-d926-04a9-e71f9ea20762@tweaklogic.com>
Date:   Thu, 19 Oct 2023 21:46:18 +1030
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] dt-bindings: iio: light: Squash APDS9300 and APDS9960
 schemas
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231019080437.94849-1-subhajit.ghosh@tweaklogic.com>
 <472aa31d-7d6c-41df-86e6-d17f05998256@linaro.org>
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <472aa31d-7d6c-41df-86e6-d17f05998256@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/23 19:50, Krzysztof Kozlowski wrote:
> On 19/10/2023 10:04, Subhajit Ghosh wrote:
>> Squashing Avago (Broadcom) APDS9300 and APDS9960 schemas into one
>> file and removing the other.
> 
> Please answer: why?
Apologies for not providing detailed explanation.
Link: https://lore.kernel.org/all/4e785d2e-d310-4592-a75a-13549938dcef@linaro.org/
As per your comments on the patch series in the above link and as per my understanding,
I have to do two operations:
1. Squash existing apds9300 schema and apds9960 schema as they look similar.
2. Add apds9306 (work in progress) support after that (which belongs to my original patch series).
This patch is the first operation.
>>   
>> +allOf:
>> +  - $ref: ../common.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - avago,apds9960
>> +    then:
>> +      required:
>> +        - interrupts
> 
> Why? This wasn't in original binding.
I am not sure about this. I went through the driver code and found out that probe()
of apds9300 handles both situations whether interrupt bindings are provided or not, whereas,
apds9960 requires an interrupt binding for probe() to be successful. I thought it would
be appropriate to add that in the schema.
> 
> Separate patch please.
> 
> You are doing way too many unexpected and not explained changes.
Sure. Thank you for reviewing.

Regards,
Subhajit Ghosh.
