Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EBB77D3EE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbjHOUKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240173AbjHOUKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:10:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334A01BE2;
        Tue, 15 Aug 2023 13:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B53B665D4A;
        Tue, 15 Aug 2023 20:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB47C433C8;
        Tue, 15 Aug 2023 20:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692130212;
        bh=49CtHvFLjsWdVP/KunpxEt8LNawrL89+unX3+egWjbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SVCSHdehYMNtSTV1erQHKXY4UotrI6NWoQqT0HHfEJmYaZRZN92QgUwIJ3xYfODoj
         piYUzW7kePpvMdmoPuRndNpJ76NlR8sFUtQ6/K+IfPXbDRct9+O9myWLqIiBVaV2Z9
         saj1XhW480uTqT7FWgHOynpnh6MOv/A441SvTBcg=
Date:   Tue, 15 Aug 2023 22:10:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, logang@deltatee.com, linux-kernel@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3] PCI/DOE: Expose the DOE protocols via sysfs
Message-ID: <2023081538-grab-alongside-ce24@gregkh>
References: <20230809232851.1004023-1-alistair.francis@wdc.com>
 <20230810073457.GA26246@wunner.de>
 <CAKmqyKPm_BFnNxVLXCO_PVRDJaVb+XOj=kEEzXd+MgkwDiZhXA@mail.gmail.com>
 <20230812081526.GC9469@wunner.de>
 <2023081224-famished-devotion-6e0e@gregkh>
 <CAKmqyKPx9Oi-ZF0grdUzkHi5BjyyNQZ2r30vgShR6cOY9xZ9YQ@mail.gmail.com>
 <2023081543-clarify-deniable-8de8@gregkh>
 <CAKmqyKMHpo8MA9cRAzxWNT+P9poHCKbSpNF4yk8MrVg9+k8=_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKMHpo8MA9cRAzxWNT+P9poHCKbSpNF4yk8MrVg9+k8=_A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 03:50:31PM -0400, Alistair Francis wrote:
> On Tue, Aug 15, 2023 at 11:11 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Aug 15, 2023 at 09:44:32AM -0400, Alistair Francis wrote:
> > > On Sat, Aug 12, 2023 at 4:26 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Sat, Aug 12, 2023 at 10:15:26AM +0200, Lukas Wunner wrote:
> > > > > On Thu, Aug 10, 2023 at 11:34:11AM -0400, Alistair Francis wrote:
> > > > > > On Thu, Aug 10, 2023 at 3:34???AM Lukas Wunner <lukas@wunner.de> wrote:
> > > > > > > On Wed, Aug 09, 2023 at 07:28:51PM -0400, Alistair Francis wrote:
> > > > > > > > --- a/drivers/pci/pci-sysfs.c
> > > > > > > > +++ b/drivers/pci/pci-sysfs.c
> > > > > > > > @@ -1226,6 +1227,12 @@ static int pci_create_resource_files(struct pci_dev *pdev)
> > > > > > > >       int i;
> > > > > > > >       int retval;
> > > > > > > >
> > > > > > > > +#ifdef CONFIG_PCI_DOE
> > > > > > > > +     retval = doe_sysfs_init(pdev);
> > > > > > > > +     if (retval)
> > > > > > > > +             return retval;
> > > > > > > > +#endif
> > > > > > > > +
> > > > > > >
> > > > > > > The preferred way to expose PCI sysfs attributes nowadays is to add them
> > > > > > > to pci_dev_attr_groups[] and use the ->is_visible callback to check
> > > > > > > whether they're applicable to a particular pci_dev.  The alternative
> > > > > > > via pci_create_resource_files() has race conditions which I think
> > > > > > > still haven't been fixed. Bjorn recommended the ->is_visible approach
> > > > > > > in response to the most recent attempt to fix the race:
> > > > > > >
> > > > > > > https://lore.kernel.org/linux-pci/20230427161458.GA249886@bhelgaas/
> > > > > >
> > > > > > The is_visible doen't seem to work in this case.
> > > > > >
> > > > > > AFAIK is_visible only applies to the attributes under the group. Which
> > > > > > means that every PCIe device will see a `doe_protos` directory, no
> > > > > > matter if DOE is supported.
> > > > >
> > > > > internal_create_group() in fs/sysfs/group.c does this:
> > > > >
> > > > >       if (grp->name) {
> > > > >                       ...
> > > > >                       kn = kernfs_create_dir_ns(kobj->sd, grp->name, ...
> > > > >
> > > > > So I'm under the impression that if you set the ->name member of
> > > > > struct attribute_group, the attributes in that group appear under
> > > > > a directory of that name.
> > > > >
> > > > > In fact, the kernel-doc for struct attribute_group claims as much:
> > > > >
> > > > >  * struct attribute_group - data structure used to declare an attribute group.
> > > > >  * @name:     Optional: Attribute group name
> > > > >  *            If specified, the attribute group will be created in
> > > > >  *            a new subdirectory with this name.
> > > > >
> > > > > So I don't quite understand why you think that "every PCIe device will
> > > > > see a `doe_protos` directory, no matter if DOE is supported"?
> > > > >
> > > > > Am I missing something?
> > > >
> > > > I think the issue might be that the directory will be created even if no
> > > > attributes are present in it due to the is_visable() check not returning
> > > > any valid files?
> > >
> > > Yes, that's what I'm seeing. I see the directory for all PCIe devices
> > >
> > > This is a WIP that I had:
> > > https://github.com/alistair23/linux/commit/61925cd174c31386eaa7e51e3a1be606b38f847c
> > >
> > > >
> > > > If so, I had a patch somewhere around here where I was trying to fix
> > > > that up:
> > > >         https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=debugfs_cleanup&id=f670945dfbaf353fe068544c31e3fa45575da5b5
> > > > but it didn't seem to work properly and kept crashing.  I didn't spend
> > > > much time on looking into it, but if this is an issue, I can work on
> > > > fixing this properly.
> > >
> > > That patch sounds like it would fix the issue of empty directories
> > > that I'm seeing. Do you mind fixing it up properly?
> >
> > I am currently unable to do so due to travel and stuff for a few weeks,
> > sorry.  Feel free to take it and fix the boot crash that is seen with it
> > and make it part of your patch series if you can't wait that long.
> 
> No worries.
> 
> It's much harder than I first thought though. There are currently lots
> of users who expect the group to remain even if empty, as they
> dynamically add/merge properties later. Which is what we end up doing
> for DOE as well
> 
> I'll keep looking into this and see if I can figure something out.

Yeah, now that I think about it, that's where stuff fell apart for me as
well.  We should be able to create the group and then only create the
file when they are added/merged, so I bet I missed a codepath somewhere.

> Would an .attr_is_visible() function pointer for struct
> attribute_group something that the kernel would accept?

Worst case, yes, that would be acceptable.  But try to see where I
messed up on the original patch, it should be able to be done
automatically somehow...

thanks,

greg k-h
