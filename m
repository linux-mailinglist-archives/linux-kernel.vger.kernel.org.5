Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD6B796DD7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 02:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbjIGAHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 20:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjIGAHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 20:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516171990
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 17:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694045175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BgN4XRZyMzqcGmPmG5KWJX1UvABl/ETPX1t8ADqiNNc=;
        b=iUFfTw5b80SX9Xk7x5+nxBtnKs9xAKP41H+krDBoT7at8yisTi/VGVX4MSZlEe3uPbyLXJ
        bgDALCU/mbI9e+jOpHeNVTbBgkBKYVNUXvSZSLvmlnrgo7ncLsVOOlm7BMmofY387bn3gw
        0qYZwilX3U3jzo9ypl5AWmolkufFuDg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-w_-2c7LON2eYF4e7Gf6ofg-1; Wed, 06 Sep 2023 20:06:14 -0400
X-MC-Unique: w_-2c7LON2eYF4e7Gf6ofg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F0263810D4B;
        Thu,  7 Sep 2023 00:06:13 +0000 (UTC)
Received: from localhost (unknown [10.72.112.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2F7A40C2070;
        Thu,  7 Sep 2023 00:06:12 +0000 (UTC)
Date:   Thu, 7 Sep 2023 08:06:09 +0800
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
Subject: Re: [PATCH v2 6/9] mm: vmalloc: Offload free_vmap_area_lock lock
Message-ID: <ZPkT8RJJgY0HGwmC@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-7-urezki@gmail.com>
 <ZPgWXgL1nLASjx8O@MiWiFi-R3L-srv>
 <ZPjQCSkKesWmWdB8@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPjQCSkKesWmWdB8@pc636>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/23 at 09:16pm, Uladzislau Rezki wrote:
> > >  static void free_vmap_area(struct vmap_area *va)
> > >  {
> > >  	struct vmap_node *vn = addr_to_node(va->va_start);
> > > +	int vn_id = decode_vn_id(va->flags);
> > >  
> > >  	/*
> > >  	 * Remove from the busy tree/list.
> > > @@ -1594,12 +1629,19 @@ static void free_vmap_area(struct vmap_area *va)
> > >  	unlink_va(va, &vn->busy.root);
> > >  	spin_unlock(&vn->busy.lock);
> > >  
> > > -	/*
> > > -	 * Insert/Merge it back to the free tree/list.
> > > -	 */
> > > -	spin_lock(&free_vmap_area_lock);
> > > -	merge_or_add_vmap_area_augment(va, &free_vmap_area_root, &free_vmap_area_list);
> > > -	spin_unlock(&free_vmap_area_lock);
> > > +	if (vn_id >= 0) {
> > 
> > In alloc_vmap_area(), the vn_id is encoded into va->flags. When
> > allocation failed, the vn_id = 0. Here should we change to check 'if
> > (vn_id > 0)' becasue the vn_id == 0 means no available vn_id encoded
> > into. And I do not get how we treat the case vn_id truly is 0.
> > 
> > 	va->flags = (addr != vend) ? encode_vn_id(vn_id) : 0;
> >
> Yes, vn_id always >= 0, so it is positive since it is an index.
> We encode a vn_id as vn_id + 1. For example if it is zero we write 1.
> 
> If not node allocation path or an error zero is written. Decoding
> is done as: zero - 1 = -1, so it is negative value, i.e. decode_vn_id()
> function returns -1.

Ah, I see it now, thanks. It would be helpful to add some explanation
above decode_vn_id() lest people misunderstand this like me?

