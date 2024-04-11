Return-Path: <linux-kernel+bounces-139845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AE18A0861
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F201C2328B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0178E13CAAB;
	Thu, 11 Apr 2024 06:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b2fPo4/Q"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3822613CA86
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816536; cv=none; b=fq1aMoQyy8LCZkgsZcPKwFsH1Bkb0M6AyZclAfWITGGw4o9c8EYjbDeglsk6mZOdbI5j1nwx4OEqpdqYG0zzNPx32p4JdJP3M0CZtmlnp1StSy4WKuFei3K3ulf9KmgsF7ASWNdsTsYeqUZH05Rz9JNQJ0YGQZ4la1lMqNDenxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816536; c=relaxed/simple;
	bh=61mGfleN9b9hdGxn+KoWtdZ07L8Dqx7oPBIXuPLrCAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7z+QaQNJqTXXB6CQTatUfafIIivSBfQ950dKLglQ0MCPubLVqK0euMSvgkuqSeG4SVi6/I3XFXNmcgrX4lob5X9Rouu1nEthU0TtwCkJZLok6jfgF/cacyUzwG3MWHGbzeRe8b0ypXwjM6WcMZn0nh71aQXKK/UwodHLnI9QII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b2fPo4/Q; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e346224bdso5575667a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712816532; x=1713421332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QlIgB0jwM0VnB5Ngxou2lnVrqnfVxHRzX+mAfelLC68=;
        b=b2fPo4/Qa7krzVqS4WRzR7NFitr9nFlDzZ7PsaJU0HNOgSiz6iq4aUufPkdhPTMigR
         pE5SUBXYZNjzxkRQ4/j+ly2dELqj6IApYvfrGA0/kfVH/hZyp7jyw3kTiWH+jT6c0KHY
         yYj0NN4n0+i8xonGC7Fqb2wAQVF4jY4tYDPUhtQiFHXjaCgs/l249Nv7ESAkWF3UV+jm
         7aScnPPYJMVe7HF6IVEdj1MwFUPbxmyO6419ZIdzrEBnn65/qNXXPDycZIkncCPVl4LC
         XBfN9+Ot41c1EE26UCXl2MANQ/qLNGsHTGdQwXQ861B6GvowhEfkZ9KrTN4QFwJ6qfXm
         GfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712816532; x=1713421332;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlIgB0jwM0VnB5Ngxou2lnVrqnfVxHRzX+mAfelLC68=;
        b=c7a1Az/sVymNdPQAvfbQFQfHbl1/FJMjvw0tuhkvgmAsWBSFYILDczVRK1jQ7mcDYp
         i9/3l2/9yBUs5mY0oNwctSKzz/TBRFKhdX30ieU5h8KKsbuOPXMYJ5vqr6GNwJ2aJWd6
         RayGOv6LNWTvcQc/TtDw4q/5MGZpCZXztXfggKYCOuttMRs0PNgKs79dbQhWRJAp2vXJ
         QwofECjV3p5VtdtCajktky8u6wEOzO6hAp/UG8GAESTegybxEdBaJmQIbkIWXeUrC2nu
         u1exQupBR9hvwrVOZpTtBchXgg3rco/tFwssUdOwiuJHr9+DOOVU+aK/0L+M7PsVq3Qw
         hXQA==
X-Gm-Message-State: AOJu0YzoD+OShWK4rSs6QlctVVqGcj3Yks37APJZcBG6GGQmyfBtpJki
	02YOthmabLPxcGhuACY4cThnhekynSCtq9g6AZmhC0E8hQSruJhigum19qUnBmI=
X-Google-Smtp-Source: AGHT+IEAenA7yd2kGnXDACPFOEtrBjmVBy2YdIB5KbdySPiAvj+dRhKBXWVaWUR4fdImNSNM9s/H0w==
X-Received: by 2002:a50:bae5:0:b0:56d:f637:451c with SMTP id x92-20020a50bae5000000b0056df637451cmr2639331ede.32.1712816532469;
        Wed, 10 Apr 2024 23:22:12 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7318:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7318:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id x12-20020aa7d6cc000000b0056ddcbd9362sm378247edr.51.2024.04.10.23.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 23:22:12 -0700 (PDT)
Message-ID: <0503ff9b-afb7-43a5-b9eb-f6c9d9945638@suse.com>
Date: Thu, 11 Apr 2024 09:22:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] x86/bugs: Cache the value of
 MSR_IA32_ARCH_CAPABILITIES
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
 <9592a18a814368e75f8f4b9d74d3883aa4fd1eaf.1712813475.git.jpoimboe@kernel.org>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <9592a18a814368e75f8f4b9d74d3883aa4fd1eaf.1712813475.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11.04.24 г. 8:40 ч., Josh Poimboeuf wrote:
> There's no need to keep reading MSR_IA32_ARCH_CAPABILITIES over and
> over.  It's even read in the BHI sysfs function which is a big no-no.
> Just read it once and cache it.
> 
> Fixes: ec9404e40e8f ("x86/bhi: Add BHI mitigation knob")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

