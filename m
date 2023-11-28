Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D24B7FAFF0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 03:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjK1CLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbjK1CLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:11:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A2DD41
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 18:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701137496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybA3u2D2n3zV+vLhPpowqdJYuAB99119WeeWqv/jh3o=;
        b=arZRnoyQHpxNZBs63x1rQF/4oKxYzjCcyyibxNKmZ7L1dgDZmsnMdbhJunyckq53fjCp+Q
        XRhuN9GF2E34sNKv9/DdMjZuHtao+985WZ6EtTSAO2FHbYwQUhK1nAMTdI1ro4EawwWelv
        8/vtMb1GazUi4wWqCPAte8pdR4cBQxY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-MLSVnv92NhKsmWqo6Uvz6g-1; Mon, 27 Nov 2023 21:11:35 -0500
X-MC-Unique: MLSVnv92NhKsmWqo6Uvz6g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7AE38477A0;
        Tue, 28 Nov 2023 02:11:34 +0000 (UTC)
Received: from localhost (unknown [10.72.112.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EC541121308;
        Tue, 28 Nov 2023 02:11:33 +0000 (UTC)
Date:   Tue, 28 Nov 2023 10:11:31 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jiri Bohac <jbohac@suse.cz>
Cc:     Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, mhocko@suse.cz
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 at 09:12am, Tao Liu wrote:
> Hi Jiri,
> 
> On Sun, Nov 26, 2023 at 5:22 AM Jiri Bohac <jbohac@suse.cz> wrote:
> >
> > Hi Tao,
> >
> > On Sat, Nov 25, 2023 at 09:51:54AM +0800, Tao Liu wrote:
> > > Thanks for the idea of using CMA as part of memory for the 2nd kernel.
> > > However I have a question:
> > >
> > > What if there is on-going DMA/RDMA access on the CMA range when 1st
> > > kernel crash? There might be data corruption when 2nd kernel and
> > > DMA/RDMA write to the same place, how to address such an issue?
> >
> > The crash kernel CMA area(s) registered via
> > cma_declare_contiguous() are distinct from the
> > dma_contiguous_default_area or device-specific CMA areas that
> > dma_alloc_contiguous() would use to reserve memory for DMA.
> >
> > Kernel pages will not be allocated from the crash kernel CMA
> > area(s), because they are not GFP_MOVABLE. The CMA area will only
> > be used for user pages.
> >
> > User pages for RDMA, should be pinned with FOLL_LONGTERM and that
> > would migrate them away from the CMA area.
> >
> > But you're right that DMA to user pages pinned without
> > FOLL_LONGTERM would still be possible. Would this be a problem in
> > practice? Do you see any way around it?

Thanks for the effort to bring this up, Jiri.

I am wondering how you will use this crashkernel=,cma parameter. I mean
the scenario of crashkernel=,cma. Asking this because I don't know how
SUSE deploy kdump in SUSE distros. In SUSE distros, kdump kernel's
initramfs is the same as the 1st kernel, or only contain those needed
kernel modules for needed devices. E.g if we dump to local disk, NIC
driver will be filter out? If latter case, It's possibly having the
on-flight DMA issue, e.g NIC has DMA buffer in the CMA area, but not
reset during kdump bootup because the NIC driver is not loaded in to
initialize. Not sure if this is 100%, possible in theory?

Recently we are seeing an issue that on a HPE system, PCI error messages
are always seen in kdump kernel, while it's a local dump, NIC device is
not needed and the igb driver is not loaded in. Then adding igb driver
into kdump initramfs can work around it. It's similar with above
on-flight DMA.

The crashkernel=,cma requires no userspace data dumping, from our
support engineers' feedback, customer never express they don't need to
dump user space data. Assume a server with huge databse deployed, and
the database often collapsed recently and database provider claimed that
it's not database's fault, OS need prove their innocence. What will you
do?

So this looks like a nice to have to me. At least in fedora/rhel's
usage, we may only back port this patch, and add one sentence in our
user guide saying "there's a crashkernel=,cma added, can be used with
crashkernel= to save memory. Please feel free to try if you like".
Unless SUSE or other distros decides to use it as default config or
something like that. Please correct me if I missed anything or took
anything wrong.

Thanks
Baoquan

