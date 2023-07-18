Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8AA757DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjGRNgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjGRNgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:36:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112D6115
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689687327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cEu1yb4Zgq1SLELJ8rlpOHBQWwE2NJnVWaDiK7u0B4Q=;
        b=G7h3ahF7YZIu7wF/bCeYmvQ2knQ7V0soXbpPHE1MRYjb9Ixn0sxVgW9ODMZ6vXWAYBdUAp
        S+vRPC4yg6s886n4dWD9bhxdZoQqCjIz2TSdEhqk2WMrLTtlUzcpnlHd9NdW4KRXu8eemt
        1C4yAd78NWRFWSNFUTpxvDTzigwiF9w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-1DY-lJquM-uOXvJN7Kdbkg-1; Tue, 18 Jul 2023 09:35:25 -0400
X-MC-Unique: 1DY-lJquM-uOXvJN7Kdbkg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-98843cc8980so354738766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689687325; x=1692279325;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEu1yb4Zgq1SLELJ8rlpOHBQWwE2NJnVWaDiK7u0B4Q=;
        b=JT1MvLu+9FIoRDofbFsoXaMOGRxTBSGrl3vukdZrBOkPggR8QlbYaIiJOHLYz/QjP1
         5GyDuG+OgCyuv2U85osxj0SNsoM2n1gXbDy90bP9BVZsRyv3zFNaX/toIdgY1vfgu0D0
         tr6ruw4Mw0MyzYlQUL8Sfs6W67WHnRhM6HAHg0tRJhYo1e9YCOaXcJRqK1zr9zQZCqfm
         HsAyKFC1Xm7t7VIkse3lBPfqTsueDaj/0vYFAItgtbM+tvT+JR+lpVOEcIzycZB4aQYR
         1qNmTWtKvDlezJfG0+5aQ+SgIR76hFb6e0Fz0o+UDXCx0Pw45Wk8EnEvCYGG1AOcsyoo
         7rVA==
X-Gm-Message-State: ABy/qLaUmJ5218W+KiGz4AdwLNsq0odunFCuEcxMozfDXmU9YMTb/tAL
        suCgaXp0534cZLCH9lbEcXX3lU6PRsVayGET8rspgxCTve6kvbT355uo0eRkG2Td0fg2cokrid9
        Qd9Hq3z19rjWDVrUh8qMKswkg
X-Received: by 2002:a17:906:eb82:b0:991:f7cb:cc3d with SMTP id mh2-20020a170906eb8200b00991f7cbcc3dmr13327528ejb.65.1689687324861;
        Tue, 18 Jul 2023 06:35:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE6BIgUGric7bcLk/QABEzPWeIdh0wiGZkCK6sZV8z78PAPNcNuqus+Bife1lVy6P9Ah+mfdA==
X-Received: by 2002:a17:906:eb82:b0:991:f7cb:cc3d with SMTP id mh2-20020a170906eb8200b00991f7cbcc3dmr13327514ejb.65.1689687324521;
        Tue, 18 Jul 2023 06:35:24 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id d1-20020a056402516100b00521a3d8474csm1244859ede.57.2023.07.18.06.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 06:35:24 -0700 (PDT)
Message-ID: <51968407-c87a-e565-28f7-868a1b923d5c@redhat.com>
Date:   Tue, 18 Jul 2023 13:38:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH drm-next v7 02/13] drm: manager to keep track of GPUs VA
 mappings
Content-Language: en-US
To:     Donald Robson <Donald.Robson@imgtec.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "jason@jlekstrand.net" <jason@jlekstrand.net>,
        "willy@infradead.org" <willy@infradead.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "matthew.brost@intel.com" <matthew.brost@intel.com>,
        "bskeggs@redhat.com" <bskeggs@redhat.com>,
        "ogabbay@kernel.org" <ogabbay@kernel.org>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "alexdeucher@gmail.com" <alexdeucher@gmail.com>,
        "airlied@gmail.com" <airlied@gmail.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "airlied@redhat.com" <airlied@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>
References: <20230713170429.2964-1-dakr@redhat.com>
 <20230713170429.2964-3-dakr@redhat.com>
 <f5957892c4fb41becd7084ac93310aae3a6e091a.camel@imgtec.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <f5957892c4fb41becd7084ac93310aae3a6e091a.camel@imgtec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 12:00, Donald Robson wrote:
> Hi Danilo,
> The below part of the documentation is out of date now.
> Thanks,
> Donald

Thanks Donald for pointing this out.

If there aren't any further objections in general I will fix up the 
comment and then push the GPUVA Manager parts of the series to 
drm-misc-next.

- Danilo

> 
> On Thu, 2023-07-13 at 19:03 +0200, Danilo Krummrich wrote:
>>
>> +
>> +/**
>> + * DOC: Locking
>> + *
>> + * Generally, the GPU VA manager does not take care of locking itself, it is
>> + * the drivers responsibility to take care about locking. Drivers might want to
>> + * protect the following operations: inserting, removing and iterating
>> + * &drm_gpuva objects as well as generating all kinds of operations, such as
>> + * split / merge or prefetch.
>> + *
>> + * The GPU VA manager also does not take care of the locking of the backing
>> + * &drm_gem_object buffers GPU VA lists by itself; drivers are responsible to
>> + * enforce mutual exclusion using either the GEMs dma_resv lock or alternatively
>> + * a driver specific external lock by setting the @DRM_GPUVA_MANAGER_LOCK_EXTERN
>> + * flag.
>> + *
>> + * For the latter, functions such as drm_gpuva_link() or drm_gpuva_unlink()
>> + * contain lockdep checks to indicate locking issues. For this to work drivers
>> + * must provide (in case the @DRM_GPUVA_MANAGER_LOCK_EXTERN flag is set) their
>> + * external lock with drm_gpuva_manager_set_ext_lock() after initialization.
>> + */
>>

