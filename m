Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8307B5D5A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 00:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbjJBWvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 18:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236756AbjJBWvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:51:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22155CE;
        Mon,  2 Oct 2023 15:50:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C30AC433C7;
        Mon,  2 Oct 2023 22:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696287057;
        bh=/OqHkpnCr2yp1sDRAdjhGT7oMqmIEUALgDHapbczbmI=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=YOzaTs8xV30AkpqZbykvhJSF0mNTVlgNrJdaZuah8iyObs6eMafbHTI/hNig4dWQX
         vrC2a+GKlGOLBX6HK26gDeMOht2XNo+CNdwjXs5srCzTgdOfpbbQUUJDqTUYD0tuXj
         5Ogpu/QrdP84k1KW44KYcZ484+H0U8gegEkBVgqLEnbrUOc4eqSG0slsHEIvnlad3P
         Z56UeZDV+NpTwaI3LNFfV23LROuNH6PrMrmZQyTOgf4na/6gwlG+gzXU8XkYhLdzKb
         7UXnUl6BPmy6BcW3oSUZm6y9Paqwl5OjOF2Z6r/UPVGqTS98/289KlB2V8IYDupALH
         TqzvT1Mi7RhWQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 03 Oct 2023 01:50:43 +0300
Message-Id: <CVYBKLX6LJR4.22G72LXAHW77W@seitikki>
Cc:     "Mimi Zohar" <zohar@linux.ibm.com>,
        "James Bottomley" <jejb@linux.ibm.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Ahmad Fatoum" <a.fatoum@pengutronix.de>,
        "sigma star Kernel Team" <upstream+dcp@sigma-star.at>,
        "David Howells" <dhowells@redhat.com>,
        "Li Yang" <leoyang.li@nxp.com>, "Paul Moore" <paul@paul-moore.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Tejun Heo" <tj@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "Richard Weinberger" <richard@nod.at>,
        "David Oberhollenzer" <david.oberhollenzer@sigma-star.at>
Subject: Re: [PATCH v3 1/3] crypto: mxs-dcp: Add support for hardware
 provided keys
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "David Gstir" <david@sigma-star.at>
X-Mailer: aerc 0.14.0
References: <20230918141826.8139-1-david@sigma-star.at>
 <20230918141826.8139-2-david@sigma-star.at>
 <CVS3NIJ8OO6Y.2C6GJ9OBR6COC@suppilovahvero>
 <88FFAB6B-10A8-4732-A901-50859E22352D@sigma-star.at>
In-Reply-To: <88FFAB6B-10A8-4732-A901-50859E22352D@sigma-star.at>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Sep 27, 2023 at 9:25 AM EEST, David Gstir wrote:
> Jarkko,
>
> > On 25.09.2023, at 17:22, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >=20
> > On Mon Sep 18, 2023 at 5:18 PM EEST, David Gstir wrote:
> >> DCP is capable to performing AES with hardware-bound keys.
> >> These keys are not stored in main memory and are therefore not directl=
y
> >> accessible by the operating system.
> >>=20
> >> So instead of feeding the key into DCP, we need to place a
> >> reference to such a key before initiating the crypto operation.
> >> Keys are referenced by a one byte identifiers.
> >=20
> > Not sure what the action of feeding key into DCP even means if such
> > action does not exists.
> >=20
> > What you probably would want to describe here is how keys get created
> > and how they are referenced by the kernel.
> >=20
> > For the "use" part please try to avoid academic paper style long
> > expression starting with "we" pronomine.
> >=20
> > So the above paragraph would normalize into "The keys inside DCP
> > are referenced by one byte identifier". Here of course would be
> > for the context nice to know what is this set of DCP keys. E.g.
> > are total 256 keys or some subset?
> >=20
> > When using too much prose there can be surprsingly little digestable
> > information, thus this nitpicking.
>
> Thanks for reviewing that in detail! I=E2=80=99ll rephrase the commit
> messages on all patches to get rid of the academic paper style.
>
>
> >=20
> >> DCP supports 6 different keys: 4 slots in the secure memory area,
> >> a one time programmable key which can be burnt via on-chip fuses
> >> and an unique device key.
> >>=20
> >> Using these keys is restricted to in-kernel users that use them as bui=
lding
> >> block for other crypto tools such as trusted keys. Allowing userspace
> >> (e.g. via AF_ALG) to use these keys to crypt or decrypt data is a secu=
rity
> >> risk, because there is no access control mechanism.
> >=20
> > Unless this patch has anything else than trusted keys this should not
> > be an open-ended sentence. You want to say roughly that DCP hardware
> > keys are implemented for the sake to implement trusted keys support,
> > and exactly and only that.
> >=20
> > This description also lacks actions taken by the code changes below,
> > which is really the beef of any commit description.
>
> You=E2=80=99re right. I=E2=80=99ll add that.

Yup, I'm just doing my part of the job, as I'm expected to do it :-)
Thanks for understanding.

> Thanks,
> - David

BR, Jarkko
