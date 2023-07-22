Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A84875DB08
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 10:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjGVIjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 04:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGVIjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 04:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290282106
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 01:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690015099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UY1p3F98tixlPb7eOWLjpqGq9rAksoWVFOM7au1Qp78=;
        b=D0WT/g9e6X3OKGhpg7ef4Dq2w/sR6ubEpbr5S9BUHUwpK5aqM/7cX2hSixiXyeN7/IImrJ
        YEsteWhTM/70/PZGJNvufmHpY5dai7SFkyCsEz7G3sdLAsP50+umb3AQLmcUaXLLtvGFnr
        aA0uR//I9D4zPaTud5WVF29w8Kx0BbI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-3TaFKNs_MVC0WyQ0BBLFgA-1; Sat, 22 Jul 2023 04:38:15 -0400
X-MC-Unique: 3TaFKNs_MVC0WyQ0BBLFgA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C6AF185A78F;
        Sat, 22 Jul 2023 08:38:14 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15B6CC57969;
        Sat, 22 Jul 2023 08:38:14 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id F1E5230C0663; Sat, 22 Jul 2023 08:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id EEF623F7CF;
        Sat, 22 Jul 2023 10:38:13 +0200 (CEST)
Date:   Sat, 22 Jul 2023 10:38:13 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: Warnings when suspending to disk
In-Reply-To: <alpine.LRH.2.02.2206110625280.9999@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <941832c4-2e61-7023-8545-73bbac26e85c@redhat.com>
References: <alpine.LRH.2.02.2205301145540.25840@file01.intranet.prod.int.rdu2.redhat.com> <YpUcf19E+qgb6Eyu@kroah.com> <alpine.LRH.2.02.2205310324410.13770@file01.intranet.prod.int.rdu2.redhat.com> <Ypjr5yIMan1N0bqH@yaz-fattaah>
 <alpine.LRH.2.02.2206031327190.25179@file01.intranet.prod.int.rdu2.redhat.com> <YqD1YjeovGu28xsP@yaz-fattaah> <alpine.LRH.2.02.2206110625280.9999@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

Hi

I upgraded the kernel to 6.4.4 and it still has this bug (see 
https://lore.kernel.org/lkml/YqD1YjeovGu28xsP@yaz-fattaah/T/ for the 
beginning of this thread).

The patch below fixes these warnings.

I'd like to ask you to submit the patch upstream, with

Fixes: 7f99cb5e6039 ("x86/CPU/AMD: Use default_groups in kobj_type")
Cc: stable@vger.kernel.org	# v5.18+
Tested-by: Mikulas Patocka <mpatocka@redhat.com>

Mikulas



On Sat, 11 Jun 2022, Mikulas Patocka wrote:

> 
> 
> On Wed, 8 Jun 2022, Yazen Ghannam wrote:
> 
> > On Fri, Jun 03, 2022 at 01:34:26PM -0400, Mikulas Patocka wrote:
> > 
> > ...
> > 
> > > I tried this patch and it doesn't help.
> > 
> > Thanks Mikulas for testing.
> > 
> > I'm still not able to reproduce the exact issue. But I was able to reproduce
> > the same symptom by hacking the kernel and doing CPU hotplug.
> 
> I also see the warnings when disabling cores.
> 
> > Can you please try the following patch? This seems to work in my hacked case.
> > I also tried to write out a detailed description of the issue to the best of
> > my knowledge.
> 
> This patch works - there are no longer any warnings on CPU disable or on 
> suspend to disk.
> 
> Mikulas
> 
> > Thanks,
> > Yazen
> > 
> > ========================
> > 
> > >From d1fa5cdc7f29bf810215f0a83f16bc7435e55240 Mon Sep 17 00:00:00 2001
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > Date: Mon, 6 Jun 2022 19:45:56 +0000
> > Subject: [PATCH] x86/MCE/AMD: Decrement threshold_bank refcount when removing
> >  threshold blocks
> > 
> > AMD systems from Family 10h to 16h share MCA bank 4 across multiple CPUs.
> > Therefore, the threshold_bank structure for bank 4, and its threshold_block
> > structures, will be initialized once at boot time. And the kobject for the
> > shared bank will be added to each of the CPUs that share it. Furthermore,
> > the threshold_blocks for the shared bank will be added again to the bank's
> > kobject. These additions will increase the refcount for the bank's kobject.
> > 
> > For example, a shared bank with two blocks and shared across two CPUs will
> > be set up like this:
> > 
> > CPU0 init
> >   bank create and add; bank refcount = 1; threshold_create_bank()
> >     block 0 init and add; bank refcount = 2; allocate_threshold_blocks()
> >     block 1 init and add; bank refcount = 3; allocate_threshold_blocks()
> > CPU1 init
> >   bank add; bank refcount = 3; threshold_create_bank()
> >     block 0 add; bank refcount = 4; __threshold_add_blocks()
> >     block 1 add; bank refcount = 5; __threshold_add_blocks()
> > 
> > Currently in threshold_remove_bank(), if the bank is shared then
> > __threshold_remove_blocks() is called. Here the shared bank's kobject and
> > the bank's blocks' kobjects are deleted. This is done on the first call
> > even while the structures are still shared. Subsequent calls from other
> > CPUs that share the structures will attempt to delete the kobjects.
> > 
> > During kobject_del(), kobject->sd is removed. If the kobject is not part of
> > a kset with default_groups, then subsequent kobject_del() calls seem safe
> > even with kobject->sd == NULL.
> > 
> > Originally, the AMD MCA thresholding structures did not use default_groups.
> > And so the above behavior was not apparent.
> > 
> > However, a recent change implemented default_groups for the thresholding
> > structures. Therefore, kobject_del() will go down the sysfs_remove_groups()
> > code path. In this case, the first kobject_del() may succeed and remove
> > kobject->sd. But subsequent kobject_del() calls will give a WARNing in
> > kernfs_remove_by_name_ns() since kobject->sd == NULL.
> > 
> > Use kobject_put() on the shared bank's kobject when "removing" blocks. This
> > decrements the bank's refcount while keeping kobjects enabled until the
> > bank is no longer shared. At that point, kobject_put() will be called on
> > the blocks which drives their refcount to 0 and deletes them and also
> > decrementing the bank's refcount. And finally kobject_put() will be called
> > on the bank driving its refcount to 0 and deleting it.
> > 
> > With this patch and the example above:
> > 
> > CPU1 shutdown
> >   bank is shared; bank refcount = 5; threshold_remove_bank()
> >     block 0 put parent bank; bank refcount = 4; __threshold_remove_blocks()
> >     block 1 put parent bank; bank refcount = 3; __threshold_remove_blocks()
> > CPU0 shutdown
> >   bank is no longer shared; bank refcount = 3; threshold_remove_bank()
> >     block 0 put block; bank refcount = 2; deallocate_threshold_blocks()
> >     block 1 put block; bank refcount = 1; deallocate_threshold_blocks()
> >   put bank; bank refcount = 0; threshold_remove_bank()
> > 
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Tested-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> > ---
> >  arch/x86/kernel/cpu/mce/amd.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> > index 2b7ee4a6c6ba..680b75d23a03 100644
> > --- a/arch/x86/kernel/cpu/mce/amd.c
> > +++ b/arch/x86/kernel/cpu/mce/amd.c
> > @@ -1260,10 +1260,10 @@ static void __threshold_remove_blocks(struct threshold_bank *b)
> >  	struct threshold_block *pos = NULL;
> >  	struct threshold_block *tmp = NULL;
> >  
> > -	kobject_del(b->kobj);
> > +	kobject_put(b->kobj);
> >  
> >  	list_for_each_entry_safe(pos, tmp, &b->blocks->miscj, miscj)
> > -		kobject_del(&pos->kobj);
> > +		kobject_put(b->kobj);
> >  }
> >  
> >  static void threshold_remove_bank(struct threshold_bank *bank)
> > -- 
> > 2.25.1
> > 
> 

