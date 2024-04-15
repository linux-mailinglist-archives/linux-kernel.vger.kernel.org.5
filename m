Return-Path: <linux-kernel+bounces-144686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D708A4936
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450861F21B25
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF4C2C848;
	Mon, 15 Apr 2024 07:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AV4jC0iz"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481382C69B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166732; cv=none; b=GGp+iVj3605uXFKq5yVLBimijCI+FMTE+KqqAlV6XvtV0QwkaLaDN7hWysI2pt9JHAMtcPjdGHR4o8hOiuoO+wkAv8fUCaaXDaaTx/ojcde1Zel2OEPAusidSQjlrx7pYYvfmu7Swsc+hbhUyEVJcNAwbPECDjcMfUDQFrUYv9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166732; c=relaxed/simple;
	bh=kvTJ3NCcw5TZDtos9qNzPPDoMD5I2V9e4WWSFMcPVC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xo6Q4KXQF2/XggKRj67QrZNEWukwlGRXj5VNf6Rk2Gc+MhuMr8aUx3gZsPtDJ8tc7VrVgCtG4XaaeqYXSv/sRL8N8Bgl+xp33ZK+E8bnl/CkDlJM+Tq+gNY7qqOfAR4xHV7awmXr7CoaZfSdo9jfq2CDKP86eMif8liOvy7IHCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AV4jC0iz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-416c4767b07so15876385e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 00:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713166728; x=1713771528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9LXj1zZW5K+QLp2gYiuCSv1Ulk6cDGBlKYS+XMmbg0=;
        b=AV4jC0izWjXmjvUt4WzUPu1InX+3x353RdFfwYvehYUQZt3n1Nm+MHIJ5Ug8VAjebe
         jJKD3t+IOc5CoId/eifRXffnxQk2RvFW2ifVnhVmLWfZ2bfiayg+eQA/+nZWSCGzmfyt
         KPGv+dlGjdaHJ1qE74UcAS+rSIxSGRw+IPqdJZUiD5VS/zkbfHFHSpqk+/+Ultz+mw5/
         LE2t/zVSESRVB6v69psAMvNsioSur+8u6MQoyP82YiaNKkX0n5zJc+aaOLfvjGukuzG3
         mqsPThjjK0/UcRECW2qTqfllzjLXeyZ1yxlVMY10tVGQWncIj8D72ttu1p9s1Tfd7GgN
         pUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713166728; x=1713771528;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9LXj1zZW5K+QLp2gYiuCSv1Ulk6cDGBlKYS+XMmbg0=;
        b=mGnxumI6Y5mSGaiZqFoy2wF2V/RU+Uqcjk+i/JTxN+7K1U8t3Hq1eielA4I+vyH0aN
         zR7MucBs6dowRpIvEgThh2j9v08ZDmsDgy0K5upO4U3dHE1gbDIcl6bu3DleGSTVXdS/
         RZgveXlm1yLX6FqtLHOQlVDZrIg0Apc/PeqbBHkqKRa/nDXdgoJ23JLRnm40Hkqf8+6E
         j5fGyP0p1jkpRCG+sBnULr3KHkNMJK6tSnjf9jrkAC5KEJnf4il8jIQAHjd++hGetpDc
         YhAcpEphUPbbWT8xYA2qWpE68i6BezVzS0H2ZI0tH9GoTBTaJh3P+CXl7HgDa5cx3X/5
         MCsQ==
X-Gm-Message-State: AOJu0YxSqrYjN9GtxraMd5qnyowhFMS0Z4Wtm8PysaYCtVUe02VgrSqS
	+4WtukZwB/RgtwgodwsaqGah2v6PqrBanAfk5es2YYgY9QbIhtMH+RF1Dvv3g1tiM8B4y29IOgm
	GL4+pMA==
X-Google-Smtp-Source: AGHT+IEp1EsFbOlIOsDD8y0Ud0XPcwtSEZA1D4fs3LMk02Cz8xYWCdrmRhShOMUfvnvAThHxe+fFZg==
X-Received: by 2002:a17:907:2d93:b0:a51:dd18:bd20 with SMTP id gt19-20020a1709072d9300b00a51dd18bd20mr8286185ejc.14.1713166325058;
        Mon, 15 Apr 2024 00:32:05 -0700 (PDT)
Received: from [10.20.0.196] (ivokam.ddns.nbis.net. [109.121.139.111])
        by smtp.gmail.com with ESMTPSA id lo17-20020a170906fa1100b00a466af74ef2sm5070111ejb.2.2024.04.15.00.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 00:32:04 -0700 (PDT)
Message-ID: <8aee08a9-0d7a-4b5f-aee1-c70bad9433ca@suse.com>
Date: Mon, 15 Apr 2024 10:32:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] x86/bugs: Only harden syscalls when needed
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Christopherson <seanjc@google.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, KP Singh <kpsingh@kernel.org>,
 Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>
References: <cover.1712944776.git.jpoimboe@kernel.org>
 <079f24edefb5b47e922c2804f199463e04ccf0c8.1712944776.git.jpoimboe@kernel.org>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <079f24edefb5b47e922c2804f199463e04ccf0c8.1712944776.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12.04.24 г. 21:10 ч., Josh Poimboeuf wrote:
> Syscall hardening (i.e., converting the syscall indirect branch to a
> series of direct branches) may cause performance regressions in certain
> scenarios.  Only use the syscall hardening when indirect branches are
> considered unsafe.
>
> Fixes: 1e3ad78334a6 ("x86/syscall: Don't force use of indirect calls for system calls")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   arch/x86/entry/common.c            | 15 ++++++++++++---
>   arch/x86/entry/syscall_32.c        | 11 +----------
>   arch/x86/entry/syscall_64.c        |  6 ------
>   arch/x86/entry/syscall_x32.c       |  7 ++++++-
>   arch/x86/include/asm/cpufeatures.h |  1 +
>   arch/x86/include/asm/syscall.h     |  8 +++++++-
>   arch/x86/kernel/cpu/bugs.c         | 31 +++++++++++++++++++++++++++++-
>   7 files changed, 57 insertions(+), 22 deletions(-)
>

To ask again, what do we gain by having this syscall hardening at the 
same time as the always on BHB scrubbing sequence?


