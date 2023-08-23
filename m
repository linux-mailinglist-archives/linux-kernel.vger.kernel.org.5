Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCCC7863E0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 01:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbjHWXNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 19:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238541AbjHWXNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 19:13:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB23C10C7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 16:13:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31c63cd4ec2so1846797f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 16:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692832390; x=1693437190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4pUSrxjDT+8MgP/8jIoWX3HytxOHfJ1GFCQYUkvAzc=;
        b=VgslsiAMKgWP55NZSP4T/bngxxbJZlk1iVLMNDCMhJZ5FhRKsMaDu7v4kdG/ytRahd
         DuH2Eeo/yNQc0ElHyXohIM76sqPQ054j84QcQ+7TOCsbXPW+80bPxu/hx9R2zvkNzNjG
         zQ1KIVbg7YU2AHDIr7B/90ZmUC8HEkjj7CADM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692832390; x=1693437190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4pUSrxjDT+8MgP/8jIoWX3HytxOHfJ1GFCQYUkvAzc=;
        b=L30ekBpXPUy6bfs8NmYidAGN/826MqNgR/R/ag2cdmexnPAKgi80lnpBufqw36/1C5
         aeuWG512LNQjJk2+l1et4oWn4ZJ3D4ecM4nue6DLa2W9+sUAgLfjCCjltbJl+V++U9bS
         M5eDAoZ1DgR6yyY8xRYoNcCb4MIUPoBioJ7V3bhKHL8SW7chkvItasMt+sGgezQd2hoX
         EgAamMG+/Xr/qEa15LSaJuK4dhxKAdPpRWJ993x8nUVhS/piWllY5Lw7Rcer7xLu6ITF
         0J1+v1tGIxJMMw7vQ1Da4exOvr4fagVGw31HPIP3rrah+lj9KWJlb34DSglEoDnBeuoR
         6r5A==
X-Gm-Message-State: AOJu0YxAX0FAQD+cgcWT7QksnCkX1xUrt71mat7VTa56GD2ISkFz7+O2
        KcsQzuc8GwSTQr/0+Z9Xr1HDl+wE1KNPAi4kcEBZwA==
X-Google-Smtp-Source: AGHT+IFuDyFnHtP04kErHpgiACqv8D2N1u66DseGgw5ypbv7JmAQMrIEEv7UfapZTIe8/QAaDEOlZcunKdox/foqNkM=
X-Received: by 2002:a5d:6282:0:b0:31a:c6ef:5edc with SMTP id
 k2-20020a5d6282000000b0031ac6ef5edcmr9233956wru.12.1692832390226; Wed, 23 Aug
 2023 16:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230822065256.163660-1-denik@chromium.org> <20230822174835.253469-1-denik@chromium.org>
 <CAFP8O3KunP9CzT_U2cj1_oysojTxCNJRWX_kvvu_wOx4tbYHug@mail.gmail.com> <CAK7LNASstNj2HEfJHcRzqt7hay65T-yEgzaAuXbEQPuCS+yC6w@mail.gmail.com>
In-Reply-To: <CAK7LNASstNj2HEfJHcRzqt7hay65T-yEgzaAuXbEQPuCS+yC6w@mail.gmail.com>
From:   Denis Nikitin <denik@chromium.org>
Date:   Wed, 23 Aug 2023 16:12:57 -0700
Message-ID: <CADDJ8CWdm+cWt4UBTae0sCQ8ZDWhbMuozqqq59R+EtvMHere0g@mail.gmail.com>
Subject: Re: [PATCH v2] modpost: Skip .llvm.call-graph-profile section check
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Fangrui Song <maskray@google.com>, linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 4:02=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Wed, Aug 23, 2023 at 3:00=E2=80=AFAM Fangrui Song <maskray@google.com>=
 wrote:
> >
> > On Tue, Aug 22, 2023 at 10:49=E2=80=AFAM Denis Nikitin <denik@chromium.=
org> wrote:
> > >
> > > .llvm.call-graph-profile section is added by clang when the kernel is
> > > built with profiles (e.g. -fprofile-sample-use=3D or -fprofile-use=3D=
).
> > >
> > > The section contains edge information derived from text sections,
> > > so .llvm.call-graph-profile itself doesn't need more analysis as
> > > the text sections have been analyzed.
> > >
> > > This change fixes the kernel build with clang and a sample profile
> > > which currently fails with:
> > >
> > > "FATAL: modpost: Please add code to calculate addend for this archite=
cture"
>
>
> Curious.
>
> This message is only displayed for REL.
>
> (Please not it is located in section_rel() function)
>
>
> I think modern architectures use RELA instead of REL.
> Which architecture are we talking about?

Aarch64. There was also a report on x86-64 but the error message could be
different there.

>
>
> What does the output of this command look like?
>
> $ llvm-readelf -S vmlinux.o | grep  .llvm.call-graph-profile
>
>
> Is it REL?
>

  [119] .llvm.call-graph-profile LLVM_CALL_GRAPH_PROFILE 0000000000000000
1c74a458 0104c8 08   E  0   0  1
  [120] .rel.llvm.call-graph-profile REL 0000000000000000 1c75a920 041320 1=
0
I 26090 119  8

Thanks,
Denis
