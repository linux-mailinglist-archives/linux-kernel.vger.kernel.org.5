Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CC17C8C54
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjJMR3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJMR3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:29:39 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A17A9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:29:36 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b2b1b03074so509782b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1697218176; x=1697822976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97hlZ1f0vdmu3r3CsDL/WAPyzOiVT34Yjs8V5akcfEo=;
        b=uEmifDlDStjlij1eVPotjva0HERfmF/1FJqcGJJJEgAepA2MkawBYNf4Vi3pSoV0wd
         ulphhGxNZe9k26+4KFr/FoRCoMA2gUX/lC2K5iOdkqgdu5sczqS7Xaf2xOGKlW9nrwQ1
         IiOY04yH2jPGpq6y13sEbamqPA9gEIzFoJRO68qoiTFshRrAeFAWpTcds4SsBq58sgvn
         h9h/rjr2YcgmesSaPkBHCaL8tG4pPWVq3u1S9HFBTSbkSL7q2XBaV+ozr1C9xBTo6sSW
         N0jU3d4qozEoZDGmyfSAoQaY7K6lywvokxp8f9/W8G/ZLUxTQJUc13PZ9Pu7Qwlt8cJj
         zyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697218176; x=1697822976;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97hlZ1f0vdmu3r3CsDL/WAPyzOiVT34Yjs8V5akcfEo=;
        b=HrZ4kKL2qvm9atnTtHQCsy3kmLJPm4N/DypJXdnErURLrTyCFMYAdemEomLbfs6L3P
         7rjX36jl1eXxsA3oFmY44u6NRSOfwEZ5bQbp3j4rBIGnuwOLoNqtK1HDgSNTiMQ2Bqow
         u+/ouTBQxOlqQubkiN+7HQowqpa306t62oJj0RwE+lZ+VqZOtM+BHTGgFYerHyYNbsSs
         AWSjeBg+BltRh0qetiCDvycWtyeNOvBtfP9J1koNnomBKBIAkTFIAQ9dhbq4gvsOxMv1
         5wiwx5/d0Ac+D3FF3RE80Q8zJZ91/OB+Jf/BS4XXwPTEcPRfM7ZuKhzaVY+GfVOpReTC
         MB+w==
X-Gm-Message-State: AOJu0YycBfbxBw+tShDfiWRWKrvW+TIi8C6nfSVCo1fW4Pm3P9Pd0BUp
        9HzHtNqvdqhViX1oDP3Wv0jPvA==
X-Google-Smtp-Source: AGHT+IGFw8UO7lnc4otlF25dX3JXoiZ11aavqQev8GGdYf0HnCuIRJ1jZkX13PqJqavbCoyvGI5BuQ==
X-Received: by 2002:a05:6808:1201:b0:3a8:5ff0:6b52 with SMTP id a1-20020a056808120100b003a85ff06b52mr30316146oil.15.1697218176149;
        Fri, 13 Oct 2023 10:29:36 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id f11-20020a05680814cb00b003af4f822358sm813264oiw.24.2023.10.13.10.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 10:29:34 -0700 (PDT)
Date:   Fri, 13 Oct 2023 10:29:34 -0700 (PDT)
X-Google-Original-Date: Fri, 13 Oct 2023 10:29:14 PDT (-0700)
Subject:     Re: [RFC PATCH] membarrier: riscv: Provide core serializing command
In-Reply-To: <ZNDvVlbubtOoto0p@andrea>
CC:     mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     parri.andrea@gmail.com, charlie@rivosinc.com, rehn@rivosinc.com
Message-ID: <mhng-b720eb90-633f-498b-a487-0cfdc9f00ddd@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Aug 2023 06:19:18 PDT (-0700), parri.andrea@gmail.com wrote:
>> One more noteworthy detail: if a system call similar to ARM cacheflush(2) is implemented for
>> RISC-V, perhaps an iovec ABI (similar to readv(2)/writev(2)) would be relevant to handle
>> batching of cache flushing when address ranges are not contiguous. Maybe with a new name
>> like "cacheflushv(2)", so eventually other architectures could implement it as well ?
>
> I believe that's a sensible idea.  But the RISC-V maintainers can provide
> a more reliable feedback.

Sorry I missed this, I'm still a bit backlogged from COVID.  A few of us 
were having a meeting, just to try and summarize (many of these points 
came up in the thread, so sorry for rehashing things):

We don't have a fence.i in the scheduling path, as fence.i is very slow 
on systems that implement it by flushing the icache.  Instead we have a 
mechanism for deferring the fences (see flush_icache_deferred, though 
I'm no longer sure that's correct which I'll mention below).  As a 
result userspace can't do a fence.i directly, but instead needs to make 
a syscall/vdsocall so the kernel can do this bookkeeping.  There's some 
proposals for ISA extensions that replace fence.i, but they're still WIP 
and there's a lot of fence.i-only hardware so we'll have to deal with 
it.

When we did this we had a feeling this may be sub-optimal for systems 
that have faster fence.i implementations (ie, coherent instruction 
caches), but nobody's gotten around to doing that yet -- and maybe 
there's no hardware that behaves this way.  The rough plan was along the 
lines of adding a prctl() where userspace can request the ability to 
directly emit fence.i, which would then result in the kernel eagerly 
emitting fence.i when scheduling.  Some of the Java people have been 
asking for this sort of feature.

From looking at the membarrier arch/scheduler hooks, I think we might 
have a bug in our deferred icache flushing mechanism: specifically we 
hook into switch_mm(), which this comment has me worried about

         * When switching through a kernel thread, the loop in
         * membarrier_{private,global}_expedited() may have observed that
         * kernel thread and not issued an IPI. It is therefore possible to
         * schedule between user->kernel->user threads without passing though
         * switch_mm(). Membarrier requires a barrier after storing to
         * rq->curr, before returning to userspace, so provide them here:

Even if there's not a bug in the RISC-V stuff, it seems that we've ended 
up with pretty similar schemes here and we could remove some 
arch-specific code by de-duplicating things -- IIRC there was no 
membarrier when we did the original port, so I think we've just missed a 
cleanup opportunity.

So I'd propose doing the following:

* Pick up a patch like this.  Mmaybe exactly this, I'm going to give it 
  a proper review to make sure.
* Remove the RISC-V implemenation of deferred icache flushes and instead 
  just call into membarrier.  We might need to add some more bookkeeping 
  here, but from a quick look it seems membarrier is doing pretty much 
  the same thing.
* Implement that prctl that allows userspace to ask for permission to do 
  direct fence.i instructions -- sort of a different project, but if 
  we're going to be tearing into all this code we might as well do it 
  now.

Charlie is volunteering to do the work here, so hopefully we'll have 
something moving forward.

>
>   Andrea
