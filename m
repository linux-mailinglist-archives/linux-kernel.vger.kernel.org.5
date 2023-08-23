Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112F37862C4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236710AbjHWVxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238481AbjHWVxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:53:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EF410E4;
        Wed, 23 Aug 2023 14:53:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A3C564E10;
        Wed, 23 Aug 2023 21:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3FBC433C9;
        Wed, 23 Aug 2023 21:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692827608;
        bh=yYgchl/uSO44oPTWX83F6cb+aTw2O4tlPnxAf4Uij0w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mFelGQFqPCOsOIhNodECa5P2EXBq8p5a7qY/VlfJ/IpFc2rI8kkfJTjOQrAnkiSJv
         GIWm+qjlZsLs9O0rDjAW0YSZTvWGPlOXNsbZGJXGV+wFaip7KAHj9+7FcRToJRENv5
         qK9RvalX915GjbtKimt3P080qsAqluft9nnyVHYBEV06nAeCMw8Q9AnFyHsh87vnir
         wQg4NqTqGH5hXzkEMVoO9MHizflo48lihgVPrAqvIkm35I+wBgrWLL/hWQLi13yfiU
         PPZ3KLEl1GUua+Z7aRT79O5eyZCcKa3/FtLNbydYfvDy9RKFfmXJF8pcE//xszUgsm
         bMq7U6t83wbfw==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-56c4c4e822eso3864476eaf.3;
        Wed, 23 Aug 2023 14:53:28 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx4GLI8GSWIBtFyMvPSeKxfbWrDTjRJdL7qF90buXMvXXUrInP0
        +c9M27BqeKEhj0lHg8qg8/AlSA1sr4uQK2zTRig=
X-Google-Smtp-Source: AGHT+IEzcm1O1GbE7GtfYPZKZrjpO3qrihhmg6Vt/76+JbfzKbT+DzPJCtWl2yBnN3s7p6Nt/I2AoMGkA9Y4mWtImnE=
X-Received: by 2002:a05:6820:41:b0:56e:5a8e:654f with SMTP id
 v1-20020a056820004100b0056e5a8e654fmr569092oob.8.1692827607881; Wed, 23 Aug
 2023 14:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230809002436.18079-1-sunying@nj.iscas.ac.cn>
 <CAK7LNARH-ziDD8=+90y5Zzo0cqqnc5qaiVWW0YQzdZ=nO9+e8w@mail.gmail.com>
 <CAJFTR8SajdzT2kKscEpPon9faUa8tHrvYPC_+awG3VeHVS8sSg@mail.gmail.com> <20230823015551.GB3913@google.com>
In-Reply-To: <20230823015551.GB3913@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 24 Aug 2023 06:52:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQNk2MU=M5Q6GXtm34VyFcNOhVgw3UQ7Mdn4hoqQ_636A@mail.gmail.com>
Message-ID: <CAK7LNAQNk2MU=M5Q6GXtm34VyFcNOhVgw3UQ7Mdn4hoqQ_636A@mail.gmail.com>
Subject: Re: [PATCH] kconfig: add dependency warning print about invalid
 values in verbose mode
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Ying Sun <sunying@nj.iscas.ac.cn>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Siyuan Guo <zy21df106@buaa.edu.cn>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jesse T <mr.bossman075@gmail.com>
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

On Wed, Aug 23, 2023 at 10:56=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/08/19 22:40), Jesse T wrote:
> > > > From: Ying Sun <sunying@nj.iscas.ac.cn>
> > > >
> > > > Add warning about the configuration option's invalid value in verbo=
se mode,
> > > >  including error causes, mismatch dependency, old and new values,
> > > >  to help users correct them.
>
> Are those really errors?
>
> ERROR : CLANG_VERSION[140006 =3D> 0] value is invalid  due to it has defa=
ult value
> ERROR : CC_IS_GCC[n =3D> y] value is invalid  due to it has default value
> ERROR : GCC_VERSION[0 =3D> 120200] value is invalid  due to it has defaul=
t value
>
> I'm using clang, so corresponding options are set accordingly in my .conf=
ig


I think not errors, but warnings.

His idea is, CONFIG options that change a value
should be warned.



--
Best Regards
Masahiro Yamada
