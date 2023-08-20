Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2EE78201E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 23:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjHTVIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 17:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjHTVIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 17:08:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39495588;
        Sun, 20 Aug 2023 14:06:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3912C60F96;
        Sun, 20 Aug 2023 21:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E3BC433C7;
        Sun, 20 Aug 2023 21:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692565567;
        bh=PBuqF2N309GDrRdll1czvJXNpOEd5IjVqSK/jMX6XTE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eliHNnPtGTZ2q8ZGydQIsNd5Y72ERl6sgMTZHgEmB3YgllspT5s3eQyYR7mnVVrR4
         /n1CQB7E8np/9+S3N/M4oHw6u4lho8AcWOxwhSIhQpw1XDQWNe9riCGo6EQIRvIngP
         rCGHQuhb9Hqbfo0b24HGec2P8RNlEAeFbJD6pBgSjAz1ixHO/nXV1v+g8SDm+JKT87
         sk9DugfYYvCYXwXPzZ0UHhnzy2VVD9JSfl0PpJ8TnkO2Bb3yzkPqvnZlHOnAjAKYIm
         HEsK0UDciTV8836ieRi+4Tqmsm3bP33i4/us1xESxUsKacGzhlxTBHk3ENm+D6yckI
         6lGsXgAjYAC0A==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1c4f47810c6so1492444fac.0;
        Sun, 20 Aug 2023 14:06:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YxsLNgpMdXrc3xIk2c737hwbNnuOWxsnZQBpg3J81iEZrgCvWS7
        j01sS9hzcfUWtZHxQQ0r+eIOf5ADa8vrtDmk1zA=
X-Google-Smtp-Source: AGHT+IFk9LRqYvL9Uk7Aw73iv3VPsqJ8P0z5AvSsrfnDvUPwfw911PQrwC4kCjaLsHIqlQZe67oX2y5Hz19KPf6BCos=
X-Received: by 2002:a05:6870:830e:b0:1b4:7411:5c0c with SMTP id
 p14-20020a056870830e00b001b474115c0cmr5441250oae.13.1692565566803; Sun, 20
 Aug 2023 14:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230820091505.3812160-1-masahiroy@kernel.org>
In-Reply-To: <20230820091505.3812160-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 21 Aug 2023 06:05:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNARk52-MvsPSjgQV3vDXpv2RXpeg0vkzMJAsLR1yQwr7Qw@mail.gmail.com>
Message-ID: <CAK7LNARk52-MvsPSjgQV3vDXpv2RXpeg0vkzMJAsLR1yQwr7Qw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: deb-pkg: support DEB_BUILD_OPTIONS=parallel=N in debian/rules
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bastian Germann <bage@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
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

On Mon, Aug 21, 2023 at 1:20=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> 'make srcdeb-pkg' generates a source package, which you can build
> later by using dpkg-buildpackage.
>
> In older dpkg versions, 'dpkg-buildpackage -j N' sets not only
> DEB_BUILD_OPTIONS but also MAKEFLAGS. Hence, passing -j (--jobs)
> to dpkg-buildpackage was enough to run parallel building.
>
> The behavior was changed by commit 1d0ea9b2ba3f ("dpkg-buildpackage:
> Change -j, --jobs semantics to non-force mode") of dpkg project. [1]
>
> Since then, 'dpkg-buildpackage -j N' sets only DEB_BUILD_OPTIONS,
> which is not parsed by the current debian/rules. You cannot build it
> in parallel unless you pass --jobs-force instead or set the MAKEFLAGS
> environment variable.
>
> Debian policy [2] suggests the following code snippet for debian/rules.
>
>   ifneq (,$(filter parallel=3D%,$(DEB_BUILD_OPTIONS)))
>       NUMJOBS =3D $(patsubst parallel=3D%,%,$(filter parallel=3D%,$(DEB_B=
UILD_OPTIONS)))
>       MAKEFLAGS +=3D -j$(NUMJOBS)
>   endif
>
> I added slightly different code to debian/rules so 'make -j N deb-pkg'
> works as before. In this case, the '-j N' should not be specified in
> debian/rules again. 'make deb-pkg' without the -j option must explicitly
> pass -j1 to dpkb-buildpackage because otherwise DEB_BUILD_OPTIONS
> contains parallel=3D<nproc> by default.
>
> This should work with almost all Make versions Kbuild supports.
>
> Only the corner case I found not working is 'make-3.82 -j deb-pkg',
> which results in single thread building. It is not a big deal because
> -j without an argument, which does not limit the number of jobs, is
> rarely used.
>
> As far as I tested, the MAKEFLAGS format varies by Make versions.
>
>                  command line option         $(MAKEFLAGS) in recipe
>  Make 3.82            -j                            j
>                       -j1                         <none>
>                       -j2                          -j
>  Make 4.0/4.1         -j                           -j
>                       -j1                         <none>
>                       -j2                          -j
>  Make 4.2+            -j                           -j
>                       -j1                          -j1
>                       -j2                          -j2



On second thought, this is not a good idea.

I will send v2 with a different solution.





--=20
Best Regards
Masahiro Yamada
