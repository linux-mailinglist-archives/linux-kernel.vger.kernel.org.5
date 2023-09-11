Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D88379BC82
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242350AbjIKVuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243180AbjIKQ47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:56:59 -0400
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D99110
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:56:52 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Rkt6132vMzMq8R6;
        Mon, 11 Sep 2023 16:51:37 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Rkt5z6QN4zMpnPm;
        Mon, 11 Sep 2023 18:51:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1694451097;
        bh=pqqrQta8piJdqnMvVdURjJa1eNsNKhKxvBLmVj6CI+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sEOjdUnCGTTs0ZUOaxZHYuk/JaLYbF9GJAN45a7K0gH43z4OQXSviIscARZ2muRwD
         a4/LIqxUqgo19pinerOWoDZSQCWKntWA18zSrEuVFKQNRS9k60eyJrkhEN1tXh8ZIi
         /3MS9EU1KLREDKF2R2I5n1RNSPDseMcDXOQuPAcs=
Date:   Mon, 11 Sep 2023 18:51:33 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>, jarkko@kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org, mic@linux.microsoft.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH] certs: Restrict blacklist updates to the secondary
 trusted keyring
Message-ID: <20230911.chaeghaeJ4ei@digikod.net>
References: <20230908213428.731513-1-eric.snowberg@oracle.com>
 <097a0413b27ed9792dc598ff184730bcf6ae8fcf.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <097a0413b27ed9792dc598ff184730bcf6ae8fcf.camel@linux.ibm.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 09:29:07AM -0400, Mimi Zohar wrote:
> Hi Eric,
> 
> On Fri, 2023-09-08 at 17:34 -0400, Eric Snowberg wrote:
> > Currently root can dynamically update the blacklist keyring if the hash
> > being added is signed and vouched for by the builtin trusted keyring.
> > Currently keys in the secondary trusted keyring can not be used.
> > 
> > Keys within the secondary trusted keyring carry the same capabilities as
> > the builtin trusted keyring.  Relax the current restriction for updating
> > the .blacklist keyring and allow the secondary to also be referenced as
> > a trust source.  Since the machine keyring is linked to the secondary
> > trusted keyring, any key within it may also be used.
> > 
> > An example use case for this is IMA appraisal.  Now that IMA both
> > references the blacklist keyring and allows the machine owner to add
> > custom IMA CA certs via the machine keyring, this adds the additional
> > capability for the machine owner to also do revocations on a running
> > system.
> > 
> > IMA appraisal usage example to add a revocation for /usr/foo:
> > 
> > sha256sum /bin/foo | awk '{printf "bin:" $1}' > hash.txt
> > 
> > openssl smime -sign -in hash.txt -inkey machine-private-key.pem \
> >        -signer machine-certificate.pem -noattr -binary -outform DER \
> >        -out hash.p7s
> > 
> > keyctl padd blacklist "$(< hash.txt)" %:.blacklist < hash.p7s
> > 
> > Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> 
> The secondary keyring may include both CA and code signing keys.  With
> this change any key loaded onto the secondary keyring may blacklist a
> hash.  Wouldn't it make more sense to limit blacklisting
> certificates/hashes to at least CA keys? 

Some operational constraints may limit what a CA can sign.

This change is critical and should be tied to a dedicated kernel config
(disabled by default), otherwise existing systems using this feature
will have their threat model automatically changed without notice.

> 
> > ---
> >  certs/Kconfig     | 2 +-
> >  certs/blacklist.c | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/certs/Kconfig b/certs/Kconfig
> > index 1f109b070877..23dc87c52aff 100644
> > --- a/certs/Kconfig
> > +++ b/certs/Kconfig
> > @@ -134,7 +134,7 @@ config SYSTEM_BLACKLIST_AUTH_UPDATE
> >  	depends on SYSTEM_DATA_VERIFICATION
> >  	help
> >  	  If set, provide the ability to load new blacklist keys at run time if
> > -	  they are signed and vouched by a certificate from the builtin trusted
> > +	  they are signed and vouched by a certificate from the secondary trusted
> 
> If CONFIG_SECONDARY_TRUSTED_KEYRING is not enabled, it falls back to
> the builtin keyring.  Please update the comment accordingly.
> 
> >  	  keyring.  The PKCS#7 signature of the description is set in the key
> >  	  payload.  Blacklist keys cannot be removed.
> >  
> > diff --git a/certs/blacklist.c b/certs/blacklist.c
> > index 675dd7a8f07a..0b346048ae2d 100644
> > --- a/certs/blacklist.c
> > +++ b/certs/blacklist.c
> > @@ -102,12 +102,12 @@ static int blacklist_key_instantiate(struct key *key,
> >  
> >  #ifdef CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE
> >  	/*
> > -	 * Verifies the description's PKCS#7 signature against the builtin
> > +	 * Verifies the description's PKCS#7 signature against the secondary
> >  	 * trusted keyring.
> >  	 */
> 
> And similarly here ...
> 
> >  	err = verify_pkcs7_signature(key->description,
> >  			strlen(key->description), prep->data, prep->datalen,
> > -			NULL, VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
> > +			VERIFY_USE_SECONDARY_KEYRING, VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
> >  	if (err)
> >  		return err;
> >  #else
> 
> -- 
> thanks,
> 
> Mimi
> 
