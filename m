Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9117782E5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjHJVyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjHJVyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:54:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159FAED;
        Thu, 10 Aug 2023 14:54:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8B1863AB5;
        Thu, 10 Aug 2023 21:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E3BC433C8;
        Thu, 10 Aug 2023 21:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691704450;
        bh=zHlbC4DhGyvqqyiP84nv86Xr6u7c4WwQ5xngbfFhFuk=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=kmF1F8xDR5Lmybalh/o8eQmpCMGiYsVpMq6CJcn6OamF7Spr1QQHH8WlyEzGrMlfv
         kW0MjOhksTi1L4FoVEo1p2qPGJrEdfFUyshVyUfOEY0CCjEtCCi56sLJwLS0MOAgfH
         eSMQbcFzNXIvFYm7M9n80PUs1Nf38rLfvvw2R/ivjrtuFDTkM4SSeyfrbqN9cRVO19
         Pzg5ekjcVkNZHdIDO6o/R3EjkFOjX7Wq7Ymo3b87C6wIS3TNdfNWbmYAViw/ZF6qF5
         ZZHnKFD14FrPOLFgWwFDEu9XWJAujA/9LHHe1vLX4kB9Rc+Ai9BjgQKa31mCXNOmiu
         8apXYvpiXlzCg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Aug 2023 00:54:05 +0300
Subject: Re: [PATCH v2 6/6] integrity: PowerVM support for loading third
 party code signing keys
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Nayna Jain" <nayna@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>
Cc:     "Mimi Zohar" <zohar@linux.ibm.com>,
        "Eric Snowberg" <eric.snowberg@oracle.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <CUP754GCFF2H.15G672KXVX5AJ@suppilovahvero>
X-Mailer: aerc 0.14.0
References: <20230809195315.1085656-1-nayna@linux.ibm.com>
 <20230809195315.1085656-7-nayna@linux.ibm.com>
In-Reply-To: <20230809195315.1085656-7-nayna@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 9, 2023 at 10:53 PM EEST, Nayna Jain wrote:
> On secure boot enabled PowerVM LPAR, third party code signing keys are
> needed during early boot to verify signed third party modules. These
> third party keys are stored in moduledb object in the Platform
> KeyStore(PKS).
          ^ space

>
> Load third party code signing keys onto .secondary_trusted_keys keyring.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  certs/system_keyring.c                        | 23 +++++++++++++++++++
>  include/keys/system_keyring.h                 |  7 ++++++
>  security/integrity/integrity.h                |  1 +
>  .../platform_certs/keyring_handler.c          |  8 +++++++
>  .../platform_certs/keyring_handler.h          |  5 ++++
>  .../integrity/platform_certs/load_powerpc.c   | 18 ++++++++++++++-
>  6 files changed, 61 insertions(+), 1 deletion(-)
>
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index b348e0898d34..3435d4936fb2 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -396,3 +396,26 @@ void __init set_platform_trusted_keys(struct key *ke=
yring)
>  	platform_trusted_keys =3D keyring;
>  }
>  #endif
> +

spurious newline character

> +void __init add_to_secondary_keyring(const char *source, const void *dat=
a,
> +				     size_t len)

Documentation is lacking, and should be in a single line, as it totals
less than 100 characters.

> +{
> +	key_ref_t key;
> +	key_perm_t perm; the following structure
> +	int rc =3D 0;

	int rc;

> +
> +	perm =3D (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW;
> +
> +	key =3D key_create_or_update(make_key_ref(secondary_trusted_keys, 1),
> +				   "asymmetric",
> +				   NULL, data, len, perm,
> +				   KEY_ALLOC_NOT_IN_QUOTA);
> +	if (IS_ERR(key)) {
> +		rc =3D PTR_ERR(key);

This helper variable is not very useful.

> +		pr_err("Problem loading X.509 certificate %d\n", rc);

Why pr_err()? What kind of object is "a problem"?

Also X.509 certificates are everywhere. If these are printed to the
klog, how can e.g. an admin deduce the problem over here?

Even without having these log messages at all I could trace the called
function and be informed that some X.509 cert has an issues. Actually
then I could even deduce the location, thanks to call backtrace.

These have a potential to lead into wrong conclusions.

> +	} else {
> +		pr_notice("Loaded X.509 cert '%s'\n",
> +			  key_ref_to_ptr(key)->description);

single line

> +		key_ref_put(key);
> +	}

I'd suggest instead the following structure:

	if (IS_ERR(key)) {
		pr_err("Problem loading X.509 certificate %d\n", PTR_ERR(key));
		return;
	}

	pr_notice("Loaded X.509 cert '%s'\n", key_ref_to_ptr(key)->description);
	key_ref_put(key);
}

BR, Jarkko
