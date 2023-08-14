Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4922977BF2C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjHNRm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjHNRmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:42:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE992127;
        Mon, 14 Aug 2023 10:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7455463299;
        Mon, 14 Aug 2023 17:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333A5C433C7;
        Mon, 14 Aug 2023 17:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692034953;
        bh=oDKfWtRlcLNAQvkh08JvEm0sUUNG09qXf8Rgaq35i9M=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=TM9tRruOG2GkGbjnVZfsj/Cy5lYvUjoTDROpltW23y0uB89Yl0WsA6+VRKrtxVdqf
         X534Ysx3accRjTJnuYDnnLGwykvYQXqccUCaqm/w7lelnzhzT9eWaJ8dJnc9fVT8j3
         0mQJ7xCHFHhz+OYU7i/EHDAWmCevL3nTuK+inLfL/dNVDnsaufl4qLzaMtODT1kSaA
         vLhIKAzu6s5ma2HiqKbLrd6KflQKLEvgNIBCBS5659OGFuNhAsFLuU2LmRGu5g83PL
         UpCbM0s6ILJA+ncuz1uLsGUkkrGaUHfKcwQ8pzDYPDhixy98MeWHxTw4bV3Jv1QsSk
         lBAYP5OGqNa1g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 20:42:30 +0300
Message-Id: <CUSGBX9YASR6.1HQHWGQOS3B6Z@suppilovahvero>
Cc:     "Mimi Zohar" <zohar@linux.ibm.com>,
        "Eric Snowberg" <eric.snowberg@oracle.com>,
        "Paul Moore" <paul@paul-moore.com>,
        <linux-security-module@vger.kernel.org>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] integrity: PowerVM support for loading third
 party code signing keys
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Nayna Jain" <nayna@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230813021531.1382815-1-nayna@linux.ibm.com>
 <20230813021531.1382815-7-nayna@linux.ibm.com>
In-Reply-To: <20230813021531.1382815-7-nayna@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Aug 13, 2023 at 5:15 AM EEST, Nayna Jain wrote:
> On secure boot enabled PowerVM LPAR, third party code signing keys are
> needed during early boot to verify signed third party modules. These
> third party keys are stored in moduledb object in the Platform
> KeyStore(PKS).
>
> Load third party code signing keys onto .secondary_trusted_keys keyring.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  certs/system_keyring.c                        | 30 +++++++++++++++++++
>  include/keys/system_keyring.h                 |  7 +++++
>  security/integrity/integrity.h                |  1 +
>  .../platform_certs/keyring_handler.c          |  8 +++++
>  .../platform_certs/keyring_handler.h          |  5 ++++
>  .../integrity/platform_certs/load_powerpc.c   | 18 ++++++++++-
>  6 files changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index b348e0898d34..e458d414918d 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -396,3 +396,33 @@ void __init set_platform_trusted_keys(struct key *ke=
yring)
>  	platform_trusted_keys =3D keyring;
>  }
>  #endif
> +
> +/**
> + * add_to_secondary_keyring - Add to secondary keyring.
> + * @source: Source of key
> + * @data: The blob holding the key
> + * @len: The length of the data blob
> + *
> + * Add a key to the secondary keyring. The key must be vouched for by a =
key in the builtin,
> + * machine or secondary keyring itself.
> + */
> +void __init add_to_secondary_keyring(const char *source, const void *dat=
a, size_t len)
> +{
> +	key_ref_t key;
> +	key_perm_t perm;
> +
> +	perm =3D (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW;
> +
> +	key =3D key_create_or_update(make_key_ref(secondary_trusted_keys, 1),
> +				   "asymmetric",
> +				   NULL, data, len, perm,
> +				   KEY_ALLOC_NOT_IN_QUOTA);
> +	if (IS_ERR(key)) {
> +		pr_err("Problem loading X.509 certificate from %s to secondary keyring=
 %ld\n",
> +		       source, PTR_ERR(key));
> +		return;
> +	}
> +
> +	pr_notice("Loaded X.509 cert '%s'\n", key_ref_to_ptr(key)->description)=
;
> +	key_ref_put(key);
> +}
> diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.=
h
> index 7e2583208820..4188f75d1bac 100644
> --- a/include/keys/system_keyring.h
> +++ b/include/keys/system_keyring.h
> @@ -50,9 +50,16 @@ int restrict_link_by_digsig_builtin_and_secondary(stru=
ct key *keyring,
>  						  const struct key_type *type,
>  						  const union key_payload *payload,
>  						  struct key *restriction_key);
> +void __init add_to_secondary_keyring(const char *source, const void *dat=
a,
> +				     size_t len);
> +
>  #else
>  #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_=
builtin_trusted
>  #define restrict_link_by_digsig_builtin_and_secondary restrict_link_by_d=
igsig_builtin
> +void __init add_to_secondary_keyring(const char *source, const void *dat=
a,
> +				     size_t len)
> +{
> +}
>  #endif
> =20
>  #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
> diff --git a/security/integrity/integrity.h b/security/integrity/integrit=
y.h
> index d7553c93f5c0..efaa2eb789ad 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -228,6 +228,7 @@ static inline int __init integrity_load_cert(const un=
signed int id,
>  {
>  	return 0;
>  }
> +
>  #endif /* CONFIG_INTEGRITY_SIGNATURE */
> =20
>  #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
> diff --git a/security/integrity/platform_certs/keyring_handler.c b/securi=
ty/integrity/platform_certs/keyring_handler.c
> index 586027b9a3f5..13ea17207902 100644
> --- a/security/integrity/platform_certs/keyring_handler.c
> +++ b/security/integrity/platform_certs/keyring_handler.c
> @@ -78,6 +78,14 @@ __init efi_element_handler_t get_handler_for_ca_keys(c=
onst efi_guid_t *sig_type)
>  	return NULL;
>  }
> =20
> +__init efi_element_handler_t get_handler_for_code_signing_keys(const efi=
_guid_t *sig_type)
> +{
> +	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) =3D=3D 0)
> +		return add_to_secondary_keyring;
> +
> +	return NULL;
> +}
> +
>  /*
>   * Return the appropriate handler for particular signature list types fo=
und in
>   * the UEFI dbx and MokListXRT tables.
> diff --git a/security/integrity/platform_certs/keyring_handler.h b/securi=
ty/integrity/platform_certs/keyring_handler.h
> index 6f15bb4cc8dc..f92895cc50f6 100644
> --- a/security/integrity/platform_certs/keyring_handler.h
> +++ b/security/integrity/platform_certs/keyring_handler.h
> @@ -34,6 +34,11 @@ efi_element_handler_t get_handler_for_mok(const efi_gu=
id_t *sig_type);
>   */
>  efi_element_handler_t get_handler_for_ca_keys(const efi_guid_t *sig_type=
);
> =20
> +/*
> + * Return the handler for particular signature list types for code signi=
ng keys.
> + */
> +efi_element_handler_t get_handler_for_code_signing_keys(const efi_guid_t=
 *sig_type);
> +
>  /*
>   * Return the handler for particular signature list types found in the d=
bx.
>   */
> diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/=
integrity/platform_certs/load_powerpc.c
> index 6263ce3b3f1e..32c4e5fbf0fb 100644
> --- a/security/integrity/platform_certs/load_powerpc.c
> +++ b/security/integrity/platform_certs/load_powerpc.c
> @@ -59,7 +59,7 @@ static __init void *get_cert_list(u8 *key, unsigned lon=
g keylen, u64 *size)
>  static int __init load_powerpc_certs(void)
>  {
>  	void *db =3D NULL, *dbx =3D NULL, *data =3D NULL;
> -	void *trustedca =3D NULL;
> +	void *trustedca =3D NULL, *moduledb =3D NULL;

The patch looks otherwise good but I'm not sure about this initialization.

>  	u64 dsize =3D 0;
>  	u64 offset =3D 0;
>  	int rc =3D 0;
> @@ -137,6 +137,22 @@ static int __init load_powerpc_certs(void)
>  		kfree(data);
>  	}
> =20
> +	data =3D get_cert_list("moduledb", 9,  &dsize);
> +	if (!data) {
> +		pr_info("Couldn't get moduledb list from firmware\n");
> +	} else if (IS_ERR(data)) {
> +		rc =3D PTR_ERR(data);
> +		pr_err("Error reading moduledb from firmware: %d\n", rc);
> +	} else {
> +		extract_esl(moduledb, data, dsize, offset);
> +
> +		rc =3D parse_efi_signature_list("powerpc:moduledb", moduledb, dsize,
> +					      get_handler_for_code_signing_keys);
> +		if (rc)
> +			pr_err("Couldn't parse moduledb signatures: %d\n", rc);
> +		kfree(data);
> +	}
> +
>  	return rc;
>  }
>  late_initcall(load_powerpc_certs);
> --=20
> 2.31.1

BR, Jarkko

