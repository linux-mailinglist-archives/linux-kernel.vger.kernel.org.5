Return-Path: <linux-kernel+bounces-73238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA18085BFD5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB341C20F82
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BB976036;
	Tue, 20 Feb 2024 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtDej+my"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3927602A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708442873; cv=none; b=CCIu+BstjmjedgkeYHx2XZJlJWYNBvzEBhIeeRiLyS5cEhBi18utfj6Xgpb8I+OSEOjgggvGhxKoGWmPD/s9GlpBZNDRIn9BVQjsjLy9zn8SUQJ1AQCju1iwcYtU57GQK83AVVYc7J0fVLb7yHfKXDJPHxDarseaRTwl2W2mnwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708442873; c=relaxed/simple;
	bh=mLxWfQLLvOioexeY886N76KCBm89j9DOOaIJB4Zbm3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RVCjaQIzGfF++XudPB2kexlKMteusTzvkfXmHQ9sEs/+xrDk3+uQXQ4Fko+DeOkuVk/fz6y7NHSZq3e19KumKcJqwm9iOeS0Vy1zcB6ect5qZTnhaqsdFAKHq0ijaKeYRNyDc6DYF8c0P6OuLv3biv9OjJktWADnQXsf6HdQe3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KtDej+my; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708442870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fYOuDIFs/LVlHXgleVMIbbLrukpLufIKk99tU3yPwCc=;
	b=KtDej+myeKIb7aCYW6BohBHn76cDZwbEVW2vY0RP0gw1tMNd20T3yud/hvJw6jKh4Zo+/c
	vKIlaeha+D/ZLcADD7ztCtePz/Kg4ZN16BK8w8ZGZh9dOQS2g54q2CpZ+TOuDdgK3zxVL3
	yFXriOfGQA9tFpWkHSVJ/3XoTXIln/I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-k030d100OKGaepm9kkR6Gg-1; Tue, 20 Feb 2024 10:27:48 -0500
X-MC-Unique: k030d100OKGaepm9kkR6Gg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4102b934ba0so30688555e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:27:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708442867; x=1709047667;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYOuDIFs/LVlHXgleVMIbbLrukpLufIKk99tU3yPwCc=;
        b=d8rY0sPj66D1XUzgWYzn1IjuK5co5DlXyHFBKhptoyD1XVk8BHjwIsJWV7pIe5bWaK
         VoUXdm8DUAQQLUnCuIyTCzkFGYyGoPPPw5Z4Hx6qn3kz4hXJ1nma19mJ9pihqCE29yuI
         owyXO1MkDjbrHR9L8C4d8asp2UqMS+ax6nbCveYtI2OJP3qNZ2lRD/XS+NG4O/87T4oi
         r5c0NeWm9X+cGcHlcJp0QBsQfmJqGVKNBvWoKCMUkHAxGJkVvtRkMvzvU8fbppK5AMWT
         /qqIvx7iJ8alz2jzQkKI0Mzb7zSKx0LUv7sExcJzQUdRRMciuqbcb5Kv8g6+P5Sc0kak
         rkAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRZaCoMhiEY5fdvM6u90MTkbs+n585Bf2oUlDaZkuAfjwvq453hamr1TLQYxriDers7unyQUQXt+rA5WLUdsMakp5jGjcLwgx96ClG
X-Gm-Message-State: AOJu0YzXX5Qqn6IVmFusqHxMdaj4908rZOEqZ9myD621BGbiy1OTJyWw
	Tn7NdJfOcDRJVotI2qnKi2cyxJ4ZDuq3EdHjy/5V8Kj9yyR3pbkegBekV2xE1eyQtTw9Nc+XLvn
	+e/mkngNsaIJjoRt+gicUC0SJhXk7/SrhxT5Z10flCmObtpCSKYGff59ageYMhA==
X-Received: by 2002:a05:600c:45c6:b0:412:6dea:443b with SMTP id s6-20020a05600c45c600b004126dea443bmr1820325wmo.7.1708442867525;
        Tue, 20 Feb 2024 07:27:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgmL98pbTGBZrpzczgcEHbjfyuyieMoDDZxmeoGTVVCLmI80xfFt7I2cQAujleLydKE0j3NQ==
X-Received: by 2002:a05:600c:45c6:b0:412:6dea:443b with SMTP id s6-20020a05600c45c600b004126dea443bmr1820297wmo.7.1708442867090;
        Tue, 20 Feb 2024 07:27:47 -0800 (PST)
Received: from ?IPV6:2003:cb:c72a:bc00:9a2d:8a48:ef51:96fb? (p200300cbc72abc009a2d8a48ef5196fb.dip0.t-ipconnect.de. [2003:cb:c72a:bc00:9a2d:8a48:ef51:96fb])
        by smtp.gmail.com with ESMTPSA id s8-20020a7bc388000000b00412260889d9sm14901685wmj.1.2024.02.20.07.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 07:27:46 -0800 (PST)
Message-ID: <52f81c45-efa7-42c7-86f4-fc1084b1d57a@redhat.com>
Date: Tue, 20 Feb 2024 16:27:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/24] x86/resctrl: kfree() rmid_ptrs from
 resctrl_exit()
Content-Language: en-US
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240213184438.16675-3-james.morse@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240213184438.16675-3-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.02.24 19:44, James Morse wrote:
> rmid_ptrs[] is allocated from dom_data_init() but never free()d.
> 
> While the exit text ends up in the linker script's DISCARD section,
> the direction of travel is for resctrl to be/have loadable modules.
> 
> Add resctrl_put_mon_l3_config() to cleanup any memory allocated
> by rdt_get_mon_l3_config().
> 
> There is no reason to backport this to a stable kernel.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Reviewed-by: Babu Moger <babu.moger@amd.com>
> ---

[...]


> +static void __exit dom_data_exit(void)
> +{
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	kfree(rmid_ptrs);
> +	rmid_ptrs = NULL;
> +
> +	mutex_unlock(&rdtgroup_mutex);

Just curious: is grabbing that mutex really required?

Against which race are we trying to protect ourselves?

I suspect this mutex is not required here: if we could racing with 
someone else, likely freeing that memory would not be safe either.

Apart from that LGTM.

-- 
Cheers,

David / dhildenb


