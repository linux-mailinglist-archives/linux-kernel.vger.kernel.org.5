Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494EC77BF1E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjHNRiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjHNRhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:37:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1F6170B;
        Mon, 14 Aug 2023 10:37:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A61BF64141;
        Mon, 14 Aug 2023 17:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A4EC433C8;
        Mon, 14 Aug 2023 17:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692034645;
        bh=LHvuxUi4RS4zNS43gxo6HisRbG6Z81b+jiNk7yx4v18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRsS6jInqQYknu3yxKOTH7xPoDGz80KcRLcnoP5+qinRRAotvoNURx0u3kcTg+RtN
         x2n9cbhBWo68IGoBQh/w98jCLPnScCjtVoCzcUDh/nms9JoWwXt8d1eH5Cx6xIJf9e
         +SxV1DvElnB6K9xnRcUkMoYZ5WFz4PtVwVQhEGbiEc0W6jSRrRnUvb7UZsyJ/+3VZQ
         GwFu57ibzvQvQMGd6E4CP9wX+Q+DPndgWNoHArRRQp5kasV+RSQVgS/LvRK4kQtUll
         0tSDqS684FY2F22aw4OnvxylLBJAgp8+57WYn/ohFh2krUVWSRNj4tzCKpXbNL3PHq
         lnPox45IE+Xow==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 20:37:21 +0300
Message-Id: <CUSG7ZDGZ5N4.37KMXB8BFPWKI@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Nayna Jain" <nayna@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>
Cc:     "Mimi Zohar" <zohar@linux.ibm.com>,
        "Eric Snowberg" <eric.snowberg@oracle.com>,
        "Paul Moore" <paul@paul-moore.com>,
        <linux-security-module@vger.kernel.org>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] integrity: PowerVM support for loading CA keys
 on machine keyring
X-Mailer: aerc 0.14.0
References: <20230813021531.1382815-1-nayna@linux.ibm.com>
 <20230813021531.1382815-2-nayna@linux.ibm.com>
In-Reply-To: <20230813021531.1382815-2-nayna@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Aug 13, 2023 at 5:15 AM EEST, Nayna Jain wrote:
> Keys that derive their trust from an entity such as a security officer,
> administrator, system owner, or machine owner are said to have "imputed
> trust". CA keys with imputed trust can be loaded onto the machine keyring=
.
> The mechanism for loading these keys onto the machine keyring is platform
> dependent.
>
> Load keys stored in the variable trustedcadb onto the .machine keyring
> on PowerVM platform.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-and-tested-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  .../integrity/platform_certs/keyring_handler.c  |  8 ++++++++
>  .../integrity/platform_certs/keyring_handler.h  |  5 +++++
>  .../integrity/platform_certs/load_powerpc.c     | 17 +++++++++++++++++
>  3 files changed, 30 insertions(+)
>
> diff --git a/security/integrity/platform_certs/keyring_handler.c b/securi=
ty/integrity/platform_certs/keyring_handler.c
> index 8a1124e4d769..1649d047e3b8 100644
> --- a/security/integrity/platform_certs/keyring_handler.c
> +++ b/security/integrity/platform_certs/keyring_handler.c
> @@ -69,6 +69,14 @@ __init efi_element_handler_t get_handler_for_mok(const=
 efi_guid_t *sig_type)
>  	return NULL;
>  }
> =20
> +__init efi_element_handler_t get_handler_for_ca_keys(const efi_guid_t *s=
ig_type)
> +{
> +	if (efi_guidcmp(*sig_type, efi_cert_x509_guid) =3D=3D 0)
> +		return add_to_machine_keyring;
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
> index 212d894a8c0c..6f15bb4cc8dc 100644
> --- a/security/integrity/platform_certs/keyring_handler.h
> +++ b/security/integrity/platform_certs/keyring_handler.h
> @@ -29,6 +29,11 @@ efi_element_handler_t get_handler_for_db(const efi_gui=
d_t *sig_type);
>   */
>  efi_element_handler_t get_handler_for_mok(const efi_guid_t *sig_type);
> =20
> +/*
> + * Return the handler for particular signature list types for CA keys.
> + */
> +efi_element_handler_t get_handler_for_ca_keys(const efi_guid_t *sig_type=
);
> +
>  /*
>   * Return the handler for particular signature list types found in the d=
bx.
>   */
> diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/=
integrity/platform_certs/load_powerpc.c
> index 170789dc63d2..6263ce3b3f1e 100644
> --- a/security/integrity/platform_certs/load_powerpc.c
> +++ b/security/integrity/platform_certs/load_powerpc.c
> @@ -59,6 +59,7 @@ static __init void *get_cert_list(u8 *key, unsigned lon=
g keylen, u64 *size)
>  static int __init load_powerpc_certs(void)
>  {
>  	void *db =3D NULL, *dbx =3D NULL, *data =3D NULL;
> +	void *trustedca =3D NULL;

Could this be just "void *trustedca;" ?

>  	u64 dsize =3D 0;
>  	u64 offset =3D 0;
>  	int rc =3D 0;
> @@ -120,6 +121,22 @@ static int __init load_powerpc_certs(void)
>  		kfree(data);
>  	}
> =20
> +	data =3D get_cert_list("trustedcadb", 12,  &dsize);
> +	if (!data) {
> +		pr_info("Couldn't get trustedcadb list from firmware\n");
> +	} else if (IS_ERR(data)) {
> +		rc =3D PTR_ERR(data);
> +		pr_err("Error reading trustedcadb from firmware: %d\n", rc);
> +	} else {
> +		extract_esl(trustedca, data, dsize, offset);
> +
> +		rc =3D parse_efi_signature_list("powerpc:trustedca", trustedca, dsize,
> +					      get_handler_for_ca_keys);
> +		if (rc)
> +			pr_err("Couldn't parse trustedcadb signatures: %d\n", rc);
> +		kfree(data);
> +	}
> +
>  	return rc;
>  }
>  late_initcall(load_powerpc_certs);
> --=20
> 2.31.1

BR, Jarkko
