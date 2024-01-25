Return-Path: <linux-kernel+bounces-39296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2959883CE4A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB701C2300E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3A81386B9;
	Thu, 25 Jan 2024 21:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hcuXl/1s"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C044613A24C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 21:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217313; cv=none; b=eGe9rwO32v0VfzlhObdOQf5HKKYprnKXlVPGq9Tr3bIBJaRO/uHwj0kSK/Vrz0hWRx9KwpM75KQKunwX+ATSlON3eDwHZxy1lze/ecqeSYXDD6dv2ULmoir450MzSo/9XykOPXBmLk4pg6NQN2RK2e1gLrZ8wwMrXFJxQnREjYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217313; c=relaxed/simple;
	bh=b/qs/nkt+9BuESReMPYiO827KTWJWW0+QfrfS9/NXgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tceGFt/ioT82IP2YSMej64DfigX3CNVMyZa0uCbkUSxmHdev5/0B3Ao8uciOBJ0m5JjfsflF0lCmp9nDX9Hcyf0vz3jWCFyoGF2Id13RboTHdZvqBIdBfvkf84RiM6CwyogJsW1s7CsO2/jpStwTXcn8o1JrWdWd/rTy5ATQ92c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hcuXl/1s; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bfb1e7f599so28612639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1706217311; x=1706822111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ukzAY7Ia5t5Dvy0Ix5ly4ai+YCBGcgR+LuvxltyaCZQ=;
        b=hcuXl/1s1YvDG0+HCX9DXODxbB30MIK5II+tgWlO4Qh+l1YC/j+04uRZb5b/1u2Ens
         J57kLUgYGh7FxISRTjpYDo/ZNuy9NRwt6ZyNEjFMCb3NSht2e+8aqCUz03lKWGWD0z49
         TdjYL+Bp9b4mMcqI+N7gaoUilUb3PdGbwsUYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706217311; x=1706822111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukzAY7Ia5t5Dvy0Ix5ly4ai+YCBGcgR+LuvxltyaCZQ=;
        b=HZv+4ZXBpFzhNjV+5WLiWaahJNpYXqFWia9InCZ5udIfBIgiNc8SMHExrIe6iAUTmV
         xxzEo4A2UAVDYqhaHEPOjoQr8EEHrtrJde7BJWCwlmWQ+umDIKHlRjQjLdaDu4/oN4WJ
         eNqdW7y6KrTfqKfI9I6rVKZ914hN7gWv9oBZjSZxwuTePOqfbBJu2DpAHDFiig876+KC
         DxpKGNXARZsAcUR9Xq/0Z/xEXnmKkxBW0jbCLxYhOI+TYxpoyLPO99aTpiLcsGB9EdsW
         mugoItRK6py+1rMybYs3cfE6HE6yxp4w99nX93vxA83wsJ6Z/iaDB4hugT4XL4f0Oggn
         0RYQ==
X-Gm-Message-State: AOJu0Yx43MqhBOzqFwAVfx8nfW7GX3tRDgeBroMVc1ZYPhXGsE+b9JRa
	NcAp3P/9m9/4Xi3r3lQk0PHmRN9pljjVmNX0ONJK+PmjU6qai6p5LTLE9R8N6t4Zf0n8NU0JaIv
	9
X-Google-Smtp-Source: AGHT+IGgSDqpN5Nf9SwdxyyhjoxVnGwF3qhAxf3L0te+12vXSMjDhnzep66R9fzDIrxZFj8XvHYjrA==
X-Received: by 2002:a6b:e416:0:b0:7bf:356b:7a96 with SMTP id u22-20020a6be416000000b007bf356b7a96mr803126iog.2.1706217310758;
        Thu, 25 Jan 2024 13:15:10 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id t5-20020a5edd05000000b007bfbe4e309asm395593iop.27.2024.01.25.13.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 13:15:10 -0800 (PST)
Message-ID: <41addcfe-f897-4394-bf40-aaef22c27fca@linuxfoundation.org>
Date: Thu, 25 Jan 2024 14:15:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] kselftest/seccomp: Convert to KTAP output
To: Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anders Roxell <anders.roxell@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240124-b4-kselftest-seccomp-benchmark-ktap-v4-0-cfd2bd2a31cf@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240124-b4-kselftest-seccomp-benchmark-ktap-v4-0-cfd2bd2a31cf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/24/24 06:00, Mark Brown wrote:
> Currently the seccomp benchmark selftest produces non-standard output,
> meaning that while it makes a number of checks of the performance it
> observes this has to be parsed by humans.  This means that automated
> systems running this suite of tests are almost certainly ignoring the
> results which isn't ideal for spotting problems.  Let's rework things so
> that each check that the program does is reported as a test result to
> the framework.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v4:
> - Silence checkpatch noise.
> - Link to v3: https://lore.kernel.org/r/20240122-b4-kselftest-seccomp-benchmark-ktap-v3-0-785bff4c04fd@kernel.org
> 

Thank you Mark.

Applied to linux-kselftest fixes for the next rc

thanks,
-- Shuah


