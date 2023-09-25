Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42AE7ADD7A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjIYQzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjIYQzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:55:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E42EE;
        Mon, 25 Sep 2023 09:54:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF6DC433C8;
        Mon, 25 Sep 2023 16:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695660893;
        bh=SyZT2A0CSmuW9Kq1aYtg9sgERqEPr88gupKNQgHSb2c=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=fkHWlzi9pmmigRvIWcuLohwLaC39obOuitaBHnwMBw0C7SWKSUkhWo7CbjagnyhJg
         EGFpQcY7ss044NVRWoIQNeRHn7YTvigivtrXVIvu5lFRM6A+rBiKTDAECNjI/fy4yf
         WYKX80igbTpFFa3+DRYeZHj0oFLkBmgDOOvLz6TjTE53HTYWSQGjWLbeE5mjXLOcoQ
         PtwepnxjXg0nG9wPGoTnh9D8F5E372z+wvt1H9DsQET6kOE4nFFJBkBmFFnHh2jvFu
         uH5+FIKfR8RsJkTxiBgkdb54d9xvHmukr6CPgYYqP39cs9l3wzo3LY1ez3YVTgczfb
         U6CoYHs22x9Gw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 25 Sep 2023 19:54:50 +0300
Message-Id: <CVS5MB3X82Q8.8KDB4346ROR5@suppilovahvero>
Cc:     "dhowells@redhat.com" <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] certs: Add option to disallow non-CA certificates in
 secondary trusted keying
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Denis Glazkov" <d.glazkov@omp.ru>,
        "Sergey Shtylyov" <s.shtylyov@omp.ru>
X-Mailer: aerc 0.14.0
References: <f5a1d856-0482-a2c3-0e62-3ca911ce3dd2@omp.ru>
 <20230908121330.4076-1-d.glazkov@omp.ru>
 <CVGEE9ODRR8I.1RIVO2MVE2UAX@suppilovahvero>
 <3bc6b569be0beff9f70d58b751088fd2cc798e93.camel@omp.ru>
In-Reply-To: <3bc6b569be0beff9f70d58b751088fd2cc798e93.camel@omp.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Sep 15, 2023 at 8:50 PM EEST, Denis Glazkov wrote:
> On Tue, Sep 12 2023 at 01:15 AM +0300, Jarkko Sakkinen wrote:
> > On Fri Sep 8, 2023 at 3:14 PM EEST, Denis Glazkov wrote:
> > > The Linux kernel has an IMA (Integrity Measurement Architecture)
> > > subsystem to check the integrity of the file system based on digital
> > > signatures. IMA uses certificates in `.ima` keying to check integrity=
.
> > >=20
> > > Only certificates issued by one of the trusted CA (Certificate Author=
ity)
> > > certificates can be added to the `.ima` keying.
> > >=20
> > > The Linux kernel now has a secondary trusted keying to which trusted
> > > certificates from user space can be added if you have superuser
> > > privileges. Previously, all trusted certificates were in the built-in
> > > trusted keying, which could not be modified from user space.
> > > Trusted certificates were placed in the built-in trusted keying at
> > > kernel compile time.
> > >=20
> > > The secondary trusted keying is designed so that any certificates tha=
t
> > > are signed by one of the trusted CA certificates in the built-in or
> > > secondary trusted keyring can be added to it.
> > >=20
> > > Let's imagine that we have the following certificate trust chain:
> > >=20
> > >              =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=90
> > >              =E2=94=82                           =E2=94=82     =E2=94=
=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90=
       =E2=94=82
> > >              =E2=94=82                           =E2=94=82     =E2=94=
=82       =E2=94=82       =E2=94=82
> > > =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90    =E2=94=
=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=90  =E2=94=82 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> > > =E2=94=82.builtin_trusted_keys=E2=94=82=E2=97=84=E2=94=80=E2=94=80=E2=
=94=80=E2=94=A4.secondary_trusted_keys =E2=94=9C=E2=94=80=E2=94=80=E2=94=98=
 =E2=94=82   .ima    =E2=94=82
> > > =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4    =E2=94=
=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=A4    =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> > > =E2=94=82     Root CA Cert    =E2=94=82-----=E2=96=BA Intermediate CA=
 Cert  =E2=94=82-----=E2=96=BA IMA Cert =E2=94=82
> > > =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98    =E2=94=
=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=98    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
> > >=20
> > >                 Issues                  Restricted by
> > >             -------------=E2=96=BA             =E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BA
> > >=20
> > > Since the IMA certificate is signed by a CA certificate from a second=
ary
> > > trusted keying, an attacker with superuser privileges will be able to
> > > add the IMA certificate to the secondary trusted keying. That is, the=
 IMA
> > > certificate will become trusted.
> > >=20
> > > Since, with `CONFIG_MODULE_SIG` option enabled, modules can only be
> > > loaded into kernel space if they are signed with one of the trusted
> > > certificates, an attacker could sign untrusted kernel modules with
> > > the private key corresponding to the IMA certificate and successfully
> > > load the untrusted modules into kernel space.
> > >=20
> > > This patch adds the configuration that once enabled, only
> > > certificates that meet the following requirements can be added
> > > to the secondary trusted keying:
> > >=20
> > > 1. The certificate is a CA (Certificate Authority)
> > > 2. The certificate must be used for verifying a CA's signatures
> > > 3. The certificate must not be used for digital signatures
> > >=20
> > > Signed-off-by: Denis Glazkov <d.glazkov@omp.ru>
> >=20
> > s/keying/keyring/ (multiple)
> >=20
> > Have you considered instead making mod_verify_sig() more robust?
> > Obviously this would mean making selection of keys in
> > verify_pkcs7_signature() more robust (see the documentation of
> > 'trusted_keys').
> >=20
> > The this would be also less niche feature to pick for distributors
> > if it was just concerning module loading, and have associated config
> > flag over there.
> >=20
> > BR, Jarkko
>
> Jarkko, thank you for your suggestion.
>
> This patch was created not to solve only the problem of loading
> untrusted kernel modules, but to make it possible to use a secondary
> trusted keying only as a part of a chain of trust containing only
> CA certificates with no digital signature capability.
>
> Let's imagine that tomorrow we have a new kernel feature, similar
> to kernel modules in terms of its impact on system security, which
> also uses trusted certificates for signature verification.
>
> If at this point we solve only the problem of loading untrusted
> kernel modules, and not the problem of the entire trusted keys
> system, we will need to add a new kernel option each time to solve
> a similar problem for each new kernel feature that uses trusted
> certificates.

Ok, I guessed so but given what I read from commit message I had to ask :-)

The description is very detailed and of good quality, and also what you
say CONFIG_MODULE_SIG is just fine but for completeness it would be good
to mention that purpose and goal is to fully close the gap with any
possible feature that might go without CA certificates (*in addition*).

> BR, Denis

BR, Jarkko
