Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41F977A657
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 14:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjHMM1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 08:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHMM1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 08:27:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E471709;
        Sun, 13 Aug 2023 05:27:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 945F861EE6;
        Sun, 13 Aug 2023 12:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF46C433CD;
        Sun, 13 Aug 2023 12:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691929656;
        bh=hI63j5Y1v/EpxkF3zRmRJcJMwH3uwkL2Etsjilu5r3M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jzdO4ETk4SQo9NtoyfSDFz/mK53009YwOV6cl1dZONwCQLJy+TdooqxJRg32RQz4K
         5fCo8B+13j9FRSiF+iHjffnmT5zSr+GE4iW+lWagOJyE2xOUBsAcMBYwExEjmu2AHi
         aMPzZDZBJXH4EofW0prKi7wqmL5Nu3T1ESIgFIym5Mit97toH1/yTRpnpnFvvDTsGa
         tDfx4NbU+5TXAe8O4IBtr/IJSH9Ib4tMTZ/iJ+O+mAAgksDk8XzJn8XDib3heC+mvV
         euuHuzl5U3IJG8lPafPBxDJxRovhcjeiHHHntRCHwh6gm1+Nopz3r+rrBA85ev4/sH
         xqE7/4DhamWEQ==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3a76d882052so2882358b6e.0;
        Sun, 13 Aug 2023 05:27:35 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy22IB7CTVxd6Lc373fK2AGBSpJhLNSk417sE+DwvgcT0ZhAFbl
        173BxiHggOIHe68Jzc6ab3kfUG/BJD2ZhUQY/y8=
X-Google-Smtp-Source: AGHT+IHSiW8nFZhCa3rpwuCP+pi0GoJAEwDAiJKgryWuYNImBPFx2Eko3cGlBu3PhSQ+myGWFRG3cpnigWh0CzWbBYk=
X-Received: by 2002:a05:6808:1416:b0:3a4:3072:e597 with SMTP id
 w22-20020a056808141600b003a43072e597mr7409078oiv.54.1691929655153; Sun, 13
 Aug 2023 05:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230809172211.343677-1-yesshedi@gmail.com> <20230809172211.343677-5-yesshedi@gmail.com>
 <2023081024-garment-conducive-d429@gregkh>
In-Reply-To: <2023081024-garment-conducive-d429@gregkh>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 13 Aug 2023 21:26:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNATovC3UQcNC21vyjU-rNOUX02M6KehA6Vz7QuWHjD7PHg@mail.gmail.com>
Message-ID: <CAK7LNATovC3UQcNC21vyjU-rNOUX02M6KehA6Vz7QuWHjD7PHg@mail.gmail.com>
Subject: Re: [PATCH v9 4/7] sign-file: add support to sign modules in bulk
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Shreenidhi Shedi <yesshedi@gmail.com>, dhowells@redhat.com,
        dwmw2@infradead.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, linux-kernel@vger.kernel.org, sshedi@vmware.com,
        linux-kbuild@vger.kernel.org
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

On Fri, Aug 11, 2023 at 6:10=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Aug 09, 2023 at 10:52:07PM +0530, Shreenidhi Shedi wrote:
> > In the existing system, we need to invoke sign-file binary for every
> > module we want to sign. This patch adds support to give modules list
> > in bulk and it will sign them all one by one.
>
> But you never actually use this option in the kernel build process?  If
> not, why add this at all?
>
> thanks,
>
> greg k-h


Agree.
The bulk-sign flag is never used in the upstream kernel.
We cannot accept this.


--=20
Best Regards
Masahiro Yamada
