Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2A379919D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 23:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344621AbjIHVst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 17:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjIHVsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:48:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1E6E45;
        Fri,  8 Sep 2023 14:48:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5A1C433CB;
        Fri,  8 Sep 2023 21:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694209723;
        bh=qBwdoqG1zVNvc3aShF3LCnCCMv6kyB9Wvl1DSPjBmKw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LqG7JSNNHl+a3C2tdjmPUc9f+8/khnICP8q4+BvKP5FKdIDnR/LmnN52cpmtm4/En
         c+mB3XAArArl1U0cANr+93qYmxPCfT+QgMTgj9crX+VOHaBTTmkMbj9ZDki6LYqlco
         B1bgBOBB9sNIqUcU6fL3ksC8O/U6TH+70GIerdNCSOy7AS2A1d43bWdjXh3MUTdq+I
         o62BFsJF4qePewmmtcAne07plHKcz//DOrSnDygR6Pexulzedzai//lVNheY+fRT5a
         MFHocLxOf9a/PrIxIvvM/kVelIqEeSuteQLm+7+9VcHomVhSTofM4DFw95PniUISQm
         GH8iwLG4xBdaQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5007616b756so4146503e87.3;
        Fri, 08 Sep 2023 14:48:43 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzl6uPjQkVvp0Y73x3dBoJhUDagnvaXMoaSAK8XcnTsvpfJ9i1Z
        m6QcGbCgdTdmsQljnzwIB4eIj15rImX2comwVHU=
X-Google-Smtp-Source: AGHT+IHdt83V5zkWEI/zYp4eQdKOInBkQ/fcJo2LzCdTQtPBOg8u/Zxe/xPeFmYww3NGkOx3GITH5AX6OshJOu4NSCM=
X-Received: by 2002:a05:6512:3a87:b0:4fb:8bab:48b6 with SMTP id
 q7-20020a0565123a8700b004fb8bab48b6mr3731344lfu.52.1694209722018; Fri, 08 Sep
 2023 14:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v7-0-b05c520b7296@chromium.org>
 <CAPhsuW5_qAvV0N3o+hOiAnb1=buJ1pLzqYW9D+Bwft6hxJvAeQ@mail.gmail.com> <CANiDSCu2YLaXv2DkfzN0GbTF1b79HnqPG=GWqodDr4X9krGjUA@mail.gmail.com>
In-Reply-To: <CANiDSCu2YLaXv2DkfzN0GbTF1b79HnqPG=GWqodDr4X9krGjUA@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 8 Sep 2023 14:48:29 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5JDPk7ZEthu7cowqp6emQOXsWgSvPM+kvnERPq4RR83w@mail.gmail.com>
Message-ID: <CAPhsuW5JDPk7ZEthu7cowqp6emQOXsWgSvPM+kvnERPq4RR83w@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] kexec: Fix kexec_file_load for llvm16 with PGO
To:     Ricardo Ribalda <ribalda@chromium.org>
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

Hi Ricardo,

Thanks for your kind reply.

On Fri, Sep 8, 2023 at 2:18=E2=80=AFPM Ricardo Ribalda <ribalda@chromium.or=
g> wrote:
>
> Hi Song
>
> On Fri, 8 Sept 2023 at 01:08, Song Liu <song@kernel.org> wrote:
> >
> > Hi Ricardo and folks,
> >
> > On Fri, May 19, 2023 at 7:48=E2=80=AFAM Ricardo Ribalda <ribalda@chromi=
um.org> wrote:
> > >
> > > When upreving llvm I realised that kexec stopped working on my test
> > > platform.
> > >
> > > The reason seems to be that due to PGO there are multiple .text secti=
ons
> > > on the purgatory, and kexec does not supports that.
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >
> > We are seeing WARNINGs like the following while kexec'ing a PGO and
> > LTO enabled kernel:
> >
> > WARNING: CPU: 26 PID: 110894 at kernel/kexec_file.c:919
> > kexec_load_purgatory+0x37f/0x390
> >
> > AFAICT, the warning was added by this set, and it was triggered when
> > we have many .text sections
> > in purgatory.ro. The kexec was actually successful. So I wonder
> > whether we really need the
> > WARNING here. If we disable LTO (PGO is still enabled), we don't see
> > the WARNING any more.
> >
> > I also tested an older kernel (5.19 based), where we also see many
> > .text sections with LTO. It
> > kexec()'ed fine. (It doesn't have the WARN_ON() in
> > kexec_purgatory_setup_sechdrs).
>
> You have been "lucky" that the code has chosen the correct start
> address, you need to modify the linker script of your kernel to
> disable PGO.
> You need to backport a patch like this:
> https://lore.kernel.org/lkml/CAPhsuW5_qAvV0N3o+hOiAnb1=3DbuJ1pLzqYW9D+Bwf=
t6hxJvAeQ@mail.gmail.com/T/#md68b7f832216b0c56bbec0c9b07332e180b9ba2b

We already have this commit in our branch. AFAICT, the issue was
triggered by LTO. So something like the following seems fixes it
(I haven't finished the end-to-end test yet). Does this change make
sense to you?

Thanks again,
Song

diff --git i/arch/x86/purgatory/Makefile w/arch/x86/purgatory/Makefile
index 8f71aaa04cc2..dc306fa7197d 100644
--- i/arch/x86/purgatory/Makefile
+++ w/arch/x86/purgatory/Makefile
@@ -19,6 +19,10 @@ CFLAGS_sha256.o :=3D -D__DISABLE_EXPORTS
 # optimization flags.
 KBUILD_CFLAGS :=3D $(filter-out -fprofile-sample-use=3D%
-fprofile-use=3D%,$(KBUILD_CFLAGS))

+# When LTO is enabled, llvm emits many text sections, which is not support=
ed
+# by kexec. Remove -flto=3D* flags.
+KBUILD_CFLAGS :=3D $(filter-out -flto=3D%,$(KBUILD_CFLAGS))
+
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symb=
ols.
 PURGATORY_LDFLAGS :=3D -e purgatory_start -z nodefaultlib
