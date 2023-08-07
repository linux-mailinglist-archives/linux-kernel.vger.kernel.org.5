Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF55771ADE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjHGG4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHGG4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDFB10D4
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 23:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691391311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ho4TOU4xYIxDlaPGJbh5CdW3AQ8AoyQ6uWHEuuD2FN8=;
        b=EtdXRM4yeC78nWtoSOjY7HKWOJs0LUIYE+RYB6WK83f16gVrLAZ3TaC7TEyj1upFP2C8sL
        C90m6osz6c6pmxm6IS2km9S+nYOgxLUf6o7PnsXI6DJrshgr2MLJf/6/VddvyssgBqDCau
        m0n3LlIvVOM4K+OnMkTmofxUyk+/ARo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-ENfSAIHrMJO1qy-lIOgz2g-1; Mon, 07 Aug 2023 02:55:10 -0400
X-MC-Unique: ENfSAIHrMJO1qy-lIOgz2g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-317ebae819aso300888f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 23:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691391309; x=1691996109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ho4TOU4xYIxDlaPGJbh5CdW3AQ8AoyQ6uWHEuuD2FN8=;
        b=VeBRP8kHZjX4XEWnrFiE6ZVOql9DtqZa/RO40CemFqMYslwErdzvURBsVposALSti7
         nQKgn6aOYZgiYW5zkVcW1BptKS1AbGdv0X6Y2+PnzOSdZGZbCojSniidp17MFg9LEqUQ
         H6lFbXH/75FC80avHHBEXuRxcWZMrajbEg2a7ueRQ3heIDSuSNiyy1xdSuOhbfYmZ+OY
         AiE2YkPSeQ6NkOHCU/oMDdcBbNu4QbZ2Urqur8q3iDfc5vRPO0L9gyavBhJmeCKa6Upv
         0anGSbF5NipV4bzw6IFlGZZ+7qRIuXzP6gAV16Lmto+9LbNhKUE8zjMcMtk1kLUJ1S7Y
         6IlQ==
X-Gm-Message-State: AOJu0YxiCErjzjhbg8ypps8T6l9AqVPPmG1K8jSwbDyavfvxIfW2sImj
        Lj3dR+Fcib0FWKN5biQ98ydL4VZCc9DoWaUUAunbolYsXFyXSxp/VXykjzXKDQDxI5bzT3SsH66
        02tM9ND2NU/D7ECqetHCKbg0K
X-Received: by 2002:a7b:c3c1:0:b0:3fa:96ad:5d2e with SMTP id t1-20020a7bc3c1000000b003fa96ad5d2emr6236054wmj.19.1691391309012;
        Sun, 06 Aug 2023 23:55:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbqsyRD6exvzZaZpz4Zzq7W+cysAHnnx6rDqQMGoLvuKnifa+ME2mPeuNFLtkftztRZe1Otg==
X-Received: by 2002:a7b:c3c1:0:b0:3fa:96ad:5d2e with SMTP id t1-20020a7bc3c1000000b003fa96ad5d2emr6236048wmj.19.1691391308715;
        Sun, 06 Aug 2023 23:55:08 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id z10-20020a05600c220a00b003fba6a0c881sm14113789wml.43.2023.08.06.23.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 23:55:07 -0700 (PDT)
Message-ID: <763f3b3f-861e-1716-f65f-1b4f256590c5@redhat.com>
Date:   Mon, 7 Aug 2023 08:55:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 04/19] KVM:x86: Refresh CPUID on write to guest
 MSR_IA32_XSS
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Yang Weijiang <weijiang.yang@intel.com>
Cc:     peterz@infradead.org, john.allen@amd.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com,
        chao.gao@intel.com, binbin.wu@linux.intel.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
References: <20230803042732.88515-1-weijiang.yang@intel.com>
 <20230803042732.88515-5-weijiang.yang@intel.com>
 <ZM1C+ILRMCfzJxx7@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ZM1C+ILRMCfzJxx7@google.com>
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

On 8/4/23 20:27, Sean Christopherson wrote:
> I think my preference is to enforce guest CPUID for host accesses to 
> XSS, XFD, XFD_ERR, etc I'm pretty sure I've advocated for the exact 
> opposite in the past, i.e. argued that KVM's ABI is to not enforce 
> ordering between KVM_SET_CPUID2 and KVM_SET_MSR. But this is becoming
> untenable, juggling the dependencies in KVM is complex and is going
> to result in a nasty bug at some point.

Fortunately, you are right now.  Well, almost :) but the important part 
is that indeed the dependencies are too complex.

While host-side accesses must be allowed, they should only allow the 
default value if the CPUID bit is not set.

Paolo

