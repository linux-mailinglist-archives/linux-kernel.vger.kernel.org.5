Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2457B5DE1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbjJBXuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjJBXuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:50:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D450C83;
        Mon,  2 Oct 2023 16:49:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5F8C433C7;
        Mon,  2 Oct 2023 23:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696290599;
        bh=eQvzq/pyS6uCjfM+/FiGWMp1HvzJv5UeqBTNXcKGofk=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=o/uS8mTR05XyRyW1FTe8g6gAfL7zScnEBWG2EA1KCNnytQJGScEr2D3O+kMJxM7t+
         ErYQEi5tKdIkvtphMRBW9sCXukBQ0pEYAua3U8OumbGxaPAKHTf9B2LSLKvqh5Lpop
         yfUN0rEX0qDIxsMIqzR6H5j2rg5AEvL2fc752J/5p5gY/xoBbqO/7AoFCfxUdVGwB+
         /Wv1j4tXVsMZKdjWaMOJkVkCFiXif3NiaMvGMoJnnegBmZHR9bq9HkPmUAt+qHjxQp
         5+AScyrsAWH2hA/n5qqRdA45AF2TQTry9T1dvfClQVKyIO8U7JGv5gx11NdCLvxE6B
         CGxi57HMHZa3w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 03 Oct 2023 02:49:53 +0300
Message-Id: <CVYCTWRQAXDF.2HY5028ZT9FEC@seitikki>
Cc:     "dhowells@redhat.com" <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sergey Shtylyov" <s.shtylyov@omp.ru>
Subject: Re: [PATCH v3] certs: Add option to disallow non-CA certificates in
 secondary trusted keying
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Denis Glazkov" <d.glazkov@omp.ru>
X-Mailer: aerc 0.14.0
References: <CVS5MB3X82Q8.8KDB4346ROR5@suppilovahvero>
 <20231002104525.7631-1-d.glazkov@omp.ru>
In-Reply-To: <20231002104525.7631-1-d.glazkov@omp.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Oct 2, 2023 at 1:46 PM EEST, Denis Glazkov wrote:
> The Linux kernel has an IMA (Integrity Measurement Architecture)
> subsystem to check the integrity of the file system based on digital
> signatures. IMA uses certificates in `.ima` keying to check integrity.
>
> Only certificates issued by one of the trusted CA (Certificate Authority)
> certificates can be added to the `.ima` keying.
>
> The Linux kernel now has a secondary trusted keying to which trusted
> certificates from user space can be added if you have superuser
> privileges. Previously, all trusted certificates were in the built-in
> trusted keying, which could not be modified from user space.
> Trusted certificates were placed in the built-in trusted keying at
> kernel compile time.
>
> The secondary trusted keying is designed so that any certificates that
> are signed by one of the trusted CA certificates in the built-in or
> secondary trusted keyring can be added to it.
>
> Let's imagine that we have the following certificate trust chain:
>
>              =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=90
>              =E2=94=82                           =E2=94=82     =E2=94=8C=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90   =
    =E2=94=82
>              =E2=94=82                           =E2=94=82     =E2=94=82 =
      =E2=94=82       =E2=94=82
> =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90    =E2=94=8C=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90=
  =E2=94=82 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> =E2=94=82.builtin_trusted_keys=E2=94=82=E2=97=84=E2=94=80=E2=94=80=E2=94=
=80=E2=94=A4.secondary_trusted_keys =E2=94=9C=E2=94=80=E2=94=80=E2=94=98 =
=E2=94=82   .ima    =E2=94=82
> =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4    =E2=94=9C=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4=
    =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> =E2=94=82     Root CA Cert    =E2=94=82-----=E2=96=BA Intermediate CA Cer=
t  =E2=94=82-----=E2=96=BA IMA Cert =E2=94=82
> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98    =E2=94=94=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98=
    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>
>                 Issues                  Restricted by
>             -------------=E2=96=BA             =E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=96=BA
>
> Since the IMA certificate is signed by a CA certificate from a secondary
> trusted keying, an attacker with superuser privileges will be able to
> add the IMA certificate to the secondary trusted keying. That is, the IMA
> certificate will become trusted.
>
> Since, with `CONFIG_MODULE_SIG` option enabled, modules can only be
> loaded into kernel space if they are signed with one of the trusted
> certificates, an attacker could sign untrusted kernel modules with
> the private key corresponding to the IMA certificate and successfully
> load the untrusted modules into kernel space.
>
> This patch was created not to solve only the problem of loading
> untrusted kernel modules, but to make it possible to use a secondary
> trusted keying only as a part of a chain of trust containing only
> CA certificates with no digital signature capability. This will
> help avoid similar problems when new features appear in the linux
> kernel that are similar to kernel modules in terms of their impact
> on system security, which will also use trusted certificates for
> signature verification.
>
> This patch adds the configuration that once enabled, only
> certificates that meet the following requirements can be added
> to the secondary trusted keying:
>
> 1. The certificate is a CA (Certificate Authority)
> 2. The certificate must be used for verifying a CA's signatures
> 3. The certificate must not be used for digital signatures
>
> Signed-off-by: Denis Glazkov <d.glazkov@omp.ru>
> ---
> v1 -> v2:
>  - Rebase the patch from `linux-next` to the main `linux` repo master bra=
nch
>  - Make the commit message more detailed
>  - Move the variable declaration to the `if` block
>  - Replace `#ifdef` with `IS_ENABLED` macro
>
> v2 -> v3:
>  - Add the purpose and goal of the patch to the commit message
> ---
>  certs/Kconfig          |  9 +++++++++
>  certs/system_keyring.c | 16 ++++++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/certs/Kconfig b/certs/Kconfig
> index 1f109b070877..4a4dc8aab892 100644
> --- a/certs/Kconfig
> +++ b/certs/Kconfig
> @@ -90,6 +90,15 @@ config SECONDARY_TRUSTED_KEYRING
>  	  those keys are not blacklisted and are vouched for by a key built
>  	  into the kernel or already in the secondary trusted keyring.
> =20
> +config SECONDARY_TRUSTED_KEYRING_FOR_CA_CERTIFICATES_ONLY
> +	bool "Allow only CA certificates to be added to the secondary trusted k=
eyring"
> +	depends on SECONDARY_TRUSTED_KEYRING
> +	help
> +	  If set, only CA certificates can be added to the secondary trusted ke=
yring.
> +	  An acceptable CA certificate must include the `keyCertSign` value in
> +	  the `keyUsage` field. CA certificates that include the `digitalSignat=
ure`
> +	  value in the `keyUsage` field will not be accepted.
> +
>  config SYSTEM_BLACKLIST_KEYRING
>  	bool "Provide system-wide ring of blacklisted keys"
>  	depends on KEYS
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 9de610bf1f4b..ee14447374e7 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -99,6 +99,22 @@ int restrict_link_by_builtin_and_secondary_trusted(
>  		/* Allow the builtin keyring to be added to the secondary */
>  		return 0;
> =20
> +	if (IS_ENABLED(CONFIG_SECONDARY_TRUSTED_KEYRING_FOR_CA_CERTIFICATES_ONL=
Y) &&
> +	    dest_keyring =3D=3D secondary_trusted_keys) {
> +		const struct public_key *pub =3D payload->data[asym_crypto];
> +
> +		if (type !=3D &key_type_asymmetric)
> +			return -EOPNOTSUPP;
> +		if (!pub)
> +			return -ENOPKG;
> +		if (!test_bit(KEY_EFLAG_CA, &pub->key_eflags))
> +			return -EPERM;
> +		if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pub->key_eflags))
> +			return -EPERM;
> +		if (test_bit(KEY_EFLAG_DIGITALSIG, &pub->key_eflags))
> +			return -EPERM;
> +	}
> +
>  	return restrict_link_by_signature(dest_keyring, type, payload,
>  					  secondary_trusted_keys);
>  }
> --=20
> 2.34.1

I don't think this does any harm. What do you think Mimi?

BR, Jarkko
