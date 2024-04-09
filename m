Return-Path: <linux-kernel+bounces-136395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C4089D398
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19611284184
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425DF7D3E6;
	Tue,  9 Apr 2024 07:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="rb/nEBMZ"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C634F7C6C5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649394; cv=none; b=UL2h1qAXlbPguqxYGk6Dmk5m3Iji8i8zBAKn3vd2WdICRwzLKDIk61w6ozpDIYjpGvfodNqQn1HrkDE37SM6j2ao80+X0RXWZYMANVkp2n1WbgZ5e0l3pzSfJcbXI7FYRsu6DgzNme4zsRkWG9nQbdGMiVstj78cOLaYFjO5jPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649394; c=relaxed/simple;
	bh=J+1B+SztGs+d9sY3z7ovEHaFKiQTvjRrCrrMd0lPWvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdZYnIWq9aw4TJii3ulk6GF/nAR10oMnHsHXQnAOMuWx3kwzJCFyOXASAKdgRKwj0e0X+pqtgLkt2qzY2yEttx/u+cjyHMpGmnVXDjUZ9aH/Kmrp6QuZQXE3vS4P2EQQvRm/egUF4CkcxQA8cpd+KNBQxA0YpxXsaoIFtC6Btno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=rb/nEBMZ; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c397193878so2780446b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 00:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1712649392; x=1713254192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eLRrmyrkSoVdDITv9mGHfqqiu3Rslw82mlx/smFYYTw=;
        b=rb/nEBMZePi4rvK1XZ3mwYqp7xJZhFmpdupJh8DB8dOXUzkf/n01JDXw1KUME7/+En
         69V2TwW3pHBoUp7p8gn9nyUKtgFknrbJgU2wTxrGQB4ha0I4nOBMyWHx9skYXyj/5Kzl
         fgW1DdMSbLQYAHnLy+Z5jqtVQmDXp9Gok+rQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712649392; x=1713254192;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLRrmyrkSoVdDITv9mGHfqqiu3Rslw82mlx/smFYYTw=;
        b=fUIP6TZmKfPNkyTsTv8eNOoEQFy9+6NAvZGoYHky34YZB/hdYoriwuymAGjEA8pYA+
         L7sbvFE4uxo6IPNNS4wL4W0Om42Jr4chLmUWyrvJI3l+kl6R5zbmPEZ9ofOzAHXdx0YT
         nnUxUW2DQWEGf5sCbz4Flr96juBtfDA2MRmmE2/ejn7Z2ug6r0mByQFeA4g6LfbxvgH3
         wDeSR7R0qXW4ILnwzoxDpNaPDUuNJRjpfqK3SJ0/ooOChf/PDGPXSt6gcBUC2LTMIXm7
         3B9YRwD6c1Isl1dWYg1Z8lo1CK8+TjPVvM/cQNn7lANI3hBd5UjYulY2I55CxTkObkGH
         t7YA==
X-Forwarded-Encrypted: i=1; AJvYcCUiWAVdb+ZLACt4bkXOIsNRlAx976sYG9+GiXJBphHMZC6qjssnky3SnJY5dt1CZmxp1/Z1E5eZsLTxHzU4B1Jczrl5lxAwX24ucjK7
X-Gm-Message-State: AOJu0YyTGMmtcV8AR7awpaeYG93ZzmgKvp0MwpD/cP1zyv8hJyFB0sy1
	9tCBax8axFLylxPZg1L3LIsT7ReaKccuvNv+q5nxLnlUofbbkd+W2ybQo3oeAAw=
X-Google-Smtp-Source: AGHT+IHa+vwisLW1OlJxhn9xflWgf+jsjQJEuVi/xj4dB95fxmGEKn5BysuYbKgh3ssacJMXPojZRw==
X-Received: by 2002:a05:6808:b0c:b0:3c5:f7e7:e3e0 with SMTP id s12-20020a0568080b0c00b003c5f7e7e3e0mr4067700oij.22.1712649391898;
        Tue, 09 Apr 2024 00:56:31 -0700 (PDT)
Received: from [192.168.1.10] (host-92-3-248-192.as13285.net. [92.3.248.192])
        by smtp.gmail.com with ESMTPSA id qp12-20020a05620a388c00b0078d704f9867sm280735qkn.71.2024.04.09.00.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 00:56:31 -0700 (PDT)
Message-ID: <d82cf14a-e949-4265-ae37-ec01685e1080@citrix.com>
Date: Tue, 9 Apr 2024 08:56:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
To: Sean Christopherson <seanjc@google.com>,
 Michael Kelley <mhklinux@outlook.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Xi Ruoyao <xry111@xry111.site>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dexuan Cui <decui@microsoft.com>
References: <20240324190503.116160-1-xry111@xry111.site>
 <SN6PR02MB41576028614CB7FE9A11EBEBD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Zg7S5dk3J4Zc82nj@google.com>
 <d1cc1f7c-9df0-4e3c-88ae-aedcd556ba95@citrix.com>
 <Zg7jLn-lV55Yh6mH@google.com>
 <SN6PR02MB415717D76F71C023A574841ED43C2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <f8df14f3-ae6a-4e08-927a-7a7c2ebe8352@intel.com>
 <SN6PR02MB4157FDA1C431A92873AA1AAED4002@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ZhSdSwqUprIgLVtr@google.com>
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
In-Reply-To: <ZhSdSwqUprIgLVtr@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/04/2024 2:43 am, Sean Christopherson wrote:
> On Mon, Apr 08, 2024, Michael Kelley wrote:
>> From: Dave Hansen <dave.hansen@intel.com> Sent: Thursday, April 4, 2024 11:09 AM
>>> On 4/4/24 10:48, Michael Kelley wrote:
>>>> I agree one could argue that it is a hypervisor bug to present PCID to the guest
>>>> in this situation. It's a lot cleaner to not have a guest be checking FMS and
>>>> microcode versions. But whether that's practical in the real world, at least
>>>> for Hyper-V, I don't know. What's the real impact of running with PCID while
>>>> the flaw is still present? I don’t know the history here ...
>>> There's a chance that INVLPG will appear ineffective.
>>>
>>> The bad sequence would go something like this: The kernel does the
>>> INVLPG on a global mapping.  Later, when switching PCIDs, the TLB entry
>>> mysteriously reappears.  No PCIDs switching means no mysterious
>>> reappearance.
>> Xi Ruoyao's patch identifies these errata:  RPL042 and ADL063.  In the links
>> to the documents Xi provided, both of these errata have the following
>> statement in the Errata Details section:
>>
>>     This erratum does not apply in VMX non-root operation.  It applies only
>>     when PCIDs are enabled and either in VMX root operation or outside
>>     VMX operation.
>>
>> I don't have deep expertise on the terminology here, but this sounds
>> like it is saying the erratum doesn’t apply in a guest VM.  Or am I
>> misunderstanding?
> Huh.  My read of that is the same as yours.  If that's the case, then it probably
> makes sense to have KVM advertise support if PCID is available in hardware, even
> if PCID is disabled by the host kernel.

My reading is the same also.  Seems like VMs are fine.

~Andrew

