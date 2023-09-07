Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119E4797BAA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjIGS0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjIGS0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:26:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B63B2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694111130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+YZnY8Y16y63bpnKa1LB+Dq6TqgHlqb2M3cQd5Vbeeg=;
        b=WV7pgd2Ryy/yDzoRuwQ6FJDnJu4Lm7nhPpdyndLVUGcaMBuh2PephE4r+KBFPotQ7PyPNc
        IZVOdkqovHPTj08UMGdl6B8n1DNOGnAv7SfiLLg+mhvMtsd7V2A0EPDdrN06n8ntRUBvCz
        6868LuPUmy8cZkW+VSlZ6AwZB5YK+h0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-bRJDmM7BNXioUhRM5aC-Og-1; Thu, 07 Sep 2023 05:58:16 -0400
X-MC-Unique: bRJDmM7BNXioUhRM5aC-Og-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79102801FA9;
        Thu,  7 Sep 2023 09:58:15 +0000 (UTC)
Received: from localhost (unknown [10.72.112.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 399E2493112;
        Thu,  7 Sep 2023 09:58:13 +0000 (UTC)
Date:   Thu, 7 Sep 2023 17:58:09 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Uladzislau Rezki <urezki@gmail.com>, k-hagio-ab@nec.com
Cc:     lijiang@redhat.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        kexec@lists.infradead.org
Subject: Re: [PATCH v2 4/9] mm: vmalloc: Remove global vmap_area_root rb-tree
Message-ID: <ZPmesS66PTl+1Mdz@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-5-urezki@gmail.com>
 <ZPkyw0nAQSQWj5H1@MiWiFi-R3L-srv>
 <ZPmaYgsT5EdLVUyO@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPmaYgsT5EdLVUyO@pc636>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/23 at 11:39am, Uladzislau Rezki wrote:
> On Thu, Sep 07, 2023 at 10:17:39AM +0800, Baoquan He wrote:
> > Add Kazu and Lianbo to CC, and kexec mailing list
> > 
> > On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > > Store allocated objects in a separate nodes. A va->va_start
> > > address is converted into a correct node where it should
> > > be placed and resided. An addr_to_node() function is used
> > > to do a proper address conversion to determine a node that
> > > contains a VA.
> > > 
> > > Such approach balances VAs across nodes as a result an access
> > > becomes scalable. Number of nodes in a system depends on number
> > > of CPUs divided by two. The density factor in this case is 1/2.
> > > 
> > > Please note:
> > > 
> > > 1. As of now allocated VAs are bound to a node-0. It means the
> > >    patch does not give any difference comparing with a current
> > >    behavior;
> > > 
> > > 2. The global vmap_area_lock, vmap_area_root are removed as there
> > >    is no need in it anymore. The vmap_area_list is still kept and
> > >    is _empty_. It is exported for a kexec only;
> > 
> > I haven't taken a test, while accessing all nodes' busy tree to get
> > va of the lowest address could severely impact kcore reading efficiency
> > on system with many vmap nodes. People doing live debugging via
> > /proc/kcore will get a little surprise.
> > 
> >
> > Empty vmap_area_list will break makedumpfile utility, Crash utility
> > could be impactd too. I checked makedumpfile code, it relys on
> > vmap_area_list to deduce the vmalloc_start value. 
> >
> It is left part and i hope i fix it in v3. The problem here is
> we can not give an opportunity to access to vmap internals from
> outside. This is just not correct, i.e. you are not allowed to
> access the list directly.

Right. Thanks for the fix in v3, that is a relief of makedumpfile and
crash.

Hi Kazu,

Meanwhile, I am thinking if we should evaluate the necessity of
vmap_area_list in makedumpfile and Crash. In makedumpfile, we just use
vmap_area_list to deduce VMALLOC_START. Wondering if we can export
VMALLOC_START directly. Surely, the lowest va->va_start in vmap_area_list
is a tighter low boundary of vmalloc area and can reduce unnecessary
scanning below the lowest va. Not sure if this is the reason people
decided to export vmap_area_list.

Thanks
Baoquan

