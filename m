Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F300D7900EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348373AbjIAQsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347241AbjIAQsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:48:40 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF5910FD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 09:48:32 -0700 (PDT)
Date:   Fri, 01 Sep 2023 16:48:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail3; t=1693586910; x=1693846110;
        bh=WilzynXfIjeYBBxn3KF8I+zEPTz6CizTqABslRcHX3c=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=Q/KXRm4AvicJzFZb6NTLhCld+4w+WMopTVlJlWgUY91WYLgU6hGB5nBZi6xW8QUL+
         eO7baepjx8AqaEJ8f0WHr3Ig0nHqh2eDgwiYfAgeNJ+vfYswwfNB/VR5i5uTzqzhL4
         xzKlqrpvDFBO+i6SFcd6zi8v3Es2sFB3XHmTze2eiC4iEf6LkDWZADTWWO0WnWpa+B
         YYNoNgexWlECbB+NEn5fVKLROL3qnIgZ032J66p/6CoDRVEYeh9HxlJC3ghOGrvlzJ
         NipYHg1idDWzl4JL9PY7j0QDrqODnEDqZGLg+G6MmEldrjzmwkHknhq0oDUkuBoWg6
         8CIkrjnNiuRdQ==
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.de>
From:   Waldek Andrukiewicz <waldek.social@pm.me>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v2 00/11] Fix support for System Suspend for CS35L41 HDA
Message-ID: <03a70489-3a68-4c37-8f72-569bcd7463c4@pm.me>
Feedback-ID: 6286898:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28.07.23 15:55, Stefan Binding wrote:
>
> On 28/07/2023 12:10, Takashi Iwai wrote:
>> On Mon, 24 Jul 2023 11:00:38 +0200,
>> Takashi Iwai wrote:
>>> On Fri, 21 Jul 2023 17:18:05 +0200,
>>> Stefan Binding wrote:
>>>> There have been a couple of customer reports of intermittant issues
>>>> after
>>>> system resume, where sometimes the DSP firmware stops responding.
>>>> Investigations into this issue show that there is a race between
>>>> receiving
>>>> a prepare from the HDA core, and the firmware reload which is
>>>> started by
>>>> the system resume. This can causes the Global Enable on the CS35L41
>>>> to be
>>>> enabled during the firmware load, which can sometimes cause issues
>>>> in the
>>>> DSP.
>>>>
>>>> The existing system resume behaviour also did not resume the audio, if
>>>> audio was previously playing when it was suspended.
>>>> In addition, during investigation, it was found there were additional
>>>> problems in the System Resume sequence, as well as the Playback
>>>> sequence
>>>> with External Boost, where the driver does not correctly follow its
>>>> enable sequence for this mode. This can cause additional issues
>>>> such as
>>>> pops and clicks.
>>>>
>>>> This chain intends to correct the sequences for playback and system
>>>> suspend/resume so that the driver: obeys the external boost enable
>>>> sequence;
>>>> resumes audio on system resume; and avoids the race condition on
>>>> firmware
>>>> load and playback during system resume.
>>>>
>>>> Changes since v1:
>>>> - Split patch 1 into 2 separate patches
>>>> - Combine Patches 6 and 9
>>>>
>>>> Stefan Binding (11):
>>>> =C2=A0=C2=A0 ALSA: cs35l41: Use mbox command to enable speaker output =
for
>>>> external
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 boost
>>>> =C2=A0=C2=A0 ALSA: cs35l41: Poll for Power Up/Down rather than waiting=
 a fixed
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 delay
>>>> =C2=A0=C2=A0 ALSA: hda: cs35l41: Check mailbox status of pause command=
 after
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 firmware load
>>>> =C2=A0=C2=A0 ALSA: hda: cs35l41: Ensure we correctly re-sync regmap be=
fore
>>>> system
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 suspending.
>>>> =C2=A0=C2=A0 ALSA: hda: cs35l41: Ensure we pass up any errors during s=
ystem
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 suspend.
>>>> =C2=A0=C2=A0 ALSA: hda: cs35l41: Move Play and Pause into separate fun=
ctions
>>>> =C2=A0=C2=A0 ALSA: hda: hda_component: Add pre and post playback hooks=
 to
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 hda_component
>>>> =C2=A0=C2=A0 ALSA: hda: cs35l41: Use pre and post playback hooks
>>>> =C2=A0=C2=A0 ALSA: hda: cs35l41: Rework System Suspend to ensure corre=
ct call
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 separation
>>>> =C2=A0=C2=A0 ALSA: hda: cs35l41: Add device_link between HDA and cs35l=
41_hda
>>>> =C2=A0=C2=A0 ALSA: hda: cs35l41: Ensure amp is only unmuted during pla=
yback
>>> Applied all patches now to for-next branch.
>> It seems that this patch set causes occasional freeze at suspend:
>> =C2=A0=C2=A0 https://bugzilla.suse.com/show_bug.cgi?id=3D1213745
>>
>> Could you take a look?
>>
>>
>> thanks,
>>
>> Takashi
>
> Hi Takashi,
>
> The initial bug report shows one of the original issues that this patch
> chain was trying to fix.
> From what I can tell from the second issue, something has caused the
> CS35L41 to stop responding,
> which in turn caused the system suspend call to fail, and the error is
> passed up. Since system suspend
> failed, there was no corresponding system resume, which means the
> CS35L41 was stuck broken.
>
> I'm not sure what was meant by "freeze" and "overheating" in the bug
> report, since the log seems to
> indicate the laptop is still responsive, even if audio is broken.
>
> There is some oddity in the log, since one of the errors that was
> printed should only be printed when
> the CS35L41 is using External Boost, but I think this laptop is supposed
> to use Internal Boost.
> We'll investigate further.
>
> Thanks,
>
> Stefan Binding


Hello,

I would like to inform you that (one of) those patches is probably
breaking sound on Lenovo Legion 7 16ACHg6. They were applied in Manjaro
Linux kernel here:

https://gitlab.manjaro.org/packages/core/linux64/-/commit/742e66f525170fe02=
dec42e47aedf53d3dc85195

and when I install this kernel, there is no sound anymore. There is
nothing more than those patches in this commit. A kernel compiled from
the previous commit works fine.

Sound used to work fine from 5.17 if I remember correctly.

I hope I replied correctly to this thread, if not, apologies.

Best Regards,

Waldek Andrukiewicz



