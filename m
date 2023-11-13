Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF52F7E9C83
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjKMM6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMM6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:58:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9560E10EA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699880244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=99HQPaexgy0VlHo7G+FMrZBwsYGZqGO7/PNoylZTCAo=;
        b=GgnCfXgkwjUJWoureE5sOUdMqq6HrAWc612/PtOja0hdSx5vDsWhIZ9Fz6P3Xa/80cE/37
        iX01TGT1qxo3vI3pt2Q9tYxl1VwfL8qz2PXPbIbmhrs+1PgkRZoKtUha45+4+bfVDJ3prz
        HofECLGYcsuLdsUNivZvDbTE0LZ7TPo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610--m8ZRHTYM3u4-FPJodtX8A-1; Mon, 13 Nov 2023 07:57:23 -0500
X-MC-Unique: -m8ZRHTYM3u4-FPJodtX8A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9e28d82339aso286316066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:57:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699880242; x=1700485042;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99HQPaexgy0VlHo7G+FMrZBwsYGZqGO7/PNoylZTCAo=;
        b=tDSDTxrkDOjPtkgGvb+wYXrJ32MlJkzgsMO1t2p9D9z+p85+hiXB0NcSYWlmC5jEQV
         G8esmCux/wNim9+mCU4GgBJ1Jg4P+XePMrXWp5rI1/5Hn97wyTChiCeVe/jwMKRuJv/t
         bDj/RAMIf5sYLcewzhUrNKjVdqQ/TjCrzyECXs+Bbidu47mT/oUpplh6StKDpOhhJj91
         s7Y+WWIgUwjiA7d3KzYwhnmJ9SQ75Ct79AiQtgIvuSd6Leu/o91BLXBY84AeIH5psup3
         UQU8H5o5m7upQg7o4LUjOhXWf+3BVEzUJJ+XrBri1F8z8il2t29r+I3PbInQ5PVCW/4j
         +JYA==
X-Gm-Message-State: AOJu0YxM39+nlP0Jiu8M3i9MgI9x6eohh8eQAfeB27shIPn3q7FxGtFz
        8JMpvgmmztYIgLRu5PwLtqjPdWG1+0K59EznC0ctbsZynzYcumdxfRuFK0CyToSYC32aMRvEIB+
        CWgs6p0qPGJNRVAuJ/ucl+6Hy
X-Received: by 2002:a17:906:340c:b0:9d8:27e2:4c12 with SMTP id c12-20020a170906340c00b009d827e24c12mr4300059ejb.63.1699880242359;
        Mon, 13 Nov 2023 04:57:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhqSC5pNXAAfTn2Ku8ibOoV0faQFodi6FP8YDestjtCGX+ELhgazhdKJkF80CqKfD4FjEM0g==
X-Received: by 2002:a17:906:340c:b0:9d8:27e2:4c12 with SMTP id c12-20020a170906340c00b009d827e24c12mr4300043ejb.63.1699880241912;
        Mon, 13 Nov 2023 04:57:21 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id s10-20020a1709066c8a00b009dbe08bc793sm4108212ejr.18.2023.11.13.04.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 04:57:21 -0800 (PST)
Message-ID: <45ba5373-6454-4687-b21c-46748a3a6e5d@redhat.com>
Date:   Mon, 13 Nov 2023 13:57:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-misc-next v8 09/12] drm/gpuvm: reference count
 drm_gpuvm structures
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        sarah.walker@imgtec.com, donald.robson@imgtec.com,
        boris.brezillon@collabora.com, faith@gfxstrand.net,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231101233113.8059-10-dakr@redhat.com>
 <be93d9ef-3d3e-4262-a280-d2922b983ca1@amd.com> <ZUTyGTxcH7WlHKsv@pollux>
 <a2e13a27-d2e5-4ae3-9c11-c18b425b69cc@amd.com>
 <b533af44-0404-49c9-9879-3414d0964acc@redhat.com>
 <51dea5f3-a18b-4797-b4fa-87da7db4624a@amd.com> <ZUjZFFtLM435tTxJ@pollux>
 <8e87d962-c80c-40d9-94d7-58b6cd9dd794@amd.com> <ZUj0DdYZUgjhcvf5@pollux>
 <6d3c48f6-a92d-49b3-b836-ee1bc95b56bf@amd.com> <ZUkXkJ+zT7OFGosC@pollux>
 <44bc28c7-05f4-4419-5183-453c4951aac0@linux.intel.com>
 <6c536c94-7072-403c-9c63-d932252fd66b@amd.com>
 <4532d9d5-4c5a-4639-8136-d3ba9995d7b6@redhat.com>
 <1d4ca394-ee0c-4617-adbe-1d47e295c8fb@amd.com>
 <987ac707-8f9b-4e33-86c3-decdc1c48a3a@redhat.com>
 <71a50cac-3253-480f-adff-da475738ae6b@amd.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <71a50cac-3253-480f-adff-da475738ae6b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/23 08:22, Christian König wrote:
> Am 10.11.23 um 17:57 schrieb Danilo Krummrich:
>> On 11/10/23 09:50, Christian König wrote:
>>> [SNIP]
>>>>>
>>>>>>
>>>>>> Another issue Christian brought up is that something intended to be embeddable (a base class) shouldn't really have its own refcount. I think that's a valid point. If you at some point need to derive from multiple such structs each having its own refcount, things will start to get weird. One way to resolve that would be to have the driver's subclass provide get() and put() ops, and export a destructor for the base-class, rather than to have the base-class provide the refcount and a destructor  ops.
>>>>
>>>> GPUVM simply follows the same pattern we have with drm_gem_objects. And I think it makes
>>>> sense. Why would we want to embed two struct drm_gpuvm in a single driver structure?
>>>
>>> Because you need one drm_gpuvm structure for each application using the driver? Or am I missing something?
>>
>> Right, *one*, but not more than one. Wasn't that the concern? Maybe I misunderstood something. :)
> 
> Well, there is the use case of native context with XEN/KVM. In that situation QEMU opens tons of driver file descriptors on behalves of the virtual environment clients.
> 
> In this use case you have many drm_gpuvm instances for a single application. So you can't assume that you only have one VM per PID/TGID or something like that.

Well, that's fine. I think Xe can have multiple VMs per PID as well. In this case you'd keep creating driver VM structures with a single GPUVM as base class. But not multiple GPUVMs serving as base class for a single driver structure, which I thought was the concern here. For the latter I can't see a use case.

> 
> AMD already made that mistake with KFD and I strongly suggest not to repeat it :)
> 
> Regards,
> Christian.
> 

