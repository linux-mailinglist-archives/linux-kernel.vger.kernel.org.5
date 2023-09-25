Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679697AD112
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjIYHH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjIYHHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:07:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A3EB8;
        Mon, 25 Sep 2023 00:07:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EC2C433AB;
        Mon, 25 Sep 2023 07:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695625637;
        bh=N6mc0aHWFcgFpRtTDCT4En17AvKws6F8YqHYyIo0PVA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EJg7YRnVisvyUzgHs4WBxIniT1IJDwEy6XObQxoKvCu57smDV/VI2w/4wvqXYb646
         5HbENKBosu5cJNA8yuuQlmfvl/bDgpeDmTJ5kvlvlTEUHQm//dEAGkjdqNn5G/wYrO
         b86cuv0u6SL1g4f20UEklBvwfTewc79tPkoGe4SQW7C3SsOo55AnWxkfuanyhzFNJG
         QgV0jpbGzz+Mdz0Ig6rXmqaYBVHjt1aU63Lxew3TCiEy4n++110O1MO5WFSLguEgUL
         ISw6WqBkWvXYjQ3PRrw0J0Y1asVuaxDJ1Tsu4HOiJU9okjR1t9rcYPCT9XL1MUs5rQ
         G8ikFLRv3NPJw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1dceaa7aeffso1392523fac.0;
        Mon, 25 Sep 2023 00:07:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YyCQ7TRFsjRELyg2hKJ7YD14yKwpUp6zl99nxRrnRfH/v2aghsV
        W2JZoyWcCZ42/Hp//BAUirGtdAfrS3pJULx3lvE=
X-Google-Smtp-Source: AGHT+IFOiFhdrZ+lis0uTmihuJ6U+6yVA37X3fAFpdu3ZIZOBY5MUlSCRDTCFZM//OsshohPaGi280ujFMXNeCI4jsw=
X-Received: by 2002:a05:6870:2328:b0:1d5:cdf7:bdbc with SMTP id
 w40-20020a056870232800b001d5cdf7bdbcmr3661140oao.2.1695625637184; Mon, 25 Sep
 2023 00:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230917192009.254979-1-arnd@kernel.org>
In-Reply-To: <20230917192009.254979-1-arnd@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 25 Sep 2023 16:06:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNASua5xkkg84s4o4GZ00hFRc10V9BmqyxfWfPi=JVFYC8g@mail.gmail.com>
Message-ID: <CAK7LNASua5xkkg84s4o4GZ00hFRc10V9BmqyxfWfPi=JVFYC8g@mail.gmail.com>
Subject: Re: [PATCH] [v2] Documentation: kbuild: explain handling optional dependencies
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Sep 18, 2023 at 4:20=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This problem frequently comes up in randconfig testing, with
> drivers failing to link because of a dependency on an optional
> feature.
>
> The Kconfig language for this is very confusing, so try to
> document it in "Kconfig hints" section.
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: fix typos pointed out by Nicolas Schier


Applied to linux-kbuild. Thanks.



--=20
Best Regards
Masahiro Yamada
