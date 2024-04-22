Return-Path: <linux-kernel+bounces-153256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84A78ACB8E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB9B2850E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A22145FFB;
	Mon, 22 Apr 2024 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JkyRxydJ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14494145FF0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783623; cv=none; b=Qx7jaCABYHaEvHlKJB8LGLBmNjc7CYqGxepfISbKbhEIWPUurnCRG99ueoSLsieFEuSa2svGuZCpgtVJjwb0eKXMQ6wpl3SZRK12KTnqqRiYa4XkAnQI1oB6nhzzrlxggzQ8pryq6u7v6NnZZ3I0dQVxFoS74xhlbwNizNqFExQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783623; c=relaxed/simple;
	bh=FjXgJBEF9WQXIANP8LVzJtNEN6BMbLnvO3wgK9AhaTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ds0H8P57iUU2BIskkhiQ70OmJdl/kZGH9C6R8A1VeSC6udS+urA5IpMRiJwWnY6nFyJz6mQw7adry97xbHEvRmHjxW1q6wRfwCQIYOKu02zZBVAc3907UwJpi00Ouj9x3vWvRuB6Fpf5wAl9Co6D6ihV/8cflyWEUrBt6+DIUYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JkyRxydJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41a1d2a7b81so6364085e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 04:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713783619; x=1714388419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FS0KcORUvAeBrlI9AOGLQALewryArCeOzC98LMVpwS0=;
        b=JkyRxydJ5Q5JN1pIVJu/wMmAS1EThm7LE44WLmWpG42n9zTVfio+4kw34lWTVJLsIq
         UAgQvT/xpmVanQ6A3pJXiSNfsO12qIn+oevp++BX5Y/y2ew7G2qFls75Jr9oqTPy2YVF
         gTFULbXzedgUIrcRZuPwIsyM14V/JMC4IeL9q6C6zhc4i6LihtHVtggSWT4HgCr1SojK
         D+UJr87o0Aui8D5WienW+aahKhhCRRhR5OQJBtl30CzwpTFPB77nmMAWm4NduKZu29aB
         2bRGnAJsc+55rqo620N28AIKIdR5C5y0b/TA7fKhtOhUOqsPV9s29Nv1TOv3lgncOsFk
         DbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713783619; x=1714388419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FS0KcORUvAeBrlI9AOGLQALewryArCeOzC98LMVpwS0=;
        b=jp8vbPkuZTDQcO/m7rNihc9C9TLBd3AgLrUWLMbBEqVg2E5SnexFwUK3Z2ke1quxAQ
         0ST9IpWNEYqgdv5/HfSG9Axq8UB2ro6zWg664lpc1ylv05JBHZnmRqJr4xbc9lNWeFSa
         QkOjHlzZjIb7M6QmMTCdzcWSiSGxGM3Cqj91z7kn5dk5oTt9C1KBMaE9OdYzycD6tGCU
         CxabDgbxIGtBoifSFYRfRmshRuhm2F8QJ3VvjeisWuVsyiYWGKh21IKnjpXAIvIXNDB7
         5SePx9APGSFTjy98671uYXcEUytiK5psuPOnsINVHlsLVbBjqnLhiqtXVPARi4SQ7rfc
         gX7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXv64en/x7W3aHL2dLsFEK6TsnhqHU2+UhJ9p+DHiOP1h+Jc4ca7VO/8bhbdF1o+lDDvnV9XqX6Q7im5R60OsE/F3IQsOUIJMXHmkck
X-Gm-Message-State: AOJu0Yz/pqZ3s0llEuowhAZ6Ij/rb1/sUTGbWSYXTWWKtORDd7aPEZII
	6elFrqpYVESMte4piE9OAN029I96YGF/yOO5grwwZ924lQWrFVWM+cRueN+tiaE=
X-Google-Smtp-Source: AGHT+IFkEA8Af6G1A8h+g+qVarA3YDEDVSpc9LqxclrpHrv9AUo856Vt+U55sfyteuM5/+uB0yMz2w==
X-Received: by 2002:a05:600c:4f43:b0:41a:3369:61a3 with SMTP id m3-20020a05600c4f4300b0041a336961a3mr2871684wmq.5.1713783619161;
        Mon, 22 Apr 2024 04:00:19 -0700 (PDT)
Received: from [192.168.42.227] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b00418729383a4sm16125071wmq.46.2024.04.22.04.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 04:00:18 -0700 (PDT)
Message-ID: <7c1dda50-2155-4b3c-8a87-b8669b077b30@suse.com>
Date: Mon, 22 Apr 2024 13:00:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2023-52575: x86/srso: Fix SBPB enablement for
 spec_rstack_overflow=off
To: cve@kernel.org, linux-kernel@vger.kernel.org,
 linux-cve-announce@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Hocko <mhocko@suse.com>
References: <2024030256-CVE-2023-52575-34bf@gregkh>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <2024030256-CVE-2023-52575-34bf@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2.03.24 г. 23:00 ч., Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> x86/srso: Fix SBPB enablement for spec_rstack_overflow=off
> 
> If the user has requested no SRSO mitigation, other mitigations can use
> the lighter-weight SBPB instead of IBPB.
> 
> The Linux kernel CVE team has assigned CVE-2023-52575 to this issue.

I'd like to dispute this as this isn't a CVE but a mere performance 
optimization in case spec_rstack_overflow is disabled. Without this 
patch in case spec_rstack_overflow is disabled the kernel will simply 
use the heavier ibpb but that won't have effect on correctness.

> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Issue introduced in 5.10.189 with commit 8457fb5740b1 and fixed in 5.10.198 with commit ae806c74c063
> 	Issue introduced in 5.15.125 with commit 153f9a7b02d4 and fixed in 5.15.134 with commit 13ea4b92e875
> 	Issue introduced in 6.1.44 with commit 4f25355540ad and fixed in 6.1.56 with commit adbcec23c842
> 	Issue introduced in 6.5 with commit fb3bd914b3ec and fixed in 6.5.6 with commit e3cb8b2c391b
> 	Issue introduced in 6.5 with commit fb3bd914b3ec and fixed in 6.6 with commit 01b057b2f4cc
> 
> Please see https://www.kernel.org or a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2023-52575
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	arch/x86/kernel/cpu/bugs.c
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/ae806c74c0634b0c23855066d8ba28d850fd1260
> 	https://git.kernel.org/stable/c/13ea4b92e8759d2f6c330a73cde31ad9c313021b
> 	https://git.kernel.org/stable/c/adbcec23c8423e3d5df1839c5ae91599dcf703cb
> 	https://git.kernel.org/stable/c/e3cb8b2c391b1f287eb76df4ba37880f4ea56d8a
> 	https://git.kernel.org/stable/c/01b057b2f4cc2d905a0bd92195657dbd9a7005ab

