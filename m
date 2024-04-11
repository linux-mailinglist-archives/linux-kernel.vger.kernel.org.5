Return-Path: <linux-kernel+bounces-141604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9A88A209A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF501C211AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3052BCE8;
	Thu, 11 Apr 2024 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nyyylwaz"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CB63A8D8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869405; cv=none; b=Db7ohINGfI4+dIDDhOZE+TO72NB/WzZdXYMNJUKeYK7hj9KJLkBPHlpXm8bcwzxIoNnOv+PbTdRGX9/LAIKRIosJa7K25HD4Fdft0wqSAuRkwhXh3wOKElUWshoM3ATzTrkqaRe6qKwakWp6x5MR5Ey84zZUJNEXNYNXrtZgvZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869405; c=relaxed/simple;
	bh=cStBAu9ZM4K010J4PEkSQ5RzVRGtWYK6r22iftBsmp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVNf925UFC+IzRSknQfJCie30RoMvW8X9Fmxg6DapQp2Lx/zBotvkDlq1LWiiZ8YHvfySljeBSGgUkKoo3jPbRbVFhpDSBsZHzgdnkkfJWu73EZi9XQCettAebC5/EHnRV/rqsa0ZijznIzveq22BkEXf/l8Qlyuqm5QOQAq9nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nyyylwaz; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso5351439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712869404; x=1713474204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XkXziOZcmJPH9DNxVUuT0LSvem2MocbN93rqFY23cGU=;
        b=Nyyylwaz4riSJ2tQ21lwjBWh0PcTdoBUTZ6Nha9UcWBoABFCkbKIRjVIg/cEXo+6rf
         UItFmW7sl44YWM360UmNYh3DXh4QgP7zQLjzDO79pAXqk0TYNuoyt6byT4YqIgbnitYi
         V6Hcntl3094b06yvF8sQuB8LnMpZ9TMqT/XXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712869404; x=1713474204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkXziOZcmJPH9DNxVUuT0LSvem2MocbN93rqFY23cGU=;
        b=TCSVfhfWRe3UEMV5pSdHNn39qLTRBdh+gwQQbr3M5zMdSMufL3vajPQ4YCIADuSmT5
         Te97B7C/oBRGw3s6ybLkFW9ea9DqC/ngCa0gRE7yP+pP1vNERq8n55vnkDWE3oUTh4pw
         pe0CWXpS56bjSf++lzdKRE9uUIhKFRRVMLEXOWO8os9zgZtzd21/08lywraFKEUxzcwP
         061l3dbvKL3n+Jfuv6XIAuZZZUTiouLkSZL6D0g5kUGAo5synGZBl9bgm0NfIlOslcOf
         gN7iXBX2AUGnV9Z/MN+HMp2GP8iIeMxi54n6kyIQOHNhi+5yNM9WDNn4/vf4lWN1RgJW
         JrdA==
X-Gm-Message-State: AOJu0YwIMh08se+XpOy9EKGdUYy0/vvn9KvVQFlVroxsqzprS+xk7wuo
	a86DQZ+/TcCsB/2h44O/HQaoLL9z24n8uUZtjd+LoNUs62JCmh3vfEV/iai75euPFV8960PcvvJ
	0XoM=
X-Google-Smtp-Source: AGHT+IH+SIjacB44Z2pTqGb+ewSPjLIOUQiuNIQihVZqvUDNwsuJRnB4hUTSv14qa8VHpfYHaF3LwA==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr985974iob.0.1712869403597;
        Thu, 11 Apr 2024 14:03:23 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id i17-20020a0566022c9100b007d02d49bc80sm607756iow.50.2024.04.11.14.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 14:03:23 -0700 (PDT)
Message-ID: <c70a1402-4664-4200-94a5-239c7bc37392@linuxfoundation.org>
Date: Thu, 11 Apr 2024 15:03:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/clone3: Check that the child exited cleanly
To: Mark Brown <broonie@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240409-kselftest-clone3-signal-v1-1-bbe49156171d@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240409-kselftest-clone3-signal-v1-1-bbe49156171d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/24 14:39, Mark Brown wrote:
> When the child exits during the clone3() selftest we use WEXITSTATUS() to
> get the exit status from the process without first checking WIFEXITED() to
> see if the result will be valid. This can lead to incorrect results, for
> example if the child exits due to signal. Add a WIFEXTED() check and report
> any non-standard exit as a failure, using EXIT_FAILURE as the exit status
> for call_clone3() since we otherwise report 0 or negative errnos.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/clone3/clone3.c | 5 +++++
>   1 file changed, 5 insertions(+)

Applied to linux-kselftest next for Linux 6.10-rc1.

thanks,
-- Shuah


