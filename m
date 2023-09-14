Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4286F79F8F5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 05:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbjINDhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 23:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjINDhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 23:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8103F3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 20:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694662575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jq7lah8VbTZSuBiDNjbRBD2evIv7Pav30k3MjGNNfxo=;
        b=IqomfqHFk4o1vXHmGRiOZkLoZm0/HVSdP9qETg0rMHAUPC6k9SmuPxt/Rds7zg2rXZz9Ct
        RewoADIaFTK5Jl6A6scwD4Vfx8LrrsBh3jAnfYgxPi/RMWij/NkqdiFDa8CnifmyUfzazZ
        CLEIVVhUQd5FtQtLbmfJDowIhCyqrGo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-gFuXdfXzM7SNncdCnx6mpA-1; Wed, 13 Sep 2023 23:36:12 -0400
X-MC-Unique: gFuXdfXzM7SNncdCnx6mpA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B68E4816524;
        Thu, 14 Sep 2023 03:36:11 +0000 (UTC)
Received: from localhost (unknown [10.72.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F32B040C6ECA;
        Thu, 14 Sep 2023 03:36:10 +0000 (UTC)
Date:   Thu, 14 Sep 2023 11:36:06 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 7/9] mm: vmalloc: Support multiple nodes in vread_iter
Message-ID: <ZQJ/pv+iJBijwmTc@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-8-urezki@gmail.com>
 <ZP6QVTQmDGx7tx1a@MiWiFi-R3L-srv>
 <ZP9ZdRc4FDSH2ej4@pc636>
 <ZQBqyDxVuCphprk2@MiWiFi-R3L-srv>
 <ZQHYfO0GTco4qPEF@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQHYfO0GTco4qPEF@pc636>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/23 at 05:42pm, Uladzislau Rezki wrote:
> On Tue, Sep 12, 2023 at 09:42:32PM +0800, Baoquan He wrote:
> > On 09/11/23 at 08:16pm, Uladzislau Rezki wrote:
> > > On Mon, Sep 11, 2023 at 11:58:13AM +0800, Baoquan He wrote:
> > > > On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > > > > Extend the vread_iter() to be able to perform a sequential
> > > > > reading of VAs which are spread among multiple nodes. So a
> > > > > data read over the /dev/kmem correctly reflects a vmalloc
> > > > > memory layout.
> > > > > 
> > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > ---
> > > > >  mm/vmalloc.c | 67 +++++++++++++++++++++++++++++++++++++++++-----------
> > > > >  1 file changed, 53 insertions(+), 14 deletions(-)
> > > > > 
> > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > index 4fd4915c532d..968144c16237 100644
> > > > > --- a/mm/vmalloc.c
> > > > > +++ b/mm/vmalloc.c
> > > > ......  
> > > > > @@ -4057,19 +4093,15 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
> > > > >  
> > > > >  	remains = count;
> > > > >  
> > > > > -	/* Hooked to node_0 so far. */
> > > > > -	vn = addr_to_node(0);
> > > > > -	spin_lock(&vn->busy.lock);
> > > > 
> > > > This could change the vread behaviour a little bit. Before, once we take
> > > > vmap_area_lock, the vread will read out the content of snapshot at the
> > > > moment. Now, reading out in one node's tree won't disrupt other nodes'
> > > > tree accessing. Not sure if this matters when people need access
> > > > /proc/kcore, e.g dynamic debugging.
> > > >
> > > With one big tree you anyway drop the lock after one cycle of reading.
> > > As far as i see, kcore.c's read granularity is a PAGE_SIZE.
> > 
> > With my understanding, kcore reading on vmalloc does read page by page,
> > it will continue after one page reading if the required size is bigger
> > than one page. Please see aligned_vread_iter() code. During the complete
> > process, vmap_area_lock is held before this patch.
> > 
> > > 
> > > > 
> > > > And, the reading will be a little slower because each va finding need
> > > > iterate all vmap_nodes[].
> > > > 
> > > Right. It is a bit tough here, because we have multiple nodes which
> > > represent zones(address space), i.e. there is an offset between them,
> > > it means that, reading fully one tree, will not provide a sequential
> > > reading.
> > 
> > Understood. Suppose the kcore reading on vmalloc is not critical. If I
> > get chance to test on a machine with 256 cpu, I will report here.
> > 
> It would be great! Unfortunately i do not have an access to such big
> systems. What i have is 64 CPUs max system. If you, by chance can test
> on bigger systems or can provide a temporary ssh access that would be
> awesome.

10.16.216.205
user:root
password:redhat

This is a testing server in our lab, we apply for usage each time and it
will reinstall OS, root user should be OK. I will take it for two days.

If accessing is not available, I can do some testing if you want me to
run some commands.

