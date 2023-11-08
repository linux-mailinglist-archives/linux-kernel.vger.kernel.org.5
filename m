Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360097E6072
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 23:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjKHWcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 17:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjKHWcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 17:32:07 -0500
Received: from mailout1n.rrzn.uni-hannover.de (mailout1n.rrzn.uni-hannover.de [130.75.2.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B4A211B;
        Wed,  8 Nov 2023 14:32:04 -0800 (PST)
Received: from mbp (dynamic-095-112-074-036.95.112.pool.telefonica.de [95.112.74.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailout1n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id 099EA38D;
        Wed,  8 Nov 2023 23:32:01 +0100 (CET)
From:   ostapyshyn@sra.uni-hannover.de
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Nils Fuhler <nils@nilsfuhler.de>, davidrevoy@protonmail.com,
        folays@gmail.com, jason.gerecke@wacom.com, jkosina@suse.cz,
        jose.exposito89@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, ostapyshyn@sra.uni-hannover.de
Subject: Re: Requesting your attention and expertise regarding a
 Tablet/Kernel issue
In-Reply-To: <CAO-hwJ+b4q+8g=Cg5MRJQT2EsxkFZrK_XgJqmHWm=GBHskhDqQ@mail.gmail.com>
        (Benjamin Tissoires's message of "Wed, 8 Nov 2023 21:34:07 +0100")
References: <CAO-hwJK_xp1A=dEOV-2v3KJAf0bRLDWNcrFQeBpgEuxT-qSBnw@mail.gmail.com>
        <20231108194051.279435-2-nils@nilsfuhler.de>
        <CAO-hwJ+b4q+8g=Cg5MRJQT2EsxkFZrK_XgJqmHWm=GBHskhDqQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date:   Wed, 08 Nov 2023 23:31:36 +0100
Message-ID: <87zfzndghj.fsf@sra.uni-hannover.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.9 at mailout1n
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 21:34, Benjamin Tissoires wrote:

> Again, you convinced me that this commit was wrong. If people needs to
> also use an ioctl to "fix" it, then there is something wrong.

I don't think we're on the same page here.  Nobody needs to use an ioctl
to fix 276e14e6c3.  Rather, the _exact opposite_: the bug reporter used
an ioctl to remap Eraser to BTN_STYLUS2.  It stopped working after
276e14e6c3 and broke his workflow.  He reported it as a regression,
starting this whole thread.

> Sorry but I tend to disagree. Relying on the ioctl EVIOCSKEYCODE for
> tuning the behavior of a state machine is just plain wrong. When
> people do that, they are doing it at the wrong level and introducing
> further bugs.
>
> The whole pen and touch HID protocols rely on a state machine. You
> just can not change the meaning of it because your hardware maker
> produced a faulty hardware.
>
> [...]
>
> In the same way, if you remap Tip Switch to KEY-A, you won't get
> clicks from your pen. Assuming you can do that with any event on any
> HID device is just plain wrong.
> That ioctl is OK-ish for "remapping" simple things like keys. In our
> case, the whole firmware follows a state machine, so we can not change
> it. It has to be remapped in a later layer, in libinput, your
> compositor, or in your end user application.

I don't disagree.  Forbidding EVIOCSKEYCODE ioctls for pen and touch HID
is a legitimate way to resolve this (an appealing one too -- accounting
for it in hidinput_hid_event might be a hellish task).

Should we forbid remapping Eraser too?  If your answer is yes, then we
can finish this conversation here and leave the code as it is now,
because __the regression__ is a user not being able to use an ioctl to
remap Eraser after 276e14e6c3.  Otherwise, if we do make an exemption for
David's Eraser, the fix is as simple as replacing BTN_TOUCH with
usage->code on line 1594 of hid-input.c.

> How many of such devices do we have? Are they all UGTablet like the
> XP-PEN? Are they behaving properly on Windows without a proprietary
> driver?
>
> [...]
>
> I might buy the "invertless" devices are a thing if I can get more
> data about it. So far there are only 2 of them, and they add extra
> complexity in the code when we can just patch the devices to do the
> right thing.

There might or might not be more devices like this in the wild.  It looks
like BarrelSwitch2 was added only 2013 [1], which is why so many styli
use Eraser for the second button.  Setting two bits for a single button
just to adhere to Microsoft's *recommendation* is nice for compatibility,
but I can imagine vendors taking a shortcut and omitting Invert
altogether.  The HID specification alone just lists the usages and says
nothing about how they relate to each other.

XP-Pen Artist 24 does work on Windows with the generic driver.  The
Eraser engages as soon as the button is pressed, without touching the
screen.

> New hardware isn't supposed to be supported on an old kernel and is
> not considered as a regression. However, David mentioned that the
> device was "working" on 6.5.0 but broke in 6.5.8 with the patch
> mentioned above. This is a regression that needs to be tackled.
> Especially because it was introduced in 6.6 but backported into 6.5.

To make sure we're talking about the same thing:

1. "Broke" in this context means that the ioctl remapping from Eraser to
   right-click stopped working.

2. XPPen 16 Pro Gen2 is a whole different topic, untouched by 276e14e6c3.

[1] https://www.usb.org/sites/default/files/hutrr46e.txt
