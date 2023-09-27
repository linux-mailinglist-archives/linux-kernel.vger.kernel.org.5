Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5017B0AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjI0Qxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0Qxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C24292
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695833580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rxjtGuP27M/M7llCwr0T0C3cRYx9L/Mjemr/JjBDHmM=;
        b=gUGTRfR9JzFgLlhFgca+uQ2tAgbW84qkfRQmJLNb4rTDe4cBbefJs/RhWKsXA9+h062w1r
        LiGPuz3Zv8PJ8+3yLG1/iysy0uhu2WEO5OAlwAQwkXcROYa/iSm3owRj7wxQOH5DqfG1ar
        krOTkC5V22XH/vgg0w+G29iekLafHxI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-cfNLunylNJGZvV6gy1aV7A-1; Wed, 27 Sep 2023 12:52:58 -0400
X-MC-Unique: cfNLunylNJGZvV6gy1aV7A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9adb6dd9e94so989815566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695833577; x=1696438377;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxjtGuP27M/M7llCwr0T0C3cRYx9L/Mjemr/JjBDHmM=;
        b=Kyz7FRV4z0ZgnAyf8OUCaiSpUZfxZhbCeiuY5Y8kGsE2j5BRWF99R1j8UwcHdTg/7I
         PU7kqP1r0hPFO5fzHeCxSD/H711IHLSBCCdMY6+fwFbAwx5ghkQbHMJjC3MEZR14rJlw
         yrXdOPVxBYe+pkLgo+ZycYIVOoWnozXveSa97rF+D4g5t6uOjhNuhzcIj8+9h/N/PS5x
         zG2VadR8c058ToR2ZeL/K6AEVSbKWhMA7ZZS0bnlJfSslcJQJCECHixI1gu06IkWG/am
         ctSGa6IeA0SNxOiu0eWS2IHVADWLNNQeMQJiwNpgPsek9nkDLe2unGgtGCxpj4I6DNfR
         dyZw==
X-Gm-Message-State: AOJu0YzXPgKBiKTRBcpi7+KXazpmJ3Lpm2GeRbRmoSpnNLYMxM7JJoId
        Fy+lWIEdg+vLcOfZ8PWFBVZurx3qAunhqDrPJsXNcSfSxK1s2DJ6OGmPBII9byCJUj+T+4aCa3l
        RtQdZcBcxcXeKZvSs9tNWn1Sh
X-Received: by 2002:a17:907:77c5:b0:9ae:505d:310b with SMTP id kz5-20020a17090777c500b009ae505d310bmr2306332ejc.39.1695833577407;
        Wed, 27 Sep 2023 09:52:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHc83/1tUjQ09zzLgVnnHRK2VLhOicSElrnrdTxCdR6t80pKF0wAdKYoaj3LU1idXVGIDZCA==
X-Received: by 2002:a17:907:77c5:b0:9ae:505d:310b with SMTP id kz5-20020a17090777c500b009ae505d310bmr2306309ejc.39.1695833577104;
        Wed, 27 Sep 2023 09:52:57 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id k15-20020a170906970f00b0098733a40bb7sm9562757ejx.155.2023.09.27.09.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 09:52:56 -0700 (PDT)
Message-ID: <810dc476-8ead-19e6-23fc-0f9cf35ba2b2@redhat.com>
Date:   Wed, 27 Sep 2023 18:52:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH drm-misc-next v4 6/8] drm/gpuvm: add drm_gpuvm_flags to
 drm_gpuvm
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, christian.koenig@amd.com,
        faith.ekstrand@collabora.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230920144343.64830-1-dakr@redhat.com>
 <20230920144343.64830-7-dakr@redhat.com>
 <20230922135842.242c865d@collabora.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20230922135842.242c865d@collabora.com>
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

On 9/22/23 13:58, Boris Brezillon wrote:
> On Wed, 20 Sep 2023 16:42:39 +0200
> Danilo Krummrich <dakr@redhat.com> wrote:
> 
>> +/**
>> + * enum drm_gpuvm_flags - flags for struct drm_gpuvm
>> + */
>> +enum drm_gpuvm_flags {
>> +	/**
>> +	 * @DRM_GPUVM_USERBITS: user defined bits
>> +	 */
>> +	DRM_GPUVM_USERBITS = (1 << 0),
> 
> Nit: I tried declaring driver-specific flags, and I find this
> counter-intuitive. You basically end up with something like:
> 
> enum my_gpuvm_flags {
> 	MY_FLAG_X = DRM_GPUVM_USERBITS,
> 	MY_FLAG_Y = DRM_GPUVM_USERBITS << 1,
> };
> 
> instead of the usual
> 
> enum my_gpuvm_flags {
> 	MY_FLAG_X = BIT(0),
> 	MY_FLAG_Y = BIT(1),
> };
> 
> pattern.

Right, same as with dma_fence flags.

> 
> Another issue I see coming is if we end up adding more core flags and
> drivers start falling short of bits for their own flags. This makes me
> wonder if we shouldn't kill this notion of USER flags and let drivers
> store their flags in some dedicated field, given they're likely to
> derive drm_gpuvm and drm_gpuva with their own object anyway.

The only reason I have this in the code is that Xe asked for this with
drm_gpuva_flags. Hence, for consistency reasons I added it for drm_gpuvm_flags
too.

Drivers can still have their own flag fields if needed, otherwise I guess it
doesn't really hurt to keep DRM_GPUVM_USERBITS in case someone wants to use it.

> 
>> +};
>> +
> 

