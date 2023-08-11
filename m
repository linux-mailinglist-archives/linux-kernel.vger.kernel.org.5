Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5303277972C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbjHKSkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHKSke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC62B30E6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691779191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQSZqaBPxPLEbOWk1UdqCwfBAXoTtMuxQ+F1Qordg04=;
        b=OjtCXS7tMF4NOVheb6TjjwklOYJz6eb2fkbcNNveqIkOqqv6Jkl/SQfppmZOmpXn++bMUX
        5r89HWt2YxAS03U8sAPeJ7tHhPL6Xxuavkz0ExDdGPn83e1AbLpsGeG/GqYVHTpMPt+GQk
        HAtG4CdyBFz1TLD5Dzw5xpX20pDolOU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-NR13IzDhM5CIeU9Jcz90BQ-1; Fri, 11 Aug 2023 14:39:49 -0400
X-MC-Unique: NR13IzDhM5CIeU9Jcz90BQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3178e3f46b1so1315366f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691779188; x=1692383988;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQSZqaBPxPLEbOWk1UdqCwfBAXoTtMuxQ+F1Qordg04=;
        b=hb760nCII/SD/coRe3vh82Z5TarNlR0TTgUSMT4lTHlcQ/JW08vrRoO4P8V4ltE8Ny
         CUR/niR46sN8VcoQ9bpk9Cv0SVwNmfqvYr23TFxhYBu+sh4mBNKdgjPSJnZvyJ+Qafzu
         ZJyADMTJpsgpjlmMep82fKmQIlI//22z73LYM4i9LVB1+L0436CmyLYKbxCDWtAD1YiZ
         Xl65pZ3fAR+i+hlNPf5C3ZdGvxcl8kpWgpzbftgGBwpue1Cxzu2L3cik7130MNl+IwD2
         1TAfROdvXcyjG5FWdf/DlSVgkWLYT5hzQlV+TUOAKFNPtEa1tlUnQJZclY3SLC7F0Zxr
         UtvA==
X-Gm-Message-State: AOJu0Yzrna6Q0p0rfkN42TQWdKO+5VEG1fPzHWCugbxoAqMQtsvQgzX8
        m+gNeP8sFAXvxeGVlzl8LtOMI5EP0cvsbdVYv9NbYwtBrcZov8MX6SH7snZZuPJLkaGzvAvOkT1
        jQ68UM3uoo47yuuEtdluLbhKi
X-Received: by 2002:adf:efc2:0:b0:314:370f:e92c with SMTP id i2-20020adfefc2000000b00314370fe92cmr2209058wrp.67.1691779188497;
        Fri, 11 Aug 2023 11:39:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH61cb9gi24MjCxCXSGg4TnORc0Tig5arRBwgwd6TW8enuaXyKtKpsva9dj5uUlJDaO/WG8g==
X-Received: by 2002:adf:efc2:0:b0:314:370f:e92c with SMTP id i2-20020adfefc2000000b00314370fe92cmr2209032wrp.67.1691779188068;
        Fri, 11 Aug 2023 11:39:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:3000:973c:c367:3012:8b20? (p200300cbc71a3000973cc36730128b20.dip0.t-ipconnect.de. [2003:cb:c71a:3000:973c:c367:3012:8b20])
        by smtp.gmail.com with ESMTPSA id l6-20020adff486000000b003143867d2ebsm6200653wro.63.2023.08.11.11.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 11:39:47 -0700 (PDT)
Message-ID: <846e9117-1f79-a5e0-1b14-3dba91ab8033@redhat.com>
Date:   Fri, 11 Aug 2023 20:39:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 0/5] Reduce NUMA balance caused TLB-shootdowns in a
 VM
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>, Yan Zhao <yan.y.zhao@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com,
        mike.kravetz@oracle.com, apopple@nvidia.com, jgg@nvidia.com,
        rppt@kernel.org, akpm@linux-foundation.org, kevin.tian@intel.com,
        Mel Gorman <mgorman@techsingularity.net>
References: <20230810085636.25914-1-yan.y.zhao@intel.com>
 <41a893e1-f2e7-23f4-cad2-d5c353a336a3@redhat.com>
 <ZNSyzgyTxubo0g/D@yzhao56-desk.sh.intel.com>
 <6b48a161-257b-a02b-c483-87c04b655635@redhat.com>
 <1ad2c33d-95e1-49ec-acd2-ac02b506974e@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1ad2c33d-95e1-49ec-acd2-ac02b506974e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Ah, okay I see, thanks. That's indeed unfortunate.
> 
> Sigh. All this difficulty reminds me that this mechanism was created in
> the early days of NUMA. I wonder sometimes lately whether the cost, in
> complexity and CPU time, is still worth it on today's hardware.
> 
> But of course I am deeply biased, so don't take that too seriously.
> See below. :)

:)

>>
>>>
>>> Then current KVM will unmap all notified pages from secondary MMU
>>> in .invalidate_range_start(), which could include pages that finally not
>>> set to PROT_NONE in primary MMU.
>>>
>>> For VMs with pass-through devices, though all guest pages are pinned,
>>> KVM still periodically unmap pages in response to the
>>> .invalidate_range_start() notification from auto NUMA balancing, which
>>> is a waste.
>>
>> Should we want to disable NUMA hinting for such VMAs instead (for example, by QEMU/hypervisor) that knows that any NUMA hinting activity on these ranges would be a complete waste of time? I recall that John H. once mentioned that there are
> similar issues with GPU memory:  NUMA hinting is actually counter-productive and they end up disabling it.
>>
> 
> Yes, NUMA balancing is incredibly harmful to performance, for GPU and
> accelerators that map memory...and VMs as well, it seems. Basically,
> anything that has its own processors and page tables needs to be left
> strictly alone by NUMA balancing. Because the kernel is (still, even
> today) unaware of what those processors are doing, and so it has no way
> to do productive NUMA balancing.

Is there any existing way we could handle that better on a per-VMA 
level, or on the process level? Any magic toggles?

MMF_HAS_PINNED might be too restrictive. MMF_HAS_PINNED_LONGTERM might 
be better, but with things like iouring still too restrictive eventually.

I recall that setting a mempolicy could prevent auto-numa from getting 
active, but that might be undesired.

CCing Mel.

-- 
Cheers,

David / dhildenb

