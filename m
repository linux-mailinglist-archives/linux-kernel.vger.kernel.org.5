Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F2F797931
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbjIGRFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjIGRFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:05:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B07D1FDE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694106189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=euSESbGnOpxGG/an0+tjKSmmMkLR8E9KsUE2opfoBz4=;
        b=S79TmgoQHgOMi0FiD2TyXEHLUmHnpiHM/tANZCMGBOTXz/oBSp4V2GI5ytzoNhZH3gDEV8
        rvHiESDaf1vDz0Ckbqh4YzWurFZOGAQozKVXmOU7SZxHPiEpSuNI4DmBhz4wbC00Yqtxqc
        Zp/0itcMQNRuC1gsJ/fUSL1BxctcTUQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-b4LufIMuOiuXJ0blwuhkkQ-1; Thu, 07 Sep 2023 05:38:12 -0400
X-MC-Unique: b4LufIMuOiuXJ0blwuhkkQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F9AF8001EA;
        Thu,  7 Sep 2023 09:38:11 +0000 (UTC)
Received: from localhost (unknown [10.72.112.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EDFBC03293;
        Thu,  7 Sep 2023 09:38:10 +0000 (UTC)
Date:   Thu, 7 Sep 2023 17:38:07 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, k-hagio-ab@nec.com,
        lijiang@redhat.com
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <ZPmZ/8CLpKHEZvQY@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-5-urezki@gmail.com>
 <ZPkyw0nAQSQWj5H1@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPkyw0nAQSQWj5H1@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/23 at 10:17am, Baoquan He wrote:
> Add Kazu and Lianbo to CC, and kexec mailing list
> 
> On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > Store allocated objects in a separate nodes. A va->va_start
> > address is converted into a correct node where it should
> > be placed and resided. An addr_to_node() function is used
> > to do a proper address conversion to determine a node that
> > contains a VA.
> > 
> > Such approach balances VAs across nodes as a result an access
> > becomes scalable. Number of nodes in a system depends on number
> > of CPUs divided by two. The density factor in this case is 1/2.
> > 
> > Please note:
> > 
> > 1. As of now allocated VAs are bound to a node-0. It means the
> >    patch does not give any difference comparing with a current
> >    behavior;
> > 
> > 2. The global vmap_area_lock, vmap_area_root are removed as there
> >    is no need in it anymore. The vmap_area_list is still kept and
> >    is _empty_. It is exported for a kexec only;
> 
> I haven't taken a test, while accessing all nodes' busy tree to get
> va of the lowest address could severely impact kcore reading efficiency
> on system with many vmap nodes. People doing live debugging via
> /proc/kcore will get a little surprise.
> 
> Empty vmap_area_list will break makedumpfile utility, Crash utility
> could be impactd too. I checked makedumpfile code, it relys on
> vmap_area_list to deduce the vmalloc_start value. 

Except of the empty vmap_area_list, this patch looks good to me.

We may need think of another way to export the vmalloc_start value or
deduce it in makedumpfile/Crash utility. And then remove the useless
vmap_area_list. I am not sure if we should remove vmap_area_list in this
patch because the empty value will cause breakage anyway. Otherwise,

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> > 
> > 3. The vmallocinfo and vread() have to be reworked to be able to
> >    handle multiple nodes.
> 

