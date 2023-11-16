Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F4B7EE9E3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 00:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjKPXLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 18:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjKPXLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 18:11:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ECED53
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 15:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700176259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=CgEX29Pt1JmGCTcHMQ0I2eQh29hYElt25FeFUIb2i0w=;
        b=aLx81FzERPpO/o7HoZDUSmvw+Y0RIOxbFFgN2IOyCpoKJiTqOxJvrjLCtiP5qH1Fsk5JAg
        0jLKYFUqmfQSI1LXNXkqxAfIPAbPx2gtHUhajhCSY7xNArSDNcRljRidVJRFq7ArnSKvhK
        TTQN2NMZ/nge59fIYnILxnIGg3jiswo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-qcprEz7rO6ee1DuIrP_GDA-1; Thu, 16 Nov 2023 18:10:57 -0500
X-MC-Unique: qcprEz7rO6ee1DuIrP_GDA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32da8de4833so646747f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 15:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700176256; x=1700781056;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgEX29Pt1JmGCTcHMQ0I2eQh29hYElt25FeFUIb2i0w=;
        b=Qz/oLpvCV3rBtt48ayVWKZGP/RtVsHa97HgsDk0+zczt7nO8F1d06eAR9UqHZOk6RX
         bBfmw1viP/JTBhze9szpp1mriM9Pke4LNUvIUOIS4AeKU8ux5VDOGFnrwlZTiddDZQVe
         BCY8PxrxFGZirAI2FHsq8e5QEoOvxgxY7vfmQ48vrY+ht5Pq+XRXuE7PtzfUil4u3q3s
         oLC5/Jke+sSRetQIV1d+vDT5jS2LSRS04NMAkGHPCZFLZn/MTtZlMiP4tF+eB+XLN3+S
         fAnng8TQiVc0eDh1ikiGY6jouJkl/wYF7WbHjJu7W4skQcfdMVOIsFRmzpDWxZ5/jN+0
         6yPA==
X-Gm-Message-State: AOJu0YyOIn3uBFw0ilYsK2+LdHLjTDuJK97nSlhFZudAJc1eV4PFSUNf
        Pm6S+i+OD9fV4TJKXFrD/mAKBOQNVGr2r2v31FpjYIG4Qg9GgPHMPfzqogldhqaXgaE+9TYb5et
        +VrtqX9smaVFE7eN+i7JfM5JIIvP7QE0C
X-Received: by 2002:adf:e90a:0:b0:31f:db1b:7296 with SMTP id f10-20020adfe90a000000b0031fdb1b7296mr11979344wrm.21.1700176256588;
        Thu, 16 Nov 2023 15:10:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5jEbwrcA73XAM/14JHCdI8QNFP+LmTBo3lEJ4Dl79qKSu3tJRixSwerp696usy1cCbedmZg==
X-Received: by 2002:adf:e90a:0:b0:31f:db1b:7296 with SMTP id f10-20020adfe90a000000b0031fdb1b7296mr11979337wrm.21.1700176256295;
        Thu, 16 Nov 2023 15:10:56 -0800 (PST)
Received: from ?IPV6:2003:cb:c714:e000:d929:2324:97c7:112c? (p200300cbc714e000d929232497c7112c.dip0.t-ipconnect.de. [2003:cb:c714:e000:d929:2324:97c7:112c])
        by smtp.gmail.com with ESMTPSA id d5-20020adfef85000000b0032fb46812c2sm573718wro.12.2023.11.16.15.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 15:10:55 -0800 (PST)
Message-ID: <146fee4b-fbd3-4571-9c81-8ae8393cb391@redhat.com>
Date:   Fri, 17 Nov 2023 00:10:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mm/selftests: Fix pagemap_ioctl memory map test
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>
References: <20231116201547.536857-1-peterx@redhat.com>
 <20231116201547.536857-4-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231116201547.536857-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.11.23 21:15, Peter Xu wrote:
> __FILE__ is not guaranteed to exist in current dir.  Replace that with
> argv[0] for memory map test.
> 
> Fixes: 46fd75d4a3c9 ("selftests: mm: add pagemap ioctl tests")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tools/testing/selftests/mm/pagemap_ioctl.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
> index befab43719ba..d59517ed3d48 100644
> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
> @@ -36,6 +36,7 @@ int pagemap_fd;
>   int uffd;
>   int page_size;
>   int hpage_size;
> +const char *progname;
>   
>   #define LEN(region)	((region.end - region.start)/page_size)
>   
> @@ -1149,11 +1150,11 @@ int sanity_tests(void)
>   	munmap(mem, mem_size);
>   
>   	/* 9. Memory mapped file */
> -	fd = open(__FILE__, O_RDONLY);
> +	fd = open(progname, O_RDONLY);
>   	if (fd < 0)
>   		ksft_exit_fail_msg("%s Memory mapped file\n", __func__);
>   
> -	ret = stat(__FILE__, &sbuf);
> +	ret = stat(progname, &sbuf);
>   	if (ret < 0)
>   		ksft_exit_fail_msg("error %d %d %s\n", ret, errno, strerror(errno));
>   
> @@ -1472,12 +1473,14 @@ static void transact_test(int page_size)
>   			      extra_thread_faults);
>   }
>   
> -int main(void)
> +int main(int argc, char *argv[])
>   {
>   	int mem_size, shmid, buf_size, fd, i, ret;
>   	char *mem, *map, *fmem;
>   	struct stat sbuf;
>   
> +	progname = argv[0];
> +
>   	ksft_print_header();
>   
>   	if (init_uffd())

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

