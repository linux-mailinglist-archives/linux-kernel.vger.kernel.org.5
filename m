Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9F4783DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbjHVKL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjHVKL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:11:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C574CDD;
        Tue, 22 Aug 2023 03:11:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ED3C6512E;
        Tue, 22 Aug 2023 10:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6990AC433C8;
        Tue, 22 Aug 2023 10:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692699103;
        bh=K0TMXM4eZSYf0xtIfbRyMYChh6lzNYF33b/EHKuem48=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=KW6T1KozRx4OkS0pLY1XDTmQbh75KWysgSM3hYzb5fMSvtrXI42nOJdU4n59cqiA2
         eXl2HO7QhsEudGf4EPWW0BEZNrzVsKXy8JNRqm2hLX/F1aih6BEdixrDHVH2oWxnEw
         kWCshYYqGTdMfDx7beZsNiiUehhA3e8U98JbONXHYydgi43UUz2elwq5boGL8fn19x
         Gt8Vm/2yQMc+S+Js97zZSJwN6TcVS2sNt5bg5pPzFmR4YA7DbBMRPzg24v8g96toTG
         CTAEb9PN+iiH0TEvXmpXu79wX3be8+MIcnfP+UFMQ76e8lyrXQCv8k2EMSqTQFTh+R
         qInKDUWTDU99w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Aug 2023 13:11:40 +0300
Message-Id: <CUYZR3S5XMLT.2NW0TKQ5CU2B1@suppilovahvero>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 7/9] selftests/sgx: Ensure expected location of test
 enclave buffer
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>, <kai.huang@intel.com>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230819094332.8535-1-jo.vanbulck@cs.kuleuven.be>
 <20230819094332.8535-8-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230819094332.8535-8-jo.vanbulck@cs.kuleuven.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Aug 19, 2023 at 12:43 PM EEST, Jo Van Bulck wrote:
> The external tests manipulating page permissions expect encl_buffer to be
> placed at the start of the test enclave's .data section. As this is not
> guaranteed per the C standard, explicitly place encl_buffer in a separate
> section that is explicitly placed at the start of the .data segment in th=
e
> linker script to avoid the compiler placing it somewhere else in .data.
>
> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> ---
>  tools/testing/selftests/sgx/defines.h     | 1 +
>  tools/testing/selftests/sgx/test_encl.c   | 8 ++++----
>  tools/testing/selftests/sgx/test_encl.lds | 1 +
>  3 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selfte=
sts/sgx/defines.h
> index b8f482667..402f8787a 100644
> --- a/tools/testing/selftests/sgx/defines.h
> +++ b/tools/testing/selftests/sgx/defines.h
> @@ -14,6 +14,7 @@
>  #define __aligned(x) __attribute__((__aligned__(x)))
>  #define __packed __attribute__((packed))
>  #define __used __attribute__((used))
> +#define __section(x)__attribute__((__section__(x)))
> =20
>  #include "../../../../arch/x86/include/asm/sgx.h"
>  #include "../../../../arch/x86/include/asm/enclu.h"
> diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/self=
tests/sgx/test_encl.c
> index c7bcbc85b..151600353 100644
> --- a/tools/testing/selftests/sgx/test_encl.c
> +++ b/tools/testing/selftests/sgx/test_encl.c
> @@ -6,11 +6,11 @@
> =20
>  /*
>   * Data buffer spanning two pages that will be placed first in the .data
> - * segment. Even if not used internally the second page is needed by ext=
ernal
> - * test manipulating page permissions, so mark encl_buffer as "used" to =
make
> - * sure it is entirely preserved by the compiler.
> + * segment via the linker script. Even if not used internally the second=
 page
> + * is needed by external test manipulating page permissions, so mark
> + * encl_buffer as "used" to make sure it is entirely preserved by the co=
mpiler.
>   */
> -static uint8_t __used encl_buffer[8192] =3D { 1 };
> +static uint8_t __used __section(".data.encl_buffer") encl_buffer[8192] =
=3D { 1 };
> =20
>  enum sgx_enclu_function {
>  	EACCEPT =3D 0x5,
> diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/se=
lftests/sgx/test_encl.lds
> index 13144b045..ffe851a1c 100644
> --- a/tools/testing/selftests/sgx/test_encl.lds
> +++ b/tools/testing/selftests/sgx/test_encl.lds
> @@ -24,6 +24,7 @@ SECTIONS
>  	} : text
> =20
>  	.data : {
> +		*(.data.encl_buffer)
>  		*(.data*)
>  	} : data
> =20
> --=20
> 2.25.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
