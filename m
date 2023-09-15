Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B327A1D5F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjIOLYr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Sep 2023 07:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbjIOLYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:24:45 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5916E1B9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:24:40 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-59bd2e19c95so22656607b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694777079; x=1695381879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0PpysMM8Y9ZK703ol6vVQ3DajyNr/T628aVy9tnICc=;
        b=MbBlViL2tR6raUKEh6d9NzQ9BiMPqfud8ix2Wr6iGddEuW1L5/sWfbvEiBCzy0KS3C
         YJ1yAnEqajpMfkRbD6fI2tjtEFC8UM0lfaYbwARzMcwLMllyvTCn5jy99ZjFYgUCRF2L
         XSdP/LHgI5DBec28sd3WS5Kw8NTAPcM9wcAJBpnoPGLquvZfHsJDBQ1f7v78vqBrThP3
         z5p5vBxcoi/Dws0Naf7TziTtpST4XRTCqpLO6ocj2EqF0sTLvz+Y8RzDDNod//9tkOdN
         veSm6ViBKuIkGBVfyIlx+Kh0wRO5lwcCW2pkgEu0dytryP6Nqk4IUaRS/mOaZq8N4B0P
         vJwA==
X-Gm-Message-State: AOJu0YyaCPBusjqbC7XvNfi8owgOd1hZnePFAoUn4oxa15m5u+N1kj3t
        xL1/9uz1Fnn2xZJMl00RCAMGZGtEM0Ttmw==
X-Google-Smtp-Source: AGHT+IF/9BHbXiHFFXUQokeTfT+DCnTlhpIKFX+uNa9xFgksMOjkwaofx0joS7/c/CnfC79az98AHA==
X-Received: by 2002:a0d:d652:0:b0:589:e586:6f0a with SMTP id y79-20020a0dd652000000b00589e5866f0amr1383691ywd.3.1694777079337;
        Fri, 15 Sep 2023 04:24:39 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id h125-20020a816c83000000b00582fae92aa7sm811761ywc.93.2023.09.15.04.24.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 04:24:39 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5925e580f12so22424537b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:24:39 -0700 (PDT)
X-Received: by 2002:a81:7c42:0:b0:58f:bda3:8dd with SMTP id
 x63-20020a817c42000000b0058fbda308ddmr1529650ywc.32.1694777078863; Fri, 15
 Sep 2023 04:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230913101634.553699-1-john.ogness@linutronix.de>
In-Reply-To: <20230913101634.553699-1-john.ogness@linutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Sep 2023 13:24:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWts9NKU=DfPujTKAQNU6T3uawVtejwiTkp=usMu0rH-A@mail.gmail.com>
Message-ID: <CAMuHMdWts9NKU=DfPujTKAQNU6T3uawVtejwiTkp=usMu0rH-A@mail.gmail.com>
Subject: Re: [PATCH] workqueue: fix duplicate wq_update_pod_attrs_buf allocation
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 8:05 PM John Ogness <john.ogness@linutronix.de> wrote:
> One of the hunks for the patch resulting in
> commit 84193c07105c ("workqueue: Generalize unbound CPU pods") was
> applied incorrectly. This resulted in @wq_update_pod_attrs_buf
> being allocated twice.
>
> From the kmemleak detector:
>
> unreferenced object 0xc0000000040074c0 (size 64):
>   comm "swapper/0", pid 0, jiffies 4294937296 (age 1936.580s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<0000000076b83a6e>] .kmalloc_trace+0x54/0x190
>     [<00000000898f2356>] .alloc_workqueue_attrs+0x2c/0x60
>     [<0000000063365e1f>] .workqueue_init_early+0xe4/0x4b8
>     [<00000000ca97ff39>] .start_kernel+0x8d0/0xba4
>     [<000000002ee12080>] start_here_common+0x1c/0x20
>
> Remove the redundant allocation.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Stephen posted a similar patch before:
https://lore.kernel.org/all/20230905174935.2d75feab@gandalf.local.home

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
