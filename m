Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C716A811D61
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379218AbjLMSvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjLMSvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:51:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7651D107
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702493465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3bz2PFKioWO39O1b/K33auuuNG1O5t2+2CTYPmaCsuU=;
        b=huLjng6M0lT5cFR5IuQkkKWhaCOxozjCvQtkb/hAZyzGivhEWCDX13d/OZ2Il1v6b3tptc
        YX+JaTEu+g6zCmPad5Mmti6N6MVm7PgzsLOM/AcHzkIVoEinUefGQMx9RnkybFquAp2Yct
        jqc2w4qNGwUP/Qu1Ju8ngysCr9Fgq2Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-uqwVFLpTNPiw7lFSnN5omw-1; Wed, 13 Dec 2023 13:51:01 -0500
X-MC-Unique: uqwVFLpTNPiw7lFSnN5omw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33608afb161so5061200f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493460; x=1703098260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bz2PFKioWO39O1b/K33auuuNG1O5t2+2CTYPmaCsuU=;
        b=wX5sOoyWb17/7s22tfptseCm+7oTlTfvWsA4yeVeEP7U6BvEWkosKB1YaJFcLB4F4m
         kVFsj1fgBaSulNMOE74jzGfkthbigS2yNeQt2nun610CDCd5juHUKOcH/BkJr7ToOAy2
         AzE/iG7PwKyXeHkurmekaiHAK/TZc6ZjA+12cpzZpmkvWM+rGuc21fDqosvH4e+bftYL
         6K1Rh7FVkA8JsLLsQoMZ/Sk/+457KoUTi6V64NrQZWZqv/7XsmU8WIaJxFXaIJiI84Uw
         Fk6kodcinrRKhCq7OQyct9ovxIp3fwSapl8BMaDoBCQgQ8ADP4i4e7ES1nxk97/Yw++z
         PuNg==
X-Gm-Message-State: AOJu0YxZiQj8KvC8KAf4UWSRAWE428BMvjc9dQCHGfBypC3lkaO9YmMA
        M/pDBpnfW7dRj+z0UMgFT+C5XS1DliUCXwyn3a1GeGXlvFY5XMD3KWqJbbdpQ+FinqWT12EoYcG
        S7MYjRUcMuQNr0a2AsV7kuNtjHTLby/IBO2yVAeF+
X-Received: by 2002:adf:fb03:0:b0:336:81b:7b3e with SMTP id c3-20020adffb03000000b00336081b7b3emr4694816wrr.84.1702493460720;
        Wed, 13 Dec 2023 10:51:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrOqThvRO3wtBz0WPYYTaM1hs7Q8Qv3LHMthbrTRo6wldeHDuIrDcx4q8TA6SBkLf72CI9CplVyd0Z267kaPY=
X-Received: by 2002:adf:fb03:0:b0:336:81b:7b3e with SMTP id
 c3-20020adffb03000000b00336081b7b3emr4694811wrr.84.1702493460440; Wed, 13 Dec
 2023 10:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20231213003614.1648343-1-imammedo@redhat.com> <20231213003614.1648343-3-imammedo@redhat.com>
 <CAJZ5v0gowV0WJd8pjwrDyHSJPvwgkCXYu9bDG7HHfcyzkSSY6w@mail.gmail.com>
 <CAMLWh55dr2e_R+TYVj=8cFfV==D-DfOZvAeq9JEehYs3nw6-OQ@mail.gmail.com> <20231213115248-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231213115248-mutt-send-email-mst@kernel.org>
From:   Igor Mammedov <imammedo@redhat.com>
Date:   Wed, 13 Dec 2023 19:50:48 +0100
Message-ID: <CAMLWh56qLpe8PsndvzKv5WB_-qeOUPt1vEumTC3tW8M-9bGU-w@mail.gmail.com>
Subject: Re: [RFC 2/2] PCI: acpiphp: slowdown hotplug if hotplugging multiple
 devices at a time
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        lenb@kernel.org, bhelgaas@google.com,
        mika.westerberg@linux.intel.com, boris.ostrovsky@oracle.com,
        joe.jin@oracle.com, stable@vger.kernel.org,
        Fiona Ebner <f.ebner@proxmox.com>,
        Thomas Lamprecht <t.lamprecht@proxmox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 5:54=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Dec 13, 2023 at 05:49:39PM +0100, Igor Mammedov wrote:
> > On Wed, Dec 13, 2023 at 2:08=E2=80=AFPM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 1:36=E2=80=AFAM Igor Mammedov <imammedo@redha=
t.com> wrote:
> > > >
> > > > previous commit ("PCI: acpiphp: enable slot only if it hasn't been =
enabled already"
> > > > introduced a workaround to avoid a race between SCSI_SCAN_ASYNC job=
 and
> > > > bridge reconfiguration in case of single HBA hotplug.
> > > > However in virt environment it's possible to pause machine hotplug =
several
> > > > HBAs and let machine run. That can hit the same race when 2nd hotpl=
ugged
> > > > HBA will start re-configuring bridge.
> > > > Do the same thing as SHPC and throttle down hotplug of 2nd and up
> > > > devices within single hotplug event.
> > > >
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > ---
> > > >  drivers/pci/hotplug/acpiphp_glue.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotpl=
ug/acpiphp_glue.c
> > > > index 6b11609927d6..30bca2086b24 100644
> > > > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > > > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > > > @@ -37,6 +37,7 @@
> > > >  #include <linux/mutex.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/acpi.h>
> > > > +#include <linux/delay.h>
> > > >
> > > >  #include "../pci.h"
> > > >  #include "acpiphp.h"
> > > > @@ -700,6 +701,7 @@ static void trim_stale_devices(struct pci_dev *=
dev)
> > > >  static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
> > > >  {
> > > >         struct acpiphp_slot *slot;
> > > > +        int nr_hp_slots =3D 0;
> > > >
> > > >         /* Bail out if the bridge is going away. */
> > > >         if (bridge->is_going_away)
> > > > @@ -723,6 +725,10 @@ static void acpiphp_check_bridge(struct acpiph=
p_bridge *bridge)
> > > >
> > > >                         /* configure all functions */
> > > >                         if (slot->flags !=3D SLOT_ENABLED) {
> > > > +                               if (nr_hp_slots)
> > > > +                                       msleep(1000);
> > >
> > > Why is 1000 considered the most suitable number here?  Any chance to
> > > define a symbol for it?
> >
> > Timeout was borrowed from SHPC hotplug workflow where it apparently
> > makes race harder to reproduce.
> > (though it's not excuse to add more timeouts elsewhere)
> >
> > > And won't this affect the cases when the race in question is not a co=
ncern?
> >
> > In practice it's not likely, since even in virt scenario hypervisor won=
't
> > stop VM to hotplug device (which beats whole purpose of hotplug).
> >
> > But in case of a very slow VM (overcommit case) it's possible for
> > several HBA's to be hotplugged by the time acpiphp gets a chance
> > to handle the 1st hotplug event. SHPC is more or less 'safe' with its
> > 1sec delay.
> >
> > > Also, adding arbitrary timeouts is not the most robust way of
> > > addressing race conditions IMV.  Wouldn't it be better to add some
> > > proper synchronization between the pieces of code that can race with
> > > each other?
> >
> > I don't like it either, it's a stop gap measure to hide regression on
> > short notice,
> > which I can fixup without much risk in short time left, before folks
> > leave on holidays.
> > It's fine to drop the patch as chances of this happening are small.
> > [1/2] should cover reported cases.
> >
> > Since it's RFC, I basically ask for opinions on a proper way to fix
> > SCSI_ASYNC_SCAN
> > running wild while the hotplug is in progress (and maybe SCSI is not
> > the only user that
> > schedules async job from device probe).
>
> Of course not. And things don't have to be scheduled from probe right?
> Can be triggered by an interrupt or userspace activity.

Maybe, but it would probably depend on driver/device.

For HBA case, we probably can't depend on iqr or a userspace activity.
Current expectations are that after hotplug HBA will show up along with
drives attached to it. I suppose udev can kick off scan on HBA after device
appears but it is still postponing the same race just elsewhere.
Not to mention making the whole system more complicated/fragile.

Also async scan during hotplug begs a question, it does speed up
boot process with several HBA. But how much sense it makes to do so
at hotplug time where resources are plugged on demand
(synchronous scan might even be better).


> > So adding synchronisation and testing
> > would take time (not something I'd do this late in the cycle).
> >
> > So far I'm thinking about adding rw mutex to bridge with the PCI
> > hotplug subsystem
> > being a writer while scsi scan jobs would be readers and wait till hotp=
lug code
> > says it's safe to proceed.
> > I plan to work in this direction and give it some testing, unless
> > someone has a better idea.
>
> > >
> > > > +
> > > > +                                ++nr_hp_slots;
> > > >                                 enable_slot(slot, true);
> > > >                         }
> > > >                 } else {
> > > > --
> > >
>

