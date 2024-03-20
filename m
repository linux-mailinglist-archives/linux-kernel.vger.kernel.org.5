Return-Path: <linux-kernel+bounces-109273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32980881715
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83947B211A2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054AD6A8BB;
	Wed, 20 Mar 2024 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AbLPR7uA"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12446A327
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957879; cv=none; b=Oxn3Z4NzQQSYc8b9nphhUu4vgHNvnDknM2DTe3L4CXzH3S56vOar5UtXhDa8FDaYX1OOnJ519/vVh5zhj3xhx/Y97bcUPfQBmnZTHXqxjKSZW+nhWtSIY6O5jaOK+PSFZontsVWA9vcfRXMfZvLHM8Vi0ZrrwO33BxoOopiabtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957879; c=relaxed/simple;
	bh=VOZ4WmYYmAeIBgjFbfFvP+4vvCJ36utbFzgoapDF8SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyxqkZB9qyqr4QFZ1foi8PdYEGmBebu2QO5AwucsesrwfYUgzUjg8f3mGxWFEuMYUQ5mSybYyh2L8fk9Ho67Mnq/mFcQKBBy6LpxU880zQ5BU/yw50OZs8nhc8g7IyH1mz9agJlAL8u7AacS7nA9BLKrgLbo9ocYt2TXLQTInKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=AbLPR7uA; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60a0579a968so402417b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710957877; x=1711562677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6TmgB7TOmDIH1+NUxCse+KiCTmMgVy8/EkD7jAnjwO8=;
        b=AbLPR7uA6qgMLQH6Nb2BEnJSVKVSZKag7WPNxfyQXJ5vi0ZROOxsPF6/oW4inTv/eT
         43wD7mfoJ4sF0BC5zJOxQNIDxz4fWJzmPsZG1ADMj4lru8OP/Ov65/etsXXym9Sa6+5r
         qF1I7LNw7z2Pcxu/52Hdd3Id7Aj7WaQK9D/3LOlV9tJp/Pr5D3QW77hgm/M2d8bg7/Eo
         +l5YeBIsmQBl3Y1XB/6K38bqan7VWiVkDezfIgFs+CzXM6L14dc6UDm1Yc0A4zcJXAGS
         +mH/6l+EiDfQcMZs4Sf7kARefRs6IOQx5ENMue7sC3YNzhdsTfpctTIVWqVeSICf5QEN
         l/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957877; x=1711562677;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TmgB7TOmDIH1+NUxCse+KiCTmMgVy8/EkD7jAnjwO8=;
        b=FxPJITGhd2pdq3Ol4hikeS4aPl1x+J5EGFIufYVS2hQ1jwu7wnu5TasIGyFRfHltsV
         NR+LJHtKNEHcIRldc+ans9jaWOzZACZcy92W7JVNAHD6AFaqGI1JUX0eetWV8eUp1bwF
         6WoBh7FJ+ryOHVLnN0r4PtgpPEKBx7056g2PINODcBySdAN1ytodvTWuXKstBWlMk01k
         t2CM9TANwC2V67s/OWdOqUN7xSPiBmzEnSHyn95FuTu4YzD/CAXuhxfsPORyGvGNh0YO
         P52Yi2xQ25y01wDdWAAbjAJyBIXTUvX+Dk8QoHrgSupnSkDlPQ98XYJDMWKEMb5+mzn9
         HWTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW/IzauwS7lJmG+VeiB3bY5dRz/Z9Q0vWnXuDl68yrln7DLxCb6p+MMieWFX+hKf6kEzWo1UMyeU5W94OIjlWYzCaozojBpjzY4CA/
X-Gm-Message-State: AOJu0YyGGKLHuaPN5qNbQEdyfrdXbS0dyonQEDK185O/8FZnpvi+eolu
	cjYAhcT5jxeyXsRpbvtvBl9ke102Mj+Ii2VpjJwk3tcMWlTLUQ13VqAAKnifzdg=
X-Google-Smtp-Source: AGHT+IEjNFRrCRHpqrhxdo3V77FEmF7Rpc9yb5igu4d1kI5oiVdJtqEevCyIKfRdNiyO251T+F0HDQ==
X-Received: by 2002:a81:a50f:0:b0:610:c904:842b with SMTP id u15-20020a81a50f000000b00610c904842bmr2791022ywg.46.1710957876657;
        Wed, 20 Mar 2024 11:04:36 -0700 (PDT)
Received: from [100.64.0.1] ([136.226.86.189])
        by smtp.gmail.com with ESMTPSA id o1-20020a81ef01000000b0060a304ca3f4sm2832865ywm.19.2024.03.20.11.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 11:04:35 -0700 (PDT)
Message-ID: <1ffad954-63bb-497a-af10-0b319a0831b7@sifive.com>
Date: Wed, 20 Mar 2024 13:04:33 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 9/9] selftests: riscv: Add a pointer masking test
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, tech-j-ext@lists.risc-v.org,
 kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Shuah Khan <shuah@kernel.org>
References: <20240319215915.832127-1-samuel.holland@sifive.com>
 <20240319215915.832127-10-samuel.holland@sifive.com>
 <20240320-handpick-freight-ec8027baa4d1@spud>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240320-handpick-freight-ec8027baa4d1@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Conor,

On 2024-03-20 12:21 PM, Conor Dooley wrote:
> On Tue, Mar 19, 2024 at 02:58:35PM -0700, Samuel Holland wrote:
>> This test covers the behavior of the PR_SET_TAGGED_ADDR_CTRL and
>> PR_GET_TAGGED_ADDR_CTRL prctl() operations, their effects on the
>> userspace ABI, and their effects on the system call ABI.
>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>>  tools/testing/selftests/riscv/Makefile        |   2 +-
>>  tools/testing/selftests/riscv/tags/Makefile   |  10 +
>>  .../selftests/riscv/tags/pointer_masking.c    | 307 ++++++++++++++++++
> 
> I dunno much about selftests, but this patch seems to produce some
> warnings about gitignores with allmodconfig:
> tools/testing/selftests/riscv/tags/Makefile: warning: ignored by one of the .gitignore files
> tools/testing/selftests/riscv/tags/pointer_masking.c: warning: ignored by one of the .gitignore files

This is because the "tags" directory name is ignored by the top-level
gitignore. I chose the name to match tools/testing/selftests/arm64/tags, but I
am fine with renaming it to avoid the warning.

Regards,
Samuel


