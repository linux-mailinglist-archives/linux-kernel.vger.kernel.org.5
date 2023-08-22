Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027E0783DA2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjHVKLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjHVKLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:11:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084ECCD0;
        Tue, 22 Aug 2023 03:10:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FB8F633A0;
        Tue, 22 Aug 2023 10:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD499C433C8;
        Tue, 22 Aug 2023 10:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692699028;
        bh=OlIDWf01BL+/Ezuk9SoDTvgO4c2C63kFlK6C+hAdPCk=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=J7/vTggRaMK+PUeUetmzUBMg1zDolQCrFNqIOZad2p6OHmEW98jaxnevflhWrW+aJ
         3OBOILEtQ9SwPOLQmxxsBvTSwSYEfp4Uy9CnBjZ36tTbr7hM8+ZINNahM0y9AYAt8q
         HKp1saMbXyKypdhX/2E4d0tIQSXYz19iQs+EX1SxU+QufNqy9ZlEi+5wMV0Bw63sjd
         eHSXa3KGTSOU2l8eSNejNJcbPGUgBxecxBvjraZI9aQqyVATnmhMYQnZPNnMLazfgs
         Or0/qj35uVx7ocx6HL2585GogBCQk3hZ8Trk/eR5Mxz7fbiQh8pggdxDj4PdnDwE6W
         UynjrKnx6wyAQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Aug 2023 13:10:25 +0300
Message-Id: <CUYZQ5FWX0Q0.2DOQOB96T7H7@suppilovahvero>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 5/9] selftests/sgx: Include memory clobber for inline
 asm in test enclave
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>, <kai.huang@intel.com>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230819094332.8535-1-jo.vanbulck@cs.kuleuven.be>
 <20230819094332.8535-6-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230819094332.8535-6-jo.vanbulck@cs.kuleuven.be>
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
> Add the "memory" clobber to the EMODPE and EACCEPT asm blocks to tell the
> compiler the assembly code accesses to the secinfo struct. This ensures
> the compiler treats the asm block as a memory barrier and the write to
> secinfo will be visible to ENCLU.
>
> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> ---
>  tools/testing/selftests/sgx/test_encl.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/self=
tests/sgx/test_encl.c
> index 7633fb7cb..b09550cb3 100644
> --- a/tools/testing/selftests/sgx/test_encl.c
> +++ b/tools/testing/selftests/sgx/test_encl.c
> @@ -24,10 +24,11 @@ static void do_encl_emodpe(void *_op)
>  	secinfo.flags =3D op->flags;
> =20
>  	asm volatile(".byte 0x0f, 0x01, 0xd7"
> -				:
> +				: /* no outputs */
>  				: "a" (EMODPE),
>  				  "b" (&secinfo),
> -				  "c" (op->epc_addr));
> +				  "c" (op->epc_addr)
> +				: "memory" /* read from secinfo pointer */);
>  }
> =20
>  static void do_encl_eaccept(void *_op)
> @@ -42,7 +43,8 @@ static void do_encl_eaccept(void *_op)
>  				: "=3Da" (rax)
>  				: "a" (EACCEPT),
>  				  "b" (&secinfo),
> -				  "c" (op->epc_addr));
> +				  "c" (op->epc_addr)
> +				: "memory" /* read from secinfo pointer */);
> =20
>  	op->ret =3D rax;
>  }
> --=20
> 2.25.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
