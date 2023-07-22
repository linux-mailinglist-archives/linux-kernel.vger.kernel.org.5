Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD7475DE06
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 20:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjGVSKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 14:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGVSKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 14:10:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CCE26B3;
        Sat, 22 Jul 2023 11:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE53360B96;
        Sat, 22 Jul 2023 18:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A138C433C8;
        Sat, 22 Jul 2023 18:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690049445;
        bh=aG58NWi7sc0lQTEyK5lKCBU4gxPNAXYYIz4iHvVeBrA=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=oYXNhOWS89EfdquFHUuOm1TTuxo8RXPPqmhBV+abx+yIvbO8c+VzrnDCOA1P552Va
         Jy7vMKnhFbZECVY5NIJOV45t1ZcrTvq994YGQFdT8Gvj1n0H5v7Prx4eOtUO2RQH4z
         aQphr32K9mWn+xnOhh2cjlQiV/dByMOS55TLyxQZxDm3ayGKzt/Zm0DUBtwTY9oVX6
         CP8QfFoZjcBP6Kmqx5WPm7oi30eijwRK2/LP8GB6aj4fWlyfy5640md6qLZhsGAvYZ
         YQLt/RRgqwCzWwvXRGGk5fa/9hEFUmrH2+glW1zE8T2Z5QTr5ACiJEsLBDUqxMRmIJ
         fxPgNBkKdP8Vg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 22 Jul 2023 18:10:42 +0000
Message-Id: <CU8WIZGB01DT.2YX12UG6QRTA@seitikki>
Subject: Re: [PATCH 0/4] selftests/sgx: Harden test enclave
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     <dave.hansen@linux.intel.com>
X-Mailer: aerc 0.14.0
References: <20230719142500.13623-1-jo.vanbulck@cs.kuleuven.be>
 <CU76BC9V7H3Z.TQ3L8AZY1WD@suppilovahvero>
 <a6e26927-acb0-c967-10c4-90a41d9a8cad@cs.kuleuven.be>
In-Reply-To: <a6e26927-acb0-c967-10c4-90a41d9a8cad@cs.kuleuven.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jul 20, 2023 at 7:12 PM UTC, Jo Van Bulck wrote:
> On 20.07.23 19:25, Jarkko Sakkinen wrote:
> > There's a lot of source code in kselftest, which probably has at least
> > some security issues.
> >=20
> > I'm not sure, at least based on this motivation, why would we care?
>
> I'd argue that, in general, code examples are often used as templates=20
> and may thus inherit any vulnerabilities therein. This may be especially=
=20
> relevant here as your selftest enclave is in my knowledge the only=20
> available truly minimal SGX enclave that can be built and extended while=
=20
> only relying on standard tools and no heavy frameworks like the Intel=20
> SGX SDK. Thus, as noted before on this mailing list, it may be an=20
> attractive start for people who want to build things from scratch.

If you use this code as a template,  you have a legal risk in your hands
because of GPLv2 licensing.

> IMHO the example enclave should do a best effort to reasonably follow=20
> SGX coding best practices and not have _known_ security vulnerabilities=
=20
> in it. Note that these are not advanced microarchitectural attacks with=
=20
> ugly LFENCE defenses, but plain, architectural memory-safety exploit=20
> preventions with minimal sanitization checks, not unlike the existing=20
> protections against buffer overflow where best practices are followed=20
> for op->type.

I'm not sure what are the "best practices" behavior in the context of a
kselftest instance.

> Apart from that, the added checks only enforce correct behavior in the=20
> test framework, only validating that things are sane and as expected.=20
> Thus, to some extent, the added checks may even increase resilience of=20
> the test framework.

I'm not sure what is "correct" behavior in the context of a kselftest
instance.

> Best,
> Jo

This code is not meant for production. I implemented it specifically for
kselftest, and that is exactly its scope.

BR, Jarkko
