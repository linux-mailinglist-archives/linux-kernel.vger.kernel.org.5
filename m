Return-Path: <linux-kernel+bounces-139844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 323A88A0860
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1BBA281B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDC713CAAB;
	Thu, 11 Apr 2024 06:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dzW72Wsx"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3813BAD2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816523; cv=none; b=pqCnzGxTtf9QTdGwAsUHd5OgWJsGPgM+WkV0cX+vy9HhcqpbKRYxlXvUKjYBzIUR47nTPTazCvVzWnFG1TwmzTJJgO9NE/7B7krCPB4d6VNaDf9tcJJIJ2BmUxJWDpIjXJTYLCAoYN+jfLRlnqL9l/D/rxit8cUeSgirA5nsMVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816523; c=relaxed/simple;
	bh=PBzyNksFSNuNnUYKqfjQOwCmkAQgPjAAra8q+zT/2l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2cGH+bsjhubMn0DqvftMgOpl3dl6uXvOU9UGMC+5vORC3nzZQkk0oCmEOrRsfmZraYJvnAPZrcdeo9X0nUpffRpuOdSw24OCEsosxTQnVm0iAETysZadHWef5YiiFnXCx4gHjl/k3dBq8EDhCaFzgu1Y+GOo+C3C4Hd4Je9+jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dzW72Wsx; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so906089a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712816519; x=1713421319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8G6Rjn9b4ReWAC7Uawtf9NLLRkerqy1UCYOYjVg3P5c=;
        b=dzW72Wsxk4gUTO2brY0KBFwJHu8RexOuvA0/elrKBThRveRtnF8ZXo6jkd2JWHUC1/
         Sd2f9ZiRhS5yPiJvkFUawjHKiJ7rLo6lQGwszvZjb0YC50BiABrJdzvYIJqmKCaRmvnV
         oA3Y6qwB9QgumKiXMXaefaU45u14t2UglEcWZb42tS+HR664Mr5Dyxb+/oAuQOUDFl3n
         iXETIbWAIzZgZu/42Uaq3SwMpEw39X9JWmFargtxhjpehJiQGDHTC7CZZqDgDJvlBbv0
         V8yVRpnwNKBP4ypk9V4YkG2GV+R08ez+BZid4XYk1/RRJFJPLZVXJUlr5SnsDbUdIotm
         AbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712816519; x=1713421319;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8G6Rjn9b4ReWAC7Uawtf9NLLRkerqy1UCYOYjVg3P5c=;
        b=G5Yham2Rjl8u6t49i6OaN8NGrccgpMeaWJsrsNcbYAcuyqYAT4ZHWoc0m/7zwN6GGt
         8lGWGFBWzBN4fdqawecKEmS/Q+fEHZqnXmrHVkQmYGIv7mBxK/UbVgq/RM21M6aPMaBe
         BxmOHSuD49EUNCcZgTb3GefOSFESM1HEk3UCHf2BTHpMQ+BRjUXhfXKPQkeRxPQVqDru
         RuNJbTh1cfYYj6QeaDaJ7ohWBMjNRuDMsxKz8W9xPTbmwT6fOup9+LMZq95VY5fa/HbQ
         6Ul3fOOr4oB25dM3b7QNPy90UdQEXCR+fqQhn24pakgZxnSiVlau0y3TASkF+RYiNCSY
         FyJw==
X-Gm-Message-State: AOJu0YxbyQ0tTZOrmtUWe5yBiZTAqf1cyABeH/5Jm6YJDtG9nnYcSpJr
	T2T/aYB6Md4zSV//oiCU8rRUBYQeJIvxYDPB8aLCwmHf/Dl+ASUngjxzNN8MKug=
X-Google-Smtp-Source: AGHT+IHyelk9D8gAJw8FtVuRViKtUY7+Cj+kTLYF4t5QjR4EtjQZY5XfAhjfuey0Fj2dPUasbETPEw==
X-Received: by 2002:a17:906:37c7:b0:a51:ab81:6062 with SMTP id o7-20020a17090637c700b00a51ab816062mr1283794ejc.30.1712816519658;
        Wed, 10 Apr 2024 23:21:59 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7318:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7318:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id qf4-20020a1709077f0400b00a51e5813f4fsm434690ejc.19.2024.04.10.23.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 23:21:59 -0700 (PDT)
Message-ID: <d3d73612-6631-45a5-ac86-3b7e9156e9d3@suse.com>
Date: Thu, 11 Apr 2024 09:21:58 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] x86/bugs: BHI documentation fixes
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
 Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>
References: <cover.1712813475.git.jpoimboe@kernel.org>
 <8c84f7451bfe0dd08543c6082a383f390d4aa7e2.1712813475.git.jpoimboe@kernel.org>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <8c84f7451bfe0dd08543c6082a383f390d4aa7e2.1712813475.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11.04.24 г. 8:40 ч., Josh Poimboeuf wrote:
> Fix up some inaccuracies in the BHI documentation.
> 
> Fixes: ec9404e40e8f ("x86/bhi: Add BHI mitigation knob")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

