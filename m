Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1FB776DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 04:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjHJCH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 22:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHJCHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 22:07:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7362136
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 19:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691633223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CujbJvk8xR2wivezZL312pI5YeFGQCWJwDhrju025js=;
        b=FNu8aQbjfleXY52kOe3p62/xWSJ9qs4ILHg6ob3apVde1gJO6HeL2Ey/nkmSRCDjC+T5z3
        Jm8V+sOABUHioBHcTbZXE2/gGoAFleT/GF1ybYJko+bSzGSCz9ZjqDunrzY1VTmpSGeeeR
        VPvfbF47y7Ld8jdRyqB833JDgkKrlms=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-02XBssC6PbqWp0BJ03OIxQ-1; Wed, 09 Aug 2023 22:07:00 -0400
X-MC-Unique: 02XBssC6PbqWp0BJ03OIxQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 822FB185A78F;
        Thu, 10 Aug 2023 02:06:59 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16AB540C2076;
        Thu, 10 Aug 2023 02:06:50 +0000 (UTC)
Date:   Thu, 10 Aug 2023 10:06:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Wen Xiong <wenxiong@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Pingfan Liu <piliu@redhat.com>
Subject: Re: [PATCH V3 01/14] blk-mq: add blk_mq_max_nr_hw_queues()
Message-ID: <ZNRGNsRzEJfzUEzH@fedora>
References: <20230808104239.146085-1-ming.lei@redhat.com>
 <20230808104239.146085-2-ming.lei@redhat.com>
 <20230809134401.GA31852@lst.de>
 <ZNQqt1C0pXspGl3d@fedora>
 <ZNQ64xhCIBU6XM/5@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNQ64xhCIBU6XM/5@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 09:18:27AM +0800, Baoquan He wrote:
> On 08/10/23 at 08:09am, Ming Lei wrote:
> > On Wed, Aug 09, 2023 at 03:44:01PM +0200, Christoph Hellwig wrote:
> > > I'm starting to sound like a broken record, but we can't just do random
> > > is_kdump checks, and it's not going to get better by resending it again and
> > > again.  If kdump kernels limit the number of possible CPUs, it needs to
> > > reflected in cpu_possible_map and we need to use that information.
> > > 
> > 
> > Can you look at previous kdump/arch guys' comment about kdump usage &
> > num_possible_cpus?
> > 
> >     https://lore.kernel.org/linux-block/CAF+s44RuqswbosY9kMDx35crviQnxOeuvgNsuE75Bb0Y2Jg2uw@mail.gmail.com/
> >     https://lore.kernel.org/linux-block/ZKz912KyFQ7q9qwL@MiWiFi-R3L-srv/
> > 
> > The point is that kdump kernels does not limit the number of possible CPUs.
> > 
> > 1) some archs support 'nr_cpus=1' for kdump kernel, which is fine, since
> > num_possible_cpus becomes 1.
> 
> Yes, "nr_cpus=" is strongly suggested in kdump kernel because "nr_cpus="
> limits the possible cpu numbers, while "maxcpuss=" only limits the cpu
> number which can be brought up during bootup. We noticed this diference
> because a large number of possible cpus will cost more memory in kdump
> kernel. e.g percpu initialization, even though kdump kernel have set
> "maxcpus=1". 
> 
> Currently x86 and arm64 all support "nr_cpus=". Pingfan ever spent much
> effort to make patches to add "nr_cpus=" support to ppc64, seems ppc64
> dev and maintainers do not care about it. Finally the patches are not
> accepted, and the work is not continued.
> 
> Now, I am wondering what is the barrier to add "nr_cpus=" to power ach.
> Can we reconsider adding 'nr_cpus=' to power arch since real issue
> occurred in kdump kernel?

If 'nr_cpus=' can be supported on ppc64, this patchset isn't needed.

> 
> As for this patchset, it can be accpeted so that no failure in kdump
> kernel is seen on ARCHes w/o "nr_cpus=" support? My personal opinion.

IMO 'nr_cpus=' support should be preferred, given it is annoying to
maintain two kinds of implementation for kdump kernel from driver
viewpoint. I guess kdump things can be simplified too with supporting
'nr_cpus=' only.

thanks,
Ming

