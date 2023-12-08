Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA56809B87
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbjLHFIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjLHFID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:08:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E554E19A3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 21:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702012053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7DjOW++h2qpYv/KAC35xyOMKgc1I7IXf0474RhNm4+E=;
        b=DCWAZW1keEijMMenLUifNvVAf9whNDBcZ4yHoADZ1Y2lmgI0XnzaS2unJ4c2+foZ7+JO0s
        qO3xXWFUZJpL87mf2BQZUI+oGbR4ehArenXUtkcQWA4NM52B8pSasddy7QcNuoG4HOC3Iu
        XHJeM5iTP5G81SpHofECU8MH10PnDqs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-LvQAJoYQPu6cSeQdOfmYCA-1; Fri, 08 Dec 2023 00:07:29 -0500
X-MC-Unique: LvQAJoYQPu6cSeQdOfmYCA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-286978683d0so1429965a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 21:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702012048; x=1702616848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DjOW++h2qpYv/KAC35xyOMKgc1I7IXf0474RhNm4+E=;
        b=qYf9fcTMfrfkbk0u/aVd+eImhG849/WDlMnJVCPHX3A1Dpn5NNob7+B6+mfSD1w573
         8aOFaMZBZovV5IOS3aNojktAF9mDe6D9ecIB8vaAltSveR1KmcGixQV0SUUHkU6tzkJE
         RnsdXvcYOpeNPZC7a0wi3reC7EYOpltwODcDHRwJefAyTqbfd1GU3RBqRmWKWGvpzfmp
         KZy6WRMcYKQNDmvVv/9Sxlw8JmjInzL99ahHgKRqk2pSHGMU8X1PGiyuNn6rSj+oV0JO
         8/mtm97hWte2bVtfQGJIfy7QUnQUoA/WaQIUHWwgBJ1utEx0riyp86NP/v+THFBTnZz2
         s2QQ==
X-Gm-Message-State: AOJu0YyW1o6I3cLM1jBvcj7tEytEt2b6Vl77OX5ItoDxaAqUiJfvrrLm
        oL8YxoYmH2eXiQvSS+rCxO+swvN7SNjKUj+c39MpBzkty2t7qVOFiIF/sBbKZTOPV+M85lXCFEp
        L8bC8UcboN8ENxbGIPP2At5hV
X-Received: by 2002:a17:903:228b:b0:1d0:b16a:b26a with SMTP id b11-20020a170903228b00b001d0b16ab26amr3435382plh.4.1702012048125;
        Thu, 07 Dec 2023 21:07:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6LlOSfQMdwKQHpCvinXE+YTOV9LAn4L/4e5piuadXfTGPzQr096NtqUuMnxxErVNRlrsErQ==
X-Received: by 2002:a17:903:228b:b0:1d0:b16a:b26a with SMTP id b11-20020a170903228b00b001d0b16ab26amr3435375plh.4.1702012047799;
        Thu, 07 Dec 2023 21:07:27 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902869800b001cf9ddd3552sm701722plo.85.2023.12.07.21.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 21:07:27 -0800 (PST)
Message-ID: <c8e1594e-1379-4fb3-904f-fba2cd194cdc@redhat.com>
Date:   Fri, 8 Dec 2023 15:07:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] KVM: selftests: Fix Assertion on non-x86_64 platforms
Content-Language: en-US
To:     Shaoqin Huang <shahuang@redhat.com>, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
References: <20231208033505.2930064-1-shahuang@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231208033505.2930064-1-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/23 13:35, Shaoqin Huang wrote:
> When running the set_memory_region_test on arm64 platform, it causes the
> below assert:
> 
> ==== Test Assertion Failure ====
>    set_memory_region_test.c:355: r && errno == EINVAL
>    pid=40695 tid=40695 errno=0 - Success
>       1	0x0000000000401baf: test_invalid_memory_region_flags at set_memory_region_test.c:355
>       2	 (inlined by) main at set_memory_region_test.c:541
>       3	0x0000ffff951c879b: ?? ??:0
>       4	0x0000ffff951c886b: ?? ??:0
>       5	0x0000000000401caf: _start at ??:?
>    KVM_SET_USER_MEMORY_REGION should have failed on v2 only flag 0x2
> 
> This is because the arm64 platform also support the KVM_MEM_READONLY flag, but
> the current implementation add it into the supportd_flags only on x86_64
> platform, so this causes assert on other platform which also support the
> KVM_MEM_READONLY flag.
> 
> Fix it by using the __KVM_HAVE_READONLY_MEM macro to detect if the
> current platform support the KVM_MEM_READONLY, thus fix this problem on
> all other platform which support KVM_MEM_READONLY.
> 
> Fixes: 5d74316466f4 ("KVM: selftests: Add a memory region subtest to validate invalid flags")
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
> This patch is based on the latest kvm-next[1] branch.
> 
> [1] https://git.kernel.org/pub/scm/virt/kvm/kvm.git/log/?h=next
> ---
>   tools/testing/selftests/kvm/set_memory_region_test.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

