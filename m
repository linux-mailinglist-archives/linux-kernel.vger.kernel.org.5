Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15CC79C3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242460AbjILDRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242447AbjILDR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:17:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06A7107C72;
        Mon, 11 Sep 2023 19:07:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B82C433B8;
        Mon, 11 Sep 2023 21:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694466934;
        bh=jKcBqdin2tQkw/Q1r5bXfoLHC2ns8OLx8oid/0xcnhI=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=U0qjagxpMzedehK9Rnp94FOB5NGS96dvp8x4TnNeUL0sRX4Z3sceopbVWxG+fOY/W
         5E5/UDNHg6Y62UYTfllgBH2y2VCmrR/l17pA0SKoDc88LYupqdeF6T3jV79xZFkEN4
         u+bGTtOuSkvHrNMs42+oItei4kulqAzGJUZDdRvSHn2VvZC3HxaSBJXP5SIrW7+cAN
         34jhVL0dMLKxF+DLxH8igFbxdSELhrRD9mHE+b6XsXzdoAZck6XUm8vjM5450Bpb5S
         2O32TFHVMKUbTjXcDMeGdi447ptRwnzVaLcAf5hEUZvOY5XqGnQMb+dCOu4eNb1BYR
         /WNqpkA1yMqag==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 00:15:30 +0300
Message-Id: <CVGEE9ODRR8I.1RIVO2MVE2UAX@suppilovahvero>
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
In-Reply-To: <20230908121330.4076-1-d.glazkov@omp.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Sep 8, 2023 at 3:14 PM EEST, Denis Glazkov wrote:
> The Linux kernel has an IMA (Integrity Measurement Architecture)
> subsystem to check the integrity of the file system based on digital
> signatures. IMA uses certificates in `.ima` keying to check integrity.
>
> Only certificates issued by one of the trusted CA (Certificate Authority)
> certificates can be added to the `.ima` keying.
>
> The Linux kernel now has a secondary trusted keying to which trusted
> certificates from user space can be added if you have superuser
> privileges. Previously, all trusted certificates were in the built-in
> trusted keying, which could not be modified from user space.
> Trusted certificates were placed in the built-in trusted keying at
> kernel compile time.
>
> The secondary trusted keying is designed so that any certificates that
> are signed by one of the trusted CA certificates in the built-in or
> secondary trusted keyring can be added to it.
>
> Let's imagine that we have the following certificate trust chain:
>
>              =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=90
>              =E2=94=82                           =E2=94=82     =E2=94=8C=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90   =
    =E2=94=82
>              =E2=94=82                           =E2=94=82     =E2=94=82 =
      =E2=94=82       =E2=94=82
> =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90    =E2=94=8C=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90=
  =E2=94=82 =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> =E2=94=82.builtin_trusted_keys=E2=94=82=E2=97=84=E2=94=80=E2=94=80=E2=94=
=80=E2=94=A4.secondary_trusted_keys =E2=94=9C=E2=94=80=E2=94=80=E2=94=98 =
=E2=94=82   .ima    =E2=94=82
> =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4    =E2=94=9C=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4=
    =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> =E2=94=82     Root CA Cert    =E2=94=82-----=E2=96=BA Intermediate CA Cer=
t  =E2=94=82-----=E2=96=BA IMA Cert =E2=94=82
> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98    =E2=94=94=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98=
    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>
>                 Issues                  Restricted by
>             -------------=E2=96=BA             =E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=96=BA
>
> Since the IMA certificate is signed by a CA certificate from a secondary
> trusted keying, an attacker with superuser privileges will be able to
> add the IMA certificate to the secondary trusted keying. That is, the IMA
> certificate will become trusted.
>
> Since, with `CONFIG_MODULE_SIG` option enabled, modules can only be
> loaded into kernel space if they are signed with one of the trusted
> certificates, an attacker could sign untrusted kernel modules with
> the private key corresponding to the IMA certificate and successfully
> load the untrusted modules into kernel space.
>
> This patch adds the configuration that once enabled, only
> certificates that meet the following requirements can be added
> to the secondary trusted keying:
>
> 1. The certificate is a CA (Certificate Authority)
> 2. The certificate must be used for verifying a CA's signatures
> 3. The certificate must not be used for digital signatures
>
> Signed-off-by: Denis Glazkov <d.glazkov@omp.ru>

s/keying/keyring/ (multiple)

Have you considered instead making mod_verify_sig() more robust?
Obviously this would mean making selection of keys in
verify_pkcs7_signature() more robust (see the documentation of
'trusted_keys').

The this would be also less niche feature to pick for distributors
if it was just concerning module loading, and have associated config
flag over there.

BR, Jarkko
