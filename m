Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BE07AA4A7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjIUWNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjIUWN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:13:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42F61BD;
        Thu, 21 Sep 2023 15:10:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5E4C433CB;
        Thu, 21 Sep 2023 22:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695334240;
        bh=N5hdFpyXSiGpYG0511NDyp6fv24cJcs4QSVnP7w1UAU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wvqk0n6jq0ct52sblCUd8L/Xq8+N+SorW8zAWVSuS8RApVD17k7plQRRz/k5AtqcZ
         GfT0CHWwJxWi4gUehtxR+8ljjuQTqjvYKgxWb2XNuVdjKevxRu1ENJFvPX5YXAHSbF
         Ix9CdbGlyzCm8uVsj2Qxltwpt5fiLP3w48irVYCfZTdJDqTfRku6xjijf57j/ZypWU
         97yg0mO2y5J78oLs+yCmKD+nXRc3T+EFcvHppUt3wuFXOaWZdvIvQ4j8dq0mhxHV1+
         hn7FVpnRYo4KhRE7dodDocdh21fQMMb+Di7kRnH5vPdK32pTNVgx3GHtydByNaiHSX
         2EmQpYW6b+alA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5041bb9ce51so2466137e87.1;
        Thu, 21 Sep 2023 15:10:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YxFcVtmEm3oEWo8idFtMNYq2G4WIU9xIxKGAeDSLaC8XzC5nHA6
        A/Os7unXe6c0ie2bw3wFW2fEWkGcW0nssbBNJ5k=
X-Google-Smtp-Source: AGHT+IFpnRd6TFzlAtTmG0SVL+ey3URugDNbqT5vmaLEkxDXDZHK88BxPcak1tSmyXSq9q54rWpyKjCd5XFO26LBHOk=
X-Received: by 2002:a19:6903:0:b0:4fe:2d93:2b50 with SMTP id
 e3-20020a196903000000b004fe2d932b50mr5173357lfc.31.1695334238605; Thu, 21 Sep
 2023 15:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230918072955.2507221-1-rppt@kernel.org> <20230918072955.2507221-3-rppt@kernel.org>
In-Reply-To: <20230918072955.2507221-3-rppt@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 21 Sep 2023 15:10:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4bQY5fo_+K2z4uUdd4r0wYF1eT3bAya=YqcEcmqdGXvg@mail.gmail.com>
Message-ID: <CAPhsuW4bQY5fo_+K2z4uUdd4r0wYF1eT3bAya=YqcEcmqdGXvg@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] mm: introduce execmem_text_alloc() and execmem_free()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nadav Amit <nadav.amit@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 12:30=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
[...]
> +
> +#include <linux/mm.h>
> +#include <linux/vmalloc.h>
> +#include <linux/execmem.h>
> +#include <linux/moduleloader.h>
> +
> +static void *execmem_alloc(size_t size)
> +{
> +       return module_alloc(size);
> +}
> +
> +void *execmem_text_alloc(enum execmem_type type, size_t size)
> +{
> +       return execmem_alloc(size);
> +}

execmem_text_alloc (and later execmem_data_alloc) both take "type" as
input. I guess we can just use execmem_alloc(type, size) for everything?

Thanks,
Song

> +
> +void execmem_free(void *ptr)
> +{
> +       /*
> +        * This memory may be RO, and freeing RO memory in an interrupt i=
s not
> +        * supported by vmalloc.
> +        */
> +       WARN_ON(in_interrupt());
> +       vfree(ptr);
> +}
> --
> 2.39.2
>
