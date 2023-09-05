Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E745792AB5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344237AbjIEQlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350512AbjIEFEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:04:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3382CCB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 22:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693890191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QF++iXxEZpFrQCnUt3ZrjX7wcQsJCw0Lcgs8IhL6Xus=;
        b=AxzYfISoEu17fCftaFqDG0vjpLHEVF7YF02GnFWWAKF+3b8stvDNlKV1azCdSqUdXMHhJz
        tiA0yoH3rd9eR8XB+Mn5yDExnBzyzrWTm6+dtSX9j0TQGkvs+3hOa1VO3dVDED5EVQLTY/
        4JP4fHSZLXHBXRk+YbNfMxsphUOWMYs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-4rUGPEBPMYipOttOl5wP7g-1; Tue, 05 Sep 2023 01:03:06 -0400
X-MC-Unique: 4rUGPEBPMYipOttOl5wP7g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B587B1817904;
        Tue,  5 Sep 2023 05:03:05 +0000 (UTC)
Received: from localhost (unknown [10.72.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B496340C6CCC;
        Tue,  5 Sep 2023 05:03:04 +0000 (UTC)
Date:   Tue, 5 Sep 2023 13:03:01 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Hari Bathini <hbathini@linux.ibm.com>, mpe@ellerman.id.au
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Pingfan Liu <piliu@redhat.com>, Dave Young <dyoung@redhat.com>,
        npiggin@gmail.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Wen Xiong <wenxiong@linux.ibm.com>, kexec@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Christoph Hellwig <hch@lst.de>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Subject: Re: [PATCH V3 01/14] blk-mq: add blk_mq_max_nr_hw_queues()
Message-ID: <ZPa2hbRQUdFRNqr9@MiWiFi-R3L-srv>
References: <20230808104239.146085-1-ming.lei@redhat.com>
 <20230808104239.146085-2-ming.lei@redhat.com>
 <20230809134401.GA31852@lst.de>
 <ZNQqt1C0pXspGl3d@fedora>
 <ZNQ64xhCIBU6XM/5@MiWiFi-R3L-srv>
 <ZNRGNsRzEJfzUEzH@fedora>
 <ZNRTGrRuwf69EgnE@MiWiFi-R3L-srv>
 <772c4140-3035-16d8-0253-f5893c3698e2@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <772c4140-3035-16d8-0253-f5893c3698e2@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_NONE,
        T_SPF_HELO_TEMPERROR autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hari, Michael

On 08/11/23 at 01:23pm, Hari Bathini wrote:
> 
> 
> On 10/08/23 8:31 am, Baoquan He wrote:
> > On 08/10/23 at 10:06am, Ming Lei wrote:
> > > On Thu, Aug 10, 2023 at 09:18:27AM +0800, Baoquan He wrote:
> > > > On 08/10/23 at 08:09am, Ming Lei wrote:
> > > > > On Wed, Aug 09, 2023 at 03:44:01PM +0200, Christoph Hellwig wrote:
> > > > > > I'm starting to sound like a broken record, but we can't just do random
> > > > > > is_kdump checks, and it's not going to get better by resending it again and
> > > > > > again.  If kdump kernels limit the number of possible CPUs, it needs to
> > > > > > reflected in cpu_possible_map and we need to use that information.
> > > > > > 
> > > > > 
> > > > > Can you look at previous kdump/arch guys' comment about kdump usage &
> > > > > num_possible_cpus?
> > > > > 
> > > > >      https://lore.kernel.org/linux-block/CAF+s44RuqswbosY9kMDx35crviQnxOeuvgNsuE75Bb0Y2Jg2uw@mail.gmail.com/
> > > > >      https://lore.kernel.org/linux-block/ZKz912KyFQ7q9qwL@MiWiFi-R3L-srv/
> > > > > 
> > > > > The point is that kdump kernels does not limit the number of possible CPUs.
> > > > > 
> > > > > 1) some archs support 'nr_cpus=1' for kdump kernel, which is fine, since
> > > > > num_possible_cpus becomes 1.
> > > > 
> > > > Yes, "nr_cpus=" is strongly suggested in kdump kernel because "nr_cpus="
> > > > limits the possible cpu numbers, while "maxcpuss=" only limits the cpu
> > > > number which can be brought up during bootup. We noticed this diference
> > > > because a large number of possible cpus will cost more memory in kdump
> > > > kernel. e.g percpu initialization, even though kdump kernel have set
> > > > "maxcpus=1".
> > > > 
> > > > Currently x86 and arm64 all support "nr_cpus=". Pingfan ever spent much
> > > > effort to make patches to add "nr_cpus=" support to ppc64, seems ppc64
> > > > dev and maintainers do not care about it. Finally the patches are not
> > > > accepted, and the work is not continued.
> > > > 
> > > > Now, I am wondering what is the barrier to add "nr_cpus=" to power ach.
> > > > Can we reconsider adding 'nr_cpus=' to power arch since real issue
> > > > occurred in kdump kernel?
> > > 
> > > If 'nr_cpus=' can be supported on ppc64, this patchset isn't needed.
> > > 
> > > > 
> > > > As for this patchset, it can be accpeted so that no failure in kdump
> > > > kernel is seen on ARCHes w/o "nr_cpus=" support? My personal opinion.
> > > 
> > > IMO 'nr_cpus=' support should be preferred, given it is annoying to
> > > maintain two kinds of implementation for kdump kernel from driver
> > > viewpoint. I guess kdump things can be simplified too with supporting
> > > 'nr_cpus=' only.
> > 
> > Yes, 'nr_cpus=' is ideal. Not sure if there's some underlying concerns so
> > that power people decided to not support it.
> 
> Though "nr_cpus=1" is an ideal solution, maintainer was not happy with
> the patch as the code changes have impact for regular boot path and
> it is likely to cause breakages. So, even if "nr_cpus=1" support for
> ppc64 is revived, the change is going to take time to be accepted
> upstream.

I talked to pingfan recently, he said he posted patches to add 'nr_cpus='
support in powerpc in order to reduce memory amount for kdump kernel.
His patches were rejected by maintainer because maintainer thought the
reason is not sufficient. So up to now, in architectures fedora/RHEL
supports to provide default crashkernel reservation value, powerpc costs
most. Now with this emerging issue, can we reconsider supporting
'nr_cpus=' in powerpc?

> 
> Also, I see is_kdump_kernel() being used irrespective of "nr_cpus=1"
> support for other optimizations in the driver for the special dump
> capture environment kdump is.
> 
> If there is no other downside for driver code, to use is_kdump_kernel(),
> other than the maintainability aspect, I think the above changes are
> worth considering.

Hi Hari,

By the way, will you use the ppc specific is_kdump_kernel() and
is_crashdump_kernel() in your patches to fix this issue?

Thanks
Baoquan

