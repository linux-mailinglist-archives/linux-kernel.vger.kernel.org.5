Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4607C5129
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjJKLKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbjJKLKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:10:06 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F656106;
        Wed, 11 Oct 2023 04:09:38 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 99A2020008;
        Wed, 11 Oct 2023 11:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697022576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KP05wLyKRD598HzULG2gUbJ6b/QOLew0QiiIOyL4nsU=;
        b=KxAXc2+yFUMRaXPG/GFMXyxuaVUm2wr7o3/QPrGS4yg3Prthevv0z9dbeY1DMwgpwilD5A
        W5IujeLG1Mi2/bMnoco2S/0dtHjy1OCJvnyikMVNPxeNJfmI5Wku3VA2Rfq9KMLMX204Bt
        dWRYNI2U0SUOvon32s4W3uKcim3zQkEDa8QJV6PNNmITWap2KZJ6IsAffFAJ/373uQBVpA
        gsPPBD8VUWoVHTRodg+eUFEQLZrF9RVzLPexa0RkxXDmvd5WGeyY2qmeO0DraZMy6gn6/R
        DttSk3HcghXBtrXqWxB/nTbs06rSrD+85fXkMyp7Dth2y9c9S7QUzQaWc1Z1FA==
Date:   Wed, 11 Oct 2023 13:09:31 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v12 7/7] nvmem: core: Expose cells through sysfs
Message-ID: <20231011130931.3b6216aa@xps-13>
In-Reply-To: <8b8403ee-b610-312b-aa98-3e4fa65a3800@linaro.org>
References: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
        <20231005155907.2701706-8-miquel.raynal@bootlin.com>
        <318fe799-f53e-64ed-b631-d099bb5202f4@linaro.org>
        <20231011091524.0c9ecc55@xps-13>
        <548849a8-9f11-5274-778e-f291267603bb@linaro.org>
        <20231011103306.08f1fbd4@xps-13>
        <fe4a2688-079c-a36d-0ea4-c244c6e1a0ad@linaro.org>
        <20231011105829.778bed58@xps-13>
        <490c6740-06cb-9ee6-ca8c-3ab404109344@linaro.org>
        <20231011114419.21821f4d@xps-13>
        <8b8403ee-b610-312b-aa98-3e4fa65a3800@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Wed, 11 Oct 2023 11:02:16 +0100:

> Hi Miquel,
>=20
> On 11/10/2023 10:44, Miquel Raynal wrote:
> > Hi Srinivas,
> >=20
> > srinivas.kandagatla@linaro.org wrote on Wed, 11 Oct 2023 10:26:43 +0100:
> >  =20
> >> On 11/10/2023 09:58, Miquel Raynal wrote: =20
> >>> Hi Srinivas,
> >>>
> >>> srinivas.kandagatla@linaro.org wrote on Wed, 11 Oct 2023 09:45:11 +01=
00: =20
> >>>    >>>> On 11/10/2023 09:33, Miquel Raynal wrote: =20
> >>>>> Hi Srinivas,
> >>>>>
> >>>>> srinivas.kandagatla@linaro.org wrote on Wed, 11 Oct 2023 09:27:20 +=
0100: =20
> >>>>>     >>>> On 11/10/2023 08:15, Miquel Raynal wrote:
> >>>>>>>>> +
> >>>>>>>>> +	nvmem_cells_group.bin_attrs =3D cells_attrs;
> >>>>>>>>> +
> >>>>>>>>> +	ret =3D devm_device_add_groups(&nvmem->dev, nvmem_cells_group=
s);
> >>>>>>>>> +	if (ret)
> >>>>>>>>> +		goto unlock_mutex; =20
> >>>>>>>> This is going to create groups after the nvmem device is added, =
isn't this going to be problem with user space notifications? =20
> >>>>>>> Greg said it was not. I hope I understood correctly =F0=9F=98=84
> >>>>>>>
> >>>>>>> And anyway, cells have never been available to userspace, so ther=
e is
> >>>>>>> nothing userspace might expect yet? =20
> >>>>>> I agree, but once we add sysfs uapi then this is going to change. =
=20
> >>>>>
> >>>>> Can you elaborate? I'm not sure I follow you here. Is there still a
> >>>>> problem you fear or you think it's okay? =20
> >>>>>     >> Now that we add cells to sysfs. =20
> >>>> AFAIU, By the time the userspace sees the udev event from this devic=
e we might not have cells populated. =20
> >>>
> >>> Yes, but why would this be a problem? =20
> >>>    >> It will be problem if the userspace is using things like libude=
v to act on these events. There seems to be some caching of attributes in u=
dev during event more info http://www.kroah.com/log/blog/2013/06/26/how-to-=
create-a-sysfs-file-correctly/ =20
> >=20
> > I am already using these attributes, right? The problem here is that we
> > always attach cells sysfs attributes to the nvmem device, but in some
> > cases (when using layout devices/drivers) the probe of these devices
> > will happen after the main nvmem device has been announced to userspace
> > and thus these attributes might not be populated yet (but Greg said it
> > was "supported" and I assumed it was fine). =20
> >  > So what is your idea here to overcome this? =20
>=20
> Ideally we should have all the cells definitions ready by the time nvmem =
is registered.

I no longer think what you describe can happen because even though the
rootfs might be mounted, the daemons will only be 'started' once the
kernel is done starting and starts the init process, which means all
the devices have probed and all the cells have been registered as well.

Thanks,
Miqu=C3=A8l
