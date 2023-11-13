Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E0E7E98B2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 10:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjKMJQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 04:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjKMJQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 04:16:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EA8D4A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 01:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699866910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=ADm3Ah4BDupTtZHaL12aO2aDm/Ea3RDgQNBUNj91X+c=;
        b=f/riuauT7KIvV5Byg5dtiufE1kUd0JH+/NcqQOAzDkS98IMWKupjsrDFuXCsBs47kDD/r6
        U6R7sWEKpp+DR2myJvr769expTH50b0sNGLC+nyv2/Q/o/j4a9foooauhDlLOP7ow+yczg
        cj/+OzL0KiLx0dxzqfU71pBPvbGMNeI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6--z05810_MS6ruCszxd3rMA-1; Mon, 13 Nov 2023 04:15:08 -0500
X-MC-Unique: -z05810_MS6ruCszxd3rMA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40839252e81so27097785e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 01:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699866907; x=1700471707;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :cc:references:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADm3Ah4BDupTtZHaL12aO2aDm/Ea3RDgQNBUNj91X+c=;
        b=muaeBT6c2kJCiFPtQ/H0Pdqq3hghZsAO6AWOEeGoW4V67hZnOlhJ6gLZCRTnc/JjnX
         TSC78hjw+dcA5T05jQUeST9uJw94VkFTPQbRiWqAeJQGLZhsaVEDikNaF/AxE1yjpM7f
         UY1uMOuXFqPn5tr7gcODT45MW2TnXY2EcttAyUeihrCYH7yTkKXDyMd9M1KmqRGlPJKH
         yRQ/xCoZYZC5JcWJLrnW7N9+bmqh4uHs8HuE1cPNMMbCvJLt9CIgTb3d3dZtSwT1sIs3
         5bqINHCKJjC559lE2VnTkzoodLe+lUPMgLvNZomxIQd0QUFtksztEFKNKM9C9bNL1Onm
         Tomg==
X-Gm-Message-State: AOJu0YzgnrSet6WnChz+Z+cSv5VwHoRzJtf1Eb9t2ttHoCFvSunjeNnd
        m5kwcMvXIsgh9hnhTJNE6onAK2XAX5lWcZtwvJfTCtonxXTgyZX00to15Uh+J+wSWiI1X54f/L+
        eYiCE0t5f7B/ODB9wp5mIYpxj
X-Received: by 2002:a05:600c:a45:b0:409:6e0e:e95c with SMTP id c5-20020a05600c0a4500b004096e0ee95cmr4860137wmq.21.1699866907494;
        Mon, 13 Nov 2023 01:15:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH35Kq0I0xk3f63qoiZTuFETpqo39nFuEvYwf83Ouf2GKWEctf8ka064Vut8xXVsIsSB+7FTg==
X-Received: by 2002:a05:600c:a45:b0:409:6e0e:e95c with SMTP id c5-20020a05600c0a4500b004096e0ee95cmr4860111wmq.21.1699866906999;
        Mon, 13 Nov 2023 01:15:06 -0800 (PST)
Received: from ?IPV6:2003:d8:2f09:f500:a38f:d086:59d4:9df? (p200300d82f09f500a38fd08659d409df.dip0.t-ipconnect.de. [2003:d8:2f09:f500:a38f:d086:59d4:9df])
        by smtp.gmail.com with ESMTPSA id h17-20020a5d5051000000b0032d9523de65sm4924485wrt.48.2023.11.13.01.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 01:15:06 -0800 (PST)
Message-ID: <60081af2-d580-4f82-9233-3d3d7dd883bc@redhat.com>
Date:   Mon, 13 Nov 2023 10:15:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG?] mm/secretmem: memory address mapped to memfd_secret can be
 used in write syscall.
Content-Language: en-US
To:     David Wang <00107082@163.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <61159548.60cf.18baec1fd65.Coremail.00107082@163.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <61159548.60cf.18baec1fd65.Coremail.00107082@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.11.23 12:47, David Wang wrote:
> 
> Hi,
> According to https://lwn.net/Articles/865256/,
> the memory address got from memfd_secret/ftruncate/mmap should not be used by syscalls, since it is not accessible even by kernel.
> 
> But my test result shows that the "secret" memory could be used in  syscall write, is this expected behavior?
> This is my test code:

CCing Mike.

According to the man page:

"The  memory areas backing the file created with memfd_secret(2) are 
visible only to the processes that have access to the file descriptor. 
The memory region is removed from the kernel page tables and only the 
page tables  of  the  processes  holding  the file descriptor map the 
corresponding physical memory.  (Thus, the pages in the region can't be 
accessed by the kernel itself, so that, for example, pointers  to  the 
region can't be passed to system calls.)

I'm not sure if the last part is actually true, if the syscalls end up 
walking user page tables to copy data in/out.

> 
> int main() {
> 	int fd = syscall(__NR_memfd_secret, 0);
> 	if (fd < 0) {
> 		perror("Fail to create secret");
> 		return -1;
> 	}
> 	if (ftruncate(fd, 1024) < 0) {
> 		perror("Fail to size the secret");
> 		return -1;
> 	}
> 	char *key = mmap(NULL, 1024, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> 	if (key == MAP_FAILED) {
> 		perror("Fail to mmap");
> 		return -1;
> 	}
> 	// should be some secure channel
> 	strcpy(key, "ThisIsAKey");
> 	// printf("[%d]key(%s) ready: %p\n", getpid(), key, key);
> 	// getchar();
> 	// make syscall, should err
> 	write(STDOUT_FILENO, key, strlen(key));  //<-- Here the key shows up on stdout.


What probably happens here is that the kernel reads the data via the 
user page tables, and can, therefore, access that memory just fine.

Looking at the selftest (tools/testing/selftests/mm/memfd_secret.c) we 
test that we cannot read from the memfd and cannot write to the memfd. 
We don't test if other syscalls can access that user-provided buffer 
that is backed by a memfd.

-- 
Cheers,

David / dhildenb

