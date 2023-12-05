Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71910805C8E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345997AbjLEO57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346013AbjLEO55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:57:57 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612FA183;
        Tue,  5 Dec 2023 06:58:02 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1rAWrq-0005mA-Tn; Tue, 05 Dec 2023 15:57:46 +0100
Message-ID: <01210f0e-9340-41bb-bb41-e3ca0774faa9@leemhuis.info>
Date:   Tue, 5 Dec 2023 15:57:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: Fwd: Kernels v6.5 and v6.6 break resume from standby (s3) on some
 Intel systems if VT-d is enabled
To:     Linux Regressions <regressions@lists.linux.dev>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        kbugreports@proton.me, Linux IOMMU <iommu@lists.linux.dev>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <4b3c624a-f114-4e39-9e1c-0df18f307e8c@gmail.com>
 <ZWx1IHBE9KCk6rWj@archie.me>
Content-Language: en-US, de-DE
In-Reply-To: <ZWx1IHBE9KCk6rWj@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701788282;af276d30;
X-HE-SMSGID: 1rAWrq-0005mA-Tn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing Mario, as he might be interested]

On 03.12.23 13:31, Bagas Sanjaya wrote:
> On Tue, Nov 28, 2023 at 08:09:24PM +0700, Bagas Sanjaya wrote:
>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>> 
>>> Affected system:
>>> 
>>> Thinkpad, Intel Kaby Lake (i7-7600U) chipset / cpu and onboard
>>> gpu (Intel HD 620), no separate graphics card, current bios
>>> firmware; running Void Linux, xfce / lightdm
>>> 
>>> Symptom / problem:
>>> 
>>> Since the upgrade to kernel v6.5.5 (from v6.3.13) my system
>>> doesn't wake up from standby, i.e. resume from s3 fails 100% of
>>> the time.
>
>> https://bugzilla.kernel.org/show_bug.cgi?id=218191 
> 
> The reporter had done bisection (see Bugzilla for details),

Turns out the kernel used by the reporter is not vanilla, as zfs is
involved -- and due to that the reporter is not even able to check if
mainline is still affected. I'll thus remove this from the tracking.
Sorry for the noise.

In case anyone nevertheless cares: The bisection result from the report
was 0c7ffa32dbd6b0 ("x86/smpboot/64: Implement
arch_cpuhp_init_parallel_bringup() and enable it") [v6.5-rc1].
This time on a Intel machine. Mario's "Fixes for s3 with parallel
bootup" patch-series[1] (the one were abandoned because things turned
out to be a BIOS bug affecting some AMD systems) apparently resolved the
problem for the reporter.

[1]
https://lore.kernel.org/all/20231026170330.4657-1-mario.limonciello@amd.com/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot inconclusive: kernel used by the reporter is not vanilla
