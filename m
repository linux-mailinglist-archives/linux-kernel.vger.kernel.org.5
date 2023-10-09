Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85E87BD9D1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346225AbjJILaX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 07:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjJILaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:30:18 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581AF19A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:29:52 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59f82ad1e09so55429897b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 04:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696850991; x=1697455791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmxle10UmTm3V9bFVaMw9WXKc8CRfQ8WHVztXUU4bIQ=;
        b=gASHBJo8dJ2OdkjKRMoyuqUyTvXuTo6j49QAXlhrqaibjTDEP76EwFyczYyaJ+GqRM
         kqGVhFT4e1+BlmFAjTrLNYCENie8Q8tVXWuINj/zJUwSjK6/lFxSvVBS8EizpURhUA/n
         9Smi68d9oi5bS0/vE2XSoI672yMPMfZYFNWP9HsIIzV63oPqAqDNmSS+SaXlW2QVPiCa
         7PzM54PaS7kZ6aulUFg6XWR0xEGbalZFceZGOiRoJeusnt75ZcavJ5BU6lygCIdk+9tu
         fDN+fMkN6hLW7vIgJnGVcbghw70Se38Wvg150Ctfj0PFhcwU8rHelnc2KrBZ/fJvcmVQ
         0ksA==
X-Gm-Message-State: AOJu0Yw7QPzRZvKjsqCbPosa5rEukwiyIJ172TQzuy6oP/sZonLlgvta
        I0oyhpy8AGoPOwv7i/c3iIxjlqaQTGeTzA==
X-Google-Smtp-Source: AGHT+IFRPLdTO30b0WjzY0qr47GeUGSzAhexJY2ETxXtzTVTnrNCA0L8fGYD4TxHIKAwoCj4GcOuIQ==
X-Received: by 2002:a5b:807:0:b0:d81:6e88:7cb3 with SMTP id x7-20020a5b0807000000b00d816e887cb3mr13862644ybp.47.1696850991362;
        Mon, 09 Oct 2023 04:29:51 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id 127-20020a250885000000b00d7465a90f0csm3036374ybi.22.2023.10.09.04.29.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 04:29:51 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d89ba259964so4733417276.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 04:29:51 -0700 (PDT)
X-Received: by 2002:a25:bccd:0:b0:d4b:6a0:fe2b with SMTP id
 l13-20020a25bccd000000b00d4b06a0fe2bmr14893641ybm.36.1696850990864; Mon, 09
 Oct 2023 04:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <7858a184cda66e0991fd295c711dfed7e4d1248c.1696603287.git.geert@linux-m68k.org>
In-Reply-To: <7858a184cda66e0991fd295c711dfed7e4d1248c.1696603287.git.geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Oct 2023 13:29:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVT7QEfagWcLx9z7YGtFiKRW5-J3F6gyxKYEzFBb=2_Gg@mail.gmail.com>
Message-ID: <CAMuHMdVT7QEfagWcLx9z7YGtFiKRW5-J3F6gyxKYEzFBb=2_Gg@mail.gmail.com>
Subject: Re: [PATCH/RFC] m68k: Add full preempt support
To:     Greg Ungerer <gerg@linux-m68k.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
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

On Fri, Oct 6, 2023 at 4:49 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Currently, a Preemptible Kernel is only supported on the Coldfire CPU
> family.  Extend preempt support to the full Classic M68K CPU family
> (68020+ with MMU, and 68000-derivatives without MMU).
>
> Make sure preemption is disabled in loops involving cache and TLB
> flushing.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Tested on ARAnyM, using none/voluntary/full preemption.

bloat-o-meter summaries for atari_defconfig:

PREEMPT_NONE -> PREEMPT_VOLUNTARY:

    add/remove: 0/0 grow/shrink: 238/30 up/down: 2804/-748 (2056)
    Total: Before=4478149, After=4480205, chg +0.05%

PREEMPT_VOLUNTARY -> PREEMPT:

    add/remove: 735/277 grow/shrink: 3050/347 up/down: 244359/-11440 (232919)
    Total: Before=4480205, After=4713124, chg +5.20%

Ouch.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
