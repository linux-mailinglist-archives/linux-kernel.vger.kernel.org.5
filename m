Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D4977D07D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbjHOQ6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238601AbjHOQ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:58:33 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFC2B3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:58:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc6535027aso47799065ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692118712; x=1692723512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xqd4XV+LwQvovXgpNIcAKecAp1thZ9KtrkJe2mg2A8Q=;
        b=Er4jI5ppgad3Xbc6O7OV6ibMu3wQ4kkmvkVU7oEl4+TuevGHjVZAu9xXHZVJPX028y
         Co05tAqZ9jjHWST2N3Sx5m8MfkSQIms6XBXYHEQoikNPP5j3Ym+7FS2WX1ix6efpBLNu
         AQsMGdDUHQtBF/ZsaU9WiigQtTde3qykdojGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692118712; x=1692723512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqd4XV+LwQvovXgpNIcAKecAp1thZ9KtrkJe2mg2A8Q=;
        b=Wa9gVtKWX0xJvMQLqSXRcTOvTI/zGl1sMPZ+Ob8+4gvBx+F9qf7YjgSUxE7k58GhPm
         kKmbePXuzRS8Wku+e9m6R0kpo76tK0/ELDTLVvvyyE7VfRBVqU0HT8neAJFeIv1GBKV+
         7SqqUs3O9QByR4NxDK/bhfVzM+gTJF8FAZtCHJV0UIouF8s2wddPzr+44Z1eN9fwNLhM
         73+D1QgOK6A4yxK5VgjsfBferlxEm3QHVcUjtckoyyFUr0Sd4hS9pJbLratNtLeOc53j
         Ot7NlDJiT1niIB2EhgtiDpgFwke1kK5n4P6W4UFDKNIuPq5fLyGPVhkWOMq8xCLDl9c+
         IG8Q==
X-Gm-Message-State: AOJu0Yw6B2tT4L/8OHVwzUgyskyZA6lIu8Rqm8KSCWe2LpgFCON98Ne7
        J7RacuR+xcpoXRe1ZFqnnMEK0g==
X-Google-Smtp-Source: AGHT+IHR1MdTz8o3u+jIpxxqGrjUoUVE6Eg/qtxmxIolgfkvYMtA+cvbIf4VOpysh6aGKXHMb4sAVA==
X-Received: by 2002:a17:902:d4cd:b0:1bb:9b29:20d9 with SMTP id o13-20020a170902d4cd00b001bb9b2920d9mr17054181plg.20.1692118712223;
        Tue, 15 Aug 2023 09:58:32 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id ij13-20020a170902ab4d00b001b02bd00c61sm11448931plb.237.2023.08.15.09.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 09:58:31 -0700 (PDT)
Date:   Wed, 16 Aug 2023 01:58:27 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Rob Clark <robdclark@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] dma-debug: defer __dma_entry_alloc_check_leak() printk
 output
Message-ID: <20230815165827.GG907732@google.com>
References: <20230815152822.3660784-1-senozhatsky@chromium.org>
 <b6d28992-5adc-5df0-91e5-7fd0571b1465@arm.com>
 <20230815165225.GF907732@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815165225.GF907732@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/16 01:52), Sergey Senozhatsky wrote:
> On (23/08/15 17:42), Robin Murphy wrote:
> > On 15/08/2023 4:26 pm, Sergey Senozhatsky wrote:
> > > __dma_entry_alloc_check_leak() calls printk -> serial console
> > > output (qcom geni) and grabs port->lock under free_entries_lock,
> > > which is a conflicting locking dependency chain as qcom_geni IRQ
> > > handler can call into dma-debug code and grab free_entries_lock
> > > under port->lock.
> > > 
> > > Use deferred printk in __dma_entry_alloc_check_leak() so that we
> > > don't acquire serial console's port->lock under free_entries_lock.
> > 
> > Hmm, the print really doesn't need to be under the lock anyway, it only
> > needs to key off whether the "num_free_entries == 0" condition was hit or
> > not.
> 
> I thought about it, briefly. __dma_entry_alloc_check_leak() reads
> global nr_total_entries /  nr_prealloc_entries which are updated
> (inc/dec) under free_entries_lock, so I didn't want to move
> __dma_entry_alloc_check_leak() outside of free_entries_lock scope.

Something like this?

---

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 9e11ceadc69d..ca0508de4e78 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -637,15 +637,15 @@ static struct dma_debug_entry *__dma_entry_alloc(void)
        return entry;
 }

-static void __dma_entry_alloc_check_leak(void)
+static void __dma_entry_alloc_check_leak(u32 total_entries)
 {
-       u32 tmp = nr_total_entries % nr_prealloc_entries;
+       u32 tmp = total_entries % nr_prealloc_entries;

        /* Shout each time we tick over some multiple of the initial pool */
        if (tmp < DMA_DEBUG_DYNAMIC_ENTRIES) {
-               printk_deferred(KERN_INFO "dma_debug_entry pool grown to %u (%u00%%)\n",
-                               nr_total_entries,
-                               (nr_total_entries / nr_prealloc_entries));
+               pr_info("dma_debug_entry pool grown to %u (%u00%%)\n",
+                       total_entries,
+                       (total_entries / nr_prealloc_entries));
        }
 }

@@ -658,6 +658,8 @@ static struct dma_debug_entry *dma_entry_alloc(void)
 {
        struct dma_debug_entry *entry;
        unsigned long flags;
+       bool alloc_check_leak = false;
+       u32 total_entries;

        spin_lock_irqsave(&free_entries_lock, flags);
        if (num_free_entries == 0) {
@@ -667,13 +669,17 @@ static struct dma_debug_entry *dma_entry_alloc(void)
                        pr_err("debugging out of memory - disabling\n");
                        return NULL;
                }
-               __dma_entry_alloc_check_leak();
+               alloc_check_leak = true;
+               total_entries = nr_total_entries;
        }

        entry = __dma_entry_alloc();

        spin_unlock_irqrestore(&free_entries_lock, flags);

+       if (alloc_check_leak)
+               __dma_entry_alloc_check_leak(total_entries);
+
 #ifdef CONFIG_STACKTRACE
        entry->stack_len = stack_trace_save(entry->stack_entries,
                                            ARRAY_SIZE(entry->stack_entries),

