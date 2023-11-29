Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9046E7FD10F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjK2Iit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjK2ILA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:11:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C071735
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701245464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BC4uggJfBcsQ9J288hcUReQwagRBB7yxUyX9PfI8YC4=;
        b=Q6OhDV4JCMvODO9U6UeYpY7t+ReGX6ehjLtordP9WvO8bWIm292x2PFH91NlfPLUap7Xy/
        SYYDi8Qsra8XKHYUbH2akm631jI47rV9L7QqrCXgXd4eP8Sf2oKtKbnkxPa+omYFtaLVHJ
        POINE4e5+bpXsksexe7T62bACZMIfMg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-Di-Svtm0OSiYAyIeYfDUdQ-1; Wed, 29 Nov 2023 03:11:00 -0500
X-MC-Unique: Di-Svtm0OSiYAyIeYfDUdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 103B18058EE;
        Wed, 29 Nov 2023 08:11:00 +0000 (UTC)
Received: from localhost (unknown [10.72.112.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5857D1C060AE;
        Wed, 29 Nov 2023 08:10:59 +0000 (UTC)
Date:   Wed, 29 Nov 2023 16:10:55 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@suse.com>, ddutile@redhat.com
Cc:     Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
        Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
 <ZWWuBSiZZdF2W12j@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWWuBSiZZdF2W12j@tiehlicka>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 at 10:08am, Michal Hocko wrote:
> On Tue 28-11-23 10:11:31, Baoquan He wrote:
> > On 11/28/23 at 09:12am, Tao Liu wrote:
> [...]
> > Thanks for the effort to bring this up, Jiri.
> > 
> > I am wondering how you will use this crashkernel=,cma parameter. I mean
> > the scenario of crashkernel=,cma. Asking this because I don't know how
> > SUSE deploy kdump in SUSE distros. In SUSE distros, kdump kernel's
> > driver will be filter out? If latter case, It's possibly having the
> > on-flight DMA issue, e.g NIC has DMA buffer in the CMA area, but not
> > reset during kdump bootup because the NIC driver is not loaded in to
> > initialize. Not sure if this is 100%, possible in theory?
> 
> NIC drivers do not allocation from movable zones (that includes CMA
> zone). In fact kernel doesn't use GFP_MOVABLE for non-user requests.
> RDMA drivers might and do transfer from user backed memory but for that
> purpose they should be pinning memory (have a look at
> __gup_longterm_locked and its callers) and that will migrate away from
> the any zone.

Add Don in this thread.

I am not familiar with RDMA. If we reserve a range of 1G meory as cma in
1st kernel, and RDMA or any other user space tools could use it. When
corruption happened with any cause, that 1G cma memory will be reused as
available MOVABLE memory of kdump kernel. If no risk at all, I mean 100%
safe from RDMA, that would be great.

>  
> [...]
> > The crashkernel=,cma requires no userspace data dumping, from our
> > support engineers' feedback, customer never express they don't need to
> > dump user space data. Assume a server with huge databse deployed, and
> > the database often collapsed recently and database provider claimed that
> > it's not database's fault, OS need prove their innocence. What will you
> > do?
> 
> Don't use CMA backed crash memory then? This is an optional feature.
>  
> > So this looks like a nice to have to me. At least in fedora/rhel's
> > usage, we may only back port this patch, and add one sentence in our
> > user guide saying "there's a crashkernel=,cma added, can be used with
> > crashkernel= to save memory. Please feel free to try if you like".
> > Unless SUSE or other distros decides to use it as default config or
> > something like that. Please correct me if I missed anything or took
> > anything wrong.
> 
> Jiri will know better than me but for us a proper crash memory
> configuration has become a real nut. You do not want to reserve too much
> because it is effectively cutting of the usable memory and we regularly
> hit into "not enough memory" if we tried to be savvy. The more tight you
> try to configure the easier to fail that is. Even worse any in kernel
> memory consumer can increase its memory demand and get the overall
> consumption off the cliff. So this is not an easy to maintain solution.
> CMA backed crash memory can be much more generous while still usable.
> -- 
> Michal Hocko
> SUSE Labs
> 

