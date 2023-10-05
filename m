Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82857B99F2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 04:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbjJEC32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 22:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjJEC31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 22:29:27 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2819493;
        Wed,  4 Oct 2023 19:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1696472958; x=1696732158;
        bh=OgB3vdOwYqWu8Tkn6dHcRy+eHWm6DTD+cmJDDbZbPsw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=LUrkh2pQpZCuR+gSw+0IxNc4az+PIxlXoyV5S3rB8ptCG6C1KutoFmp5/1BOnj/Ry
         a2nJIynKFTTQUOqglV+ZLo7niSCNj02SoPfca9VE2RmYdRFLWr17jm+9MZhA+jGBRu
         f+m9XP7NGr7VqaRPjc7A7PCUYzbM7esQig4gN82Pfnog0YvfEhd83kLAZIArI0rkdO
         /2VcTTKeGSzRWGbDAgZrNTvOUdG3XGnBQJsN3QKF4wGV8TvpnDDzhRkl/q8kqudgzz
         Qj2qoIjJkIKrb/InSvrPsL2HQ2K/tS1+PjKwZipC5Ty6l9q38vaOkKh37JQU0J+JnW
         G6GeEsSujDgcg==
Date:   Thu, 05 Oct 2023 02:29:09 +0000
To:     Rain <rain@sunshowers.io>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: multitouch: Add required quirk for Synaptics 0xcd7e device
Message-ID: <8734ypls3y.fsf@protonmail.com>
In-Reply-To: <e0f33dd3-1a35-4c76-889f-a80e42da2ded@app.fastmail.com>
References: <20230917161802.39716-1-sergeantsagara@protonmail.com> <e0f33dd3-1a35-4c76-889f-a80e42da2ded@app.fastmail.com>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 04 Oct, 2023 12:01:27 -0700 "Rain" <rain@sunshowers.io> wrote:
> On Sun, Sep 17, 2023, at 09:18, Rahul Rameshbabu wrote:
>> Register the Synaptics device as a special multitouch device with certai=
n
>> quirks that may improve usability of the touchpad device.
>>
>> Reported-by: Rain <rain@sunshowers.io>
>> Closes:
>> https://lore.kernel.org/linux-input/2bbb8e1d-1793-4df1-810f-cb0137341ff4=
@app.fastmail.com/
>> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
>> ---
>>
>> Notes:
>>     Theory:
>>
>>       I think the Synaptics device in the related email to the linux-inp=
ut
>>       mailing list requires certain quirks like MT_QUIRK_HOVERING to cor=
rectly
>>       reconfigure the distance configuration for multitouch events. This=
 might
>>       explain why light touches were not registered originally when
>>       MT_CLS_DEFAULT was used by default for the device. Would like to h=
ave
>>       this patch tested before being merged. A Tested-by: git trailer ca=
n then
>>       be appended.
>>
>>  drivers/hid/hid-multitouch.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
>> index 521b2ffb4244..8db4ae05febc 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -2144,6 +2144,10 @@ static const struct hid_device_id mt_devices[] =
=3D {
>>  =09=09=09USB_DEVICE_ID_MTP_STM)},
>>
>>  =09/* Synaptics devices */
>> +=09{ .driver_data =3D MT_CLS_WIN_8_FORCE_MULTI_INPUT,
>> +=09=09HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
>> +=09=09=09USB_VENDOR_ID_SYNAPTICS, 0xcd7e) },
>
> Thanks for the patch! I haven't tested it yet but it looks promising.
>
> The vendor ID isn't USB_VENDOR_ID_SYNAPTICS (0x06cb),
> however -- it's SYNA7DB5 (0x7db5) which I guess is an alternative vendor
> ID for Synaptics. Would be worth fixing that.

Hi Rain,

I think you might be confusing the device name string with the vendor
id, based on my interpretation of the output you shared.

  [    2.034760] input: SYNA7DB5:00 06CB:CD7E Mouse as /devices/platform/AM=
DI0010:00/i2c-0/i2c-SYNA7DB5:00/0018:06CB:CD7E.0001/input/input1
  [    2.034865] input: SYNA7DB5:00 06CB:CD7E Touchpad as /devices/platform=
/AMDI0010:00/i2c-0/i2c-SYNA7DB5:00/0018:06CB:CD7E.0001/input/input2

The first column has a device name but what we are interested in is the
second column, '06CB:CD7E'. 0x06CB is the vendor id and 0xCD7E is the
device id. Hope that makes sense and let me know if you think this is
off.

In general for these types of issues, I think the right direction would
be to make quirks loadable in userspace through HID-BPF where DEs or
some systemd subsystem can help users load quirks needed for their HID
devices rather than building a list of quirks in the driver. This is
something I am interested in exploring.

Thanks,

Rahul Rameshbabu

>
>> +
>>  =09{ .driver_data =3D MT_CLS_WIN_8_FORCE_MULTI_INPUT,
>>  =09=09HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
>>  =09=09=09USB_VENDOR_ID_SYNAPTICS, 0xce08) },
>> --
>> 2.40.1


