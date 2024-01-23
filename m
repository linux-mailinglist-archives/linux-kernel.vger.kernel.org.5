Return-Path: <linux-kernel+bounces-36184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75FA839D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7B91C23FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D09654673;
	Tue, 23 Jan 2024 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsMOzsDK"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106B153E17
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706052154; cv=none; b=PSk+86E5Cts1OoCwTXk9goVqPDCO9srXn6YaPNShD7hz/6I0aElefOL4SkFnu4b57oSaHqbEUuw51fYqVfBl3XW95OstVQtF0vX7cDdBtICuYl+Iebz/DOjh3LMYDmkhz05TyUj+VdpY4r6UIs09SLdLddNv0EGHrI4bmkiZQ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706052154; c=relaxed/simple;
	bh=duFm+yYYWqyJP/UVmhigX/BEIENDYFuC5cqNZ9XwD8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FixJZgPw9YewoIc2QjvBnP9hmVTlfEyVx6w2r8sC7JphP42u+w17KJgvUPHQ78OW6dtdVsWs9mqK4yVAZt+G1Rn9uV7g7M1NGuC2O0UXYR44cZUO2/aIQC+uTTIRqFSslXmkjfYf2bLaCbjRRm7ivcD16vZjw9c3PUHWChKHNv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsMOzsDK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d9b13fe9e9so3956655b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706052152; x=1706656952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GZP4i/d1JSwVYCA73FcGjDSyaQvFAQ5t4u8DWK04oww=;
        b=NsMOzsDKRN4HRyNktWBZQcRr6Jty24elQ+7cl0L0/WaMzJrWiciAkzMIRtzQIUfnX+
         iLeMl3fbMzIo4R1uPDH0DbqNv3Tc46FAhHhTPpuirACU9eHlYBBl426s3xRMSiM1YrT/
         P0OF6AOaTKLxU4pqayE/HzspzT7g28xmtJD6c4aph0sHTIq49n+VsFMFxrEgPk4s5R5S
         il7SJQjVNLru9hZqA7UyvnMc3E8CST5ALwT6Qk7cU10n1FrA/j3+dxp0W7s/m+5UHSL3
         1DpbyIonyZzNBP2Cz4KMLiRrkfehhL+yOIJqUGA0G/B605lmQI2ZOls+G58MafoRDIxt
         LDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706052152; x=1706656952;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZP4i/d1JSwVYCA73FcGjDSyaQvFAQ5t4u8DWK04oww=;
        b=f5f19TsJK1SQbCvq6Cj0C9b4SdPmxcPhJseQPVEp9RznADY1ywGAK1E2ZhDRNwtf46
         Fdvk3eb9mH2qHhPwku8Dnkf0vQMh5CcCRrWimIZy1xQJBUr4hsyEh6RPYdj9kzTxib12
         GQyJ0lULxz2y1/1KjvtgHSwi6MaD0wl2FPRued7kn07/HFUNn9oFc58nbdz5zLsua5GI
         trWabc/0jpdZdoTukgzPRJFvXWOhfg7UTTlazYo0CGADZzvSiDOKlrgOpIKndxSFEu4S
         Yo10vlKkpXOPDqfaGCzJuJO69tbLYqRJFveScuELF0Evd8qNSui6IibEnLud8z+vHhfo
         4i0Q==
X-Gm-Message-State: AOJu0YxzX462rdrvcVlr2V43hAaZw1l8vb8txEe/0SuL+2EtBbR+MAf6
	PAO/FQdJNvjHgEZI2RKYVDC3qnpf46eWAxbZEZ4NMaTVeRXtV19vixO0YGwb
X-Google-Smtp-Source: AGHT+IGYj0Iyn9OE0qlvB+BAOmVfGmrcR2GfsGxGUNy8cJq9D87lo02VBkrq0HW+y9YpsP246HNLEA==
X-Received: by 2002:aa7:9eda:0:b0:6dd:82e7:b494 with SMTP id r26-20020aa79eda000000b006dd82e7b494mr991275pfq.48.1706052152320;
        Tue, 23 Jan 2024 15:22:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e11-20020a63f54b000000b005b92e60cf57sm10703881pgk.56.2024.01.23.15.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 15:22:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <84790a56-1c7c-4ddb-a4da-17dc84c1f670@roeck-us.net>
Date: Tue, 23 Jan 2024 15:22:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] lib: checksum: Fix issues with checksum tests
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>,
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20240123-fix_sparse_errors_checksum_tests-v2-0-b306b6ce7da5@rivosinc.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240123-fix_sparse_errors_checksum_tests-v2-0-b306b6ce7da5@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/24 13:58, Charlie Jenkins wrote:
> The ip_fast_csum and csum_ipv6_magic tests did not have the data
> types properly casted, and improperly misaligned data.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Changes in v2:
> - Add additional patch to fix alignment issues
> - Link to v1: https://lore.kernel.org/r/20240119-fix_sparse_errors_checksum_tests-v1-1-2d3df86d8d78@rivosinc.com
> 

I applied both patches but see the following.

     KTAP version 1
     # Subtest: checksum
     # module: checksum_kunit
     1..5
     ok 1 test_csum_fixed_random_inputs
     ok 2 test_csum_all_carry_inputs
     ok 3 test_csum_no_carry_inputs
     # test_ip_fast_csum: ASSERTION FAILED at lib/checksum_kunit.c:541
     Expected ( u64)csum_result == ( u64)expected, but
         ( u64)csum_result == 27015 (0x6987)
         ( u64)expected == 55912 (0xda68)
     not ok 4 test_ip_fast_csum
     # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:564
     Expected ( u64)csum_result == ( u64)expected, but
         ( u64)csum_result == 42151 (0xa4a7)
         ( u64)expected == 5513 (0x1589)
     not ok 5 test_csum_ipv6_magic
# checksum: pass:3 fail:2 skip:0 total:5
# Totals: pass:3 fail:2 skip:0 total:5
not ok 17 checksum

Old result, before applying the patches (v6.8-rc1):

     KTAP version 1
     # Subtest: checksum
     # module: checksum_kunit
     1..5
     ok 1 test_csum_fixed_random_inputs
     ok 2 test_csum_all_carry_inputs
     ok 3 test_csum_no_carry_inputs
     ok 4 test_ip_fast_csum
     ok 5 test_csum_ipv6_magic
# checksum: pass:5 fail:0 skip:0 total:5
# Totals: pass:5 fail:0 skip:0 total:5
ok 17 checksum

This is with the imx25-pdk emulation in qemu.

Guenter


