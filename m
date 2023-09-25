Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98247ACE2B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjIYCfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIYCfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E289D3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695609290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ANXg/1DJ0/VAI2GEzIk6D4Il3nqQ5iQ0RRx80UDWkrQ=;
        b=CpJ5c+r/7Q+M62xlaWzk6k1KDKWCDS5GwDUyz4QgZoLROyfS12EIfQv9GY9ffNFuK57OVu
        CqM0U/oMOks1BZvshthMhvUh+lmm+87E4KLPE6Kv9HBbBrI9uv5tRbfGh7xJmhWzjazPZv
        M1bihj1Pplj6/b7A55HsBP5ZDyURaMc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-H1gpPwTHOImLDJI_px70dw-1; Sun, 24 Sep 2023 22:34:47 -0400
X-MC-Unique: H1gpPwTHOImLDJI_px70dw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2035811E7B;
        Mon, 25 Sep 2023 02:34:46 +0000 (UTC)
Received: from localhost (unknown [10.72.112.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0152A492C37;
        Mon, 25 Sep 2023 02:34:45 +0000 (UTC)
Date:   Mon, 25 Sep 2023 10:34:42 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        vschneid@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH] Crash: add lock to serialize crash hotplug handling
Message-ID: <ZRDxwqY669XsDsMk@MiWiFi-R3L-srv>
References: <20230922235446.260966-1-bhe@redhat.com>
 <8515c858-4be8-fbd6-7868-c8bfb5492f83@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8515c858-4be8-fbd6-7868-c8bfb5492f83@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/23/23 at 07:10am, Eric DeVolder wrote:
> 
> 
> On 9/22/23 18:54, Baoquan He wrote:
> > Eric reported that handling corresponding crash hotplug event can be
> > failed easily when many momery hotplug event are notified in a short period.
> > They failed because failing to take __kexec_lock.
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
> >   kernel/crash_core.c     |  3 +++
> >   kernel/kexec_core.c     |  1 +
> >   kernel/kexec_internal.h | 11 +++++++++++
> >   3 files changed, 15 insertions(+)
> > 
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index 03a7932cde0a..e8851724a530 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -783,9 +783,11 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> >   {
> >   	struct kimage *image;
> > +	crash_hotplug_lock();
> >   	/* Obtain lock while changing crash information */
> >   	if (!kexec_trylock()) {
> >   		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> > +		crash_hotplug_unlock();
> >   		return;
> >   	}
> > @@ -852,6 +854,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> >   out:
> >   	/* Release lock now that update complete */
> >   	kexec_unlock();
> > +	crash_hotplug_unlock();
> >   }
> 
> The crash_check_update_elfcorehdr() also has kexec_trylock() and needs similar treatment.
> 
> >   static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index 9dc728982d79..b95a73f35d9a 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -48,6 +48,7 @@
> >   #include "kexec_internal.h"
> >   atomic_t __kexec_lock = ATOMIC_INIT(0);
> > +DEFINE_MUTEX(__crash_hotplug_lock);
> >   /* Flag to indicate we are going to kexec a new kernel */
> >   bool kexec_in_progress = false;
> > diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> > index 74da1409cd14..1db31625ef20 100644
> > --- a/kernel/kexec_internal.h
> > +++ b/kernel/kexec_internal.h
> > @@ -28,6 +28,17 @@ static inline void kexec_unlock(void)
> >   	atomic_set_release(&__kexec_lock, 0);
> >   }
> > +/*
> > + * Different than kexec/kdump loading/unloading/crash or kexec jumping/shrinking
> > + * which usually rarely happen, there will be many crash hotplug events notified
> > + * during one short period, e.g one memory board is hot added and memory regions
> > + * are online. So mutex lock  __crash_hotplug_lock is used to serialize the crash
> > + * hotplug handling specificially.
> > + * */
> > +extern struct mutex __crash_hotplug_lock;
> > +#define crash_hotplug_lock() mutex_lock(&__crash_hotplug_lock)
> > +#define crash_hotplug_unlock() mutex_unlock(&__crash_hotplug_lock)
> > +
> >   #ifdef CONFIG_KEXEC_FILE
> >   #include <linux/purgatory.h>
> >   void kimage_file_post_load_cleanup(struct kimage *image);
> 
> The new content for kexec_internal.h and kexec_core.c could/should probably be
> moved into crash_core.c, within the CONFIG_CRASH_HOTPLUG?

That makes sense, I will spin v2 and post.

