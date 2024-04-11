Return-Path: <linux-kernel+bounces-139842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7828A085C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 320BEB2761E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF0313CAB6;
	Thu, 11 Apr 2024 06:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MGGPnBiy"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4076B13CA86
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816423; cv=none; b=tRkDGiFx3JbqGfWlYOgkq5rLxMOWBPe2+Hld662SaUwlRMnI0AtLasN18+/McHlpR5P02Q5dKKsA0L9AlQLh/cssGz+Bs7RPJotOtivLzfX/KBrBYvmrvKzjYpKm3oRdt7z3jRgbOy7/h2jH8hy1eQkILCnNZBoYO3QNqjBh6hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816423; c=relaxed/simple;
	bh=4E9nCHNffxR2+QM+tntAMl/6SpLgXHF9LHCxNL3c5W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLvLxPa2JMRSfSGZTWC+eCvGEywPYoi9YLPg7qoMrlpCAVw39RQR6BY7jd58vYj+boioPgvx3j2CEaJ6rhu9IWyDMQIb2FgQCpsXw+KakldOwMfBUaLmJ2j82XNIrM9YIVUyZCCWqEYdNWHqoFP3wzaTbtDC3cstV81YKJ3alPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MGGPnBiy; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51c37a5025so578941866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712816419; x=1713421219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A89IGGcl431itke/md5mLStQg1lZ/5nB3UO/d4l9XKs=;
        b=MGGPnBiy2DhGXU2OKN/YDT6yZmeU7i19tKOnufd7OhQkFFiW+rNEcL9LFa2PpcQB+e
         Dg1GgrfCJZlSL4nKwdDRY5v0Ft0s5U63YhuMqmsA1d4z2TOgQFQZMdYUk7aIg0GTGoK9
         u1PlUGV6KGF7ooqzl7T0+ifsGMckyD8XlnQBwZ09ZsfpV3vng4jLD89NxtCY/ukdp3R4
         Yex8vF21hin91vEmQbRLrbVKzszbjZL5BBhpWp2gwZhVR9WVfyF09JJfLU7/I9DN4EEg
         n4uY+ja+8H2u/Xn93x8IYGGEHyoqA8UQ2LSIny5V82lDuB4joHrMAHrBpKFSbCNLCswc
         NVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712816419; x=1713421219;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A89IGGcl431itke/md5mLStQg1lZ/5nB3UO/d4l9XKs=;
        b=ud0Ig8q+f7wJxu9+4opFl4sO9kjLyNr+Fqj6B1Tp+HBiYuMd+LSoR9wTMtARgtH/6t
         WKjcTKP80kEoJvGYycrj4vr+sDFWyFOZAVZywJyaa7FpChQZupvL8lYYQKAxCceVmr6H
         /fv2OndD4lnS49CDJ3QhKbcsvBg9Qjxvla0ZV4pgsFjwmKRy/VxVWPdpRc7A4Rpies5o
         UWb4Q9idqTAfh6WQJUVlQWhepfQvUi0fQ0tI/HikcEqhWGNm6xBYy+mx2xOOUh8jmxUp
         cTbtEDxjI55OXhmhmo0r7OBOq5hgUJV5Sefzdei8D+oCj6jiaqXhz101Wl139cz18KLY
         6nPQ==
X-Gm-Message-State: AOJu0Yzj706BT927M6V5AQYygYgfQFYKnWztB/YKI0p79A3UvwkAyf5/
	D+MudEqnYcc0/wWgJjjXYCtunMOgESrNapx08x6ncpunPNB9xaoG6AreNUewtR4=
X-Google-Smtp-Source: AGHT+IFfVodLBWs24sVSji5lUGYGp8n4EQzNTd3JsLa3PrZgLjzs4ndSXlvDQMf0c2HIaJzwDsGb1w==
X-Received: by 2002:a17:907:72c9:b0:a51:aed0:cbc with SMTP id du9-20020a17090772c900b00a51aed00cbcmr3305674ejc.15.1712816419494;
        Wed, 10 Apr 2024 23:20:19 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7318:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7318:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id t2-20020a1709064f0200b00a51dd500071sm423595eju.169.2024.04.10.23.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 23:20:19 -0700 (PDT)
Message-ID: <124f4871-1275-47af-b513-297b870708b2@suse.com>
Date: Thu, 11 Apr 2024 09:20:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] x86/bugs: Only harden syscalls when needed
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
 <97befd7c1e008797734dee05181c49056ff6de57.1712813475.git.jpoimboe@kernel.org>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <97befd7c1e008797734dee05181c49056ff6de57.1712813475.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11.04.24 г. 8:40 ч., Josh Poimboeuf wrote:
> Syscall hardening (i.e., converting the syscall indirect branch to a
> series of direct branches) may cause performance regressions in certain
> scenarios.  Only use the syscall hardening when indirect branches are
> considered unsafe.
> 
> Fixes: 1e3ad78334a6 ("x86/syscall: Don't force use of indirect calls for system calls")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Why fiddle with syscall mechanism if the bhb scrubbing sequence 
mitigates bhb? AFAIU (correct me if I'm wrong) the original idea was to 
have use syscall hardening instead of the BHB sequence but since it 
became clear that's not sufficient bhb scrubbing completely subsumes the 
direct branch approach in the syscall handler?

<snip>

