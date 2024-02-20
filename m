Return-Path: <linux-kernel+bounces-73794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D153585CB48
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFA62843F1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C5615443B;
	Tue, 20 Feb 2024 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gj1c8hCc"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16164154427
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469955; cv=none; b=JlEXHrKKwVeN3zc5gP++mb+mgh03lxZa6hk5rw920ua+O9/F9YU6q/9pB8NOGW6tgsRYlyt/1nveIUzYvhYgydA89FipNQMlQ0/U5U/d1RxyxicsXufXNGpLSK5U7wowcRJKboLVBsKEP+glyQC1R/V6by6PIoUpjBm2VkLO4/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469955; c=relaxed/simple;
	bh=r0q7C3BTXQWVoAF7et7PmO58LjUv8JMMw/dJkBUXwvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cs+/gNjcJVHzUf6enDHyB0NVytysLXedvUiPeHVGvVGGevXsP5DiHE/8cHoypbXjOzbiQn8AoakkZuI7Kou0kcPCsYlpOOi3Lsxd4dOKZAe52VLvJEa8K6NYEMYIM14LCW+ec5nI0qxQZqVQzRvASMafo/YHoQw3824GGOWRh7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gj1c8hCc; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7c00a2cbcf6so44427139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708469953; x=1709074753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8K9aXU3q/65GO6Sm64RSpJezMgpW/RCj7oX3cxUfRkg=;
        b=Gj1c8hCcYSd4okPF+vUnyV3bJ5FryzBylMcTH5n6+MGQiBOxOc5VTjkpqZ+ex1Vido
         3AtQ4Kxvgt7naVBRIagjV+wMsve3jGBnMHsYEUHhUClCGshddZSvK77PD+Y0NJpn8s6t
         d0ntAoMmVCHB4qfFwbnniFSXMuKyzVHxhIf/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708469953; x=1709074753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8K9aXU3q/65GO6Sm64RSpJezMgpW/RCj7oX3cxUfRkg=;
        b=bdcXnpfshZfcscSKu9YJh3UQryG9lmLYkhnF1m7fYn5shN+vKuRDRYqHYEKyqt21CC
         R7/WU9TH6FEuAIlPgHpgg9wZNBWPw4E5okFb918jffb9BjeACsk1/W1DLo/DPqS+6yXy
         HGTU24kxk36uGiKektmQBRRZhtucoqflTF6IlGhwbzdSFsfAPAEplC7zNoFkrWC4L6HV
         zBMM2tff/QExG87N24A1DBmkZ2O7nqMz+FauWZXbOQ8uNQ4Vb17VI+R9rOxJIHHUJ68z
         WieLE5TkAJIZbyO9FC8WsdbUt+un7i5pWGxr31PWkFAwWOtZv7FvTuN6yGY5XC1PF64s
         xQKg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ6SBpa6ncYJOK+Dor7ADiuvkxXlQFIqf7iE4DDQzQIZe3Xs9dvsQpzqm3D5LMO946qFJ3ISLbLaSswDw5B2yzo5S3ewdQvc6XwkxT
X-Gm-Message-State: AOJu0YwwVaMxLIeLC+M7fBgD60LmpNjUot0978nOIX/NBJgn3gkxB/iP
	/nAho0tqhfvM7qlj9jflIWWWGdeheAGTkiOAqgHPHIpCRLCkvVb5ScX8dPkU9wWEmwPadqI7K37
	+
X-Google-Smtp-Source: AGHT+IHZpeFeP6L7Ans4kMahbW2XFNoZzvvWR3gSQCybe4GM0oe5Uc1SPG4SLL1RTSnn2zX+eOQezw==
X-Received: by 2002:a05:6602:2cd6:b0:7c4:9e06:b9c8 with SMTP id j22-20020a0566022cd600b007c49e06b9c8mr15482650iow.2.1708469953307;
        Tue, 20 Feb 2024 14:59:13 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id b7-20020a5edc07000000b007c45ab3dc34sm2483821iok.29.2024.02.20.14.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 14:59:12 -0800 (PST)
Message-ID: <cbd29a01-d8db-4052-9d95-1e5357b0c10a@linuxfoundation.org>
Date: Tue, 20 Feb 2024 15:59:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Move KTAP bash helpers to selftests common
 folder
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Laura Nao <laura.nao@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240102141528.169947-1-laura.nao@collabora.com>
 <5b14aa28-a239-4204-a8ce-8d37f19b724b@notapiano>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <5b14aa28-a239-4204-a8ce-8d37f19b724b@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/12/24 08:01, Nícolas F. R. A. Prado wrote:
> On Tue, Jan 02, 2024 at 03:15:28PM +0100, Laura Nao wrote:
>> Move bash helpers for outputting in KTAP format to the common selftests
>> folder. This allows kselftests other than the dt one to source the file
>> and make use of the helper functions.
>> Define pass, fail and skip codes in the same file too.
>>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
> 
> Hi Shuah, any thoughts on this patch?
> 
> It's gotten Rob's ack, so I take this will be merged through your tree.
> 
> Thanks,
> Nícolas

Applied to next for Linux 6.9-rc1

thanks,
-- Shuah

