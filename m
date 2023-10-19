Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056927D0212
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjJSSuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbjJSSuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:50:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F558137
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:49:59 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-991c786369cso5380566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697741397; x=1698346197; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PfRCt7OwWtnH0FdGfWeXu2SVBnueB9HbeDkU2AyhBWs=;
        b=Lnt7MzlVban0nkdFWcezDmQp9G/7hSm9y2CXbcRDzTNppsT66V5VCcQlsb32wmUcLd
         GUwKMdrGiKojHh/LEu9V/RqPDoV0a+E0kJFCQt5ARblLNuaO+82GfY3X/ZCN3HFh+KEP
         FGdssJXjr1nW1f7pSpqJsDgrOQB8OP7ElAtU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697741397; x=1698346197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfRCt7OwWtnH0FdGfWeXu2SVBnueB9HbeDkU2AyhBWs=;
        b=pNnAH9nIwSZHQ6SlVjTtySCnBC+U53BEeWKlU8GCEz/DfNAn+zGx9bBfaAi1D5LMNe
         jvErJJRKxVCK9q/2mDXjFTKntLLEnyBmAH4VajqwP/1y3iJ1V8Inbp6JGrelQmio/xtq
         gmFJemKWMq1LP6yCwPX/3/6xABqrf9Y4RP6pbapIu+JvHnM1m2pneLy8XZI+iHQPk5I4
         MpDE3nNDvUM1dPaaOnMFbyjD6hMuspSkOfOEGr7bDWkXGu4xBDLrW3OkmyMatzFqGvK8
         hgZYU0+ef5S2ajSTrjtKWXu1Dgeph3+Snr2kH0n0Mq2gIzg055zwCvmBXiKJ1+RsLFwv
         kYww==
X-Gm-Message-State: AOJu0YzUU92YzNoELdU/YucP1YKPN23Hu2J00FArgamBUmK/rSSoTd0m
        lo4/8dvzoDl4x0N+6gHQeZGI/8ax1Y9Ln6cGAaGf29Pj
X-Google-Smtp-Source: AGHT+IGC5o+NXcgW/LPTdfsIyF03gitjWZmR3oqBgKFV3Rd10NciJnfnhShLvWrMRYUC8gu+kjuEUA==
X-Received: by 2002:a17:906:9fc1:b0:9bd:cab6:a34f with SMTP id hj1-20020a1709069fc100b009bdcab6a34fmr2760537ejc.73.1697741397223;
        Thu, 19 Oct 2023 11:49:57 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id x10-20020a170906298a00b009829d2e892csm42310eje.15.2023.10.19.11.49.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 11:49:56 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9bdf5829000so7245166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:49:56 -0700 (PDT)
X-Received: by 2002:a17:906:dacb:b0:9c7:4d98:981f with SMTP id
 xi11-20020a170906dacb00b009c74d98981fmr2635937ejb.33.1697741396005; Thu, 19
 Oct 2023 11:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
 <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com>
 <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com> <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
 <9F926586-20D9-4979-AB7A-71124BBAABD3@vmware.com> <CAHk-=wi7YKPKKZw5SpA9gZcf4paG4pZ2kUM50g-LQmdF0g6vWg@mail.gmail.com>
 <CAFULd4bpHkNzCzKed23mTTBWRyhPnOm91f+F6UE413VK+oFtMQ@mail.gmail.com>
 <CAFULd4Z-q4Ot6iyOLo7DkjE=dY3RHXUV+yx6R0iWk=-tZ6ufhQ@mail.gmail.com>
 <CAHk-=wjSnECwAe+Bi0PD6uods3ZDs8up5OAy-qZKF5OgPLpDiA@mail.gmail.com>
 <CAFULd4bLEU-tBC8dO1wf66UAxQ2d1HxQ=D6wvtHZfdQCKhnpkw@mail.gmail.com>
 <CAFULd4YAFTFqon3ojv7N6h=G_1pAjSH3T6YvX0G=g7Fwh7j1jQ@mail.gmail.com>
 <A2E458DE-8B84-4FB2-BF6D-3EAB2B355078@vmware.com> <CAFULd4b_PdKb=8U5+Zz-XNoYdULtcQJnmf-yCrpCv7RRogSXyQ@mail.gmail.com>
 <CAFULd4Y8_MOMGcatcMuUaC89zX5F-VYr0niiJ9Yd8hQ16neHjw@mail.gmail.com>
 <3F9D776E-AD7E-4814-9E3C-508550AD9287@vmware.com> <CAFULd4Zruoq4b5imt3NfN4D+0RY2-i==KGAwUHR8JD0T8=HJBw@mail.gmail.com>
 <28B9471C-4FB0-4AB0-81DD-4885C3645E95@vmware.com> <CAHk-=whS8-Lk_=mFp=mr-JrbRYtScgz-4s_GLAOQGafa_3zP9g@mail.gmail.com>
 <CAFULd4Yy-v40tK94rexSOL99FGMke2Jk42wgcjoEBxV=2hXoCw@mail.gmail.com>
 <CAHk-=wjrLoy6xEDXB=piEUagDLMmV5Up7UK75W1D0E0UFVO-iA@mail.gmail.com>
 <CAFULd4autFT=96EckL9vUDgO5t0ESp27+NDVXQHGi7N=PAo-HQ@mail.gmail.com>
 <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com>
 <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
 <CAHk-=wgCPbkf0Kdi=4T3LAVvNEH0jxJBWcTiBkrFDBsxkC9mKQ@mail.gmail.com>
 <CAFULd4aTY002A7NHRCX21aTpYOE=tnpouBk6hkoeWND=LnT4ww@mail.gmail.com>
 <CAHk-=wia9vFmyCJPkYg0vvegF8eojLy+DxVtpfoDv-UHoWKfqQ@mail.gmail.com>
 <CAFULd4Zj5hTvATZUVYhUGrxH3fiAUWjO9C27UV_USf2H164thQ@mail.gmail.com>
 <CAHk-=whEc2HR3En32uyAufPM3tEh8J4+dot6JyGW=Eg5SEhx7A@mail.gmail.com>
 <CAFULd4avm_TaEoRauohRc90SUrx-D+wBJvg+htQDQ1_N=zNemw@mail.gmail.com>
 <CAHk-=wijmmRB7-ZeT-sdxCSUoB83Lb5dnN7a7mCcH3cRw_aghQ@mail.gmail.com>
 <CAFULd4b91Tr9Q2p4a20eusC+QO6O81gxY+nP-zpFiFKGTmLpYg@mail.gmail.com>
 <CAHk-=wi3LZ_4OGAMhvgO0JSTp-eEPOGp+siq1nJNLY1JAxdP5Q@mail.gmail.com> <CAFULd4YxvMtTEfQL-RiLisTxDwoJZZxXXB+3CWqCpzZkUf85JA@mail.gmail.com>
In-Reply-To: <CAFULd4YxvMtTEfQL-RiLisTxDwoJZZxXXB+3CWqCpzZkUf85JA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Oct 2023 11:49:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0UTj3dfuKK=DEQ+AQ2GPUddjVUVZ_nRHdY=L_rRb2KQ@mail.gmail.com>
Message-ID: <CAHk-=wj0UTj3dfuKK=DEQ+AQ2GPUddjVUVZ_nRHdY=L_rRb2KQ@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     peterz@infradead.org, Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 at 11:16, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> And NO (whee...), there is no rematerialization of asm (foo() ). OTOH,
> there is also no rematerialization from non-volatile memory (bar() ),
> although it would be more optimal than spill to/fill from a frame pair
> of moves. I wonder what are "certain circumstances" that the
> documentation is referring to.

Honestly, I've actually never seen gcc rematerialize anything at all.

I really only started worrying about remat issues in a theoretical
sense, and because I feel it would be relatively *easy* to do for
something where the source is a load.

              Linus
