Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD737692D5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjGaKOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjGaKOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:14:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40E8E3;
        Mon, 31 Jul 2023 03:14:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71DFE60D32;
        Mon, 31 Jul 2023 10:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207D8C433C7;
        Mon, 31 Jul 2023 10:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690798448;
        bh=EW7YMvUyfLmk+cbCYjst8bsZXEEoiOeVIsX41Tk6EZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oCQC2lDGGtGvVyzJaztdEoQcZ6k5LWE5DlQ8gA5w1QX63d0ynKAyAA65yimgEeYJV
         V0hkNzMKfo0sV2WiMWcaxDT9oeccHSN+nn86R6T18NDnEUxKiUJ0g6HGnvh5WD8LU4
         pnrO4cGiAcAxsI4+jROSksXAcvIOsznXfBQTPyrWI6VE0Uj56DAJoJlbmTd2zqdQ7/
         C4Z31/IciOZh2HnSjQ8v/s/TeBYETX0R4wL90/CAxq4/N4Kf4i5ybLGI+NA78x4HDr
         DqKdGoe8lcFRhWECUSZKpIGGKnr3WwNmWtj5n97S26g6E+6B6Z8M1UAOv7WNhTiGye
         CkXw9nJZ2dK1g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 31 Jul 2023 10:14:05 +0000
Message-Id: <CUGA0YM7BIJN.3RDWZ1WZSWG28@seitikki>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Daniil Stas" <daniil.stas@posteo.net>
Cc:     <mario.limonciello@amd.com>,
        <James.Bottomley@hansenpartnership.com>, <Jason@zx2c4.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <regressions@leemhuis.info>, <stable@vger.kernel.org>,
        <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
X-Mailer: aerc 0.14.0
References: <20230214201955.7461-2-mario.limonciello@amd.com>
 <20230727183805.69c36d6e@g14> <CUE1Z76QDX0Z.2K0OU6TPMS50X@seitikki>
 <20230728231810.48370d44@g14>
In-Reply-To: <20230728231810.48370d44@g14>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jul 28, 2023 at 8:18 PM UTC, Daniil Stas wrote:
> On Fri, 28 Jul 2023 19:30:18 +0000
> "Jarkko Sakkinen" <jarkko@kernel.org> wrote:
>
> > On Thu Jul 27, 2023 at 3:38 PM UTC, Daniil Stas wrote:
> > > Hi,
> > > I am still getting fTPM stutters with 6.4.3 kernel on Asus GA402RJ
> > > laptop.
> > > Compiling kernel without TPM support makes the stutters go away.
> > > The fTPM firmware version is 0x3005700020005 on my machine. =20
> >=20
> > This is needs a bit more elaboration in order to be comprehended.
> >=20
> > Do you mean by "stutter" unexpected delays and when do they happen?
> >=20
> > BR, Jarkko
>
> Yes, unexpected delays. They just happen randomly.
> You can google "AMD fTPM stuttering", there are a lot of examples.
> Here is one: https://www.youtube.com/watch?v=3DTYnRL-x6DVI

What if you make tpm_amd_is_rng_defective() to unconditonally return
true? Does this make the problem dissappear, or not?

BR, Jarkko
