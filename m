Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86528771B0C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 09:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjHGHEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 03:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjHGHEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9C310C2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 00:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691391797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b4v8GA0u0EC8VkcgQUv3B1mp/A++xZyvZaXBENnPjeM=;
        b=etnkgQW4XkK412FSG3nDZPXp1YsuJUag+VOyvVAiVJpVEospd/wNurBh42TPOf3eviv8Qi
        qNnxHuS0m+VGTIpYZHAkD6rfCyQ76T1f20JacXI7HeIHhU+xjnBpIIGAD3SS7fMNJwB2hn
        GTjGYNg93WACl49BOtzPXUMxoCvH88k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-2LKW-HQhPoqOU66DNUXdhg-1; Mon, 07 Aug 2023 03:03:16 -0400
X-MC-Unique: 2LKW-HQhPoqOU66DNUXdhg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fe11910e46so19415625e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 00:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691391795; x=1691996595;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4v8GA0u0EC8VkcgQUv3B1mp/A++xZyvZaXBENnPjeM=;
        b=G94TThGi+ZQ3652+49vYpMzzGIJMmu6h+dDjkSew8Pp7wLmdUdc9heXBBf6nObyHWg
         A/6WfKIHzSqBEli+r9iJggRS1MvpdQpFzqboIXuVe6moY1I48lYn7GBxMF9F6MfKVyvi
         eWQjvdNbM72fIywGV6NOOWWJ7MbQltq6MCXxeBdeaxE/el5EYbptmfAWy/7ra5nwUmeW
         AeW6dG3XRQhIpJKdoniPWsvSAanG8c2bDkLHmDEOjHu7BYA/s1FwslMVTIQjHa5M/sw3
         VXvcoQqFJXBcJltIR8X81xqvBH7nKd5RW8RCHEuf7uMU7shUhLcmlGTPNHNeDnzpnHFm
         N0Ig==
X-Gm-Message-State: AOJu0YygUH3QXoNvjX5hR34qi2NJcyak0+0ViQww8EZyiVgw7rGQZ/gH
        rX0cgMRXGnNM0cfDl5CdxERL74QVU92UePJzqTbFTLF6D2DwJnDH+GU0k70m/EYIlJprOsg7KgN
        RRpszZr6WBReHuF2P3gWkx34NzvkRE1ky
X-Received: by 2002:a05:600c:22c6:b0:3fe:df0:c10f with SMTP id 6-20020a05600c22c600b003fe0df0c10fmr4618389wmg.17.1691391794833;
        Mon, 07 Aug 2023 00:03:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCFAFoTUZJH8TVrXZsQ7UgyVKCscgQ+xaV6pqbrkpL57eDgfEyPnej4zYot4z9yJV489u6tg==
X-Received: by 2002:a05:600c:22c6:b0:3fe:df0:c10f with SMTP id 6-20020a05600c22c600b003fe0df0c10fmr4618372wmg.17.1691391794472;
        Mon, 07 Aug 2023 00:03:14 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id i12-20020a05600c290c00b003fbb618f7adsm9704074wmd.15.2023.08.07.00.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 00:03:13 -0700 (PDT)
Message-ID: <73338ff4-24b0-0358-0419-ad0fb0101813@redhat.com>
Date:   Mon, 7 Aug 2023 09:03:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 11/19] KVM:VMX: Emulate read and write to CET MSRs
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Chao Gao <chao.gao@intel.com>,
        Yang Weijiang <weijiang.yang@intel.com>, peterz@infradead.org,
        john.allen@amd.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com,
        binbin.wu@linux.intel.com
References: <20230803042732.88515-1-weijiang.yang@intel.com>
 <20230803042732.88515-12-weijiang.yang@intel.com>
 <ZMyJIq4CgXxudJED@chao-email> <ZM1tNJ9ZdQb+VZVo@google.com>
 <c5bdcd8e-c6cd-d586-499c-4a2b7528cda9@redhat.com>
 <ZM15zd998LCOUOrZ@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ZM15zd998LCOUOrZ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/23 00:21, Sean Christopherson wrote:
> Oooh, the MSRs that don't exempt host_initiated are added to the list

(are *not* added)

> of MSRs to save/restore, i.e. KVM "silently" supports 
> MSR_AMD64_OSVW_ID_LENGTH and MSR_AMD64_OSVW_STATUS.
> 
> And guest_pv_has() returns true unless userspace has opted in to
> enforcement.

Two different ways of having the same bug.  The latter was introduced in 
the implementation of KVM_CAP_ENFORCE_PV_FEATURE_CPUID; it would become 
a problem if some selftests started using it.

Paolo

