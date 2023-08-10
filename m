Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46F4777C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbjHJPiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbjHJPiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:38:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2655E125;
        Thu, 10 Aug 2023 08:38:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B90F166064;
        Thu, 10 Aug 2023 15:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DB7C433C8;
        Thu, 10 Aug 2023 15:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691681929;
        bh=xnhTYpWPIFOHSG3sk7givZEYBgSpBgHnBgsNcE+4edw=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=bqQ66ydZ97kMwJSbyiqdJXhdFJImIqG1tDWd2g0EI+CMMAa6fEZba1i0OVQbv/h2S
         jXwC+xUG6l7x3FPFotosyygXgry40zyrgpKF8CxO9XxDKhm+1wC1MRmJ9IPkwiHxPT
         tbKLI991PilX3gXXVPNurkACT6n3xSkD6g5WqfLv8EmYERYfkUNqr15XxgyiGd8KIu
         wj0HXAmoYdwqN5fTeoinZlT9oZY5TXxbAhyFLSSe11vhcC13uMoN2cPKiOu7iR7Fnf
         LFEJzjSy1uq++EY9nul1ZmFZ+7cGFQZxgRbQnD6QyM2UxgxmP8Gi6hvGelObSjK17e
         3m+X18AH1x19A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 18:38:39 +0300
Message-Id: <CUOZ6XAVQ7DS.2UB3SEOKGXOBX@wks-101042-mac.ad.tuni.fi>
Subject: Re: [PATCH v2 3/6] integrity: remove global variable from
 machine_keyring.c
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Nayna Jain" <nayna@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>
Cc:     "Mimi Zohar" <zohar@linux.ibm.com>,
        "Eric Snowberg" <eric.snowberg@oracle.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20230809195315.1085656-1-nayna@linux.ibm.com>
 <20230809195315.1085656-4-nayna@linux.ibm.com>
In-Reply-To: <20230809195315.1085656-4-nayna@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 9, 2023 at 10:53 PM EEST, Nayna Jain wrote:
> trust_mok variable is accessed within a single function locally.
>
> Change trust_mok from global to local static variable.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-and-tested-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/platform_certs/machine_keyring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/integrity/platform_certs/machine_keyring.c b/securi=
ty/integrity/platform_certs/machine_keyring.c
> index 389a6e7c9245..9482e16cb2ca 100644
> --- a/security/integrity/platform_certs/machine_keyring.c
> +++ b/security/integrity/platform_certs/machine_keyring.c
> @@ -8,8 +8,6 @@
>  #include <linux/efi.h>
>  #include "../integrity.h"
> =20
> -static bool trust_mok;
> -
>  static __init int machine_keyring_init(void)
>  {
>  	int rc;
> @@ -65,9 +63,11 @@ static __init bool uefi_check_trust_mok_keys(void)
>  bool __init trust_moklist(void)
>  {
>  	static bool initialized;
> +	static bool trust_mok;
> =20
>  	if (!initialized) {
>  		initialized =3D true;
> +		trust_mok =3D false;
> =20
>  		if (uefi_check_trust_mok_keys())
>  			trust_mok =3D true;

Nice catch.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
