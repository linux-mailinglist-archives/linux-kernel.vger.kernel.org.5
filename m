Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6A87896EE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 15:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjHZNho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 09:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjHZNhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 09:37:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478BA2110;
        Sat, 26 Aug 2023 06:37:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8C3A60B75;
        Sat, 26 Aug 2023 13:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41616C433C8;
        Sat, 26 Aug 2023 13:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693057031;
        bh=Yjot58EN/PcW8NWCaNBETGf3vpDyS4GUtPxgy1hzJ2k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KYVv62a381GOARTsNKTXZ7BWkPsJEbyK5MgezkePOBgYtX/vEC8Zgt7wc0746hdcN
         U2u5qNBguRblg1uihlQduv/naSlHuA7IAAHRl21js8KuBoJ1671igyIy+crAiI/sHN
         Z7QgsE/x22o3CCLnTgYMNj8ykjed7IwybCWGk/Kv8utHVXWHX19kpnoS0dnVmi3NL3
         94XNJMIgbCc4XEe+D3OqvDzy2wXznvsslsx4hQ8rbLdpgIWqY35FxSVuqIUkS4ppC4
         srgnlRSQUmizs9YfMsDRbJITbYSaMwdFkRMqCps83XK3Mrj3TXGFCdRHKEcwDoV6F1
         1I/2JSbwMXukw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5732481b22eso1207658eaf.3;
        Sat, 26 Aug 2023 06:37:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YyoySp0fCXunUIyo4pGKuo4d0+ubXq09RJl2YFm15rqc/y8pH1L
        l+aWPVfD8/IL8UohSAVVz89xJfETtvQS6/5uKAg=
X-Google-Smtp-Source: AGHT+IG0stkT42MZncUBT20W1nnM7Tt0CvOWlJQqce/1P6wn6R8ddbf55t4GzNTMAo8OxUxMgkRwg1D7v0BCSUeiiSg=
X-Received: by 2002:a4a:91c7:0:b0:56e:4dea:bc5c with SMTP id
 e7-20020a4a91c7000000b0056e4deabc5cmr7497675ooh.8.1693057030546; Sat, 26 Aug
 2023 06:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230823115048.823011-1-masahiroy@kernel.org> <ZOZjmLPxwWik/YOz@bergen.fjasle.eu>
In-Reply-To: <ZOZjmLPxwWik/YOz@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 26 Aug 2023 22:36:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNASE+C17fr5u5ouq36fEjXiQxpwfEx3UjhzXE0Qt-OEifw@mail.gmail.com>
Message-ID: <CAK7LNASE+C17fr5u5ouq36fEjXiQxpwfEx3UjhzXE0Qt-OEifw@mail.gmail.com>
Subject: Re: [PATCH 1/8] kbuild: do not run depmod for 'make modules_sign'
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Fri, Aug 25, 2023 at 2:55=E2=80=AFPM Nicolas Schier <nicolas@fjasle.eu> =
wrote:
>
> On Wed 23 Aug 2023 20:50:41 GMT, Masahiro Yamada wrote:
> > Commit 961ab4a3cd66 ("kbuild: merge scripts/Makefile.modsign to
> > scripts/Makefile.modinst") started to run depmod at the end of
> > 'make modules_sign'.
> >
> > Move the depmod rule to scripts/Makefile.modinst and run it only when
> > $(modules_sign_only) is empty.
>
> Moving the depmod rule is in patch 3/8, first half of the sentence
> seems to be left over?


Theoretically, 1/8 and 3/8 can be squashed together, but
3/8 is too big to be back-ported.

1/8 was split out for easy back-porting.






> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
>
> >
> > Fixes: 961ab4a3cd66 ("kbuild: merge scripts/Makefile.modsign to scripts=
/Makefile.modinst")
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  Makefile | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Makefile b/Makefile
> > index e0d52539a0f1..7d54a0700c6e 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1877,7 +1877,9 @@ quiet_cmd_depmod =3D DEPMOD  $(MODLIB)
> >
> >  modules_install:
> >       $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
> > +ifndef modules_sign_only
> >       $(call cmd,depmod)
> > +endif
> >
> >  else # CONFIG_MODULES
> >
> > --
> > 2.39.2



--=20
Best Regards
Masahiro Yamada
