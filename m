Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46F37AAD3E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjIVIzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjIVIzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:55:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE77A9;
        Fri, 22 Sep 2023 01:55:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B218CC433C9;
        Fri, 22 Sep 2023 08:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695372943;
        bh=8QkGhwghTGYPhExKboS3z0PsUiDKGGvXCleAsd5SH5o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CjAAOHnW+m8+RDAztDmFbJSI8mdUHvPboMtroHiybyvatO27zYyfR1Wv55g8Fv01I
         te0s9HGkJ0VGUxcVzi6S21q5ZnP3kW3G91E9EzkcgwFh/S+KI1A7tuuEMTGE3HIqBt
         6nRrji+IFh6kZxhnMEpdwcEddc5XEiLgoKEsYESe9+KRFo95Dw/rmUlDTh3/54BTTX
         9KM5MArpAD0s7o4CKVI6Ii4apE868YOc1Vz8d3/fGW7P9s5e+247+f0d/ycaOQufD9
         8mHhukuVVMeyYfCV4bv8fVCeskg+IFFN9ztlmxGPfhc3ExSSu6BsWAGJwgW8ktELWJ
         FSaXLLenObg+g==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-502a4f33440so3234084e87.1;
        Fri, 22 Sep 2023 01:55:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YyoBMjZb8rQESVje9/kRPLVWuTOkCtq5JEZr4gWNmQaTKnELTh/
        rNJEHyctSpE+6kVmt2HO/SEyUHB8fr33pwPeRNw=
X-Google-Smtp-Source: AGHT+IF8cgUepodrWyUy99Ge6z4o9GbKwpmdAjZ3R33ypUsIeilkKxYeO+uhK8l2iNZFEKGHs3hnsEm9jfUciGjro48=
X-Received: by 2002:ac2:5bc5:0:b0:503:79e:fb7b with SMTP id
 u5-20020ac25bc5000000b00503079efb7bmr6817575lfn.68.1695372941964; Fri, 22 Sep
 2023 01:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230918072955.2507221-1-rppt@kernel.org> <20230918072955.2507221-7-rppt@kernel.org>
 <CAPhsuW73NMvdpmyrhGouQSAHEL9wRw_A+8dZ-5R4BU=UHH83cw@mail.gmail.com> <9b73ad3d-cfda-bce5-2589-e8674a58c827@csgroup.eu>
In-Reply-To: <9b73ad3d-cfda-bce5-2589-e8674a58c827@csgroup.eu>
From:   Song Liu <song@kernel.org>
Date:   Fri, 22 Sep 2023 01:55:29 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4_3oYhN6LnPPyBVA4VAM=7voXKmcJNKLqiNEUboq1rnA@mail.gmail.com>
Message-ID: <CAPhsuW4_3oYhN6LnPPyBVA4VAM=7voXKmcJNKLqiNEUboq1rnA@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] mm/execmem: introduce execmem_data_alloc()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        Will Deacon <will@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
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

On Fri, Sep 22, 2023 at 12:17=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 22/09/2023 =C3=A0 00:52, Song Liu a =C3=A9crit :
> > On Mon, Sep 18, 2023 at 12:31=E2=80=AFAM Mike Rapoport <rppt@kernel.org=
> wrote:
> >>
> > [...]
> >> diff --git a/include/linux/execmem.h b/include/linux/execmem.h
> >> index 519bdfdca595..09d45ac786e9 100644
> >> --- a/include/linux/execmem.h
> >> +++ b/include/linux/execmem.h
> >> @@ -29,6 +29,7 @@
> >>    * @EXECMEM_KPROBES: parameters for kprobes
> >>    * @EXECMEM_FTRACE: parameters for ftrace
> >>    * @EXECMEM_BPF: parameters for BPF
> >> + * @EXECMEM_MODULE_DATA: parameters for module data sections
> >>    * @EXECMEM_TYPE_MAX:
> >>    */
> >>   enum execmem_type {
> >> @@ -37,6 +38,7 @@ enum execmem_type {
> >>          EXECMEM_KPROBES,
> >>          EXECMEM_FTRACE,
> >
> > In longer term, I think we can improve the JITed code and merge
> > kprobe/ftrace/bpf. to use the same ranges. Also, do we need special
> > setting for FTRACE? If not, let's just remove it.
>
> How can we do that ? Some platforms like powerpc require executable
> memory for BPF and non-exec mem for KPROBE so it can't be in the same
> area/ranges.

Hmm... non-exec mem for kprobes?

       if (strict_module_rwx_enabled())
               execmem_params.ranges[EXECMEM_KPROBES].pgprot =3D PAGE_KERNE=
L_ROX;
       else
               execmem_params.ranges[EXECMEM_KPROBES].pgprot =3D PAGE_KERNE=
L_EXEC;

Do you mean the latter case?

Thanks,
Song
