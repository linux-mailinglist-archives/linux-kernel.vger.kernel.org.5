Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867A97C610B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 01:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbjJKXVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 19:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbjJKXU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 19:20:58 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CDAA4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 16:20:56 -0700 (PDT)
Received: from [IPV6:2601:646:9a00:1821:7c45:267e:5aad:82e7] ([IPv6:2601:646:9a00:1821:7c45:267e:5aad:82e7])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 39BNKBnV1461541
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 11 Oct 2023 16:20:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 39BNKBnV1461541
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023091101; t=1697066415;
        bh=A+3phZYqNXM4miRlbtMsbx7u98cTT8X7Jf9CLISzVzM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XeQjykw/+h9Es/QbI/1xphsZ0JBa+PKYr0spgfLTCDJIxFQzaBrWoMpvMWmDYX1fg
         FA/9IJypiexXo9wPeeNIosNU1QoGcvxS3ne1AaI5FujaBLJMX2VqMMxkgYEBL/5jVp
         ZdynKuLm2U0Qj3DNro6yBcaT2jqruhugaeOTRSi1RXGgRfm7Gc+T2ShhNXBmRe/Wt/
         4zkG4yMbgp5QdRzgBMRmyBZaEatruHUPhZZxgPXbU+TksTEClWrDXd0Zg1cCgOtNcW
         byOaWwtWwL4Qbzmk6w8iSrRCmOQR/1A2tY4EtfHdk2g/M3CdwestzW4UtnspFCDht6
         ake1+JpJ2Ijlw==
Message-ID: <eec6b477-67b5-49d6-b6f4-dd2c242b9bdb@zytor.com>
Date:   Wed, 11 Oct 2023 16:20:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/23] Add generic vdso_base tracking
Content-Language: en-US
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20210611180242.711399-1-dima@arista.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/21 11:02, Dmitry Safonov wrote:
> 
> Patches set is based on linux-next (next-20201123) and it depends on
> changes in x86/cleanups (those reclaim TIF_IA32/TIF_X32) and also
> on my changes in akpm (fixing several mremap() issues).
> 
> Logically, the patches set divides on:
> - patch       1: a cleanup for patches in x86/cleanups
> - patches  2-13: cleanups for arch_setup_additional_pages()
> - patches 13-14: x86 signal changes for unmapped vdso
> - patches 15-22: provide generic vdso_base in mm_struct
> - patch      23: selftest for unmapped vDSO & fast syscalls
> 
> In the end, besides cleanups, it's now more predictable what happens for
> applications with unmapped vdso on architectures those support .mremap()
> for vdso/sigpage.
> 
> I'm aware of only one user that unmaps vdso - Valgrind [2].
> (there possibly are more, but this one is "special", it unmaps vdso, but
>   not vvar, which confuses CRIU [Checkpoint Restore In Userspace], that's
>   why I'm aware of it)
> 

There was another discussion that might be relevant: actually 
associating the vdso with an actual file, and allowing a program to map 
said file normally if it want access to one that it normally wouldn't 
have (say, /proc/vdso/x86_64.so versus /proc/vdso/i386.so on the same 
system.)

The "catch", of course, is that this file will need to be mapped as 
MAP_SHARED because of vdso data.

	-hpa
