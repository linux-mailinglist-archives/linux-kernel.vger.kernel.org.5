Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F067ED5FB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344466AbjKOVYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjKOVYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:24:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E741C8F;
        Wed, 15 Nov 2023 13:24:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04363C433C8;
        Wed, 15 Nov 2023 21:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700083479;
        bh=ozkO9Pw7MrmqVhdNfFB/XT1lNJNymTQrXyWvzxaXj4s=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=UqxWumEH0m2fdEquDZaKkRIbRzbH2AkcKxY7EXBhGv/l6dwVXR5r8AATojnri5Lkz
         bMWVyQJSP20xXP4ud5yM28bO+jCp0s1O5KoKGDNgvkRyyzgRC8kSUHNC4LUPyydEF0
         UDuzicn1SjWdoAne0kUP/RrP73CX8TMpqU5XpjTTfNGTRffEUu37gkX4vf898Zpnh3
         wm0X1hZZlV1746CUxgCboamxmTQZMQC1M8UIHJ4eJJxA87Wer6cb+3M5YLgs6bZ+HV
         dHukM+sf1qHNmQEWTPLBCwhel6OCSLWNMQYcd50Wn8FqciyFtKtzgPC1mV6AvRH7Oz
         Af07p+j0+ojqQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 15 Nov 2023 23:24:34 +0200
Message-Id: <CWZPAM33DYND.1OEHYEHGBGBI7@kernel.org>
Cc:     <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
        "James Bottomley" <James.Bottomley@hansenpartnership.com>,
        "William Roberts" <bill.c.roberts@gmail.com>,
        "Stefan Berger" <stefanb@linux.ibm.com>,
        "David Howells" <dhowells@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "James Bottomley" <jejb@linux.ibm.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        "Julien Gomes" <julien@arista.com>,
        "open list" <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] tpm: Support TPM2 sized buffers (TPM2B)
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jerry Snitselaar" <jsnitsel@redhat.com>
X-Mailer: aerc 0.15.2
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-5-jarkko@kernel.org>
 <nwbyc2al5msr7d2wqvqcfdm75osrestjncuhjgxxigm773a6k5@bc7hjv5srjxv>
In-Reply-To: <nwbyc2al5msr7d2wqvqcfdm75osrestjncuhjgxxigm773a6k5@bc7hjv5srjxv>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 7, 2023 at 7:20 PM EET, Jerry Snitselaar wrote:
> On Tue, Oct 24, 2023 at 04:15:22AM +0300, Jarkko Sakkinen wrote:
> > Add boolean parameters @alloc and @sized to tpm_buf_init():
> >=20
> > * If @alloc is set to false, buf->data is assumed to be pre-feeded and
> >   owned by the caller.
> > * If @sized is set to true, the buffer represents a sized buffer
> >   (TPM2B).
> >=20
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  drivers/char/tpm/tpm-buf.c                | 32 ++++++++++++++++-------
> >  drivers/char/tpm/tpm-sysfs.c              |  2 +-
> >  drivers/char/tpm/tpm1-cmd.c               | 14 +++++-----
> >  drivers/char/tpm/tpm2-cmd.c               | 22 ++++++++--------
> >  drivers/char/tpm/tpm2-space.c             |  4 +--
> >  drivers/char/tpm/tpm_vtpm_proxy.c         |  2 +-
> >  include/linux/tpm.h                       |  3 ++-
> >  security/keys/trusted-keys/trusted_tpm1.c |  4 +--
> >  security/keys/trusted-keys/trusted_tpm2.c |  6 ++---
> >  9 files changed, 51 insertions(+), 38 deletions(-)
> >=20
> > diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> > index fa9a4c51157a..f1d92d7e758d 100644
> > --- a/drivers/char/tpm/tpm-buf.c
> > +++ b/drivers/char/tpm/tpm-buf.c
> > @@ -7,22 +7,32 @@
> >  #include <linux/tpm.h>
> > =20
> >  /**
> > - * tpm_buf_init() - Initialize from the heap
> > + * tpm_buf_init() - Initialize a TPM buffer
> >   * @buf:	A @tpm_buf
> > + * @sized:	Represent a sized buffer (TPM2B)
> > + * @alloc:	Allocate from the heap
> >   *
> >   * Initialize all structure fields to zero, allocate a page from the h=
eap, and
>
> Depending on what the decision ends up being on the bools, flags,
> separate functions, or wrappers possibly an "if needed" should be
> tacked on to the end of "allocate a page from the heap" here.
>
>
> Flags would be better when coming across calls to the routine in the
> code than the bools, but I think switching to wrappers around
> a __tpm_buf_init for the different types would be good.

Yeah, I'll bake something based on this discussion.

BR, Jarkko
