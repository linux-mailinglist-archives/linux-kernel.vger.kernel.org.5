Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318D17FC398
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346492AbjK1Skw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjK1Sku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:40:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF29F4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701196854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VHDSVc68YkNjIz/fNayvFmFoqWmnEg0LsBzOyPrViJ0=;
        b=TBMxYFd6nXCKbMbgEtX0EGZlCR7Ot7WuyAD6+0IYEwjZ1/IAEnGz1Xm2lDk+agaK+CArIP
        DQ4rZEYVkLP9SC4twuj4rSLH1LB1Y8Mk6chNCusYZwlgw4WCkkmMugBczv5sBABD5wbUqr
        KTKvoTVzdCIVGGxmQwuE01Zc9rQEgS0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-AW74jAjePc-TLBv9O-r1dw-1; Tue, 28 Nov 2023 13:40:53 -0500
X-MC-Unique: AW74jAjePc-TLBv9O-r1dw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-332dfa77997so3974381f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:40:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701196852; x=1701801652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHDSVc68YkNjIz/fNayvFmFoqWmnEg0LsBzOyPrViJ0=;
        b=IA2EfHxCoM/9F2X3ul3s/E7SaySx8Q2lzLojAtp6L5h5U4excC1XadhtHdBb6DOX8B
         HKN3Gpwey7N8FpUqX9YJTWwG985gvUDELe6GHZ/RUXOebww1c8B5mdo426h4rdtApbNL
         Ds+S3klhX/guttYiUghPbejlWbWVp4IoaGrE565emPXUH1uOIhaKVeK4tejEnAQQdF7B
         X5D/+nlmDzmtaIS/NGJp/7ByZGsp5b+6rZuh4kqiXTuV/XmDe95LQ3j3nn2a5tWU/niw
         y2l34BzyCwVEVGC3wXHV4vXZvmAcw8/Bzt8mlcc9SLwFfpaDRrhBRZFcd2f53msJaRuk
         TfCw==
X-Gm-Message-State: AOJu0YxNYTJ/x1fTpnl9ypH2EvxbaBBGCP8UcX+rX2kvWjQKt4mbVesq
        VT/2tFYBHZ3hZ/7HAIKCp3dstA6qXFaf+1P9wEwiBOC+YbsiJzXQcnfWcFFYt9dCGJRe29gdqtn
        fqWvl6VkW3dCtpKuGJxKU5qs=
X-Received: by 2002:adf:ef4e:0:b0:324:8239:2873 with SMTP id c14-20020adfef4e000000b0032482392873mr13119568wrp.37.1701196852157;
        Tue, 28 Nov 2023 10:40:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgx9fub6tHc2TIBf8WvN+f8H+w3lnzmfR1oU9iU0W6tR1BbdEUVqOXM76GdnBXAvfNg89crw==
X-Received: by 2002:adf:ef4e:0:b0:324:8239:2873 with SMTP id c14-20020adfef4e000000b0032482392873mr13119557wrp.37.1701196851839;
        Tue, 28 Nov 2023 10:40:51 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-24-178.cust.vodafonedsl.it. [2.34.24.178])
        by smtp.gmail.com with ESMTPSA id y14-20020adff6ce000000b0033308db2576sm3765067wrp.56.2023.11.28.10.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 10:40:51 -0800 (PST)
Message-ID: <d6e92498-1784-48f5-904c-8bd37770c206@redhat.com>
Date:   Tue, 28 Nov 2023 19:40:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kunit: run test suites only after module
 initialization completes
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <20231128101627.65399-1-marpagan@redhat.com>
 <878r6icenj.fsf@minerva.mail-host-address-is-not-set>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <878r6icenj.fsf@minerva.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/11/23 12:15, Javier Martinez Canillas wrote:
> Marco Pagani <marpagan@redhat.com> writes:
> 
> Hello Marco,
> 
> [...]
> 
>> @@ -737,12 +738,14 @@ static void kunit_module_exit(struct module *mod)
>>  	};
>>  	const char *action = kunit_action();
>>  
>> +	if (!suite_set.start || !virt_addr_valid(suite_set.start))
>> +		return;
>> +
> 
> I would add a comment here explaining why this condition is checked and
> what it means. Maybe something like the following ?
> 
> +       /*
> +        * Check if the kunit test suite start address is a virtual
> +        * address or a direct mapping address. This is used as an
> +        * indication of whether the kunit_filter_suites() was used
> +        * to filter the kunit test suite or not.
> +        *
> +        * If is not a virtual address, then this means that the
> +        * kunit_module_init() function was not called and the kunit
> +        * suite was not filtered. Let's just bail out in that case.
> +        */
> +       if (!suite_set.start || !virt_addr_valid(suite_set.start))
> +               return;

Good point. I'll add a comment in v3.

> 
> The patch makes sense to me though and agree that is a better approach.
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> 

Thanks,
Marco

