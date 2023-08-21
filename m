Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A1778286B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjHUMAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjHUMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:00:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B54B4;
        Mon, 21 Aug 2023 05:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692619161; x=1693223961; i=deller@gmx.de;
 bh=mdelTfLMnGPJUyvNJd7xipF1TZZ44AqAVCUXPVXywQA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ZHvwnyPZiqWfGD2mTa2r/1mk/gS3ETk323MSPc2kr0LQJfPyjAmuejYJ7OGbJIlY7BY6cdH
 GlVgXlu7F/l98WEc7GrM4YuUxRQhgU2Cx2A7P2EmwbqXTXt4e8gRPPYbC/USI8XJewBrr9sIF
 Fshf67NZnJBdN7RyD+GT4WhXJC1QoPnzZ2qtmfD6osV5NRYZ32tlkIdbXgB2oeLEjul8oJyfO
 yf99x3ZKg3+diEfOutOYG0ck9XEga/G5m2IM6A5EMI3z2KSY9hVUlVZvZJVjFiwqK3dfjh9JW
 cEQJrzw86uGqh+TLWFs5+NsGrjKxSuUgG7RqtG48rw/j1I2JHLEQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.156.203]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wll-1paUng0po1-012ILg; Mon, 21
 Aug 2023 13:59:21 +0200
Message-ID: <fd051aec-9aad-a608-59d6-7bee3a340801@gmx.de>
Date:   Mon, 21 Aug 2023 13:59:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] HWPOISON: add a pr_err message when forcibly send a
 sigbus
Content-Language: en-US
To:     Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, James.Bottomley@HansenPartnership.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <20230819102212.21103-1-xueshuai@linux.alibaba.com>
 <20230821105025.GB19469@willie-the-truck>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230821105025.GB19469@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IVeM96pUticIvBhwoOnDbFmJ+lT/5LMU21eOcF6EwIMKtNxOSoc
 bUokuBJCBIk6zKzXvdWxx8KRouWbbPYLOkmMAnl909dYPr54k7WaocN9eLdS7gn2TGf96Q8
 aUHX1OR0URngbIG/9QEpxe488uAfd8dsMkBFgmObYFVCxN+o8AbGdVy+OgpRDLGUbNOZqGj
 /G5/w3jDXtnGZomzBXrfg==
UI-OutboundReport: notjunk:1;M01:P0:2Lfi+p9wf00=;qG6PSUZO2ECGpwRqm4SV1ORPw/p
 T/Oewr5iyBLQJ/P24b7ft6xQvXPz1TRybuIn9uqDno19rcmS836t1usieJSx67Z8bcfjRSRUv
 Ar2BIUJALJhsqRvMkPwRPaXEGj0/RlBCYH1NELXYl3LGiz8FP0F6axM371Zq1YzbF8BsP50Sj
 oQoyjB7/Ik02js3jmUvwgptnsJaRMEwy+IdboJ2fLGNZk3Np9eng8j5f3McTQIi34X8osIx47
 ZnchMTa1abPjbqkqHBoBqjsOqqBuMyfXUHKcPcOmGrjN8HKfRzzgBKiGYwMhKQyDCJht4fxVw
 6+CJJYoAUHyR61KRbQls/pxRG0mo4ySUNYLvf3SORIhUej5jaHRlP9GVCAfSWqbtaQyS0zS8f
 Z2Rxr38i1Yg5fvHxNLwiYI4/2OhU5jeJ9353hKpezNQKeGkwSHtLnH4A2cUPCtVUrXGhFWmDS
 fqFcYN7RYed1zjSe/0HtC2/zuCHF4l5cC76KoJc+hX/86TooxL1jEIUghW42BmH28pixAgxtT
 4p9HCUhVHFFIa3PA224g8RqwyYw932JIi5XqhSUBBHKF6b9nV4E/inOe1XGHSGgTkpoMP0T5c
 6G9F5eEnlj7f5hlNnt8uWK/tjM0Sy7pWMB0CkyvCPrkSIUXJ+obuY8gXmINfvpnhk6oypxuvc
 SptvJG6DN/sK+nevtA3kUEVrlUczmkNQRy863cV/4fNxjJJYq27KYoqMURoUeWMv0kZn/q8jS
 rYIG7CK66T3lYpSrn+Tn5JbhwBx81DuiqdZBmjb3dOy0+fUfI3A4Tuv9ZJW9Oa0bkcf93qifM
 g7MkA+bTHhpgvZ+U9UbsXQpHQuCZkRggEiyOyM83GL9kkYFfZoT/1UXKy9Hnsdp0ypt5Uss4I
 IbD3gnR6UEV3NuKwrVRsXlmELsHyuQVok3Y9LTC0ydnBOPCHVCL6mNJf6b6maAH/BeTfoG4NS
 DiAKopHGM4O+2u72xtmX0FAfpzM=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/23 12:50, Will Deacon wrote:
> On Sat, Aug 19, 2023 at 06:22:12PM +0800, Shuai Xue wrote:
>> When a process tries to access a page that is already offline
>
> How does this happen?
>
>> the kernel will send a sigbus signal with the BUS_MCEERR_AR code. This
>> signal is typically handled by a registered sigbus handler in the
>> process. However, if the process does not have a registered sigbus
>> handler, it is important for end users to be informed about what
>> happened.
>>
>> To address this, add an error message similar to those implemented on
>> the x86, powerpc, and parisc platforms.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>   arch/arm64/mm/fault.c  | 2 ++
>>   arch/parisc/mm/fault.c | 5 ++---
>>   arch/x86/mm/fault.c    | 3 +--
>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 3fe516b32577..38e2186882bd 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -679,6 +679,8 @@ static int __kprobes do_page_fault(unsigned long fa=
r, unsigned long esr,
>>   	} else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)) {
>>   		unsigned int lsb;
>>
>> +		pr_err("MCE: Killing %s:%d due to hardware memory corruption fault a=
t %lx\n",
>> +		       current->comm, current->pid, far);
>>   		lsb =3D PAGE_SHIFT;
>>   		if (fault & VM_FAULT_HWPOISON_LARGE)
>>   			lsb =3D hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
>
> Hmm, I'm not convinced by this. We have 'show_unhandled_signals' already=
,
> and there's plenty of code in memory-failure.c for handling poisoned pag=
es
> reported by e.g. GHES. I don't think dumping extra messages in dmesg fro=
m
> the arch code really adds anything.

I added the parisc hunk in commit 606f95e42558 due to the memory fault inj=
ections by the LTP
testsuite (madvise07). Not sure if there were any other kernel messages wh=
en this happened.

Helge
