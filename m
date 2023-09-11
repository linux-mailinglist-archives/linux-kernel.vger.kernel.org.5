Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D27679C3A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241783AbjILDER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241362AbjILDD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:03:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDC1F9F5A;
        Mon, 11 Sep 2023 18:37:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2359C116A9;
        Mon, 11 Sep 2023 22:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694469695;
        bh=t0v/8DwhZ2XTEQS0bqVLXsYjSFysr5rhj5sH1kGkl+U=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Jqu8WLZlx+u3A+ZjgZ4w+1ZrSjel5diyioaKxfCD3EU4XjjB2m/aNRfzgYqQuUCmO
         hNRXEjBrfRAV8+ZFgysEQt3/HLfNMErWaCdVpTGeYgwNreWYltqqDDf7rq41cntP0W
         imp1fr8hgHnuu4othbADNuOgzJgb7YPbleLcAen5LQRUWNXz1P9QfWof9QDLU5B+uS
         S3B1NVPN3ieNkEFr6+lmY3qWgIhKHZHsrKls42c8YqkevUmzbRPeXOp32QAkslaNRX
         P7PjG0CH64wEI5u0QrXzYO/kSKQ3Xxob7bbvsGHYvsPJFyEJqW3ugQ6iNTjjWLSRj2
         A1cXjKiQ7b+Kg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 01:01:31 +0300
Message-Id: <CVGFDI2VELSN.2E98O6TF5TZ0E@suppilovahvero>
Cc:     <mic@linux.microsoft.com>, <kanth.ghatraju@oracle.com>,
        <konrad.wilk@oracle.com>, <linux-integrity@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] certs: Restrict blacklist updates to the secondary
 trusted keyring
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Eric Snowberg" <eric.snowberg@oracle.com>, <zohar@linux.ibm.com>,
        <dhowells@redhat.com>, <dwmw2@infradead.org>
X-Mailer: aerc 0.14.0
References: <20230908213428.731513-1-eric.snowberg@oracle.com>
In-Reply-To: <20230908213428.731513-1-eric.snowberg@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Sep 9, 2023 at 12:34 AM EEST, Eric Snowberg wrote:
> Currently root can dynamically update the blacklist keyring if the hash
> being added is signed and vouched for by the builtin trusted keyring.
> Currently keys in the secondary trusted keyring can not be used.
>
> Keys within the secondary trusted keyring carry the same capabilities as
> the builtin trusted keyring.  Relax the current restriction for updating
> the .blacklist keyring and allow the secondary to also be referenced as
> a trust source.  Since the machine keyring is linked to the secondary
> trusted keyring, any key within it may also be used.
>
> An example use case for this is IMA appraisal.  Now that IMA both
> references the blacklist keyring and allows the machine owner to add
> custom IMA CA certs via the machine keyring, this adds the additional
> capability for the machine owner to also do revocations on a running
> system.
>
> IMA appraisal usage example to add a revocation for /usr/foo:
>
> sha256sum /bin/foo | awk '{printf "bin:" $1}' > hash.txt
>
> openssl smime -sign -in hash.txt -inkey machine-private-key.pem \
>        -signer machine-certificate.pem -noattr -binary -outform DER \
>        -out hash.p7s
>
> keyctl padd blacklist "$(< hash.txt)" %:.blacklist < hash.p7s
>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  certs/Kconfig     | 2 +-
>  certs/blacklist.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/certs/Kconfig b/certs/Kconfig
> index 1f109b070877..23dc87c52aff 100644
> --- a/certs/Kconfig
> +++ b/certs/Kconfig
> @@ -134,7 +134,7 @@ config SYSTEM_BLACKLIST_AUTH_UPDATE
>  	depends on SYSTEM_DATA_VERIFICATION
>  	help
>  	  If set, provide the ability to load new blacklist keys at run time if
> -	  they are signed and vouched by a certificate from the builtin trusted
> +	  they are signed and vouched by a certificate from the secondary trust=
ed
>  	  keyring.  The PKCS#7 signature of the description is set in the key
>  	  payload.  Blacklist keys cannot be removed.
> =20
> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index 675dd7a8f07a..0b346048ae2d 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -102,12 +102,12 @@ static int blacklist_key_instantiate(struct key *ke=
y,
> =20
>  #ifdef CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE
>  	/*
> -	 * Verifies the description's PKCS#7 signature against the builtin
> +	 * Verifies the description's PKCS#7 signature against the secondary
>  	 * trusted keyring.
>  	 */
>  	err =3D verify_pkcs7_signature(key->description,
>  			strlen(key->description), prep->data, prep->datalen,
> -			NULL, VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
> +			VERIFY_USE_SECONDARY_KEYRING, VERIFYING_UNSPECIFIED_SIGNATURE, NULL, =
NULL);
>  	if (err)
>  		return err;
>  #else
> --=20
> 2.39.3

What if a live system in the wild assumes the old policy? I feel that
this is "sort of" breaking backwards compatibility but please prove me
wrong.

BR, Jarkko
