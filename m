Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD50B75D06F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGURO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjGUROz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:14:55 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62F52D4E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:14:53 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b961822512so32793591fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689959692; x=1690564492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9K5VHhZFEzQffhn522CBvGHgBcaIDvu9FEQtTEAlvh8=;
        b=v9suOoHBlIk67EKDKPqWLhrvssc3VmdYen5EzwX5m/TcUyTOkr+Ok1N1Qaa2m2hhVU
         dqHw3CQNBMJ741j1Q41aKPaQP8tzE+Ad/rNDqGHrMjkShpnw72khf+y+t5siZc4LowW8
         oTLzbsiQo87tyS4+gTUmElWm6wi61LFe0O8IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689959692; x=1690564492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9K5VHhZFEzQffhn522CBvGHgBcaIDvu9FEQtTEAlvh8=;
        b=Jm1Mt9NLAq7aVMVzNMrfpouHCU8NfC3mwQssUd/veHt/AP5sbGGOyv4KpqGd+WddfH
         R9LMCYdrcar8pZZylVJCrzBGGojkSzo7LkGoThcl7o23JwkJ4PIdSESoUbUdvCoFBViw
         3hrvrrIg1snHlw4nL9BcNRaVFw0onbgASTKIryqQNTmxxI6sTAsaPwbmO1I/UwZE5qdW
         JDuxNRnRKuY0keZb1WbXrW0inNYd7dUJPCev1z4CpnPzDFZfr+I1nT5cdEvrWty5bqw/
         xg22MoQ7XubbdJJcctK4O5MLzGig697/h29JXCO7C81Fsar1azjtmsuZI6IhRliIfl7o
         0jgg==
X-Gm-Message-State: ABy/qLbBNf6HWawmuUtn8ZHliwklShufgIJilhNI4OfLrByqC44rGpWd
        YENXdZBGaUp2uZFKQrygSDxrEW4vndv3n1aSadTNnQ==
X-Google-Smtp-Source: APBJJlFcu8j3/DkgCopyZdnnpMfBq1CbxSvKbDwtsMsSsOQpSDKDCSmQi43l3aGLy2W0gXu1smDknxyIQxjYzck0H0o=
X-Received: by 2002:a05:651c:205:b0:2b5:9f54:e290 with SMTP id
 y5-20020a05651c020500b002b59f54e290mr1980021ljn.0.1689959691909; Fri, 21 Jul
 2023 10:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
 <1E0741E0-2BD9-4FA3-BA41-4E83315A10A8@joelfernandes.org> <1AF98387-B78C-4556-BE2E-E8F88ADACF8A@gmail.com>
 <cc9b292c-99b1-bec9-ba8e-9c202b5835cd@joelfernandes.org> <962bb2b940e64e7da7b71d11b307defc@AcuMS.aculab.com>
In-Reply-To: <962bb2b940e64e7da7b71d11b307defc@AcuMS.aculab.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 21 Jul 2023 13:14:40 -0400
Message-ID: <CAEXW_YS_raHUrvVAFPpnhL2PRH0hkcqT=1hD+gQOg_cMLkGrjQ@mail.gmail.com>
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
To:     David Laight <David.Laight@aculab.com>
Cc:     Alan Huang <mmpgouride@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 11:59=E2=80=AFAM David Laight <David.Laight@aculab.=
com> wrote:
>
> ....
> > Right, it shouldn't need to cache. To Eric's point it might be risky to=
 remove
> > the barrier() and someone needs to explain that issue first (or IMO the=
re needs
> > to be another tangible reason like performance etc). Anyway, FWIW I wro=
te a
> > simple program and I am not seeing the head->first cached with the patt=
ern you
> > shared above:
> >
> > #include <stdlib.h>
> >
> > #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
> > #define barrier() __asm__ __volatile__("": : :"memory")
> >
> > typedef struct list_head {
> >      int first;
> >      struct list_head *next;
> > } list_head;
> >
> > int main() {
> >      list_head *head =3D (list_head *)malloc(sizeof(list_head));
> >      head->first =3D 1;
> >      head->next =3D 0;
> >
> >      READ_ONCE(head->first);
> >      barrier();
> >      READ_ONCE(head->first);
> >
> >      free(head);
> >      return 0;
> > }
>
> You probably need to try harder to generate the error.
> It probably has something to do code surrounding the
> sk_nulls_for_each_rcu() in the ca065d0c^ version of udp.c.
>
> That patch removes the retry loop - and probably breaks udp receive.
> The issue is that sockets can be moved between the 'hash2' chains
> (eg by connect()) without being freed.

I was just replying to Alan's question on the behavior of READ_ONCE()
since I myself recently got surprised by compiler optimizations
related to it. I haven't looked into the actual UDP code.

 - Joel
