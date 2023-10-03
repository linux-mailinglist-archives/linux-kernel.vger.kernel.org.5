Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77C07B6810
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbjJCLgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240081AbjJCLgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:36:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A929B;
        Tue,  3 Oct 2023 04:36:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F68C433C9;
        Tue,  3 Oct 2023 11:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696332965;
        bh=vVhh3lazos4QYD8OzBfvDW/vTxlOEhK1alN6r8Iu4og=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NYf7GAJjcUTUSOB2IJvUQtgk5LXcKerAafqHsuLvdtNPmib6dr+mEeBF+S6Ah3okt
         G3ow6F/4X6q7jU2iTj8KFOeWjkJDevaokihQ/6Bbcv70jF3RmgH5Wz1PFWDCbZCD0X
         zbKSb4FWk0fEG8KyOYy2k6duGgiVM1WTQXDmymczXcf+ycOI0vLGGlNbT6C0AEokFY
         06cca1d09oMrlSIITHFCHuQ65JuZ5+A3qkLxgr8nYaEeB74OpCQdWpePvqjnB++Tp6
         6vh4r7pV7nKQv4Q40QOrMQNp3W1A/nOZIMIu3xAunjwQA6J7yi5Fr3dIZ1tH+GmzKK
         582IWche71omQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-57e3c2adbf0so451615eaf.2;
        Tue, 03 Oct 2023 04:36:05 -0700 (PDT)
X-Gm-Message-State: AOJu0YyhKDaX7jkU/lMFrfGZhIhYeZiOLqDzBCt+EGj1Nej4euUzvbWy
        X6AvNcSHYCD1DA2XOUENgw21SYTBlFTGNq17ldM=
X-Google-Smtp-Source: AGHT+IEyBjh7n7rNz1XH86vxqaWNI5MD9ZJVLAEl+X5mnqiV1GcBTUEXSudGPTiIBKiWWskpHdvTFWbK3wh8sKJbWXg=
X-Received: by 2002:a05:6870:d10d:b0:1c7:ebf5:b6cb with SMTP id
 e13-20020a056870d10d00b001c7ebf5b6cbmr16807308oac.25.1696332964877; Tue, 03
 Oct 2023 04:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNARd_pRWWso49C4MoahFAM9idyOFC+9ZFYdpS87CA4UTqQ@mail.gmail.com>
 <20230926124044.3522663-1-jbrennen@google.com>
In-Reply-To: <20230926124044.3522663-1-jbrennen@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 3 Oct 2023 20:35:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNARbPoTVG83kuHzD1mkwWn5Rqth1iYhfXbnsrk2LOvyHYg@mail.gmail.com>
Message-ID: <CAK7LNARbPoTVG83kuHzD1mkwWn5Rqth1iYhfXbnsrk2LOvyHYg@mail.gmail.com>
Subject: Re: [PATCH] modpost: Optimize symbol search from linear to binary search
To:     Jack Brennen <jbrennen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, maskray@google.com, cleger@rivosinc.com,
        kernel-team@android.com, joe@perches.com
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

On Tue, Sep 26, 2023 at 9:40=E2=80=AFPM Jack Brennen <jbrennen@google.com> =
wrote:
>
> Modify modpost to use binary search for converting addresses back
> into symbol references.  Previously it used linear search.
>
> This change saves a few seconds of wall time for defconfig builds,
> but can save several minutes on allyesconfigs.
>
> Before:
> $ make LLVM=3D1 -j128 allyesconfig vmlinux -s KCFLAGS=3D"-Wno-error"
> $ time scripts/mod/modpost -M -m -a -N -o vmlinux.symvers vmlinux.o
> 198.38user 1.27system 3:19.71elapsed
>
> After:
> $ make LLVM=3D1 -j128 allyesconfig vmlinux -s KCFLAGS=3D"-Wno-error"
> $ time scripts/mod/modpost -M -m -a -N -o vmlinux.symvers vmlinux.o
> 11.91user 0.85system 0:12.78elapsed
>
> Signed-off-by: Jack Brennen <jbrennen@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>



Applied to linux-kbuild.
Thanks.



--=20
Best Regards
Masahiro Yamada
