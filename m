Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597F67F288C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjKUJTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjKUJTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:19:10 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847C8C1;
        Tue, 21 Nov 2023 01:19:06 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r5MuO-0008PA-QI; Tue, 21 Nov 2023 10:19:04 +0100
Message-ID: <b9d4ab02-fe49-48ab-bf74-0c7a578e891a@leemhuis.info>
Date:   Tue, 21 Nov 2023 10:19:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: sysfs: cannot create duplicate filename
 .../system76_acpi::kbd_backlight/color
Content-Language: en-US, de-DE
To:     Takashi Iwai <tiwai@suse.de>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux LEDs <linux-leds@vger.kernel.org>,
        Tim Crawford <tcrawford@system76.com>,
        Jeremy Soller <jeremy@system76.com>,
        System76 Product Development <productdev@system76.com>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?Q?Johannes_Pen=C3=9Fel?= <johannes.penssel@gmail.com>
References: <b5646db3-acff-45aa-baef-df3f660486fb@gmail.com>
 <ZT25-gUmLl8MPk93@debian.me>
 <dc6264c4-d551-4913-a51b-72c22217f15a@traphandler.com>
 <ZUjnzB2RL2iLzIQG@debian.me> <87sf50pm34.wl-tiwai@suse.de>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <87sf50pm34.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700558346;75c0193b;
X-HE-SMSGID: 1r5MuO-0008PA-QI
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi, Jean-Jacques Hiblot, Lee,

On 20.11.23 14:53, Takashi Iwai wrote:
> On Mon, 06 Nov 2023 14:19:08 +0100,
> Bagas Sanjaya wrote:
>> On Sat, Nov 04, 2023 at 01:01:56PM +0100, Jean-Jacques Hiblot wrote:
>>> On 29/10/2023 02:48, Bagas Sanjaya wrote:
>>>> On Thu, Oct 26, 2023 at 02:55:06PM +0700, Bagas Sanjaya wrote:
>>>>> The culprit seems to be commit c7d80059b086c4986cd994a1973ec7a5d75f8eea, which introduces a new 'color' attribute for led sysfs class devices. The problem is that the system76-acpi platform driver tries to create the exact same sysfs attribute itself for the system76_acpi::kbd_backlight device, leading to the conflict. For testing purposes, I've just rebuilt the kernel with the system76-apci color attribute renamed to kb_color, and that fixes the issue.
>>>>
>>>> Jean-Jacques Hiblot, would you like to take a look on this regression,
>>>> since you authored the culprit?
>
>>> The offending commit stores the color in struct led_classdev and exposes it
>>> via sysfs. It was part of a series that create a RGB leds from multiple
>>> single-color LEDs. for this series, we need the color information but we
>>> don't really need to expose it it via sysfs. In order to fix the issue, we
>>> can remove the 'color' attribute from the sysfs.
>>
>> OK, see you in the patch!
> 
> Is there a patch available?

Not that I know of. Could not find anything on lore either.

> This bug hits for a few Logitech keyboard models, too, and it makes
> 6.6 kernel unsable for them, as hid-lg-g15 driver probe fails due to
> this bug:
>   https://bugzilla.kernel.org/show_bug.cgi?id=218155
> 
> We need a quick fix for 6.6.x.

Given that Jean-Jacques Hiblot (the author of the culprit) and Lee (who
committed it and sent it to Linus) know about this for a while already
without doing anything about it, I wonder if someone should just send a
revert to Linus (unless of course that is likely to introduce a
regression on its own).

Takashi, could you maybe do this, unless a fix shows up real soon?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: /me should have followed up on this earlier... :-/
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
