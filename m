Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9967DD4D7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346920AbjJaRoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346874AbjJaRoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:44:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D65992
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698774200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fjb6Yoc/YD3246622wziQ1x01TRFPcmtkNRame8jp4I=;
        b=HhxuI0y+hqjchQZgIt8wrmXuwKRlhWBi+ExWqEpPCkZSy+JJg0QwQDUQ2lvFAJ2lWCfuQq
        N3TUF+beSdGtXtFthXh2jyGfvs13VKTuXx9FEzuJGqHYkxa6SfF68ux0DEIDxz0gyVnfSL
        Sg+lEXgfYMOQ6GmrfFjF3tpAZhI5rag=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-xlwPX2wHMYW2AjMHZ3X_3A-1; Tue, 31 Oct 2023 13:43:14 -0400
X-MC-Unique: xlwPX2wHMYW2AjMHZ3X_3A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9cd789f0284so394551066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774193; x=1699378993;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjb6Yoc/YD3246622wziQ1x01TRFPcmtkNRame8jp4I=;
        b=rAXjz7Z7dtoCaAUHcnV/LVOV9lY/i0yNW46ZFx9oKjib9Lj46cjDVw56o0WG0PvsJr
         lj8A+OzmVZ6kHVDeoznVT2nNJBUe5osivMkoWf2e3Dg1mUSXWbbuEFl3R7y62t+RBqFC
         QiI8QstCT+rAUCeic5qQPmAfWAm/zxFwB7vETKrB/iDlGlKvsf6oQ0F6EROEKrThVFSx
         S+b6ohqfM2l00VzvU5gD4HjmHMYjMStX3MCO+zIFWVQI+ip1SflKyxwwFg2aZN7x3PY9
         4E6xW6daTgSmQpA41I5O2hpJ6nlO9qZZNZ8PUk+LCMOUC21buhFAYzNXulET1u1DjxPU
         0SzA==
X-Gm-Message-State: AOJu0Yw4f7F+XxkHc4h0Rqed/GoJmXiCl/1uw0Ycpkk32xdLFV+u1qSP
        UXkisnD6QhtQLQtxNcLC9MOM4uCn2NMphBKlTJk7KnqSXv2Hmszl7tJxQs87dNSxZ9jQZEd/pZk
        He6dvSASK+m8HHhF4tFccPJ5R
X-Received: by 2002:a17:907:806:b0:9b2:b269:d563 with SMTP id wv6-20020a170907080600b009b2b269d563mr31357ejb.63.1698774193022;
        Tue, 31 Oct 2023 10:43:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBZIn/2FMYdWi84Y1OkpcqPPwyotpPSJ5wkgv3ilk1lzE2lciLdSBr2N55hmshj9afdG5z/w==
X-Received: by 2002:a17:907:806:b0:9b2:b269:d563 with SMTP id wv6-20020a170907080600b009b2b269d563mr31345ejb.63.1698774192750;
        Tue, 31 Oct 2023 10:43:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id pk24-20020a170906d7b800b009c74c56d71dsm1334995ejb.13.2023.10.31.10.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 10:43:12 -0700 (PDT)
Message-ID: <3b78aa2c-91a8-4031-a4e8-1f330139cd9f@redhat.com>
Date:   Tue, 31 Oct 2023 18:43:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-misc-next v7 4/7] drm/gpuvm: add an abstraction for a
 VM / BO combination
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20231023201659.25332-1-dakr@redhat.com>
 <20231023201659.25332-5-dakr@redhat.com>
 <f00a4975cf32c3ae28124343a2c994acda083829.camel@linux.intel.com>
 <87zfzz3thp.fsf@intel.com> <1e2acafb-fbc3-4256-b1e1-3fe6c47b1ef2@redhat.com>
 <6cf7459aa0332d6fc3c4764f66a83c6a3825348f.camel@linux.intel.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <6cf7459aa0332d6fc3c4764f66a83c6a3825348f.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 17:50, Thomas Hellström wrote:
> On Tue, 2023-10-31 at 17:30 +0100, Danilo Krummrich wrote:
>> On 10/31/23 12:45, Jani Nikula wrote:
>>> On Tue, 31 Oct 2023, Thomas Hellström
>>> <thomas.hellstrom@linux.intel.com> wrote:
>>>> On Mon, 2023-10-23 at 22:16 +0200, Danilo Krummrich wrote:
>>>>> + * Returns: a pointer to the &drm_gpuvm_bo on success, NULL on
>>>>
>>>> Still needs s/Returns:/Return:/g
>>>
>>> FWIW, both work to accommodate the variance across the kernel,
>>> although
>>> I think only the latter is documented and recommended. It's also
>>> the
>>> most popular:
>>>
>>>     10577 Return
>>>      3596 Returns
>>
>> I'd like to keep "Returns", since that's what GPUVM uses already
>> everywhere else.
> 
> Ok. It looks like the Returns: are converted to Return in the rendered
> output so I guess that's why it's the form that is documented.
> 
> I pointed this out since in the last review you replied you were going
> to change it, and also when the code starts seeing updates from other,
> it might become inconsistent if those patches follow the documented
> way.

Sorry for that. I think I wrote this answer when I was at XDC and hence was
a little bit distracted.

> 
> But I'm OK either way.

Ok, then let's just keep it as it is.

> 
> /Thomas
> 
> 
>>
>>>      1104 RETURN
>>>       568 return
>>>       367 returns
>>>       352 RETURNS
>>>         1 RETURNs
>>>
>>> BR,
>>> Jani.
>>>
>>>
>>
> 

