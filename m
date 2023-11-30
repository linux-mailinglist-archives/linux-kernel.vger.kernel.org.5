Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F2F7FE77D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 04:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344242AbjK3DAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 22:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjK3DAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 22:00:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459B6CC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 19:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701313254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=56TLCuGuVUMKcmkPcmxQQn0pJ2YaQbx0mYwRAg7HyF4=;
        b=Qge/IJDi8Ev1UXutseeQRz+OAQCfhLTAliOL9Bf62Hq/Ac2AYC45bmN+PB7ySzKFl+YoAm
        9NxiE2TcQkgDrg7CP0idYmx/vcLGrADEx1bCLKhIdFJ5259AUFrFE3tEOwMAyXjzpB4l9a
        HZ5RIxadebtxGIGI207Eseln0UevV0Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-dCU83USwO7GZUiTgGa1_Bg-1; Wed, 29 Nov 2023 22:00:52 -0500
X-MC-Unique: dCU83USwO7GZUiTgGa1_Bg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB6828110A7;
        Thu, 30 Nov 2023 03:00:51 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 419A71C060B1;
        Thu, 30 Nov 2023 03:00:50 +0000 (UTC)
Date:   Thu, 30 Nov 2023 11:00:48 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Donald Dutile <ddutile@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, Jiri Bohac <jbohac@suse.cz>,
        Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
 <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
 <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/23 at 10:03am, Donald Dutile wrote:
> Baoquan,
> hi!
> 
> On 11/29/23 3:10 AM, Baoquan He wrote:
> > On 11/28/23 at 10:08am, Michal Hocko wrote:
> > > On Tue 28-11-23 10:11:31, Baoquan He wrote:
> > > > On 11/28/23 at 09:12am, Tao Liu wrote:
> > > [...]
> > > > Thanks for the effort to bring this up, Jiri.
> > > > 
> > > > I am wondering how you will use this crashkernel=,cma parameter. I mean
> > > > the scenario of crashkernel=,cma. Asking this because I don't know how
> > > > SUSE deploy kdump in SUSE distros. In SUSE distros, kdump kernel's
> > > > driver will be filter out? If latter case, It's possibly having the
> > > > on-flight DMA issue, e.g NIC has DMA buffer in the CMA area, but not
> > > > reset during kdump bootup because the NIC driver is not loaded in to
> > > > initialize. Not sure if this is 100%, possible in theory?
> > > 
> > > NIC drivers do not allocation from movable zones (that includes CMA
> > > zone). In fact kernel doesn't use GFP_MOVABLE for non-user requests.
> > > RDMA drivers might and do transfer from user backed memory but for that
> > > purpose they should be pinning memory (have a look at
> > > __gup_longterm_locked and its callers) and that will migrate away from
> > > the any zone.
> > 
> > Add Don in this thread.
> > 
> > I am not familiar with RDMA. If we reserve a range of 1G meory as cma in
> > 1st kernel, and RDMA or any other user space tools could use it. When
> > corruption happened with any cause, that 1G cma memory will be reused as
> > available MOVABLE memory of kdump kernel. If no risk at all, I mean 100%
> > safe from RDMA, that would be great.
> > 
> My RDMA days are long behind me... more in mm space these days, so this still
> interests me.
> I thought, in general, userspace memory is not saved or used in kdumps, so
> if RDMA is using cma space for userspace-based IO (gup), then I would expect
> it can be re-used for kexec'd kernel.
> So, I'm not sure what 'safe from RDMA' means, but I would expect RDMA queues
> are in-kernel data structures, not userspace strucutures, and they would be
> more/most important to maintain/keep for kdump saving.  The actual userspace
> data ... ssdd wrt any other userspace data.
> dma-buf's allocated from cma, which are (typically) shared with GPUs
> (& RDMA in GPU-direct configs), again, would be shared userspace, not
> control/cmd/rsp queues, so I'm not seeing an issue there either.

Thanks a lot for valuable input, Don.

Here, Jiri's patches attempt to reserve the cma area which is used in
1st kernel as CMA area, e.g being added into buddy allocator as MOVABLE,
and will be taken as available system memory of kdump kernel. Means in
kdump kernel, that specific CMA area will be zerod out and its content
won't be cared about and dumped out at all in kdump kernel. Kdump kernel
will see it as an available system RAM and initialize it and add it into
memblock allocator and buddy allocator.

Now, we are worried if there's risk if the CMA area is retaken into kdump
kernel as system RAM. E.g is it possible that 1st kernel's ongoing RDMA
or DMA will interfere with kdump kernel's normal memory accessing?
Because kdump kernel usually only reset and initialize the needed
device, e.g dump target. Those unneeded devices will be unshutdown and
let go. 

We could overthink, so would like to make clear.

> 
> I would poke the NVIDIA+Mellanox folks for further review in this space,
> if my reply leaves you (or others) 'wanting'.
> 
> - Don
> > > [...]
> > > > The crashkernel=,cma requires no userspace data dumping, from our
> > > > support engineers' feedback, customer never express they don't need to
> > > > dump user space data. Assume a server with huge databse deployed, and
> > > > the database often collapsed recently and database provider claimed that
> > > > it's not database's fault, OS need prove their innocence. What will you
> > > > do?
> > > 
> > > Don't use CMA backed crash memory then? This is an optional feature.
> > > > So this looks like a nice to have to me. At least in fedora/rhel's
> > > > usage, we may only back port this patch, and add one sentence in our
> > > > user guide saying "there's a crashkernel=,cma added, can be used with
> > > > crashkernel= to save memory. Please feel free to try if you like".
> > > > Unless SUSE or other distros decides to use it as default config or
> > > > something like that. Please correct me if I missed anything or took
> > > > anything wrong.
> > > 
> > > Jiri will know better than me but for us a proper crash memory
> > > configuration has become a real nut. You do not want to reserve too much
> > > because it is effectively cutting of the usable memory and we regularly
> > > hit into "not enough memory" if we tried to be savvy. The more tight you
> > > try to configure the easier to fail that is. Even worse any in kernel
> > > memory consumer can increase its memory demand and get the overall
> > > consumption off the cliff. So this is not an easy to maintain solution.
> > > CMA backed crash memory can be much more generous while still usable.
> > > -- 
> > > Michal Hocko
> > > SUSE Labs
> > > 
> > 
> 

