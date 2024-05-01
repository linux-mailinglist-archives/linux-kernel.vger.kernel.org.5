Return-Path: <linux-kernel+bounces-165176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 762938B8914
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF4F285A9B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8038B56B63;
	Wed,  1 May 2024 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGRzVFwM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A96448CE0
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714562104; cv=none; b=F9njKiu4CKIuXeexjn/v0a5YxAN28Eoyrtfe7jbrasY7aORwj3ETyaWgVGb06PTwM/rwdv/+bR1T9F21KMx8KFWSwl8LKhuQ+fWbErVW6QN36qNCqy5zLYooeUo0Jwx0gyOXroUlNhTC24jmKPxLizioqM+37ccDuOw6mJq7Twk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714562104; c=relaxed/simple;
	bh=FQodAUfD1JkLmt1uTy5qfN1UspuJsm4imcTHYIOZ1zM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nxnwI9g6k1cfIiwCQmKJKSk7SKP3oLw0A1rPtUOHp8+WrCokgBTruJ14latkaClStlf1pRYWpz2cCFL9vCdEaPyNmQm0dez+qsdo+/3iVGUvqlZG7X03JjPeUE26MYNJFBn+erBRvD2Bx2rIfoXjtf6rSSpxf60RVmPNZ8Pytc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QGRzVFwM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714562102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4zwGvBc/1zudle3Fu3mxvomgwnAp7EzJRWK4hmMCrY=;
	b=QGRzVFwM4PeI30rFlRkRFuZq6UB3Z4zYRNIcS2thKyTFmGdbjiEqDPFrroi6KN2bo7V+3D
	N4xNmBi8cBFgecv6LEnhRhKyLupXOaArDxIuQMREqwsMCtXhZMOdDhMxh/6t8YxRDesXQc
	RZlEsMJbCgdu8r7mfF+LQWsW8vv9uFw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-jTQqDcBwNjmxAWViXJ2d3A-1; Wed, 01 May 2024 07:15:01 -0400
X-MC-Unique: jTQqDcBwNjmxAWViXJ2d3A-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2adb84b10c1so654468a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 04:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714562100; x=1715166900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m4zwGvBc/1zudle3Fu3mxvomgwnAp7EzJRWK4hmMCrY=;
        b=MsudZ7bJCeFRVQTZhq09vZXqKP0531mwBtadMb3kINMawWvgtQsjj/J7oleq+sLbbL
         SZiG6DRFNO2uQ3theBG/DIcx/0k0GR7w8HghIAsW8QCiu+PaqpiWsAMkFmDcAxmUDP/a
         cQUhjkN3f6Dy40r3CCWMnBtw30anoHpxmdH6SJe+O0Knr68Dh1MqDuC8xBRVPcTE9950
         Hl2OrP6xaIz45qTobBgx26qMkSWB3XjnJchBVrAVuDCR8jqsPzO5XmyWeH6yzXCQyXFA
         G8I/DhAuwV3N5zd63mwoQZ4q8a+uaDxFb6FaKiVWvbPD80nrPoW7aslDsxhW75bNwglH
         rGcw==
X-Forwarded-Encrypted: i=1; AJvYcCXJCkghmpl3+bjxRPQ81TYqonOgDA5nXKFfmbR6HfTm4OTmYIo5/FI0+ZEE4w4/MZ/2FPi5fGtRcIZQaO6p7b3f6+hlWgrrXgRc5W5E
X-Gm-Message-State: AOJu0Yx1VqcbKNDXcUJ7bYQHbr4gWVO0R0hQi2iV2C3j9L+nHJnqwEmr
	zcY98a7tBeSpLG43vHzyWJoFoJ3rScr3taUZD0skSqp/WRea1FLOFRRpZuST8kptho4HHmLGKYu
	RQNWLa08cuUkpGSZS9mRQQWiel9SuRk3B5EwYRlC3XCDw1J1IOdwHesJ/w1WwZw==
X-Received: by 2002:a17:90b:3749:b0:2b3:6898:d025 with SMTP id ne9-20020a17090b374900b002b36898d025mr189457pjb.9.1714562100014;
        Wed, 01 May 2024 04:15:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgkwe4UKKc3WldVwMV2boi6I+r208XEIsyNzplTWK4MFoORCuavWHQA0/i+SiniS3enNZ28Q==
X-Received: by 2002:a17:90b:3749:b0:2b3:6898:d025 with SMTP id ne9-20020a17090b374900b002b36898d025mr189419pjb.9.1714562099556;
        Wed, 01 May 2024 04:14:59 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090a050900b002a55198259fsm3245338pjh.0.2024.05.01.04.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 04:14:59 -0700 (PDT)
Message-ID: <27e48da5-e1d0-4e4b-978e-954f1766c350@redhat.com>
Date: Wed, 1 May 2024 21:14:50 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 19/19] cpumask: Add enabled cpumask for present CPUs
 that can be brought online
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, x86@kernel.org, Russell King
 <linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com,
 justin.he@arm.com, jianyong.wu@arm.com
References: <20240430142434.10471-1-Jonathan.Cameron@huawei.com>
 <20240430142434.10471-20-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240430142434.10471-20-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 00:24, Jonathan Cameron wrote:
> From: James Morse <james.morse@arm.com>
> 
> The 'offline' file in sysfs shows all offline CPUs, including those
> that aren't present. User-space is expected to remove not-present CPUs
> from this list to learn which CPUs could be brought online.
> 
> CPUs can be present but not-enabled. These CPUs can't be brought online
> until the firmware policy changes, which comes with an ACPI notification
> that will register the CPUs.
> 
> With only the offline and present files, user-space is unable to
> determine which CPUs it can try to bring online. Add a new CPU mask
> that shows this based on all the registered CPUs.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v9: No change
> ---
>   .../ABI/testing/sysfs-devices-system-cpu      |  6 +++++
>   drivers/base/cpu.c                            | 10 ++++++++
>   include/linux/cpumask.h                       | 25 +++++++++++++++++++
>   kernel/cpu.c                                  |  3 +++
>   4 files changed, 44 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


