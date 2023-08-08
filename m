Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718697742C0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjHHRtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjHHRtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:49:10 -0400
X-Greylist: delayed 863 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Aug 2023 09:21:51 PDT
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D549AB0E31
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:21:51 -0700 (PDT)
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 9EC6AC8D01
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 06:29:19 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8674760004;
        Tue,  8 Aug 2023 06:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691476154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TDu/0VL210MkW+0bvZ8REbEHWcJsT1kLF4e/Qj9amZU=;
        b=Ql8QYi5J1lDfsBxY0JYUWWwgaY1OweKon7g12E46Ge3LzPvXqSu53eqZJiKJZP8RuQLZzV
        LGh+T5VFhatf21dVDe8XXo6xz7nx4x476GzRYoKeVokW0+sCDFWM7gJ1MCS+JraKYVeGPi
        k19pkKC6AVYwFMQKcWSbUuTv3qdRS7mhGZ36AkQzPap6kR2sNXiSdv1lie00jEWSkF6XDH
        OLP+82rWv9lQIqltlVU6I8dqxJu3k1cebPgeZxcAAX+XIFbOHSobkmG1uV0psApXPQ0EcR
        iTIsDI2hAGFe72r6B4ylXWihO+x0UXwI/M7G9E9KrfbWstM6s9gLOt/o87VD3w==
Date:   Tue, 8 Aug 2023 08:29:10 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH v8 0/8] NVMEM cells in sysfs
Message-ID: <20230808082910.3401f7f8@xps-13>
In-Reply-To: <CAGXv+5GTOVhh3R0WJ7xOP5vq+MkKhQvUUjMGoLe39-2T8oqyLw@mail.gmail.com>
References: <20230807082419.38780-1-miquel.raynal@bootlin.com>
        <CAGXv+5GaW5wtVqsN+GQJ6rzkmCq1R3c1xeZ=_hNmHmrkVZ=eug@mail.gmail.com>
        <20230807112040.55af2163@xps-13>
        <20230807162854.171ac18d@xps-13>
        <CAGXv+5GTOVhh3R0WJ7xOP5vq+MkKhQvUUjMGoLe39-2T8oqyLw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

wenst@chromium.org wrote on Tue, 8 Aug 2023 10:56:36 +0800:

> On Mon, Aug 7, 2023 at 10:28=E2=80=AFPM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
> >
> > Hi Chen-Yu,
> >
> > miquel.raynal@bootlin.com wrote on Mon, 7 Aug 2023 11:20:40 +0200:
> > =20
> > > Hi Chen-Yu,
> > >
> > > wenst@chromium.org wrote on Mon, 7 Aug 2023 16:57:03 +0800:
> > > =20
> > > > On Mon, Aug 7, 2023 at 4:24=E2=80=AFPM Miquel Raynal <miquel.raynal=
@bootlin.com> wrote: =20
> > > > >
> > > > > Hello,
> > > > >
> > > > > As part of a previous effort, support for dynamic NVMEM layouts w=
as
> > > > > brought into mainline, helping a lot in getting information from =
NVMEM
> > > > > devices at non-static locations. One common example of NVMEM cell=
 is the
> > > > > MAC address that must be used. Sometimes the cell content is main=
ly (or
> > > > > only) useful to the kernel, and sometimes it is not. Users might =
also
> > > > > want to know the content of cells such as: the manufacturing plac=
e and
> > > > > date, the hardware version, the unique ID, etc. Two possibilities=
 in
> > > > > this case: either the users re-implement their own parser to go t=
hrough
> > > > > the whole device and search for the information they want, or the=
 kernel
> > > > > can expose the content of the cells if deemed relevant. This seco=
nd
> > > > > approach sounds way more relevant than the first one to avoid use=
less
> > > > > code duplication, so here is a series bringing NVMEM cells conten=
t to
> > > > > the user through sysfs.
> > > > >
> > > > > Here is a real life example with a Marvell Armada 7040 TN48m swit=
ch:
> > > > >
> > > > > $ nvmem=3D/sys/bus/nvmem/devices/1-00563/
> > > > > $ for i in `ls -1 $nvmem/cells/*`; do basename $i; hexdump -C $i =
| head -n1; done
> > > > > country-code@77
> > > > > 00000000  54 57                                             |TW|
> > > > > crc32@88
> > > > > 00000000  bb cd 51 98                                       |..Q.|
> > > > > device-version@49
> > > > > 00000000  02                                                |.|
> > > > > diag-version@80
> > > > > 00000000  56 31 2e 30 2e 30                                 |V1.0=
.0|
> > > > > label-revision@4c
> > > > > 00000000  44 31                                             |D1|
> > > > > mac-address@2c
> > > > > 00000000  18 be 92 13 9a 00                                 |....=
..|
> > > > > manufacture-date@34
> > > > > 00000000  30 32 2f 32 34 2f 32 30  32 31 20 31 38 3a 35 39  |02/2=
4/2021 18:59|
> > > > > manufacturer@72
> > > > > 00000000  44 4e 49                                          |DNI|
> > > > > num-macs@6e
> > > > > 00000000  00 40                                             |.@|
> > > > > onie-version@61
> > > > > 00000000  32 30 32 30 2e 31 31 2d  56 30 31                 |2020=
.11-V01|
> > > > > platform-name@50
> > > > > 00000000  38 38 46 37 30 34 30 2f  38 38 46 36 38 32 30     |88F7=
040/88F6820|
> > > > > product-name@d
> > > > > 00000000  54 4e 34 38 4d 2d 50 2d  44 4e                    |TN48=
M-P-DN|
> > > > > serial-number@19
> > > > > 00000000  54 4e 34 38 31 50 32 54  57 32 30 34 32 30 33 32  |TN48=
1P2TW2042032|
> > > > > vendor@7b
> > > > > 00000000  44 4e 49                                          |DNI|
> > > > >
> > > > > This layout with a cells/ folder containing one file per cell has=
 been
> > > > > legitimately challenged by John Thomson. I am not against the ide=
a of
> > > > > having a sub-folder per cell but I did not find a relevant way to=
 do
> > > > > that so for know I did not change the sysfs organization. If some=
one
> > > > > really wants this other layout, please provide a code snipped whi=
ch I
> > > > > can integrate.
> > > > >
> > > > > Current support does not include:
> > > > > * The knowledge of the type of data (binary vs. ASCII), so by def=
ault
> > > > >   all cells are exposed in binary form.
> > > > > * Write support.
> > > > >
> > > > > Changes in v8:
> > > > > * Fix a compilation warning whith !CONFIG_NVMEM_SYSFS.
> > > > > * Add a patch to return NULL when no layout is found (reported by=
 Dan
> > > > >   Carpenter).
> > > > > * Fixed the documentation as well as the cover letter regarding t=
he
> > > > >   addition of addresses in the cell names. =20
> > > >
> > > > It seems this version no longer creates cells for legacy DT layout =
formats?
> > > > So while I assume the issue I ran into is fixed, I don't see any ce=
lls
> > > > created on the MT8183 either.
> > > >
> > > > Is this intended? =20
> > >
> > > Not at all, but I am surprised they are no longer created. I will add
> > > fake cells and see how it behaves. =20
> >
> > Alright, I've got confused, the cells are still created, but in the
> > 'legacy' case, they no longer appear in sysfs. I guess that's what you
> > meant. I will move the sysfs creation to a better place indeed. =20
>=20
> That's right, the cells in sysfs aren't created. Sorry for the confusion.

No problem ;) Thanks a lot for the testing, it's highly appreciated.

Miqu=C3=A8l
