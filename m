Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C500799280
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 00:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344491AbjIHWxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 18:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242563AbjIHWxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:53:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038CA1FEB;
        Fri,  8 Sep 2023 15:53:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A35CC433CA;
        Fri,  8 Sep 2023 22:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694213597;
        bh=KwM170Ct57lq4vNZ7xSkyIS4SWaJogcjmhutnsYYUvg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a6zALJdvJybZVN96yoS6EZ96AEPRkZIR3J4RfcotR605O+NAX+wNKtlhCkZ7m2Znv
         i6V/2X6pYg8E2vdc8LrkEoB0MIWoQalZNAUvZZgx+xmYcneTNW67WcPF/2ajJ7qFwi
         nSTyEdorTmAO+3CGT756wTHvIJ17mSEY9Xosqq7i1j7WrM7VgfKCpBQeF3kXj07jwc
         a/fA1MYPF1Zxm0UHR0htujt2KUCICJdTImw6i0KfsNo2VMYYWssP1ipoZSdLAWlQlq
         ijTEdEIp1PjWQuUEsWufaNPGDnt3zZBiGsfrWPOjprVAWSSXuYVBIBBYCypgu9egun
         AyVyrYTuWbNAw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5007abb15e9so4334362e87.0;
        Fri, 08 Sep 2023 15:53:17 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxx0yV0dLIX7sk2urXKR80RiEC6xr5E43zBchKjwTFP6FdP5ooU
        q4L7+wscFyqO2/aWO8OY60RNugzED9fkcqLszQk=
X-Google-Smtp-Source: AGHT+IFxzWHrgwn9Er+VZvUvTkc7+KPn5VFwMJdiU1jtuP4KYojqei7vjyha6oz515UbclFjbQ87OxJGnp5Vhfvbj6U=
X-Received: by 2002:ac2:4bc5:0:b0:4fe:7e1f:766a with SMTP id
 o5-20020ac24bc5000000b004fe7e1f766amr3386244lfq.24.1694213595847; Fri, 08 Sep
 2023 15:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v7-0-b05c520b7296@chromium.org>
 <CAPhsuW5_qAvV0N3o+hOiAnb1=buJ1pLzqYW9D+Bwft6hxJvAeQ@mail.gmail.com>
 <CANiDSCu2YLaXv2DkfzN0GbTF1b79HnqPG=GWqodDr4X9krGjUA@mail.gmail.com>
 <CAPhsuW5JDPk7ZEthu7cowqp6emQOXsWgSvPM+kvnERPq4RR83w@mail.gmail.com> <CANiDSCtbo1ws7hTgeha8+V8g198GN1_NAdWV+9Hi5UZgk0cfUA@mail.gmail.com>
In-Reply-To: <CANiDSCtbo1ws7hTgeha8+V8g198GN1_NAdWV+9Hi5UZgk0cfUA@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 8 Sep 2023 15:53:02 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7N2ZxO5KubvK4O7EganpGeFFMtx4JGE9sGO5OnzWscgg@mail.gmail.com>
Message-ID: <CAPhsuW7N2ZxO5KubvK4O7EganpGeFFMtx4JGE9sGO5OnzWscgg@mail.gmail.com>
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

On Fri, Sep 8, 2023 at 2:52=E2=80=AFPM Ricardo Ribalda <ribalda@chromium.or=
g> wrote:
>
> Hi Song
>
> On Fri, 8 Sept 2023 at 23:48, Song Liu <song@kernel.org> wrote:
> >
> > Hi Ricardo,
> >
> > Thanks for your kind reply.
> >
> > On Fri, Sep 8, 2023 at 2:18=E2=80=AFPM Ricardo Ribalda <ribalda@chromiu=
m.org> wrote:
> > >
> > > Hi Song
> > >
> > > On Fri, 8 Sept 2023 at 01:08, Song Liu <song@kernel.org> wrote:
> > > >
> > > > Hi Ricardo and folks,
> > > >
> > > > On Fri, May 19, 2023 at 7:48=E2=80=AFAM Ricardo Ribalda <ribalda@ch=
romium.org> wrote:
> > > > >
> > > > > When upreving llvm I realised that kexec stopped working on my te=
st
> > > > > platform.
> > > > >
> > > > > The reason seems to be that due to PGO there are multiple .text s=
ections
> > > > > on the purgatory, and kexec does not supports that.
> > > > >
> > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > >
> > > > We are seeing WARNINGs like the following while kexec'ing a PGO and
> > > > LTO enabled kernel:
> > > >
> > > > WARNING: CPU: 26 PID: 110894 at kernel/kexec_file.c:919
> > > > kexec_load_purgatory+0x37f/0x390
> > > >
> > > > AFAICT, the warning was added by this set, and it was triggered whe=
n
> > > > we have many .text sections
> > > > in purgatory.ro. The kexec was actually successful. So I wonder
> > > > whether we really need the
> > > > WARNING here. If we disable LTO (PGO is still enabled), we don't se=
e
> > > > the WARNING any more.
> > > >
> > > > I also tested an older kernel (5.19 based), where we also see many
> > > > .text sections with LTO. It
> > > > kexec()'ed fine. (It doesn't have the WARN_ON() in
> > > > kexec_purgatory_setup_sechdrs).
> > >
> > > You have been "lucky" that the code has chosen the correct start
> > > address, you need to modify the linker script of your kernel to
> > > disable PGO.
> > > You need to backport a patch like this:
> > > https://lore.kernel.org/lkml/CAPhsuW5_qAvV0N3o+hOiAnb1=3DbuJ1pLzqYW9D=
+Bwft6hxJvAeQ@mail.gmail.com/T/#md68b7f832216b0c56bbec0c9b07332e180b9ba2b
> >
> > We already have this commit in our branch. AFAICT, the issue was
> > triggered by LTO. So something like the following seems fixes it
> > (I haven't finished the end-to-end test yet). Does this change make
> > sense to you?
>
> if the end-to-end works, please send it as a patch to the mailing list.
>
> Thanks! :)

OK, it works (AFAICT). Sending the patch.

Thanks,
Song
