Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E237675E4FE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 23:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjGWVLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 17:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGWVLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 17:11:10 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC9B1B3;
        Sun, 23 Jul 2023 14:11:07 -0700 (PDT)
Date:   Sun, 23 Jul 2023 21:10:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1690146664; x=1690405864;
        bh=5Lq9UD89W1UOWyCrhfI2csu387hY98KV0VHDyb4fJjE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Ar4TSLDqnrfpzK/EDN4PSZ092xuOqAdN42OEmWU3CxEBklrgj4Y+d5dz5Tud2q2lH
         lka2vE8aUU0ncH5M8v4GB4Lx/QPtVm+gkBEM05GJbDustFBeJtaXS8LvphjSswBk3J
         f9LzulkwBrIhD4aP8lovYhL28RXiuYKLWdatOHmG/op7V2EEUQ7DQ5vU3RX2X9a2KR
         RrhdtcxpZW6xjixfbhgBMIq/JvUDxyH6bYUvL3IhiWw2pw8y/6icojrtdvfZtYQ5wY
         nIhDFvjnVg4g/A6+sNbjjN6M/5VvpSEoDhrQoCnZG/PdmamB1J31DNRlE+Q1P7POQE
         3XNT22LBWcNhA==
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
From:   Harry Austen <hpausten@protonmail.com>
Cc:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
        "Stern, Avraham" <avraham.stern@intel.com>
Subject: Re: [PATCH] wifi: iwlwifi: mvm: enable thermal zone only when firmware is loaded
Message-ID: <CU9UZGEOQ02X.24LBZ815J8K9I@Harry-LinuxPC>
In-Reply-To: <7a45b2ed16645523a13d69290b27031f607b214a.camel@intel.com>
References: <20230710104626.8399-1-hpausten@protonmail.com> <e8777141-882c-d5a0-b93b-2dbeb6ea93f7@linaro.org> <7a45b2ed16645523a13d69290b27031f607b214a.camel@intel.com>
Feedback-ID: 53116287:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Jul 16, 2023 at 2:45 PM BST, Zhang, Rui wrote:
> On Thu, 2023-07-13 at 11:41 +0200, Daniel Lezcano wrote:
> > On 10/07/2023 12:47, Harry Austen wrote:
> > > In iwl_mvm_thermal_zone_register(), when registering a thermal
> > > zone, the
> > > thermal subsystem will evaluate its temperature.
> > > But iwl_mvm_tzone_get_temp() fails at this time because
> > > iwl_mvm_firmware_running() returns false.
> > > And that's why many users report that they see
> > > "thermal thermal_zoneX: failed to read out thermal zone (-61)"
> > > message during wifi driver probing.
> > >
> > > This patch attempts to fix this by delaying enabling of the thermal
> > > zone
> > > until after the firmware has been loaded/initialized. It also gets
> > > disabled when going into suspend.
> >
> > Thanks for taking care of this bug.
> >
> > The thermal zone will be accessible from userspace
>
> Currently, I see that the mode is checked only in
> __thermal_zone_device_update().
>
> should we limit the userspace access for disabled thermal zone? For
> example, return failure when reading 'temp' sysfs attribute.

Ah okay thanks for checking. Yes, agree that is probably a more sensible be=
haviour.

>
> >  and can be enabled
> > manually.
>
> maybe we should have a .change_mode() callback and return failure when
> enabling the thermal zone with wifi firmware unloaded.
>
> >  The resulting temperature read error will be the same in this
> > case.
> >
> > IMO, it is cleaner to actually [un]register the thermal zone when the
> > firmware is [un]loaded
>
> Austen,
> may I know how often is this wifi firmware loaded/unloaded?

Personally, I have only ever seen the firmware loaded once on boot and neve=
r unloaded. That was the reason for my patch;
I was trying to reduce the number of kernel warning/error log messages on m=
y system during boot. As far as I can tell,
the ieee80211_ops stop() callback is only called in drv_stop(), which for e=
xample can be called via ieee80211_suspend().

>
> thanks,
> rui
> >
> > > Signed-off-by: Harry Austen <hpausten@protonmail.com>
> > > ---
> > > =C2=A0 .../net/wireless/intel/iwlwifi/mvm/mac80211.c=C2=A0 | 18
> > > ++++++++++++++++++
> > > =C2=A0 drivers/net/wireless/intel/iwlwifi/mvm/tt.c=C2=A0=C2=A0=C2=
=A0 |=C2=A0 9 +--------
> > > =C2=A0 2 files changed, 19 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> > > b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> > > index ce7905faa08f..a47d29a64dd4 100644
> > > --- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> > > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> > > @@ -1187,6 +1187,17 @@ int iwl_mvm_mac_start(struct ieee80211_hw
> > > *hw)
> > >
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&mvm->mu=
tex);
> > >
> > > +#ifdef CONFIG_THERMAL
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Needs to be done outsid=
e of mutex guarded section to
> > > prevent deadlock, since enabling
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the thermal zone calls =
the .get_temp() callback, which
> > > attempts to acquire the mutex.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ret) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D thermal_zone_device_enable(mvm-
> > > >tz_device.tzone);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0IWL_DEBUG_TEMP(mvm, "Failed to enable
> > > thermal zone (err =3D %d)\n", ret);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +#endif
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iwl_mvm_mei_set_sw_rf=
kill_state(mvm);
> > >
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > > @@ -1282,6 +1293,7 @@ void __iwl_mvm_mac_stop(struct iwl_mvm *mvm)
> > > =C2=A0 void iwl_mvm_mac_stop(struct ieee80211_hw *hw)
> > > =C2=A0 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iwl_mvm *mvm =
=3D IWL_MAC80211_GET_MVM(hw);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > >
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flush_work(&mvm->asyn=
c_handlers_wk);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flush_work(&mvm->add_=
stream_wk);
> > > @@ -1307,6 +1319,12 @@ void iwl_mvm_mac_stop(struct ieee80211_hw
> > > *hw)
> > >
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iwl_mvm_mei_set_sw_rf=
kill_state(mvm);
> > >
> > > +#ifdef CONFIG_THERMAL
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D thermal_zone_devic=
e_disable(mvm->tz_device.tzone);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0IWL_DEBUG_TEMP(mvm, "Failed to disable thermal z=
one
> > > (err =3D %d)\n", ret);
> > > +#endif
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&mvm->mute=
x);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__iwl_mvm_mac_stop(mv=
m);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&mvm->mu=
tex);
> > > diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > > b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > > index 157e96fa23c1..964d2d011c6b 100644
> > > --- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > > +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> > > @@ -680,7 +680,7 @@ static=C2=A0 struct thermal_zone_device_ops
> > > tzone_ops =3D {
> > >
> > > =C2=A0 static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
> > > =C2=A0 {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i, ret;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char name[16];
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0static atomic_t count=
er =3D ATOMIC_INIT(0);
> > >
> > > @@ -707,13 +707,6 @@ static void
> > > iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > >
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D thermal_zone_devic=
e_enable(mvm->tz_device.tzone);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret) {
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0IWL_DEBUG_TEMP(mvm, "Failed to enable thermal
> > > zone\n");
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0thermal_zone_device_unregister(mvm-
> > > >tz_device.tzone);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > -
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* 0 is a valid tempe=
rature,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * so initialize the =
array with S16_MIN which invalid
> > > temperature
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > --
> > > 2.41.0
> > >
> > >
> >

Thanks for the review! :)
Harry

