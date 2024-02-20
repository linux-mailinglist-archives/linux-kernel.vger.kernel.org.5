Return-Path: <linux-kernel+bounces-73240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122CB85BFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450A81C20D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D53576037;
	Tue, 20 Feb 2024 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RnagBOFq"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9DC73165
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708442909; cv=none; b=IY+EIXjqZdUUyP/FhDfOSL5tFajjJnlaSCIiMWqTi6pLMF+/LYZmaxxzwIpV0I2PBgnwlLlBBAbIkslDD9H/3dzVvMU9wUwXkrz2qfTg201ZO6xIh9DvIVYPG36M2go1OBSuRkRb+yOF7pKA7YE/R24OBekmItk44uv0UHrV1gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708442909; c=relaxed/simple;
	bh=UVLriIpfrdpJPFajm71aoVJ8QkLWvRefgJDCt8opwww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKXKK53o8Zzm48tmFIAAJn1sx+hDODoT4pBITKT1gw84mY8q0VtFGypAhK/D3ppcAxsCZlxu4gD0mcVjo3wPIkpAfLvD4C38xibM6uCKl+HFIo2mHrAXROxQ2NoFhhca2v/jDZwDtdLt+01OlHfnWvBCnW3oP6NNBb+y02LglrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RnagBOFq; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3e87b2de41so224803566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708442904; x=1709047704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XcksBfOCrTeFsWG5z2uYrSU/RcRjea2qnZfecVJx4nk=;
        b=RnagBOFqkyJbs08aZtEcKjHCk4hLC8aIfc+iM718gYJnENB8CKEF7hY7piGKHOg1Dg
         uGWnpjK2RlqKeWYFr8Ezd2+2dVpfCjTnJDiap2hgL6momYBU2MwzSnKMuNSIdyLDczuh
         XUXBr/ycbvo60Zr+Vfm0tZbGtqoVKlt49HzifPTgaGutY8LqygOVkZTJyNvzZrVq1MZP
         0Pm4GDrJjpe0F1mZQVTuYBoh6+2WyONw5LiFQqa9dmMEVGtaBL1IHmid+lvvTAdqX4aR
         TJhxTGvQriO13dooYozrrXRCBIa68HoGVx3FEAP+usPt0Jb9DDMZhGyYrl7Xpz/F99kh
         xydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708442904; x=1709047704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XcksBfOCrTeFsWG5z2uYrSU/RcRjea2qnZfecVJx4nk=;
        b=eTJX7Vm+ov0Kf2vFpGpyLLrQhTOGJAvfM5kvi1KtTpMNFvrsf+qQbyYu0UoQAcGosO
         JwGsEBtMijhRYmmCMMnHdtcoQa+bqwh41MlQ9PIxP1olL+yD+HMgRE+Zwq/0eNKJS3FG
         7V3eW/QpwaUlSNo7P1Jih+m4URK+YnWJonMt9Tl0s9lbnZg0R/QLi0y9lo4lcR1oG9ps
         AJaEELcidznzxJ7lCRqcq8alHzIryypbjE8d/vdUFIdp9a+QkSvpd7wkMkKjMBdgFmbB
         ExQIsn7fs56ylhf/nPhnN2iXFmlAzNn5b6u6IKSou0BoCdi6HuhDX/WhO9Odlndec0Z1
         jx3g==
X-Forwarded-Encrypted: i=1; AJvYcCUpVHEN7YJdfMuszKWwaAnyXwmqZUhEDCdNNKdzfG4WakzfpQbxP9JVPm1uB62xq+pryXwowhqtfhyvakzik2L8G3I7Fzz2TaHBd8ci
X-Gm-Message-State: AOJu0YzzQ3CqhCdNIwQJk/eKmMqsyPHY2ykf4UPI4w5+e8K690kZGHG2
	NyK+aHmOZTcWNmAThfp9puCSiwIUyDhPnqv694hMQ8xArMoy8dsshuVHINtjQ6U=
X-Google-Smtp-Source: AGHT+IGhdJLTwm3ykzZLu9BaukJMGGo/4XttbvnV7nwt//z0Rmmt73MQF1z4dOhk61XgIiIrH0LNIQ==
X-Received: by 2002:a17:906:60f:b0:a3e:b8ac:288f with SMTP id s15-20020a170906060f00b00a3eb8ac288fmr3168446ejb.4.1708442904601;
        Tue, 20 Feb 2024 07:28:24 -0800 (PST)
Received: from [10.100.51.161] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id s13-20020a170906bc4d00b00a3e8b5df769sm2322738ejv.35.2024.02.20.07.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 07:28:24 -0800 (PST)
Message-ID: <1c6bb7d4-59bf-4887-8a0a-03373d3d9c11@suse.com>
Date: Tue, 20 Feb 2024 16:28:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kbuild: Use -fmin-function-alignment when available
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>
Cc: masahiroy@kernel.org, nathan@kernel.org, nicolas@fjasle.eu,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240215151642.8970-1-petr.pavlu@suse.com>
 <ZdON5rbsYFsoulxm@FVFF77S0Q05N>
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <ZdON5rbsYFsoulxm@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/19/24 18:20, Mark Rutland wrote:
> On Thu, Feb 15, 2024 at 04:16:42PM +0100, Petr Pavlu wrote:
>> GCC recently added option -fmin-function-alignment, which should appear
>> in GCC 14. Unlike -falign-functions, this option causes all functions to
>> be aligned at the specified value, including the cold ones.
>>
>> Detect availability of -fmin-function-alignment and use it instead of
>> -falign-functions when present. Introduce CC_HAS_SANE_FUNCTION_ALIGNMENT
>> and make the workarounds for the broken function alignment conditional
>> on this setting.
>>
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> 
> I don't have a GCC 14 build to play with, but this looks sound to me.
> 
> Petr, are you able to test an arm64 kernel with this and DYNAMIC_FTRACE
> enabled? i.e. build that, and check that function symbols are all aligned to 8
> bytes using objdump or similar? That way we could be pretty sure there's no
> other latent issue in this area.

I tested an arm64 kernel with DYNAMIC_FTRACE, in particular with
DYNAMIC_FTRACE_WITH_CALL_OPS=y. That is actually the primary motivation
for this patch. We ran in our environment into some incorrectly aligned
functions with this option despite the kernel workarounds. They were
reported as "Misaligned patch-site" warnings from ftrace_call_adjust().
I don't observe them anymore with -fmin-function-alignment in my tests.
Sorry, I should have mentioned this motivation in the commit message.

-- 
Thanks,
Petr


