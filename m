Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6EB766F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbjG1OjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbjG1OjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:39:16 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E993C21;
        Fri, 28 Jul 2023 07:39:15 -0700 (PDT)
Date:   Fri, 28 Jul 2023 14:39:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1690555153; x=1690814353;
        bh=Xeoc38myen4AFKLJ8wKnwjebkYeRV21cILl3Fot7Ftk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=nXPX277Ri5KlMdssd7NDeGxseX+aMDdxKn9o0ZFkdWHioOWPP3P5enF2Gw6b2R+au
         /O4DXS4BW8IgVwyTn5xucEqEfp0wG54eGaKJmQv446te958wc5FpaLhxZNomkZpXJ/
         DE4dow1a29zCCKl1qteD9FhxaI0GIKZ0QaDbJ1IU6AmNJluqcimHr0XP/LlL1+ZZtO
         GJ1ZsQkKpN7nIZu65VyxdYkqc5D/PsfWL8VF0qnhdL26UADuZ9GWLvPqi9VjdydJ2m
         hDdrXdknZ/tGkrNdxCkhVn9fG7e0yJYFP8Hf8XJZEOV3SHpPWoGJFq+XZc7Y6G4pg8
         XQkYSMqZ1ft/Q==
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Subject: Re: [RFC PATCH v1] platform/x86: wmi: Do not register driver with invalid GUID
Message-ID: <wg3zDdNbblZ43zsIf667-fzagNaEDu7WRuCUeLmIQWc68QcIsDF6nw1wCCbzy1NzmaKvXipcVt2oNJAqRvhxdzgLScwnB3KIts_OajtNROM=@protonmail.com>
In-Reply-To: <ZMOSO5HgpurayDsN@smile.fi.intel.com>
References: <20230715211604.1272227-1-pobrn@protonmail.com> <efe4b91f-2602-2115-738e-bb99b42ec5b6@redhat.com> <pjVZC4te3dWaMwoS7jB1-n4z390Ohz0mvuCCUZHwiXlZVMjzwySf_DMa49RDmbhzfvkzRY3FI8zQ0xltNimu-GpBAqJ2Kc3SENu_fwJDJ7E=@protonmail.com> <ZMOSO5HgpurayDsN@smile.fi.intel.com>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


2023. j=C3=BAlius 28., p=C3=A9ntek 12:02 keltez=C3=A9ssel, Andy Shevchenko =
<andriy.shevchenko@linux.intel.com> =C3=ADrta:

> On Thu, Jul 27, 2023 at 10:54:26PM +0000, Barnab=C3=A1s P=C5=91cze wrote:
> > 2023. j=C3=BAlius 26., szerda 10:45 keltez=C3=A9ssel, Hans de Goede <hd=
egoede@redhat.com> =C3=ADrta:
> > > On 7/15/23 23:24, Barnab=C3=A1s P=C5=91cze wrote:
>=20
> ...
>=20
> > > I think that having an additional check like the one which you
> > > propose has some value too, even if it is just to cover drivers
> > > which for some reason don't use `MODULE_DEVICE_TABLE()`, but IMHO
> > > the most important check to have is a check in file2alias.c .
> >
> > Okay... any tips on how to avoid copying `uuid_is_valid()`?
>=20
> I think I already told the rough design: we need to split uuid.c to three
> files: libuuid.h, libuuid.c uuid.c and libuuid.c should be built twice:
> once for uuid.c and once for file2alias.c. libuuid.h should contain the
> definitions file2alias.c is using.  Something like that.

What is not clear at all to me is how includes should be handled. `uuid_is_=
valid()`
uses `isxdigit()`, which is found in different header files based on whethe=
r it is
a kernel or user space build.


>=20
> > Another idea I had was that maybe `struct wmi_device_id::guid_string` n=
eeds to be
> > changed to be `guid_t` and then `GUID_INIT()` or something similar coul=
d be used
> > to initialize it. That way it is impossible to mess up the format. The =
only downside
> > I can see is that guid is no longer "grep-able".
>=20
> Strictly speaking you may not do that because it's a (semi-)ABI.

Why is that the case?


Regards,
Barnab=C3=A1s P=C5=91cze
