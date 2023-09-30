Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361047B3FAE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 11:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjI3J0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 05:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjI3J0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 05:26:43 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681A2DD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 02:26:39 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 0F1D4240029
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 11:26:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1696065996; bh=bhsTAvwHD9YkPK3+W0x6nsCnMuRURoezjRHkCLlCP8E=;
        h=Message-ID:Subject:From:To:Cc:Date:Content-Transfer-Encoding:
         MIME-Version:From;
        b=NCjwOitqw9g7HnOGc35Ok1lhZO3w6iatMclH66TXV31fi/mn4U40fGcJE/Ni5m7s+
         abkSD3HDm61eEReBvm0Q/ddMqSRucRi2EB0pBR8fn+yzFwf68OL644Y+AGurKVgjyq
         emIIUDCGfIN+sv2MZ75Hinq7n8cZwJOGo8JzYIuhbLVJtx48bRyzgNy6QagRa1I0rZ
         2IMGA0AUFnmIxdkYoe2qXBkdqF7AfkJ78m8KZ9MWKSsD2gW3yDJjdlGAvdhFjObjRI
         HrpoFSDY0bo0d1SnKSpm5eJpQCGFEWp+MZTZkljaFLcYF5NBu3F5S4lUgo17H1FohX
         Ovij8dGH8+QHQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RyMKl2KCXz6tvk;
        Sat, 30 Sep 2023 11:26:35 +0200 (CEST)
Message-ID: <2d1e21cc9677a5cfe828decd8cbd5e930237e76d.camel@posteo.de>
Subject: Re: [RFC PATCH 2/2] hid: lenovo: move type checks to
 lenovo_features_set_cptkbd()
From:   Martin Kepplinger <martink@posteo.de>
To:     Jamie Lentin <jm@lentin.co.uk>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Date:   Sat, 30 Sep 2023 09:26:34 +0000
In-Reply-To: <6adc3e66402f38258eae3a044db9ee11@lentin.co.uk>
References: <140b721bc345a846863a37ebf17c3174@lentin.co.uk>
         <20230925102302.13094-1-martink@posteo.de>
         <20230925102302.13094-2-martink@posteo.de>
         <ef0f15c3b17ebbd58f7481910b3f40ff@lentin.co.uk>
         <137ee9ed434fe98fd773cd27895afc564f92a23c.camel@posteo.de>
         <6adc3e66402f38258eae3a044db9ee11@lentin.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, dem 28.09.2023 um 22:06 +0100 schrieb Jamie Lentin:
> On 2023-09-27 12:20, Martin Kepplinger wrote:
> > Am Mittwoch, dem 27.09.2023 um 09:19 +0100 schrieb Jamie Lentin:
> > > On 2023-09-25 11:23, Martin Kepplinger wrote:
> > > > These custom commands will be sent to both the USB keyboard &
> > > > mouse
> > > > devices but only the mouse will respond. Avoid sending known-
> > > > useless
> > > > messages by always prepending the filter before sending them.
> > > >=20
> > > > Suggested-by: Jamie Lentin <jm@lentin.co.uk>
> > > > Signed-off-by: Martin Kepplinger <martink@posteo.de>
> > > > ---
> > > > =C2=A0drivers/hid/hid-lenovo.c | 27 +++++++++------------------
> > > > =C2=A01 file changed, 9 insertions(+), 18 deletions(-)
> > > >=20
> > > > diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-
> > > > lenovo.c
> > > > index 29aa6d372bad..922f3e5462f4 100644
> > > > --- a/drivers/hid/hid-lenovo.c
> > > > +++ b/drivers/hid/hid-lenovo.c
> > > > @@ -521,6 +521,14 @@ static void
> > > > lenovo_features_set_cptkbd(struct
> > > > hid_device *hdev)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct lenovo_drvda=
ta *cptkbd_data =3D
> > > > hid_get_drvdata(hdev);
> > > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* All the custom action=
 happens on the USBMOUSE device
> > > > for
> > > > USB */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (((hdev->product =3D=
=3D USB_DEVICE_ID_LENOVO_CUSBKBD) ||
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (hdev=
->product =3D=3D USB_DEVICE_ID_LENOVO_TPIIUSBKBD))
> > > > &&
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hdev-=
>type !=3D HID_TYPE_USBMOUSE) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0hid_dbg(hdev, "Ignoring keyboard half of
> > > > device\n");
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > +
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Tell the keyboar=
d a driver understands it, and turn
> > > > F7,
> > > > F9, F11
> > > > into
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * regular keys
> > > > @@ -1122,14 +1130,6 @@ static int lenovo_probe_cptkbd(struct
> > > > hid_device
> > > > *hdev)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct lenovo_drvda=
ta *cptkbd_data;
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* All the custom action=
 happens on the USBMOUSE device
> > > > for
> > > > USB */
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (((hdev->product =3D=
=3D USB_DEVICE_ID_LENOVO_CUSBKBD) ||
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (hdev=
->product =3D=3D USB_DEVICE_ID_LENOVO_TPIIUSBKBD))
> > > > &&
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hdev-=
>type !=3D HID_TYPE_USBMOUSE) {
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0hid_dbg(hdev, "Ignoring keyboard half of
> > > > device\n");
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > -
> > >=20
> > > I like the idea of doing it once then forgetting about it, but
> > > removing
> > > this will mean that the "keyboard half" will have it's own set of
> > > non-functional sysfs parameters I think? Currently:-
> > >=20
> > > # evtest
> > > =C2=A0=C2=A0 . . .
> > > /dev/input/event10:=C2=A0=C2=A0=C2=A0=C2=A0 ThinkPad Compact Bluetoot=
h Keyboard with
> > > TrackPoint
> > > /dev/input/event11:=C2=A0=C2=A0=C2=A0=C2=A0 Lenovo ThinkPad Compact U=
SB Keyboard with
> > > TrackPoint
> > > /dev/input/event12:=C2=A0=C2=A0=C2=A0=C2=A0 Lenovo ThinkPad Compact U=
SB Keyboard with
> > > TrackPoint
> > >=20
> > > # ls -1 /sys/class/input/event*/device/device/fn_lock
> > > /sys/class/input/event10/device/device/fn_lock
> > > /sys/class/input/event12/device/device/fn_lock
> > >=20
> > > (note 11 is missing.)
> > >=20
> > > I think the easiest (but ugly) thing to do is to copy-paste this
> > > lump
> > > of
> > > code to the top of lenovo_reset_resume.
> > > Cheers,
> > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cptkbd_data =3D dev=
m_kzalloc(&hdev->dev,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0sizeof(*cptkbd_data),
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0GFP_KERNEL);
> > > > @@ -1264,16 +1264,7 @@ static int lenovo_probe(struct
> > > > hid_device
> > > > *hdev,
> > > > =C2=A0#ifdef CONFIG_PM
> > > > =C2=A0static int lenovo_reset_resume(struct hid_device *hdev)
> > > > =C2=A0{
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0switch (hdev->product) {
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case USB_DEVICE_ID_LENOV=
O_CUSBKBD:
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (hdev->type =3D=3D HID_TYPE_USBMOUSE) {
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0len=
ovo_features_set_cptkbd(hdev);
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > -
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default:
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lenovo_features_set_cptk=
bd(hdev);
> >=20
> > ok. ignore my change (this whole patch) and look at your addition
> > here,
> > don't you already make sure only the mouse-part gets the messages?
> > you
> > just write switch()case instead of if(); what do you think is
> > missing
> > here?
>=20
> Correct, this switch statement() that you're removing in this patch=20
> already does exactly this, so replacing it with the=20
> if()-and-return-early block would result in equivalent code (ignoring
> the Trackpoint keyboard II). That suggestion wasn't the most helpful
> of=20
> mine, sorry!
>=20
> The reason I originally used a switch here is for symmetry with=20
> lenovo_probe(), lenovo_remove(), etc. It might some day be useful to
> add=20
> something like:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case USB_DEVICE_ID_LENOVO=
_X1_TAB:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0lenovo_reset_resume_tp10ubkbd(hdev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0break;
>=20
> ...to the switch. For completeness, lenovo_reset_resume() should=20
> probably call a separate lenovo_reset_resume_cptkbd() that does the=20
> work. For just 3 lines of code it didn't seem worth it at the time=20
> though.
>=20
> Cheers,

ok your original patch seems to basically be a valid first fix. Should
I send it on your behalf (with you as author) or do you want to send it
yourself? Let's get this fixed :)

thanks,
                       martin

