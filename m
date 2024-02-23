Return-Path: <linux-kernel+bounces-79228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70673861F41
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B874286AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6AD14CABD;
	Fri, 23 Feb 2024 21:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D4d2EVXs"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FEF146E81
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 21:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724928; cv=none; b=fsSj9H5F0V9rnOC4g5SxQZGVqtivUljYrchwIBgQKBcswhrHvBt9Oa77xgiLqf3EvKLjndvX2Gb/Y58BJ1zj+RzoS/5XsHQEIceFduoivAaQq1wXF0oR/dGDBRCcVdzk4bnqio4Ncsc0b3+N8pCz/jcq+/0jS0XXQv1VuIf4Q+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724928; c=relaxed/simple;
	bh=+R0lx7cXpWz3DPUbwrtZFVFbpiqFznCCdo8QxAaxkcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TEWScYay44Ac3gd7ScBrJhGF863fActxv1IZYTxUsOPDEUDL3wEGfuBGijrCKYj2tAUtINeqJXhxCDUjTjP4/+Jj19nVDBiQGrk0o6P5vvc0yoyBBOJ/iTRWr3jXhvtNJ16Nuoh9eL1upkpsgz90W9sAUSW1hbXvZSCj2nBhScQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D4d2EVXs; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso23603839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708724926; x=1709329726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lgO5+cJdjb0UoRYq8Dm6ib2PgTItfB8pOU+uEe02TMk=;
        b=D4d2EVXsRpuAGnFgu2mdaPbTZ8YlvGxDW3c54oTzujqRnkz/Wob/CDKPwzApv0jzV5
         m7xrKLeqaXa+Wefs9FuByFYh1lh1NsfaO94/dNq9TCBAg+6CSH3n1MiuXhNfoJJJ7wyO
         InG+62Wnj+/N+zaeBxqKf+wuw0Wt61Yj8whpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708724926; x=1709329726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgO5+cJdjb0UoRYq8Dm6ib2PgTItfB8pOU+uEe02TMk=;
        b=IRCSHae7bRmy3xaphsshnhq2hIoXGWLGf4Y/8HSVQ81j8D9/MXU+JWIYAOCSVIeHNJ
         7EpGqxvONvJo2ZYeYromXSS7Gd/+Rp00/DcC7IJxDSg91eg8Hh7PiZEUa7RvEvDWUZoc
         6TlBlM2+NsLqFrUyBH4LdwX8oqWSmphpaTJAtbZzj6gcRKuxL9h0a43GUDCTsy80OFrn
         lA+gAfw0f6yYGm0/E3nk9PpjQN8RNA6UodGbb9HwSqeNLroUmIXUhLev365kMPx42MOQ
         sJxyC4K7b3zMfoxPDzriRj13WX2vs45W2EIG6a7eKT/KHYhPVVtfHoqlU3P5p6XoQnwW
         ppHw==
X-Forwarded-Encrypted: i=1; AJvYcCXAF9vJI5fGyKfK/OB3o/KabFJ3MqmIKdDvnIBx41WOhE6nnUadK3KHqBVcJFJk9VH+sanOPspO4f32xc+530nZZ7JkjkFx3y6lKlDW
X-Gm-Message-State: AOJu0YwtJUQ5/uL1QQLU1y1YfWDxH2mOAZ3zFLN8SYMhDXKxLXjKpRGS
	WQ/Pxzd+yAqKHW6fUL0xiqD0qNNnvcEkwHS2wP2vm8WThdsVg4eULSOAGqRlqpQ=
X-Google-Smtp-Source: AGHT+IHn1LVW7rSzOBvud0IxNkrh5t1iJwM5tNw5xrwCNXE5KoZyAbguXmzSWX/cJz63abGxQJllTw==
X-Received: by 2002:a05:6e02:1c43:b0:365:25a2:1896 with SMTP id d3-20020a056e021c4300b0036525a21896mr1323164ilg.0.1708724926076;
        Fri, 23 Feb 2024 13:48:46 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id z7-20020a92cec7000000b00364b66eb5e3sm4840053ilq.24.2024.02.23.13.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 13:48:45 -0800 (PST)
Message-ID: <bb4c94f5-082d-48d8-9d4c-099375603f9f@linuxfoundation.org>
Date: Fri, 23 Feb 2024 14:48:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kselftest: Add basic test for probing the rust sample
 modules
Content-Language: en-US
To: Laura Nao <laura.nao@collabora.com>, ojeda@kernel.org,
 alex.gaynor@gmail.com, wedsonaf@gmail.com, shuah@kernel.org
Cc: usama.anjum@collabora.com, a.hindborg@samsung.com, aliceryhl@google.com,
 benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
 kernel@valentinobst.de, Sergio Gonzalez Collado <sergio.collado@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240222162913.498197-1-laura.nao@collabora.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240222162913.498197-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/22/24 09:29, Laura Nao wrote:
> Add new basic kselftest that checks if the available rust sample modules
> can be added and removed correctly.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> Reviewed-by: Sergio Gonzalez Collado <sergio.collado@gmail.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes in v3:
> - Removed useless KSFT_PASS, KSFT_FAIL, KSFT_SKIP constants
> - Used ktap_finished to print the results summary and handle the return code
> Changes in v2:
> - Added missing SPDX line
> - Edited test_probe_samples.sh script to use the common KTAP helpers file
> ---
>   MAINTAINERS                                   |  1 +
>   tools/testing/selftests/Makefile              |  1 +
>   tools/testing/selftests/rust/Makefile         |  4 +++
>   .../selftests/rust/test_probe_samples.sh      | 34 +++++++++++++++++++
>   4 files changed, 40 insertions(+)
>   create mode 100644 tools/testing/selftests/rust/Makefile
>   create mode 100755 tools/testing/selftests/rust/test_probe_samples.sh
> 

Looks good to me. Don't you need a config file for this test?
Refer to config files for existing tests as a reference.

thanks,
-- Shuah

