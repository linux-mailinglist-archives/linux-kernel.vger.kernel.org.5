Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CF1797BC1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjIGS2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjIGS2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:28:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1863F171C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694111223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=56TqKCcZL60A+Wc7kJAS/gDpfEBf+hRJ5ysg2ApH3tE=;
        b=BkpZe66L9rtzHaeD9ya2FMEjbNpq+BrD5LCflx7YS2qvLrm+SS8IxyHWwrDGseeNXuMcuh
        k53RSIPdbnmPmp4mn7Mc0H67ODiryuAY3cj+Fh4lEJIB2XS7q5gV5qY9fwEPW/+ov3HQcY
        tBhQvdZ+pJxBsSAFYLvIq66akLXkC9w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-ydAcAlfpNRaiifZ1R2-IcQ-1; Thu, 07 Sep 2023 04:54:19 -0400
X-MC-Unique: ydAcAlfpNRaiifZ1R2-IcQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-997c891a88dso42397266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 01:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694076859; x=1694681659;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56TqKCcZL60A+Wc7kJAS/gDpfEBf+hRJ5ysg2ApH3tE=;
        b=i++EbHERXiIcm5RpVImkiy6w62UN0S3Q/SVN0XNIGRJM21n0LcPXYe0mbEuIEnBWeO
         zKV4f96vLbMNmhp5e8XuWhS0Zps3Daeezgt3GPHyfHedvnF7uMr7YXoTxhtomSV+Y5Sf
         CMhynHjhp5ngvxyYmTFzjvDLAR04cdms9yX6LenyvnM8RKTTjTHFzzBBww1Jfr/4QLqG
         2b4ukrLyQpYwtDrQQdV2y0m/v+AByYcC7/dYqbiV6KVsJP8cFYYwehgBctFquBmbRZZ+
         tBQamF4+dqzLCqRqzmeTgfOiGxCtJRA4834o6WSbsvlYpF65O/QieAFfGPxsahk+vsQb
         2/Nw==
X-Gm-Message-State: AOJu0YxEZTuYQCzaOLWdMCuKnIDlyVHedKt0D0RrVK1NO59JWRXYhMdd
        6s6asnmremU/z/MHzhRTCB/BI+EUR28KAYq2mz+VL28c8NLJI4ENWKfu5f7CT9jMWqaUkD5O+7E
        /w3RUsiFKz7KDFxwHebRxaHOh
X-Received: by 2002:a17:906:3014:b0:9a1:e231:67e5 with SMTP id 20-20020a170906301400b009a1e23167e5mr4093423ejz.39.1694076858812;
        Thu, 07 Sep 2023 01:54:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkjF/oeSxCuBoHl+DyVfde/AyF2LYClR/AcdAAKcsH7MTToGTtYqE/ni8+s35VoLBdgb9ozQ==
X-Received: by 2002:a17:906:3014:b0:9a1:e231:67e5 with SMTP id 20-20020a170906301400b009a1e23167e5mr4093414ejz.39.1694076858449;
        Thu, 07 Sep 2023 01:54:18 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id q19-20020a170906941300b0099bcb44493fsm10266693ejx.147.2023.09.07.01.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 01:54:18 -0700 (PDT)
Message-ID: <149184db-8003-d1d4-4ae0-1401ff1b3359@redhat.com>
Date:   Thu, 7 Sep 2023 10:54:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH drm-misc-next v2 2/7] drm/gpuvm: rename struct
 drm_gpuva_manager to struct drm_gpuvm
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
        sarah.walker@imgtec.com, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        donald.robson@imgtec.com, christian.koenig@amd.com,
        faith.ekstrand@collabora.com
References: <20230906214723.4393-1-dakr@redhat.com>
 <20230906214723.4393-3-dakr@redhat.com>
 <20230907095649.13dbd49c@collabora.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20230907095649.13dbd49c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/23 09:56, Boris Brezillon wrote:
> On Wed,  6 Sep 2023 23:47:10 +0200
> Danilo Krummrich <dakr@redhat.com> wrote:
> 
>> Rename struct drm_gpuva_manager to struct drm_gpuvm including
>> corresponding functions. This way the GPUVA manager's structures align
>> very well with the documentation of VM_BIND [1] and VM_BIND locking [2].
>>
>> It also provides a better foundation for the naming of data structures
>> and functions introduced for implementing a common dma-resv per GPU-VM
>> including tracking of external and evicted objects in subsequent
>> patches.
> 
> I'm fine with this rename, but I feel like some bits are missing in
> this patch. I see a few functions taking a drm_gpuvm object and still
> being prefixed with drm_gpuva_ (I'm not talking about functions that
> only manipulate a drm_gpuva object, but those updating the the VM state,
> like the sm_map/unmap helpers), and I think it'd be preferable to
> rename the source files and the Kconfig option too.
> 

I was a bit hesitant to also rename the source files in the first place,
but I think that makes sense.

