Return-Path: <linux-kernel+bounces-119975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B900988CF99
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1621F81BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4E012AAF3;
	Tue, 26 Mar 2024 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cLa+U+tW"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8F37353B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711487151; cv=none; b=D/lIIM3C2aPIOS2MsSIadv6iyGJHKkbnz6UxDHGM5OHuS2+kulovDr1g3Cep+UXqY+ThkeK9T0BIfs7Z4qms+IXqZcP7E+V+jyaJuYbqCAo0B7mdu5FZKqnmQluTKSW1XB1xKmascBP2Q/0L/PuQJXmIe9Kc9HPR7ujXsxeOCyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711487151; c=relaxed/simple;
	bh=8/6VIqtn4FmmIolsIBNMglvOzS+Y8GYpiEzpcGwTcH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYdIObcUGo89S9UMQNGQPJVHE9WzuCobG1TF0XVOIOJGove5TlnMVyx7Tm1PByUEjYaH4z/y3q3VrqE5mkh8cjXgrkYvYomnn9qQp/xOJiMdUwGtzIKOhNjewcbWw0GnO9QTi3h85da/XWSJ5tUbGXqEnONl7kUT+VfNnTmYyT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cLa+U+tW; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7cc5e664d52so66444139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711487148; x=1712091948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yGoOwtmMdt/+f2HpwpVRuxkbr+Dx6I+/q8ycSS5E9Jc=;
        b=cLa+U+tWOcwWg4UzddQg69ecqLCDZpW5OW9lSzYDqVNllMMERp9XLkQwv2TN7m2zKk
         v/hXed+0IgtrdlnIyqTeKbO4zidZOGjN/+xa9FUc1ns/ylWgjPJ1uLxEtWwmCOq4x60G
         tpi6rRefFG2bMDaUp/2KNNnUpzyZVYGDeksfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711487148; x=1712091948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGoOwtmMdt/+f2HpwpVRuxkbr+Dx6I+/q8ycSS5E9Jc=;
        b=Wp4y//Gi9Cww8s3dt8Y570LLXIXnv6yR2cn0P0bwv91R5jHuyvE7Z9qPXidh5OYUKf
         OQoOUlOpPi9HcRKRsi34vPiSFFTXqXGkxAf6y5qSUlyV+gmgwYjD6CVTkCCPCEseShJm
         HZIzQD9cKf0II9IyQ/drCyajTGNXySTp0m2gwGMBTBJ0WVmHeLpiOqskV/tDRk2xZG/q
         lPtyeWaalqJAm538tmx6j0sb56fhjOBeYqYtzUmmJQYi+X/Z2j3QjrNG/b49ICH93yHi
         1/DP7UMaaHiXaLnwi0vpEz2f+Cg8rS4evlwai/GON1K84fqZDs/2z2Yqxcmmtqo1Mhe5
         kPfA==
X-Forwarded-Encrypted: i=1; AJvYcCUYcYf/IK7Ucqi5WVMF6+DCPKB9WGkO16jrvnFIUoSkpcF8Hd8JJOTGAPeGaezTpKhAnatDULjNQeJHP3f9fvhZ/6E3d1INrYv1hb0k
X-Gm-Message-State: AOJu0Yzoo62oHWNCtOgVUfKk2FHGCG5NY3DcNuIHlaKHr3SFXhcOapPw
	Dzfa/ifWYcUWcE4xqLB8y8sQFYpguBPAbVO9E4j0CaekZKktHOItRH3Y4HKIodw=
X-Google-Smtp-Source: AGHT+IHRvTI1s4ZzDDNA894GQ739rWQ9Evl664b9P5wXeFUCpMADcnYCXFwXrUt8XMYZRnPFudkffw==
X-Received: by 2002:a6b:5d16:0:b0:7d0:3f6b:6af9 with SMTP id r22-20020a6b5d16000000b007d03f6b6af9mr10144994iob.0.1711487148189;
        Tue, 26 Mar 2024 14:05:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id y8-20020a029508000000b00476e3cabd48sm1081667jah.69.2024.03.26.14.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 14:05:47 -0700 (PDT)
Message-ID: <387a04c3-356e-4248-9cd3-7aa1a617c221@linuxfoundation.org>
Date: Tue, 26 Mar 2024 15:05:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] selftests/dmabuf-heap: conform test to TAP format
 output
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, "T.J. Mercier" <tjmercier@google.com>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240305060848.2478806-1-usama.anjum@collabora.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240305060848.2478806-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 23:08, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> 
> Reviewed-by: T.J. Mercier <tjmercier@google.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v4:
> - close fds correctly with code changes added in v3
> 
> Chanages since v3:
> - abort test-case instead of exiting if heap/mem allocation fails
> - Correct test_alloc_zeroed() test case in case of failure
> 
> Changes since v2:
> - Minor improvements in test_alloc_zeroed() results
> 
> Changes since v1:
> - Update some more error handling code

t would be nice to improve the error messages in addition to
changing them over to TAP format. Please see below:

> ---
>   .../selftests/dmabuf-heaps/dmabuf-heap.c      | 246 +++++++-----------
>   1 file changed, 101 insertions(+), 145 deletions(-)
> 
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> index 890a8236a8ba7..e7bd03e0af2ea 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> @@ -15,6 +15,7 @@
>   #include <linux/dma-buf.h>
>   #include <linux/dma-heap.h>
>   #include <drm/drm.h>
> +#include "../kselftest.h"
>   
>   #define DEVPATH "/dev/dma_heap"
>   
> @@ -90,14 +91,13 @@ static int dmabuf_heap_open(char *name)
>   	char buf[256];
>   
>   	ret = snprintf(buf, 256, "%s/%s", DEVPATH, name);
> -	if (ret < 0) {
> -		printf("snprintf failed!\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		ksft_exit_fail_msg("snprintf failed!\n");

Why not include the return value in the message?

>   
>   	fd = open(buf, O_RDWR);
>   	if (fd < 0)
> -		printf("open %s failed!\n", buf);
> +		ksft_exit_fail_msg("open %s failed: %s\n", buf, strerror(errno));
> +
>   	return fd;
>   }
>   
> @@ -140,7 +140,7 @@ static int dmabuf_sync(int fd, int start_stop)
>   
>   #define ONE_MEG (1024 * 1024)
>   
> -static int test_alloc_and_import(char *heap_name)
> +static void test_alloc_and_import(char *heap_name)
>   {
>   	int heap_fd = -1, dmabuf_fd = -1, importer_fd = -1;
>   	uint32_t handle = 0;
> @@ -148,27 +148,19 @@ static int test_alloc_and_import(char *heap_name)
>   	int ret;
>   
>   	heap_fd = dmabuf_heap_open(heap_name);
> -	if (heap_fd < 0)
> -		return -1;
>   
> -	printf("  Testing allocation and importing:  ");
> +	ksft_print_msg("Testing allocation and importing:\n");
>   	ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
>   	if (ret) {
> -		printf("FAIL (Allocation Failed!)\n");
> -		ret = -1;
> -		goto out;
> +		ksft_test_result_fail("FAIL (Allocation Failed!)\n");

Same here/

> +		return;
>   	}
> +
>   	/* mmap and write a simple pattern */
> -	p = mmap(NULL,
> -		 ONE_MEG,
> -		 PROT_READ | PROT_WRITE,
> -		 MAP_SHARED,
> -		 dmabuf_fd,
> -		 0);
> +	p = mmap(NULL, ONE_MEG, PROT_READ | PROT_WRITE, MAP_SHARED, dmabuf_fd, 0);
>   	if (p == MAP_FAILED) {
> -		printf("FAIL (mmap() failed)\n");
> -		ret = -1;
> -		goto out;
> +		ksft_test_result_fail("FAIL (mmap() failed)\n");

Same here and the rest of the changes in this patch.

thanks,
-- Shuah

