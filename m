Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003257D4334
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjJWX3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJWX27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:28:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107DDF9;
        Mon, 23 Oct 2023 16:28:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEADC433C8;
        Mon, 23 Oct 2023 23:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698103732;
        bh=l4PmTWh/7uS7y7pxN04O+QuVx9DNVa5EkN2BgsFOHms=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=jzlnMJsBx/cdIlC9ABnZFTPsKalzaEyol1HC7ZI0G0x+IbSUSbwpR8WD1F65PfpBC
         Vw/Nfkl0u2xY7JiBmVyWr2IrY6Nx28xoYSMKOivoU29FYypARaWaEl/KH6ZBvbsUGo
         Dbx420uGCwiDdXACYQT6kc/1NAP+SGjZ1QdqyrgOBAflwM2M2mvrmhzb6bUiI3YoVK
         IPmlBRzaM73kozg+DFyLE7/Vcwq7bY22TPE3gKvYHSrgGre8ZAolNEoKFLToVWvBbk
         mbBfFHDsatxbb3pcAVFA/pfMop1rStlT2owvq7NW/P6RMvM/rmqCQhhXpHhWFSwLHf
         YkJP7q4YrfLgA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 24 Oct 2023 02:28:48 +0300
Message-Id: <CWG7J7N7NE6L.3MHDW81QMPYRY@suppilovahvero>
To:     "Mimi Zohar" <zohar@linux.ibm.com>,
        "Denis Glazkov" <d.glazkov@omp.ru>
Cc:     "David Howells" <dhowells@redhat.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>
Subject: Re: [RFC PATCH] certs: Only allow certs signed by keys on the
 builtin keyring
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.15.2
References: <20231017122507.185896-1-zohar@linux.ibm.com>
In-Reply-To: <20231017122507.185896-1-zohar@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Oct 17, 2023 at 3:25 PM EEST, Mimi Zohar wrote:
> Originally the secondary trusted keyring provided a keyring to which extr=
a
> keys may be added, provided those keys were not blacklisted and were
> vouched for by a key built into the kernel or already in the secondary
> trusted keyring.
>
> On systems with the machine keyring configured, additional keys may also
> be vouched for by a key on the machine keyring.
>
> Prevent loading additional certificates directly onto the secondary
> keyring, vouched for by keys on the machine keyring, yet allow these
> certificates to be loaded onto other trusted keyrings.
>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  certs/Kconfig                     | 16 +++++++++++++++-
>  crypto/asymmetric_keys/restrict.c |  4 ++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/certs/Kconfig b/certs/Kconfig
> index 4a4dc8aab892..2e621963d260 100644
> --- a/certs/Kconfig
> +++ b/certs/Kconfig
> @@ -88,7 +88,21 @@ config SECONDARY_TRUSTED_KEYRING
>  	help
>  	  If set, provide a keyring to which extra keys may be added, provided
>  	  those keys are not blacklisted and are vouched for by a key built
> -	  into the kernel or already in the secondary trusted keyring.
> +	  into the kernel, machine keyring (if configured), or already in the
> +	  secondary trusted keyring.
> +
> +config SECONDARY_TRUSTED_KEYRING_SIGNED_BY_BUILTIN
> +	bool "Only allow additional certs signed by keys on the builtin trusted=
 keyring"
> +	depends on SECONDARY_TRUSTED_KEYRING
> +	help
> +	  If set, only certificates signed by keys on the builtin trusted
> +	  keyring may be loaded onto the secondary trusted keyring.
> +
> +	  Note: The machine keyring, if configured, will be linked to the
> +	  secondary keyring.  When enabling this option, it is recommended
> +	  to also configure INTEGRITY_CA_MACHINE_KEYRING_MAX to prevent
> +	  linking code signing keys with imputed trust to the secondary
> +	  trusted keyring.
> =20
>  config SECONDARY_TRUSTED_KEYRING_FOR_CA_CERTIFICATES_ONLY
>  	bool "Allow only CA certificates to be added to the secondary trusted k=
eyring"
> diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/r=
estrict.c
> index 6b69ea40da23..afcd4d101ac5 100644
> --- a/crypto/asymmetric_keys/restrict.c
> +++ b/crypto/asymmetric_keys/restrict.c
> @@ -102,6 +102,10 @@ int restrict_link_by_signature(struct key *dest_keyr=
ing,
> =20
>  	if (use_builtin_keys && !test_bit(KEY_FLAG_BUILTIN, &key->flags))
>  		ret =3D -ENOKEY;
> +	else if (IS_BUILTIN(CONFIG_SECONDARY_TRUSTED_KEYRING_SIGNED_BY_BUILTIN)=
 &&
> +		 !strcmp(dest_keyring->description, ".secondary_trusted_keys") &&
> +		 !test_bit(KEY_FLAG_BUILTIN, &key->flags))
> +		ret =3D -ENOKEY;
>  	else
>  		ret =3D verify_signature(key, sig);
>  	key_put(key);

Plese pick this to your tree.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
