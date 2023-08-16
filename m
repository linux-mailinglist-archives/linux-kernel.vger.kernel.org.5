Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD5A77EB5A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346374AbjHPVFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346398AbjHPVFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:05:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5496E2724;
        Wed, 16 Aug 2023 14:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E548766EE4;
        Wed, 16 Aug 2023 21:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1ACC433C7;
        Wed, 16 Aug 2023 21:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692219888;
        bh=vZzT4FLYZvxN57NaaD/Y3RFrRgr99gE1kZ6Pw1ws3hY=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=BgFPs7BMntOSL8c33Zzf5VpNK7hPj/8hBLAL02pTLkMKjrqkAF9i9T6Rgb8wTzpxs
         a4t5JxDnoepdKDtZ2vn3wGhTG9WveX0JlgZRyWP2j9WumbStoGCDBtmYe+auQV4cU6
         +Srsrk9E7jso00F/UefMS+H/9KrcPDCtNInr4QFOCvzTNPSZSbrQ/Zlw/deycgkBZE
         MvElC0utsjlExSnsNZdNBQtByt1da4lXdX31tQ6nj0jxLQT4sI/9KSRj5NubEcLHAB
         gwcZWHzhKeMZanibOE3SqnKVDdrtGfzb0UYtyYOu1wQcQPhZ5QKbSIMpdQHeNjv7B8
         r87ub46p3iVgQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 17 Aug 2023 00:04:45 +0300
Message-Id: <CUU9VV4M4LGZ.1W0BC1H1C0WE2@suppilovahvero>
Cc:     "Eric Snowberg" <eric.snowberg@oracle.com>,
        "Paul Moore" <paul@paul-moore.com>,
        <linux-security-module@vger.kernel.org>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] integrity: ignore keys failing CA restrictions
 on non-UEFI platform
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Mimi Zohar" <zohar@linux.ibm.com>,
        "Nayna Jain" <nayna@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230813021531.1382815-1-nayna@linux.ibm.com>
 <20230813021531.1382815-3-nayna@linux.ibm.com>
 <CUSG8HX9J4L0.37OHE7QHLL9N7@suppilovahvero>
 <3b4024eb6602fc2b7be821e6e33c656eee3c7cae.camel@linux.ibm.com>
In-Reply-To: <3b4024eb6602fc2b7be821e6e33c656eee3c7cae.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 16, 2023 at 3:58 PM EEST, Mimi Zohar wrote:
> On Mon, 2023-08-14 at 20:38 +0300, Jarkko Sakkinen wrote:
> > On Sun Aug 13, 2023 at 5:15 AM EEST, Nayna Jain wrote:
> > > On non-UEFI platforms, handle restrict_link_by_ca failures differentl=
y.
> > >
> > > Certificates which do not satisfy CA restrictions on non-UEFI platfor=
ms
> > > are ignored.
> > >
> > > Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> > > Reviewed-and-tested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > >  security/integrity/platform_certs/machine_keyring.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/security/integrity/platform_certs/machine_keyring.c b/se=
curity/integrity/platform_certs/machine_keyring.c
> > > index 7aaed7950b6e..389a6e7c9245 100644
> > > --- a/security/integrity/platform_certs/machine_keyring.c
> > > +++ b/security/integrity/platform_certs/machine_keyring.c
> > > @@ -36,7 +36,7 @@ void __init add_to_machine_keyring(const char *sour=
ce, const void *data, size_t
> > >  	 * If the restriction check does not pass and the platform keyring
> > >  	 * is configured, try to add it into that keyring instead.
> > >  	 */
> > > -	if (rc && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
> > > +	if (rc && efi_enabled(EFI_BOOT) && IS_ENABLED(CONFIG_INTEGRITY_PLAT=
FORM_KEYRING))
> > >  		rc =3D integrity_load_cert(INTEGRITY_KEYRING_PLATFORM, source,
> > >  					 data, len, perm);
> > > =20
> > > --=20
> > > 2.31.1
> >=20
> > Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> Hi Jarkko,
>
> Without the following two commits in your master branch, the last patch
> in this series "[PATCH v4 6/6] integrity: PowerVM support for loading
> third party code signing keys"   doesn't apply cleanly.
>
> - commit 409b465f8a83 ("integrity: Enforce digitalSignature usage in
> the ima and evm keyrings")
> - commit e34a6c7dd192 ("KEYS: DigitalSignature link restriction")
>
> If you're not planning on upstreaming this patch set, I'd appreciate
> your creating a topic branch with these two commits.

They reside now in my -next. I'll send PR for the next release Fri.

> --=20
> thanks,
>
> Mimi

BR, Jarkko
