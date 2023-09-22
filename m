Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597D07AABF8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjIVIHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjIVIHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2494CE64
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695370007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KB+yGo/OCL1+i13QqCvh+Psf1RFpEa7Aa+WJWzxIMsU=;
        b=QsXWKLQVxQX9ZEdqQzk/6e00xo4aDEN7H2SCisCeT/AXqh8r1i90/x1BGcfmK8XH4aZFqK
        gtuFSO835IBs2oK57cY3BUKnN5i47ZssIR3C8fVO6uHOGA0ZgGH135ba3ZCSwI943/Ctqt
        tcyNaXXjyfkSR7xvWrGwgx7pdW3YSY8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-WG_5hEtJOHW4HvcPvHgZzw-1; Fri, 22 Sep 2023 04:06:43 -0400
X-MC-Unique: WG_5hEtJOHW4HvcPvHgZzw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CE641C00D0D;
        Fri, 22 Sep 2023 08:06:15 +0000 (UTC)
Received: from localhost (unknown [10.72.112.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 56D3871128B;
        Fri, 22 Sep 2023 08:06:14 +0000 (UTC)
Date:   Fri, 22 Sep 2023 16:06:11 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        vgoyal@redhat.com, ebiederm@xmission.com,
        kexec@lists.infradead.org, sourabhjain@linux.ibm.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] kexec: change locking mechanism to a mutex
Message-ID: <ZQ1K88Il1F2I8JGR@MiWiFi-R3L-srv>
References: <20230921215938.2192-1-eric.devolder@oracle.com>
 <CALu+AoRv_Y3e2SmyftTLcCPzPbfjshc4dwO+fFK9gwtsgWfyvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALu+AoRv_Y3e2SmyftTLcCPzPbfjshc4dwO+fFK9gwtsgWfyvQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/23 at 11:36am, Dave Young wrote:
> [Cced Valentin Schneider as he added the trylocks]
> 
> On Fri, 22 Sept 2023 at 06:04, Eric DeVolder <eric.devolder@oracle.com> wrote:
> >
> > Scaled up testing has revealed that the kexec_trylock()
> > implementation leads to failures within the crash hotplug
> > infrastructure due to the inability to acquire the lock,
> > specifically the message:
> >
> >  crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> >
> > When hotplug events occur, the crash hotplug infrastructure first
> > attempts to obtain the lock via the kexec_trylock(). However, the
> > implementation either acquires the lock, or fails and returns; there
> > is no waiting on the lock. Here is the comment/explanation from
> > kernel/kexec_internal.h:kexec_trylock():
> >
> >  * Whatever is used to serialize accesses to the kexec_crash_image needs to be
> >  * NMI safe, as __crash_kexec() can happen during nmi_panic(), so here we use a
> >  * "simple" atomic variable that is acquired with a cmpxchg().
> >
> > While this in theory can happen for either CPU or memory hoptlug,
> > this problem is most prone to occur for memory hotplug.
> >
> > When memory is hot plugged, the memory is converted into smaller
> > 128MiB memblocks (typically). As each memblock is processed, a
> > kernel thread and a udev event thread are created. The udev thread
> > tries for the lock via the reading of the sysfs node
> > /sys/devices/system/memory/crash_hotplug node, and the kernel
> > worker thread tries for the lock upon entering the crash hotplug
> > infrastructure.
> >
> > These threads then compete for the kexec lock.
> >
> > For example, a 1GiB DIMM is converted into 8 memblocks, each
> > spawning two threads for a total of 16 threads that create a small
> > "swarm" all trying to acquire the lock. The larger the DIMM, the
> > more the memblocks and the larger the swarm.
> >
> > At the root of the problem is the atomic lock behind kexec_trylock();
> > it works well for low lock traffic; ie loading/unloading a capture
> > kernel, things that happen basically once. But with the introduction
> > of crash hotplug, the traffic through the lock increases significantly,
> > and more importantly in bursts occurring at roughly the same time. Thus
> > there is a need to wait on the lock.

Yeah, the atomic __kexec_lock is used to lock the door of operation on
kimage. Among kexec/kdump kernel load/unload/shrink/jumping, once any one
is in progress, the later attempt doesn't make sense. And these events are
rare.

Crash hotplug event is different, there will be many during one period.
The main problem you are encountering is the cocurrent handling of hotplug
event, right? Wondering if we can define another mutex lock to serialize
the handling of hotplug event like below. Just a sterotype to state my
thought.

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 03a7932cde0a..39b9a57a4177 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -783,6 +783,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 {
 	struct kimage *image;
 
+	crash_hotplug_lock();
 	/* Obtain lock while changing crash information */
 	if (!kexec_trylock()) {
 		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
@@ -852,6 +853,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 out:
 	/* Release lock now that update complete */
 	kexec_unlock();
+	crash_hotplug_unlock();
 }
 
 static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 9dc728982d79..b95a73f35d9a 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -48,6 +48,7 @@
 #include "kexec_internal.h"
 
 atomic_t __kexec_lock = ATOMIC_INIT(0);
+DEFINE_MUTEX(__crash_hotplug_lock);
 
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 74da1409cd14..32cb890bb059 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -28,6 +28,10 @@ static inline void kexec_unlock(void)
 	atomic_set_release(&__kexec_lock, 0);
 }
 
+extern struct mutex __crash_hotplug_lock;
+#define crash_hotplug_lock() mutex_lock(&__crash_hotplug_lock)
+#define crash_hotplug_unlock() mutex_unlock(&__crash_hotplug_lock)
+
 #ifdef CONFIG_KEXEC_FILE
 #include <linux/purgatory.h>
 void kimage_file_post_load_cleanup(struct kimage *image);

