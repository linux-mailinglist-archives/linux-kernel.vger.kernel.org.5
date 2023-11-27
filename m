Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144197F9E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjK0L1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjK0L1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:27:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DB9A186;
        Mon, 27 Nov 2023 03:27:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE4B22F4;
        Mon, 27 Nov 2023 03:28:23 -0800 (PST)
Received: from [10.57.71.110] (unknown [10.57.71.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDAFC3F73F;
        Mon, 27 Nov 2023 03:27:33 -0800 (PST)
Message-ID: <8ffb32c8-907c-4266-b8be-c7309418b9f0@arm.com>
Date:   Mon, 27 Nov 2023 11:27:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Content-Language: en-US
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
References: <2023112453-flagstick-bullring-8511@gregkh>
 <20231124185725.GA872366@pengutronix.de> <2023112520-paper-image-ef5d@gregkh>
 <20231125085038.GA877872@pengutronix.de>
 <2023112506-unselfish-unkind-adcb@gregkh>
 <ZWHM0lRPOp/efyD5@finisterre.sirena.org.uk>
 <2023112541-uptown-tripping-05f3@gregkh>
 <ZWIWBhBN8AmK7tAJ@finisterre.sirena.org.uk>
 <2023112504-cathedral-pulmonary-83ce@gregkh>
 <ZWMaMIGUo9DeyEH+@finisterre.sirena.org.uk>
 <20231126193125.GB877872@pengutronix.de>
From:   Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20231126193125.GB877872@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2023 19:31, Oleksij Rempel wrote:
> On Sun, Nov 26, 2023 at 10:14:45AM +0000, Mark Brown wrote:
>> On Sat, Nov 25, 2023 at 07:58:12PM +0000, Greg Kroah-Hartman wrote:
>>> On Sat, Nov 25, 2023 at 03:43:02PM +0000, Mark Brown wrote:
>>>> On Sat, Nov 25, 2023 at 02:35:41PM +0000, Greg Kroah-Hartman wrote:
>>
>>>>> That would be great, but I don't see that here, do you?  All I see is
>>>>> the shutdown sequence changing because someone wants it to go "faster"
>>>>> with the threat of hardware breaking if we don't meet that "faster"
>>>>> number, yet no knowledge or guarantee that this number can ever be known
>>>>> or happen.
>>
>>>> The idea was to have somewhere to send notifications when the hardware
>>>> starts reporting things like power supplies starting to fail.  We do
>>>> have those from hardware, we just don't do anything terribly useful
>>>> with them yet.
>>
>>> Ok, but that's not what I recall this patchset doing, or did I missing
>>> something?  All I saw was a "reorder the shutdown sequence" set of
>>> changes.  Or at least that's all I remember at this point in time,
>>> sorry, it's been a few days, but at least that lines up with what the
>>> Subject line says above :)
>>
>> That's not in the series, a bunch of it is merged in some form (eg, see
>> hw_protection_shutdown()) and more of it would need to be built on top
>> if this were merged.
> 
> The current kernel has enough infrastructure to manage essential functions
> related to hardware protection:
> - The Device Tree specifies the source of interrupts for detecting
>   under-voltage events. It also details critical system regulators and some
>   of specification of backup power supplied by the board.
> - Various frameworks within the kernel can identify critical hardware
>   conditions like over-temperature and under-voltage. Upon detection, these
>   frameworks invoke the hw_protection_shutdown() function.
> 
>>>>> Agreed, but I don't think this patch is going to actually work properly
>>>>> over time as there is no time values involved :)
> 
> If we're to implement a deadline for each shutdown call (as the requirement for
> "time values" suggests?), then prioritization becomes essential. Without
> establishing a shutdown order, the inclusion of time values might not be
> effectively utilized.  Am I overlooking anything in this regard?
> 
>>>> This seems to be more into the area of mitigation than firm solution, I
>>>> suspect users will be pleased if they can make a noticable dent in the
>>>> number of failures they're seeing.
>>
>>> Mitigation is good, but this patch series is just a hack by doing "throw
>>> this device type at the front of the shutdown list because we have
>>> hardware that crashes a lot" :)
> 
> The root of the issue seems to be the choice of primary storage device.
> 
> All storage technologies - HDD, SSD, eMMC, NAND - are vulnerable to power
> loss. The only foolproof safeguard is a backup power source, but this
> introduces its own set of challenges:

I disagree and would say that any storage device sold as "industrial" should
guarantee power-fail safety. Plus, you mentioned data loss isn't even your concern,
but the storage device fails/bricks.
> 
> 1. Batteries: While they provide a backup, they come with limitations like a
> finite number of charge cycles, sensitivity to temperature (a significant
> concern in industrial and automotive environments), higher costs, and
> increased device size. For most embedded applications, a UPS isn't a viable
> solution.
> 
> 2. Capacitors: A potential alternative, but they cannot offer prolonged
> backup time. Increasing the number of capacitors to extend backup time leads
> to additional issues:
>    - Increased costs and space requirements on the PCB.
>    - The need to manage partially charged capacitors during power failures.
>    - The requirement for a power supply capable of rapid charging.
>    - The risk of not reaching a safe state before the backup energy
>      depletes.
>    - In specific environments, like explosive atmospheres, storing large
>      amounts of energy can be hazardous.

And also just practically, ensuring a safe power down could be in the order
of a second, so it would be quite a capacitor.

> 
> Given these considerations, it's crucial to understand that such design choices
> aren't merely "hacks". They represent a balance between different types of
> trade-offs.
> 
>>>> It feels like if we're concerned about mitigating physical damage during
>>>> the process of power failure that's a very limited set of devices - the
>>>> storage case where we're in the middle of writing to flash or whatever
>>>> is the most obvious case.
>>
>>> Then why isn't userspace handling this?  This is a policy decision that
>>> it needs to take to properly know what hardware needs to be shut down,
>>> and what needs to happen in order to do that (i.e. flush, unmount,
>>> etc.?)  And userspace today should be able to say, "power down this
>>> device now!" for any device in the system based on the sysfs device
>>> tree, or at the very least, force it to a specific power state.  So why
>>> not handle this policy there?
>>
>> Given the tight timelines it does seem reasonable to have some of this
>> in the kernel - the specific decisions about how to handle these events
>> can always be controlled from userspace (eg, with a sysfs file like we
>> do for autosuspend delay times which seem to be in a similar ballpark).
> 
> Upon investigating the feasibility of a user space solution for eMMC
> power control, I've concluded that it's likely not possible. The primary
> issue is that most board designs don't include reset signaling for
> eMMCs. Additionally, the eMMC power rail is usually linked to the
> system's main power controller. While powering off is doable, cleanly
> powering it back on isn’t feasible. This is especially problematic when
> the rootfs is located on the eMMC, as power cycling the storage device
> could lead to system instability.
> 
> Therefore, any user space method to power off eMMC wouldn't be reliable
> or safe, as there's no way to ensure it can be turned back on without
> risking the integrity of the system. The design rationale is clear:
> avoiding the risks associated with powering off the primary storage
> device.
> 
> Considering these constraints, the only practical implementation I see
> is integrating this functionality into the system's shutdown sequence.
> This approach ensures a controlled environment for powering off the
> eMMC, avoiding potential issues.

You don't need the RST signal, in fact even if you had it it would be
the wrong thing to do. (Implementation is vendor-specific but RST
assumes that eMMCs' VCC and VCCQ are left untouched.)
You can try turning off eMMC cache completely and/or sending power down
notification on 'emergency shutdown', but since power-loss/fail behavior
is vendor-specific asking the storage device vendor how to ensure a safe
power-down.
Anyway the proper eMMC power-down methods are up to a second in timeouts,
so infeasible for your requirements from what I can see.

BR,
Christian
