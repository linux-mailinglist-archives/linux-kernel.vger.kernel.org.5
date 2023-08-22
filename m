Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6D9783DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjHVKLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjHVKLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:11:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7577C18B;
        Tue, 22 Aug 2023 03:11:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CC2B61301;
        Tue, 22 Aug 2023 10:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDFEC433C8;
        Tue, 22 Aug 2023 10:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692699060;
        bh=wNC0A6kL7exuR/rOZgM/K3PhTbqHuSNFdCbXpOCmezw=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=N6UJNcuuIRkcxE4cc7BePowDjaOXDNSQNUUbT+DG+qojGXTJ+Qplsj7kX9JB242Bc
         gOW3RK5VSP3vg/YR3dHPap6wdeVBYYUqq6hM3GTzLPoM9MkrdCj2CXR8bBwi68TWMK
         YQz//pCIMpTVP/PbviIdACxWHlKytqMDvQ4spT1BxtPGscIFesOIbxfhlOyn+CVu81
         2NbEcLIF+7EyQAcvNfw7PSrmSkc5j37XGYidlmx6LnbXn7Kth10p95ANkJAdqlJlyR
         Wcae4xKp6F0vm3Yc2A7S7MZoPtIS099E2BwJRUB10YZ9vVEk9f8pA+cijNF/NtrrMx
         oNh6d9ld+unGA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Aug 2023 13:10:57 +0300
Message-Id: <CUYZQJXJCJGP.PBVMRZTU12QJ@suppilovahvero>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 6/9] selftests/sgx: Ensure test enclave buffer is
 entirely preserved
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>, <kai.huang@intel.com>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230819094332.8535-1-jo.vanbulck@cs.kuleuven.be>
 <20230819094332.8535-7-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230819094332.8535-7-jo.vanbulck@cs.kuleuven.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Aug 19, 2023 at 12:43 PM EEST, Jo Van Bulck wrote:
> Attach the "used" attribute to instruct the compiler to preserve the stat=
ic
> encl_buffer, even if it appears it is not entirely referenced in the encl=
ave
> code, as expected by the external tests manipulating page permissions.
>
> Link: https://lore.kernel.org/all/a2732938-f3db-a0af-3d68-a18060f66e79@cs=
.kuleuven.be/
> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> ---
>  tools/testing/selftests/sgx/defines.h   | 1 +
>  tools/testing/selftests/sgx/test_encl.c | 9 +++++----
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selfte=
sts/sgx/defines.h
> index d8587c971..b8f482667 100644
> --- a/tools/testing/selftests/sgx/defines.h
> +++ b/tools/testing/selftests/sgx/defines.h
> @@ -13,6 +13,7 @@
> =20
>  #define __aligned(x) __attribute__((__aligned__(x)))
>  #define __packed __attribute__((packed))
> +#define __used __attribute__((used))
> =20
>  #include "../../../../arch/x86/include/asm/sgx.h"
>  #include "../../../../arch/x86/include/asm/enclu.h"
> diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/self=
tests/sgx/test_encl.c
> index b09550cb3..c7bcbc85b 100644
> --- a/tools/testing/selftests/sgx/test_encl.c
> +++ b/tools/testing/selftests/sgx/test_encl.c
> @@ -5,11 +5,12 @@
>  #include "defines.h"
> =20
>  /*
> - * Data buffer spanning two pages that will be placed first in .data
> - * segment. Even if not used internally the second page is needed by
> - * external test manipulating page permissions.
> + * Data buffer spanning two pages that will be placed first in the .data
> + * segment. Even if not used internally the second page is needed by ext=
ernal
> + * test manipulating page permissions, so mark encl_buffer as "used" to =
make
> + * sure it is entirely preserved by the compiler.
>   */
> -static uint8_t encl_buffer[8192] =3D { 1 };
> +static uint8_t __used encl_buffer[8192] =3D { 1 };
> =20
>  enum sgx_enclu_function {
>  	EACCEPT =3D 0x5,
> --=20
> 2.25.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
