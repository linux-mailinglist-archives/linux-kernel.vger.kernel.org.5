Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9684E779706
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbjHKSXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjHKSXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:23:47 -0400
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4633230DD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:23:43 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 193A8EB.A8F67
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:145:242:ac11:22])
        by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id 193A8EB;
        Fri, 11 Aug 2023 20:23:40 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1691778219;
        bh=aM/WSIY/N0AWV7IeD5mW5NLJdwV8q3RvYqxgbNiQWU4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=LLTIkDUpXpY5N46cfQX0h4ddwa/qtn3rLpIqcReA9cjcaYU1Z0pGTsuV4GR5+KOtY
         3bGEmEvQvA4GL8LOSrgywjUTzDdgZ8QJs4+Of+el6/bK2MjgjHDuUYzx8REwEDB4NN
         SivdFIF216oozO7HgyHS+GU2qJY3dDqtWZMqqoic=
Received: from [172.22.26.96] (unknown [68.170.73.15])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 182B1D4EBDF1A;
        Fri, 11 Aug 2023 20:23:37 +0200 (CEST)
Message-ID: <405927c5-91bf-144d-a3d7-b82f5527f3c9@cs.kuleuven.be>
Date:   Fri, 11 Aug 2023 11:23:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND] x86/pti: Fix kernel warnings for pti= and nopti
 cmdline options.
To:     Sohil Mehta <sohil.mehta@intel.com>, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        mingo@redhat.com
Cc:     x86@kernel.org, bp@alien8.de, tglx@linutronix.de, hpa@zytor.com
References: <20230808195615.9795-1-jo.vanbulck@cs.kuleuven.be>
 <c0aed6a4-23e0-d947-5c17-26e580d5c40a@intel.com>
Content-Language: en-US
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <c0aed6a4-23e0-d947-5c17-26e580d5c40a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the code review!

On 08.08.23 17:13, Sohil Mehta wrote:> Can mitigations be off through 
some other mechanisms such as kernel config?

Yes, from the kernel documentation [1]:

"It can be enabled by setting CONFIG_PAGE_TABLE_ISOLATION=y at compile 
time. Once enabled at compile-time, it can be disabled at boot with the 
'nopti' or 'pti=' kernel parameters"

In my understanding, if PTI is disabled at compile-time the full pti.c 
file is excluded and this code is never executed. I validated that, when 
compiling with CONFIG_PAGE_TABLE_ISOLATION=n, any nopti/pti= parameters 
are reported as unknown and 
/sys/devices/system/cpu/vulnerabilities/meltdown is reported as 
vulnerable. I validated this both with and without the proposed patch.

> Maybe split the mitigations_off check into a separate if and it's own
> unique print message?
> Also, with the separated check you can avoid the unnecessary re-setting
> of pti_mode when pti_mode == PTI_FORCE_OFF is true.

Thanks, makes sense. I'll make sure to do this in the next patch revision.

> In the rare case that both pti= and nopti is set the existing code seems
> to ignore the nopti option. Would the new implementation do the same?

Good point. In my understanding, passing such conflicting options is 
undefined as per the specification [2] and I'm not sure if backwards 
compatibility is a requirement?

That being said, I can see the argument that in this case of 
security-sensitive functionality, it may be desirable to maintain 
identical behavior for identical kernel parameter combinations and 
sequences. The current patch does indeed _not_ guarantee this. 
Particularly, I found there are currently 2 divergent cases:

CASE 1: PTI= > NOPTI
====================

Before patch pti= always takes priority:

KERNEL_CMDLINE="nopti pti=on"
[    0.022721] Unknown kernel command line parameters "nopti pti=on", 
will be passed to user space.
[    0.024146] Kernel/User page tables isolation: enabled
Mitigation: PTI

KERNEL_CMDLINE="pti=on nopti"
[    0.020566] Unknown kernel command line parameters "nopti pti=on", 
will be passed to user space.
[    0.021576] Kernel/User page tables isolation: enabled
Mitigation: PTI

After patch behavior depends on which option comes last in order:

KERNEL_CMDLINE="nopti pti=on"
[    0.021779] Kernel/User page tables isolation: enabled
Mitigation: PTI

KERNEL_CMDLINE="pti=on nopti"
[    0.010289] Kernel/User page tables isolation: disabled on command line.
Vulnerable

CASE 2: MITIGATIONS=off
=======================

Before patch pti= always overrides mitigations=:

KERNEL_CMDLINE="mitigations=off pti=on"
[    0.017404] Unknown kernel command line parameters "pti=on", will be 
passed to user space.
[    0.018239] Kernel/User page tables isolation: enabled
Mitigation: PTI

KERNEL_CMDLINE="pti=on mitigations=off"
[    0.017356] Unknown kernel command line parameters "pti=on", will be 
passed to user space.
[    0.018232] Kernel/User page tables isolation: enabled
Mitigation: PTI

After patch, mitigations=off always takes priority:

KERNEL_CMDLINE="mitigations=off pti=on"
[    0.008331] Kernel/User page tables isolation: disabled on command line.
Vulnerable

KERNEL_CMDLINE="pti=on mitigations=off"
[    0.008495] Kernel/User page tables isolation: disabled on command line.
Vulnerable


--> I can update the patch to ensure backwards-compatible behavior in 
both cases for the next patch revision.

[1] https://www.kernel.org/doc/html/latest/arch/x86/pti.html
[2] 
https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
