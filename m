Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FBE80B610
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 20:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjLIT1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 14:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjLIT1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 14:27:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE205125
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 11:27:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54063C433C7;
        Sat,  9 Dec 2023 19:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702150028;
        bh=7eH07NOIg7S8Oed4coNU+KjHoIA9mCHcWUGQlTJkMPE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Oya+JYtn3Cq/MhxsUXeD3D7IBJkonamRcMfitlmvhGEYsmiLchPHZnlplmY53wqWv
         EaoovI5qxTqt1x3zoHJQQr4MIb+FFRtaX2+1XKtZNMnYOuiWrO+ejd/mfDV12UpVrI
         gkALHdkxTKFp5umpgnGBJrMrey2WnbuTZ0QyNv7KTwK5U7gD2840J2Iq7j22cvPFdw
         WjkD/boNZJV04eAD6SuT6pPGrQ5yzDNRHEkndIcxzl+4QrW+Ud8xGMCvfy1x47G9iS
         sBIVDYPWIsf1sqqfBE2hVnyGzWNb7gsYAgVN6wKdX6/Axhb6qKmcL9MeNcP3plK+cv
         3IyZj7QjEPYgg==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6d9d21959aaso1738569a34.2;
        Sat, 09 Dec 2023 11:27:08 -0800 (PST)
X-Gm-Message-State: AOJu0YzIZUNiNigIqfrZdI8bD/+RoYSJuc/yAVSQVfERsNHkjEp2u90h
        eAUbV/lcX3xqf2IAohQbBOHggRMrqbgyzcW0KpM=
X-Google-Smtp-Source: AGHT+IH5U7uAkrOlN3vsQGa3BZk5t88Q0NfxBahA43BOSk5sfQ9Z4k/bjUIe9Pijg1scldtw7f0I++8XGNlQ8+qcjgc=
X-Received: by 2002:a05:6870:2008:b0:1fb:2025:e5b2 with SMTP id
 o8-20020a056870200800b001fb2025e5b2mr1212829oab.103.1702150027738; Sat, 09
 Dec 2023 11:27:07 -0800 (PST)
MIME-Version: 1.0
References: <20231126071914.932241-1-masahiroy@kernel.org> <ZW67BGhBzh4f3G3T@bombadil.infradead.org>
In-Reply-To: <ZW67BGhBzh4f3G3T@bombadil.infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 10 Dec 2023 04:26:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQAckvYsU_mAuGS=pDzUk=-ZmAN9K45iTLQn0wfaYkDfQ@mail.gmail.com>
Message-ID: <CAK7LNAQAckvYsU_mAuGS=pDzUk=-ZmAN9K45iTLQn0wfaYkDfQ@mail.gmail.com>
Subject: Re: [PATCH] init: move THIS_MODULE from <linux/export.h> to <linux/init.h>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Dec 5, 2023 at 2:54=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> On Sun, Nov 26, 2023 at 04:19:14PM +0900, Masahiro Yamada wrote:
> > Commit f50169324df4 ("module.h: split out the EXPORT_SYMBOL into
> > export.h") appropriately separated EXPORT_SYMBOL into <linux/export.h>
> > because modules and EXPORT_SYMBOL are orthogonal; modules are symbol
> > consumers, while EXPORT_SYMBOL are used by symbol providers, which
> > may not be necessarily a module.
> >
> > However, that commit also relocated THIS_MODULE. As explained in the
> > commit description, the intention was to define THIS_MODULE in a
> > lightweight header, but I do not believe <linux/export.h> was the
> > suitable location because EXPORT_SYMBOL and THIS_MODULE are unrelated.
> >
> > Move it to another lightweight header, <linux/init.h>. The reason for
> > choosing <linux/init.h> is to make <linux/moduleparam.h> self-contained
> > without relying on <linux/linkage.h> incorrectly including
> > <linux/export.h>.
> >
> > With this adjustment, the role of <linux/export.h> becomes clearer as
> > it only defines EXPORT_SYMBOL.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>


I will fold your reviewed-by tag.

Thanks.


>
> Do you want this this to go through modules-next or your tree? I'm fine
> it goes either way.
>
>   Luis



--=20
Best Regards
Masahiro Yamada
