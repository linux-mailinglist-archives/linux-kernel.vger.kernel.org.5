Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723CA7B3FCE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 11:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbjI3J7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 05:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjI3J7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 05:59:30 -0400
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E5ADD;
        Sat, 30 Sep 2023 02:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lentin.co.uk; s=mythic-beasts-k1; h=Subject:To:From:Date;
        bh=/4uYrF1YZamO8Ddz5l0mdwZaajyvTANffN5fQkY1Ulw=; b=LJh/avzSGrM72gw+iPIW8BbYlC
        SIBbumnUVg+G9DdKvDEOWUjwZT+3PvrPyljH/r/rbMB3KOc12D0o8iJtptwISswMxt+xUw7aP6bUk
        JiSlZBzpuSreH08yHna3DRE5k/6lg8p237yxIpawdwbRKuihFhXn9LSxcbLI5xpzdL7d66P1bWZeJ
        uRY/5eNJ8XB0Td5C6WYnxjPofof+V2IDBcnE0S+pnmT8LBXZodRt7oc9dNZiddgX23sFXRPvrIqr7
        BIcxRJjHxIuPpJhzpwlTyenJj4oRd+hyyQUC4yfO2bFHeVhmlfxGDWeENsHBcrmz5RWaCp+sOjlKE
        SpUZAzwQ==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpa (Exim 4.94.2)
        (envelope-from <jm@lentin.co.uk>)
        id 1qmWkl-007ob1-6B; Sat, 30 Sep 2023 10:59:15 +0100
MIME-Version: 1.0
Date:   Sat, 30 Sep 2023 10:58:52 +0100
From:   Jamie Lentin <jm@lentin.co.uk>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] hid: lenovo: move type checks to
 lenovo_features_set_cptkbd()
In-Reply-To: <2d1e21cc9677a5cfe828decd8cbd5e930237e76d.camel@posteo.de>
References: <140b721bc345a846863a37ebf17c3174@lentin.co.uk>
 <20230925102302.13094-1-martink@posteo.de>
 <20230925102302.13094-2-martink@posteo.de>
 <ef0f15c3b17ebbd58f7481910b3f40ff@lentin.co.uk>
 <137ee9ed434fe98fd773cd27895afc564f92a23c.camel@posteo.de>
 <6adc3e66402f38258eae3a044db9ee11@lentin.co.uk>
 <2d1e21cc9677a5cfe828decd8cbd5e930237e76d.camel@posteo.de>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <b3603d57b6d2be22f2a5615e66775d0b@lentin.co.uk>
X-Sender: jm@lentin.co.uk
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-30 10:26, Martin Kepplinger wrote:
> Am Donnerstag, dem 28.09.2023 um 22:06 +0100 schrieb Jamie Lentin:
>> On 2023-09-27 12:20, Martin Kepplinger wrote:
>> > Am Mittwoch, dem 27.09.2023 um 09:19 +0100 schrieb Jamie Lentin:
>> > > On 2023-09-25 11:23, Martin Kepplinger wrote:
>> > > > These custom commands will be sent to both the USB keyboard &
>> > > > mouse
>> > > > devices but only the mouse will respond. Avoid sending known-
>> > > > useless
>> > > > messages by always prepending the filter before sending them.
>> > > >
>> > > > Suggested-by: Jamie Lentin <jm@lentin.co.uk>
>> > > > Signed-off-by: Martin Kepplinger <martink@posteo.de>
>> > > > ---
>> > > >  drivers/hid/hid-lenovo.c | 27 +++++++++------------------
>> > > >  1 file changed, 9 insertions(+), 18 deletions(-)
>> > > >
>> > > > diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-
>> > > > lenovo.c
>> > > > index 29aa6d372bad..922f3e5462f4 100644
>> > > > --- a/drivers/hid/hid-lenovo.c
>> > > > +++ b/drivers/hid/hid-lenovo.c
>> > > > @@ -521,6 +521,14 @@ static void
>> > > > lenovo_features_set_cptkbd(struct
>> > > > hid_device *hdev)
>> > > >         int ret;
>> > > >         struct lenovo_drvdata *cptkbd_data =
>> > > > hid_get_drvdata(hdev);
>> > > >
>> > > > +       /* All the custom action happens on the USBMOUSE device
>> > > > for
>> > > > USB */
>> > > > +       if (((hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD) ||
>> > > > +           (hdev->product == USB_DEVICE_ID_LENOVO_TPIIUSBKBD))
>> > > > &&
>> > > > +           hdev->type != HID_TYPE_USBMOUSE) {
>> > > > +               hid_dbg(hdev, "Ignoring keyboard half of
>> > > > device\n");
>> > > > +               return;
>> > > > +       }
>> > > > +
>> > > >         /*
>> > > >          * Tell the keyboard a driver understands it, and turn
>> > > > F7,
>> > > > F9, F11
>> > > > into
>> > > >          * regular keys
>> > > > @@ -1122,14 +1130,6 @@ static int lenovo_probe_cptkbd(struct
>> > > > hid_device
>> > > > *hdev)
>> > > >         int ret;
>> > > >         struct lenovo_drvdata *cptkbd_data;
>> > > >
>> > > > -       /* All the custom action happens on the USBMOUSE device
>> > > > for
>> > > > USB */
>> > > > -       if (((hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD) ||
>> > > > -           (hdev->product == USB_DEVICE_ID_LENOVO_TPIIUSBKBD))
>> > > > &&
>> > > > -           hdev->type != HID_TYPE_USBMOUSE) {
>> > > > -               hid_dbg(hdev, "Ignoring keyboard half of
>> > > > device\n");
>> > > > -               return 0;
>> > > > -       }
>> > > > -
>> > >
>> > > I like the idea of doing it once then forgetting about it, but
>> > > removing
>> > > this will mean that the "keyboard half" will have it's own set of
>> > > non-functional sysfs parameters I think? Currently:-
>> > >
>> > > # evtest
>> > >    . . .
>> > > /dev/input/event10:     ThinkPad Compact Bluetooth Keyboard with
>> > > TrackPoint
>> > > /dev/input/event11:     Lenovo ThinkPad Compact USB Keyboard with
>> > > TrackPoint
>> > > /dev/input/event12:     Lenovo ThinkPad Compact USB Keyboard with
>> > > TrackPoint
>> > >
>> > > # ls -1 /sys/class/input/event*/device/device/fn_lock
>> > > /sys/class/input/event10/device/device/fn_lock
>> > > /sys/class/input/event12/device/device/fn_lock
>> > >
>> > > (note 11 is missing.)
>> > >
>> > > I think the easiest (but ugly) thing to do is to copy-paste this
>> > > lump
>> > > of
>> > > code to the top of lenovo_reset_resume.
>> > > Cheers,
>> > >
>> > > >         cptkbd_data = devm_kzalloc(&hdev->dev,
>> > > >                                         sizeof(*cptkbd_data),
>> > > >                                         GFP_KERNEL);
>> > > > @@ -1264,16 +1264,7 @@ static int lenovo_probe(struct
>> > > > hid_device
>> > > > *hdev,
>> > > >  #ifdef CONFIG_PM
>> > > >  static int lenovo_reset_resume(struct hid_device *hdev)
>> > > >  {
>> > > > -       switch (hdev->product) {
>> > > > -       case USB_DEVICE_ID_LENOVO_CUSBKBD:
>> > > > -               if (hdev->type == HID_TYPE_USBMOUSE) {
>> > > > -                       lenovo_features_set_cptkbd(hdev);
>> > > > -               }
>> > > > -
>> > > > -               break;
>> > > > -       default:
>> > > > -               break;
>> > > > -       }
>> > > > +       lenovo_features_set_cptkbd(hdev);
>> >
>> > ok. ignore my change (this whole patch) and look at your addition
>> > here,
>> > don't you already make sure only the mouse-part gets the messages?
>> > you
>> > just write switch()case instead of if(); what do you think is
>> > missing
>> > here?
>> 
>> Correct, this switch statement() that you're removing in this patch
>> already does exactly this, so replacing it with the
>> if()-and-return-early block would result in equivalent code (ignoring
>> the Trackpoint keyboard II). That suggestion wasn't the most helpful
>> of
>> mine, sorry!
>> 
>> The reason I originally used a switch here is for symmetry with
>> lenovo_probe(), lenovo_remove(), etc. It might some day be useful to
>> add
>> something like:
>> 
>>         case USB_DEVICE_ID_LENOVO_X1_TAB:
>>                 lenovo_reset_resume_tp10ubkbd(hdev);
>>                 break;
>> 
>> ...to the switch. For completeness, lenovo_reset_resume() should
>> probably call a separate lenovo_reset_resume_cptkbd() that does the
>> work. For just 3 lines of code it didn't seem worth it at the time
>> though.
>> 
>> Cheers,
> 
> ok your original patch seems to basically be a valid first fix. Should
> I send it on your behalf (with you as author) or do you want to send it
> yourself? Let's get this fixed :)

If it's working for you and you don't mind, feel free send it on my 
behalf. I don't have the hardware to test the patch currently.

Thanks!

> 
> thanks,
>                        martin
