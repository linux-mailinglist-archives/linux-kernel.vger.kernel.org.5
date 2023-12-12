Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B7180F8BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377422AbjLLU50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjLLU5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:57:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5DB9C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:57:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A61C433D9;
        Tue, 12 Dec 2023 20:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1702414650;
        bh=KLAi6edpD/jz7hYCHpCfsvUM9M3DmKv0l7/YKtSRRC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e7knbxJnlbITSwa0iGhG6i91+F3Jm8V7PLb0TQb8ioXWTpV/yQ8N1WUZXMKgYjljy
         4OhppAYwgmv3NVXgay3I68ggS+37mBJobmt6vwEYHk4L+hghB7SgpxKdl3Gbkr1VAn
         MKYL8GId9UIgPJH6AhB77js/cfv15K7trRI6WVPU=
Date:   Tue, 12 Dec 2023 12:57:28 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH mm 1/4] lib/stackdepot: add printk_deferred_enter/exit
 guards
Message-Id: <20231212125728.1a275e704db4a5f5ca30e15c@linux-foundation.org>
In-Reply-To: <CANpmjNNXiRxwTk4wGHL3pXmXo5YUY=VNLCf+g+kB6inXJnC2YA@mail.gmail.com>
References: <cover.1702339432.git.andreyknvl@google.com>
        <6c38c31e304a55449f76f60b6f72e35f992cad99.1702339432.git.andreyknvl@google.com>
        <CANpmjNNXiRxwTk4wGHL3pXmXo5YUY=VNLCf+g+kB6inXJnC2YA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 19:59:29 +0100 Marco Elver <elver@google.com> wrote:

> On Tue, 12 Dec 2023 at 01:14, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Stack depot functions can be called from various contexts that do
> > allocations, including with console locks taken. At the same time, stack
> > depot functions might print WARNING's or refcount-related failures.
> >
> > This can cause a deadlock on console locks.
> >
> > Add printk_deferred_enter/exit guards to stack depot to avoid this.
> >
> > Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> > Closes: https://lore.kernel.org/all/000000000000f56750060b9ad216@google.com/
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 
> Reviewed-by: Marco Elver <elver@google.com>
> 
> Doesn't need Fixes, because the series is not yet in mainline, right?

I've moved the series "stackdepot: allow evicting stack traces, v4"
(please, not "the stack depot eviction series") into mm-nonmm-stable. 
Which is allegedly non-rebasing.

So yes please, provide Fixes: on each patch.
