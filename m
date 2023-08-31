Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446E878EF74
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346400AbjHaOTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbjHaOTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB45D7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 07:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693491533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qfOe+dPfe8Tl+0Hf8LZoRkzGtXadoANomNp+T0aHZy8=;
        b=INVZOIQGoTGktWSuSr0RiUNhNvNXDRM2mP2RVklVV/7NJYzzcX4bTKq8MKUtevmm/1XALs
        rbeP0x8AdhvtiL/TWcyFkEsd8/NApJUDIRcODWlB/OciwM2xoA2iFwqe03AH0PgpGBZZ9A
        YQT62Nq+2TzNDwt9Riqy/DQiNZx501Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-SvfONyrcMM-BIEAHmVP_KA-1; Thu, 31 Aug 2023 10:18:51 -0400
X-MC-Unique: SvfONyrcMM-BIEAHmVP_KA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-313c930ee0eso485657f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 07:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693491530; x=1694096330;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfOe+dPfe8Tl+0Hf8LZoRkzGtXadoANomNp+T0aHZy8=;
        b=OudWeaA3TVVxKKKVXqob8by2ZBiegn/rpkocCg4eFQLQ63eNO6HW+2tuBYZYoSZPZS
         fjRIH/A39nwJ11RVG5w/l7U8XbhvQWsZBHKEycEyJiNnVCaXBMT6QTnfme79bDyfaTxN
         wUGoWjXsTsFqUKldCdgw1fCb/M/KCHyrqaYq/9D+Ro5e9R9rww5CWI+Y3vmX88AM342L
         b6lubhIG2GI8b37D4Vx+SFMXf3PJm2/a8yhgbTFxQjagJE714kAbST0RTB24qHM+1rYA
         CiHVHXcAwQ9QFxdiqs9aIXgvHNOHmGiYpBwR2U3hji8vUgXBYnSwusIDqG449xwm5A6P
         dmNg==
X-Gm-Message-State: AOJu0YyLgj9p6NgR37C1ZyqpZkW/0vO4IMVA97NOCEn6Yrfvs0WuiUBj
        AFRfBTu7MS85Qc81YZO4WO5e7olRCzr/0YpdDAsWSbDQ2k8a0YWYXBrZAGtWiUVPmuctxPhpCJu
        nEdlirXlDbzpoG/HRkwMLCdHS
X-Received: by 2002:adf:de83:0:b0:31a:d5fa:d710 with SMTP id w3-20020adfde83000000b0031ad5fad710mr3999791wrl.2.1693491530597;
        Thu, 31 Aug 2023 07:18:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXP/eJNDC2hoZPVCc/SJFux1N563pEa5Nz7zVIqZkcn8iYKz7cZrnue0cFtJdNABlUcQw1OQ==
X-Received: by 2002:adf:de83:0:b0:31a:d5fa:d710 with SMTP id w3-20020adfde83000000b0031ad5fad710mr3999772wrl.2.1693491530201;
        Thu, 31 Aug 2023 07:18:50 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id a2-20020adff7c2000000b003177074f830sm2383424wrq.59.2023.08.31.07.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 07:18:49 -0700 (PDT)
Message-ID: <122aefbf-0ed7-cdd3-5c0a-3d1c51429598@redhat.com>
Date:   Thu, 31 Aug 2023 16:18:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] Introduce persistent memory pool
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Madhavan Venkataraman <madvenka@linux.microsoft.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        James Gowans <jgowans@amazon.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Jinank Jain <jinankjain@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <64e7cbf7.050a0220.114c7.b70dSMTPIN_ADDED_BROKEN@mx.google.com>
 <2023082506-enchanted-tripping-d1d5@gregkh>
 <64e8f6dd.050a0220.edb3c.c045SMTPIN_ADDED_BROKEN@mx.google.com>
 <2023082633-magnetize-cupcake-accc@gregkh>
 <64ea25cd.650a0220.642cc.50e6SMTPIN_ADDED_BROKEN@mx.google.com>
 <2023082620-saint-petition-bb89@gregkh>
 <64ea3699.170a0220.13ee0.5c3aSMTPIN_ADDED_BROKEN@mx.google.com>
 <2023082619-puzzling-viewable-fa69@gregkh>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <2023082619-puzzling-viewable-fa69@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/23 22:04, Greg Kroah-Hartman wrote:
>> Yeah, I guess the "ABI" word in misleading here, especially the first
>> letter. I mean something else: the old kernel/new kernel.
>> This persistent memory pool (its metadata) is supposed to be passed
>> across kexec with the data. That is probably the main difference in
>> comparison to pmem or cma.
>> Since the header can change its format between kernels, there should be
>> a way to identify it.
> 
> Ah.  Hah, that's crazy, and it's never going to work, you need to just
> test the version of the kernel that the image was created for (you have
> that in the kernel already) and verify that it is the same before
> loading the new one.
> 
> That way you never have to worry about any "version number", it's just
> the kernel specific version number instead.

Checking the version of the kernel is not enough because you want to 
support kexec to a newer kernel.

I agree though that a version number is not needed.  In the end this is 
just like a filesystem and you'd better keep it backwards compatible. 
If you think you might need an extra field in the header, you have to 
leave some padding and add a "flags" field that right now is always 
zero.  Or something like that.

Paolo

