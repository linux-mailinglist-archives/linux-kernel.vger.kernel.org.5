Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E177B36D0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjI2P3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjI2P3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:29:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EEEDD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:29:02 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4054496bde3so124906415e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696001340; x=1696606140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlsdSMmFq0hq8XyANQ44LEJbaHj2u6g8M8EGKwhgyF0=;
        b=D7UVSn+33qcJyN9lYbflQBuegq2Bcz0s3wETE0gqHUAlDYHPY994an+IzP1P2Lqld7
         bScQNeSCtLz8L0U7+SpEj31L9VkSy0aNJhJ/7v4c7BwoQkmw4iHxYmMUrNnQjM0I0Zbf
         yAKylfyoSYEv+cROwBsG4Jy/HfwIBhUqripW0b4Pk7m5OvyaT4TvRgAaJfA71gYK1W2e
         NomHHYxouZTxLp2wdS9e7sRWIij6gCb8El2VBU7Ay2p5kuxWUiWJc9gfs5lmD2n0hJxR
         B8I8f+qWSKR2dQanYAhsLdd6CGeUCk5VN7h0TL0C+3dnxjDa5hZ0vH1tWSgL/MKhjYVT
         /bUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696001340; x=1696606140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlsdSMmFq0hq8XyANQ44LEJbaHj2u6g8M8EGKwhgyF0=;
        b=qaztjHEA6r698CCY7fcqDfdrBogHoMOLEZShmrAu656ilLO5CYyDAujjaGNoHwvdNz
         tObFeqCYqDMuhidB66m6/DkRhV5QK4ax+AZgr5DQickmqjNZt9YDGzxrO7Vef2HSVxCl
         2l4GA8i8BUpOxTZx3JFp547Snr3MTiC3nQ9AxfJ/Cvc/NT2kunnpxy4Hoee3ET2m1XCk
         lqFY7shTXsz5s5+M9VdJT7K3f3VgX4G54/GiLwQLudLBr0Nv2u72+xHiYcsI4p8FGKgs
         iZM9aALZDPpGrXDWg0ezY9+XqzHDpXtEW7WHPrS19OeSrgdzpqVsQP2016wu6/Hy9dyH
         fbLg==
X-Gm-Message-State: AOJu0Yyi2BULK+PyKU7h4YGMd9dClT5/N/8J8scCBKiKABmEcTv4HzZa
        cAmryoYr0SWjhlHdclw3fF9/Om1DEguqYhW502SWJQ==
X-Google-Smtp-Source: AGHT+IH1/sALQzrKTtc78rISXR065F8tPVPlJg5Y1eXaliBD/UZjOWfmtvduKNjCUN7eesW+j4jQcVU4S5yk4kH2lY4=
X-Received: by 2002:a5d:4210:0:b0:317:58e4:e941 with SMTP id
 n16-20020a5d4210000000b0031758e4e941mr4094268wrq.33.1696001340349; Fri, 29
 Sep 2023 08:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230929034836.403735-1-cmllamas@google.com>
In-Reply-To: <20230929034836.403735-1-cmllamas@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Sep 2023 08:28:45 -0700
Message-ID: <CAKwvOd=r838B622q9v_e+ViRZNctqT65t7rmA5_A7+4FhYtD_w@mail.gmail.com>
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: optionally use LLVM utilities
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        John Stultz <jstultz@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 8:48=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> GNU's addr2line can have problems parsing a vmlinux built with LLVM,
> particularly when LTO was used. In order to decode the traces correctly
> this patch adds the ability to switch to LLVM's utilities readelf and
> addr2line. The same approach is followed by Will in [1].
>
> Before:
>   $ scripts/decode_stacktrace.sh vmlinux < kernel.log
>   [17716.240635] Call trace:
>   [17716.240646] skb_cow_data (??:?)
>   [17716.240654] esp6_input (ld-temp.o:?)
>   [17716.240666] xfrm_input (ld-temp.o:?)
>   [17716.240674] xfrm6_rcv (??:?)
>   [...]
>
> After:
>   $ LLVM=3D1 scripts/decode_stacktrace.sh vmlinux < kernel.log
>   [17716.240635] Call trace:
>   [17716.240646] skb_cow_data (include/linux/skbuff.h:2172 net/core/skbuf=
f.c:4503)
>   [17716.240654] esp6_input (net/ipv6/esp6.c:977)
>   [17716.240666] xfrm_input (net/xfrm/xfrm_input.c:659)
>   [17716.240674] xfrm6_rcv (net/ipv6/xfrm6_input.c:172)
>   [...]
>
> Note that one could set CROSS_COMPILE=3Dllvm- instead to hack around this
> issue. However, doing so can break the decodecode routine as it will
> force the selection of other LLVM utilities down the line e.g. llvm-as.
>
> [1] https://lore.kernel.org/all/20230914131225.13415-3-will@kernel.org/
>
> Cc: Will Deacon <will@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  scripts/decode_stacktrace.sh | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
> index 564c5632e1a2..bfe5a4082d8e 100755
> --- a/scripts/decode_stacktrace.sh
> +++ b/scripts/decode_stacktrace.sh
> @@ -16,6 +16,21 @@ elif type c++filt >/dev/null 2>&1 ; then
>         cppfilt_opts=3D-i
>  fi
>
> +UTIL_SUFFIX=3D
> +if [[ -z ${LLVM:-} ]]; then
> +       UTIL_PREFIX=3D${CROSS_COMPILE:-}
> +else
> +       UTIL_PREFIX=3Dllvm-
> +       if [[ ${LLVM} =3D=3D */ ]]; then
> +               UTIL_PREFIX=3D${LLVM}${UTIL_PREFIX}
> +       elif [[ ${LLVM} =3D=3D -* ]]; then
> +               UTIL_SUFFIX=3D${LLVM}
> +       fi
> +fi
> +
> +READELF=3D${UTIL_PREFIX}readelf${UTIL_SUFFIX}
> +ADDR2LINE=3D${UTIL_PREFIX}addr2line${UTIL_SUFFIX}
> +
>  if [[ $1 =3D=3D "-r" ]] ; then
>         vmlinux=3D""
>         basepath=3D"auto"
> @@ -75,7 +90,7 @@ find_module() {
>
>         if [[ "$modpath" !=3D "" ]] ; then
>                 for fn in $(find "$modpath" -name "${module//_/[-_]}.ko*"=
) ; do
> -                       if readelf -WS "$fn" | grep -qwF .debug_line ; th=
en
> +                       if ${READELF} -WS "$fn" | grep -qwF .debug_line ;=
 then
>                                 echo $fn
>                                 return
>                         fi
> @@ -169,7 +184,7 @@ parse_symbol() {
>         if [[ $aarray_support =3D=3D true && "${cache[$module,$address]+i=
sset}" =3D=3D "isset" ]]; then
>                 local code=3D${cache[$module,$address]}
>         else
> -               local code=3D$(${CROSS_COMPILE}addr2line -i -e "$objfile"=
 "$address" 2>/dev/null)
> +               local code=3D$(${ADDR2LINE} -i -e "$objfile" "$address" 2=
>/dev/null)
>                 if [[ $aarray_support =3D=3D true ]]; then
>                         cache[$module,$address]=3D$code
>                 fi
> --
> 2.42.0.582.g8ccd20d70d-goog
>


--=20
Thanks,
~Nick Desaulniers
