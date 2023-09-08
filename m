Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC857991AA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 23:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344043AbjIHVw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 17:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjIHVw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:52:28 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB4EE46
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 14:52:23 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7870821d9a1so1482205241.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 14:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694209942; x=1694814742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m43PrEMsLZP2EQdS/bT6AbnWiwNqqhpPB/h3QciEWyw=;
        b=VTrB+nZucJ1rcPIIFwERlGhyoTr0z8+6rAXXYiWoFUdiaSJFzqaYJp+n7EzxvIstEn
         +3Vs2yAHse0jweIgHROApu7zkShjAHDNa3vDgveFEpMlL1INEsDlF+0yXYhV6SGeHZ9S
         99sTPvFQRlswiD2Nt1aByFF75pa3o7k8TSRro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694209942; x=1694814742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m43PrEMsLZP2EQdS/bT6AbnWiwNqqhpPB/h3QciEWyw=;
        b=BT7blanLnIQkUSZeCIeIKFI22frWTp9FbrSZjr8RNldzNaJV2puPLIu1w74Y8muejA
         TSpeKnekUkYWnkB54FWtdGJ+YTyykhVhS980wqLwIrZskldzez7HZFe9I/gu0FaX3Nho
         NxQWnyyP2wXTG1iizHqUZDL5Rt23QoLzZmGTTPrwzucV084/B4BmjBnqA15nDdlrUDao
         JL7552m45BaQPenmzZWRMxNUZEIeLgf2/A3I87epNMy8yacEt9tqIwJXdjhfo4x3DvR1
         8Nm6p+dpWOwFCJDlPFBqG32Lh40mEF7rAeZxGpAcPnURP+d1m02j0v0wHlGssIfYCdMB
         6Jvw==
X-Gm-Message-State: AOJu0YzmupNeOj7+SY+R8OrGaBljNRBcNGnet8ATLDW/8uNrVdyzBrSh
        4pu/CyIDIL357mYA99SrMooxHLsfqkvKSe/RvLs=
X-Google-Smtp-Source: AGHT+IGyoZwd8V33kv+eZWsKuai4IiCB9GkENwFb/sbZJyTInm+OWRYymctN6SvcrDsQURnCsifWwQ==
X-Received: by 2002:a67:eccf:0:b0:44e:cab7:be2d with SMTP id i15-20020a67eccf000000b0044ecab7be2dmr1719012vsp.7.1694209942030;
        Fri, 08 Sep 2023 14:52:22 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id x22-20020a056102323600b004507f465cd8sm437970vsf.30.2023.09.08.14.52.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 14:52:21 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-44ee1123667so2204467137.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 14:52:21 -0700 (PDT)
X-Received: by 2002:ad4:5f0d:0:b0:651:6604:bee6 with SMTP id
 fo13-20020ad45f0d000000b006516604bee6mr9638376qvb.30.1694209920738; Fri, 08
 Sep 2023 14:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v7-0-b05c520b7296@chromium.org>
 <CAPhsuW5_qAvV0N3o+hOiAnb1=buJ1pLzqYW9D+Bwft6hxJvAeQ@mail.gmail.com>
 <CANiDSCu2YLaXv2DkfzN0GbTF1b79HnqPG=GWqodDr4X9krGjUA@mail.gmail.com> <CAPhsuW5JDPk7ZEthu7cowqp6emQOXsWgSvPM+kvnERPq4RR83w@mail.gmail.com>
In-Reply-To: <CAPhsuW5JDPk7ZEthu7cowqp6emQOXsWgSvPM+kvnERPq4RR83w@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 8 Sep 2023 23:51:47 +0200
X-Gmail-Original-Message-ID: <CANiDSCtbo1ws7hTgeha8+V8g198GN1_NAdWV+9Hi5UZgk0cfUA@mail.gmail.com>
Message-ID: <CANiDSCtbo1ws7hTgeha8+V8g198GN1_NAdWV+9Hi5UZgk0cfUA@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] kexec: Fix kexec_file_load for llvm16 with PGO
To:     Song Liu <song@kernel.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Baoquan He <bhe@redhat.com>,
        Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Simon Horman <horms@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, stable@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song

On Fri, 8 Sept 2023 at 23:48, Song Liu <song@kernel.org> wrote:
>
> Hi Ricardo,
>
> Thanks for your kind reply.
>
> On Fri, Sep 8, 2023 at 2:18=E2=80=AFPM Ricardo Ribalda <ribalda@chromium.=
org> wrote:
> >
> > Hi Song
> >
> > On Fri, 8 Sept 2023 at 01:08, Song Liu <song@kernel.org> wrote:
> > >
> > > Hi Ricardo and folks,
> > >
> > > On Fri, May 19, 2023 at 7:48=E2=80=AFAM Ricardo Ribalda <ribalda@chro=
mium.org> wrote:
> > > >
> > > > When upreving llvm I realised that kexec stopped working on my test
> > > > platform.
> > > >
> > > > The reason seems to be that due to PGO there are multiple .text sec=
tions
> > > > on the purgatory, and kexec does not supports that.
> > > >
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > >
> > > We are seeing WARNINGs like the following while kexec'ing a PGO and
> > > LTO enabled kernel:
> > >
> > > WARNING: CPU: 26 PID: 110894 at kernel/kexec_file.c:919
> > > kexec_load_purgatory+0x37f/0x390
> > >
> > > AFAICT, the warning was added by this set, and it was triggered when
> > > we have many .text sections
> > > in purgatory.ro. The kexec was actually successful. So I wonder
> > > whether we really need the
> > > WARNING here. If we disable LTO (PGO is still enabled), we don't see
> > > the WARNING any more.
> > >
> > > I also tested an older kernel (5.19 based), where we also see many
> > > .text sections with LTO. It
> > > kexec()'ed fine. (It doesn't have the WARN_ON() in
> > > kexec_purgatory_setup_sechdrs).
> >
> > You have been "lucky" that the code has chosen the correct start
> > address, you need to modify the linker script of your kernel to
> > disable PGO.
> > You need to backport a patch like this:
> > https://lore.kernel.org/lkml/CAPhsuW5_qAvV0N3o+hOiAnb1=3DbuJ1pLzqYW9D+B=
wft6hxJvAeQ@mail.gmail.com/T/#md68b7f832216b0c56bbec0c9b07332e180b9ba2b
>
> We already have this commit in our branch. AFAICT, the issue was
> triggered by LTO. So something like the following seems fixes it
> (I haven't finished the end-to-end test yet). Does this change make
> sense to you?

if the end-to-end works, please send it as a patch to the mailing list.

Thanks! :)

>
> Thanks again,
> Song
>
> diff --git i/arch/x86/purgatory/Makefile w/arch/x86/purgatory/Makefile
> index 8f71aaa04cc2..dc306fa7197d 100644
> --- i/arch/x86/purgatory/Makefile
> +++ w/arch/x86/purgatory/Makefile
> @@ -19,6 +19,10 @@ CFLAGS_sha256.o :=3D -D__DISABLE_EXPORTS
>  # optimization flags.
>  KBUILD_CFLAGS :=3D $(filter-out -fprofile-sample-use=3D%
> -fprofile-use=3D%,$(KBUILD_CFLAGS))
>
> +# When LTO is enabled, llvm emits many text sections, which is not suppo=
rted
> +# by kexec. Remove -flto=3D* flags.
> +KBUILD_CFLAGS :=3D $(filter-out -flto=3D%,$(KBUILD_CFLAGS))
> +
>  # When linking purgatory.ro with -r unresolved symbols are not checked,
>  # also link a purgatory.chk binary without -r to check for unresolved sy=
mbols.
>  PURGATORY_LDFLAGS :=3D -e purgatory_start -z nodefaultlib



--=20
Ricardo Ribalda
