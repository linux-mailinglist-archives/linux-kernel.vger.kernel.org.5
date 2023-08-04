Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D72A77076A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjHDSBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHDSBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:01:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B01546A8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691172034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=plknfH3SDQ/AujyL8eWFqeOy7h7VD7A1dUfZFnOOKDM=;
        b=BbimRuwNeLcqubjf0P0fbZemwkJ/NWqiM3ZiVKsJwsug3oTlOFgHNXY2gbYXArmCqnFED/
        LvZXeAGLDMd5S7Ss1qB20C8QjvUWHu+0bT9+NSm+Fgju3akmuG7mk0i3ZRJeG6Jl6a1aqo
        KPRiYcEDr65oOQKm1dGuTJdJbcaMn6Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-zD1dSulTMcKEwRfLJPGtMA-1; Fri, 04 Aug 2023 14:00:29 -0400
X-MC-Unique: zD1dSulTMcKEwRfLJPGtMA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3176c4de5bbso1189051f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 11:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691172028; x=1691776828;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plknfH3SDQ/AujyL8eWFqeOy7h7VD7A1dUfZFnOOKDM=;
        b=lp73QBeqlF7ZtrhKy66xxyMDVXhjvIfmukCKeFASeQ3V5FXCuBNILk2df7HAac89Bm
         y5t5aZqbVidZPqnZx7oTz+OkFArDlZcpnO3aTU0kx84BSxKEQBsaVYhD0XRYDqFHzEUB
         0YhHE/Bl4kRGp+nic1BaQVO3M+nBVD8K9tanMy2CmTwxm26dwPpBaQdt4f3b6HGY7O7R
         mkUOA5RPMjhikDjsYTdZUQfUHyt42LWlKAjXvd5+WiI2IfZY966QGKYDDObRl3DXiZPx
         rwoy9tFYJBNhactF4o1ngZ9+rjFarro0O6j2sq5SvaW7hycYI9goEPy7h9SdYAZyEusf
         uFCg==
X-Gm-Message-State: AOJu0YxcNd3uexpEc9KjuPafsbiBwgOjD2JeAaQ8zSFnz8G7RYDAvWYs
        V0EpRiSiat5gvxxpxJ3o0QPNePnDlo9BSpwb7RezXIQnyabPmbaDUE5T4jucbH1Ub5dthuJ16nm
        h1Z7weAlGo3rnHAWlAAtUqKWJ
X-Received: by 2002:adf:e90b:0:b0:314:49e4:b0c4 with SMTP id f11-20020adfe90b000000b0031449e4b0c4mr1906972wrm.70.1691172028376;
        Fri, 04 Aug 2023 11:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxHfzUz1EPw43upa/7C1PthJlkuVCBp6Z+blRveCGIYkYDQyDnvZ5j7WD7RCluzgxUr1F+kA==
X-Received: by 2002:adf:e90b:0:b0:314:49e4:b0c4 with SMTP id f11-20020adfe90b000000b0031449e4b0c4mr1906951wrm.70.1691172027948;
        Fri, 04 Aug 2023 11:00:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2d:8e00:a20e:59bc:3c13:4806? (p200300d82f2d8e00a20e59bc3c134806.dip0.t-ipconnect.de. [2003:d8:2f2d:8e00:a20e:59bc:3c13:4806])
        by smtp.gmail.com with ESMTPSA id m15-20020a056000008f00b0031417b0d338sm3082057wrx.87.2023.08.04.11.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 11:00:27 -0700 (PDT)
Message-ID: <dff76f35-8564-1908-2a17-1479c53e56cf@redhat.com>
Date:   Fri, 4 Aug 2023 20:00:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 7/7] selftest/mm: ksm_functional_tests: Add PROT_NONE
 test
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20230803143208.383663-1-david@redhat.com>
 <20230803143208.383663-8-david@redhat.com> <ZMv6wG7PqehMp6vT@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZMv6wG7PqehMp6vT@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.23 21:06, Peter Xu wrote:
> On Thu, Aug 03, 2023 at 04:32:08PM +0200, David Hildenbrand wrote:
>> Let's test whether merging and unmerging in PROT_NONE areas works as
>> expected.
>>
>> Pass a page protection to mmap_and_merge_range(), which will trigger
>> an mprotect() after writing to the pages, but before enabling merging.
>>
>> Make sure that unsharing works as expected, by performing a ptrace write
>> (using /proc/self/mem) and by setting MADV_UNMERGEABLE.
>>
>> Note that this implicitly tests that ptrace writes in an inaccessible
>> (PROT_NONE) mapping work as expected.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> [...]
> 
>> +static void test_prot_none(void)
>> +{
>> +	const unsigned int size = 2 * MiB;
>> +	char *map;
>> +	int i;
>> +
>> +	ksft_print_msg("[RUN] %s\n", __func__);
>> +
>> +	map = mmap_and_merge_range(0x11, size, PROT_NONE, false);
>> +	if (map == MAP_FAILED)
>> +		goto unmap;
>> +
>> +	/* Store a unique value in each page on one half using ptrace */
>> +	for (i = 0; i < size / 2; i += pagesize) {
>> +		lseek(mem_fd, (uintptr_t) map + i, SEEK_SET);
>> +		if (write(mem_fd, &i, sizeof(size)) != sizeof(size)) {
> 
> sizeof(i)?  May not matter a huge lot, though..

Oh, indeed, thanks!

> 
>> +			ksft_test_result_fail("ptrace write failed\n");
>> +			goto unmap;
>> +		}
>> +	}
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> 

Thanks!

-- 
Cheers,

David / dhildenb

