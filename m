Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205A079C08C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245510AbjIKVJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243123AbjIKQvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:51:52 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F5B110;
        Mon, 11 Sep 2023 09:51:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id A74BA1007E0;
        Mon, 11 Sep 2023 16:51:40 +0000 (UTC)
Message-ID: <bf984d34-e9bd-c94f-e264-07ff8eca16e6@enpas.org>
Date:   Tue, 12 Sep 2023 01:51:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
From:   Max Staudt <max@enpas.org>
Subject: Re: [PATCH 2/2] hid-sony: DS3: Report analog buttons for Sixaxis
To:     Roderick Colenbrander <thunderbird2k@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Vicki Pfau <vi@endrift.com>,
        Pavel Rojtberg <rojtberg@gmail.com>,
        Roderick Colenbrander <roderick@gaikai.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230826152111.13525-1-max@enpas.org>
 <20230826152111.13525-3-max@enpas.org>
 <ec4d07de-4944-a7ea-2b74-c4162af75b16@enpas.org>
 <CAEc3jaDoRESqJ_6KAa6FHvbF=R4ZRV0P+=4KY5pjYPCrwroqCQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEc3jaDoRESqJ_6KAa6FHvbF=R4ZRV0P+=4KY5pjYPCrwroqCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roderick,

Thanks for pointing out the 2018 thread!

Since lore.kernel.org doesn't seem to have an archive of it, I hope this one is complete:

   https://www.spinics.net/lists/linux-input/msg57662.html


It's been 5 years since the thread you mentioned. There were many outstanding ideas, and yet as of today, Linux still has no support for pressure sensitive buttons. Hence, maybe we can find a "good enough" solution that covers most or all of what we've seen so far, without future-proofing too much?


My experience with controllers comes from sniffing and emulating wire protocols on older consoles, and from looking at the reports from USB devices such as DualShock 3. I presume you have a wider overview, but maybe we can complement each other here :)


As for keyboards, I think that we could simply report a pressure value in parallel with EV_KEY events - like you originally suggested. Maybe we can bundle the two using EV_SYN, given that I see my keyboard combining EV_MSC and EV_KEY in this manner?


As for gamepads, it seems to me like the world has converged to an Xbox360/PS3 style layout for the face buttons and joysticks. SDL, which is used for a vast array of games, maintains a mapping from raw evdev events onto a virtual Xbox 360 gamepad - gamecontrollerdb.txt - which allows games to consistently map, say, the NORTH button, according to the physical geometry rather than what evdev claims. This is something that unfortunately is not unified in the kernel UAPI, and now userspace needs to have knowledge of all devices.

The original thread mentioned the Gamecube controller. I feel that designs that stray from the Xbox360/PS3 layout, such as the Gamecube's separate digital buttons that are hidden beneath the triggers (beyond the 255 point), have disappeared. Please correct me if I'm too short-sighted, but since I don't see such designs on the horizon, I wouldn't worry about describing them in the kernel. Those buttons can be exported as e.g. L3/R3 (which the GC does not have), and userspace then needs to know about the odd physical geometry anyway. The geometry is really a separate property of the controller and breaks modern games' assumptions (see SDL above), so I'd worry about this on the kernel side only once this really comes up as a kernel problem.


There was the idea of Multitouch like event slots, to allow for future expandability. I like it. But do we really need this? We could always add this as yet another event type, or maybe even in a reserved zone within EV_PSB, but for now, all devices that I've seen report a value in the exact range 0-255, with 0 meaning that the button is released. I also don't remember seeing a controller that flakes in its idle state - it has always been a solid 0 when I released the buttons. A flaking button would currently report as EV_KEY 1 anyway, since e.g. the DS3 treats an analog reading of 1 as digital down, I believe.

Hence, how about simply adding an EV_PSB report in parallel with EV_KEY, and this report works exactly the same, except that the range is not 0-1, but 0-255? This keeps backwards compatibility through EV_KEY, and is easy to handle on all ends.


There was also the idea of an expandable array of PSB properties. In the end, it is still up to userspace to make sense of anything we feed it, and there are things we can add in retrospect, and things we can't add without breaking userspace's assumptions.

For example, which value is interpreted as "down" or "up" is something I'd again leave to userspace, or even the hardware itself - after all, up until now, userspace has happily lived with the kernel's binary EV_KEY. If we really want to, we can always add a non-binding "hint" or "suggestion" later.

The only thing I can see as really important right now is pretty much the same info as in input_absinfo - namely, the minimum/maximum values. If we avoid such a structure, and simply tell userspace that values are always 0-255, then we cannot change this afterwards.

But are there any devices that report PSB in a range that is not 0-255, or at least easily scaled into this range? DS2, DS3, Xbox face buttons are all 0-255. So are all L2/R2 triggers that I've seen. Do you know about controllers or keyboards that don't fit well in this range? If there are none, then we could skip describing minimum/maximum values, and cross our fingers for the future.


As for letting userspace detect which buttons support PSB, we could keep a bitmap like for EV_KEY. Or, we could guarantee (in the kernel driver spec) to always send EV_PSB before EV_KEY, and then userspace can dynamically learn which keys are PSBs. Since EV_PSB comes first, it can then ignore any following EV_KEY for that keycode. This way, we don't need to keep a key bitmap either.


As for high-speed chatter overloading the event pipeline, I'd report only changes to a button's value (just like EV_KEY and EV_ABS), not all buttons' state all the time, like the DS3/4 do in their wire protocols.


To avoid analog keyboards overloading classic event loops, I suggest hiding EV_PSB events until they are enabled via some ioctl() or write().



So many ideas, and I hope we can pare it down to an easy to manage minimum - maybe we can get away without any ioctl(EVIOCGPSR) at all :)



Thanks for your help!

Max

