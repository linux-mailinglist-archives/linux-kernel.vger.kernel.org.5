Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC077B7E2E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242264AbjJDLaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbjJDLax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:30:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7979AB8;
        Wed,  4 Oct 2023 04:30:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2680FC433C8;
        Wed,  4 Oct 2023 11:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696419048;
        bh=XZPfDOUEl7syT8/Zq2cqR5ByKKYEBNpz28MnTNBylJ4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=T8RalRLm/USKEdr1skYZ4DUL0KxHD2jmP6NkhZwKmYVPWJAsNaKCYGXt5OplnjghW
         rVLTPl/Da1PIMZrS5kbaX7i6Up3DMJF54+qShGG7VsTdKdD36balIVa+/314FcipsV
         Qqzx+AjXmI1eon+/viBXfvMrLwr6xqmW202JF55q7YK0s2W5WBHuSNAVF0CX403LHe
         YofyOxGO8lPgo3bKuUNNba9o9tOUfotHQt4+iZCwKdOea9HCkwmGpzV0m+k+SnDIRQ
         a4ils8F3A14HVjAqiIp6pgzQcdB4PUEhdwpg6eIh2KAaBsyxKP8JKVj8UDVyz8rFzp
         O7fnK3zYHl+UQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     =?utf-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] wifi: wfx: fix power_save setting when AP is
 stopped
References: <20230927163257.568496-1-jerome.pouiller@silabs.com>
        <20230927163257.568496-2-jerome.pouiller@silabs.com>
        <87ttr6heoz.fsf@kernel.org> <14139521.lVVuGzaMjS@pc-42>
Date:   Wed, 04 Oct 2023 14:30:45 +0300
In-Reply-To: <14139521.lVVuGzaMjS@pc-42> (=?utf-8?B?IkrDqXLDtG1l?=
 Pouiller"'s message of "Wed,
        04 Oct 2023 12:37:02 +0200")
Message-ID: <877co27hga.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com> writes:

> Hi Kalle,
>
> On Wednesday 4 October 2023 12:20:12 CEST Kalle Valo wrote:
>>=20
>> J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com> writes:
>>=20
>> > The WF200 allow to start two network interfaces (one AP, one station) =
on
>> > two different channels. Since magic does not exist, it only works if t=
he
>> > station interface enables power save.
>> >
>> > Thus, the driver detects this case and enforce power save as necessary.
>> >
>> > This patch fixes the case where the AP interface is stopped and it is =
no
>> > more necessary to enforce power saving on the station interface.
>> >
>> > Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>> > ---
>> >  drivers/net/wireless/silabs/wfx/sta.c | 5 +++++
>> >  1 file changed, 5 insertions(+)
>> >
>> > diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wirel=
ess/silabs/wfx/sta.c
>> > index 626dfb4b7a55d..9c0a11c277e97 100644
>> > --- a/drivers/net/wireless/silabs/wfx/sta.c
>> > +++ b/drivers/net/wireless/silabs/wfx/sta.c
>> > @@ -402,7 +402,12 @@ void wfx_stop_ap(struct ieee80211_hw *hw, struct =
ieee80211_vif *vif,
>> >                struct ieee80211_bss_conf *link_conf)
>> >  {
>> >       struct wfx_vif *wvif =3D (struct wfx_vif *)vif->drv_priv;
>> > +     struct wfx_dev *wdev =3D wvif->wdev;
>> >
>> > +     wvif =3D  NULL;
>> > +     while ((wvif =3D wvif_iterate(wdev, wvif)) !=3D NULL)
>> > +             wfx_update_pm(wvif);
>>=20
>> Isn't the assignment of wvif to NULL unnecessary as in the next line we
>> assign it to again?
>
> wvif is also passed as argument to wvif_iterate(). wvif_iterate() uses th=
is
> parameter to know where the iteration has stopped on previous call.

Ah, I missed that.

> However, the assignation during the declaration of wvif is useless.

Indeed, missed that as well.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
