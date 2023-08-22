Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF25A784277
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjHVNww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbjHVNww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:52:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A751B9;
        Tue, 22 Aug 2023 06:52:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FD1F656E1;
        Tue, 22 Aug 2023 13:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B56FC433C8;
        Tue, 22 Aug 2023 13:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692712360;
        bh=YzLaCmClh/kthvSkr231iUB47ivUYlUZTI93ZVPO1Aw=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Xv86NiVJL0UIRMRHHqzYGKVamDEosHJ15fZyFUcNxwo2+/HJjJLW6Cekg6rylMsZE
         BOHh7HSkiZ+CiLgnvAtLFP3r7NCvuHVQWiHpkUs/F4h9OessD8sJvMyM+gPHWH/q3F
         KBictTPTNbxBt+dSaF+icZkrwmLe+z+PrB6rO4V03xUGCURi7Tf6W4Gl/uh5YRnX/G
         B/vNgtshsaKxZLPRBqjT2HrENPHJJk/9AGE5W/QFPao6qaWfl9cys0WotLsDnPqEad
         ZzLp8dlPAzAQ9bND8/DSR45U9wKL2ZWkVQOneqPI1zN+6InjpXsTKwC77ViAZ6wWS8
         Js89xzfiAsl5A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Aug 2023 16:52:36 +0300
Message-Id: <CUZ4G9FRXIW1.23TJD5ASQBUNE@suppilovahvero>
Cc:     <jejb@linux.ibm.com>, <zohar@linux.ibm.com>,
        <jens.wiklander@linaro.org>, <sudeep.holla@arm.com>,
        <achin.gupta@arm.com>, <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: trusted: tee: Refactor register SHM usage
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Sumit Garg" <sumit.garg@linaro.org>,
        <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230822112933.1550062-1-sumit.garg@linaro.org>
In-Reply-To: <20230822112933.1550062-1-sumit.garg@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 22, 2023 at 2:29 PM EEST, Sumit Garg wrote:
> The OP-TEE driver using the old SMC based ABI permits overlapping shared
> buffers, but with the new FF-A based ABI each physical page may only
> be registered once.
>
> As the key and blob buffer are allocated adjancently, there is no need
> for redundant register shared memory invocation. Also, it is incompatibil=
e
> with FF-A based ABI limitation. So refactor register shared memory
> implementation to use only single invocation to register both key and blo=
b
> buffers.
>
> Fixes: 4615e5a34b95 ("optee: add FF-A support")
> Reported-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Does this retain backwards compatibility?

> ---
>  security/keys/trusted-keys/trusted_tee.c | 64 ++++++++----------------
>  1 file changed, 20 insertions(+), 44 deletions(-)
>
> diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/tru=
sted-keys/trusted_tee.c
> index ac3e270ade69..aa3d477de6db 100644
> --- a/security/keys/trusted-keys/trusted_tee.c
> +++ b/security/keys/trusted-keys/trusted_tee.c
> @@ -65,24 +65,16 @@ static int trusted_tee_seal(struct trusted_key_payloa=
d *p, char *datablob)
>  	int ret;
>  	struct tee_ioctl_invoke_arg inv_arg;
>  	struct tee_param param[4];
> -	struct tee_shm *reg_shm_in =3D NULL, *reg_shm_out =3D NULL;
> +	struct tee_shm *reg_shm =3D NULL;
> =20
>  	memset(&inv_arg, 0, sizeof(inv_arg));
>  	memset(&param, 0, sizeof(param));
> =20
> -	reg_shm_in =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
> -						 p->key_len);
> -	if (IS_ERR(reg_shm_in)) {
> -		dev_err(pvt_data.dev, "key shm register failed\n");
> -		return PTR_ERR(reg_shm_in);
> -	}
> -
> -	reg_shm_out =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->blob,
> -						  sizeof(p->blob));
> -	if (IS_ERR(reg_shm_out)) {
> -		dev_err(pvt_data.dev, "blob shm register failed\n");
> -		ret =3D PTR_ERR(reg_shm_out);
> -		goto out;
> +	reg_shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
> +					      sizeof(p->key) + sizeof(p->blob));
> +	if (IS_ERR(reg_shm)) {
> +		dev_err(pvt_data.dev, "shm register failed\n");
> +		return PTR_ERR(reg_shm);
>  	}
> =20
>  	inv_arg.func =3D TA_CMD_SEAL;
> @@ -90,13 +82,13 @@ static int trusted_tee_seal(struct trusted_key_payloa=
d *p, char *datablob)
>  	inv_arg.num_params =3D 4;
> =20
>  	param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> -	param[0].u.memref.shm =3D reg_shm_in;
> +	param[0].u.memref.shm =3D reg_shm;
>  	param[0].u.memref.size =3D p->key_len;
>  	param[0].u.memref.shm_offs =3D 0;
>  	param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> -	param[1].u.memref.shm =3D reg_shm_out;
> +	param[1].u.memref.shm =3D reg_shm;
>  	param[1].u.memref.size =3D sizeof(p->blob);
> -	param[1].u.memref.shm_offs =3D 0;
> +	param[1].u.memref.shm_offs =3D sizeof(p->key);
> =20
>  	ret =3D tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
>  	if ((ret < 0) || (inv_arg.ret !=3D 0)) {
> @@ -107,11 +99,7 @@ static int trusted_tee_seal(struct trusted_key_payloa=
d *p, char *datablob)
>  		p->blob_len =3D param[1].u.memref.size;
>  	}
> =20
> -out:
> -	if (reg_shm_out)
> -		tee_shm_free(reg_shm_out);
> -	if (reg_shm_in)
> -		tee_shm_free(reg_shm_in);
> +	tee_shm_free(reg_shm);
> =20
>  	return ret;
>  }
> @@ -124,24 +112,16 @@ static int trusted_tee_unseal(struct trusted_key_pa=
yload *p, char *datablob)
>  	int ret;
>  	struct tee_ioctl_invoke_arg inv_arg;
>  	struct tee_param param[4];
> -	struct tee_shm *reg_shm_in =3D NULL, *reg_shm_out =3D NULL;
> +	struct tee_shm *reg_shm =3D NULL;
> =20
>  	memset(&inv_arg, 0, sizeof(inv_arg));
>  	memset(&param, 0, sizeof(param));
> =20
> -	reg_shm_in =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->blob,
> -						 p->blob_len);
> -	if (IS_ERR(reg_shm_in)) {
> -		dev_err(pvt_data.dev, "blob shm register failed\n");
> -		return PTR_ERR(reg_shm_in);
> -	}
> -
> -	reg_shm_out =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
> -						  sizeof(p->key));
> -	if (IS_ERR(reg_shm_out)) {
> -		dev_err(pvt_data.dev, "key shm register failed\n");
> -		ret =3D PTR_ERR(reg_shm_out);
> -		goto out;
> +	reg_shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
> +					      sizeof(p->key) + sizeof(p->blob));
> +	if (IS_ERR(reg_shm)) {
> +		dev_err(pvt_data.dev, "shm register failed\n");
> +		return PTR_ERR(reg_shm);
>  	}
> =20
>  	inv_arg.func =3D TA_CMD_UNSEAL;
> @@ -149,11 +129,11 @@ static int trusted_tee_unseal(struct trusted_key_pa=
yload *p, char *datablob)
>  	inv_arg.num_params =3D 4;
> =20
>  	param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> -	param[0].u.memref.shm =3D reg_shm_in;
> +	param[0].u.memref.shm =3D reg_shm;
>  	param[0].u.memref.size =3D p->blob_len;
> -	param[0].u.memref.shm_offs =3D 0;
> +	param[0].u.memref.shm_offs =3D sizeof(p->key);
>  	param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> -	param[1].u.memref.shm =3D reg_shm_out;
> +	param[1].u.memref.shm =3D reg_shm;
>  	param[1].u.memref.size =3D sizeof(p->key);
>  	param[1].u.memref.shm_offs =3D 0;
> =20
> @@ -166,11 +146,7 @@ static int trusted_tee_unseal(struct trusted_key_pay=
load *p, char *datablob)
>  		p->key_len =3D param[1].u.memref.size;
>  	}
> =20
> -out:
> -	if (reg_shm_out)
> -		tee_shm_free(reg_shm_out);
> -	if (reg_shm_in)
> -		tee_shm_free(reg_shm_in);
> +	tee_shm_free(reg_shm);
> =20
>  	return ret;
>  }
> --=20
> 2.34.1

BR, Jarkko
