Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E01A759E80
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGSTYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGSTYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:24:21 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EB42108;
        Wed, 19 Jul 2023 12:23:52 -0700 (PDT)
Date:   Wed, 19 Jul 2023 19:23:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1689794628; x=1690053828;
        bh=IL73x9/3e7aPgiPUN+IQu7hCH2EH/t8unrXpz7ZHD+I=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=nqZc6JT/EQgIAc+DcnZs9LuRQB+aPpJtWfd0CORBMmhzeg9Me2uRV3t7EvumniCYo
         cn1Awo6E7nPth53+46lJzPgTiwF5ph/XxM/CjjXsYbdQGrX84XS8vweVWFjNVX5BjB
         +mLozPEC8UdDrrovkAubdFavIAs6lJQ3nXpAHf+xscJcqwGf0GMf5aVLMql1vfdoDe
         IcXznCZXCw+cqEt3XnOZadzgkSf1wtdtwAaQnVmE0u7ccJl514Cg0GaLUXplUsC2+B
         bOoS2BXEH033AXBI2mh7BNeQut4M35BCwFnPeV0s+5eYeZ70zSwGboaQcr6Ae6Xn40
         k6UORGnMm6gyw==
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Armin Wolf <W_Armin@gmx.de>
Subject: Re: [RFC PATCH v1] platform/x86: wmi: Do not register driver with invalid GUID
Message-ID: <kN5iBK5RwAEr8LXNTgb6dUk7zxuGFFtF2q_ReNezksLqaq7C4frYfo6ELswUu0wVoewy3UENAwFjjK48d2qBwf6q4is8ST28zpK6-ze_eIU=@protonmail.com>
In-Reply-To: <ZLUmh0nKJdRMmhX1@smile.fi.intel.com>
References: <20230715211604.1272227-1-pobrn@protonmail.com> <ZLUOxnE58wUgZXWx@smile.fi.intel.com> <mL0s5ZsO3eU18EzO_7zVsawf2rr7o-zsOrwBDncazQIAgRn-LRNTGw2ugm1bfRoHKWTRYmUHt8s7zjfNEESapwFZlaNj6B041x_AZ-pagoI=@protonmail.com> <ZLUmh0nKJdRMmhX1@smile.fi.intel.com>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


2023. j=C3=BAlius 17., h=C3=A9tf=C5=91 13:31 keltez=C3=A9ssel, Andy Shevche=
nko =C3=ADrta:

> On Mon, Jul 17, 2023 at 11:23:50AM +0000, Barnab=C3=A1s P=C5=91cze wrote:
> > 2023. j=C3=BAlius 17., h=C3=A9tf=C5=91 11:49 keltez=C3=A9ssel, Andy She=
vchenko <andriy.shevchenko@linux.intel.com> =C3=ADrta:
> > On Sat, Jul 15, 2023 at 09:24:16PM +0000, Barnab=C3=A1s P=C5=91cze wrot=
e:
> > > > Since a WMI driver's ID table contains strings it is relatively
> > > > easy to make mistakes. At the moment, there is no feedback
> > > > if any of the specified GUIDs are invalid (since
> > > > 028e6e204ace1f080cfeacd72c50397eb8ae8883).
> > > >
> > > > So check if the GUIDs in the driver's ID table are valid,
> > > > print all invalid ones, and refuse to register the driver
> > > > if any of the GUIDs are invalid.
> > >
> > > Besides using wrong API (uuid_*() vs. guid_*() one), I don't
> >
> > As far as I can see `guid_parse()` also uses `uuid_is_valid()`, the for=
mat is the same.
>=20
> Then add guid_is_valid() to complete the API. Perhaps with the renaming t=
he
> common part to something else.

But that would be the exact same function. GUIDs are UUIDs, aren't they?


>=20
> > > think we need to validate it here. Why not in file2alias.c?
> > > [...]
> >
> > 1) that seems like a more complicated change (duplicating `uuid_is_vali=
d()`?);
> > 2) that will only check the GUIDs specified by `MODULE_DEVICE_TABLE()`.
> >
> > Arguably the second point is not that significant since most users will=
 indeed
> > use `MODULE_DEVICE_TABLE()`. But I think the first point has some merit=
. And
> > furthermore, I think this check should be here regardless of whether fi=
le2alias.c
> > also contains an equivalent/similar check.
>=20
> Why do we need it? We never match against wrong GUID from ACPI, since it =
would
> be very weird ACPI table.
> [...]

The point is to catch typos in drivers' WMI ID tables.


Regards,
Barnab=C3=A1s P=C5=91cze
