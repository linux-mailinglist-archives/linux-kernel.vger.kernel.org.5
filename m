Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAF57AE63B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjIZGrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjIZGrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:47:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E5CF0;
        Mon, 25 Sep 2023 23:47:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B431C433C9;
        Tue, 26 Sep 2023 06:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695710852;
        bh=EpiMNFOkYkDOeMwbYg/ulEJB/BqynJtMsZS3NTt9cNk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tyt0CDhTAcvO8jkf0Y+qTkM3gD7vsNHS4Sfv4nb88M9oZOlQDg+bumEwn3rg8jeeq
         le2o9tlQHVZn+gVyxEvt++HJCb+xynuNIAx+uebkCetr0OBqjIwh8Ad/Ewli9yHc4U
         uWDIse6RlWT3DPrI4d46jT/2YucQeuVsJM6m76p7pjj+X6mZf4kkwv3bPa1MtijDbd
         g8yY8Fi+58RAb7cS9HYBRsHGa6nG1orTTgHEbpYyaWOfYmZQsJ8YgyHGd0+ecdjiiM
         42/bZZ+pb2p9TrsAtlnpV0Wc81RaEPEMMw/x8T+K6hTpXRN2ReRTnqO/6MPd2+xjmF
         7Vvc/VQbAt4Hw==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3ae55c2e12bso325526b6e.0;
        Mon, 25 Sep 2023 23:47:32 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzs1B/YDZBXT6FjusZTbhcHmqnEyBoepgogWIs8SPLmnerZ3Gdx
        yT2W+Er2Yandt3ww/ROK1tnzsGaGMFkSD2YumRM=
X-Google-Smtp-Source: AGHT+IF3+503yqRdlbZyIRHn/ymw+oUqCL66Ups8UAnN04Ljl5HJjVNQIj6RFfBSjDsY/evEZl6HTU2QNeYqSI5In9E=
X-Received: by 2002:a05:6870:a901:b0:1b7:670e:ad7a with SMTP id
 eq1-20020a056870a90100b001b7670ead7amr10629531oab.43.1695710851933; Mon, 25
 Sep 2023 23:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230918210631.3882376-1-jbrennen@google.com> <20230925205933.2869049-1-jbrennen@google.com>
In-Reply-To: <20230925205933.2869049-1-jbrennen@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 26 Sep 2023 15:46:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNARd_pRWWso49C4MoahFAM9idyOFC+9ZFYdpS87CA4UTqQ@mail.gmail.com>
Message-ID: <CAK7LNARd_pRWWso49C4MoahFAM9idyOFC+9ZFYdpS87CA4UTqQ@mail.gmail.com>
Subject: Re: [PATCH] modpost: Optimize symbol search from linear to binary search
To:     Jack Brennen <jbrennen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, maskray@google.com, cleger@rivosinc.com,
        kernel-team@android.com, Joe Perches <joe@perches.com>
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

On Tue, Sep 26, 2023 at 5:59=E2=80=AFAM Jack Brennen <jbrennen@google.com> =
wrote:

> +Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
> +                               unsigned int secndx, bool allow_negative,
> +                               Elf_Addr min_distance)
> +{
> +       size_t hi =3D elf->symsearch->table_size;
> +       size_t lo =3D 0;
> +       struct syminfo *table =3D elf->symsearch->table;
> +       struct syminfo target;
> +
> +       target.addr =3D addr;
> +       target.section_index =3D secndx;
> +       target.symbol_index =3D ~0;  /* compares greater than any actual =
index */
> +       while (hi > lo) {
> +               size_t mid =3D lo + (hi-lo)/2;   /* Avoids potential over=
flow */
> +
> +               if (syminfo_compare(&table[mid], &target) > 0)
> +                       hi =3D mid;
> +               else
> +                       lo =3D mid+1;


My preference is "low =3D mid + 1" over "low =3D mid+1"


Documentation/process/coding-style.rst suggests spaces
around binary operators.

"
Use one space around (on each side of) most binary and ternary operators,
such as any of these::

        =3D  +  -  <  >  *  /  %  |  &  ^  <=3D  >=3D  =3D=3D  !=3D  ?  :
"




I can see the corresponding line in the checkpatch tool:

https://github.com/torvalds/linux/blob/v6.5/scripts/checkpatch.pl#L5330


I wonder why the checkpatch did not detect it.

Maybe, Joe Perches may know the reason.







My previous question about the type inconsistency
was not addressed.

syminfo::symbol_index is unsigned int
symsearch::table_size is size_t


If we encountered a situation where size_t is
really needed for the table_size
(that is, the number of entries does not fit in 32-bit),
syminfo::symbol_index would wrap around.

So, there is no point to use size_t for one,
and (unsigned int) for the other.


In my opinion, (unsigned int) would be enough to count
numbers or index here.

size_t might be 32-bit or 64-bit depending
on the build host architecture.
That is not related to the target architecture
of ELF being processed.




--
Best Regards
Masahiro Yamada
