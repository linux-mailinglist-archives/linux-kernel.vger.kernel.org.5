Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411EA77952D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbjHKQvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjHKQvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:51:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3882D78;
        Fri, 11 Aug 2023 09:51:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BFE366790;
        Fri, 11 Aug 2023 16:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421CBC433C8;
        Fri, 11 Aug 2023 16:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691772690;
        bh=+gzQDpDpVxcoDrHfScSrPe9X+T9url7EabBaC/G4uZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ey1PH9BUCoK+Y2d2oG4sNhwVXeEKrvFxCoi2Aj8IQ2CZmf/O9D/VQ8HNVUQ3BwfXR
         j4bnqul1G2ikIzdy0zpD+VhRVGwxNF7qX7fP3GCx0as9ZNUV/UYoViLOLs0Wvqi4eE
         i9cEBJFXE7LuKQkLRLpLgcMBkYHNLJRmzLKl8r7FZjA9klk4ct9EXNkN4LJiIusAab
         4gfVeuwlkfVmfh9mUxr31YL1Qzb/g7RCwlfTt/SY6B/wjFzG0tOTz4tjp9r/4TUGVm
         Z0CTy3Q7GydlMCaf9B//X2+QrlOiX3A/hUdzMM8cWnjJzXKybIh3JTpw0nH7yU/2uC
         IB4iMcdvDqrYg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Aug 2023 19:51:27 +0300
Message-Id: <CUPVD79CBVEF.1A618P66T7KTZ@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Takashi Iwai" <tiwai@suse.de>
Cc:     <linux-integrity@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        <stable@vger.kernel.org>,
        "Lino Sanfilippo" <l.sanfilippo@kunbus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts categorically for
 Lenovo
X-Mailer: aerc 0.14.0
References: <20230810182433.518523-1-jarkko@kernel.org>
 <87zg2yrqmy.wl-tiwai@suse.de> <87pm3tr467.wl-tiwai@suse.de>
In-Reply-To: <87pm3tr467.wl-tiwai@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 11, 2023 at 6:26 PM EEST, Takashi Iwai wrote:
> On Fri, 11 Aug 2023 09:21:09 +0200,
> Takashi Iwai wrote:
> >=20
> > On Thu, 10 Aug 2023 20:24:33 +0200,
> > Jarkko Sakkinen wrote:
> > >=20
> > > By large most of the entries in tpm_tis_dmi_table[] are for Lenovo la=
ptops,
> > > and they keep on coming. Therefore, disable IRQs categorically for Le=
novo.
> > >=20
> > > Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> > > Cc: <stable@vger.kernel.org> # v6.4+
> > > Reported-by: "Takashi Iwai" <tiwai@suse.de>
> > > Closes: https://lore.kernel.org/linux-integrity/87il9qhxjq.wl-tiwai@s=
use.de/
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > > This will be included into v6.5-rc6 PR, as long as Takashi ack's it. =
I'm
> > > planning to send tomorrow morning (GMT+3).
> >=20
> > Feel free to take my ack:
> >=20
> > Acked-by: Takashi Iwai <tiwai@suse.de>
> >=20
> > I'll build a test kernel and ask reporters for testing the fix, too.
>
> FYI, the test results are all positive, so far.

Thanks a lot.

Can you check this that it looks good to you:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/comm=
it/?h=3Dnext&id=3Dbfc4b8c073a6dcfd39d413a7fa1c5ce1ede9f326

Tested-by?

BR, Jarkko
