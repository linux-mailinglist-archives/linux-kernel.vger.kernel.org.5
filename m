Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD4476BD5D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjHATKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjHATKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:10:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262571BF0;
        Tue,  1 Aug 2023 12:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFA156168C;
        Tue,  1 Aug 2023 19:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0F8C433C7;
        Tue,  1 Aug 2023 19:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690917003;
        bh=WmZPoZ2ncAPbHyIi412gnUY6DHW9Ve1TXWYRZhaL/6k=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=soesqq4mcDw1KGEMbIxztwJDTTm65/Q75or6DwbtQBcu06HxRy39XXYaf1CdpKHn/
         01+tKdoM5iE4eLEHrIpIyUuLW1wXwgLcjRKGrun79bpyN3JBke61kFc4HOrmRDXS17
         UvG2K8ZAZrqoCPrmxfqaH4u53jy+mKVyfBKjKCnMj9pVz8SbIMrXiblkyjTIrxjFP6
         Fz/jekuvN4DwND/sntPyXAEQWRg/d4DkMwc0rEnDZ7VLhSOb1W+PVXCIiJ6aURaltF
         m3R689cXlQBoPgPLtcTcKsecLKe0Cfm1332ZDQIwiD4p4unVSieyqn8TX6B6aiaHRX
         BuZDlcH31WsuA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 01 Aug 2023 22:09:58 +0300
Message-Id: <CUHG1TB7IELF.PVXOXEXBGEPP@suppilovahvero>
Cc:     "Daniil Stas" <daniil.stas@posteo.net>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        <James.Bottomley@hansenpartnership.com>, <Jason@zx2c4.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <regressions@leemhuis.info>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.14.0
References: <20230727183805.69c36d6e@g14>
 <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
 <20230727193949.55c18805@g14>
 <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
 <20230727195019.41abb48d@g14>
 <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
 <20230727200527.4080c595@g14>
 <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki>
 <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
 <CUHF67ZOFOTN.1UFE7Q1IFRQMX@suppilovahvero>
 <CAHk-=wgK0Z-LrJGExwG=e=oxjD93LJhY3jMmi_2O2_Pkjf8Tsg@mail.gmail.com>
In-Reply-To: <CAHk-=wgK0Z-LrJGExwG=e=oxjD93LJhY3jMmi_2O2_Pkjf8Tsg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 1, 2023 at 9:42 PM EEST, Linus Torvalds wrote:
> On Tue, 1 Aug 2023 at 11:28, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > I would disable it inside tpm_crb driver, which is the driver used
> > for fTPM's: they are identified by MSFT0101 ACPI identifier.
> >
> > I think the right scope is still AMD because we don't have such
> > regressions with Intel fTPM.
>
> I'm ok with that.
>
> > I.e. I would move the helper I created inside tpm_crb driver, and
> > a new flag, let's say "TPM_CHIP_FLAG_HWRNG_DISABLED", which tpm_crb
> > sets before calling tpm_chip_register().
> >
> > Finally, tpm_add_hwrng() needs the following invariant:
> >
> >         if (chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
> >                 return 0;
> >
> > How does this sound? I can refine this quickly from my first trial.
>
> Sounds fine.

Mario, it would be good if you could send a fix candidate but take my
suggestion for a new TPM chip flag into account, while doing it. Please
send it as a separate patch, not attachment to this thread.

I can test and ack it, if it looks reasonable.

> My only worry comes from my ignorance: do these fTPM devices *always*
> end up being enumerated through CRB, or do they potentially look
> "normal enough" that you can actually end up using them even without
> having that CRB driver loaded?

I know that QEMU has TPM passthrough but I don't know how it behaves
exactly.

> Put another way: is the CRB driver the _only_ way they are visible, or
> could some people hit on this through the TPM TIS interface if they
> have CRB disabled?

I'm not aware of such implementations.

> I see, for example, that qemu ends up emulating the TIS layer, and it
> might end up forwarding the TPM requests to something that is natively
> CRB?
>
> But again: I don't know enough about CRB vs TIS, so the above may be a
> stupid question.
>
>            Linus

I would focus exactly what is known not to work and disable exactly
that.

If someone still wants to enable TPM on such hardware, we can later
on add a kernel command-line flag to enforce hwrng. This ofc based
on user feedback, not something I would add right now.

BR, Jarkko
