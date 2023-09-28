Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642127B240A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjI1Rgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjI1Rg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:36:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D5D1AD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695922538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bhJQz2nsCHp2m+57NVX3KFHSV/EDTbVztb5rANet7Mk=;
        b=gko+U4g0BxHIeNZI9RJtUihgLryI9N8Xf21BdrpU1yelEDl2j4je8CwKd/msd9B+nWTrT9
        blr3+0HMFR986Fvc1aadSstaFFuwKjqmP4GHtMOiPAiGbMAc+ee2P3fXKGpKpZstAM+DCu
        Qr9B2JrDRzfhT+kqec9HWJVq0q3Xgbc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-1x7f1H-0Ngy1dhePf8-DOg-1; Thu, 28 Sep 2023 13:35:35 -0400
X-MC-Unique: 1x7f1H-0Ngy1dhePf8-DOg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4063f0af359so44583815e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695922534; x=1696527334;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhJQz2nsCHp2m+57NVX3KFHSV/EDTbVztb5rANet7Mk=;
        b=TZKxSbmIM5vzU1Zit+mYreuPbi/eH1GCbRrA4kA8jnBWmmKCoj2fSDEpMCovCXqxsN
         Lx+zFnDDuwnxrdRBm6VfkVeNE6ffJEl61Go0GKcu6YomFdEohtAszrQzg+PYby2DS+qZ
         beFLAUBhEkxxnG3K6gkikeSilKBnC2VzTzgjHWbzcq6Yx2VeXjdYZLia4t9AtI+xyc3t
         EXszeJu/iK1BvYufT+NFRdrZEPJvRxFVvVekOO0DoGKvlDyu+17UFAgtbPGUEWn2z3RU
         jOKn9prxWUE/+VmNDc4aWNUI7p8yROdOLLlAXEWksojKNsM6/ysIAF+EELWcH7XlogbW
         w5Mg==
X-Gm-Message-State: AOJu0Yw8JplxzTzharoR8NPevYpWWLZKQWntaW+WZ99auBwr7tHuQLnI
        n+oZ5Q2DGERfC7Xm6poqgFpnbKB/xC+ZCTnxrQji+OCIK9BJKu/EvSyrFwC8b71s8cFo7xLfQyx
        NI0cPKeI8m7EuPUNymgu8PGYx
X-Received: by 2002:a7b:cd95:0:b0:405:95ae:4a94 with SMTP id y21-20020a7bcd95000000b0040595ae4a94mr1736605wmj.5.1695922534563;
        Thu, 28 Sep 2023 10:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1D4mtRbNaTqnzKHYbzNWGSnEHm8nnG9RRLTvd9ee4kE9dx1bCsUvsR1IDCdX32RkbnUVjNw==
X-Received: by 2002:a7b:cd95:0:b0:405:95ae:4a94 with SMTP id y21-20020a7bcd95000000b0040595ae4a94mr1736570wmj.5.1695922534181;
        Thu, 28 Sep 2023 10:35:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:f00:b37d:4253:cd0d:d213? (p200300cbc7180f00b37d4253cd0dd213.dip0.t-ipconnect.de. [2003:cb:c718:f00:b37d:4253:cd0d:d213])
        by smtp.gmail.com with ESMTPSA id x5-20020a05600c21c500b0040644e699a0sm4315192wmj.45.2023.09.28.10.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 10:35:33 -0700 (PDT)
Message-ID: <fa924c8d-c954-5612-37eb-43e1976a1b7b@redhat.com>
Date:   Thu, 28 Sep 2023 19:35:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        stanislav.kinsburskii@gmail.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-mm@kvack.org, kys@microsoft.com, jgowans@amazon.com,
        wei.liu@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        graf@amazon.de, pbonzini@redhat.com
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv> <20230927161319.GA19976@skinsburskii.>
 <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.09.23 15:22, Dave Hansen wrote:
> On 9/27/23 09:13, Stanislav Kinsburskii wrote:
>> Once deposited, these pages can't be accessed by Linux anymore and thus
>> must be preserved in "used" state across kexec, as hypervisor state is
>> unware of kexec.
> 
> If Linux can't access them, they're not RAM any more.  I'd much rather
> remove them from the memory map and move on with life rather than
> implement a bunch of new ABI that's got to be handed across kernels.

The motivation of handling kexec (faster?) in a hyper-v domain doesn't 
sound particularly compelling got me for such features. If you inflated 
memory, just don't allow to kexec. It's been broken for years IIUC.

Maybe the other use cases are more "relevant".

-- 
Cheers,

David / dhildenb

