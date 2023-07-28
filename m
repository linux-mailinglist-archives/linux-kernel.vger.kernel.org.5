Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91200767600
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjG1TF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjG1TF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:05:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419763C0A;
        Fri, 28 Jul 2023 12:05:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9C58621DB;
        Fri, 28 Jul 2023 19:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E896C433C8;
        Fri, 28 Jul 2023 19:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690571154;
        bh=6X3IgvgIJ77SD3GGAxQ9qFcuzFD8mWqa8dZ4Z1RQOcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bkndYAvc941UXNZ36XGL88924t5zeKBMsQXni6rtYmFqy89yuEEeOt9rAHz8Vl7Gh
         Cr7IKko/8XqV92lDsUcTAHECdsh1vD7QdAWBEGFFYpy6vpjG9SK3BrWngVQlDgipl5
         Qe0n69S7N6HdwXETnOyS+rpBBa0YpVVxxgJ3uZT0Pvz20oanLMvGuinTfDBHu+4Wdb
         oQEReqWU2AV4oiXc5eEipGsCcRlE6zsjjwAgc59zj/+kawhcdgWKm2/20pZDz0UIHA
         PKBtc16XDufoI9HqtLzZCn7+VHvT8PXkx+ebYuksRN3bziudh2d7oDc5uWsCzxGBrX
         FyuQqCdtdsALA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 19:05:51 +0000
Message-Id: <CUE1GHCIZXGV.28B1TA9UD7WH9@seitikki>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 3/5] selftests/sgx: Ensure correct secinfo struct
 alignment in test enclave.
X-Mailer: aerc 0.14.0
References: <20230724165832.15797-1-jo.vanbulck@cs.kuleuven.be>
 <20230724165832.15797-4-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230724165832.15797-4-jo.vanbulck@cs.kuleuven.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jul 24, 2023 at 4:58 PM UTC, Jo Van Bulck wrote:
> Declare the secinfo struct as volatile to prevent compiler optimizations
> from passing an unaligned pointer to ENCLU.
>
> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> ---
>  tools/testing/selftests/sgx/test_encl.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/self=
tests/sgx/test_encl.c
> index 4e31a6c3d673..aba301abefb8 100644
> --- a/tools/testing/selftests/sgx/test_encl.c
> +++ b/tools/testing/selftests/sgx/test_encl.c
> @@ -18,7 +18,8 @@ enum sgx_enclu_function {
> =20
>  static void do_encl_emodpe(void *_op)
>  {
> -	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) =3D {0=
};
> +	/* declare secinfo volatile to preserve alignment */
> +	volatile struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo=
)) =3D {0};
>  	struct encl_op_emodpe *op =3D _op;
> =20
>  	secinfo.flags =3D op->flags;
> @@ -32,7 +33,8 @@ static void do_encl_emodpe(void *_op)
> =20
>  static void do_encl_eaccept(void *_op)
>  {
> -	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) =3D {0=
};
> +	/* declare secinfo volatile to preserve alignment */
> +	volatile struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo=
)) =3D {0};
>  	struct encl_op_eaccept *op =3D _op;
>  	int rax;
> =20
> --=20
> 2.34.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
