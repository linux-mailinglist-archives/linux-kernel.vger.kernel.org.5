Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EB577F561
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350342AbjHQLhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350259AbjHQLhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:37:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC94F7;
        Thu, 17 Aug 2023 04:37:09 -0700 (PDT)
Received: from [IPV6:2405:201:0:21ea:73f6:2283:f432:3936] (unknown [IPv6:2405:201:0:21ea:73f6:2283:f432:3936])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 38DD7660722C;
        Thu, 17 Aug 2023 12:37:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692272227;
        bh=XpsLoLdD24V/VCEZfFfWZMx9/FmqcYIRq7T56uKXZkM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dezbTy3ssM+3ssPGsT3JQhck6ieWjEz8Pt1eVIZWl6rtFNAOrVAkHyGYhRsGl92iE
         3P18wyUzp+DFCjjDzoyUWQ//8oeo1GPJ5EkFFhAEja/Ul9YTVgdI6TNLs8zpKnwsbK
         mNL53o+EadUuMa1ZF70cWv8s5uL9NEgzR7IEa6PbZpOY4k232U1L8JVObPpwnvtB9/
         zrfkA3rYNn2ydvjILvWrs3GYaC22C96IRqnsvgpA2O7vdc2rjJNYVo3Q/0sOq5SZKT
         YbE/Ygr3JfhLIHe5Sdj5hx7W/6AmWayTOzUvPl8O1Vq7qGZrzJ8mrM1lGXEHUdkBGq
         t3fEPB7HvgLpQ==
Message-ID: <471bf84d-9d58-befc-8224-359a62e29786@collabora.com>
Date:   Thu, 17 Aug 2023 17:06:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.17 127/298] driver core: Fix wait_for_device_probe() &
 deferred_probe_timeout interaction
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     saravanak@google.com, stable@vger.kernel.org,
        John Stultz <jstultz@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Ferry Toth <fntoth@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-pm@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <2023081619-slapping-congrats-8e85@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 16/08/23 20:33, Greg Kroah-Hartman wrote:
> On Wed, Aug 16, 2023 at 03:09:27PM +0530, Shreeya Patel wrote:
>> On 13/06/22 15:40, Greg Kroah-Hartman wrote:
>>> From: Saravana Kannan<saravanak@google.com>
>>>
>>> [ Upstream commit 5ee76c256e928455212ab759c51d198fedbe7523 ]
>>>
>>> Mounting NFS rootfs was timing out when deferred_probe_timeout was
>>> non-zero [1].  This was because ip_auto_config() initcall times out
>>> waiting for the network interfaces to show up when
>>> deferred_probe_timeout was non-zero. While ip_auto_config() calls
>>> wait_for_device_probe() to make sure any currently running deferred
>>> probe work or asynchronous probe finishes, that wasn't sufficient to
>>> account for devices being deferred until deferred_probe_timeout.
>>>
>>> Commit 35a672363ab3 ("driver core: Ensure wait_for_device_probe() waits
>>> until the deferred_probe_timeout fires") tried to fix that by making
>>> sure wait_for_device_probe() waits for deferred_probe_timeout to expire
>>> before returning.
>>>
>>> However, if wait_for_device_probe() is called from the kernel_init()
>>> context:
>>>
>>> - Before deferred_probe_initcall() [2], it causes the boot process to
>>>     hang due to a deadlock.
>>>
>>> - After deferred_probe_initcall() [3], it blocks kernel_init() from
>>>     continuing till deferred_probe_timeout expires and beats the point of
>>>     deferred_probe_timeout that's trying to wait for userspace to load
>>>     modules.
>>>
>>> Neither of this is good. So revert the changes to
>>> wait_for_device_probe().
>>>
>>> [1] -https://lore.kernel.org/lkml/TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com/
>>> [2] -https://lore.kernel.org/lkml/YowHNo4sBjr9ijZr@dev-arch.thelio-3990X/
>>> [3] -https://lore.kernel.org/lkml/Yo3WvGnNk3LvLb7R@linutronix.de/
>> Hi Saravana, Greg,
>>
>>
>> KernelCI found this patch causes the baseline.bootrr.deferred-probe-empty test to fail on r8a77960-ulcb,
>> see the following details for more information.
>>
>> KernelCI dashboard link:
>> https://linux.kernelci.org/test/plan/id/64d2a6be8c1a8435e535b264/
>>
>> Error messages from the logs :-
>>
>> + UUID=11236495_1.5.2.4.5
>> + set +x
>> + export 'PATH=/opt/bootrr/libexec/bootrr/helpers:/lava-11236495/1/../bin:/sbin:/usr/sbin:/bin:/usr/bin'
>> + cd /opt/bootrr/libexec/bootrr
>> + sh helpers/bootrr-auto
>> e6800000.ethernet	
>> e6700000.dma-controller	
>> e7300000.dma-controller	
>> e7310000.dma-controller	
>> ec700000.dma-controller	
>> ec720000.dma-controller	
>> fea20000.vsp	
>> feb00000.display	
>> fea28000.vsp	
>> fea30000.vsp	
>> fe9a0000.vsp	
>> fe9af000.fcp	
>> fea27000.fcp	
>> fea2f000.fcp	
>> fea37000.fcp	
>> sound	
>> ee100000.mmc	
>> ee140000.mmc	
>> ec500000.sound	
>> /lava-11236495/1/../bin/lava-test-case
>> <8>[   17.476741] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=deferred-probe-empty RESULT=fail>
>>
>> Test case failing :-
>> Baseline Bootrr deferred-probe-empty test -https://github.com/kernelci/bootrr/blob/main/helpers/bootrr-generic-tests
>>
>> Regression Reproduced :-
>>
>> Lava job after reverting the commit 5ee76c256e92
>> https://lava.collabora.dev/scheduler/job/11292890
>>
>>
>> Bisection report from KernelCI can be found at the bottom of the email.
>>
>> Thanks,
>> Shreeya Patel
>>
>> #regzbot introduced: 5ee76c256e92
>> #regzbot title: KernelCI: Multiple devices deferring on r8a77960-ulcb
>>
>> ---------------------------------------------------------------------------------------------------------------------------------------------------
>>
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * **
>> * If you do send a fix, please include this trailer: *
>> * Reported-by: "kernelci.org bot" <bot@...> *
>> * *
>> * Hope this helps! *
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>
>> stable-rc/linux-5.10.y bisection: baseline.bootrr.deferred-probe-empty on
>> r8a77960-ulcb
> You are testing 5.10.y, yet the subject says 5.17?
>
> Which is it here?

Sorry, I accidentally used the lore link for 5.17 while reporting this 
issue,
but this test does fail on all the stable releases from 5.10 onwards.

stable 5.15 :- 
https://linux.kernelci.org/test/case/id/64dd156a5ac58d0cf335b1ea/
mainline :- 
https://linux.kernelci.org/test/case/id/64dc13d55cb51357a135b209/

Thanks,
Shreeya Patel

>
> confused,
>
> greg k-h
>
