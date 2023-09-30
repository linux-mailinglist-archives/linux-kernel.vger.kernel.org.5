Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC9A7B4301
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 20:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbjI3S2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 14:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbjI3S2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 14:28:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686CFD3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 11:28:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75395C433C8;
        Sat, 30 Sep 2023 18:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696098513;
        bh=Y9iCNcGGh4nfHDPA28tz0aK7pyM7yVYEhIxnYu0QfG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1k1HaUHuIORJNTGPd+sZFi8gkE0zdO5YIja2DkSsvLFPK3pYs55Mobkwz8fLs6rQa
         hwvyWiSwwBSQYASjE9dZKij+EUA2Fa34mmaJzW6xCgu77gCaDAUE04LiuQTjOpMCrI
         geP/D2iDqYhIqiZ1P5iV7vt3YGQxYQl12/7T17F4=
Date:   Sat, 30 Sep 2023 20:28:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Leech <cleech@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Rasesh Mody <rmody@marvell.com>,
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
Message-ID: <2023093002-unlighted-ragged-c6e1@gregkh>
References: <20230929170023.1020032-1-cleech@redhat.com>
 <20230929170023.1020032-4-cleech@redhat.com>
 <2023093055-gotten-astronomy-a98b@gregkh>
 <ZRhmqBRNUB3AfLv/@rhel-developer-toolbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRhmqBRNUB3AfLv/@rhel-developer-toolbox>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 11:19:20AM -0700, Chris Leech wrote:
> On Sat, Sep 30, 2023 at 09:06:51AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Sep 29, 2023 at 10:00:23AM -0700, Chris Leech wrote:
> > > Make use of the new UIO_MEM_DMA_COHERENT type to properly handle mmap
> > > for dma_alloc_coherent buffers.
> > 
> > Why are ethernet drivers messing around with UIO devices?  That's not
> > what UIO is for, unless you are trying to do kernel bypass for these
> > devices without anyone noticing?
> > 
> > confused,
> 
> It's confusing. The bnx2 driver stack included a cnic (converged nic?)
> module that sits between the ethernet drivers (bnx2, bnx2x) and protocol
> offload drivers (iscsi, fcoe, rdma).
> 
> The iscsi module (bnx2i) uses a passthrough interface from cnic to
> handle some network configuration that the device firmware doesn't do.
> It uses a uio device and a userspace component called iscsiuio to do
> that.

That's horrible, and not what the UIO api is for at all.  Configure the
device like any other normal kernel device, don't poke at raw memory
values directly, that way lies madness.

Have a pointer to the userspace tool anywhere?  All I found looks like a
full IP stack in userspace under that name, and surely that's not what
this api is for...

thanks,

greg k-h
