Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9557178438C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjHVOMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjHVOMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:12:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A61E51;
        Tue, 22 Aug 2023 07:11:59 -0700 (PDT)
Received: from [IPV6:2405:201:0:21ea:73f6:2283:f432:3936] (unknown [IPv6:2405:201:0:21ea:73f6:2283:f432:3936])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 535A76607252;
        Tue, 22 Aug 2023 15:10:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692713429;
        bh=sd11d3ypYTMasYaegw5coFu8/jgboWLEnakdZOASQTs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=arLmtfSYTryCNFP6uiR1U4gFRBSVQXGbJXlzbnoNqLkTYJRtxDlzwy2eeAd4uU05k
         0uEPBg9EsI2jUkG2gXjBHeHd8vv1RO6kCMidVLppnjKD0M0UxSpOPgvWTr2oVTQ7dt
         drCasBNi+btMLKxQikLm0MnITvwrR690vdLwBEzRnfLSa810WmZ0n5GuOcSkxdljXB
         N+rh0HE8wQLw4izadzGDHpw2y6TbFyJaloV3g+B9N4qQVNsAbLjExZ/DGYVpzWXprc
         1D6inbUSI3FzpLAOtSK0IRF3qW48z5N0DLcKbYUYq43G0SBbirshpnYPR9ceAVkSTW
         BJaWzQKSxPP0Q==
Message-ID: <e42b78a2-2b0f-1934-b71d-21bb94a01eed@collabora.com>
Date:   Tue, 22 Aug 2023 19:40:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.17 127/298] driver core: Fix wait_for_device_probe() &
 deferred_probe_timeout interaction
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Stultz <jstultz@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Ferry Toth <fntoth@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-pm@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        =?UTF-8?Q?Ricardo_Ca=c3=b1uelo_Navarro?= 
        <ricardo.canuelo@collabora.com>,
        Guillaume Charles Tucker <guillaume.tucker@collabora.com>,
        usama.anjum@collabora.com, kernelci@lists.linux.dev
References: <20220613094924.913340374@linuxfoundation.org>
 <20220613094928.793712131@linuxfoundation.org>
 <6283c4b1-2513-207d-4ed6-fdabf3f3880e@collabora.com>
 <2023081619-slapping-congrats-8e85@gregkh>
 <471bf84d-9d58-befc-8224-359a62e29786@collabora.com>
 <CAGETcx-NVoN7b8XCV09ouof81XxZk4wtGhEcqcFAt6Gs=JWKdw@mail.gmail.com>
 <d8f8ddf6-8063-fb3a-7dad-4064a47c5fe8@collabora.com>
 <CAGETcx-DUm417mM-Nmyqj-e_rKUw69m=rTe5R6_Vxd_rsKMmGg@mail.gmail.com>
 <97b06c78-da3c-d8ab-ca72-ff37b9976f2a@collabora.com>
 <6d7a7ecc-1364-5cbe-0485-01d693dbdc6c@arm.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <6d7a7ecc-1364-5cbe-0485-01d693dbdc6c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 21/08/23 18:09, Robin Murphy wrote:
> On 2023-08-21 12:35, Shreeya Patel wrote:
>>
>> On 19/08/23 01:49, Saravana Kannan wrote:
>>> On Thu, Aug 17, 2023 at 4:13 PM Shreeya Patel
>>> <shreeya.patel@collabora.com> wrote:
>>>> Hi Geert, Saravana,
>>>>
>>>> On 18/08/23 00:03, Saravana Kannan wrote:
>>>>> On Thu, Aug 17, 2023 at 4:37 AM Shreeya Patel
>>>>> <shreeya.patel@collabora.com> wrote:
>>>>>> Hi Greg,
>>>>>>
>>>>>> On 16/08/23 20:33, Greg Kroah-Hartman wrote:
>>>>>>> On Wed, Aug 16, 2023 at 03:09:27PM +0530, Shreeya Patel wrote:
>>>>>>>> On 13/06/22 15:40, Greg Kroah-Hartman wrote:
>>>>>>>>> From: Saravana Kannan<saravanak@google.com>
>>>>>>>>>
>>>>>>>>> [ Upstream commit 5ee76c256e928455212ab759c51d198fedbe7523 ]
>>>>>>>>>
>>>>>>>>> Mounting NFS rootfs was timing out when deferred_probe_timeout 
>>>>>>>>> was
>>>>>>>>> non-zero [1].  This was because ip_auto_config() initcall 
>>>>>>>>> times out
>>>>>>>>> waiting for the network interfaces to show up when
>>>>>>>>> deferred_probe_timeout was non-zero. While ip_auto_config() calls
>>>>>>>>> wait_for_device_probe() to make sure any currently running 
>>>>>>>>> deferred
>>>>>>>>> probe work or asynchronous probe finishes, that wasn't 
>>>>>>>>> sufficient to
>>>>>>>>> account for devices being deferred until deferred_probe_timeout.
>>>>>>>>>
>>>>>>>>> Commit 35a672363ab3 ("driver core: Ensure 
>>>>>>>>> wait_for_device_probe() waits
>>>>>>>>> until the deferred_probe_timeout fires") tried to fix that by 
>>>>>>>>> making
>>>>>>>>> sure wait_for_device_probe() waits for deferred_probe_timeout 
>>>>>>>>> to expire
>>>>>>>>> before returning.
>>>>>>>>>
>>>>>>>>> However, if wait_for_device_probe() is called from the 
>>>>>>>>> kernel_init()
>>>>>>>>> context:
>>>>>>>>>
>>>>>>>>> - Before deferred_probe_initcall() [2], it causes the boot 
>>>>>>>>> process to
>>>>>>>>>       hang due to a deadlock.
>>>>>>>>>
>>>>>>>>> - After deferred_probe_initcall() [3], it blocks kernel_init() 
>>>>>>>>> from
>>>>>>>>>       continuing till deferred_probe_timeout expires and beats 
>>>>>>>>> the point of
>>>>>>>>>       deferred_probe_timeout that's trying to wait for 
>>>>>>>>> userspace to load
>>>>>>>>>       modules.
>>>>>>>>>
>>>>>>>>> Neither of this is good. So revert the changes to
>>>>>>>>> wait_for_device_probe().
>>>>>>>>>
>>>>>>>>> [1] 
>>>>>>>>> -https://lore.kernel.org/lkml/TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com/
>>>>>>>>> [2] 
>>>>>>>>> -https://lore.kernel.org/lkml/YowHNo4sBjr9ijZr@dev-arch.thelio-3990X/ 
>>>>>>>>>
>>>>>>>>> [3] -https://lore.kernel.org/lkml/Yo3WvGnNk3LvLb7R@linutronix.de/
>>>>>>>> Hi Saravana, Greg,
>>>>>>>>
>>>>>>>>
>>>>>>>> KernelCI found this patch causes the 
>>>>>>>> baseline.bootrr.deferred-probe-empty test to fail on 
>>>>>>>> r8a77960-ulcb,
>>>>>>>> see the following details for more information.
>>>>>>>>
>>>>>>>> KernelCI dashboard link:
>>>>>>>> https://linux.kernelci.org/test/plan/id/64d2a6be8c1a8435e535b264/
>>>>>>>>
>>>>>>>> Error messages from the logs :-
>>>>>>>>
>>>>>>>> + UUID=11236495_1.5.2.4.5
>>>>>>>> + set +x
>>>>>>>> + export 
>>>>>>>> 'PATH=/opt/bootrr/libexec/bootrr/helpers:/lava-11236495/1/../bin:/sbin:/usr/sbin:/bin:/usr/bin'
>>>>>>>> + cd /opt/bootrr/libexec/bootrr
>>>>>>>> + sh helpers/bootrr-auto
>>>>>>>> e6800000.ethernet
>>>>>>>> e6700000.dma-controller
>>>>>>>> e7300000.dma-controller
>>>>>>>> e7310000.dma-controller
>>>>>>>> ec700000.dma-controller
>>>>>>>> ec720000.dma-controller
>>>>>>>> fea20000.vsp
>>>>>>>> feb00000.display
>>>>>>>> fea28000.vsp
>>>>>>>> fea30000.vsp
>>>>>>>> fe9a0000.vsp
>>>>>>>> fe9af000.fcp
>>>>>>>> fea27000.fcp
>>>>>>>> fea2f000.fcp
>>>>>>>> fea37000.fcp
>>>>>>>> sound
>>>>>>>> ee100000.mmc
>>>>>>>> ee140000.mmc
>>>>>>>> ec500000.sound
>>>>>>>> /lava-11236495/1/../bin/lava-test-case
>>>>>>>> <8>[   17.476741] <LAVA_SIGNAL_TESTCASE 
>>>>>>>> TEST_CASE_ID=deferred-probe-empty RESULT=fail>
>>>>>>>>
>>>>>>>> Test case failing :-
>>>>>>>> Baseline Bootrr deferred-probe-empty test 
>>>>>>>> -https://github.com/kernelci/bootrr/blob/main/helpers/bootrr-generic-tests
>>>>>>>>
>>>>>>>> Regression Reproduced :-
>>>>>>>>
>>>>>>>> Lava job after reverting the commit 5ee76c256e92
>>>>>>>> https://lava.collabora.dev/scheduler/job/11292890
>>>>>>>>
>>>>>>>>
>>>>>>>> Bisection report from KernelCI can be found at the bottom of 
>>>>>>>> the email.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Shreeya Patel
>>>>>>>>
>>>>>>>> #regzbot introduced: 5ee76c256e92
>>>>>>>> #regzbot title: KernelCI: Multiple devices deferring on 
>>>>>>>> r8a77960-ulcb
>>>>>>>>
>>>>>>>> --------------------------------------------------------------------------------------------------------------------------------------------------- 
>>>>>>>>
>>>>>>>>
>>>>>>>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * **
>>>>>>>> * If you do send a fix, please include this trailer: *
>>>>>>>> * Reported-by: "kernelci.org bot" <bot@...> *
>>>>>>>> * *
>>>>>>>> * Hope this helps! *
>>>>>>>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>>>>>>>
>>>>>>>> stable-rc/linux-5.10.y bisection: 
>>>>>>>> baseline.bootrr.deferred-probe-empty on
>>>>>>>> r8a77960-ulcb
>>>>>>> You are testing 5.10.y, yet the subject says 5.17?
>>>>>>>
>>>>>>> Which is it here?
>>>>>> Sorry, I accidentally used the lore link for 5.17 while reporting 
>>>>>> this
>>>>>> issue,
>>>>>> but this test does fail on all the stable releases from 5.10 
>>>>>> onwards.
>>>>>>
>>>>>> stable 5.15 :-
>>>>>> https://linux.kernelci.org/test/case/id/64dd156a5ac58d0cf335b1ea/
>>>>>> mainline :-
>>>>>> https://linux.kernelci.org/test/case/id/64dc13d55cb51357a135b209/
>>>>>>
>>>>> Shreeya, can you try the patch Geert suggested and let us know if it
>>>>> helps? If not, then I can try to take a closer look.
>>>> I tried to test the kernel with 9be4cbd09da8 but it didn't change the
>>>> result.
>>>> https://lava.collabora.dev/scheduler/job/11311615
>>>>
>>>> Also, I am not sure if this can change things but just FYI, KernelCI
>>>> adds some kernel parameters when running these tests and one of the
>>>> parameter is deferred_probe_timeout=60.
>>> Ah this is good to know.
>>>
>>>> You can check this in the definition details given in the Lava job. I
>>>> also tried to remove this parameter and rerun the test but again I got
>>>> the same result.
>>> How long does the test wait after boot before checking for the
>>> deferred devices list?
>>>
>>
>> AFAIK, script for running the tests is immediately ran after the boot 
>> process is complete so there is no wait time.
>
> Regardless of what the kernel is doing, it seems like a fundamentally 
> dumb test to specifically ask deferred probe to wait for up to a 
> minute then complain that it hasn't finished after 11 seconds :/
>
> If anything, it seems plausible that the "regression" might actually 
> be the correct behaviour, and it was wrong before. I can't manage to 
> pull up a boot log for a pre-5.10 kernel since all the async stuff on 
> the KernelCI dashboard always just times out for me with a helpful 
> "Error while loading data from the server (error code: 0)", but what 
> would be interesting is whether those devices on the list are expected 
> to successfully probe anyway - the mainline log below also shows other 
> stuff failing to probe and CPUs failing to come online, so it's 
> clearly not a very happy platform to begin with.
>

Sorry about the dashboard issues you are facing, KernelCI team is 
working on a new dashboard which will fix all of these issues. But we 
need to wait for it be ready for some more time.


Your point makes sense and that is why we did a test to add some sleep 
time of 60-65 seconds before running the tests and it actually fixed the 
problem. There are no more deferred devices as you can see in the 
following job.
https://lava.collabora.dev/scheduler/job/11330931

This change, to add deferred_probe_timeout=60 as kernel parameter was 
recently added in KernelCI since there were number of devices failing to 
probe on different platforms, specifically for chromebooks.
Unfortunately, no one realized to change the start of the test time and 
hence these issues are seen now on different platforms.

Thanks for pointing it out, it will help us to eliminate quite many 
deferred probe test failures that we are seeing.

Saravana, thanks to you as well for asking the valid questions about 
when the test starts running.

Thanks,
Shreeya Patel


#regzbot resolve: Nothing is broken due to the patch, a fix is needed on 
the KernelCI side.

> Robin.
>
>>>> I will try to add 9be4cbd09da8 to mainline kernel and see what 
>>>> results I
>>>> get.
>>> Now I'm confused. What do you mean by mainline? Are you saying the tip
>>> of tree of Linus's tree is also hitting this issue?
>>
>>
>> KernelCI runs tests on different kernel branches and trees, we also 
>> have this same test running on mainline tree.
>> Following is the link to the dashboard for it and as you can see, it 
>> does fail there too.
>>
>>
>> https://linux.kernelci.org/test/case/id/64dc13d55cb51357a135b209/
>>
>>
>>> -Saravana
>>>
>
