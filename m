Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B077E402A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjKGNkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjKGNko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:40:44 -0500
Received: from mailout1n.rrzn.uni-hannover.de (mailout1n.rrzn.uni-hannover.de [130.75.2.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B60C9F;
        Tue,  7 Nov 2023 05:40:41 -0800 (PST)
Received: from [10.23.33.142] (mmsrv.sra.uni-hannover.de [130.75.33.181])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailout1n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id D83B11B6;
        Tue,  7 Nov 2023 14:40:39 +0100 (CET)
Message-ID: <7bcf210f-c68f-4ffc-b84f-f4c47bdbbf62@sra.uni-hannover.de>
Date:   Tue, 7 Nov 2023 14:40:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel
 issue
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     David Revoy <davidrevoy@protonmail.com>, jkosina@suse.cz,
        jason.gerecke@wacom.com, jose.exposito89@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        nils@nilsfuhler.de, peter.hutterer@who-t.net, ping.cheng@wacom.com,
        bagasdotme@gmail.com
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
 <20231103200524.53930-1-ostapyshyn@sra.uni-hannover.de>
 <bokQB3BK040-4fGy8tNfZrdM2mNmWxZud9O-KMmYqOkfa1JTC1ocUjoAzCEpPsbsAvY5qb5TcSP6XsQLaja2XO0gapOcsZyeVdCvq6T31qA=@protonmail.com>
 <CAO-hwJLpKTb9yxvxaPDLZkF9kDF8u2VRJUf9yiQd+neOyxPeug@mail.gmail.com>
 <eb8e22f3-77dc-4923-a7ba-e237ee226edb@sra.uni-hannover.de>
 <CAO-hwJKVwZK00yZFjuyyR9Xt4Y2-r8eLJNZfnyeopHxoZQ0eGA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAO-hwJKVwZK00yZFjuyyR9Xt4Y2-r8eLJNZfnyeopHxoZQ0eGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.9 at mailout1n
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending again because the mail bounced from the mailing list due to the
attachment.

Benjamin Tissoires <benjamin.tissoires@redhat.com> writes:

> And BTW, if you have a tool affected by 276e14e6c3, I'd be curious to
> get a hid-recorder sample for it so I can get regression tests for it.

I have attached [3] the recording of me:

(1) Bringing the stylus in range, touching the screen with the tip and
    bringing the stylus out of range.

(2) Bringing the stylus in range, pressing the top barrel button and
    bringing the stylus out of range.

(3) Bringing the stylus in range, touching the screen with the tip again
    and bringing the stylus out of range.

The digitizer is the one of the two that David uses, XP-Pen Artist 24.
I don't have the other one with two erasers here, so we'd have to wait
for David's recording to investigate further.

If you revert 276e14e6c3, you can observe that after pressing the eraser
button, neither BTN_TOOL_PEN nor BTN_TOUCH events will appear in evdev
anymore for (3).

> I must confess, being the one who refactored everything, I still don't
> believe this is as simple as it may seem. I paged out all of the
> special cases, and now, without seeing the event flow I just can not
> understand why this would fix the situation.

David uses hwdb to remap Eraser (0xd0045) to BTN_STYLUS2 (0x14c) [1]:

evdev:input:b0003v28BDp092De0100-e0*
 KEYBOARD_KEY_d0045=0x14c

In the end, this translates to a hidinput_setkeycode with the respective
arguments, setting usage->code to BTN_STYLUS2.  In the current state,
doing so results in BTN_STYLUS2 being permanently set and never released
when pressing the top barrel switch.  You can replay and observe this
with the attached [3] recording.

The if statement [2] is there to release BTN_TOOL_RUBBER if the device
has no Invert, but only after BTN_TOUCH has been released.  Eraser with
value 0 releases BTN_TOUCH in the first iteration and BTN_TOOL_RUBBER in
the second (when BTN_TOUCH is not in input->key anymore).

The problem is that the condition assumes usage->code is BTN_TOUCH.
When this is not the case, (!test_bit(BTN_TOUCH, input->key)) is always
true, we release the tool and return prematurely.  Therefore,
usage->code is never released.

As such, BTN_TOOL_RUBBER is not the problem and does no harm (except for
maybe showing the rubber icon in Krita).  It is required, however, for a
functional eraser out of the box.  I think, in the HID_QUIRK_NOINVERT
case, BTN_TOOL_RUBBER should better be omitted if Eraser is remapped to
something else, like BTN_STYLUS2.  Hence the second proposal.

> So either the explanation was wrong, or it's not explaining the
> situation (I also understand that this is not a formal submission, so
> maybe that's the reason why the comment is not updated).

Right, the example was not meant as a formal submission, that's why I
didn't change the comment.  Sorry for that.  We should fix the comment
below it (line 1603) too after this is resolved.

Cheers,
Illia

[1]
https://www.davidrevoy.com/article842/review-xp-pen-artist-24-pro-on-linux
[2]
https://elixir.bootlin.com/linux/latest/source/drivers/hid/hid-input.c#L1594
[3] https://dl.uni-h.de/?t=dc4a5542a8e4d54964e298045a173049

