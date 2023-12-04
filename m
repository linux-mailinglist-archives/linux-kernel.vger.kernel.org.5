Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BA880418C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjLDWTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjLDWTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:19:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47DBD5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:19:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B907CC433C8;
        Mon,  4 Dec 2023 22:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701728377;
        bh=0hNiw7to/yO9/NIok2V2cBm5rPlBjCyUvP5ni95GaCo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=nl2Zobp4xA5MMX0jOv7fSNJ3LZ7p6u6rrTEfJqV3NaH9iLF5TGS+8W1XJ3DSaXp7I
         CfnzIX09PeJ0dI7Av/hlmk2xlYT41Yw96jdH2Bcr6fKBtqrA6TAU37MNT6UXUFKLLG
         fLkP9o2Xk+xEk2uSax32m1PuJESDhZvvI4rWklxEflp5JVXPwfMwVF+3C/559d9gz+
         D7uyDJeh0fCJ1ceOAruTXFN8PHTXP9ZB4KrZOPEjy4TEc1CbdQJkPQqT/tvJGGXGbB
         cGRTgfnABxD9Rtj9nn7YKUUjZVPCtprOMd0dvkekZCY3J/VlKBdRig+5FFznGyg0HQ
         VfR2Qofk/fH3g==
Date:   Mon, 4 Dec 2023 14:19:33 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Jiqian Chen <Jiqian.Chen@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
        Honglei Huang <Honglei1.Huang@amd.com>,
        Julia Zhang <Julia.Zhang@amd.com>,
        Huang Rui <Ray.Huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v2 2/3] xen/pvh: Unmask irq for passthrough
 device in PVH dom0
In-Reply-To: <ZW2ptexPQXrWBiOS@macbook>
Message-ID: <alpine.DEB.2.22.394.2312041413000.110490@ubuntu-linux-20-04-desktop>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com> <20231124103123.3263471-3-Jiqian.Chen@amd.com> <alpine.DEB.2.22.394.2311291950350.3533093@ubuntu-linux-20-04-desktop> <ZWiyBP4Lzz5lXraP@macbook> <alpine.DEB.2.22.394.2311301912350.110490@ubuntu-linux-20-04-desktop>
 <ZWmgJNidFsfkDp7q@macbook> <alpine.DEB.2.22.394.2312011857260.110490@ubuntu-linux-20-04-desktop> <ZW2ptexPQXrWBiOS@macbook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1207504391-1701728057=:110490"
Content-ID: <alpine.DEB.2.22.394.2312041414460.110490@ubuntu-linux-20-04-desktop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1207504391-1701728057=:110490
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2312041414461.110490@ubuntu-linux-20-04-desktop>

On Mon, 4 Dec 2023, Roger Pau Monné wrote:
> On Fri, Dec 01, 2023 at 07:37:55PM -0800, Stefano Stabellini wrote:
> > On Fri, 1 Dec 2023, Roger Pau Monné wrote:
> > > On Thu, Nov 30, 2023 at 07:15:17PM -0800, Stefano Stabellini wrote:
> > > > On Thu, 30 Nov 2023, Roger Pau Monné wrote:
> > > > > On Wed, Nov 29, 2023 at 07:53:59PM -0800, Stefano Stabellini wrote:
> > > > > > On Fri, 24 Nov 2023, Jiqian Chen wrote:
> > > > > > > This patch is to solve two problems we encountered when we try to
> > > > > > > passthrough a device to hvm domU base on Xen PVH dom0.
> > > > > > > 
> > > > > > > First, hvm guest will alloc a pirq and irq for a passthrough device
> > > > > > > by using gsi, before that, the gsi must first has a mapping in dom0,
> > > > > > > see Xen code pci_add_dm_done->xc_domain_irq_permission, it will call
> > > > > > > into Xen and check whether dom0 has the mapping. See
> > > > > > > XEN_DOMCTL_irq_permission->pirq_access_permitted, "current" is PVH
> > > > > > > dom0 and it return irq is 0, and then return -EPERM.
> > > > > > > This is because the passthrough device doesn't do PHYSDEVOP_map_pirq
> > > > > > > when thay are enabled.
> > > > > > > 
> > > > > > > Second, in PVH dom0, the gsi of a passthrough device doesn't get
> > > > > > > registered, but gsi must be configured for it to be able to be
> > > > > > > mapped into a domU.
> > > > > > > 
> > > > > > > After searching codes, we can find map_pirq and register_gsi will be
> > > > > > > done in function vioapic_write_redirent->vioapic_hwdom_map_gsi when
> > > > > > > the gsi(aka ioapic's pin) is unmasked in PVH dom0. So the problems
> > > > > > > can be conclude to that the gsi of a passthrough device doesn't be
> > > > > > > unmasked.
> > > > > > > 
> > > > > > > To solve the unmaske problem, this patch call the unmask_irq when we
> > > > > > > assign a device to be passthrough. So that the gsi can get registered
> > > > > > > and mapped in PVH dom0.
> > > > > > 
> > > > > > 
> > > > > > Roger, this seems to be more of a Xen issue than a Linux issue. Why do
> > > > > > we need the unmask check in Xen? Couldn't we just do:
> > > > > > 
> > > > > > 
> > > > > > diff --git a/xen/arch/x86/hvm/vioapic.c b/xen/arch/x86/hvm/vioapic.c
> > > > > > index 4e40d3609a..df262a4a18 100644
> > > > > > --- a/xen/arch/x86/hvm/vioapic.c
> > > > > > +++ b/xen/arch/x86/hvm/vioapic.c
> > > > > > @@ -287,7 +287,7 @@ static void vioapic_write_redirent(
> > > > > >              hvm_dpci_eoi(d, gsi);
> > > > > >      }
> > > > > >  
> > > > > > -    if ( is_hardware_domain(d) && unmasked )
> > > > > > +    if ( is_hardware_domain(d) )
> > > > > >      {
> > > > > >          /*
> > > > > >           * NB: don't call vioapic_hwdom_map_gsi while holding hvm.irq_lock
> > > > > 
> > > > > There are some issues with this approach.
> > > > > 
> > > > > mp_register_gsi() will only setup the trigger and polarity of the
> > > > > IO-APIC pin once, so we do so once the guest unmask the pin in order
> > > > > to assert that the configuration is the intended one.  A guest is
> > > > > allowed to write all kind of nonsense stuff to the IO-APIC RTE, but
> > > > > that doesn't take effect unless the pin is unmasked.
> > > > > 
> > > > > Overall the question would be whether we have any guarantees that
> > > > > the hardware domain has properly configured the pin, even if it's not
> > > > > using it itself (as it hasn't been unmasked).
> > > > > 
> > > > > IIRC PCI legacy interrupts are level triggered and low polarity, so we
> > > > > could configure any pins that are not setup at bind time?
> > > > 
> > > > That could work.
> > > > 
> > > > Another idea is to move only the call to allocate_and_map_gsi_pirq at
> > > > bind time? That might be enough to pass a pirq_access_permitted check.
> > > 
> > > Maybe, albeit that would change the behavior of XEN_DOMCTL_bind_pt_irq
> > > just for PT_IRQ_TYPE_PCI and only when called from a PVH dom0 (as the
> > > parameter would be a GSI instead of a previously mapped IRQ).  Such
> > > difference just for PT_IRQ_TYPE_PCI is slightly weird - if we go that
> > > route I would recommend that we instead introduce a new dmop that has
> > > this syntax regardless of the domain type it's called from.
> > 
> > Looking at the code it is certainly a bit confusing. My point was that
> > we don't need to wait until polarity and trigger are set appropriately
> > to allow Dom0 to pass successfully a pirq_access_permitted() check. Xen
> > should be able to figure out that Dom0 is permitted pirq access.
> 
> The logic is certainly not straightforward, and it could benefit from
> some comments.
> 
> The irq permissions are a bit special, in that they get setup when the
> IRQ is mapped.
> 
> The problem however is not so much with IRQ permissions, that we can
> indeed sort out internally in Xen.  Such check in dom0 has the side
> effect of preventing the IRQ from being assigned to a domU without the
> hardware source being properly configured AFAICT.

Now I understand why you made a comment previously about Xen having to
configure trigger and polarity for these interrupts on its own.


> > So the idea was to move the call to allocate_and_map_gsi_pirq() earlier
> > somewhere because allocate_and_map_gsi_pirq doesn't require trigger or
> > polarity to be configured to work. But the suggestion of doing it a
> > "bind time" (meaning: XEN_DOMCTL_bind_pt_irq) was a bad idea.
> > 
> > But maybe we can find another location, maybe within
> > xen/arch/x86/hvm/vioapic.c, to call allocate_and_map_gsi_pirq() before
> > trigger and polarity are set and before the interrupt is unmasked.
> > 
> > Then we change the implementation of vioapic_hwdom_map_gsi to skip the
> > call to allocate_and_map_gsi_pirq, because by the time
> > vioapic_hwdom_map_gsi we assume that allocate_and_map_gsi_pirq had
> > already been done.
> 
> But then we would end up in a situation where the
> pirq_access_permitted() check will pass, but the IO-APIC pin won't be
> configured, which I think it's not what we want.
> 
> One option would be to allow mp_register_gsi() to be called multiple
> times, and update the IO-APIC pin configuration as long as the pin is
> not unmasked.  That would propagate each dom0 RTE update to the
> underlying IO-APIC.  However such approach relies on dom0 configuring
> all possible IO-APIC pins, even if no device on dom0 is using them, I
> think it's not a very reliable option.
> 
> Another option would be to modify the toolstack to setup the GSI
> itself using the PHYSDEVOP_setup_gsi hypercall.  As said in a previous
> email, since we only care about PCI device passthrough the legacy INTx
> should always be level triggered and low polarity.
> 
> > I am not familiar with vioapic.c but to give you an idea of what I was
> > thinking:
> > 
> > 
> > diff --git a/xen/arch/x86/hvm/vioapic.c b/xen/arch/x86/hvm/vioapic.c
> > index 4e40d3609a..16d56fe851 100644
> > --- a/xen/arch/x86/hvm/vioapic.c
> > +++ b/xen/arch/x86/hvm/vioapic.c
> > @@ -189,14 +189,6 @@ static int vioapic_hwdom_map_gsi(unsigned int gsi, unsigned int trig,
> >          return ret;
> >      }
> >  
> > -    ret = allocate_and_map_gsi_pirq(currd, pirq, &pirq);
> > -    if ( ret )
> > -    {
> > -        gprintk(XENLOG_WARNING, "vioapic: error mapping GSI %u: %d\n",
> > -                 gsi, ret);
> > -        return ret;
> > -    }
> > -
> >      pcidevs_lock();
> >      ret = pt_irq_create_bind(currd, &pt_irq_bind);
> >      if ( ret )
> > @@ -287,6 +279,17 @@ static void vioapic_write_redirent(
> >              hvm_dpci_eoi(d, gsi);
> >      }
> >  
> > +    if ( is_hardware_domain(d) ) 
> > +    {
> > +        int pirq = gsi, ret;
> > +        ret = allocate_and_map_gsi_pirq(currd, pirq, &pirq);
> > +        if ( ret )
> > +        {
> > +            gprintk(XENLOG_WARNING, "vioapic: error mapping GSI %u: %d\n",
> > +                    gsi, ret);
> > +            return ret;
> > +        }
> > +    }
> >      if ( is_hardware_domain(d) && unmasked )
> >      {
> >          /*
> 
> As said above, such approach relies on dom0 writing to the IO-APIC RTE
> of likely each IO-APIC pin, which is IMO not quite reliable.  In there
> are two different issues here that need to be fixed for PVH dom0:
> 
>  - Fix the XEN_DOMCTL_irq_permission pirq_access_permitted() call to
>    succeed for a PVH dom0, even if dom0 is not using the GSI itself.

Yes makes sense


>  - Configure IO-APIC pins for PCI interrupts even if dom0 is not using
>    the IO-APIC pin itself.
> 
> First one needs to be fixed internally in Xen, second one will require
> the toolstack to issue an extra hypercall in order to ensure the
> IO-APIC pin is properly configured.
 
On ARM, Xen doesn't need to wait for dom0 to configure interrupts
correctly. Xen configures them all on its own at boot based on Device
Tree information. I guess it is not possible to do the same on x86? If
not, then I can see why we would need 1 extra toolstack hypercall for
that (or to bundle the operation of configuring IO-APIC pins together
with an existing toolstack hypercall).
--8323329-1207504391-1701728057=:110490--
