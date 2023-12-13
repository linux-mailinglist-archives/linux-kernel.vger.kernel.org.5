Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEB7810CD6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjLMI7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMI7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:59:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D094CAD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702457988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OX4lZddGamu8EnfuDkp92NJESGRg8WCgQgponQ6BJCI=;
        b=bTjhPbvUrg87jbHQw+/xc1OXDAyW/3v18PX+D2gufzFs2Ud12AbyJmhMg7Mna7nrqLZ7Ci
        W3Aw2uVjhUf3JFwF02ZamvVKtqIyb6VqZvuerpjDk/cFKyEjHh1oQLdpUlJYX1mfcCnpBC
        HMSYtUj6z91r+StZGhNDl9Dpi9hBzXE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-hiSkGMXHPSOPvzVmjEJU9w-1; Wed, 13 Dec 2023 03:59:46 -0500
X-MC-Unique: hiSkGMXHPSOPvzVmjEJU9w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40c464a1e5cso22506035e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:59:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702457985; x=1703062785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OX4lZddGamu8EnfuDkp92NJESGRg8WCgQgponQ6BJCI=;
        b=n1ERjA2gzLxvwUnn1YoS8sHwNSveCvv/XKT/feQVHBrWtAytJermMKC/KyXgrfynTr
         3TwBdpfe0m3kzqJNK4AyqwfCpdgxWtC0a/NFWri+fGEsi0daYXco5gtqYWcki3vXDabV
         eXRANzfqb194sefLyXV6GfDx1EnzEzVtJgNeptHiTmGqaXc/HeJTXCoahQuWPMwkpUGC
         wIOd93z//fjIRc97ONz2b5a7gi1xs1z7c1b/BhnsAatQYoTZiU+/PNGvMbZg7ibzl/4t
         Nw4S6asMAydh86hKJr3bk9Qp6G5F3WmlDQGJZbMxK4ReX6VRaVIPBgQB6+xsZkmfkrTo
         q+cQ==
X-Gm-Message-State: AOJu0YxbmSFSLyIt04YxNo5meUwYuw9jwJ6O0+g74tJ6QIoQn/pRhUtM
        ICx6cXWlkrSFwcBvzkrEfftBftUp59ZFUO+aT9YAbQpD/JVflcR/N5JCJdivWapBF8VbgiB3NI2
        nJi1OmJMq1CwreBQyPcprV+Tn
X-Received: by 2002:a05:600c:16c4:b0:40c:34e1:72d9 with SMTP id l4-20020a05600c16c400b0040c34e172d9mr2732952wmn.112.1702457984791;
        Wed, 13 Dec 2023 00:59:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHclAdDcCL3iPQ1Rp54op566LLgrSj9HcR91P9HqBcrD10K96tFgdDvB5d4aI6mFcSreomoAQ==
X-Received: by 2002:a05:600c:16c4:b0:40c:34e1:72d9 with SMTP id l4-20020a05600c16c400b0040c34e172d9mr2732947wmn.112.1702457984422;
        Wed, 13 Dec 2023 00:59:44 -0800 (PST)
Received: from localhost.localdomain ([151.29.78.8])
        by smtp.gmail.com with ESMTPSA id d13-20020a05600c34cd00b0040c496c64cfsm9313492wmq.12.2023.12.13.00.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 00:59:44 -0800 (PST)
Date:   Wed, 13 Dec 2023 09:59:42 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com, peterz@infradead.org
Subject: Re: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Message-ID: <ZXlyfjDsFGbYcMU6@localhost.localdomain>
References: <20230729135334.566138-1-atomlin@atomlin.com>
 <um77hym4t6zyypfbhwbaeqxpfdzc657oa7vgowdfah7cuctjak@pexots3mfb24>
 <ZXdXdBzvbkI4Y4fL@slm.duckdns.org>
 <ZXguMgcKLCLn16T4@localhost.localdomain>
 <ZXiVCOKk90Fjpmhw@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXiVCOKk90Fjpmhw@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 07:14, Tejun Heo wrote:
> Hello, Juri.
> 
> On Tue, Dec 12, 2023 at 10:56:02AM +0100, Juri Lelli wrote:
> > Hummm, OK, but in terms of which CPU the rescuer is possibly woken up,
> > how are we making sure that the wake up is always happening on
> > housekeeping CPUs (assuming unbound workqueues have been restricted to
> > those)?
> > 
> > AFAICS, we have
> > 
> > send_mayday ->
> >   wake_up_process(wq->rescuer->task)
> > 
> > which is not affined to the workqueue cpumask it's called to rescue, so
> > in theory can be woken up anywhere?
> 
> Ah, was only thinking about work item execution. Yeah, it's not following
> the isolation rule there and we probably should affine it as we're waking it
> up.

Something like the following then maybe?

---
 kernel/workqueue.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2989b57e154a7..ed73f7f80d57d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4405,6 +4405,12 @@ static void apply_wqattrs_commit(struct apply_wqattrs_ctx *ctx)
        link_pwq(ctx->dfl_pwq);
        swap(ctx->wq->dfl_pwq, ctx->dfl_pwq);

+       /* rescuer needs to respect wq cpumask changes */
+       if (ctx->wq->rescuer) {
+               kthread_bind_mask(ctx->wq->rescuer->task, ctx->attrs->cpumask);
+               wake_up_process(ctx->wq->rescuer->task);
+       }
+
        mutex_unlock(&ctx->wq->mutex);
 }

