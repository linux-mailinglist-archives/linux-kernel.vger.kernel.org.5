Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53F178A10A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 20:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjH0Sf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 14:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjH0Sfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 14:35:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E23AC2;
        Sun, 27 Aug 2023 11:35:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AB9662BDA;
        Sun, 27 Aug 2023 18:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731BEC433C7;
        Sun, 27 Aug 2023 18:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693161333;
        bh=hthdsaMAEkjkovvMGqKX8Il/NFirqqc5w/Dlfh/wBzA=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=f6qg8bG5hCDTx2dTZFXuXMSl993MGpN8J8F8Fx5t2mK/GSk79ji5+gjSH5VMIqzT8
         bh3LnDEfLMx4JSLw7xDkIwtmpV4lkTu22/RIKOTRoQQO1JF3ArsXBP4ebCpFNb2cIp
         2qJAt7vVq3evsUxpXFWnkAgs3SllDZtWmpyd49OKIrKGhtXDYNUryrxzIrTBfl3q+y
         543ZVcusFyRpBzpsZ7tcBv1iiNAmJLc322MkoPN7kkse11Y6E2tgE0C6B4W/tzuSWA
         1PjThWyB4qGP6SkOxFgmXDGLmwH4FhRFiWbXqfVvVVdLVAQ1dU/RzYUa4ZbcoBlhzn
         vTKJcBclXEcTA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 27 Aug 2023 21:35:30 +0300
Message-Id: <CV3JLL8X7OVD.37SUDJ5IJXFN3@suppilovahvero>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 09/13] selftests/sgx: Specify freestanding
 environment for enclave compilation
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>, <kai.huang@intel.com>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230825133252.9056-1-jo.vanbulck@cs.kuleuven.be>
 <20230825133252.9056-10-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230825133252.9056-10-jo.vanbulck@cs.kuleuven.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 25, 2023 at 4:32 PM EEST, Jo Van Bulck wrote:
> Use -ffreestanding to assert the enclave compilation targets a
> freestanding environment (i.e., without "main" or standard libraries).
> This fixes clang reporting "undefined reference to `memset'" after
> erroneously optimizing away the provided memset/memcpy implementations.
>
> Still need to instruct the linker from using standard system startup
> functions, but drop -nostartfiles as it is implied by -nostdlib.
>
> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> ---
>  tools/testing/selftests/sgx/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftes=
ts/sgx/Makefile
> index 2de970f7237c..f96667bdf9f2 100644
> --- a/tools/testing/selftests/sgx/Makefile
> +++ b/tools/testing/selftests/sgx/Makefile
> @@ -14,8 +14,8 @@ endif
>  INCLUDES :=3D -I$(top_srcdir)/tools/include
>  HOST_CFLAGS :=3D -Wall -Werror -g $(INCLUDES) -fPIC
>  HOST_LDFLAGS :=3D -z noexecstack -lcrypto
> -ENCL_CFLAGS :=3D -Wall -Werror -static-pie -nostdlib -nostartfiles -fPIE=
 \
> -	       -fno-stack-protector -mrdrnd $(INCLUDES)
> +ENCL_CFLAGS :=3D -Wall -Werror -static-pie -nostdlib -ffreestanding -fPI=
E \
> +		-fno-stack-protector -mrdrnd $(INCLUDES)
>  ENCL_LDFLAGS :=3D -Wl,-T,test_encl.lds,--build-id=3Dnone
> =20
>  TEST_CUSTOM_PROGS :=3D $(OUTPUT)/test_sgx
> --=20
> 2.25.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
