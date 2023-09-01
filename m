Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7D678FD1E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243081AbjIAMZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbjIAMZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:25:05 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E435F10F2;
        Fri,  1 Sep 2023 05:24:55 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1693571094; bh=r6Usb71alT0FYOYfRDio0CQvhmqFmN358TO+VG3cTGA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=wI42BDTKG4lDYBUe2BLd+0tomuEazLzUimeltIyzpkiswYHKOtCaf1SnXpJ4XcIG2
         R2lIPpir7l4asdVlXIC+rMPR4p3MgM1NxK28729BBoDGyBWz019ndm6CXYk3PcJmUF
         M6Ka+0fUsOnjnxvOj2cB69E3Vx/bRUktNzD6j2b3xMUzjYjbBTmULaajfV1iMFWV+p
         EBrdX1xI2HrkwFdHKYSiFD12eeF0FRWGF2w+uR7ZneUDqw7pc6AV1PVvtATK6EoavX
         RLYRgdUZ/3NNXUdy0od9ynfAj69BlO5EejLUNJgfZoxGlFmz/i3OdOMFxfWuYFhC5f
         u4BtfjXwJ+G4w==
To:     Dongliang Mu <dzm91@hust.edu.cn>, Kalle Valo <kvalo@kernel.org>,
        Sujith Manoharan <c_manoha@qca.qualcomm.com>,
        "John W. Linville" <linville@tuxdriver.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ath9k: fix null-ptr-deref in ath_chanctx_event
In-Reply-To: <f183e79c-692e-54b0-2018-bf63424d7908@hust.edu.cn>
References: <20230901080701.1705649-1-dzm91@hust.edu.cn>
 <87y1hqtbtu.fsf@toke.dk>
 <317b9482-d750-9093-e891-21f73feeac0c@hust.edu.cn>
 <87il8uta8f.fsf@toke.dk>
 <f183e79c-692e-54b0-2018-bf63424d7908@hust.edu.cn>
Date:   Fri, 01 Sep 2023 14:24:54 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87fs3yt71l.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dongliang Mu <dzm91@hust.edu.cn> writes:

> On 2023/9/1 19:16, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Dongliang Mu <dzm91@hust.edu.cn> writes:
>>
>>> On 2023/9/1 18:41, 'Toke H=C3=B8iland-J=C3=B8rgensen' via HUST OS Kernel
>>> Contribution wrote:
>>>> Dongliang Mu <dzm91@hust.edu.cn> writes:
>>>>
>>>>> Smatch reports:
>>>>>
>>>>> ath_chanctx_event() error: we previously assumed 'vif' could be null
>>>>>
>>>>> The function ath_chanctx_event can be called with vif argument as NUL=
L.
>>>>> If vif is NULL, ath_dbg can trigger a null pointer dereference.
>>>>>
>>>>> Fix this by adding a null pointer check.
>>>>>
>>>>> Fixes: 878066e745b5 ("ath9k: Add more debug statements for channel co=
ntext")
>>>>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>>>>> ---
>>>>>    drivers/net/wireless/ath/ath9k/channel.c | 4 +++-
>>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/net/wireless/ath/ath9k/channel.c b/drivers/net/w=
ireless/ath/ath9k/channel.c
>>>>> index 571062f2e82a..e343c8962d14 100644
>>>>> --- a/drivers/net/wireless/ath/ath9k/channel.c
>>>>> +++ b/drivers/net/wireless/ath/ath9k/channel.c
>>>>> @@ -576,7 +576,9 @@ void ath_chanctx_event(struct ath_softc *sc, stru=
ct ieee80211_vif *vif,
>>>>>    		if (sc->sched.state !=3D ATH_CHANCTX_STATE_WAIT_FOR_BEACON)
>>>>>    			break;
>>>>>=20=20=20=20
>>>>> -		ath_dbg(common, CHAN_CTX, "Preparing beacon for vif: %pM\n", vif->=
addr);
>>>>> +		if (vif)
>>>>> +			ath_dbg(common, CHAN_CTX,
>>>>> +				"Preparing beacon for vif: %pM\n", vif->addr);
>>>> Please don't send patches for static checker errors without actually
>>>> checking if there is a valid bug. Which there isn't in this case.
>>> Before sending this patch, I searched in the code, there are many call
>>> sites of ath_chanctx_event with argument vif as NULL.
>>>
>>> Functions calling this function: ath_chanctx_event
>>>
>>>   =C2=A0 File=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Function=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Line
>>> 0 beacon.c=C2=A0 ath9k_beacon_tasklet=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 459 ath_chanctx_event(sc, vif,
>>> ATH_CHANCTX_EVENT_BEACON_PREPARE);
>> But only this one has ATH_CHANCTX_EVENT_BEACON_PREPARE as an argument,
>> which is required to hit the code path you are changing.
>>
>>> 1 channel.c ath_chanctx_check_active=C2=A0=C2=A0=C2=A0 321 ath_chanctx_=
event(sc, NULL,
>>> 2 channel.c ath_chanctx_beacon_sent_ev=C2=A0 781 ath_chanctx_event(sc, =
NULL, ev);
>>> 3 channel.c ath_chanctx_beacon_recv_ev=C2=A0 787 ath_chanctx_event(sc, =
NULL, ev);
>>> 4 channel.c ath_chanctx_timer=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 1054 ath_chanctx_event(sc, NULL,
>>> ATH_CHANCTX_EVENT_TSF_TIMER);
>>> 5 channel.c ath_chanctx_set_next=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 13=
21 ath_chanctx_event(sc, NULL,
>>> ATH_CHANCTX_EVENT_SWITCH);
>>> 6 channel.c ath9k_p2p_ps_timer=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 1566 ath_chanctx_event(sc, NULL,
>>> ATH_CHANCTX_EVENT_TSF_TIMER);
>>> 7 main.c=C2=A0=C2=A0=C2=A0 ath9k_sta_state=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1671 ath_chanctx_event(sc, vif,
>>> 8 main.c=C2=A0=C2=A0=C2=A0 ath9k_remove_chanctx=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 2577 ath_chanctx_event(sc, NULL,
>>> ATH_CHANCTX_EVENT_UNASSIGN);
>>> 9 xmit.c=C2=A0=C2=A0=C2=A0 ath_tx_edma_tasklet=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 2749 ath_chanctx_event(sc, NULL,
>>>
>>> This NULL parameters would cause some abnormal behaviors.
>>>
>>>> Specifically, that branch of the switch statement dereferences the avp
>>>> pointer, which will be NULL if 'vif' is. Meaning we will have crashed
>>>> way before reaching this statement if vif is indeed NULL.
>>> Yeah, you are right. However, no matter where or which variable causing
>>> the null-ptr-def crash, the crash is there.
>> There is no crash, see above.
>
> Yeah, I see where my problem is. Please ignore this patch.
>
> In the future I will check more and think more about the code logic when=
=20
> verifying the result of static analyzer.

Great! As a general point, while static analysers do occasionally find
corner case bugs that have not been discovered, they are by no means
infallible, and tend to produce false positives as well. And especially
in a code path such as this, where the crash would have been really
obvious, applying some extra scrutiny to the tool's output is warranted.

> Thanks for your patience.

You're welcome :)

-Toke
