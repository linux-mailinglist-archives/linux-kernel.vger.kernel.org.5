Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77D17B0AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjI0RAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjI0RAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:00:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5992591
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695833960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l6cdl+aga/6XxqqAgUUx1HZQLiVlXgz3gMJOL8B3acE=;
        b=HdQ6xiO7z9n8o1/sxK8VCuLkngE4xlgn1rolGUStqKH3BFmqQcQUd/NfZaC9XooVRJCHr2
        ZyyCNL8cMsvx9Z7dygUIQbwCGm0tZl25nzqY90KRNYICtTKt/OKgT6zx2yLp26SKaitsy5
        xlr7vS1Ns6Z59UCWqdWG0XUIYkBR594=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-ozbHUqZrNyC6HgfkRzyyyw-1; Wed, 27 Sep 2023 12:59:18 -0400
X-MC-Unique: ozbHUqZrNyC6HgfkRzyyyw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-533ca50404bso7001700a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695833956; x=1696438756;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6cdl+aga/6XxqqAgUUx1HZQLiVlXgz3gMJOL8B3acE=;
        b=ulI1wOW7XP9EYouRa1mbFkNCdb3qNccpQxr8Ig0NwKQMECvAJ9ZXAxV0J/EgBr9njj
         QTaWsExYFpnOhPMHt4NZGFKWUd6hdIWlNp0j3DP8V/GxLYy8oX0qt1JQXvlWCG9Gnjm3
         4+VSo0KZut3AKErRXLfZL6EKbPTa684qcPw8OtmPZR/c3QJM2+E4fp7F9N4ouR93oj94
         AEV28GnZTo9240e6BnnYtkE11v+kg5omTsU/00cWBLkMgggm3p+4K0Ge/Ts2lKFBZCf1
         9CDllLJPKKJgwf1vsXDxvVnzTDaTmw109u4l9WOwhJvGsvaKVGeABE9GJ8eKMeSmKzxX
         NsGg==
X-Gm-Message-State: AOJu0Ywb6HzzBk5l4x91W9hTlOuGnkKNQ8HQ/XsY2hYaxRcLw86mHA1s
        lpDD54PfTVS/sSjimVftoCAhTiwxGqD7m3coN/3/grQkeiKf9DBQZ1GbBtvPmgp4u/gfswqcVgZ
        nY5bSsRWoIxGLSRJcAGGB+/EH
X-Received: by 2002:aa7:d0d8:0:b0:530:a0a9:ee36 with SMTP id u24-20020aa7d0d8000000b00530a0a9ee36mr2095711edo.38.1695833956677;
        Wed, 27 Sep 2023 09:59:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKMrmbuENX8FTtWAevq2VNbPYGGhr9ZiqqUZp9scNnPqDJ3oJHDnGAkbey4dkMV7CVYYlnMQ==
X-Received: by 2002:aa7:d0d8:0:b0:530:a0a9:ee36 with SMTP id u24-20020aa7d0d8000000b00530a0a9ee36mr2095696edo.38.1695833956385;
        Wed, 27 Sep 2023 09:59:16 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id s3-20020a056402014300b0052595b17fd4sm8315439edu.26.2023.09.27.09.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 09:59:15 -0700 (PDT)
Message-ID: <a46f49b8-3680-9476-046b-e3d821184851@redhat.com>
Date:   Wed, 27 Sep 2023 18:59:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH drm-misc-next v4 7/8] drm/gpuvm: generalize
 dma_resv/extobj handling and GEM validation
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, christian.koenig@amd.com,
        faith.ekstrand@collabora.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230920144343.64830-1-dakr@redhat.com>
 <20230920144343.64830-8-dakr@redhat.com>
 <20230922134548.7ede67c0@collabora.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20230922134548.7ede67c0@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/23 13:45, Boris Brezillon wrote:
> On Wed, 20 Sep 2023 16:42:40 +0200
> Danilo Krummrich <dakr@redhat.com> wrote:
> 
>> +	/**
>> +	 * @DRM_GPUVM_RESV_PROTECTED: GPUVM is protected externally by the
>> +	 * GPUVM's &dma_resv lock
> 
> I think we need to be more specific, and list the fields/operations
> that need to be externally protected when DRM_GPUVM_RESV_PROTECTED is
> set.

I agree, we should probably keep a list somewhere. However, there are also
lockdep asserts where a lock is required to be held.

> 
>> +	 */
>> +	DRM_GPUVM_RESV_PROTECTED = (1 << 0),
> 

