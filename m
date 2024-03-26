Return-Path: <linux-kernel+bounces-119852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D23D88CDB2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9522E5A31
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA5313D287;
	Tue, 26 Mar 2024 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eGygfekZ"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8709B13D26F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483327; cv=none; b=h2NMKmUiwltIKWf/tJh3G0MEjLrZ7lFeYRFLyG49o63T14//dGGnGVAwJZd2Hcfd6Z0fueh7zQBrM9cgOac/v+sSUDyTj2tk73/yos/abENCiAvfAAN67/2//FoYhS09XiLeyYOBz20Jr/05cWKa7EBrWy+GM+o9AI4EuxMzYB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483327; c=relaxed/simple;
	bh=NVyT1rZ5Z09EkRaYcg04Xz5VJbpOngmHOVufF0GzCuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHPEGuPCFVBaU+uIARWgPK5mbIrSlhf9JjkcPx4rCky0kgTvvQpWEwXb9QFkU8omRV0a2+cFeX3LlaghHHjHTpZTtCnFxnoqWT0n8nbcUG3oePOPKW8CVrGP8mibfxP5dZBR8VxBbbc1lGkfYbIJcn8qfFqFiAH0xv3B96lOoRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eGygfekZ; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso39132039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711483323; x=1712088123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ceDt7l40yS8ehWwNFlDZMvkF/pov5VQ5j/XeBU2FK4=;
        b=eGygfekZ9sfpLWPv+anX+TmCJmDUB2gE5DLHrRf49+KxwQVguF7BvgtHDAzBefZ98G
         CufybqAhb37t/gQAY7bR6wuWYp7fv7pH/QVAcFJ70KNvO5zAu0jFWPWBXZXKYSwL6I8z
         WrLuTWgJ7EoYa9FDsadkOorGIER5grsq68jBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711483323; x=1712088123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ceDt7l40yS8ehWwNFlDZMvkF/pov5VQ5j/XeBU2FK4=;
        b=opM5ELHkVkODsJlVsA0F6S5/4diG4pe9z38WDTaZ9BCX6N9SWnKykkECMUQkl++xcj
         fYxbtDaC9OHFLqx9/0AY+HvrWofWLuBz7TpBpqJCYR3JBG4qdLUG5NwTI93EMOAu3++X
         BkgVw3C5JcnDUr+8pnUhV294iLdFmYWAb5uJX2kWiD/ygnGVSXjw6d/NphZcrC62GXeb
         Ee0i2TkJA64wOn1UQ0JOXBXlqqFOOIiVHkT397vY4r1MrRitNcw3ZJn6xWVaG2Omecd1
         ijeNRk5Liob/hjlz1zasbnP/IcHHFsaPsf1KjoWFl95eWCmN7pNWG689f4Nblpy2F4KT
         LcpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx0+YbbrVlZjdN01b26+AH8+6SrftXMj5kf+dkR0kzZyk9ppRwTZroIsZdY9QyaV9qhbPPJ7j3bwP/hf4anB22whnd5Kxlf3NXeBuF
X-Gm-Message-State: AOJu0YzT2Jm4vaO6RQ7VGNb1L4ovd/lu5RoO3WudlankpImEhnI7ORVM
	W8zto92EdKunYaBLoBUBBlVPUfUAqn1q9u/T8sVQMeVCI2NnVvruPCE1y9imxOM=
X-Google-Smtp-Source: AGHT+IHTtc/I5Tza5E6NUgf+B527aT1caT0ldXqAFDQVLsHVo6+FXPjzT+mhcV5alzJgv4Wbcs+fgA==
X-Received: by 2002:a92:de11:0:b0:368:4839:9b0a with SMTP id x17-20020a92de11000000b0036848399b0amr9316779ilm.0.1711483318537;
        Tue, 26 Mar 2024 13:01:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id j12-20020a926e0c000000b00366a3016a30sm3105612ilc.70.2024.03.26.13.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:01:58 -0700 (PDT)
Message-ID: <19beb37a-932d-4777-86de-c2c415ea56a6@linuxfoundation.org>
Date: Tue, 26 Mar 2024 14:01:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests: x86: test_mremap_vdso: conform test to TAP
 format output
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240314103216.286603-1-usama.anjum@collabora.com>
 <20240314103216.286603-2-usama.anjum@collabora.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240314103216.286603-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/24 04:32, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

This one looks okay. Please address the problems on patch 1/2
and send v2 for both.

thanks,
-- Shuah

