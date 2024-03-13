Return-Path: <linux-kernel+bounces-101420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7890287A6E8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0EB1F23BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FF63FB1C;
	Wed, 13 Mar 2024 11:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tb62GcZW"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E463FB15
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328291; cv=none; b=cjOT8Adbnk1dQwYy2aVMxjmfwF+gwg4YDm4tmer/MDIAT7BY15Fdz7ZpcYLpGsAcRfWOtw0nMpcozYXw7oGGLheqq/2SO8gePkesnVN6vaHM+nz7FeV0t1LnuL4yAV4EfUMSAFlxI+wy0EUsTIAtAvJ6gKEcBtSHRW4b5q8gRtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328291; c=relaxed/simple;
	bh=XPlJIgNStuf4buDRYYaVRnoP93BKyAR1MZDwhRIxozo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ln2tos+VOcjzrDBjcxbfayAxmIi9TcIzeCj5WjNxX4YvZyvzYuBHy2cbHkXzhkC+tDZKfzYlrQGsWP0UJFr5c004Lv6JMB+/4Lae1qMBQD1tDZlQWQ7PZAIyntTDXlKWuFPIfiTh3TII4UoqL835Wi4BRmD4ZV6Qa/Egow5WdYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tb62GcZW; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d4541bf57eso11841811fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710328287; x=1710933087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7woccNPj4UXd7qVtmOU390S3k1KzIAZsbOQ4xioXn0Y=;
        b=tb62GcZWF+aKn8urZeZx0rDkEcuKin4vFCozuxlvpkeV2FzuapFPziW/tdzItOYsQq
         gU9FRsdPjRFISi3piATgvbnfePpsBu18Tk0yjoL4DaUdy+l+Gd53QNSoeNX7WCfDQ3O5
         FSPVhfQA6fA02I2PhU3GSnBcLgvZjAhqhe4axaRDX5qx/rg5ZZIs6RWIERdSvDombUYw
         g+80ICaYQ+50aZzWcK1BMzTka9WMDdPC6H6nAka57OJga8b7Ty92NN/Kr1Lv47/TO5ek
         tAYpAL6saiWWAA2TixccJXb+uxI2Ki+7VUUy4vCLVhRX6KwUfCDHLpdKZMJgH0sKJml6
         E/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710328287; x=1710933087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7woccNPj4UXd7qVtmOU390S3k1KzIAZsbOQ4xioXn0Y=;
        b=T1VDEz5BmLD6QY2lQJcqI3mD0vajcFCB0n53CeiizvOnoKSpzjKp9i+qo8p2Ka5zdc
         207n01GI2weP+OVHTJQNFt89J9nJWfRhelSZ7oMunkctyIQ/lqeAvA119iPoTQSDV3k+
         ovhlb3URwRAkk3+ins1R66lZ7icFCSmuYlmcXV2UkXPMd/mtDGrblUyHSR78rQ2zaPUG
         u+KSxejV0t8VzDYb+rhTAQSc+k2mAtVGZrDq4KJ2txTcuvBFsQXvtFIfiIJVuah+ILK1
         jDRV4Z8Ezzr7nUCaDIc5f9YoDJoQi543XddDNYoJ5/HJZP6vtzYec2NaX2oZBVUkWEot
         5H+g==
X-Forwarded-Encrypted: i=1; AJvYcCUIA5BwWVDZ+grfIZkJ7sbFIG1qlCAWahfdcTI1jY46P9ZLVPeFFgQRiMbzIB8CocunTZYiupj5jb1nOSVv9H2SLpCj8liQoKjmpaeV
X-Gm-Message-State: AOJu0YyrzeV2RrVgBlp8RslSWk4zIEe7jhX7QsNEaelXWZyznfpPo8kg
	u8Phi2Qcspe22cvURIzWW8/yHuZ8FIIE8/W89iECuPA5y6waORP1WPdYtQDOvB4=
X-Google-Smtp-Source: AGHT+IFe6RvtTLmew5N27k0KtbNVRvqn1qKhx35adNhbsYVId+ZVveNfCa7J/CyIRBKHtjtLjo0sKw==
X-Received: by 2002:ac2:59c6:0:b0:513:c790:792a with SMTP id x6-20020ac259c6000000b00513c790792amr1252418lfn.38.1710328287456;
        Wed, 13 Mar 2024 04:11:27 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id q11-20020adff94b000000b0033e95bf4796sm7905988wrr.27.2024.03.13.04.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 04:11:27 -0700 (PDT)
Message-ID: <4ac22b8b-9230-4489-8b38-a2ba79c16d16@linaro.org>
Date: Wed, 13 Mar 2024 12:11:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clocksource: timer-riscv: Clear timer interrupt on
 timer initialization
Content-Language: en-US
To: Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Thomas Gleixner <tglx@linutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: atishp@rivosinc.com, Samuel Holland <samuel.holland@sifive.com>,
 Anup Patel <apatel@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ley Foon Tan <lftan.linux@gmail.com>,
 stable@vger.kernel.org
References: <20240306172330.255844-1-leyfoon.tan@starfivetech.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240306172330.255844-1-leyfoon.tan@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/03/2024 18:23, Ley Foon Tan wrote:
> In the RISC-V specification, the stimecmp register doesn't have a default
> value. To prevent the timer interrupt from being triggered during timer
> initialization, clear the timer interrupt by writing stimecmp with a
> maximum value.
> 
> Fixes: 9f7a8ff6391f ("RISC-V: Prefer sstc extension if available")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> 
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


