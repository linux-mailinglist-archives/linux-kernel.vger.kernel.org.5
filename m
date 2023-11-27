Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492B57F97C3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 04:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjK0DDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 22:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjK0DDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 22:03:00 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588F9B6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 19:03:05 -0800 (PST)
Received: from [192.168.68.112] (203-57-215-234.dyn.iinet.net.au [203.57.215.234])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 12E4920034;
        Mon, 27 Nov 2023 11:02:58 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1701054179;
        bh=Hk7MBX8MDvUBYr6oc5O7guJNHMGpcWV4KcgN0+fKl48=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ZeRgVU/4VSclrn21nv0OXHyxH9F3YB91YtHDfUw/cUXVope2UpbWMTh6n5h9cJpL4
         Bk3djASUe0W/Vuz/ZA5FPspp9gZ3AHMpM+DpQ4E0XHgPMEN7yPsKzyW+AEfcyxizRt
         HgC/UAkLcPgUZ2D7hLDld3/IEl5b84WSYQtAwFBKoK2CYgua5ubWNcyL4tsiMf8w0b
         dHPWviSg1HVZ/aqH6OnVmIC8P0AVOk5YiZ28FmQWOUpi/Oa/UC7efZPKRvNn+NmOnT
         bA90AmjpvquL36qZtLD8eJ8IsDZpnemGtijHAMqOzUcfLVLtd6+tyPlKR9MsgauZwV
         WOqe+jTGIHTQQ==
Message-ID: <4e355b4b19d49753d900094c900f2586d283179e.camel@codeconstruct.com.au>
Subject: Re: [PATCH 08/10] ipmi: kcs_bmc: Track clients in core
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, aladyshev22@gmail.com,
        jk@codeconstruct.com.au
Date:   Mon, 27 Nov 2023 13:32:57 +1030
In-Reply-To: <20231120124001.00003cbc@Huawei.com>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
         <20231103061522.1268637-9-andrew@codeconstruct.com.au>
         <20231103150522.00004539@Huawei.com>
         <a015924b542fd35fe84357eebddd14cfae83dace.camel@codeconstruct.com.au>
         <20231120124001.00003cbc@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-11-20 at 12:40 +0000, Jonathan Cameron wrote:
> On Mon, 06 Nov 2023 10:26:38 +1030
> Andrew Jeffery <andrew@codeconstruct.com.au> wrote:
>=20
> > On Fri, 2023-11-03 at 15:05 +0000, Jonathan Cameron wrote:
> > > On Fri,  3 Nov 2023 16:45:20 +1030
> > > Andrew Jeffery <andrew@codeconstruct.com.au> wrote:
> > >  =20
> > > > I ran out of spoons before I could come up with a better client tra=
cking
> > > > scheme back in the original refactoring series:
> > > >=20
> > > > https://lore.kernel.org/all/20210608104757.582199-1-andrew@aj.id.au=
/
> > > >=20
> > > > Jonathan prodded Konstantin about the issue in a review of Konstant=
in's
> > > > MCTP patches[1], prompting an attempt to clean it up.
> > > >=20
> > > > [1]: https://lore.kernel.org/all/20230929120835.0000108e@Huawei.com=
/
> > > >=20
> > > > Prevent client modules from having to track their own instances by
> > > > requiring they return a pointer to a client object from their
> > > > add_device() implementation. We can then track this in the core, an=
d
> > > > provide it as the argument to the remove_device() implementation to=
 save
> > > > the client module from further work. The usual container_of() patte=
rn
> > > > gets the client module access to its private data.
> > > >=20
> > > > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au> =20
> > >=20
> > > Hi Andrew,
> > >=20
> > > A few comments inline.
> > > More generally, whilst this is definitely an improvement I'd have bee=
n tempted
> > > to make more use of the linux device model for this with the clients =
added
> > > as devices with a parent of the kcs_bmc_device.  That would then allo=
w for
> > > simple dependency tracking, binding of individual drivers and all tha=
t.
> > >=20
> > > What you have here feels fine though and is a much less invasive chan=
ge. =20
> >=20
> Sorry for slow reply, been traveling.

No worries, I've just got back from travel myself :)

>=20
> > Yeah, I had this debate with myself before posting the patches. My
> > reasoning for the current approach is that the clients don't typically
> > represent a device, rather a protocol implementation that is
> > communicated over a KCS device (maybe more like pairing a line
> > discipline with a UART). It was unclear to me whether associating a
> > `struct device` with a protocol implementation was stretching the
> > abstraction a bit, or whether I haven't considered some other
> > perspective hard enough - maybe we treat the client as the remote
> > device, similar to e.g. a `struct i2c_client`?
>=20
> That was my thinking.  The protocol is used to talk to someone - the endp=
oint
> (similar to i2c_client) so represent that. If that device is handling mul=
tiple
> protocols (no idea if that is possible) - that is fine as well, it just b=
ecomes
> like having multiple i2c_clients in a single package (fairly common for s=
ensors),
> or the many other cases where we use a struct device to represent just pa=
rt
> of a larger device that operates largely independently of other parts (or=
 with
> well defined boundaries).

Alright, let me think about that a bit more.

Thanks for the feedback,

Andrew
