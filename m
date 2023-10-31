Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9D37DC648
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjJaGJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjJaGJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:09:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E02FF;
        Mon, 30 Oct 2023 23:09:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC6EC43395;
        Tue, 31 Oct 2023 06:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698732571;
        bh=775+5HnV3K8GgaKubQHWtyriSEwbJwYL+QzF6FBBk38=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a1W86bZXJCAr6gQY9Uu8ExXwKnD9hcsjukwgI8ALrNqJrg0xjrwwYphhSxJVeNt4u
         EO0j4G93QCHGhbfOkWpiZ8Iilb5c9IFBGlwt/8Zz5ogx0mvSZtZrLicfFF2mi39bAD
         Bh56jALhIuFMUxFmpSw3O7pAuodE/emq77GLxrlOMzaiwVR9De2HzcSgWRss3zBiBO
         8YdYEu+aXL4FZotEfBn869ZobOHvYwnoL7E9rDEZqPdaoLTCXFT5io9CPPKZ/icwv3
         HJcXSSWLygz7yAY1v/1WCi+UmQNzyQOrMBJyJ5H0S8UTMTaWpA8Ap1a+yHf7Gctbb0
         FJE5er42OHGuQ==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ce2c5b2154so3468647a34.3;
        Mon, 30 Oct 2023 23:09:30 -0700 (PDT)
X-Gm-Message-State: AOJu0YytZPCtGEv1af5C830IouVXyJoAS7NFPYjUNS/xaIILY+oEp79v
        wqwe0+PjRkRwkCsdPTLFYLP51a22B8Svw8IkZv0=
X-Google-Smtp-Source: AGHT+IG2/T3/z336SoyHXPy/49vQHhwQuOguhxuhYDRWMiQAwsES07tlf1Nd3lWT2zS8OHio36eMlg7yinZEhY/ZaUU=
X-Received: by 2002:a05:6870:1244:b0:1d6:cd8a:d99e with SMTP id
 4-20020a056870124400b001d6cd8ad99emr12925471oao.0.1698732569686; Mon, 30 Oct
 2023 23:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231030083222.28509-1-msuchanek@suse.de>
In-Reply-To: <20231030083222.28509-1-msuchanek@suse.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 31 Oct 2023 15:08:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQRQ41bXiBFViXE94gObx+3qu5xQxWTXKfO6NYj=v0=9A@mail.gmail.com>
Message-ID: <CAK7LNAQRQ41bXiBFViXE94gObx+3qu5xQxWTXKfO6NYj=v0=9A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: dummy-tools: Add support for -fpatchable-function-entry
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 5:32=E2=80=AFPM Michal Suchanek <msuchanek@suse.de>=
 wrote:
>
> dummy-gcc does not produce the output
> gcc-check-fpatchable-function-entry.sh expects. Add a base64 encoded
> output of the second test.
>
> Fixes: 0f71dcfb4aef ("powerpc/ftrace: Add support for -fpatchable-functio=
n-entry")
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---



I prefer this one
https://lore.kernel.org/linux-kbuild/20231030113416.5208-1-jirislaby@kernel=
.org/T/#u


Does it work for you?





>  scripts/dummy-tools/gcc | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/scripts/dummy-tools/gcc b/scripts/dummy-tools/gcc
> index 07f6dc4c5cf6..8ab81a905cc2 100755
> --- a/scripts/dummy-tools/gcc
> +++ b/scripts/dummy-tools/gcc
> @@ -73,6 +73,25 @@ if arg_contain -Wa,--version "$@"; then
>         exit 0
>  fi
>
> +if arg_contain -fpatchable-function-entry=3D2 "$@"; then
> +       base64 -d <<-EOF
> +       CS5maWxlCSI8c3RkaW4+IgoJLm1hY2hpbmUgcG93ZXI4CgkuYWJpdmVyc2lvbiAyC=
gkuc2VjdGlv
> +       bgkiLnRleHQiCgkuYWxpZ24gMgoJLnAyYWxpZ24gNCwsMTUKCS5nbG9ibCBmdW5jC=
gkudHlwZQlm
> +       dW5jLCBAZnVuY3Rpb24KZnVuYzoKLkxGQjA6CgkuY2ZpX3N0YXJ0cHJvYwouTENGM=
DoKMDoJYWRk
> +       aXMgMiwxMiwuVE9DLi0uTENGMEBoYQoJYWRkaSAyLDIsLlRPQy4tLkxDRjBAbAoJL=
mxvY2FsZW50
> +       cnkJZnVuYywuLWZ1bmMKCS5zZWN0aW9uCV9fcGF0Y2hhYmxlX2Z1bmN0aW9uX2Vud=
HJpZXMsImF3
> +       byIsQHByb2diaXRzLC5MUEZFMAoJLmFsaWduIDMKCS44Ynl0ZQkuTFBGRTAKCS5zZ=
WN0aW9uCSIu
> +       dGV4dCIKLkxQRkUwOgoJbm9wCglub3AKCWFkZGlzIDksMiwuTEFOQ0hPUjBAdG9jQ=
GhhCglsd2Eg
> +       MywuTEFOQ0hPUjBAdG9jQGwoOSkKCWJscgoJLmxvbmcgMAoJLmJ5dGUgMCwwLDAsM=
CwwLDAsMCww
> +       CgkuY2ZpX2VuZHByb2MKLkxGRTA6Cgkuc2l6ZQlmdW5jLC4tZnVuYwoJLmdsb2JsI=
HgKCS5zZWN0
> +       aW9uCSIuYnNzIgoJLmFsaWduIDIKCS5zZXQJLkxBTkNIT1IwLC4gKyAwCgkudHlwZ=
Ql4LCBAb2Jq
> +       ZWN0Cgkuc2l6ZQl4LCA0Cng6CgkuemVybwk0CgkuaWRlbnQJIkdDQzogKFNVU0UgT=
GludXgpIDEz
> +       LjIuMSAyMDIzMDkxMiBbcmV2aXNpb24gYjk2ZTY2ZmQ0ZWYzZTM2OTgzOTY5ZmI4Y=
2RkMTk1NmY1
> +       NTFhMDc0Yl0iCgkuc2VjdGlvbgkubm90ZS5HTlUtc3RhY2ssIiIsQHByb2diaXRzC=
g=3D=3D
> +       EOF
> +       exit 0
> +fi
> +
>  if arg_contain -S "$@"; then
>         # For scripts/gcc-x86-*-has-stack-protector.sh
>         if arg_contain -fstack-protector "$@"; then
> --
> 2.42.0
>


--=20
Best Regards
Masahiro Yamada
