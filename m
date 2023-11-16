Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7F47EE237
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345454AbjKPOCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345351AbjKPOCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:02:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DC9173D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700143341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ify9Vvsur2tjiWibc1WjaPX2nLUPCNROFWZ7Gxf23VI=;
        b=FqlTQ1Es8lIKB67XWyEprqmI2WWWCr3bE9otNmM86tJ4ZXmupNgZMW0xOjGCu3qSEvDSrW
        uVEls0mRbM7TWwAG/lvLBTXviErjXWSqwHwmDmD4igel19q0ei/1KRYtYydwhbw1so1b2G
        xPkBR+ZaomW7+4tO2p297spLM9+rq5Q=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-nUkNOWNNPeevjpj_PlkB9Q-1; Thu, 16 Nov 2023 09:02:20 -0500
X-MC-Unique: nUkNOWNNPeevjpj_PlkB9Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9e28d82339aso60423666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700143339; x=1700748139;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ify9Vvsur2tjiWibc1WjaPX2nLUPCNROFWZ7Gxf23VI=;
        b=LSflO/0FGYqXlE+gV1z2eCQ1S3mf8SxdYXU4sLNvPqswiVSdOhI0sW+bg5Oyys66zk
         Ofu8TfjdjuFV+/vW7x3eMpquFppz288CEgckGGcrAVgenaX5g8yIx8N76Wp4KYEECbE9
         Yke+GemyCl6HCsLHc9Q1oC4+cr71TK/XwLeHNb3P15kIDlgU1idRyBfbjVTGuEaDFyh7
         +A3JtSmvoNs93l1pyhtEw24qTD+VdtNrDoBCwKhsPXWHGaLiJLiqud58wRL59Mqz/PFz
         tI1gf9ztEwKuyIpn3VRvznIpdFLot/GuDJWKuR7IbvnjJIOxN6IQ4cQYK/fnM11SN1iw
         Pdtg==
X-Gm-Message-State: AOJu0YzdzSZpC3rWpQXrQUxNWnLv+8h4XI7FEx1mbjv4oPdkU/1WN43p
        a9wQ9UcS1Eq78znS4FtBoPWOg+WMqP4nSaLZLeRyvI4Nqc8RLvd6gVaGeBNycb94XRiIbaGEE1Y
        MNnswXIeEYRdT/mH4qredtxRC
X-Received: by 2002:a17:906:e20c:b0:9e0:4910:1665 with SMTP id gf12-20020a170906e20c00b009e049101665mr10183262ejb.29.1700143339109;
        Thu, 16 Nov 2023 06:02:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4pGsJb2OCA8cUb6M3QJESft2ul7MzFcR4nU6hjfBuLpwW0QUNLAHidXjV+1Rf6jlYCJQBRQ==
X-Received: by 2002:a17:906:e20c:b0:9e0:4910:1665 with SMTP id gf12-20020a170906e20c00b009e049101665mr10183242ejb.29.1700143338774;
        Thu, 16 Nov 2023 06:02:18 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id mb8-20020a170906eb0800b009bf7a4d591csm8606474ejb.11.2023.11.16.06.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 06:02:18 -0800 (PST)
Message-ID: <c129fa94-6456-4746-9477-737a0fb61f96@redhat.com>
Date:   Thu, 16 Nov 2023 15:02:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Documentation/gpu: VM_BIND locking document
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     intel-xe@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Oak Zeng <oak.zeng@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Francois Dugast <francois.dugast@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231115124937.6740-1-thomas.hellstrom@linux.intel.com>
 <20231116104851.114bdb08@collabora.com>
 <0850281b667c4b88163dab60737dbc945ad742fd.camel@linux.intel.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <0850281b667c4b88163dab60737dbc945ad742fd.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 12:48, Thomas Hellström wrote:

<snip>

>>> +Locks used and locking orders
>>> +=============================
>>> +
>>> +One of the benefits of VM_BIND is that local GEM objects share the
>>> gpu_vm's
>>> +dma_resv object and hence the dma_resv lock. So even with a huge
>>> +number of local GEM objects, only one lock is needed to make the
>>> exec
>>> +sequence atomic.
>>> +
>>> +The following locks and locking orders are used:
>>> +
>>> +* The ``gpu_vm->lock`` (optionally an rwsem). Protects how the
>>> gpu_vm is
>>> +  partitioned into gpu_vmas. It can also protect the gpu_vm's list
>>> of
>>> +  userptr gpu_vmas. With a CPU mm analogy this would correspond to
>>> the
>>> +  mmap_lock.
>>
>> I don't see any drm_gpuvm::lock field in Danilo's latest patchset,
>> so,
>> unless I missed one version, and this lock is actually provided by
>> drm_gpuvm, I would mention this is a driver-specific lock. This
>> comment
>> applies to all the locks you describe here actually (mention which
>> ones
>> are provided by drm_gpuvm, and which ones are driver-specific).
> 
> These will be needed also by gpuvm when implementing userptr vmas, so I
> can mention that drm_gpuvm is currently lacking a userptr
> implementation, so "the locks described below are to be considered
> driver-specific for now"

Since Xe already implements userptr support, are you guys maybe interested
in extending drm_gpuvm accordingly? :-)

