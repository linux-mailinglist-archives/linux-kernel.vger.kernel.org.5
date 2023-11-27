Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931C97FAAAB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjK0Tyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjK0Tyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:54:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C1AF4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701114895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+viejdGrXzmIzPjCsTE2dERIUwjgFpRXidRJ+El7Zb0=;
        b=BknhSvk1bgLbumk0hFUIZx6/dCZScvUq0ppNkgOP8+Kjoa4UndPU5ibEyDauHailES6FqK
        zJchlVl8npR7LM1NoLOr4AQzEmi8kZbyWDg17xMlGfToc82Xz5J9nkE543bFXSFVNLGvdk
        7IHLQnNLpU3z4TdjLAzZUiiPuV7qc1k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-SkC_i8I7M36HXo6H47guFw-1; Mon, 27 Nov 2023 14:54:54 -0500
X-MC-Unique: SkC_i8I7M36HXo6H47guFw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a02cc56af16so354601766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701114893; x=1701719693;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+viejdGrXzmIzPjCsTE2dERIUwjgFpRXidRJ+El7Zb0=;
        b=NiJVP9ToeaDzK88wkkYXPmGu6sHM1zluHrnPCM3JpgcYInNNkvnRRySf9rr96PNX8L
         JXQNQyGtCZ6DDD3pp4a4nf3v/6N7UEhNW7a6LPFK2MWfg9eDzR/KOqVlzSf3fXcitkPz
         Bt1N0ENebl0HC7uhs/GXybLjF1TDBDWgmaaBUJp2i5RV8Umo0iEK0kyVLdhX1iignaaX
         H71/ma0d7ZQL0t0JrZY6Rm+3X65stz47Z/5Lgu7y0FajYDE5mF196oKe+FGn3X8LbQ2/
         N11DqKzmOdi1frRzCUfDxKtdvOD1f3m9LaYzYXtVn+XSiwf+XjkFS4Xnh/emx+Z5lkPT
         RUuw==
X-Gm-Message-State: AOJu0YyDZgcRUyHrcLx3Eq7v7gxOMzeF/t9l3Gch55C/1IaHHP4qsFV3
        X9q51M1jvkBwU8gkcXaIxcGCfbLXxkAHzVbYVsOIcy5R1AD2+u7vhm3R69Iw286cZo7anO3g3Jq
        u3abvToRHvg0ulx0j/bNf1zZI
X-Received: by 2002:a17:907:c708:b0:9b2:d78c:afe9 with SMTP id ty8-20020a170907c70800b009b2d78cafe9mr12510214ejc.49.1701114893229;
        Mon, 27 Nov 2023 11:54:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqsjQCsAPoPOd6g0Qn1BKTS65cz8ECHJlGNLkABKEDrEEApBu5Jji0dCbisefe04GfKIqPgw==
X-Received: by 2002:a17:907:c708:b0:9b2:d78c:afe9 with SMTP id ty8-20020a170907c70800b009b2d78cafe9mr12510207ejc.49.1701114892974;
        Mon, 27 Nov 2023 11:54:52 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id e27-20020a1709062c1b00b009fda627abd9sm5988845ejh.79.2023.11.27.11.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 11:54:52 -0800 (PST)
Message-ID: <6a30b834-fa29-41aa-bf91-4ab887dc2a56@redhat.com>
Date:   Mon, 27 Nov 2023 20:54:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] Documentation/gpu: VM_BIND locking document
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
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231121104046.3201-1-thomas.hellstrom@linux.intel.com>
 <20231121145619.7e7cb541@collabora.com>
 <574ec6bd-22ff-ec66-0bfe-35b51b7142f6@linux.intel.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <574ec6bd-22ff-ec66-0bfe-35b51b7142f6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/23 08:49, Thomas Hellström wrote:
> 
> On 11/21/23 14:56, Boris Brezillon wrote:
>> On Tue, 21 Nov 2023 11:40:46 +0100
>> Thomas Hellström <thomas.hellstrom@linux.intel.com> wrote:
>>
>>> Add the first version of the VM_BIND locking document which is
>>> intended to be part of the xe driver upstreaming agreement.
>>>
>>> The document describes and discuss the locking used during exec-
>>> functions, evicton and for userptr gpu-vmas. Intention is to be using the
>>> same nomenclature as the drm-vm-bind-async.rst.
>>>
>>> v2:
>>> - s/gvm/gpu_vm/g (Rodrigo Vivi)
>>> - Clarify the userptr seqlock with a pointer to mm/mmu_notifier.c
>>>    (Rodrigo Vivi)
>>> - Adjust commit message accordingly.
>>> - Add SPDX license header.
>>>
>>> v3:
>>> - Large update to align with the drm_gpuvm manager locking
>>> - Add "Efficient userptr gpu_vma exec function iteration" section
>>> - Add "Locking at bind- and unbind time" section.
>>>
>>> v4:
>>> - Fix tabs vs space errors by untabifying (Rodrigo Vivi)
>>> - Minor style fixes and typos (Rodrigo Vivi)
>>> - Clarify situations where stale GPU mappings are occurring and how
>>>    access through these mappings are blocked. (Rodrigo Vivi)
>>> - Insert into the toctree in implementation_guidelines.rst
>>>
>>> v5:
>>> - Add a section about recoverable page-faults.
>>> - Use local references to other documentation where possible
>>>    (Bagas Sanjaya)
>>> - General documentation fixes and typos (Danilo Krummrich and
>>>    Boris Brezillon)
>>> - Improve the documentation around locks that need to be grabbed from the
>>>    dm-fence critical section (Boris Brezillon)
>>> - Add more references to the DRM GPUVM helpers (Danilo Krummrich and
>>>    Boriz Brezillon)
>>> - Update the rfc/xe.rst document.
>>>
>>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>>> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Still have a few comments (see below), and in general, I find some
>> sentences very long, which has the tendency of confusing me (always
>> trying to figure out what was the main point, what the pronouns are
>> referring to, etc). Anyway, I think it's better to have something
>> imperfect than nothing at all, so here is my
>>
>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora>
>>
>> Feel free to add it even if you decide to ignore my comments.
> 
> Thanks for reviewing, Boris!
> 
> I'll make a final version incorporating much of the comments and suggestions, much appreciated.
> 
> I still think, though, that in principle the referral between gpuvm and this document should be the other way around, or it should all sit in gpuvm. In any case this is an initial version and as more comments and suggestions land, we can certainly update.

I think if we agree that GPUVM should be the common component that we recommend
drivers to use, we should reference to GPUVM whenever possible. However, I'm not
sure whether we'd want to dedicate *all* documentation to GPUVM. Since the topic
is rather complex, I can see that it might be beneficial to do both, discuss it
from a more abstract point of view and document the corresponding common component.

Reviewed-by: Danilo Krummrich <dakr@redhat.com>

> 
> Thanks,
> 
> Thomas
> 

