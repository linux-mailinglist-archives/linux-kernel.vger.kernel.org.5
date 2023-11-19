Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D88B7F0877
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjKST3i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Nov 2023 14:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKST3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:29:37 -0500
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090ADE5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:29:34 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5caa401f151so238157b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:29:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700422173; x=1701026973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSuZWXA7VX1qqz2aTwL0m12B4oKVg9yE4zPN8KTIR1o=;
        b=M7i2QgDVwddSCIXkyHjXwmHtUhoOcFMLXb35aIN3fINi1ONWrIEquOsokPEjKb7GUB
         0s7eSA6FbDE+ZDNCNZX6PN+uUfHMVKNptlJiQYcdKteMKC9QPE47BSDnwioxkZmbcZXi
         /252n3mcF0UnL8VPJhyf65lqXAWNJfXYYsUgNlN+OtYgpbe4aNyQ4Zzzckvi18kOOuMh
         TIu+ld76Cpc1wxym7piNBq7Mi2rNdU8LDusTKk5CDQbX2VUSxFfDTwnzhDtkBlEQHQ+s
         pKcrF+eScYTxRb3P+dNMnkjBQ/wtCJcKnCW+XPPsp6llT3G+QX6QSAy/reyJhaVkZZAu
         w78g==
X-Gm-Message-State: AOJu0YxYBAb+lPgkoGgMZKVOtcH01qCrN9JaxpVQke37ufbRms9ozVmC
        QpEPzY+axUBH8+oIBZ1D7jhXzM5kCyLAhA==
X-Google-Smtp-Source: AGHT+IGs4kA1NcS9z39s+dv2OxhR6M6JeQ4dqPugxLQH7Yj3CQ2Qixq/YLzVJatPm9wY+ZcmHE62vQ==
X-Received: by 2002:a05:690c:2b89:b0:5a7:af97:c787 with SMTP id en9-20020a05690c2b8900b005a7af97c787mr4597330ywb.11.1700422173134;
        Sun, 19 Nov 2023 11:29:33 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id y7-20020a0def07000000b005a247c18403sm1917273ywe.37.2023.11.19.11.29.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 11:29:31 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5c5b9c142e8so30589707b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:29:30 -0800 (PST)
X-Received: by 2002:a81:dd09:0:b0:5a7:fbd5:8c1 with SMTP id
 e9-20020a81dd09000000b005a7fbd508c1mr5935678ywn.17.1700422170381; Sun, 19 Nov
 2023 11:29:30 -0800 (PST)
MIME-Version: 1.0
References: <20231118155105.25678-1-yury.norov@gmail.com> <20231118155105.25678-33-yury.norov@gmail.com>
In-Reply-To: <20231118155105.25678-33-yury.norov@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 19 Nov 2023 20:29:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXXC+DjLOy6xaghjLh2OTaU81BTa1BwCoGfpyyV1XKctw@mail.gmail.com>
Message-ID: <CAMuHMdXXC+DjLOy6xaghjLh2OTaU81BTa1BwCoGfpyyV1XKctw@mail.gmail.com>
Subject: Re: [PATCH 32/34] m68k: rework get_mmu_context()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-m68k@lists.linux-m68k.org, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuri,

Thanks for your patch!

On Sat, Nov 18, 2023 at 4:51 PM Yury Norov <yury.norov@gmail.com> wrote:
> ALSA code opencodes atomic find_and_set_bit_wrap(). Switch it to

ALSA?

> dedicated function.
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

The rest LGTM, but as it's Coldfire code, I'd like to defer to Greg.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
