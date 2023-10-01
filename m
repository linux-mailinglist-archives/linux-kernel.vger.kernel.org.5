Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6222B7B4742
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 13:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbjJAL5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 07:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjJAL5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 07:57:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB71D3
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 04:57:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F2CC433C8;
        Sun,  1 Oct 2023 11:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696161448;
        bh=JsTcYuCjnKCRS49oBtoC/vqy3wZU5S1GK8S0OnCnZK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zaeTs7ygqGfjrJWOnFpfD3yxD4Vik2KbdPjbE0n2twJEyAqkuWttYUXY3y0MSydKM
         VgbDXZMTofVh3NjFuvBjRB+0g7QNWvqSbKpMModxj2vdeuN1iJey22rW1P4myyS8lf
         by8piuTx91mqiUPbju6XcRad0soc2YA8f92gTkJ4=
Date:   Sun, 1 Oct 2023 13:57:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Chris Leech <cleech@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Rasesh Mody <rmody@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Lee Duncan <lduncan@suse.com>,
        Mike Christie <michael.christie@oracle.com>,
        Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Message-ID: <2023100114-flatware-mourner-3fed@gregkh>
References: <20230929170023.1020032-1-cleech@redhat.com>
 <20230929170023.1020032-4-cleech@redhat.com>
 <2023093055-gotten-astronomy-a98b@gregkh>
 <ZRhmqBRNUB3AfLv/@rhel-developer-toolbox>
 <2023093002-unlighted-ragged-c6e1@gregkh>
 <e0360d8f-6d36-4178-9069-d633d9b7031d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0360d8f-6d36-4178-9069-d633d9b7031d@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 12:44:05PM +0200, Hannes Reinecke wrote:
> On 9/30/23 20:28, Greg Kroah-Hartman wrote:
> > On Sat, Sep 30, 2023 at 11:19:20AM -0700, Chris Leech wrote:
> > > On Sat, Sep 30, 2023 at 09:06:51AM +0200, Greg Kroah-Hartman wrote:
> > > > On Fri, Sep 29, 2023 at 10:00:23AM -0700, Chris Leech wrote:
> > > > > Make use of the new UIO_MEM_DMA_COHERENT type to properly handle mmap
> > > > > for dma_alloc_coherent buffers.
> > > > 
> > > > Why are ethernet drivers messing around with UIO devices?  That's not
> > > > what UIO is for, unless you are trying to do kernel bypass for these
> > > > devices without anyone noticing?
> > > > 
> > > > confused,
> > > 
> > > It's confusing. The bnx2 driver stack included a cnic (converged nic?)
> > > module that sits between the ethernet drivers (bnx2, bnx2x) and protocol
> > > offload drivers (iscsi, fcoe, rdma).
> > > 
> > > The iscsi module (bnx2i) uses a passthrough interface from cnic to
> > > handle some network configuration that the device firmware doesn't do.
> > > It uses a uio device and a userspace component called iscsiuio to do
> > > that.
> > 
> > That's horrible, and not what the UIO api is for at all.  Configure the
> > device like any other normal kernel device, don't poke at raw memory
> > values directly, that way lies madness.
> > 
> > Have a pointer to the userspace tool anywhere?  All I found looks like a
> > full IP stack in userspace under that name, and surely that's not what
> > this api is for...
> > 
> But that's how the interface is used, in particular for the bnx2i driver.
> Problem is that the bnx2i iSCSI offload is just that, an iSCSI offload. Not
> a TCP offload. So if the iSCSI interface is configured to
> acquire the IP address via DHCP, someone has to run the DHCP protocol.
> But the iSCSI offload can't, and the bnx2i PCI device is not a network
> device so that the normal network stack can't be used.
> And so the architects of the bnx2i card decided to use UIO to pass
> the network traffic to userspace, and used the userspace 'iscsiuio'
> application to run DHCP in userspace.
> 
> But's been that way for several years now; so long, in fact, that
> the card itself has been out of support from Marvell (since quite some
> years, too, IIRC). And even the successor of that card (the qedi driver)
> is nearing EOL. Mind you, the qedi driver is using the same interface (by
> using UIO to run DHCP in userspace), so singling out the bnx2i for bad
> design can be construed as being unfair :-)

Ok, let's say they are all horrible! :)

> I agree, though, that the design is a mess.

Ok, so why are we papering over it and continuing to allow it to exist?

What "broke" to suddenly require this UIO change?  If this has been
around for a very long time, what has caused this to now require the UIO
layer to change?

thanks,

greg k-h
