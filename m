Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FFB75B239
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjGTPQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjGTPQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:16:11 -0400
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E257926B0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:16:09 -0700 (PDT)
Received: from [IPV6:2a02:8428:2a4:1a01:6315:6ab5:10c2:f7af] (unknown [IPv6:2a02:8428:2a4:1a01:6315:6ab5:10c2:f7af])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 6CE5419F5C7;
        Thu, 20 Jul 2023 17:16:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1689866167;
        bh=MiHnnl6bhVPR1+ongnOWzT28HIpB4Cwd6ywFRv/O2ng=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cReJTNfI8afAxFVwdZS8SvkwNPPASZaanU+1dSuC5OPQonckNbGKSH7dx3Rg1StLH
         dCs0OlPhLufeRXP4qHf2/3iWBCgpsm41b0TuqHAntXueYakVWCIqVrqveUiPXSd44t
         XXzJzLgnXDAXWwgc2fRcs1ReWhagacj/4C/1/cvpSu6QjOzXInPL0+hzqJ4R90n5Xw
         Is6xepvLPkjyVGtL4P5cJwru8kkCMkw2M9t9naxZCoQXWDu75MNgy/sB6V/nkVcBg1
         yKBcqiu/8pO4WaleCkd81ei+pgFXPLHbuwxZmUBE9UALEcH8DAsTmBiIcfS7kHB9c5
         rx7GLEfniuLrA==
Message-ID: <c5b0c16b-01df-9d74-aeec-30124f134a94@free.fr>
Date:   Thu, 20 Jul 2023 17:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch 00/58] x86/apic: Decrapification and static calls
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230717223049.327865981@linutronix.de>
 <502aa1d5-97a0-7787-1d9c-486f351fe9c5@free.fr>
 <20230720131316.GD3569127@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <20230720131316.GD3569127@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 15:13, Peter Zijlstra wrote:

> On Thu, Jul 20, 2023 at 02:43:55PM +0200, Marc Gonzalez wrote:
>
>> # cat /proc/cpuinfo
>> processor       : 0
>> vendor_id       : GenuineIntel
>> cpu family      : 6
>> model           : 28
>> model name      : Intel(R) Atom(TM) CPU CE4150   @ 1.20GHz
>> stepping        : 10
>> microcode       : 0x106
>> cpu MHz         : 1199.885
>> cache size      : 512 KB
>> physical id     : 0
>> siblings        : 2
>> core id         : 0
>> cpu cores       : 1
>> apicid          : 0
>> initial apicid  : 0
>> fdiv_bug        : no
>> f00f_bug        : no
>> coma_bug        : no
>> fpu             : yes
>> fpu_exception   : yes
>> cpuid level     : 10
>> wp              : yes
>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc arch_perfmon pebs bts cpuid aperfmperf pni dtes64 monitor ds_cpl vmx tm2 ssse3 cx16 xtpr pdcm movbe lahf_lm tpr_shadow vnmi flexpriority vpid dtherm
>> vmx flags       : vnmi flexpriority tsc_offset vtpr vapic
>> bugs            :
>> bogomips        : 2400.76
>> clflush size    : 64
>> cache_alignment : 64
>> address sizes   : 32 bits physical, 48 bits virtual
> 
> But that's a 64bit chip, no? lm, cx16

Hol'up. A 64b chip with 32b physical addresses?
Only for the additional registers then?

https://www.cpu-world.com/CPUs/Atom/Intel-Atom%20CE4150.html
https://www.techpowerup.com/cpu-specs/atom-ce4150.c1440

I'm 99% sure it's running a 32b kernel.
Are you saying a 64b kernel would work?
(Well, there are several binary blobs, so no way.)

Regards

