Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186957EC929
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjKORCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjKORCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:02:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AF9FA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700067749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8+K02y8E63N7Hl8bfWpAm+o723A4RMPADnx/bCpWAh0=;
        b=eJJYIpfC9rLmzkiyJ7vPuEwLgg4AdoI2LTluEY3QRACSgsvCh4zc9IoUHIqRpKWdK8m1H/
        YGMHPE39b6TqbXzXgH13g0N8grMmd0o599RvN0oqKiSMsF837DrxnoJYz4FCqVb1MfprhA
        kf1fQ7rOQAv+/XeexlY9NXueTmcAJlc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-JWJfMkMXM96Xe4JT2XPBTg-1; Wed, 15 Nov 2023 12:02:21 -0500
X-MC-Unique: JWJfMkMXM96Xe4JT2XPBTg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9e644d94d85so139479466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:02:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067740; x=1700672540;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+K02y8E63N7Hl8bfWpAm+o723A4RMPADnx/bCpWAh0=;
        b=ALpqZBlbdrVOaApI1RjPJ8XJPX+rhNvcvGpb0QZcndr+IXorIc+OOi0UL3wUT8alD/
         xJlQvFY0Q1tuo1Vu+3pZxD5hOPGWvva5emd2HsaIkNVZ09N/sSRl+lfYQOm5dERL3nrq
         rg9l5/TnkfKq9kPgOO+QJH8pV3uC+9h+Fzzib7d+c0AmKJ9t5wTkQ4mURpbtN1KMlim7
         SLohCvo+BdMDtdUDx/hzjExVvQTtjktIma+YcIRROt5VGQ5leFZslVsKW7GHTL54s9VX
         YgkNnmOYbdT3QYoZthGtvFnVhymFpAmP9wI3Jik9dl5cQtODGK+AYmCZg33ZvDmDB78c
         rfvw==
X-Gm-Message-State: AOJu0YyKtGhMmGrgAg5U2y0p69zXdMwrWa7gAGmtijmrQgavL78PIfL4
        7eNedJh1BeRB2+DXQ99xrExXiQVSz3Se811yDU553Ht/KWLw1qyZ5lnvmvb1P/m4IOJOj6tnx04
        +bNYmbscQQza1OqACKBTdT5gA
X-Received: by 2002:a17:906:7693:b0:9e5:2b00:506f with SMTP id o19-20020a170906769300b009e52b00506fmr5192454ejm.15.1700067740246;
        Wed, 15 Nov 2023 09:02:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmyLGRL3GwYsNwyV1gH7JktmROiYMN6I3Eellr851VhdnrwoZiNzuZ1mX4o6IaWOpV/CLtUA==
X-Received: by 2002:a17:906:7693:b0:9e5:2b00:506f with SMTP id o19-20020a170906769300b009e52b00506fmr5192406ejm.15.1700067739689;
        Wed, 15 Nov 2023 09:02:19 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de9c:abf:b8ff:feee:998b? ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id o9-20020a1709061b0900b0099bcf9c2ec6sm7283726ejg.75.2023.11.15.09.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 09:02:19 -0800 (PST)
Message-ID: <05cf6199-3884-4e46-90ac-0b8df7420af7@redhat.com>
Date:   Wed, 15 Nov 2023 18:02:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Documentation/gpu: VM_BIND locking document
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>
Cc:     intel-xe@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Oak Zeng <oak.zeng@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Francois Dugast <francois.dugast@intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231115124937.6740-1-thomas.hellstrom@linux.intel.com>
 <ZVTfmbDz1HGqt4Ef@pollux>
 <62cdf31f6dbbb3a114755affc89d22fde875c3ff.camel@linux.intel.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <62cdf31f6dbbb3a114755affc89d22fde875c3ff.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/23 17:04, Thomas Hellström wrote:
> Hi, Danilo,
> 
> On Wed, 2023-11-15 at 16:11 +0100, Danilo Krummrich wrote:
>> On Wed, Nov 15, 2023 at 01:49:37PM +0100, Thomas Hellström wrote:
>>> Add the first version of the VM_BIND locking document which is
>>> intended to be part of the xe driver upstreaming agreement.
>>>
>>> The document describes and discuss the locking used during exec-
>>> functions, evicton and for userptr gpu-vmas. Intention is to be
>>> using the
>>> same nomenclature as the drm-vm-bind-async.rst.
>>>
> 
> Thanks for reviewing. I'll update the document accordingly except for
> the s/an rwsem/a rwsem/g, I think it's "an rwsem" similarly to "an r".

I read it as "read-write-sem". Would you read it as "ar-double-u-sem"
then I guess?

> 
> /Thomas
> 

