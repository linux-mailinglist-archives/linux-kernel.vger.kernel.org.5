Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C527AA4B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjIUWP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjIUWPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:15:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671A999;
        Thu, 21 Sep 2023 15:15:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFB4C433B6;
        Thu, 21 Sep 2023 22:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695334508;
        bh=j+YpilMLGCC5ERDcgjdZY/UEYbvSwBxJ4mCRlrG3+go=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L+gPhURipQCVv5lQ6lMZEeHafe2Map2Z3SouhfPMvOq3LIN5npAvywgTLrdsrYoDw
         lcSQt8Ka8fmcf1d8ZM8qIlXPNumlpX3JZKdESMC/KpenaIBv7uGMi+LUkvfCfO+Vlt
         Ms3BphwgqclEjVmwfHiEkkrb7+Ta8zh3Ag+RqoFwGGlsIzXfHKrtVOjxsaXB9alIhH
         JK+MwyCKXlDL+alHW9KkokkF6FFQuanhqMW2Sdmh2NRZkCVnTo9ppIcJLwe1SwZkYz
         JQdTcMm4ZdnaSVT+CVcsNzzz7DKO5EXfQ9zO0FIrMF11/hIqK2vZeqyr2ZUZVULtBX
         NHK7vuo8iml0w==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50337b43ee6so2384844e87.3;
        Thu, 21 Sep 2023 15:15:08 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz6LQ7OFX4l8PRAF6m5TPSjW+jAccwG8ucpwcrP41ii8KG8riIo
        p5zrHoy/uro0IDaCuObv8tfVteYpmks0JnVOHoE=
X-Google-Smtp-Source: AGHT+IEOsdVYa+3bdtK+lEO/ooz4+HKzafq7xPbE1njdx3C8+57KFx3hJ2XTTULe0kNONSMtwPONNYKDgjY7yPaLcMU=
X-Received: by 2002:a05:6512:3254:b0:503:1c07:f7f9 with SMTP id
 c20-20020a056512325400b005031c07f7f9mr5552939lfr.29.1695334506735; Thu, 21
 Sep 2023 15:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230918072955.2507221-1-rppt@kernel.org> <20230918072955.2507221-3-rppt@kernel.org>
In-Reply-To: <20230918072955.2507221-3-rppt@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 21 Sep 2023 15:14:54 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7y2T+tajK71NfYhquhGJKpLpL+EoxxzqrVhEuAamDH3w@mail.gmail.com>
Message-ID: <CAPhsuW7y2T+tajK71NfYhquhGJKpLpL+EoxxzqrVhEuAamDH3w@mail.gmail.com>
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
> +/**
> + * enum execmem_type - types of executable memory ranges
> + *
> + * There are several subsystems that allocate executable memory.
> + * Architectures define different restrictions on placement,
> + * permissions, alignment and other parameters for memory that can be us=
ed
> + * by these subsystems.
> + * Types in this enum identify subsystems that allocate executable memor=
y
> + * and let architectures define parameters for ranges suitable for
> + * allocations by each subsystem.
> + *
> + * @EXECMEM_DEFAULT: default parameters that would be used for types tha=
t
> + * are not explcitly defined.
> + * @EXECMEM_MODULE_TEXT: parameters for module text sections
> + * @EXECMEM_KPROBES: parameters for kprobes
> + * @EXECMEM_FTRACE: parameters for ftrace
> + * @EXECMEM_BPF: parameters for BPF
> + * @EXECMEM_TYPE_MAX:
> + */
> +enum execmem_type {
> +       EXECMEM_DEFAULT,

I found EXECMEM_DEFAULT more confusing than helpful.

Song

> +       EXECMEM_MODULE_TEXT =3D EXECMEM_DEFAULT,
> +       EXECMEM_KPROBES,
> +       EXECMEM_FTRACE,
> +       EXECMEM_BPF,
> +       EXECMEM_TYPE_MAX,
> +};
> +
[...]
