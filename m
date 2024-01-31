Return-Path: <linux-kernel+bounces-45701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB70484345E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC3E1C24512
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4620712B86;
	Wed, 31 Jan 2024 03:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAH3i7xR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096A91079B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706670701; cv=none; b=EFWtQ2jXfWuonN9c/jNEgLtAWunIDCyyTj5Yg9Cn+7k70YPZWKdyueogDgBIgFRUWx/VSfPayLap7YMun8jyrU2/yPofbgOmGU2GeEXf5O2rmDxvmiL2veTnCpN7cSq5G8a5/dewlw1P1MwTRM5eFLaNTx/Tek5On/bsYVC4jPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706670701; c=relaxed/simple;
	bh=8A1sNTcqh/vi3qf/rn7lmh0Ujtt2fMYFqdqHx9tLGhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMMNU/srQLYE4fqCjFrBZ+Jgm8sY1EfNuDcE7kfTzq2d8qBYIpf/JPQ/P8/Jiq0/HyvvMjcj9vE6tJhSV80qW4Zk2Xrh+zVSFGfVbRhx4xosKFtOjQWQasZdWFHos+l7hTZZuEp1XcobCd1pbl7hMmxftBmu35yRJTvsQAr/0T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAH3i7xR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706670699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iu3CJL4LbQS98hB4MGDC78q9pGdj3UV5DPUVK7DzfMo=;
	b=UAH3i7xRVFR/0xSVCuEEGyNeQHSIdyEbyl29fLGPnnqrpx8bdayf4jTRhmvNntNGjHDygs
	Aqx1g0g2DxZ/PJjo8g5kxnFCIlcgmrWdetUASY83bMKJZByAb8wkZnXPuQouLGAHz87Tg8
	YPnjk3KU+XPTrutGlrQpoNfyIyK8SyU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-BQS8Cf2bMqaAtzTZ2a21nA-1; Tue, 30 Jan 2024 22:11:36 -0500
X-MC-Unique: BQS8Cf2bMqaAtzTZ2a21nA-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3be75cab163so605007b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706670695; x=1707275495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iu3CJL4LbQS98hB4MGDC78q9pGdj3UV5DPUVK7DzfMo=;
        b=XJZlkw5C0B3jI5MqSBMRb7jtwaQVp92cWyJFAKXz14dWzPrzbLXjxOBd8rt+Sg3qbL
         bKijNJ5Fq1eZlG0VgOvtqcTpkt9EMa0hdJeYsKmuJWKlfKfRmh7sayvmC7PlcpQzLGZe
         crnx82YYVgio1yD6LyBrkPOrusTyKCRxdlFJgANNUx1Wtwoh+JM1Gdu7TpgIY44Rp7BW
         ZpI8ofJzPdjUMN9paj5vhFnj9QR0KSKhw3ZxVS4pxaIqu5GktalmD38gqlDe35tOePFJ
         Knrp9GrKsrVgWrNTDS2v8EWHNhCuf5V077tSqQ5Kbw4Vi5aJGmH19XQWCe/oi8wyxT7Z
         jA+Q==
X-Gm-Message-State: AOJu0Yxv4JkFOx+QDqTH627wlA2zXt8dF9PGb4sVfcYGEr5Z8bqhDoGY
	wCmuXiiummEzdVANMnwgN6ZJxPuMgQdYd8SqgtdfMcDOVTPu++FPHBeASyOvRMmSX3kRKc+Os1d
	NzTs308XwXWHjNPpf1V1Jm+OYbR2OBiDpPxrD2UrFPkfoNtcGvMXj1wI+fq3vJA==
X-Received: by 2002:a05:6808:329a:b0:3be:6bed:70af with SMTP id cg26-20020a056808329a00b003be6bed70afmr574526oib.3.1706670695142;
        Tue, 30 Jan 2024 19:11:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmfRksgT7QnfG2CN0xzUAVB0zgkTIWmjGTT9JZuTu7vPmTr2vpPAGzf5rzH88B+9ZKhzkzMg==
X-Received: by 2002:a05:6808:329a:b0:3be:6bed:70af with SMTP id cg26-20020a056808329a00b003be6bed70afmr574507oib.3.1706670694846;
        Tue, 30 Jan 2024 19:11:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWlTw1dye8bxzwmPtvq8UxMcKWb53stpiyLPATNR6iaQUszWm9J9ynFpckV3yNoZa1PI8CIknSnuWJsBwaO02BqdGhqrfursNiEOkio6a2UGvFqsVKpuU/H5CSPkl+Aa2kxjGVkGMiZrkfwq5bg8R52435X0a6KA1/AbSuJhoyQpkAD+OlfOvHsMt3eGTuITT3pZ5hRXf59RibQDhxuEv0FmCJIGONPRfRNZ93L0Oa8zSOPIpMBk7+pzBn8w2th2H5M99+zW5THY8QAvX/oZjnk9j0cijhnLF+LkcajdzOpCxzEneepW3w+i56pxirHQMbskARfpvCEAFw5kgClUG9W352XhNnU0gEOP6vKEt04bMNk8V7vkIhMeiBB+5sV09Y7rU8hpuw0ZumI+0dFILHnPHNahfEQXvzi9sFHpw==
Received: from [10.72.116.50] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p26-20020a62ab1a000000b006ddb85a61cfsm8564500pff.162.2024.01.30.19.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 19:11:34 -0800 (PST)
Message-ID: <d2d09269-30fa-461d-9461-16a1ffbde6b6@redhat.com>
Date: Wed, 31 Jan 2024 11:11:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] KVM: selftests: aarch64: Introduce
 pmu_event_filter_test
To: Eric Auger <eauger@redhat.com>, Oliver Upton <oliver.upton@linux.dev>,
 Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev
Cc: James Morse <james.morse@arm.com>, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>
References: <20240116060129.55473-1-shahuang@redhat.com>
 <51ca8edc-81e6-4c6d-9c72-80fe59919868@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <51ca8edc-81e6-4c6d-9c72-80fe59919868@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Eric,

On 1/26/24 18:25, Eric Auger wrote:
> Hi Shaoqin,
> 
> On 1/16/24 07:01, Shaoqin Huang wrote:
>> The test is inspired by the pmu_event_filter_test which implemented by x86. On
>> the arm64 platform, there is the same ability to set the pmu_event_filter
>> through the KVM_ARM_VCPU_PMU_V3_FILTER attribute. So add the test for arm64.
>>
>> The series first move some pmu common code from vpmu_counter_access to
>> lib/aarch64/vpmu.c and include/aarch64/vpmu.h, which can be used by
>> pmu_event_filter_test. Then fix a bug related to the [enable|disable]_counter,
>> and at last, implement the test itself.
> which branch does it apply on? I fail to apply on top on main.
> 
> Or can you provide a branch?

This was based on v6.7.

> 
> Eric
>>
>> Changelog:
>> ----------
>> v2->v3:
>>    - Check the pmceid in guest code instead of pmu event count since different
>>    hardware may have different event count result, check pmceid makes it stable
>>    on different platform.                        [Eric]
>>    - Some typo fixed and commit message improved.
>>
>> v1->v2:
>>    - Improve the commit message.                 [Eric]
>>    - Fix the bug in [enable|disable]_counter.    [Raghavendra & Marc]
>>    - Add the check if kvm has attr KVM_ARM_VCPU_PMU_V3_FILTER.
>>    - Add if host pmu support the test event throught pmceid0.
>>    - Split the test_invalid_filter() to another patch. [Eric]
>>
>> v1: https://lore.kernel.org/all/20231123063750.2176250-1-shahuang@redhat.com/
>> v2: https://lore.kernel.org/all/20231129072712.2667337-1-shahuang@redhat.com/
>>
>> Shaoqin Huang (5):
>>    KVM: selftests: aarch64: Make the [create|destroy]_vpmu_vm() public
>>    KVM: selftests: aarch64: Move pmu helper functions into vpmu.h
>>    KVM: selftests: aarch64: Fix the buggy [enable|disable]_counter
>>    KVM: selftests: aarch64: Introduce pmu_event_filter_test
>>    KVM: selftests: aarch64: Add invalid filter test in
>>      pmu_event_filter_test
>>
>>   tools/testing/selftests/kvm/Makefile          |   2 +
>>   .../kvm/aarch64/pmu_event_filter_test.c       | 255 ++++++++++++++++++
>>   .../kvm/aarch64/vpmu_counter_access.c         | 218 ++-------------
>>   .../selftests/kvm/include/aarch64/vpmu.h      | 135 ++++++++++
>>   .../testing/selftests/kvm/lib/aarch64/vpmu.c  |  74 +++++
>>   5 files changed, 490 insertions(+), 194 deletions(-)
>>   create mode 100644 tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
>>   create mode 100644 tools/testing/selftests/kvm/include/aarch64/vpmu.h
>>   create mode 100644 tools/testing/selftests/kvm/lib/aarch64/vpmu.c
>>
> 

-- 
Shaoqin


