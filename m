Return-Path: <linux-kernel+bounces-105768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2782487E408
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE21D2815CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F6F225D4;
	Mon, 18 Mar 2024 07:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YTtGYkZr"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C65224CE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710746587; cv=none; b=ffHjAHeZ5YjBt8eUkpyqwdhUd2DC5t4g46m2pgDJXJOll2Bf0ixvmXfDpTS8wUr4UkNCZ3YlqSKtE7tYx8PzjMsE7yrz5yXPnPfTUyrtpsCG0Uz0bQD4hdHl+W0Hlqrm4VPXdwItNXYRYPyi/NlLdclyU1OndWzULD/sv0ZuTh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710746587; c=relaxed/simple;
	bh=xp9STLfI/VgEupEHLT1X7kTuOfhJvB+d2alWxqds6Hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2tkOrWudcjjWA2+vIU6OOpfuqKk/qrkNXDkj+mEZVSNAGf2nZXaPdIJcf9h6ZBNHeDnZpQB+SlSGiTsti+axNVehsa0yC5tsE83KVUgLqbhKjOzIDS0pZdLSkDPyitXTFTN8pDaL4QdsBopJbuU0s1ntgwXkzlnBkgsBN6VEXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YTtGYkZr; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-568aa282ccdso3555711a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 00:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710746584; x=1711351384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2+xmiNT0HV1PrVIMTOkvVdPBI7GhnHCBaeppqG3Ayo=;
        b=YTtGYkZrvOW+Ev19SIJe4lMsLfEofb6a09Z7Slf82IZPmlQWGVF8suQJ57+9rlux4A
         ym/Mehx66X9ABEQ6BPvJAerWpnB+iyaJc3wqWdcrUSxgAu9uDL2cGrRBHG7OIYSRlprH
         lfoieN1aKZ4k68dkntwOjol3OfwXMTvgJEcf3DwUScdcmlxua6Um6YYyOEuHWK/7GZVG
         +UcW/VdsALLwbuMKiGoE9dON6lFwfuVTSmkijlcHIDoAa0yN/GJcWsjtObS+Efh8i3pJ
         5o7DzQZWpCtnysAfYlW+BrZST+s5I0pZUUv+tBr0XZKVcK+MdjqjQYBbSlumRzVVxId4
         UGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710746584; x=1711351384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2+xmiNT0HV1PrVIMTOkvVdPBI7GhnHCBaeppqG3Ayo=;
        b=Clqst1C36hqaYVaCP7ENxTAMmmZkC/pmqpe/zSDLUcIMq6b2UhgvfenihGjZYi+55E
         aWHiRaHoi8OMKyHvFUchEDZIpo1RHlWTIlSlM3NdYCQWj/grvPTHg4HzSfb3foSk3fnW
         oaOwju1I0S9GfshKOYIhD3hC1qBh1KfoRRrP/llYFUkLgMxA4YPHMcWFDlZmOqIhhR2h
         BYai2LIu98z5v1KHsOStxuW0NLszPQaO7smuryY1wLDFuzROjvbJcGY4E91TFkVx4Be3
         Iftok7gExgtgm9QUtllmING3O9wrGvqBXjrZboF+kXD67GSwVlNlneE6daa9guQz8x3V
         uQbA==
X-Forwarded-Encrypted: i=1; AJvYcCXY1Dm/iaZiv5yWomoa+gc4e1xKbGZtZz72rkBVoIFwFk9m/ciAM0KRBBxoKHK2rUdBtX9AtfAu6+S/3mFY3IcU9j1GEGo7qEIXZPA4
X-Gm-Message-State: AOJu0YyqMxctG4qNWGQGgSySWDtFbmxaEm3auXFHfnp1gXC4tkwGt/1o
	BRXE/X4+G2wG8pVCYIEIhEtwRubCaObaqz+DEAHom5nMCoDSYtLCgUd3MTl7XOc=
X-Google-Smtp-Source: AGHT+IG/FvP8FIPkOAjy1Sqh3yrjW0+6MsrVrNKO/gQxWJLTWjYkr4kGMhpQK7lOhCNJSTLGPpmMag==
X-Received: by 2002:a17:907:7a93:b0:a46:74fe:904f with SMTP id mm19-20020a1709077a9300b00a4674fe904fmr8405153ejc.26.1710746583937;
        Mon, 18 Mar 2024 00:23:03 -0700 (PDT)
Received: from ?IPV6:2003:e5:873a:400:704b:6dbb:e7c0:786e? (p200300e5873a0400704b6dbbe7c0786e.dip0.t-ipconnect.de. [2003:e5:873a:400:704b:6dbb:e7c0:786e])
        by smtp.gmail.com with ESMTPSA id wg8-20020a17090705c800b00a46cc48ab13sm218367ejb.62.2024.03.18.00.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 00:23:03 -0700 (PDT)
Message-ID: <acb094b7-15b5-4a77-b461-a938f9d7e9e0@suse.com>
Date: Mon, 18 Mar 2024 08:23:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] x86: Rename __{start,end}_init_task to
 __{start,end}_init_stack
Content-Language: en-US
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-arch@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 boris.ostrovsky@oracle.com, arnd@arndb.de
References: <20240318071429.910454-1-xin@zytor.com>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240318071429.910454-1-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.03.24 08:14, Xin Li (Intel) wrote:
> The stack of a task has been separated from the memory of a task_struct
> struture for a long time on x86, as a result __{start,end}_init_task no
> longer mark the start and end of the init_task structure, but its stack
> only.
> 
> Rename __{start,end}_init_task to __{start,end}_init_stack.
> 
> Note other architectures are not affected because __{start,end}_init_task
> are used on x86 only.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen


