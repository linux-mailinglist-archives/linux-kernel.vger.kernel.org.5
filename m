Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6457C7FEE86
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345250AbjK3MFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345221AbjK3MFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:05:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B85D40
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701345909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B80Gpj6tociNz1RbRJ/cNcWm35Kf/1SWUfnQzVTmpWk=;
        b=D4wDA5xconauaWIsEXHp/sTdQHtUW3SRxnE9RINeJFaiV4VzkeJOpVzSzLWEQo+cm3psTf
        51TO/vsGa4B1X5UMvZP+liasBuKRR3c805hofisMoSGovAHxzfshVCx2aCPYCh7uTlWFdD
        lNPpxw+snib/VIfkQqADfQNc/xhsW6Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-BqfA4TXcMKOdz47HbkXqIQ-1; Thu, 30 Nov 2023 07:05:03 -0500
X-MC-Unique: BqfA4TXcMKOdz47HbkXqIQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48461811E86;
        Thu, 30 Nov 2023 12:05:03 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D1A42026D68;
        Thu, 30 Nov 2023 12:05:02 +0000 (UTC)
Date:   Thu, 30 Nov 2023 20:04:59 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Donald Dutile <ddutile@redhat.com>, Jiri Bohac <jbohac@suse.cz>,
        Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
 <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
 <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
 <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
 <ZWhg_b3O6piZtkQ-@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWhg_b3O6piZtkQ-@tiehlicka>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

On 11/30/23 at 11:16am, Michal Hocko wrote:
> On Thu 30-11-23 11:00:48, Baoquan He wrote:
> [...]
> > Now, we are worried if there's risk if the CMA area is retaken into kdump
> > kernel as system RAM. E.g is it possible that 1st kernel's ongoing RDMA
> > or DMA will interfere with kdump kernel's normal memory accessing?
> > Because kdump kernel usually only reset and initialize the needed
> > device, e.g dump target. Those unneeded devices will be unshutdown and
> > let go. 
> 
> I do not really want to discount your concerns but I am bit confused why
> this matters so much. First of all, if there is a buggy RDMA driver
> which doesn't use the proper pinning API (which would migrate away from
> the CMA) then what is the worst case? We will get crash kernel corrupted
> potentially and fail to take a proper kernel crash, right? Is this
> worrisome? Yes. Is it a real roadblock? I do not think so. The problem
> seems theoretical to me and it is not CMA usage at fault here IMHO. It
> is the said theoretical driver that needs fixing anyway.
> 
> Now, it is really fair to mention that CMA backed crash kernel memory
> has some limitations
> 	- CMA reservation can only be used by the userspace in the
> 	  primary kernel. If the size is overshot this might have
> 	  negative impact on kernel allocations
> 	- userspace memory dumping in the crash kernel is fundamentally
> 	  incomplete.

I am not sure if we are talking about the same thing. My concern is:
====================================================================
1) system corrutption happened, crash dumping is prepared, cpu and
interrupt controllers are shutdown;
2) all pci devices are kept alive;
3) kdump kernel boot up, initialization is only done on those devices
which drivers are added into kdump kernel's initrd;
4) those on-flight DMA engine could be still working if their kernel
module is not loaded;

In this case, if the DMA's destination is located in crashkernel=,cma
region, the DMA writting could continue even when kdump kernel has put
important kernel data into the area. Is this possible or absolutely not
possible with DMA, RDMA, or any other stuff which could keep accessing
that area?

The existing crashkernel= syntax can gurantee the reserved crashkernel
area for kdump kernel is safe.
=======================================================================

The 1st kernel's data in the ,cma area is ignored once crashkernel=,cma
is taken.

