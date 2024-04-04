Return-Path: <linux-kernel+bounces-131908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F32B898D7B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4133C1C27B98
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DDA12DDBD;
	Thu,  4 Apr 2024 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OIRMCtj3"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4BA12CD9C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252908; cv=none; b=fl3Z8HIu9uEbePVtx5h1qv/liT9YfMbV9IGAozebyKBW5OVEnt6KF1teWY8k8eehl/9ZYhQCnAyMbIv8/peq8lR4bSVn/Zc/bKU7GfpFlgn2QQfWTts9ZyTQpgQmLlGexU27/X3grJ82OuKawGmIi6t5Ykic6CF2d47AS2FPdB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252908; c=relaxed/simple;
	bh=3cSbmZrjAfQIrrTlLR0hOFNu/HfpV2pnoC7RSDEECic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPko5QaziNFZvxo1LbJ/0geXUldhQ+2smXSChGald93pJCIOQEzSjsHT/IViD/+x4nJy2dr+QoN9TqWDfzsRpt4CTlX/t/o4j7V6R3oFH+Xmo5/V1lwkifUPLRr6Dz4QUiJuZq4gWDDEpxMSjpZHvvthADKIbunilTWcTsl07sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OIRMCtj3; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7cc5e664d52so27086439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 10:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712252906; x=1712857706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KY5NyprwqnUz5XuA9Kl5z+7VSecMAoWLl/z+MUE9h3s=;
        b=OIRMCtj3/kGO/7uP4JL/ySFZnoCc7BiSL1RmL+60eii00FJKxt/6hS97g4YyrSLfyq
         kOCg5j4O5+diKaawE3BZOS05l+Sn7hX6GxIShiU/ZXPyYttcZ8eP9vIG9h9xi/evHRC7
         3WG8+n19o5WhvobuxmqQZVfvj1ADdIjhjdGag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712252906; x=1712857706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KY5NyprwqnUz5XuA9Kl5z+7VSecMAoWLl/z+MUE9h3s=;
        b=GqMnE/PPsUefIhmbG7VvR8nbu378OC5bsEQlvkvNh17gWM3bjfzxpQ8OJUpDJoaqGn
         scthmSQmkfrCritBMazyPLQWjQ2XHl86JYRx1dvfz17HlgP9GXCSp6cF01bzPfgMpkML
         cvD+DiiljyuDN8e6ElAGuye0VAx1Ou4xG8NfUJDTLHBeg7kxmXE1jay88qsPZ48tknRV
         4wk4oNbqlOgD82LXvcn2f/XHPILePlEMfVg+wP2g3h2sSWVX6Pm3v6wpk23J2WOECfq9
         dtuP+M+lYBkC4wHf+eiu5EjBQiC1d1MCkakY7gk6mo74mRvcQuGlpsh/VnXk/yuy33De
         DsKg==
X-Forwarded-Encrypted: i=1; AJvYcCVV9oUea8olm/3K4aIIgfxkaxv0WnsK5sEl7HFWcsqECYkN1MAtmqDNP+cHzZAFWAOl+3xpppb7DAL5TRuPAGVysuJc3XI5hG+3oYUI
X-Gm-Message-State: AOJu0YzKqtuJe6G/wNCGExr8UkbTkf96+FgMp+WgngygnFcBoNiFc/ZS
	F9BLi+e0jMjwO9mNZqt3Zz2R/JyuANMoYsXILxV5gj3wLfFRWHrCkh1f7EH6mwI=
X-Google-Smtp-Source: AGHT+IEQpErISzxtGnTtE2N5Xs2rTdzy5TuY1rIwnpn+T8yboQI6fXwKLovL7m1U6HCU8niYZE9xgw==
X-Received: by 2002:a92:cc4a:0:b0:369:b728:583c with SMTP id t10-20020a92cc4a000000b00369b728583cmr3556416ilq.3.1712252905984;
        Thu, 04 Apr 2024 10:48:25 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id he21-20020a0566386d1500b0047f1a41f958sm1238024jab.56.2024.04.04.10.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 10:48:25 -0700 (PDT)
Message-ID: <9a2b6f33-451b-4cb3-ad6b-be87b4c03a94@linuxfoundation.org>
Date: Thu, 4 Apr 2024 11:48:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] selftests: add ksft_exit_fail_perror()
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>,
 Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: kernel@collabora.com
References: <20240404161433.114497-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240404161433.114497-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/24 10:14, Muhammad Usama Anjum wrote:
> In this series, ksft_exit_fail_perror() is being added which is helper
> function on top of ksft_exit_fail_msg(). It prints errno and its string
> form always. After writing and porting several kselftests, I've found
> out that most of times ksft_exit_fail_msg() isn't useful if errno value
> isn't printed. The ksft_exit_fail_perror() provides a convenient way to
> always print errno when its used.
> 
> Muhammad Usama Anjum (2):
>    selftests: add ksft_exit_fail_perror()>    selftests: exec: Use new ksft_exit_fail_perror() helper
> 
>   tools/testing/selftests/exec/recursion-depth.c | 10 +++++-----
>   tools/testing/selftests/kselftest.h            | 14 ++++++++++++++
>   2 files changed, 19 insertions(+), 5 deletions(-)
> 

Applied the two patches to linux-kselftest next for Linux 6.10-rc1.

thanks,
-- Shuah

