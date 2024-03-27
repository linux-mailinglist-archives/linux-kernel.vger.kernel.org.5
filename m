Return-Path: <linux-kernel+bounces-121578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD7488EB81
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42CE1B29B01
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9704612FB00;
	Wed, 27 Mar 2024 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AqFEAUAg"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C953D130A4C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555027; cv=none; b=KdxRpv180e0/S6G3rpLRpVAjzpEq2oCvlNHZ6cuL30UUwrtPndVUfXQiLxJlNNmywBZOtKa5iWj3J/GksdAE9btCWMgEPHvRl9LmZnu7Si/Id38VXnG+ZYmm1psOjxbxRRQO/8Qko3IZmB7djLxNZHr+SC+vwBituQ/O9EOA1IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555027; c=relaxed/simple;
	bh=xolD+KStM6h/UiYhVPWl/rlwdm70NGrlHVhiiIw3IFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8zRVPpsahlOGf/At5xSEYUSlEHvpfmGEziEoSQUFWRM0vifKN0X3BD+mKebau/UVm9doR4o0mX7Vr2H7NCfYy4PxY+l/OYBirQN/3DlIntKyXh3Bf23HbFG5KVMg0EHZECt7nV4c7w5OZL+bpZfnb5XN85RagEnCVzLxUO7gPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AqFEAUAg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34175878e3cso4958655f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711555023; x=1712159823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9RZc0Oa6GSoT+Kr5s8/A3SHBWT32jBMU5zycY9Q3gRs=;
        b=AqFEAUAg66OUCs4cvNCII+1BXiKdoqKW+IocND8dKdLVxBKb2jl6Xi4c4SyKiltTJo
         h8OlMJTLUepTzlcFbBY3mwFCWlhfk9zpUeK5jmqG45l+FsVcbXjn17IFVPsCuQUySXjC
         sHJFcuoLGs1ajVhaSq1gXP6fsNp+EoFbobYOCIlmCxp+XaCPFU/mEC4xslfYlzN8dLLI
         2z+R24xeb6FvNJZniDeEq3wG3MhaTzgfXIY6orDDofB6VcvRRGWAzNZeUe7jPZ9fUMQC
         QzEfYEzL/fxHF85rvvHyYbdh/VtwSPgDgmRTg8ln9Bk2JKaWCF74BJTq2bKvEmOAcmO1
         cMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555023; x=1712159823;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9RZc0Oa6GSoT+Kr5s8/A3SHBWT32jBMU5zycY9Q3gRs=;
        b=VX0gFNo+mxfAbzZrW5cJUQxYhExA4O0fxKWth8Jbblp4lW10HvfVhMC1vvn5yu/ucX
         IL8eiFlatQBqv3WaKFtj2i7z+HhWxDiNpRNm3wfl5GxLYDla8EZJpsw+Z/GXnG5h1xRk
         oDehp7pt9sbP5CzlSy4NEsnaKyvWsLptD7Cealw3omvbPe4GTTHSN9DqUwJ5GbinDZVK
         uS4dHRsQgkyWPdoGltnc12ydwWcTu0uqCMQbpsZ/G0LzL67J0XH5MxoddDZ/UlvbOuKd
         HmhxiGRnfO8jG7AlyBKeM0FIFe/heDZO3a2U/jH+Asg+N02NxfdGMzwFCUHF3NEWYgRh
         oGwA==
X-Gm-Message-State: AOJu0YwI7HOb+qjwrfD5DM3o1oYR7WPkgRgw+aa0jU0yMuM9IM4P2brE
	A0/VbVHWz41kXvrHXbsKY5MC4bitHheJ9JQQPj+i6k2cjk90+o5YU9pHGTis1j8=
X-Google-Smtp-Source: AGHT+IGs2esijcve1nRhIVXtWvFzpZT8RBRfuKIIZL72paxU0tXDteZDw9GkTgvgK4Lg2nhkK5RElA==
X-Received: by 2002:adf:f78e:0:b0:33e:c7e7:cc6 with SMTP id q14-20020adff78e000000b0033ec7e70cc6mr246826wrp.2.1711555023034;
        Wed, 27 Mar 2024 08:57:03 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:73fa:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:73fa:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id x3-20020adfcc03000000b0033e41e1ad93sm15104926wrh.57.2024.03.27.08.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 08:57:02 -0700 (PDT)
Message-ID: <540c12cb-f42d-469d-b3de-a52155298dda@suse.com>
Date: Wed, 27 Mar 2024 17:57:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] x86/alternatives: Catch late X86_FEATURE modifiers
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, KVM <kvm@vger.kernel.org>,
 Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Michael Roth <michael.roth@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
References: <20240327154317.29909-1-bp@alien8.de>
 <20240327154317.29909-3-bp@alien8.de>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240327154317.29909-3-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27.03.24 г. 17:43 ч., Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> After alternatives have been patched, changes to the X86_FEATURE flags
> won't take effect and could potentially even be wrong.
> 
> Warn about it.
> 
> This is something which has been long overdue.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

nit: While cleaning this bit mind if you also switch 
alternatives_patched to a bool?



