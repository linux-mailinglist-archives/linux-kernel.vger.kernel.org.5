Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3256F809BBC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjLHFd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjLHFdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:33:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F5E1729
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 21:33:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F38AC433C8;
        Fri,  8 Dec 2023 05:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702013610;
        bh=57Iuychu+Y6HJndFxVGj0xwfUq2O94hJGtPFq6Hs3bE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N8tLFs818LJj90WRN8s0XJpAyMFajluMii8/dZUCGN26Sp99+yFxIluN2oqv5k1Fo
         0zK5XjSQFFhqDiI3yabEQaA0LC0bLYo4i5k+kPQknF+u2HeVSC3IbX4OdIKw+sn4OU
         eKX6+D6u+Bp5/p3tnBRM8NIHK0G0J5CmqKDlGQMOUMixsn/595AzvSSBDMVwBj+r4A
         QLfUgtZbDpzG8vPUfCEPJ+hEnmM6Wb3l5Xa8/2kXrWQYzLNnbDL/Epcdcyc5OakQgS
         id9PK+dBcukWAPJP8WLmG0F50J3sErIQQTyaMPVcpMjkws/pKM90WXMmpBqqMPvada
         YY4i+LlElWWDg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50be03cc8a3so2090305e87.1;
        Thu, 07 Dec 2023 21:33:30 -0800 (PST)
X-Gm-Message-State: AOJu0YxC7vgwggckZWPC56gyuPTxQdk6shoKUrjONZ4KV2i4/g66+EP+
        WFeaLzMsekthuRUWIdcbghZ3VSWqSfCz4XmmMjg=
X-Google-Smtp-Source: AGHT+IGrWYKEARpYyha5a0BZLMItMM50RLahl12IkQVgDAvW13+O6qc+CP0Wak/gkrsYjmUNkbytn6ssAaOvZubz3jo=
X-Received: by 2002:a05:6512:12c2:b0:50c:1bc5:6a65 with SMTP id
 p2-20020a05651212c200b0050c1bc56a65mr1563713lfg.53.1702013608490; Thu, 07 Dec
 2023 21:33:28 -0800 (PST)
MIME-Version: 1.0
References: <03dd7de1cecdb7084814f2fab300c9bc716aff3e.1701632867.git.christophe.jaillet@wanadoo.fr>
 <202312041419.81EF03F7B7@keescook>
In-Reply-To: <202312041419.81EF03F7B7@keescook>
From:   Song Liu <song@kernel.org>
Date:   Thu, 7 Dec 2023 21:33:17 -0800
X-Gmail-Original-Message-ID: <CAPhsuW43g-M+xvzD0N1JsJ_zGnvZQOw2Bi1TEqoHKanPnvMHLQ@mail.gmail.com>
Message-ID: <CAPhsuW43g-M+xvzD0N1JsJ_zGnvZQOw2Bi1TEqoHKanPnvMHLQ@mail.gmail.com>
Subject: Re: [PATCH] md/md-multipath: Convert "struct mpconf" to flexible array
To:     Kees Cook <keescook@chromium.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 2:20=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Sun, Dec 03, 2023 at 08:48:06PM +0100, Christophe JAILLET wrote:
> > The 'multipaths' field of 'struct mpconf' can be declared as a flexible
> > array.
> >
> > The advantages are:
> >    - 1 less indirection when accessing to the 'multipaths' array
> >    - save 1 pointer in the structure
> >    - improve memory usage
> >    - give the opportunity to use __counted_by() for additional safety
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
> This looks like a really nice conversion. I haven't run-tested this, but
> it reads correct to me.

Agreed this is a good optimization. However, since MD_MULTIPATH is
already marked as deprecated. I don't think we should ship further
changes to it.

Thanks,
Song
