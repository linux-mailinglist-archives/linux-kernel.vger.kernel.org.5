Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC30A79882F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241271AbjIHN6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjIHN6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:58:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B791BF6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 06:58:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E6FC433CB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694181521;
        bh=DfiFir3Xn1RbQQOIWt9tqf3zKXx7eQfHklOO0Iw6By0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FmxIsFBYDzi39WJpJumAvBzhPdJLbs74aR+5J47pG93IrAItgQXZ0W0nTiOOOhlkg
         cwXfj6t/3hY5RIG2F3z3O32HIRUexix+gNSZlsT2LCrpYtsPt/HLs/n+pvXCJkrDa2
         bWC1Dx0ymRCivkGAyCFIZnygpLOOKo28A7ER3Sf+KJXiGgIXyXvIiWBi1BoaNZrtcf
         SIHTZWMo/pzDXFgan13o1xIBuQkpynspw3b4xAg/bfjVOWwEOFlHrkvmkduCjfThJG
         fwuE1Cp8T0KCch9DgXKhdefuQYC3Fo66rdPdkd/rhxT0gNkTSISSIdGCfXraIN1osH
         RW7JS5M00HGJw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1c4dd644cf8so1677380fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 06:58:41 -0700 (PDT)
X-Gm-Message-State: AOJu0YxSYEOCpW6mZ/TP0a8evE7ruDxfsPkor6exyvaSds9x9D/Q0Hxh
        KTC7jKbxvtOGnNhISpghyQ59c7DCQj/Uq2AjsBY=
X-Google-Smtp-Source: AGHT+IG7jIYVPeNQtF8VhCVJyGQPKFt9ZP06kqhbWd6sFrElmcTqg0AE+wBEfPNE9j07flChDeh96xxqCjeUYM0mmw4=
X-Received: by 2002:a05:6871:706:b0:1bb:b18e:b864 with SMTP id
 f6-20020a056871070600b001bbb18eb864mr3159137oap.48.1694181521288; Fri, 08 Sep
 2023 06:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230907110305.2096052-1-masahiroy@kernel.org> <ZPnZHzOli8w0Lqwr@smile.fi.intel.com>
In-Reply-To: <ZPnZHzOli8w0Lqwr@smile.fi.intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 8 Sep 2023 22:58:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNATK--vNGT8x67=KMeoETXdvsSZt2_x7jUgpazyaoHgr3g@mail.gmail.com>
Message-ID: <CAK7LNATK--vNGT8x67=KMeoETXdvsSZt2_x7jUgpazyaoHgr3g@mail.gmail.com>
Subject: Re: [PATCH] devres: rename the first parameter of devm_add_action_or_reset()
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
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

On Thu, Sep 7, 2023 at 11:24=E2=80=AFPM Andy Shevchenko <andy@kernel.org> w=
rote:
>
> On Thu, Sep 07, 2023 at 08:03:05PM +0900, Masahiro Yamada wrote:
> > Fix a possible mistake in commit 410e7088e971 ("devres: Pass unique nam=
e
> > of the resource to devm_add_action_or_reset()").
> >
> > The first parameter of devm_add_action_or_reset() is the associated
> > device. The name 'release' is confusing because it is often used for
> > dr_release_t in the devres context.
> >
> > Rename it to 'dev'. No functional change intended.
>
> ...
>
> > -#define devm_add_action_or_reset(release, action, data) \
> > -     __devm_add_action_or_reset(release, action, data, #action)
> > +#define devm_add_action_or_reset(dev, action, data) \
> > +     __devm_add_action_or_reset(dev, action, data, #action)
>
> What about devm_add_action() and Co?


I will fix devm_add_action too.


Thanks.




> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
Best Regards
Masahiro Yamada
