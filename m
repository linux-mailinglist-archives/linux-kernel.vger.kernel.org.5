Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0F679C377
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241196AbjILC7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241325AbjILC7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:59:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D95116B0C;
        Mon, 11 Sep 2023 18:22:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E053C116AE;
        Mon, 11 Sep 2023 22:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694469891;
        bh=d7+LLwsZ5NfE/HD2sW7mmL/65WCoPD7FlRtaiVBTjTU=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Fwvnn18e5ySS+jeBQ5Z7YYsIXDqZs5bd9/Bkd3tAZ1j7Q5rXp877lI4+WZ6Z9uTcl
         IOP0R1j5clAdbPvdxnxkQlkKXDV6l5jZ90mx33q6hgYcrcmt0+5w1Z3fJqLPmNp9sC
         AOe1MoaMobwA0MpjLBEf9OPKkKtSG3Jr1KfZOu7ghKRB1e1s4Avuk/aqlEaBhJDPGV
         wptddAH6X+eKOTS/CwqlmWlQWl9rsEnt7R4ZT/v71jgSDk1ktfJf+Xo7mYav42/fgw
         yaRLP6yZIdQ2JhnAkcctN54Oo2oHdyWRcAWK1wJdtj/W8oMO4+0NSe94wmtsZjLIKJ
         gwDGimdkS7DYw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 01:04:47 +0300
Message-Id: <CVGFG0625KNL.3B8Z118U3IGBY@suppilovahvero>
Subject: Re: [PATCH] certs: Restrict blacklist updates to the secondary
 trusted keyring
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Mimi Zohar" <zohar@linux.ibm.com>,
        "Eric Snowberg" <eric.snowberg@oracle.com>, <dhowells@redhat.com>,
        <dwmw2@infradead.org>
Cc:     <mic@linux.microsoft.com>, <kanth.ghatraju@oracle.com>,
        <konrad.wilk@oracle.com>, <linux-integrity@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230908213428.731513-1-eric.snowberg@oracle.com>
 <097a0413b27ed9792dc598ff184730bcf6ae8fcf.camel@linux.ibm.com>
In-Reply-To: <097a0413b27ed9792dc598ff184730bcf6ae8fcf.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Sep 11, 2023 at 4:29 PM EEST, Mimi Zohar wrote:
> Hi Eric,
>
> On Fri, 2023-09-08 at 17:34 -0400, Eric Snowberg wrote:
> > Currently root can dynamically update the blacklist keyring if the hash
> > being added is signed and vouched for by the builtin trusted keyring.
> > Currently keys in the secondary trusted keyring can not be used.
> >=20
> > Keys within the secondary trusted keyring carry the same capabilities a=
s
> > the builtin trusted keyring.  Relax the current restriction for updatin=
g
> > the .blacklist keyring and allow the secondary to also be referenced as
> > a trust source.  Since the machine keyring is linked to the secondary
> > trusted keyring, any key within it may also be used.
> >=20
> > An example use case for this is IMA appraisal.  Now that IMA both
> > references the blacklist keyring and allows the machine owner to add
> > custom IMA CA certs via the machine keyring, this adds the additional
> > capability for the machine owner to also do revocations on a running
> > system.
> >=20
> > IMA appraisal usage example to add a revocation for /usr/foo:
> >=20
> > sha256sum /bin/foo | awk '{printf "bin:" $1}' > hash.txt
> >=20
> > openssl smime -sign -in hash.txt -inkey machine-private-key.pem \
> >        -signer machine-certificate.pem -noattr -binary -outform DER \
> >        -out hash.p7s
> >=20
> > keyctl padd blacklist "$(< hash.txt)" %:.blacklist < hash.p7s
> >=20
> > Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
>
> The secondary keyring may include both CA and code signing keys.  With
> this change any key loaded onto the secondary keyring may blacklist a
> hash.  Wouldn't it make more sense to limit blacklisting
> certificates/hashes to at least CA keys?=20

I think a bigger issue is that if a kernel is updated with this patch
it will change the behavior. It is nothing to do whether the "old" or
"new" is better but more like kind of backwards compatibility issue.

BR, Jarkko
