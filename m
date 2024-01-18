Return-Path: <linux-kernel+bounces-30372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F3F831DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9011F25E63
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C3A2D033;
	Thu, 18 Jan 2024 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YE+59htC"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE362D02A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596754; cv=none; b=Y9CjUhtqdAfyKXoZQwBvh6MCkDGBj55Xu4VMPTDG9MqJr5R/L6Ze79NRxi+gGdL6adBqFfjMQOV0mgSVrqFdfW2BnnDNb4sT742Z5K0A/w0ELFrlt9OPxPKkJ6VUEKXoeg8+4jCG3Nw4J7UTcGrTWTDn9cj30bZ3Yy6SzkJPW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596754; c=relaxed/simple;
	bh=Tib9qmRhyTIuOuk9z3JFvHx/L/hQYWeGELswdZbwgaM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=G+BbZOiG8Dw7KgbtoFUdbQESgYlCQP/Ezpzk4vY9k3EefrPjUSJMjumZMoYL0MhPi12Vdl9O0tOSEKq+hJ5RoqzsIMEGC35Zzf+fd/sYigjnOaoh0/goLrKQhS4eVMYEqDy9EBhyiS4F2meIgTerhn7HCKDtsIKe2+A/F14JNZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YE+59htC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-337b583453bso2754140f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 08:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705596751; x=1706201551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pBTbJBhUXoCD9RPj5M/LGF6UDaJgZ8Ej94kU5beb7Pc=;
        b=YE+59htCkZ0+IMj/qqg4rfWmSYOH9kSUyy0VQmPbfskbybfmqs2Rk14Ry93IjJvyuJ
         MxcHsa8k2NdzYecVXlTHCrsBWO4+T0ICiV3GitgkIqvaYtalEujGrG/0tkNmlfvMS21q
         A2Vg2kvxovrllhBTNaWCrBwjOTJjYBe5PcoGq7O8T2Inbi8I12UP3y15F1jHLbJxNxWN
         48OzQmcWVc5dKEgrjtl9IIAKLnrQR4vZ7zaP0jbDr4aZfAgwilcDt7AgLWi1f4IC2u2C
         l7q6dHzObdiVVShfA4FOujNPjeQc4GH8843HhSZNVaihIJZHZz34q26oePJsAoa6sX/U
         EEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705596751; x=1706201551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBTbJBhUXoCD9RPj5M/LGF6UDaJgZ8Ej94kU5beb7Pc=;
        b=YCMWXfPjfcz4qE3KpNOB8QDwNIXFExYNF12hoGC51wBCLiU/y3pwqbFj6h0tTWOFOy
         V1X7bj9SR8DvPwv3U5blXc832VROsfLKgHx06774PV7cFBP5hhaxD6QbPBcN+H/AGaFm
         9oH7kW248rrIuemBnt98Vtv2wl4cRZOf85ibe+tagCK5oXhVgqxqSfioKu8urKC9dX3E
         p9c7lELOATrSAWlnX3nCf1ixxZHfxoCczyuaFqppgVV/xmjRUWstNw9hpoQf37/BPkQh
         0CQgSjsdH5DwA7XgSXAUkhW7qlgtIyNzYcTTQAXmqCCeixudOSHaShEsB9aKJ5QCJBO6
         dM9g==
X-Gm-Message-State: AOJu0YxE5W7enRgkbg1Jk4tXebHn6bTny0ID5Qps5RyxaLbWy4k4LxCz
	hkngR9W5s7sNHgRGuqJO1pJsK5ksDYTjgrix3ZC7iRHrILyb5G6tPmzYHvV9Iz9akFn2V4aSiw6
	c
X-Google-Smtp-Source: AGHT+IGh5ZvDe3gCVOWGIfyMG1xq3HdpeekqSJAyaIEgwsHWK1sTT8bEBej/MEPqeVRYsSh1YjMfJg==
X-Received: by 2002:a05:600c:32a7:b0:40e:48aa:c444 with SMTP id t39-20020a05600c32a700b0040e48aac444mr421547wmp.213.1705596751156;
        Thu, 18 Jan 2024 08:52:31 -0800 (PST)
Received: from ?IPV6:2a10:bac0:b000:7588:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7588:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id cn25-20020a0564020cb900b00559c8520f6bsm2905588edb.75.2024.01.18.08.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 08:52:30 -0800 (PST)
Message-ID: <52fab554-b23e-49b7-b0d7-2340784b8732@suse.com>
Date: Thu, 18 Jan 2024 18:52:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Remove reference to syscall trampoline in PTI
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>
Cc: tglx@linutronix.de, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231102130204.41043-1-nik.borisov@suse.com>
 <dd0e864d-295a-4edc-bfd7-ad5de88d7a0c@suse.com> <87edee1v0i.fsf@meer.lwn.net>
 <20240118164108.GIZalUpEnj2HT-9ix6@fat_crate.local>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240118164108.GIZalUpEnj2HT-9ix6@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18.01.24 г. 18:41 ч., Borislav Petkov wrote:
> On Thu, Jan 18, 2024 at 09:11:41AM -0700, Jonathan Corbet wrote:
>>> Ping
>>
>> Hmm...this has indeed languished for a while.  I was waiting for an ack
>> from x86land, but I guess I'll just apply it unless somebody screams.
> 
> https://lore.kernel.org/all/170238995160.398.1051285467012003027.tip-bot2@tip-bot2
> 
> Jon wasn't CCed but Nik was.
> 
> Nik, you missed that tip-bot2 mail or you don't have it?
> 


Ah, I must have missed it. Sorry for the noise...

