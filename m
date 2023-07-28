Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F617675DF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbjG1Syp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjG1Syo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:54:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC7D136;
        Fri, 28 Jul 2023 11:54:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1234E621CF;
        Fri, 28 Jul 2023 18:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A74EC433C7;
        Fri, 28 Jul 2023 18:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690570482;
        bh=bluqcMUuf/WDnwicuR6jvp34FrTCGpLy45ia6cQUW9g=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=TmRZCY7VZV9pXvCESUsmW+ZArzzBXp0avUVOsFUtHWyaxuk8hD+CCEDFI50e3Qimb
         yjIqBqpMd0I4SR6I3fBYrKZ7tR2kafu82sN7wPGTCqe721oNDiFHNSnkNwGkCyV99+
         s29bbKS6Oir8qO8I0IcG+BCJO9u27wvdQRAC2aQZOX/YdNxcgaimnUeFZY2uEMuEmp
         iSgMV3tZFKQa4k/cWp6KPDXykH6TmzPAz9aK619UKAx5TYy9zL/71eNZ+R9nr7gAL3
         7uT7245JpD8kykl09bZun8IaX24qAfuuuovvhCionA3hIbcBRpkkYQDutPzsIP3YYV
         aj+W59yHzDMWA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 18:54:39 +0000
Message-Id: <CUE17WOKP8HH.39KZQV0H8IRBV@seitikki>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 0/4] selftests/sgx: Harden test enclave
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230719142500.13623-1-jo.vanbulck@cs.kuleuven.be>
 <CU76BC9V7H3Z.TQ3L8AZY1WD@suppilovahvero>
 <a6e26927-acb0-c967-10c4-90a41d9a8cad@cs.kuleuven.be>
 <CU8WIZGB01DT.2YX12UG6QRTA@seitikki>
 <707e662f-5aed-ef86-a2e3-dda3959d6f7d@cs.kuleuven.be>
In-Reply-To: <707e662f-5aed-ef86-a2e3-dda3959d6f7d@cs.kuleuven.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jul 24, 2023 at 10:46 AM UTC, Jo Van Bulck wrote:
> On 22.07.23 20:10, Jarkko Sakkinen wrote:
> > This code is not meant for production. I implemented it specifically fo=
r
> > kselftest, and that is exactly its scope.
>
> I see, makes sense. As per Dave's suggestion, I'll see if I can submit a=
=20
> proposed minimal patch to remove any existing sanitization code that is=
=20
> not necessary for kselftest (eg register cleansing) and avoid any=20
> misguided impressions of the test enclave being representative.
>
> > I'm not sure what is "correct" behavior in the context of a kselftest
> > instance.
>
> True. But at least when defining "correct" as passing the selftests,=20
> then I think it makes sense to merge the compiler optimization fixes. As=
=20
> the existing code clearly emits wrong assembly that breaks the selftests=
=20
> when switching optimization levels (which may always also be=20
> incorporated by default in future gcc versions or other compilers like=20
> clang).
>
> Thus, I'll separate this out and submit another patch to ensure=20
> correctness with compiler optimizations only.
>
> Best,
> Jo

It should be relatively easy to relicense the code as most of the
commits have Intel copyright.

Personally I would not mind because that would give opportunity for
code that I wrote to have a wider audience but it needs to be forked
with some other license first.

BR, Jarkko
