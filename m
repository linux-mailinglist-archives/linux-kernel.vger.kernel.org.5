Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C627536AF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbjGNJez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbjGNJes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:34:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672673C26
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:34:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FDB461C99
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA23C43395
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689327237;
        bh=zkKlNfArEF4ArjwsLDxjgeIohO7hLPIxQWb5Efn6wOI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q2WZbnXwBL+HOhFnDmu6Pno380v/gZyTJ5OORKdbsoWTFB0ddj8YIIC+Ai/H0OFKQ
         YkPfk7ZLVsjAqlWo+Ff+yy5+1rrfsxnmXadu5J7F8++MP3agT6MjgtKVyPTBARWxTE
         CrgdG3OE/cjxdkHBLQj50tqVISN+Bw0BOwRqZnv1u+LGG2RwM1ePNRspNR2HaRayNN
         Yc0fQjYOvwYxO7FunMNzWQ34BJ9evWNHs8mnH40xCKcP94Qpv9Gv4ZX/zUJSx6i7JU
         G46KCbCtWYyeawJ7ns6UlWuxF2adNCbPp1iQPHoGbjZcbP4jrzZRsz5il4KHZuOucD
         zczEwfTdoK/xw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b701e1c80fso24876031fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:33:57 -0700 (PDT)
X-Gm-Message-State: ABy/qLYLr+AssZMzQWmDlK/SVmY4657o5rU2MsTCqzIha1gff6NkNuA/
        kQW5jjqQh4i5TZBRF7/D+Z+oCo0KYIEN3Kjw640=
X-Google-Smtp-Source: APBJJlGNio41U6FPBe9mxJYollC6yuPDIu2a2vDnkbUCB9J0Ff4QupILS9m1gUtlsFC6n6bd+FZdEkf5VFolsluxu8Y=
X-Received: by 2002:a2e:7a17:0:b0:2b6:e7c7:b039 with SMTP id
 v23-20020a2e7a17000000b002b6e7c7b039mr3509445ljc.28.1689327235427; Fri, 14
 Jul 2023 02:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230711154449.1378385-1-eesposit@redhat.com> <ZK/9MlTh435FP5Ji@gambale.home>
 <CAMw=ZnRQ0qNg0hT27DWvfZ1DH3dLdu0U7zYN8HvJDx7NPVy_pQ@mail.gmail.com>
In-Reply-To: <CAMw=ZnRQ0qNg0hT27DWvfZ1DH3dLdu0U7zYN8HvJDx7NPVy_pQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 14 Jul 2023 11:33:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEAmsLM0kXLyjRX5bK3b0EzRCGBkUq2DdXknLhwDc7Krg@mail.gmail.com>
Message-ID: <CAMj1kXEAmsLM0kXLyjRX5bK3b0EzRCGBkUq2DdXknLhwDc7Krg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
To:     Luca Boccassi <bluca@debian.org>
Cc:     Emanuele Giuseppe Esposito <eesposit@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 at 01:13, Luca Boccassi <bluca@debian.org> wrote:
>
> On Thu, 13 Jul 2023 at 14:33, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Hello Emanuele,
> >
> > Please cc the linux-efi@ mailing list and myself on EFI related patches.
> >
> > First of all, I think the tone of the discussion is way out of hand on
> > both sides of the debate. Please keep it civil and courteous.
>
> I appreciate the attempt, but sorry, it's not cool to try and
> both-side things here. The original submission was not aggressive,
> insulting or in any way out of line, it's clearly marked as an RFC and
> the FIRST LINE was:
>
> "*Important*: this is just an RFC, as I am not expert in this area and
> I don't know what's the best way to achieve this."
>
> which is as friendly and humble as one can be. And yet, not one, not
> two, but three maintainers have decided that the best way to respond
> to something like that is to spew bile, toxicity and aggressivity,
> which was completely and utterly uncalled for.

I completely agree.

> So, if you want to call
> someone out (you should), please direct that towards your fellow
> maintainers, who in theory should be setting a good example and
> productively directing the discourse, but instead, once again, have
> only succeeded in ensuring that the lkml lives up to its fame of being
> an open sewer.
>

While I understand your frustration, the tone of your replies is not
helping either, so I am directing this to you as well. Let's be the
adults in the room, shall we?

> > On Tue, Jul 11, 2023 at 11:44:49AM -0400, Emanuele Giuseppe Esposito wrote:
> > > *Important*: this is just an RFC, as I am not expert in this area and
> > > I don't know what's the best way to achieve this.
> > >
> > > v2:
> > > * add standard "sbat,1,SBAT Version,..." header string
> > >
> > > The aim of this patch is to add a .sbat section to the linux binary
> > > (https://github.com/rhboot/shim/blob/main/SBAT.md).
> > > We mainly need SBAT in UKIs (Unified Kernel Images), as we might want
> > > to revoke authorizations to specific signed PEs that were initially
> > > considered as trusted. The reason might be for example a security issue
> > > related to a specific linux release.
> > >
> > > A .sbat is simply a section containing a string with the component name
> > > and a version number. This version number is compared with the value in
> > > OVMF_VARS, and if it's less than the variable, the binary is not trusted,
> > > even if it is correctly signed.
> > >
> >
> > Most people will not known what OVMF_VARS is or a PE.
> >
> > Also, 'version number' is a bit vague, better to stick with existing
> > terminology that makes this more self explanatory: the component that
> > authenticates the kernel image keeps a revocation counter, and refuses
> > to load authentic images whose revocation index is lower than the
> > revocation counter. This approach removes the need for revoking
> > individual image hashes or having to rotate the signing keys when a
> > vulnerability is discovered.
> >
> > The argument that we need this in the upstream kernel seems to be
> > predicated on the assumption that there is one universal signing
> > authority and revocation domain, but this is not necessarily true. Even
> > if the distros appear to have decided that it is a reasonable choice to
> > deploy the MicroSoft signed shim and the associated components on other
> > systems than Windows-crippled x86 PCs, this is not universally true, and
> > UEFI secure boot can be (and is) deployed in sane ways as well.
>
> There is no other solution for the current revision of the spec (and
> I'm pretty sure this aspect won't change in future ones either), for
> 'public' signing it's just Shim and the 3party CA. Of course for
> individual/internal/scoped deployment there is self signing, but
> that's out of scope of any of this and it couldn't be otherwise, and
> that's ok. But it's not some obscure corner case: the default for
> every generalist distro that boots on uefi machines is by using Shim.
> If there's any use case that matters, it's this one. But even that's
> not the main reason it's a good idea to store the generation id here.
>
> > Therefore, I don't think it makes sense for the upstream kernel source
> > to carry a revocation index. It is ultimately up to the owner of the
> > signing key to decide which value gets signed along with the image, and
> > this is fundamentally part of the configure/build/release workflow.  No
> > distro builds and signs the upstream sources unmodified, so each signed
> > release is a fork anyway, making a upstream revocation index almost
> > meaningless. Also, while backporting revocation index bumps to -stable
> > should not result in any issues, I don't think the associated
> > bookkeeping belongs in the hands of the stable tree maintainers.
>
> The reason it's a good idea to store it here is because otherwise
> there would need to be another external "registry" that matches 1:1,
> and that is maintained identical everywhere, perfectly in sync,
> forever, and any 'new' distro and/or distro maintainer would have to
> discover and use that registry, and would be completely oblivious to
> it otherwise.
>

But why does there need to be a single, shared upstream 'generation
id' in the first place? The upstream is just a bunch of source files
that can be built in a million different ways, including for different
architectures that can all boot via EFI.

To me, being able to revoke a signed release by means of a revocation
counter makes perfect sense. What doesn't make sense is the need for
two or more counters to describe the same entity.

> It would be much more work for those actually doing the work, and it
> wouldn't make any meaningful differences to those who don't care about
> the use case. AFAIK nobody has suggested that it's kernel maintainers
> who need to worry about the generation id and do the bookkeeping, if
> they don't care. I mean I'm pretty sure every help is welcome, but
> that should be it.
>
> The 'owner of the signing key' is not good enough, because there are
> many of those - as you know, the kernel is signed by each distro. But
> the key here is that the revocation is _global_ (again: global means
> it applies to everyone using shim signed by 3rd party CA), so each
> distro storing their own id defeats the purpose of that.

But this kernel is never signed by the key that signs shim. Each
distro has its own set of keys to sign releases of their kernel forks.
So what is the relevance of shim being signed by the MS 3rd party UEFI
CA certificate here?

In fact, it would make me *much* happier if shim was not mentioned at
all, and someone could explain why this facility has value if you are
not using shim in the first place. I'd much prefer to, e.g., have a
Debian top-level cert in KEK, so it could store its per-release
signing keys in db, and revoke those (if needed) via dbx. Could SBAT
play a role in such a context as well?

shim and its GRUB integration have been an endless source of problems
with EFI boot on non-x86 architectures, so arguing that something is
needed by shim is not very convincing to me, and generally implies
that the distros should be owning it instead.

> There is
> space in the spec for distro-specific revocations, but that's intended
> for distro-specific _additions_, like for example a lot of the
> mok/lockdown used to be - thankfully most of that is upstream now, so
> it mostly applies to grub these days, which is the most
> downstream-patched component in the stack from the point of view of
> the boot chain.

I think those distro-specific revocation counters are the right place for this.
