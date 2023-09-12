Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6574379C8B1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjILHwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjILHvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:51:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2924B10F1;
        Tue, 12 Sep 2023 00:51:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D252F21846;
        Tue, 12 Sep 2023 07:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694505095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0olCWOM5/gMcD6jTiH5oaRY6kpX/DXzG5tdEGM5nfTw=;
        b=VbuILt1FgF2htdXpzOR7bxovvC2X6qiPurQz3engfOUs+nizoiM7BlZ1n7MmJCjBK2Zxt7
        sNhwgedkfpKkfnZfKeiL2XnYVggRudPOHkCdLRHQnFIuRS4OlMPS3aoQTc99wtmZ8vij/J
        HB6wOYYK0QBpkgk225ObRtHIHwnb8yQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694505095;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0olCWOM5/gMcD6jTiH5oaRY6kpX/DXzG5tdEGM5nfTw=;
        b=kBRaaLQ9/yPtt2KT+z9Nv7fyhZ7POXqBNc1wdhkwQC/uLz5c9kHF+8jXBnbuzQILsZlcsG
        19bRSfXryVXgwaBg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A2BC42C142;
        Tue, 12 Sep 2023 07:51:35 +0000 (UTC)
Date:   Tue, 12 Sep 2023 09:51:34 +0200
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
Message-ID: <20230912075134.GM8826@kitsune.suse.cz>
References: <20230907165224.32256-1-msuchanek@suse.de>
 <CVGF1AQT9WI4.2660NVII9NIDU@suppilovahvero>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CVGF1AQT9WI4.2660NVII9NIDU@suppilovahvero>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:45:35AM +0300, Jarkko Sakkinen wrote:
> On Thu Sep 7, 2023 at 7:52 PM EEST, Michal Suchanek wrote:
> > No other platform needs CA_MACHINE_KEYRING, either.
> >
> > This is policy that should be decided by the administrator, not Kconfig
> 
> s/administrator/distributor/ ?

It depends on the situation. Ideally the administrator would pick the
distributor that provides a policy that is considered fitting for the
purpose or roll their own. Unfortunately, they don't always have the
choice.

For the kerenel's part it should support wide range of policies for
different use cases, and not force the hand of the administrator or
distributor.

> 
> > dependencies.
> >
> > cc: joeyli <jlee@suse.com>
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  security/integrity/Kconfig | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> > index 232191ee09e3..b6e074ac0227 100644
> > --- a/security/integrity/Kconfig
> > +++ b/security/integrity/Kconfig
> > @@ -68,8 +68,6 @@ config INTEGRITY_MACHINE_KEYRING
> >  	depends on INTEGRITY_ASYMMETRIC_KEYS
> >  	depends on SYSTEM_BLACKLIST_KEYRING
> >  	depends on LOAD_UEFI_KEYS || LOAD_PPC_KEYS
> > -	select INTEGRITY_CA_MACHINE_KEYRING if LOAD_PPC_KEYS
> > -	select INTEGRITY_CA_MACHINE_KEYRING_MAX if LOAD_PPC_KEYS
> >  	help
> >  	 If set, provide a keyring to which Machine Owner Keys (MOK) may
> >  	 be added. This keyring shall contain just MOK keys.  Unlike keys
> > -- 
> > 2.41.0
> 
> I'd suggest to add even fixes tag.

Here it is

Fixes: d7d91c4743c4 ("integrity: PowerVM machine keyring enablement")

Thanks

Michal
