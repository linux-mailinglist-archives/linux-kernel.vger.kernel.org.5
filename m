Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF5E7AEC1E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbjIZMFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjIZME7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318E0DE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695729846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pdY0WCFjlWQnzuU/n992RL0sOmwnkSxRL4q+fOL9AbA=;
        b=EeD5Y/bYx6M7wF4g6xZjpegfxuwOsCruq0v9qeNHxFNUEJWns/hFMQwUDZ/4D3trK+IZTa
        lotGvMM5wJ68OYCjWCADXPaJ82tn1ABOZXhSapF8K1UxOhxyt6P0NsFRBxv8svHSi+Sqxw
        UjSbOfSK/e3qBuGx+hvI3B2AM69OHCs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573--n3YlA7WONiEYiCMZTpFbw-1; Tue, 26 Sep 2023 08:04:02 -0400
X-MC-Unique: -n3YlA7WONiEYiCMZTpFbw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F696380115A;
        Tue, 26 Sep 2023 12:04:01 +0000 (UTC)
Received: from localhost (unknown [10.72.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2438E1005B96;
        Tue, 26 Sep 2023 12:03:58 +0000 (UTC)
Date:   Tue, 26 Sep 2023 20:03:55 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        akpm@linux-foundation.org, vschneid@redhat.com, dyoung@redhat.com,
        sourabhjain@linux.ibm.com
Subject: Re: [PATCH v2] Crash: add lock to serialize crash hotplug handling
Message-ID: <ZRLIqztHflB38zYV@MiWiFi-R3L-srv>
References: <20230925030701.338672-1-bhe@redhat.com>
 <d6bd8083-94e5-9bb3-7b1e-5bf6cc954baa@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6bd8083-94e5-9bb3-7b1e-5bf6cc954baa@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/23 at 09:59am, Eric DeVolder wrote:
> 
> 
> On 9/24/23 22:07, Baoquan He wrote:
> > Eric reported that handling corresponding crash hotplug event can be
> > failed easily when many memory hotplug event are notified in a short
> > period. They failed because failing to take __kexec_lock.
> > 
> > =======
> > [   78.714569] Fallback order for Node 0: 0
> > [   78.714575] Built 1 zonelists, mobility grouping on.  Total pages: 1817886
> > [   78.717133] Policy zone: Normal
> > [   78.724423] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> > [   78.727207] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> > [   80.056643] PEFILE: Unsigned PE binary
> > =======
> > 
> > The memory hotplug events are notified very quickly and very many,
> > while the handling of crash hotplug is much slower relatively. So the
> > atomic variable __kexec_lock and kexec_trylock() can't guarantee the
> > serialization of crash hotplug handling.
> > 
> > Here, add a new mutex lock __crash_hotplug_lock to serialize crash
> > hotplug handling specifically. This doesn't impact the usage of
> > __kexec_lock.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> > v1->v2:
> >   - Move mutex lock definition into CONFIG_CRASH_HOTPLUG ifdeffery
> >     scope in kernel/crash_core.c because the lock is only needed and
> >     used in that scope. Suggested by Eric.
> > 
> >   kernel/crash_core.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> > 
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index 03a7932cde0a..5951d6366b72 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -739,6 +739,17 @@ subsys_initcall(crash_notes_memory_init);
> >   #undef pr_fmt
> >   #define pr_fmt(fmt) "crash hp: " fmt
> > +/*
> > + * Different than kexec/kdump loading/unloading/jumping/shrinking which
> > + * usually rarely happen, there will be many crash hotplug events notified
> > + * during one short period, e.g one memory board is hot added and memory
> > + * regions are online. So mutex lock  __crash_hotplug_lock is used to
> > + * serialize the crash hotplug handling specifically.
> > + */
> > +DEFINE_MUTEX(__crash_hotplug_lock);
> > +#define crash_hotplug_lock() mutex_lock(&__crash_hotplug_lock)
> > +#define crash_hotplug_unlock() mutex_unlock(&__crash_hotplug_lock)
> > +
> >   /*
> >    * This routine utilized when the crash_hotplug sysfs node is read.
> >    * It reflects the kernel's ability/permission to update the crash
> > @@ -783,9 +794,11 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> >   {
> >   	struct kimage *image;
> > +	crash_hotplug_lock();
> >   	/* Obtain lock while changing crash information */
> >   	if (!kexec_trylock()) {
> >   		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> > +		crash_hotplug_unlock();
> >   		return;
> >   	}
> > @@ -852,6 +865,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> >   out:
> >   	/* Release lock now that update complete */
> >   	kexec_unlock();
> > +	crash_hotplug_unlock();
> >   }
> >   static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
> 
> The crash_check_update_elfcorehdr() also has kexec_trylock() and needs similar treatment.
> Userspace (ie udev rule processing) and kernel (crash hotplug infrastrucutre) need to be
> protected/serialized from one another.

You are right. I didn't consider the kexec_load interface. There's a
tiny racing window which we still need to avoid. V3 will be posted.
Thanks. 

