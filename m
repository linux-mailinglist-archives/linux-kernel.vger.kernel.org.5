Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B9477BF22
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 19:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjHNRii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 13:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjHNRiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:38:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C51F18F;
        Mon, 14 Aug 2023 10:38:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6FF6641BE;
        Mon, 14 Aug 2023 17:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D275C433C8;
        Mon, 14 Aug 2023 17:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692034685;
        bh=NFNbSyjv17b+lF//gANxT8L/sCCriZnvzsLC3xBq94A=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=DYPXQrxyP8fJPDfqFP5/jHAr326fZC5KdUS2IrCNuO+bmPmeS2l+E6V5oXBOUIcyw
         Q6opF8jgnu9V9HrIUrGAFRSYIajgM47cWAyIBehCYM291TO4st4Gh9OYldqZ3eidou
         97Fk1+djLpyzm9ix6uj94ScvDyIfdRm5dzODkHmKQhKydV7iTbFRHHdSex6vwXOPrD
         r7X2E8GbE9IGlrjjdupLeRCVKEluDHd0UyptM0A0o9HTyV8SjbWYrw8Ru3frHdWr6C
         Sq9qB4Mf6XFbmZDBY1XOlaWawxfKlw1fkoJYpHeGewidkdRYIrpBdIQhIzTmU2Z+x5
         t+emshCqr9l9w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 20:38:01 +0300
Message-Id: <CUSG8HX9J4L0.37OHE7QHLL9N7@suppilovahvero>
Cc:     "Mimi Zohar" <zohar@linux.ibm.com>,
        "Eric Snowberg" <eric.snowberg@oracle.com>,
        "Paul Moore" <paul@paul-moore.com>,
        <linux-security-module@vger.kernel.org>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] integrity: ignore keys failing CA restrictions
 on non-UEFI platform
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Nayna Jain" <nayna@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230813021531.1382815-1-nayna@linux.ibm.com>
 <20230813021531.1382815-3-nayna@linux.ibm.com>
In-Reply-To: <20230813021531.1382815-3-nayna@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Aug 13, 2023 at 5:15 AM EEST, Nayna Jain wrote:
> On non-UEFI platforms, handle restrict_link_by_ca failures differently.
>
> Certificates which do not satisfy CA restrictions on non-UEFI platforms
> are ignored.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-and-tested-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/platform_certs/machine_keyring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/integrity/platform_certs/machine_keyring.c b/securi=
ty/integrity/platform_certs/machine_keyring.c
> index 7aaed7950b6e..389a6e7c9245 100644
> --- a/security/integrity/platform_certs/machine_keyring.c
> +++ b/security/integrity/platform_certs/machine_keyring.c
> @@ -36,7 +36,7 @@ void __init add_to_machine_keyring(const char *source, =
const void *data, size_t
>  	 * If the restriction check does not pass and the platform keyring
>  	 * is configured, try to add it into that keyring instead.
>  	 */
> -	if (rc && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
> +	if (rc && efi_enabled(EFI_BOOT) && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM=
_KEYRING))
>  		rc =3D integrity_load_cert(INTEGRITY_KEYRING_PLATFORM, source,
>  					 data, len, perm);
> =20
> --=20
> 2.31.1

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
