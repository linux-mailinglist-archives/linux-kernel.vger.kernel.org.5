Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AB279C11B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjILA2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 20:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjILA2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 20:28:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08568469A;
        Mon, 11 Sep 2023 17:28:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C53C116AA;
        Mon, 11 Sep 2023 22:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694469749;
        bh=BPQ6dr22xKZeaU3Kgfesl8AdYcWadqw/YEcuDpmDST4=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=N5GwXa+SDYrhEIk4TuMtZ7tTjNdzDnsTrHuml88ub+VqXsSBsN2OjmWvPuZBZ4UWP
         Mo49LFkDV40SawEe1+qf9LrZFe2/UVm2Y3OAcZPB8mWpNvFAcyBv04yeQul4kPWO9X
         oG9Fgvw400MHs8NRjIuBih87jiOL752wxzGUr0Q75CZiY3EWwNOgqkWPYm/yVFsVXc
         dvtv3gz7NSqvABf8ilXAYQPtk+lRYTgqBosEks/u89WYpaP+zysbbOJaMRdxWEogpn
         1hqlYlgt6t2JcOKR8cvXXltniUzh+izqSBl3VsajRTS94b7/l+7asMGhXiD26IsRRg
         erZQgH3kXmONw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 01:02:24 +0300
Message-Id: <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
Cc:     <kexec@lists.infradead.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <dhowells@redhat.com>, <vgoyal@redhat.com>,
        <keyrings@vger.kernel.org>, <akpm@linux-foundation.org>,
        <bhe@redhat.com>, <bhelgaas@google.com>, <lennart@poettering.net>,
        <bluca@debian.org>, <systemd-devel@lists.freedesktop.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jan Hendrik Farr" <kernel@jfarr.cc>,
        <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230909161851.223627-1-kernel@jfarr.cc>
In-Reply-To: <20230909161851.223627-1-kernel@jfarr.cc>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Sep 9, 2023 at 7:18 PM EEST, Jan Hendrik Farr wrote:
> Hello,
>
> this patch implements UKI support for kexec_file_load. It will require su=
pport
> in the kexec-tools userspace utility. For testing purposes the following =
can be used:
> https://github.com/Cydox/kexec-test/
>
> There has been discussion on this topic in an issue on GitHub that is lin=
ked below
> for reference.
>
>
> Some links:
> - Related discussion: https://github.com/systemd/systemd/issues/28538
> - Documentation of UKIs: https://uapi-group.org/specifications/specs/unif=
ied_kernel_image/
>
> Jan Hendrik Farr (1):
>   x86/kexec: UKI support
>
>  arch/x86/include/asm/kexec-uki.h       |   7 ++
>  arch/x86/include/asm/parse_pefile.h    |  32 +++++++
>  arch/x86/kernel/Makefile               |   2 +
>  arch/x86/kernel/kexec-uki.c            | 113 +++++++++++++++++++++++++
>  arch/x86/kernel/machine_kexec_64.c     |   2 +
>  arch/x86/kernel/parse_pefile.c         | 110 ++++++++++++++++++++++++
>  crypto/asymmetric_keys/mscode_parser.c |   2 +-
>  crypto/asymmetric_keys/verify_pefile.c | 110 +++---------------------
>  crypto/asymmetric_keys/verify_pefile.h |  16 ----
>  9 files changed, 278 insertions(+), 116 deletions(-)
>  create mode 100644 arch/x86/include/asm/kexec-uki.h
>  create mode 100644 arch/x86/include/asm/parse_pefile.h
>  create mode 100644 arch/x86/kernel/kexec-uki.c
>  create mode 100644 arch/x86/kernel/parse_pefile.c
>
> --=20
> 2.40.1

What the heck is UKI?

BR, Jarkko
