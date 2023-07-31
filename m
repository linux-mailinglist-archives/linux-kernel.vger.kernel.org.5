Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2425376943A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjGaLHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjGaLHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:07:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8C71BF;
        Mon, 31 Jul 2023 04:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D10FC6104B;
        Mon, 31 Jul 2023 11:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6745EC433C7;
        Mon, 31 Jul 2023 11:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690801663;
        bh=RV8Rk8epBSDHGl4CjLo2RB50HeXG/xuM7WBwj6ffrfg=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=hnQj3Y89tF3k+OzGkCF13kZ7RTEH+3Ve6nekpXyfQ8I12hXlUTh7joL2PooaC3Eq7
         jmEK0Jman9bikOnW6zmcvrjYPz9Dx48cDMAu9Rv+0HhTpZtpGkdKA1fB0NI+IiQr13
         59RKH/Y6JJvx5HG3rWzGE3KBJkaiMRdYLTew3L2ZbjYjNFcMaZ8pVW6tuPKdSU8QW4
         HXOXccFy1tW1ILsqNQeXvlwY1Svb+E4wVrNQhSgwy3xUN11bziFqS/CcmrfSEGvB3l
         25qfp5D9GNAIjFoQYEPUw5CzqMOzPwhMbVWdRam/9fCDetqzjws856YVm0PPDLtYKp
         +ZAcDBAGrru7g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 31 Jul 2023 11:07:39 +0000
Message-Id: <CUGB5ZDAQVCH.1MBPZYSTIKAVO@seitikki>
Cc:     <mario.limonciello@amd.com>,
        <James.Bottomley@hansenpartnership.com>, <Jason@zx2c4.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <regressions@leemhuis.info>, <stable@vger.kernel.org>,
        <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Daniil Stas" <daniil.stas@posteo.net>
X-Mailer: aerc 0.14.0
References: <20230214201955.7461-2-mario.limonciello@amd.com>
 <20230727183805.69c36d6e@g14> <CUE1Z76QDX0Z.2K0OU6TPMS50X@seitikki>
 <20230728231810.48370d44@g14> <CUGA0YM7BIJN.3RDWZ1WZSWG28@seitikki>
 <20230731132837.64690d7b@g14>
In-Reply-To: <20230731132837.64690d7b@g14>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jul 31, 2023 at 10:28 AM UTC, Daniil Stas wrote:
> On Mon, 31 Jul 2023 10:14:05 +0000
> "Jarkko Sakkinen" <jarkko@kernel.org> wrote:
>
> > On Fri Jul 28, 2023 at 8:18 PM UTC, Daniil Stas wrote:
> > > On Fri, 28 Jul 2023 19:30:18 +0000
> > > "Jarkko Sakkinen" <jarkko@kernel.org> wrote:
> > > =20
> > > > On Thu Jul 27, 2023 at 3:38 PM UTC, Daniil Stas wrote: =20
> >  [...] =20
> > > >=20
> > > > This is needs a bit more elaboration in order to be comprehended.
> > > >=20
> > > > Do you mean by "stutter" unexpected delays and when do they
> > > > happen?
> > > >=20
> > > > BR, Jarkko =20
> > >
> > > Yes, unexpected delays. They just happen randomly.
> > > You can google "AMD fTPM stuttering", there are a lot of examples.
> > > Here is one: https://www.youtube.com/watch?v=3DTYnRL-x6DVI =20
> >=20
> > What if you make tpm_amd_is_rng_defective() to unconditonally return
> > true? Does this make the problem dissappear, or not?
> >=20
> > BR, Jarkko
>
> I already tried compiling kernel without CONFIG_HW_RANDOM_TPM enabled,
> which does the same.
> Yes, it removes the issue.

Thank you, just wanted sanity check that I exactly know what is going on.

BR, Jarkko
