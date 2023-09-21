Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057B37AA53B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjIUWwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIUWwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:52:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B66DF7;
        Thu, 21 Sep 2023 15:52:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C784EC433AD;
        Thu, 21 Sep 2023 22:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695336755;
        bh=N+rCKzD4RnGgPH16U+ccWdzVA4uu9GwvbHIaEOV8lLA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bjJNwevJA42TvkguuRjTs76ETN2R6q990VwsQaX+fVZHYFTVg3twcHMCXBi+EwswY
         KDvM3rQnSpp34FNwfM0U/WFpPi5sxiWBihMbkmLQVD3dMwe0w1TV/6pnGa5fK7MnRq
         f/RnmF4zvwavGrTVGR9fsTL6T+hC8QShKMLdwjOkeOLZk0rpJgxA2dFhnnTnVB9Xwk
         TCSjg9WYJ/gz4jSOZ5+6CD4cbsh3pPk93gUBjEKQnbqdin3Ors6QaTCSNo54GO47rs
         GROCJ3RhQnOtTsYPDlxmiEmDKgihH28meWIoUHV/vobKuLSBg7uQPTbsXHKf9QQFkj
         fMbBtTpx4QTiw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50305abe5f0so2439551e87.2;
        Thu, 21 Sep 2023 15:52:35 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy//vzaxhq2PC0z+wVHGEwKZ4Ke1r5YMDZ7obAXNGj3Ajce+ERv
        D+V05edYEmk4pGL+49y5p6NzoHP4lvUy0x6hZ3E=
X-Google-Smtp-Source: AGHT+IHrJYRcXcnBl5OYoAS68DJ303ssKI8aEm5234o+h+Cle34G5bJm6ZjjrxLZlbKjfe5M7kikSCFf7m0lncLYrfA=
X-Received: by 2002:a05:6512:ac7:b0:500:b3e3:6fa6 with SMTP id
 n7-20020a0565120ac700b00500b3e36fa6mr7384141lfu.68.1695336753899; Thu, 21 Sep
 2023 15:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230918072955.2507221-1-rppt@kernel.org> <20230918072955.2507221-7-rppt@kernel.org>
In-Reply-To: <20230918072955.2507221-7-rppt@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 21 Sep 2023 15:52:21 -0700
X-Gmail-Original-Message-ID: <CAPhsuW73NMvdpmyrhGouQSAHEL9wRw_A+8dZ-5R4BU=UHH83cw@mail.gmail.com>
Message-ID: <CAPhsuW73NMvdpmyrhGouQSAHEL9wRw_A+8dZ-5R4BU=UHH83cw@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] mm/execmem: introduce execmem_data_alloc()
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
> diff --git a/include/linux/execmem.h b/include/linux/execmem.h
> index 519bdfdca595..09d45ac786e9 100644
> --- a/include/linux/execmem.h
> +++ b/include/linux/execmem.h
> @@ -29,6 +29,7 @@
>   * @EXECMEM_KPROBES: parameters for kprobes
>   * @EXECMEM_FTRACE: parameters for ftrace
>   * @EXECMEM_BPF: parameters for BPF
> + * @EXECMEM_MODULE_DATA: parameters for module data sections
>   * @EXECMEM_TYPE_MAX:
>   */
>  enum execmem_type {
> @@ -37,6 +38,7 @@ enum execmem_type {
>         EXECMEM_KPROBES,
>         EXECMEM_FTRACE,

In longer term, I think we can improve the JITed code and merge
kprobe/ftrace/bpf. to use the same ranges. Also, do we need special
setting for FTRACE? If not, let's just remove it.

>         EXECMEM_BPF,
> +       EXECMEM_MODULE_DATA,
>         EXECMEM_TYPE_MAX,
>  };

Overall, it is great that kprobe/ftrace/bpf no longer depend on modules.

OTOH, I think we should merge execmem_type and existing mod_mem_type.
Otherwise, we still need to handle page permissions in multiple places.
What is our plan for that?

Thanks,
Song


>
> @@ -107,6 +109,23 @@ struct execmem_params *execmem_arch_params(void);
>   */
>  void *execmem_text_alloc(enum execmem_type type, size_t size);
>
> +/**
> + * execmem_data_alloc - allocate memory for data coupled to code
> + * @type: type of the allocation
> + * @size: how many bytes of memory are required
> + *
> + * Allocates memory that will contain data coupled with executable code,
> + * like data sections in kernel modules.
> + *
> + * The memory will have protections defined by architecture.
> + *
> + * The allocated memory will reside in an area that does not impose
> + * restrictions on the addressing modes.
> + *
> + * Return: a pointer to the allocated memory or %NULL
> + */
> +void *execmem_data_alloc(enum execmem_type type, size_t size);
> +
>  /**
>   * execmem_free - free executable memory
>   * @ptr: pointer to the memory that should be freed
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c4146bfcd0a7..2ae83a6abf66 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1188,25 +1188,16 @@ void __weak module_arch_freeing_init(struct modul=
e *mod)
>  {
>  }
>
> -static bool mod_mem_use_vmalloc(enum mod_mem_type type)
> -{
> -       return IS_ENABLED(CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC) &&
> -               mod_mem_type_is_core_data(type);
> -}
> -
>  static void *module_memory_alloc(unsigned int size, enum mod_mem_type ty=
pe)
>  {
> -       if (mod_mem_use_vmalloc(type))
> -               return vzalloc(size);
> +       if (mod_mem_type_is_data(type))
> +               return execmem_data_alloc(EXECMEM_MODULE_DATA, size);
>         return execmem_text_alloc(EXECMEM_MODULE_TEXT, size);
>  }
>
>  static void module_memory_free(void *ptr, enum mod_mem_type type)
>  {
> -       if (mod_mem_use_vmalloc(type))
> -               vfree(ptr);
> -       else
> -               execmem_free(ptr);
> +       execmem_free(ptr);
>  }
>
>  static void free_mod_mem(struct module *mod)
> diff --git a/mm/execmem.c b/mm/execmem.c
> index abcbd07e05ac..aeff85261360 100644
> --- a/mm/execmem.c
> +++ b/mm/execmem.c
> @@ -53,11 +53,23 @@ static void *execmem_alloc(size_t size, struct execme=
m_range *range)
>         return kasan_reset_tag(p);
>  }
>
> +static inline bool execmem_range_is_data(enum execmem_type type)
> +{
> +       return type =3D=3D EXECMEM_MODULE_DATA;
> +}
> +
>  void *execmem_text_alloc(enum execmem_type type, size_t size)
>  {
>         return execmem_alloc(size, &execmem_params.ranges[type]);
>  }
>
> +void *execmem_data_alloc(enum execmem_type type, size_t size)
> +{
> +       WARN_ON_ONCE(!execmem_range_is_data(type));
> +
> +       return execmem_alloc(size, &execmem_params.ranges[type]);
> +}
> +
>  void execmem_free(void *ptr)
>  {
>         /*
> @@ -93,7 +105,10 @@ static void execmem_init_missing(struct execmem_param=
s *p)
>                 struct execmem_range *r =3D &p->ranges[i];
>
>                 if (!r->start) {
> -                       r->pgprot =3D default_range->pgprot;
> +                       if (execmem_range_is_data(i))
> +                               r->pgprot =3D PAGE_KERNEL;
> +                       else
> +                               r->pgprot =3D default_range->pgprot;
>                         r->alignment =3D default_range->alignment;
>                         r->start =3D default_range->start;
>                         r->end =3D default_range->end;
> --
> 2.39.2
>
