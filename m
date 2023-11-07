Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25707E353D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjKGGcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjKGGcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:32:48 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3E510D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 22:32:45 -0800 (PST)
Received: from [192.168.68.112] (ppp14-2-79-67.adl-apt-pir-bras31.tpg.internode.on.net [14.2.79.67])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DD00F20059;
        Tue,  7 Nov 2023 14:32:38 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1699338759;
        bh=MKuaj0jg90e1Nx29apttkt6YjYFsc3MzYDII/TbtDLs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=OKC3cG2TFWGZ9o+reKKcP6G0mzAazWfzL2qpO1XHXV+3XlCMdogJ5ovQFkJ2Soi8A
         ZC8tzFfP/8oF9wTyjxTcgduoi3u7HR7IAFJd96I/HuJu2QKWs1aUuPXnHRfpiJHQsZ
         NJNOLwRFHmaFfJG3LqGzga4KGCntU3vQ5LdrhVXAbjOOOXQ20rAp0YHL1sc23qXw1T
         14xGxreH9kflNL12456nlkJMA0dLCj7DzpoLqbhs20nCEVezHKVLsaktJR3VSp0UzG
         nhM3q0cxhNU94y3+C6vvr6tvMpjlMPn/2eNGjV/cFcCHiyGyGaneqzSSYIxwUaK0Qq
         Ja7WJHIzH4MAw==
Message-ID: <f3b30b70563c68b56451e3eb7a3e22ce4c142651.camel@codeconstruct.com.au>
Subject: Re: [PATCH 05/10] ipmi: kcs_bmc: Define client actions in terms of
 kcs_bmc_client
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, aladyshev22@gmail.com,
        jk@codeconstruct.com.au
Date:   Tue, 07 Nov 2023 17:02:37 +1030
In-Reply-To: <20231103151651.000045ae@Huawei.com>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
         <20231103061522.1268637-6-andrew@codeconstruct.com.au>
         <20231103151651.000045ae@Huawei.com>
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

On Fri, 2023-11-03 at 15:16 +0000, Jonathan Cameron wrote:
> On Fri,  3 Nov 2023 16:45:17 +1030
> Andrew Jeffery <andrew@codeconstruct.com.au> wrote:
>=20
> > Operations such as reading and writing from hardware and updating the
> > events of interest are operations in which the client is interested, bu=
t
> > are applied to the device. Strengthen the concept of the client in the
> > subsystem and clean up some call-sites by translating between the clien=
t
> > and device types in the core of the KCS subsystem.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > ---
> >  drivers/char/ipmi/kcs_bmc.c           | 67 ++++++++++++++++++---------
> >  drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 50 ++++++++++----------
> >  drivers/char/ipmi/kcs_bmc_client.h    | 15 +++---
> >  drivers/char/ipmi/kcs_bmc_serio.c     | 10 ++--
> >  4 files changed, 81 insertions(+), 61 deletions(-)
> >=20
> > diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
> > index 5a3f199241d2..d70e503041bd 100644
> > --- a/drivers/char/ipmi/kcs_bmc.c
> > +++ b/drivers/char/ipmi/kcs_bmc.c
> > @@ -22,33 +22,53 @@ static LIST_HEAD(kcs_bmc_drivers);
> > =20
> >  /* Consumer data access */
> > =20
> > -u8 kcs_bmc_read_data(struct kcs_bmc_device *kcs_bmc)
> > +static void kcs_bmc_client_validate(struct kcs_bmc_client *client)
> >  {
> > -	return kcs_bmc->ops->io_inputb(kcs_bmc, kcs_bmc->ioreg.idr);
> > +	WARN_ONCE(client !=3D READ_ONCE(client->dev->client), "KCS client con=
fusion detected");
>=20
> Is this intended as runtime validation or to catch bugs?
> If just catch bugs then fair enough.

Ah, I think I missed replying here.

So for "runtime validation" I assume you mean "things userspace might
do that are not valid - the error condition should be detected and
punted back to userspace", vs "catch bugs" meaning "the implementation
in the kernel failed to uphold an invariant and now there are
Problems".

If that sounds accurate, then it's the latter: The WARN_ONCE() is
asserting "don't operate on a client that doesn't own the device". It
isn't an error that can be punted back for handling in userspace as it
should not be possible for the kernel to get into this state to begin
with. If we reach this state it's an error in the programming of the
kernel module that's a client of the KCS subsystem.

>=20
> With that question answered based on my somewhat vague understanding of t=
he kcs subsystem.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Andrew
