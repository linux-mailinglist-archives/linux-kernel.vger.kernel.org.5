Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567DC7974CE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbjIGPlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjIGPg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:36:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCCD10FF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694100902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PAcSsae0YNgTYfGvfvPfyDPOrHrWCq/il+FxlLj2pm8=;
        b=HC1pTCpAyJ4jzwB1Ck1xRh3e0s2ggO4w/gjjLOJnzXnW8FZ70lOjVb4HExc65VQKYRZ+Fr
        eEmLPb954cSCH3AwyFgAOJQclRRdENetQMEVydEhK7vTNBih/Pu72qUGytuCnsvkEY1eGG
        1Zod3rBwivMb959FriGuFw/uAdkoITM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-w0mB7kUyNseT2pMr9Xv_1w-1; Thu, 07 Sep 2023 07:15:54 -0400
X-MC-Unique: w0mB7kUyNseT2pMr9Xv_1w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-401e521122fso6325095e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 04:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694085353; x=1694690153;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PAcSsae0YNgTYfGvfvPfyDPOrHrWCq/il+FxlLj2pm8=;
        b=XqB/rXnwD5PAZFAQtNv54XMwr12Y2aAX1NgyeOoAeS15pwNF1ue0JYPjw4YTjJyreI
         5jYzpr4kAerCbc7JbbXQCcyQUaBBr6NOgZdvdDtZ7jvoJHYw0hGC6G/Qnh7ABSMAqytU
         nZFE5V9bJtRH5cJfs9D6kwta0hyOgeVuoH5Gp7MHZvhxY+JUgMgPP4MgvJMJjlB1REYN
         iWHWRvICIkIgplanUpfpewhpzo5e7XhvdgL4hE+5hOPj48+Vhmn0bmqGKq4U7WkmqO+8
         iqEl3xhXSspEV/Pb5bEL8G/sESKHtvzRxkN4VcT6gUiCYzfpCz2o3iv1FFCOKFGpTjBL
         HCFw==
X-Gm-Message-State: AOJu0YzsnloTZa2B2ZCXJVir7saKSQbA/6fE7MSo5zeQbWZkgdcKG0Mf
        9c+8f20NpjoxAZ0OvZF7fa6IzQAcehKFKOGPN1DxZAunrBp21ejfT0Z66vGL5vx0bleNn6GEPmf
        S0tjkftVI1CEY87pAotKzkDVs
X-Received: by 2002:a05:600c:204:b0:3fe:16c8:65fa with SMTP id 4-20020a05600c020400b003fe16c865famr4233758wmi.4.1694085353338;
        Thu, 07 Sep 2023 04:15:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb3dYsjRO0Uys0ckUXjh7u4WFrgiUtUAF8w/TQ42QoSWJUiZEM8Z8xk9KuUBMBoHTB/qyHaQ==
X-Received: by 2002:a05:600c:204:b0:3fe:16c8:65fa with SMTP id 4-20020a05600c020400b003fe16c865famr4233740wmi.4.1694085352900;
        Thu, 07 Sep 2023 04:15:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c711:cb00:d8c3:e672:87cb:e4d9? (p200300cbc711cb00d8c3e67287cbe4d9.dip0.t-ipconnect.de. [2003:cb:c711:cb00:d8c3:e672:87cb:e4d9])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c294400b003fbdbd0a7desm2219839wmd.27.2023.09.07.04.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 04:15:52 -0700 (PDT)
Message-ID: <77404164-a56d-8627-bdd0-42c82661fb3d@redhat.com>
Date:   Thu, 7 Sep 2023 13:15:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] proc: fix smaps_rollup test after KSM changes
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Stefan Roesch <shr@devkernel.io>
References: <725e041f-e9df-4f3d-b267-d4cd2774a78d@p183>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <725e041f-e9df-4f3d-b267-d4cd2774a78d@p183>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.23 13:10, Alexey Dobriyan wrote:

Can you clarify in the patch description that we are fixing up a selftest?

"selftests/proc: fixup proc-empty-vm test"

or similar?

> /proc/${pid}/smaps_rollup is not empty file even if process's address
> space is empty, update the test.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>   tools/testing/selftests/proc/proc-empty-vm.c |    1 +
>   1 file changed, 1 insertion(+)
> 
> --- a/tools/testing/selftests/proc/proc-empty-vm.c
> +++ b/tools/testing/selftests/proc/proc-empty-vm.c
> @@ -267,6 +267,7 @@ static const char g_smaps_rollup[] =
>   "Private_Dirty:         0 kB\n"
>   "Referenced:            0 kB\n"
>   "Anonymous:             0 kB\n"
> +"KSM:                   0 kB\n"
>   "LazyFree:              0 kB\n"
>   "AnonHugePages:         0 kB\n"
>   "ShmemPmdMapped:        0 kB\n"
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

