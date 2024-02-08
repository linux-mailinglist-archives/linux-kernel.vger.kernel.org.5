Return-Path: <linux-kernel+bounces-57468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBE584D973
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14BCE286C86
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C80367A13;
	Thu,  8 Feb 2024 05:00:21 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8689667A07
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 05:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707368420; cv=none; b=KYnakbfnvKzprpMjZCUgrXPjq4vK0p07a0ruzIhPlWdcmugSf+4q6sRO5u3bcxIh0TMWU/ZORzzbAzTSNL1ZFwxo7DSQ+YHR6bJUlq2MmaoWFjBCz6vfc9AxXbNnC6WA1rYNGXW9bx59pL93qL5W8TnDiiIBhLKGMqsIUQFXVq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707368420; c=relaxed/simple;
	bh=drzypQ4OMiu5rtVHsBnVb3sEPK383IRp3OEu0GSDqEA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mse4AiGu6NdfjuO4rTELjp8zycQixaTpz3boXUedWlRMGIZRNK7MYqd3K8/cxiTEq6f/AUvhwl/4Ky6UWgR+liGBd19V6q5h3EXOElZAhpLP9oZMspswcPX/RnuwXE8hVKHJrU4+qcCTLZ+C+u5UP0Kh5zZaZEH4z6dq6ljB8BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TVl9d1Pylz1Q8k8;
	Thu,  8 Feb 2024 12:58:13 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id C301F140429;
	Thu,  8 Feb 2024 13:00:10 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 13:00:09 +0800
Subject: Re: [PATCH] KVM: selftests: Fix GUEST_PRINTF() format warnings in ARM
 code
To: Sean Christopherson <seanjc@google.com>
CC: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240202234603.366925-1-seanjc@google.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <3188e6f1-f150-f7d0-6c2b-5b7608b0b012@huawei.com>
Date: Thu, 8 Feb 2024 13:00:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240202234603.366925-1-seanjc@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)

On 2024/2/3 7:46, Sean Christopherson wrote:
> Fix a pile of -Wformat warnings in the KVM ARM selftests code, almost all
> of which are benign "long" versus "long long" issues (selftests are 64-bit
> only, and the guest printf code treats "ll" the same as "l").  The code
> itself isn't problematic, but the warnings make it impossible to build ARM
> selftests with -Werror, which does detect real issues from time to time.
> 
> Opportunistically have GUEST_ASSERT_BITMAP_REG() interpret set_expected,
> which is a bool, as an unsigned decimal value, i.e. have it print '0' or
> '1' instead of '0x0' or '0x1'.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Tested-by: Zenghui Yu <yuzenghui@huawei.com>

> diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> index 274b8465b42a..d5e8f365aa01 100644
> --- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
> +++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> @@ -158,9 +158,9 @@ static void guest_validate_irq(unsigned int intid,
>   
>   	/* Basic 'timer condition met' check */
>   	__GUEST_ASSERT(xcnt >= cval,
> -		       "xcnt = 0x%llx, cval = 0x%llx, xcnt_diff_us = 0x%llx",
> +		       "xcnt = 0x%lx, cval = 0x%lx, xcnt_diff_us = 0x%lx",
>   		       xcnt, cval, xcnt_diff_us);
> -	__GUEST_ASSERT(xctl & CTL_ISTATUS, "xcnt = 0x%llx", xcnt);
> +	__GUEST_ASSERT(xctl & CTL_ISTATUS, "xcnt = 0x%lx", xcnt);

Unrelated to your patch, but it looks to me that we actually want to
print 'xctl' instead of 'xcnt' in the second __GUEST_ASSERT().

Thanks,
Zenghui

