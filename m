Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D592080C399
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjLKI1E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 03:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbjLKIZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:25:35 -0500
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3764510A;
        Mon, 11 Dec 2023 00:25:38 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5d6b9143782so35674707b3.0;
        Mon, 11 Dec 2023 00:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702283137; x=1702887937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2eWe2oiRzSTkXAZdruL7FMLjSewImdzh7HyKdRxUqI=;
        b=wt3Rq5OOiqu/yBHspSUY8gYpz2jKqNuD+wQmqfsrOE2IB2pr5KQw0CVNSKsYMfJg/R
         mIV6FEIbf0QvNyR7BocY27xzU49XdRbh0ZtoLTJx5qw0VUBOM5RQX3dLgb2PiwBogaqa
         uSL9I8AA2kLk44qIzJNMDSrcLPrUMW3fPEWbUUHSLcr/UNYEqLB+erVtXYQYghMkywhT
         moS+KBbbIbTAuqGnbkBgf8fFDYuZwct5gwAMR2B1nvPmRnI8TOgVp06Rtl7OkFcBSIwG
         3KXbzitAbhUipCQ6Fgkk9xZBhxBZCy4nC4/yqObD8nOUv1hfArEeA7yYCzrTZTojuEDc
         5sJg==
X-Gm-Message-State: AOJu0YwWOOb6kl9Utfo6YW9W23Ulsiu1YgsEL14CeoDx3eus8iOCD76F
        r5dEla+HZ2ApE+ZiFBL9URxiktQlunAiQg==
X-Google-Smtp-Source: AGHT+IGznTimJA4mSAu8adt3wu2sAMV0tN8lU0584QstnoDzM3+BXIPuN8HqHTzSSYsZE0s4uvfy5A==
X-Received: by 2002:a0d:d48c:0:b0:5d3:e835:bd67 with SMTP id w134-20020a0dd48c000000b005d3e835bd67mr3107076ywd.41.1702283136935;
        Mon, 11 Dec 2023 00:25:36 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id q68-20020a818047000000b005d580a1fd70sm2796876ywf.75.2023.12.11.00.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 00:25:36 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5d6b9143782so35674547b3.0;
        Mon, 11 Dec 2023 00:25:35 -0800 (PST)
X-Received: by 2002:a81:7285:0:b0:5d8:74e6:e4c5 with SMTP id
 n127-20020a817285000000b005d874e6e4c5mr2853116ywc.98.1702283135734; Mon, 11
 Dec 2023 00:25:35 -0800 (PST)
MIME-Version: 1.0
References: <20231208073036.7884-1-bhe@redhat.com> <ZXLI748b85be459B@fedora>
In-Reply-To: <ZXLI748b85be459B@fedora>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Dec 2023 09:25:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWAaM+eJtiVbXXBO0xOmpqhrOiCO5itNsNdTiOxRXVtVw@mail.gmail.com>
Message-ID: <CAMuHMdWAaM+eJtiVbXXBO0xOmpqhrOiCO5itNsNdTiOxRXVtVw@mail.gmail.com>
Subject: Re: [PATCH 0/5] kexec: fix the incorrect ifdeffery and dependency of CONFIG_KEXEC
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        loongarch@lists.linux.dev, kexec@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-sh@vger.kernel.org, x86@kernel.org,
        akpm@linux-foundation.org, eric_devolder@yahoo.com,
        sfr@canb.auug.org.au, ignat@cloudflare.com
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

Hi Baoquan,

On Fri, Dec 8, 2023 at 8:43 AM Baoquan He <bhe@redhat.com> wrote:
> Forgot adding kexec to CC, add it now.
>
> On 12/08/23 at 03:30pm, Baoquan He wrote:
> > The select of KEXEC for CRASH_DUMP in kernel/Kconfig.kexec will be
> > dropped, then compiling errors will be triggered if below config
> > items are set:
> >
> > ===
> > CONFIG_CRASH_CORE=y
> > CONFIG_KEXEC_CORE=y
> > CONFIG_CRASH_DUMP=y
> > ===
> >
> > E.g on mips, below link error are seen:
> > --------------------------------------------------------------------
> > mipsel-linux-ld: kernel/kexec_core.o: in function `kimage_free':
> > kernel/kexec_core.c:(.text+0x2200): undefined reference to `machine_kexec_cleanup'
> > mipsel-linux-ld: kernel/kexec_core.o: in function `__crash_kexec':
> > kernel/kexec_core.c:(.text+0x2480): undefined reference to `machine_crash_shutdown'
> > mipsel-linux-ld: kernel/kexec_core.c:(.text+0x2488): undefined reference to `machine_kexec'
> > mipsel-linux-ld: kernel/kexec_core.o: in function `kernel_kexec':
> > kernel/kexec_core.c:(.text+0x29b8): undefined reference to `machine_shutdown'
> > mipsel-linux-ld: kernel/kexec_core.c:(.text+0x29c0): undefined reference to `machine_kexec'
> > --------------------------------------------------------------------
> >
> > Here, change the incorrect dependency of building kexec_core related object
> > files, and the ifdeffery on architectures from CONFIG_KEXEC to
> > CONFIG_KEXEC_CORE.
> >
> > Testing:
> > ========
> > Passed on mips and loognarch with the LKP reproducer.
> >
> > Baoquan He (5):
> >   loongarch, kexec: change dependency of object files
> >   m68k, kexec: fix the incorrect ifdeffery and build dependency of
> >     CONFIG_KEXEC
> >   mips, kexec: fix the incorrect ifdeffery and dependency of
> >     CONFIG_KEXEC
> >   sh, kexec: fix the incorrect ifdeffery and dependency of CONFIG_KEXEC
> >   x86, kexec: fix the wrong ifdeffery CONFIG_KEXEC

I understand this series is v3 of "[PATCH v2] kexec_core: change
dependency of object files"? As this series does not contain a
changelog, can you please summarize what was changed?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
