Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB6F7CE0EA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjJRPQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjJRPQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D6198
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697642158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jB/qQDYRlrSDUxpltmB2o5vEp1zK7M2ILhY2l9aeHL8=;
        b=h9cz2fjNVqfA+nGzgf9KDzhWvr9pfRzPF0qME+P3uirIlmctmTYlMoRZidCc+3MyhgZkLI
        SG9huPvzjPH5DeLoLM4BPZA3Qn9OBFujfd8CPAwNSUFBAxBqheSBD9gTQQwbeytCthpnBB
        k1oI5+FlCfgcxrkzkout9FiFs3pAbY0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-n3af-Y9sMfyzzG8I4WAiZQ-1; Wed, 18 Oct 2023 11:15:35 -0400
X-MC-Unique: n3af-Y9sMfyzzG8I4WAiZQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08C60185A795;
        Wed, 18 Oct 2023 15:15:35 +0000 (UTC)
Received: from localhost (unknown [10.72.112.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DF9E492BEF;
        Wed, 18 Oct 2023 15:15:33 +0000 (UTC)
Date:   Wed, 18 Oct 2023 23:15:31 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Philip Li <philip.li@intel.com>
Cc:     oe-kbuild@lists.linux.dev, Lorenzo Stoakes <lstoakes@gmail.com>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: mm/vmalloc.c:3689 vread_iter() error: we previously assumed 'vm'
 could be null (see line 3667)
Message-ID: <ZS/2k6DIMd0tZRgK@MiWiFi-R3L-srv>
References: <f82be227-bfde-439a-b339-1b4ee370d59a@kadam.mountain>
 <ZS+dSd9Z6/2wU0Eg@MiWiFi-R3L-srv>
 <89caf59a-d3b9-409d-b1ae-9e370cb9ee7d@kadam.mountain>
 <ZS/LrhcxcMOgiiX5@MiWiFi-R3L-srv>
 <ZS/TVMT9ed7OdyNy@rli9-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS/TVMT9ed7OdyNy@rli9-mobl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/23 at 08:45pm, Philip Li wrote:
> On Wed, Oct 18, 2023 at 08:12:30PM +0800, Baoquan He wrote:
> > Hi Dan,
> > 
> > On 10/18/23 at 01:32pm, Dan Carpenter wrote:
> > > On Wed, Oct 18, 2023 at 04:54:33PM +0800, Baoquan He wrote:
> > > > Hi,
> > > > 
> > > > On 10/17/23 at 05:26pm, Dan Carpenter wrote:
> > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > > head:   213f891525c222e8ed145ce1ce7ae1f47921cb9c
> > > > > commit: 4c91c07c93bbbdd7f2d9de2beb7ee5c2a48ad8e7 mm: vmalloc: convert vread() to vread_iter()
> > > > > config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231017/202310171600.WCrsOwFj-lkp@intel.com/config)
> > > > > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > > > > reproduce: (https://download.01.org/0day-ci/archive/20231017/202310171600.WCrsOwFj-lkp@intel.com/reproduce)
> > > > > 
> > > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > > the same patch/commit), kindly add following tags
> > > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > > | Closes: https://lore.kernel.org/r/202310171600.WCrsOwFj-lkp@intel.com/
> > > > > 
> > > > > smatch warnings:
> > > > > mm/vmalloc.c:3689 vread_iter() error: we previously assumed 'vm' could be null (see line 3667)
> > > > 
> > > > I see the code deficit, while the reproduce link seems to be unavilable.
> > > > Could you double check the link and provide a good one so that I can
> > > > verify the code fix?
> > > 
> > > Here's a link.  :)
> > > 
> > > https://repo.or.cz/smatch.git/blob/HEAD:/Documentation/smatch.txt
> > > 
> > > Just build it and run:
> > > 
> > > ~/smatch/smatch_scripts/kchecker drivers/whatever/file.c
> > 
> > I don't know smatch and lkp well, and have no idea on how to use above
> 
> Hi Baoquan, sorry there's issue in the generation of reproduce step, but even
> it is generated, it doesn't contain the detail to setup smatch. You can follow
> the smatch.txt to do the setup.
> 
> > smatch.txt to build the target file.c. I meant in this lkp report, the
> > config file is available, however, the reproduce file is empty. Could
> > you help add an available reproduce file link? or give a little more
> > detail guiding me how to make use of above smatch file to build .c file?
> 
> On the other side, Dan has added analysis to the report as below.
> It's possible to resolve the issue without running the smatch check.
> You can give this a try.
> 
> 	06c8994626d1b7 Baoquan He              2023-02-06  3657  		if (!vm && !flags)
> 
> 	NULL check
> 
> 	...
> 
> 	06c8994626d1b7 Baoquan He              2023-02-06 @3689  		else if (!(vm->flags & VM_IOREMAP))
>                                                                                    ^^^^^^^^^
> 	Unchecked dereference

Thanks for the detailed explanation, Philipp.

Yes, the code deficit is identified. I planned to reproduce and verify
with LKP's reproducer so that it's 100% clear. Anyway, below patch
should fix it.


From a39fdd50030a7d88a7f69bcba29e6f75020a1915 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Wed, 18 Oct 2023 22:50:14 +0800
Subject: [PATCH] mm/vmalloc: fix the unchecked dereference warning in vread_iter()
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

So add checking on whether 'vm' is not null when dereferencing it in
vread_iter(). This mutes smatch complaint.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202310171600.WCrsOwFj-lkp@intel.com/
Signed-off-by: Baoquan He <bhe@redhat.com>
---
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

