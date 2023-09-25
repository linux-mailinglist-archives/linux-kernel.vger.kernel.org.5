Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36317ADA07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjIYOY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjIYOYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:24:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2B2103;
        Mon, 25 Sep 2023 07:24:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FE6C433BB;
        Mon, 25 Sep 2023 14:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695651888;
        bh=2g1Do3iFHMaQciL0KcyWXZ2okrnEVOiE1mgLnj8LAgY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZMiEBOkk+/qLFl0MfpXi0tUJXbUpv9mBiAr/nru8fgWJSn5YmyxxCMzZpTKQ1yiko
         cuJNFQN/9nRQkd/5PcJDPpwSJSZJQBVF2O/o4B7Zd15pEsrh/Hye03utErafo7z95E
         bVScDlwZC3olCKyYEcpE3iTVIUiRJiSoUde5qPNC84Lf9oOwQahDXEhknrxFUl+FZ7
         K/MVdXZH1EUfSOksjt95Wfm/jFfEEkO7StyYqw/aBBwUvuoA4r2nrY7R1McFKleSni
         D2eyaHb8KLPVpRnQ/N4+XMjZ5O7mxkHn0uTlFiHR2DLXYSMd5L8svwE3OkFziwLHsX
         ucR2rozGuSufQ==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1dceb2b8823so1697013fac.1;
        Mon, 25 Sep 2023 07:24:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YyLdYBLnQsS2rmwBgqTqEdzHfde2EpMftWqoPTyhegXv9s/hzCU
        cZqBWnKWVhSfIDAiXKLiLKvYfeUvWKhshLJdwAU=
X-Google-Smtp-Source: AGHT+IFshSJHajEwbbMkZ0LtWy62unM/P0wOWiHyadRVQtrQkJjUZgSH+LL12pe1k9VdSCb/77ZDGX7LiC9tPmq5FuM=
X-Received: by 2002:a05:6871:4a02:b0:1dd:4e2:f825 with SMTP id
 tz2-20020a0568714a0200b001dd04e2f825mr2565808oab.8.1695651888307; Mon, 25 Sep
 2023 07:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230918210631.3882376-1-jbrennen@google.com> <CAK7LNASSgCFYequw+0zQpUC-9yLHvJLHZ97Ko1ejUYZVTkM81w@mail.gmail.com>
 <20230924222019.dipusbpgntepnq2y@google.com>
In-Reply-To: <20230924222019.dipusbpgntepnq2y@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 25 Sep 2023 23:24:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNATg+cnvs9P5Ud6FPAoqQUozrGif5SJm+Pw7cs5qJ1C3gw@mail.gmail.com>
Message-ID: <CAK7LNATg+cnvs9P5Ud6FPAoqQUozrGif5SJm+Pw7cs5qJ1C3gw@mail.gmail.com>
Subject: Re: [PATCH] modpost: Optimize symbol search from linear to binary search
To:     Fangrui Song <maskray@google.com>
Cc:     Jack Brennen <jbrennen@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
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

On Mon, Sep 25, 2023 at 7:20=E2=80=AFAM Fangrui Song <maskray@google.com> w=
rote:

> However, the `- 1` part in `unsigned int hi =3D elf->symsearch->table_siz=
e - 1;` can be improved.
> I'd prefer an implementation similar to typical C++ https://en.cppreferen=
ce.com/w/cpp/algorithm/upper_bound implementation.
>
> lo =3D 0;
> hi =3D n;  // or replace hi with count
> while (lo < hi) {
>    mid =3D (lo + hi) / 2;  // we don't care about (lo+hi) overflow
>    if (less_or_eq(&table[mid], &target))
>      lo =3D mid+1;
>    else
>      hi =3D mid;
> }
>
> // lo =3D=3D hi: the index of the first element that is > target
> // if elements equal to target are present, they are on the left of lo


Ah, it is much more elegant!

Thanks.



--=20
Best Regards
Masahiro Yamada
