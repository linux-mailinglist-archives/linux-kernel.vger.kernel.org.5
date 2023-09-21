Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5FD7AA516
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjIUWbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIUWbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:31:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB3391;
        Thu, 21 Sep 2023 15:31:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC786C433CD;
        Thu, 21 Sep 2023 22:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695335460;
        bh=MM21fpAAqNycTt4Xaf9NDcGQ0SQTcft6//RqlmbkVyQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BJxXZzf/aXubyQy2npZARHLDDjhgoXgiIEWqva3Fcvcj9zcoZxEU8fccdvHJ+HE1c
         zzl8qTcUY9d4Go4O1phE4VHiUrxF82TprIMut63M6/i0lBXABCB/bZlTOwWqPbu1BQ
         q5zu/0Z8B9EGkvCak3DZShCJdshYKc/r/AcXEeYIu2QyWVYI9Vx+BhQ1n26cL4/b0+
         PS4cfkMveOYxyjpv6hbMeZ6FHOjVVnzGDFbwXlAgoIyH9v7qk7z8sPhWkYP6GlWWax
         6oJu48Ae0Rkgt9SjGUY0GxlfVZDTstOKna+Ts701hrySxm3sOn2mvMBH6VjZ4iOt+Q
         WLPXTkK17R7VA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50337b43ee6so2400559e87.3;
        Thu, 21 Sep 2023 15:31:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YwJ80atVQpPwKTRF29CYxJEvthpXSCSKKKNW/fjVvmDib0yO3aJ
        pd4b/1HM4ExSD3usFq4LwbrZRDCDzrhHjZ27SQQ=
X-Google-Smtp-Source: AGHT+IH8pmyQuqpvewRyL7QPTAL4jcebA+VNDdobgdjzXZOsPDkVCcZQaQNB105RzqTdIxkf8GblFKytjbdsRKyccPQ=
X-Received: by 2002:a05:6512:10c4:b0:500:7f71:e46b with SMTP id
 k4-20020a05651210c400b005007f71e46bmr7439120lfg.1.1695335458957; Thu, 21 Sep
 2023 15:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230918072955.2507221-1-rppt@kernel.org> <20230918072955.2507221-10-rppt@kernel.org>
In-Reply-To: <20230918072955.2507221-10-rppt@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 21 Sep 2023 15:30:46 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5Vg7yDn8zb5ez4JY4efoQ6aW+vYm9OL+Xr0NJnLfMYHg@mail.gmail.com>
Message-ID: <CAPhsuW5Vg7yDn8zb5ez4JY4efoQ6aW+vYm9OL+Xr0NJnLfMYHg@mail.gmail.com>
Subject: Re: [PATCH v3 09/13] powerpc: extend execmem_params for kprobes allocations
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

On Mon, Sep 18, 2023 at 12:31=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
[...]
> @@ -135,5 +138,13 @@ struct execmem_params __init *execmem_arch_params(vo=
id)
>
>         range->pgprot =3D prot;
>
> +       execmem_params.ranges[EXECMEM_KPROBES].start =3D VMALLOC_START;
> +       execmem_params.ranges[EXECMEM_KPROBES].start =3D VMALLOC_END;

.end =3D VMALLOC_END.

Thanks,
Song

> +
> +       if (strict_module_rwx_enabled())
> +               execmem_params.ranges[EXECMEM_KPROBES].pgprot =3D PAGE_KE=
RNEL_ROX;
> +       else
> +               execmem_params.ranges[EXECMEM_KPROBES].pgprot =3D PAGE_KE=
RNEL_EXEC;
> +
>         return &execmem_params;
>  }
> --
> 2.39.2
>
>
