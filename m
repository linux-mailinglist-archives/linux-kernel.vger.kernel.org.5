Return-Path: <linux-kernel+bounces-131847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C47898C7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE8D287D14
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFFE12AACB;
	Thu,  4 Apr 2024 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GZV9wOzS"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93851F94D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249274; cv=none; b=c7LbubcQb4SCbk3OGrovaV+Lx9Pp8r7JHy7x+VzMnWtISgxUgsJEtL47bJHsjB2xBQko4z6entD8pqPuaKAfie5HciNohDoHp13HatqwTzsN39/GRsKhn7CjU20BfYjazYyREusWVhGa6hRLGgQK+DrGJSuBQzYFYOREOeTNEc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249274; c=relaxed/simple;
	bh=oE44cNV1MThrllMvNXfgaeoOM8ecNWgMHI1ayvB7AIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcbF5F1je3Hjy5oQvfUnWoVhPvR7nezmPC0/Y1DxwnJVI16YQI4YAhcfbXbF808ByR9WQe7RWGZ8qwzn06+LPt1Uu1XK4BdgqzsQVVR6pG8O7cMvOydG59yUfLWWOaiSMFdSkREOtBNHj5LsZCupdizqSz67Jw1VfkL0aqhbx2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GZV9wOzS; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso12706739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 09:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712249272; x=1712854072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xviHTEgNbkmiNx5QIWC+NSujVLCaJfHhmEd82wbOO8A=;
        b=GZV9wOzSbrK+lIxE9+0XYp5OQbpLqiksc9eagaFpPsvxAl/pURz3v8lQWN2+zNqcIt
         MPgM54pvBGmCnD8tpPd060pmHfDZ5pF7euMHQUomR7+8O6mSNfqLHqxi3oMNNK1OVu85
         QkwM+DW0Y+77hikzu+mb+UrIz+8xXnBGYPiAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712249272; x=1712854072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xviHTEgNbkmiNx5QIWC+NSujVLCaJfHhmEd82wbOO8A=;
        b=AlNUvn1EbTApmB2Yf7+sz5+M/HqWcGsD0u5Gb4VsdVhUo9QPJqlQl54ENN5wDHYSl5
         lp3TH68ewK9M8iNNJmAl0dT1HqusA1IVqAdGoHHxMBk1KYPwhnt50rsXruJupiByCYb5
         ST1JSqusDkZAJ7RqFNtW2D88wp5oiYo2COZ8yaTnKh1yHvguoCHWX5xk2RqZNvabsS7x
         X102i+VaC9q1d5L6hM5ffij2TosrNKYlcjzmauOcvZjkLAI5DKUbzWZkDT0WieRNpfTG
         /MHNXzNiZIvtAcAQRnlpbR0meY53kxDna/liCJgOsfpYTG3yMh0LFUaHgUb2EFP9jjQN
         rqhw==
X-Gm-Message-State: AOJu0Yy0BCjWOjp2haOEsN8pBh5ms1jWSChek3EVYYrOi0v/MMHRi8TP
	6yZE1nPZTUYBFAbsgPnwOYUl81jDZB5Uhe+bm9U16BXOvIMw9kqk2J56Q2YtjoU=
X-Google-Smtp-Source: AGHT+IG82WT6J6FZa3+sICLw5p3ht7qQ0oS7pZpQFgmVnGfC82Kopwsq80qH685+J2mAyvHrx6eaxw==
X-Received: by 2002:a92:cf04:0:b0:368:b52b:b449 with SMTP id c4-20020a92cf04000000b00368b52bb449mr3363739ilo.0.1712249271906;
        Thu, 04 Apr 2024 09:47:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id r22-20020a056638131600b0047ed8c3e578sm4154125jad.134.2024.04.04.09.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 09:47:51 -0700 (PDT)
Message-ID: <8fd67aab-21ed-4aec-bea4-42171b6d0523@linuxfoundation.org>
Date: Thu, 4 Apr 2024 10:47:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/harness: Prevent infinite loop due to Assert
 in FIXTURE_TEARDOWN
To: Shengyu Li <shengyu.li.evgeny@gmail.com>, shuah@kernel.org,
 Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
 Jason Gunthorpe <jgg@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 luto@amacapital.net, wad@chromium.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240324214419.12577-1-shengyu.li.evgeny@gmail.com>
 <20240326211315.12201-1-shengyu.li.evgeny@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240326211315.12201-1-shengyu.li.evgeny@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/24 15:13, Shengyu Li wrote:
> This patch addresses an issue in the selftests/harness where an
> assertion within FIXTURE_TEARDOWN could trigger an infinite loop.
> The problem arises because the teardown procedure is meant to
> execute once, but the presence of failing assertions (ASSERT_EQ(0, 1))
> leads to repeated attempts to execute teardown due to
> the long jump mechanism used by the harness for handling assertions.
> 
> To resolve this, the patch ensures that the teardown process
> runs only once, regardless of assertion outcomes, preventing
> the infinite loop and allowing tests to fail.
> 
> A simple test demo(test.c):
>   #include "kselftest_harness.h"
> 
> FIXTURE(f)
> {
> 	int fd;
> };
> 
> FIXTURE_SETUP(f)
> {
> 	self->fd = 0;
> }
> 
> FIXTURE_TEARDOWN(f)
> {
> 	TH_LOG("TEARDOWN");
> 	ASSERT_EQ(0, 1);
> 	self->fd = -1;
> }
> 
> TEST_F(f, open_close)
> {
> 	ASSERT_NE(self->fd, 1);
> }
> 
> TEST_HARNESS_MAIN
> 
> will always output the following output due to a dead loop until timeout:
>   # test.c:15:open_close:TEARDOWN
>   # test.c:16:open_close:Expected 0 (0) == 1 (1)
>   # test.c:15:open_close:TEARDOWN
>   # test.c:16:open_close:Expected 0 (0) == 1 (1)
>   ...
> 
> But here's what we should and expect to get:
>   TAP version 13
>   1..1
>   # Starting 1 tests from 2 test cases.
>   #  RUN           f.open_close ...
>   # test.c:15:open_close:TEARDOWN
>   # test.c:16:open_close:Expected 0 (0) == 1 (1)
>   # open_close: Test terminated by assertion
>   #          FAIL  f.open_close
>   not ok 1 f.open_close
>   # FAILED: 0 / 1 tests passed.
>   # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
> 
> also this is related to the issue mentioned in this patch
> https://patchwork.kernel.org/project/linux-kselftest/patch/e2ba3f8c-80e6-477d-9cea-1c9af820e0ed@alu.unizg.hr/
> 

Adding people who participated in the above thread discussion.
Please try this patch out to see if this fixes the problem
with iommu test.

> 
> 
> Signed-off-by: Shengyu Li <shengyu.li.evgeny@gmail.com>

Than you for finding and fixing this. Applied now to linux-kselftes fixes
branch for the next rc.

thanks,
-- Shuah




