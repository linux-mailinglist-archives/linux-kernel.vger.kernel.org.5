Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2156780025
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355428AbjHQVsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355495AbjHQVsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:48:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741FF1FF3;
        Thu, 17 Aug 2023 14:48:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECC5B61AC3;
        Thu, 17 Aug 2023 21:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7B3C433C8;
        Thu, 17 Aug 2023 21:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692308909;
        bh=bexJ/xREDVWvZmu+lu8XL2wVApfsd/lRowROzQZizoc=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=DEBtayWkbf820tXs6npe3l1kydGysurs82ZhdJ046kH4/0n2Tga8dbgPpaWymLVVm
         wbAh3DD/ZYklGV8PE9XptJijDDarWoCERbZglkf6nHXnzdPvmOTi3dDia1ZIqE1+1b
         MHLA0S/dBZrzYmfEWqdLvRdZZpVxBKiDa/WqpZbVOtDXdFIctcoUUL6pHv8Xyizee8
         4FgALKGCCGjpWKoBuOt8/yQUsLkcvL+g+IBo4Sz3ri7uWbsdAhgcEEirVzPGhV0tJ0
         ddajm0l3zYAFXl2O4WCaJyftSIN9aFdV5pFLwBRaS13Yc9phxiI4wvVUdMZXKKGf4B
         uCZl4IeEREStw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 18 Aug 2023 00:48:24 +0300
Message-Id: <CUV5FU612TVH.3U5BOWZR013CD@suppilovahvero>
Cc:     "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] integrity: Annotate struct ima_rule_opt_list with
 __counted_by
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Kees Cook" <keescook@chromium.org>,
        "Mimi Zohar" <zohar@linux.ibm.com>
X-Mailer: aerc 0.14.0
References: <20230817210327.never.598-kees@kernel.org>
In-Reply-To: <20230817210327.never.598-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 18, 2023 at 12:03 AM EEST, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct ima_rule_opt_lis=
t.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  security/integrity/ima/ima_policy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index 69452b79686b..f69062617754 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -68,7 +68,7 @@ enum policy_rule_list { IMA_DEFAULT_POLICY =3D 1, IMA_C=
USTOM_POLICY };
> =20
>  struct ima_rule_opt_list {
>  	size_t count;
> -	char *items[];
> +	char *items[] __counted_by(count);
>  };
> =20
>  /*
> @@ -342,6 +342,7 @@ static struct ima_rule_opt_list *ima_alloc_rule_opt_l=
ist(const substring_t *src)
>  		kfree(src_copy);
>  		return ERR_PTR(-ENOMEM);
>  	}
> +	opt_list->count =3D count;
> =20
>  	/*
>  	 * strsep() has already replaced all instances of '|' with '\0',
> @@ -357,7 +358,6 @@ static struct ima_rule_opt_list *ima_alloc_rule_opt_l=
ist(const substring_t *src)
>  		opt_list->items[i] =3D cur;
>  		cur =3D strchr(cur, '\0') + 1;
>  	}
> -	opt_list->count =3D count;
> =20
>  	return opt_list;
>  }
> --=20
> 2.34.1

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
