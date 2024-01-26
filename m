Return-Path: <linux-kernel+bounces-39996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A9083D843
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9B12A5194
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D7A13AEC;
	Fri, 26 Jan 2024 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SL11JcaK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280E612B9B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706264725; cv=none; b=qFCaplvrvkyQqu54z3W2UPss9kqPBz/uGT01VBdpwjKNJHk+/DipLzoWHvZgjxEGQD+3T7EToManwSFR77KR4yAaFKjTvPZqFTmlE+pOAgOmxi/a5TzwdB8le5q+j/8u3Spy0PYCZ5kcgLlGeQkroB1AVelhXSc38llPSgd+5yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706264725; c=relaxed/simple;
	bh=S70PRABftOqa8emToRq/SOEAjS3k4Nc2hS3M0xK6WDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gq2GFG/jzl2oOMEJVHcSGZtqsJ7/5GSsbxBve0xFOu74UYHld0jG6gZdXEryzoawwtpWhLH21+EhCP5Z/d6HrpxHckpwILTmRuRORV81u6x2+wjVbih1jFPuZnnYy/b5wCPr8gIrrMqr+GlydJAWxgVvIfdC8Lo27mj/cAYSn/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SL11JcaK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706264723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5kQbVh0hcRgV8UMq6Vb5QM4EaBqOcOHGfTaVO2KwzEY=;
	b=SL11JcaKI12fOXuI6xNz1451GqTi98yeiPQGzHuW190lRICXQZplsGZHBODI88PNwjH+I6
	7zqScm8G31gWtPhxaLGUaZHotAWNdEOYp7/XHWQu3/D7Vr6RsSMsnFo0l+ter+NbPROQL2
	860LByL5WjFXtB6Whgje4DsvDalvkWo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-n6kDWOWYOSOS_ljS5n98DQ-1; Fri, 26 Jan 2024 05:25:20 -0500
X-MC-Unique: n6kDWOWYOSOS_ljS5n98DQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-68694f9e037so4071676d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 02:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706264719; x=1706869519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kQbVh0hcRgV8UMq6Vb5QM4EaBqOcOHGfTaVO2KwzEY=;
        b=rKnhvGA8JBBGo+jPvpr6ogVmyP3rD2fOtztADSVcnP/gJ+CyBNMl6fkft0ymb8164w
         wXD3lOrQ9+FPT6st24tpOsw7YoRyNUIstQaBNgZqzQ6svT2hRt237UomxTKmTt9Mlq1i
         XMxgF73KGfpgn5O2RFu6fIjfIH6KlGTgms2yLlxoAzRKbRJ1BfinqALd8V3SpYXFOM89
         O1A8lQjuAj8P89CobNy80SGKlMUQNxIZIjOCG0moISIxdI8m+QWIO1dakJsEzocBYHKe
         ZIZVpjdnddYaSIT9l5N+Dwp8Yh4ODzFuquIAI8u7R61Y4U41/spuTsiuQDq0nxetJ+uw
         PFbQ==
X-Gm-Message-State: AOJu0Yyk7mctGxbliP//D01/RS791/cm3wTaBVGA0gZiySG5nddMGzb/
	Dz3lJvGSA8Lvkg5TtRj9BTAXvESyMac4I++2u89L3L7PhZIoRSRoR0mbKWLWPIqghI1HZhACWy0
	EMWoFGaiTeelVElQsb6Sw9xtOKVkZhfJw9YpoZklXPPeJvlCaJ5XfLQtp6WN1XQ==
X-Received: by 2002:ad4:5d6e:0:b0:686:acaa:a4b6 with SMTP id fn14-20020ad45d6e000000b00686acaaa4b6mr1400871qvb.79.1706264719641;
        Fri, 26 Jan 2024 02:25:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtHbF0GQDnaATq85JoMxKpDaeP42Xl2uBvtV9mUCapJ2bmX+Zt1/9FX/b/+a1DH1cknGoOpQ==
X-Received: by 2002:ad4:5d6e:0:b0:686:acaa:a4b6 with SMTP id fn14-20020ad45d6e000000b00686acaaa4b6mr1400856qvb.79.1706264719347;
        Fri, 26 Jan 2024 02:25:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id h4-20020a0cd804000000b006869dae6edbsm398728qvj.77.2024.01.26.02.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 02:25:18 -0800 (PST)
Message-ID: <51ca8edc-81e6-4c6d-9c72-80fe59919868@redhat.com>
Date: Fri, 26 Jan 2024 11:25:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] KVM: selftests: aarch64: Introduce
 pmu_event_filter_test
Content-Language: en-US
To: Shaoqin Huang <shahuang@redhat.com>, Oliver Upton
 <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>,
 kvmarm@lists.linux.dev
Cc: James Morse <james.morse@arm.com>, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>
References: <20240116060129.55473-1-shahuang@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240116060129.55473-1-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shaoqin,

On 1/16/24 07:01, Shaoqin Huang wrote:
> The test is inspired by the pmu_event_filter_test which implemented by x86. On
> the arm64 platform, there is the same ability to set the pmu_event_filter
> through the KVM_ARM_VCPU_PMU_V3_FILTER attribute. So add the test for arm64.
> 
> The series first move some pmu common code from vpmu_counter_access to
> lib/aarch64/vpmu.c and include/aarch64/vpmu.h, which can be used by
> pmu_event_filter_test. Then fix a bug related to the [enable|disable]_counter,
> and at last, implement the test itself.
which branch does it apply on? I fail to apply on top on main.

Or can you provide a branch?

Eric
> 
> Changelog:
> ----------
> v2->v3:
>   - Check the pmceid in guest code instead of pmu event count since different
>   hardware may have different event count result, check pmceid makes it stable
>   on different platform.                        [Eric]
>   - Some typo fixed and commit message improved.
> 
> v1->v2:
>   - Improve the commit message.                 [Eric]
>   - Fix the bug in [enable|disable]_counter.    [Raghavendra & Marc]
>   - Add the check if kvm has attr KVM_ARM_VCPU_PMU_V3_FILTER.
>   - Add if host pmu support the test event throught pmceid0.
>   - Split the test_invalid_filter() to another patch. [Eric]
> 
> v1: https://lore.kernel.org/all/20231123063750.2176250-1-shahuang@redhat.com/
> v2: https://lore.kernel.org/all/20231129072712.2667337-1-shahuang@redhat.com/
> 
> Shaoqin Huang (5):
>   KVM: selftests: aarch64: Make the [create|destroy]_vpmu_vm() public
>   KVM: selftests: aarch64: Move pmu helper functions into vpmu.h
>   KVM: selftests: aarch64: Fix the buggy [enable|disable]_counter
>   KVM: selftests: aarch64: Introduce pmu_event_filter_test
>   KVM: selftests: aarch64: Add invalid filter test in
>     pmu_event_filter_test
> 
>  tools/testing/selftests/kvm/Makefile          |   2 +
>  .../kvm/aarch64/pmu_event_filter_test.c       | 255 ++++++++++++++++++
>  .../kvm/aarch64/vpmu_counter_access.c         | 218 ++-------------
>  .../selftests/kvm/include/aarch64/vpmu.h      | 135 ++++++++++
>  .../testing/selftests/kvm/lib/aarch64/vpmu.c  |  74 +++++
>  5 files changed, 490 insertions(+), 194 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
>  create mode 100644 tools/testing/selftests/kvm/include/aarch64/vpmu.h
>  create mode 100644 tools/testing/selftests/kvm/lib/aarch64/vpmu.c
> 


