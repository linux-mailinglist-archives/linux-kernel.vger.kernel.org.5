Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E807CEE10
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjJSC3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSC3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF3F115
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697682512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U3e/R8h8CUl6Qt8HzoNg568ab2TdGmvLJ3uBUWajvX8=;
        b=QwItNz3RakzvaWt1AwSLGsq6K37izQx3CHpNro2xoBj/LrlAzOrI9gcShmVrfOVydKc/ff
        CC0fQuOoroFxvLyI3MpsEyhRUsJeLM+vb9D4odKfj8A5ef+9XUSvYnR4pn0tCIPQ54nfWK
        desrPpuAXhhi0S/Y3f5cfc8dtzkZPLc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-Xqo4N_V8NMSwLG0l_9noLA-1; Wed, 18 Oct 2023 22:28:27 -0400
X-MC-Unique: Xqo4N_V8NMSwLG0l_9noLA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FC7D29AA383;
        Thu, 19 Oct 2023 02:28:26 +0000 (UTC)
Received: from localhost (unknown [10.72.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B79DB503B;
        Thu, 19 Oct 2023 02:28:25 +0000 (UTC)
Date:   Thu, 19 Oct 2023 10:28:21 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Philip Li <philip.li@intel.com>, oe-kbuild@lists.linux.dev,
        Lorenzo Stoakes <lstoakes@gmail.com>, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: mm/vmalloc.c:3689 vread_iter() error: we previously assumed 'vm'
 could be null (see line 3667)
Message-ID: <ZTCURc8ZQE+KrTvS@MiWiFi-R3L-srv>
References: <f82be227-bfde-439a-b339-1b4ee370d59a@kadam.mountain>
 <ZS+dSd9Z6/2wU0Eg@MiWiFi-R3L-srv>
 <89caf59a-d3b9-409d-b1ae-9e370cb9ee7d@kadam.mountain>
 <ZS/LrhcxcMOgiiX5@MiWiFi-R3L-srv>
 <ZS/TVMT9ed7OdyNy@rli9-mobl>
 <ZS/2k6DIMd0tZRgK@MiWiFi-R3L-srv>
 <20231018085248.6f3f36101cbdfe0990c8b467@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018085248.6f3f36101cbdfe0990c8b467@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/23 at 08:52am, Andrew Morton wrote:
> On Wed, 18 Oct 2023 23:15:31 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > From: Baoquan He <bhe@redhat.com>
> > Date: Wed, 18 Oct 2023 22:50:14 +0800
> > Subject: [PATCH] mm/vmalloc: fix the unchecked dereference warning in vread_iter()
> > Content-type: text/plain
> > 
> > LKP reported smatch warning as below:
> > 
> > ===================
> > smatch warnings:
> > mm/vmalloc.c:3689 vread_iter() error: we previously assumed 'vm' could be null (see line 3667)
> > ......
> > 06c8994626d1b7  @3667 size = vm ? get_vm_area_size(vm) : va_size(va);
> > ......
> > 06c8994626d1b7  @3689 else if (!(vm->flags & VM_IOREMAP))
> >                                  ^^^^^^^^^
> > Unchecked dereference
> > =====================
> > 
> > So add checking on whether 'vm' is not null when dereferencing it in
> > vread_iter(). This mutes smatch complaint.
> > 
> > ...
> >
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3813,7 +3813,7 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
> >  
> >  		if (flags & VMAP_RAM)
> >  			copied = vmap_ram_vread_iter(iter, addr, n, flags);
> > -		else if (!(vm->flags & VM_IOREMAP))
> > +		else if (!(vm && (vm->flags & VM_IOREMAP)))
> >  			copied = aligned_vread_iter(iter, addr, n);
> >  		else /* IOREMAP area is treated as memory hole */
> >  			copied = zero_iter(iter, n);
> 
> So is this not a real runtime bug?  We're only doing this to suppress a
> smatch warning?
> 
> If so, can we please include a description of *why* this wasn't a bug? 
> What conditions ensure that vm!=NULL at this point?

I think this is not a real runtime bug. The only chance it can hapen is
when (flags == VMAP_BLOCK) is true. That has been warned and could never
happen. I updated patch log and paste v2 here. 

                /*
                 * VMAP_BLOCK indicates a sub-type of vm_map_ram area, need
                 * be set together with VMAP_RAM.
                 */
                WARN_ON(flags == VMAP_BLOCK);
 
                if (!vm && !flags)
                        continue;


From 89cc02302766ab7a67cc668390c24079b4a9406b Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Wed, 18 Oct 2023 22:50:14 +0800
Subject: [PATCH v2] mm/vmalloc: fix the unchecked dereference warning in vread_iter()
Content-type: text/plain

LKP reported smatch warning as below:

===================
smatch warnings:
mm/vmalloc.c:3689 vread_iter() error: we previously assumed 'vm' could be null (see line 3667)
......
06c8994626d1b7  @3667 size = vm ? get_vm_area_size(vm) : va_size(va);
......
06c8994626d1b7  @3689 else if (!(vm->flags & VM_IOREMAP))
                                 ^^^^^^^^^
Unchecked dereference
=====================

This is not a real-time bug because the possible null 'vm' in the pointed
place could only happen when flags == VMAP_BLOCK. However, the case
'flags == VMAP_BLOCK' should never happen and has been detected with WARN_ON.
Please check vm_map_ram() implementation and the earlier checking in
vread_iter() at below:

                ~~~~~~~~~~~~~~~~~~~~~~~~~~
                /*
                 * VMAP_BLOCK indicates a sub-type of vm_map_ram area, need
                 * be set together with VMAP_RAM.
                 */
                WARN_ON(flags == VMAP_BLOCK);

                if (!vm && !flags)
                        continue;
                ~~~~~~~~~~~~~~~~~~~~~~~~~~

So add checking on whether 'vm' could be null when dereferencing it in
vread_iter(). This mutes smatch complaint.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202310171600.WCrsOwFj-lkp@intel.com/
Signed-off-by: Baoquan He <bhe@redhat.com>
---
v1->v2:
- Update patch log to state that it's not a realtime bug as Andrew
  suggested.

 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index aad48ed8d86b..2cc992392db7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3813,7 +3813,7 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 
 		if (flags & VMAP_RAM)
 			copied = vmap_ram_vread_iter(iter, addr, n, flags);
-		else if (!(vm->flags & VM_IOREMAP))
+		else if (!(vm && (vm->flags & VM_IOREMAP)))
 			copied = aligned_vread_iter(iter, addr, n);
 		else /* IOREMAP area is treated as memory hole */
 			copied = zero_iter(iter, n);
-- 
2.41.0

