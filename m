Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5339A79C7B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjILHIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjILHIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:08:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0225410CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694502441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ngjRwCUGtVn49b+a10bSdDhEKYC91j/r4ziY766Fz/Q=;
        b=Nn9RSlhVkEALsKNCenPuDiXw3qsIg2bbqpoI9zgr/rBCURM+6HCc+q+EupkmN8zRTgskLw
        FcAa4kJDrCLn/eLeKVwAq3qhU9r78I3GlVJftZlN3kcR2PUnuAP+PKFfoDwC8EhTmdZkXx
        AffZtgeCvbg4dOBZT3i4OBzr6AqeAqU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-tSLVuLd6NRSlYUDuYvntEw-1; Tue, 12 Sep 2023 03:07:20 -0400
X-MC-Unique: tSLVuLd6NRSlYUDuYvntEw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-402d1892cecso23101875e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502439; x=1695107239;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngjRwCUGtVn49b+a10bSdDhEKYC91j/r4ziY766Fz/Q=;
        b=fx1Mt7D53iFtT1Z2MnBjmotAadYwT0H6ZnlyLEWuuWVFdzzlCLfYIUCSYBeEuYduo2
         n2zKOxALKDxITn0IN7LypmBv9GhyS8lRpN/86IbebQ29HoNQ77/dxAAZbeIe1RS/nPJr
         5ryiFaldDdrX0mZGT8dxrWw8D2VOSowmZ1nzbGsh21qq39GMhZLd1e1CzJoUl0RosdSq
         e5iYxzHGyHLnzVICB23O+8u61t1Qx/EV7ZI9u58Cd2Peyv3SP4iS7+s6qXinbFjkL3If
         i3uGvVC3fa4I9LOiVyhwnWbgN0Z/c/kv17VHMJwQcZZvevImdeWHvYywfAAXKu3TRbbz
         Nl/A==
X-Gm-Message-State: AOJu0YxgkYIMkqiCBkMCCOCdjheCnL9xWAGabijgK2OhqBu/O1axBKvf
        abAT22ODQXmFUhYh1EJdSr8glIouwWEsLRtTHGlRGpl2QtjdbTX9zRaZQohGXzF6moKpk2ONeTl
        udQhfS0A4HRgEmzVs7o4rNB66
X-Received: by 2002:a05:600c:1f0f:b0:401:c717:ec6d with SMTP id bd15-20020a05600c1f0f00b00401c717ec6dmr1119945wmb.15.1694502439221;
        Tue, 12 Sep 2023 00:07:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5qayMUu6hFKKGXK/Y1sZoWl+xVPxZf7W2vplC+a6aJOLDOuM5ZiotTuLG/f2Sp2tx3YPNWQ==
X-Received: by 2002:a05:600c:1f0f:b0:401:c717:ec6d with SMTP id bd15-20020a05600c1f0f00b00401c717ec6dmr1119929wmb.15.1694502438860;
        Tue, 12 Sep 2023 00:07:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:d600:c705:bc25:17b2:71c9? (p200300cbc74fd600c705bc2517b271c9.dip0.t-ipconnect.de. [2003:cb:c74f:d600:c705:bc25:17b2:71c9])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c378800b00401d6c0505csm12028140wmr.47.2023.09.12.00.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:07:18 -0700 (PDT)
Message-ID: <550ec927-2de4-39e4-2df6-423be22c2161@redhat.com>
Date:   Tue, 12 Sep 2023 09:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [linus:master] [proc/ksm] 8b47933544:
 kernel-selftests.proc.proc-empty-vm.fail
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>,
        Stefan Roesch <shr@devkernel.io>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        linux-fsdevel@vger.kernel.org
References: <202309121427.f3542933-oliver.sang@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <202309121427.f3542933-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.09.23 09:02, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "kernel-selftests.proc.proc-empty-vm.fail" on:
> 
> commit: 8b47933544a68a62a9c4e35f8d8a6d2a2c935823 ("proc/ksm: add ksm stats to /proc/pid/smaps")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

https://lkml.kernel.org/r/725e041f-e9df-4f3d-b267-d4cd2774a78d@p183

-- 
Cheers,

David / dhildenb

