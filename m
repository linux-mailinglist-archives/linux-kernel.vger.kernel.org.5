Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDA6783B11
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjHVHiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjHVHir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:38:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B7F180;
        Tue, 22 Aug 2023 00:38:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A58464E8B;
        Tue, 22 Aug 2023 07:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F27C433C7;
        Tue, 22 Aug 2023 07:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692689924;
        bh=MQApJLZQiaBacJ4HEhPwClptAaaYHhUax1QrCn1x/QU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f4JjroqsUXa2UiQzAA75eu6sfBbBGSnL4i407W5Wi1jaPRIWtBP/i/iovGj52Gw22
         0mtjsnnut5yKEkBPhTn7HO5x90LiFtiBgfdb0HN9bJgof1VK+l4H4M+60GR4dzsdN3
         78W6jMp8AjWabTPjMyG+rOPN3dcIw37AVLrQL9aikpLefGzmVei9SJHBIKnYaT2dsT
         WCDbUXEpkzsS8tyRPi+QahH0ZDmJveXTnk0W/0XI9aupZvHDLMMUNUYcnk4PjLffAn
         06Ej3pV/XXPDrQPG6vKETeJViF44NY9llRbRn9Io0z/2r6/HjWu/0zTu9b3H7zghMZ
         gCodYv9hfTtSg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-99bed101b70so537887966b.3;
        Tue, 22 Aug 2023 00:38:44 -0700 (PDT)
X-Gm-Message-State: AOJu0YzAN6gvfI1Hs5k0uu+FiTww/eTVu0fMVDdbdx/amZkInwas/8P5
        idsCXAoQcOsiGSO4ofpag112fVDzJOUNx7f5FuY=
X-Google-Smtp-Source: AGHT+IFeQcZOpwE6raVQDpcJai88whutUSVSAJtQXW+xYm3E60ZUi/wwmbgZqJMrc3ZPiHkNvc06ZHSrWPKjGQLfkfo=
X-Received: by 2002:a17:906:73dc:b0:9a1:bd82:de24 with SMTP id
 n28-20020a17090673dc00b009a1bd82de24mr498348ejl.12.1692689922984; Tue, 22 Aug
 2023 00:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <1692434183-2054-1-git-send-email-yangtiezhu@loongson.cn>
 <1692434183-2054-4-git-send-email-yangtiezhu@loongson.cn> <CAAhV-H5_3NeAEqiBgXqxwhUbTGRhEO0fL2bY4KCOJ6J=cf9Emw@mail.gmail.com>
 <467fb231-4b0a-478e-0f68-358d0651fc05@loongson.cn>
In-Reply-To: <467fb231-4b0a-478e-0f68-358d0651fc05@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 22 Aug 2023 15:38:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7KRGM-Aw9mNUxypE7RKLdK6HPh0fx4hg5bavL_CsFE_g@mail.gmail.com>
Message-ID: <CAAhV-H7KRGM-Aw9mNUxypE7RKLdK6HPh0fx4hg5bavL_CsFE_g@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] MIPS: Return earlier in die() if notify_die()
 returns NOTIFY_STOP
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
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

On Mon, Aug 21, 2023 at 10:29=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
>
>
>
> On 08/20/2023 04:53 PM, Huacai Chen wrote:
> > Hi, Tiezhu,
> >
> > On Sun, Aug 20, 2023 at 7:21=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongso=
n.cn> wrote:
> >>
> >> After the call to oops_exit(), it should not panic or execute
> >> the crash kernel if the oops is to be suppressed.
> >>
> >> Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
> >> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> >> ---
> >>  arch/mips/kernel/traps.c | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> >> index 8e528a8..fd770dc 100644
> >> --- a/arch/mips/kernel/traps.c
> >> +++ b/arch/mips/kernel/traps.c
> >> @@ -412,6 +412,9 @@ void die(const char *str, struct pt_regs *regs)
> >>
> >>         oops_exit();
> >>
> >> +       if (ret =3D=3D NOTIFY_STOP)
> >> +               return;
> >> +
> >>         if (in_interrupt())
> >>                 panic("Fatal exception in interrupt");
> >>
> >> @@ -421,8 +424,7 @@ void die(const char *str, struct pt_regs *regs)
> >>         if (regs && kexec_should_crash(current))
> >>                 crash_kexec(regs);
> >>
> >> -       if (ret !=3D NOTIFY_STOP)
> >> -               make_task_dead(SIGSEGV);
> >> +       make_task_dead(SIGSEGV);
> > Then you call make_task_dead() at the end unconditionally, and die()
> > becomes a noreturn function again.
>
> No, it can return if (ret =3D=3D NOTIFY_STOP), so die() is a return
> function now, please see objdump -d arch/mips/kernel/traps.o.
Then should loongarch patches need to be updated, too?

Huacai
>
> Thanks,
> Tiezhu
>
