Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6617FE13E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjK2UmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjK2UmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:42:10 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20CAD67
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:42:16 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso2893241fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701290535; x=1701895335; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjyD2uy7rhiIwUguKMOS6O61vfhptuzTgpHO35Q0vkM=;
        b=eGs95RLOGruwTbMSTqo73RrVdIvHASzU+mtaPm12UPVwwBpCy4NnDgxxgB8Ld6YnsE
         iIvVLvBnyLGc3R9MoKjPxe9bbVDNScQm2pio82wb/OOXWJxBFfstAiFAkt1hakxfg/pY
         1BK1A9ycFaMtDNqyhDxXY1rV5kZp/+JSz64J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701290535; x=1701895335;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjyD2uy7rhiIwUguKMOS6O61vfhptuzTgpHO35Q0vkM=;
        b=nYBZPxM+uMRGsyqxikVGjz7DKxwcxSpHsnWCBrZtNdyROc40J2BecqaKItaR6F3UUP
         IaxmAYbXN8NEaSH1x3kGbsYW4Q5GUYyTFzc1fdQi+K0s0LaE8NTTOExuRy+fr0o6kwfh
         DKHNdXNiWObI4nUsZTtfy4Yt8m7LUMP8oplzE+a88YtRp1YVJiBasLeZZCw6nH0Msf8s
         rmtMvIVpUDo51C2tps3yYq6uytonvxwNlxHcQKvYz5fuOUqqgG2XmdA5MUbyHh/9fdop
         8xhVlnQ6qLAbwYJHExESSM4hFx36m9F/wtguGZn5O7a7Mpi2/GXHS8Gul37EwCrVgxER
         mjsA==
X-Gm-Message-State: AOJu0YwRPV4fm6MiUHQEQRxhqhfW5CHjQcqmsbQFhWpgKkwKzb+D17bM
        +rkw4peOqA10Q2q1Yf2rZMwEb1SpMuMYnVzdI0D8UQ==
X-Google-Smtp-Source: AGHT+IGLtBi/LhsApUdsOPv/Q/7AseQ1qifIjVFc58wVFu+pFHvSnzJz7JInqQ9Npx4mSLCP14BLJFdwCOSfEaqh9eA=
X-Received: by 2002:a2e:9d8e:0:b0:2c9:c22e:31eb with SMTP id
 c14-20020a2e9d8e000000b002c9c22e31ebmr1958958ljj.22.1701290534275; Wed, 29
 Nov 2023 12:42:14 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Nov 2023 12:42:13 -0800
MIME-Version: 1.0
In-Reply-To: <202311291219.A6E3E58@keescook>
References: <20231127234946.2514120-1-swboyd@chromium.org> <202311291219.A6E3E58@keescook>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 29 Nov 2023 12:42:13 -0800
Message-ID: <CAE-0n53x8AXUPaq5_TaqF6PN5u5J6g5RYoNWALN-MnEJBa5syA@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: Add kfence read after free crash type
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding kfence folks (will add on v2).

Quoting Kees Cook (2023-11-29 12:22:27)
> On Mon, Nov 27, 2023 at 03:49:45PM -0800, Stephen Boyd wrote:
> > Add the ability to allocate memory from kfence and trigger a read after
> > free on that memory to validate that kfence is working properly. This is
> > used by ChromeOS integration tests to validate that kfence errors can be
> > collected on user devices and parsed properly.
>
> This looks really good; thanks for adding this!
>
> >
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/misc/lkdtm/heap.c | 64 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >
> > diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
> > index 0ce4cbf6abda..608872bcc7e0 100644
> > --- a/drivers/misc/lkdtm/heap.c
> > +++ b/drivers/misc/lkdtm/heap.c
> > @@ -4,6 +4,7 @@
> >   * page allocation and slab allocations.
> >   */
> >  #include "lkdtm.h"
> > +#include <linux/kfence.h>
> >  #include <linux/slab.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/sched.h>
> > @@ -132,6 +133,66 @@ static void lkdtm_READ_AFTER_FREE(void)
> >       kfree(val);
> >  }
> >
> > +#if IS_ENABLED(CONFIG_KFENCE)
>
> I really try hard to avoid having tests disappear depending on configs,
> and instead report the expected failure case (as you have). Can this be
> built without the IS_ENABLED() tests?
>

We need IS_ENABLED() for the kfence_sample_interval variable. I suppose
if the config isn't set that variable can be assumed as zero and then
the timeout would hit immediately. We can either define the name
'kfence_sample_interval' as 0 in the header, or put an ifdef in the
function.

---8<---
diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 4f467d3972a6..574d0aa726dc 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -138,6 +138,14 @@ static void lkdtm_KFENCE_READ_AFTER_FREE(void)
 	int *base, val, saw;
 	unsigned long timeout, resched_after;
 	size_t len = 1024;
+	unsigned long interval;
+
+#ifdef CONFIG_KFENCE
+	interval = kfence_sample_interval;
+#else
+	interval = 0;
+#endif
+
 	/*
 	 * The slub allocator will use the either the first word or
 	 * the middle of the allocation to store the free pointer,
@@ -150,13 +158,13 @@ static void lkdtm_KFENCE_READ_AFTER_FREE(void)
 	 * 100x the sample interval should be more than enough to ensure we get
 	 * a KFENCE allocation eventually.
 	 */
-	timeout = jiffies + msecs_to_jiffies(100 * kfence_sample_interval);
+	timeout = jiffies + msecs_to_jiffies(100 * interval);
 	/*
 	 * Especially for non-preemption kernels, ensure the allocation-gate
 	 * timer can catch up: after @resched_after, every failed allocation
 	 * attempt yields, to ensure the allocation-gate timer is scheduled.
 	 */
-	resched_after = jiffies + msecs_to_jiffies(kfence_sample_interval);
+	resched_after = jiffies + msecs_to_jiffies(interval);
 	do {
 		base = kmalloc(len, GFP_KERNEL);
 		if (!base) {

---8<----
diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index 401af4757514..88100cc9caba 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -223,6 +223,8 @@ bool __kfence_obj_info(struct kmem_obj_info *kpp,
void *object, struct slab *sla

 #else /* CONFIG_KFENCE */

+#define kfence_sample_interval	(0)
+
 static inline bool is_kfence_address(const void *addr) { return false; }
 static inline void kfence_alloc_pool_and_metadata(void) { }
 static inline void kfence_init(void) { }
