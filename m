Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808F979E599
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbjIMLAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbjIMLAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 517611BC7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694602795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KB7mfwMZ7mYpt2Xc/Lhnjng9uCFOHUfEHeblSFIjfOA=;
        b=dpt+HXrv5i4Hk0pRIZhkkoHW9f9Az2tZXsmrJ2Jax338DAA3d1oF8cD3+SbF7akHPpHfPJ
        YPTOAvJ3FTlnnU7i1RrYaVkzC+R5nEkYXCIfF9AVD6NdDBCTpVgHCLuYaIo3rHFfYpy07+
        7TWxe7TU8xbLZJDVeDXXLkhXJu+CKRY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-oPatIiEkODymXrupV_m8vg-1; Wed, 13 Sep 2023 06:59:48 -0400
X-MC-Unique: oPatIiEkODymXrupV_m8vg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75D84101A550;
        Wed, 13 Sep 2023 10:59:47 +0000 (UTC)
Received: from localhost (unknown [10.72.112.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 85A3740AE2C0;
        Wed, 13 Sep 2023 10:59:46 +0000 (UTC)
Date:   Wed, 13 Sep 2023 18:59:42 +0800
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
Message-ID: <ZQGWHmESO/GpScHo@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-8-urezki@gmail.com>
 <ZP6QVTQmDGx7tx1a@MiWiFi-R3L-srv>
 <ZP9ZdRc4FDSH2ej4@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP9ZdRc4FDSH2ej4@pc636>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/23 at 08:16pm, Uladzislau Rezki wrote:
> On Mon, Sep 11, 2023 at 11:58:13AM +0800, Baoquan He wrote:
> > On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > > Extend the vread_iter() to be able to perform a sequential
> > > reading of VAs which are spread among multiple nodes. So a
> > > data read over the /dev/kmem correctly reflects a vmalloc
> > > memory layout.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  mm/vmalloc.c | 67 +++++++++++++++++++++++++++++++++++++++++-----------
> > >  1 file changed, 53 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 4fd4915c532d..968144c16237 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > ......  
> > > @@ -4057,19 +4093,15 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
> > >  
> > >  	remains = count;
> > >  
> > > -	/* Hooked to node_0 so far. */
> > > -	vn = addr_to_node(0);
> > > -	spin_lock(&vn->busy.lock);
> > 
> > This could change the vread behaviour a little bit. Before, once we take
> > vmap_area_lock, the vread will read out the content of snapshot at the
> > moment. Now, reading out in one node's tree won't disrupt other nodes'
> > tree accessing. Not sure if this matters when people need access
> > /proc/kcore, e.g dynamic debugging.
> >
> With one big tree you anyway drop the lock after one cycle of reading.
> As far as i see, kcore.c's read granularity is a PAGE_SIZE.

You are right, kcore.c's reading granularity is truly PAGE_SIZE.
I don't know procfs well, still need to study the code. Then it doesn't
matter much with the multiple nodes in vread_iter(). Sorry for the noise.

static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
{  
	......
        start = kc_offset_to_vaddr(*fpos - data_offset);
        if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
                tsz = buflen;

	m = NULL;
        while (buflen) {
	}
	...
}

