Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1B279CE1A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjILKUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbjILKUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:20:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C99BB9;
        Tue, 12 Sep 2023 03:20:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DB9F22183A;
        Tue, 12 Sep 2023 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694514007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jJikcqHPybmmVVKH+rVSv5RHGUhMwLNpMC29dvhVmO8=;
        b=qvMafhMnrSq+YoWWEMNmaYEsEk5vTGaEBGc1T4gYbVi3R0kR49A/DDY6fDsEVkoNaKxpo3
        yCaQKZUA9rPgwFsMSQ+431NzV3KT3Usq5xIdFxPWgKNpdnHXz4zD7kYgYGQaL+5Gj+25i7
        QqXYKf31KQ4Rg6g/euhbpyJd3vUusuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694514007;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jJikcqHPybmmVVKH+rVSv5RHGUhMwLNpMC29dvhVmO8=;
        b=SdUW66/4mwgnCi6EzjAH9XZxz5vfmUtzOMt1sfV+pREB9CCpcsNFkoKnHC93XN+cApI9Rv
        qY84Xeuh58ZBm0Bg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3EAE42C142;
        Tue, 12 Sep 2023 10:20:07 +0000 (UTC)
Date:   Tue, 12 Sep 2023 12:20:06 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, joeyli <jlee@suse.com>
Subject: Re: [PATCH] integrity: powerpc: Do not select CA_MACHINE_KEYRING
Message-ID: <20230912102006.GN8826@kitsune.suse.cz>
References: <20230907165224.32256-1-msuchanek@suse.de>
 <CVGF1AQT9WI4.2660NVII9NIDU@suppilovahvero>
 <20230912075134.GM8826@kitsune.suse.cz>
 <CVGUDAU0TSNU.2KQP3U44NG61T@suppilovahvero>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CVGUDAU0TSNU.2KQP3U44NG61T@suppilovahvero>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:46:32PM +0300, Jarkko Sakkinen wrote:
> On Tue Sep 12, 2023 at 10:51 AM EEST, Michal Suchánek wrote:
> > On Tue, Sep 12, 2023 at 12:45:35AM +0300, Jarkko Sakkinen wrote:
> > > On Thu Sep 7, 2023 at 7:52 PM EEST, Michal Suchanek wrote:
> > > > No other platform needs CA_MACHINE_KEYRING, either.
> > > >
> > > > This is policy that should be decided by the administrator, not Kconfig
> > > 
> > > s/administrator/distributor/ ?
> >
> > It depends on the situation. Ideally the administrator would pick the
> > distributor that provides a policy that is considered fitting for the
> > purpose or roll their own. Unfortunately, they don't always have the
> > choice.
> >
> > For the kerenel's part it should support wide range of policies for
> > different use cases, and not force the hand of the administrator or
> > distributor.
> >
> > > 
> > > > dependencies.
> > > >
> > > > cc: joeyli <jlee@suse.com>
> > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > > ---
> > > >  security/integrity/Kconfig | 2 --
> > > >  1 file changed, 2 deletions(-)
> > > >
> > > > diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> > > > index 232191ee09e3..b6e074ac0227 100644
> > > > --- a/security/integrity/Kconfig
> > > > +++ b/security/integrity/Kconfig
> > > > @@ -68,8 +68,6 @@ config INTEGRITY_MACHINE_KEYRING
> > > >  	depends on INTEGRITY_ASYMMETRIC_KEYS
> > > >  	depends on SYSTEM_BLACKLIST_KEYRING
> > > >  	depends on LOAD_UEFI_KEYS || LOAD_PPC_KEYS
> > > > -	select INTEGRITY_CA_MACHINE_KEYRING if LOAD_PPC_KEYS
> > > > -	select INTEGRITY_CA_MACHINE_KEYRING_MAX if LOAD_PPC_KEYS
> > > >  	help
> > > >  	 If set, provide a keyring to which Machine Owner Keys (MOK) may
> > > >  	 be added. This keyring shall contain just MOK keys.  Unlike keys
> > > > -- 
> > > > 2.41.0
> > > 
> > > I'd suggest to add even fixes tag.
> >
> > Here it is
> >
> > Fixes: d7d91c4743c4 ("integrity: PowerVM machine keyring enablement")
> 
> commit b755dd58d180b796d21bc14d03045e4ab84222b0 (HEAD -> next, origin/next)
> Author: Michal Suchanek <msuchanek@suse.de>
> Date:   Thu Sep 7 18:52:19 2023 +0200
> 
>     integrity: powerpc: Do not select CA_MACHINE_KEYRING
> 
>     No other platform needs CA_MACHINE_KEYRING, either.
> 
>     This is policy that should be decided by the administrator, not Kconfig
>     dependencies.
> 
>     Fixes: d7d91c4743c4 ("integrity: PowerVM machine keyring enablement")
>     Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>     Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> index 232191ee09e3..b6e074ac0227 100644
> --- a/security/integrity/Kconfig
> +++ b/security/integrity/Kconfig
> @@ -68,8 +68,6 @@ config INTEGRITY_MACHINE_KEYRING
>         depends on INTEGRITY_ASYMMETRIC_KEYS
>         depends on SYSTEM_BLACKLIST_KEYRING
>         depends on LOAD_UEFI_KEYS || LOAD_PPC_KEYS
> -       select INTEGRITY_CA_MACHINE_KEYRING if LOAD_PPC_KEYS
> -       select INTEGRITY_CA_MACHINE_KEYRING_MAX if LOAD_PPC_KEYS
>         help
>          If set, provide a keyring to which Machine Owner Keys (MOK) may
>          be added. This keyring shall contain just MOK keys.  Unlike keys
> 
> If this look good to you, I'll put it to the -rc2 pull request.

Looks good

Thanks

Michal
