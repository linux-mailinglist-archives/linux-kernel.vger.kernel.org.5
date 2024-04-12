Return-Path: <linux-kernel+bounces-142491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 528BB8A2C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073FF284A08
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65B353815;
	Fri, 12 Apr 2024 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="iOXyIG1O"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0904A29
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917500; cv=none; b=tOC+AhoZLf4KmG5Uhc/n8ebYhdD6iNMllmB606tZbF0Q1efu+XrYWssjo584qkiV1pWi5U0/VI09qOjm9z/Yi8kZT2smW4TEhzbXT/eUinfMmX8vW2wdsyK6DHHtNAAJ1leIcymElyONn/o/1lp5CDlRZ6SN1szN54PCSsta8yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917500; c=relaxed/simple;
	bh=mTije8i7p8SYTaRp24DV1G8IgwrSNJqgcNiym+vSaCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmy8ygGvlOgRCr/2oIoecd0fNCnTTH4yjKJln0BlyRFJGtL6c1ezXEuvSP6x1P54TPw/uWcdtadm55hEAAGy1/1Z2KgzoIEgqCImWuDJ623x3x8+Vm9PfPsk5Arg19uc5IOXHPLlvB7kjjMdMfiWFafVa1LbKddHcPCMfHmPQ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=iOXyIG1O; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78ec0d2e1e9so32772785a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1712917497; x=1713522297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yXjVQsLqyM7W96iPN2njoIot7m3tPecpIfZcOMPHqes=;
        b=iOXyIG1OHyqnAZaQ/p7AXXNqRpnsnQ9ivTdRO6jdBZ5BLsrtu5ttTuKBv3okmplddQ
         JmmBevMnOkR9z7Wvkzsukt5vFtC5zeXPnyQo7itzLyGAXSthkfq6S+BvXtySWmWlx9K+
         J2xEPAO5lgxBO55EEDEaUmEajDAcXuNicAr4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712917497; x=1713522297;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXjVQsLqyM7W96iPN2njoIot7m3tPecpIfZcOMPHqes=;
        b=JWuSByrkrcCU2Bae/6dayew0sElDrVsMy1kYen8RZD11qdh6/wFUWajn31sRqP15/a
         kZaMe6udEniznZIFVsAbP6XzHCPXoZvSQIq/AbYqPeA4vAFLQkUyuzLnz6Frr8xWQjpG
         5mUMvLW9F0kNY0LQiz23bqpSllhAOhKBnaSC1UtDTJW4iWJ2JuaBdlCjX0D7qNq10oP/
         WEOJTgcXsxx+ueQf2Tod2pJZC2JjSaU+vjLLN8FWAZkLicgTMGah999efAJWbsHCLjaH
         f9h9wEvTybsmsjHO7whS631uJxEKGxLJcU9jPA9hQEUYq9AwgPFFU9fiMf3+fkKOCaVP
         +K/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCUNtrmvzhnV5zdwXe2pMJluq2+mVzhagN4untJ3JePKwWClfvx0GMcq7PKb+fRmgcHAa16jt+ApBakzm56czF/xRii0Iw08DaSLVS
X-Gm-Message-State: AOJu0Yz7tQ7B6jU4IvS4uEiNXYM7Mimk+8DKJg16iFoAPn8yfFf9/Xji
	PNAkaUAd/LHZLEbf2LdadDV58qwOyOUgp4iBQQJgAkGg9pR/HBguh+14eM0br3E=
X-Google-Smtp-Source: AGHT+IELh32E1/vBC3BVRY2WDLYXtdDGoLZ01IM5jFGJ5nrnzt8Z85XGvgFw+/XxpDOpOimf+9McRA==
X-Received: by 2002:a05:620a:5dce:b0:78d:68de:e3ac with SMTP id xy14-20020a05620a5dce00b0078d68dee3acmr2029293qkn.76.1712917497479;
        Fri, 12 Apr 2024 03:24:57 -0700 (PDT)
Received: from [10.80.67.140] (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id m14-20020a05620a220e00b0078d61011c6fsm2219918qkh.6.2024.04.12.03.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 03:24:56 -0700 (PDT)
Message-ID: <323fbfe5-ad21-4606-93c7-d3ad6bbc8620@citrix.com>
Date: Fri, 12 Apr 2024 11:24:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] x86/bugs: Only harden syscalls when needed
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Christopherson <seanjc@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>, KP Singh <kpsingh@kernel.org>,
 Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>
References: <cover.1712813475.git.jpoimboe@kernel.org>
 <97befd7c1e008797734dee05181c49056ff6de57.1712813475.git.jpoimboe@kernel.org>
 <90405c43-daca-48e4-b424-d66d6bf4dd87@citrix.com>
 <20240411153841.zexbsqrdli54kiez@treble>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 xsFNBFLhNn8BEADVhE+Hb8i0GV6mihnnr/uiQQdPF8kUoFzCOPXkf7jQ5sLYeJa0cQi6Penp
 VtiFYznTairnVsN5J+ujSTIb+OlMSJUWV4opS7WVNnxHbFTPYZVQ3erv7NKc2iVizCRZ2Kxn
 srM1oPXWRic8BIAdYOKOloF2300SL/bIpeD+x7h3w9B/qez7nOin5NzkxgFoaUeIal12pXSR
 Q354FKFoy6Vh96gc4VRqte3jw8mPuJQpfws+Pb+swvSf/i1q1+1I4jsRQQh2m6OTADHIqg2E
 ofTYAEh7R5HfPx0EXoEDMdRjOeKn8+vvkAwhviWXTHlG3R1QkbE5M/oywnZ83udJmi+lxjJ5
 YhQ5IzomvJ16H0Bq+TLyVLO/VRksp1VR9HxCzItLNCS8PdpYYz5TC204ViycobYU65WMpzWe
 LFAGn8jSS25XIpqv0Y9k87dLbctKKA14Ifw2kq5OIVu2FuX+3i446JOa2vpCI9GcjCzi3oHV
 e00bzYiHMIl0FICrNJU0Kjho8pdo0m2uxkn6SYEpogAy9pnatUlO+erL4LqFUO7GXSdBRbw5
 gNt25XTLdSFuZtMxkY3tq8MFss5QnjhehCVPEpE6y9ZjI4XB8ad1G4oBHVGK5LMsvg22PfMJ
 ISWFSHoF/B5+lHkCKWkFxZ0gZn33ju5n6/FOdEx4B8cMJt+cWwARAQABzSlBbmRyZXcgQ29v
 cGVyIDxhbmRyZXcuY29vcGVyM0BjaXRyaXguY29tPsLBegQTAQgAJAIbAwULCQgHAwUVCgkI
 CwUWAgMBAAIeAQIXgAUCWKD95wIZAQAKCRBlw/kGpdefoHbdD/9AIoR3k6fKl+RFiFpyAhvO
 59ttDFI7nIAnlYngev2XUR3acFElJATHSDO0ju+hqWqAb8kVijXLops0gOfqt3VPZq9cuHlh
 IMDquatGLzAadfFx2eQYIYT+FYuMoPZy/aTUazmJIDVxP7L383grjIkn+7tAv+qeDfE+txL4
 SAm1UHNvmdfgL2/lcmL3xRh7sub3nJilM93RWX1Pe5LBSDXO45uzCGEdst6uSlzYR/MEr+5Z
 JQQ32JV64zwvf/aKaagSQSQMYNX9JFgfZ3TKWC1KJQbX5ssoX/5hNLqxMcZV3TN7kU8I3kjK
 mPec9+1nECOjjJSO/h4P0sBZyIUGfguwzhEeGf4sMCuSEM4xjCnwiBwftR17sr0spYcOpqET
 ZGcAmyYcNjy6CYadNCnfR40vhhWuCfNCBzWnUW0lFoo12wb0YnzoOLjvfD6OL3JjIUJNOmJy
 RCsJ5IA/Iz33RhSVRmROu+TztwuThClw63g7+hoyewv7BemKyuU6FTVhjjW+XUWmS/FzknSi
 dAG+insr0746cTPpSkGl3KAXeWDGJzve7/SBBfyznWCMGaf8E2P1oOdIZRxHgWj0zNr1+ooF
 /PzgLPiCI4OMUttTlEKChgbUTQ+5o0P080JojqfXwbPAyumbaYcQNiH1/xYbJdOFSiBv9rpt
 TQTBLzDKXok86M7BTQRS4TZ/ARAAkgqudHsp+hd82UVkvgnlqZjzz2vyrYfz7bkPtXaGb9H4
 Rfo7mQsEQavEBdWWjbga6eMnDqtu+FC+qeTGYebToxEyp2lKDSoAsvt8w82tIlP/EbmRbDVn
 7bhjBlfRcFjVYw8uVDPptT0TV47vpoCVkTwcyb6OltJrvg/QzV9f07DJswuda1JH3/qvYu0p
 vjPnYvCq4NsqY2XSdAJ02HrdYPFtNyPEntu1n1KK+gJrstjtw7KsZ4ygXYrsm/oCBiVW/OgU
 g/XIlGErkrxe4vQvJyVwg6YH653YTX5hLLUEL1NS4TCo47RP+wi6y+TnuAL36UtK/uFyEuPy
 wwrDVcC4cIFhYSfsO0BumEI65yu7a8aHbGfq2lW251UcoU48Z27ZUUZd2Dr6O/n8poQHbaTd
 6bJJSjzGGHZVbRP9UQ3lkmkmc0+XCHmj5WhwNNYjgbbmML7y0fsJT5RgvefAIFfHBg7fTY/i
 kBEimoUsTEQz+N4hbKwo1hULfVxDJStE4sbPhjbsPCrlXf6W9CxSyQ0qmZ2bXsLQYRj2xqd1
 bpA+1o1j2N4/au1R/uSiUFjewJdT/LX1EklKDcQwpk06Af/N7VZtSfEJeRV04unbsKVXWZAk
 uAJyDDKN99ziC0Wz5kcPyVD1HNf8bgaqGDzrv3TfYjwqayRFcMf7xJaL9xXedMcAEQEAAcLB
 XwQYAQgACQUCUuE2fwIbDAAKCRBlw/kGpdefoG4XEACD1Qf/er8EA7g23HMxYWd3FXHThrVQ
 HgiGdk5Yh632vjOm9L4sd/GCEACVQKjsu98e8o3ysitFlznEns5EAAXEbITrgKWXDDUWGYxd
 pnjj2u+GkVdsOAGk0kxczX6s+VRBhpbBI2PWnOsRJgU2n10PZ3mZD4Xu9kU2IXYmuW+e5KCA
 vTArRUdCrAtIa1k01sPipPPw6dfxx2e5asy21YOytzxuWFfJTGnVxZZSCyLUO83sh6OZhJkk
 b9rxL9wPmpN/t2IPaEKoAc0FTQZS36wAMOXkBh24PQ9gaLJvfPKpNzGD8XWR5HHF0NLIJhgg
 4ZlEXQ2fVp3XrtocHqhu4UZR4koCijgB8sB7Tb0GCpwK+C4UePdFLfhKyRdSXuvY3AHJd4CP
 4JzW0Bzq/WXY3XMOzUTYApGQpnUpdOmuQSfpV9MQO+/jo7r6yPbxT7CwRS5dcQPzUiuHLK9i
 nvjREdh84qycnx0/6dDroYhp0DFv4udxuAvt1h4wGwTPRQZerSm4xaYegEFusyhbZrI0U9tJ
 B8WrhBLXDiYlyJT6zOV2yZFuW47VrLsjYnHwn27hmxTC/7tvG3euCklmkn9Sl9IAKFu29RSo
 d5bD8kMSCYsTqtTfT6W4A3qHGvIDta3ptLYpIAOD2sY3GYq2nf3Bbzx81wZK14JdDDHUX2Rs
 6+ahAA==
In-Reply-To: <20240411153841.zexbsqrdli54kiez@treble>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/04/2024 4:38 pm, Josh Poimboeuf wrote:
> On Thu, Apr 11, 2024 at 11:06:37AM +0100, Andrew Cooper wrote:
>>> +#define __do_syscall(table, func_direct, nr, regs)			\
>>> +({									\
>>> +	unsigned long __rax, __rdi, __rsi;				\
>>> +									\
>>> +	asm_inline volatile(						\
>>> +		ALTERNATIVE("call " __stringify(func_direct) "\n\t",	\
>>> +			    ANNOTATE_RETPOLINE_SAFE			\
>>> +			    "call *%[func_ptr]\n\t",			\
>> This wants to be a plain maybe-thunk'd indirect call, and without the
>> ANNOTATE_RETPOLINE_SAFE.
>>
>> Or you're going to get into cases where some combinations of command
>> line options do unexpected things e.g. retpolining everything except the
>> syscall dispatch.
> In that case won't X86_FEATURE_INDIRECT_SAFE get cleared, resulting in
> the above using a direct call?  Or did I miss something?

That works until the next time anyone touches the logic.  Then it's
latent vulnerability, or an incorrect trial of a non-default option.

I guarantee you'll save someone (probably someone on this CC list) a
headache in the future by not introducing an unnecessary special case here.

~Andrew

