Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1BE779518
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjHKQtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjHKQtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:49:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6906630C1;
        Fri, 11 Aug 2023 09:49:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0958067735;
        Fri, 11 Aug 2023 16:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6B7C433C9;
        Fri, 11 Aug 2023 16:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691772559;
        bh=eKkCZ/d+MEomhlb+8xM1aZnvpCXRBuIypiz4jujb2ag=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=uTj8Lk0uk7vMXk0fpJANo1H0prc+mKNBzBPevVLAiPlcXBwhA38BTjDXoS4fbzNru
         ztQLlRASqqGlgkiaxQ9/8Pi/H74LbLeyoJFt4oPFzH6N5jpRTgYsCrNnpMR8oTaHc0
         zaajxD5/qKDAX2OfTGVhTylLe8jFCnSG9seics6WtYhpDDn8kuaiYs90SvWTqIy2pC
         0lEqo8moq3M+KNsPiVI7t6OU2vQgNI5RrisY/QfMjM/njJLYU/4hfsemAogmc4B+xi
         5qpj1OkA2ABT4/ivMJWk5/VMg7y1wnxA7/pAzMNwRagbL1UdOMFYON/ruDc0JuZqRr
         4skv5KZv0JV3A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Aug 2023 19:49:15 +0300
Message-Id: <CUPVBIYZ2B34.P1LAY8LPFQEQ@suppilovahvero>
To:     "Takashi Iwai" <tiwai@suse.de>
Cc:     <linux-integrity@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        <stable@vger.kernel.org>,
        "Lino Sanfilippo" <l.sanfilippo@kunbus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts categorically for
 Lenovo
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230810182433.518523-1-jarkko@kernel.org>
 <87zg2yrqmy.wl-tiwai@suse.de> <87wmy2rqjy.wl-tiwai@suse.de>
In-Reply-To: <87wmy2rqjy.wl-tiwai@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 11, 2023 at 10:22 AM EEST, Takashi Iwai wrote:
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
> Also, it's worth to put the link to the original bug report:
>
> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1213779

These days it is recommended afaik to use "Closes:" so I used that
(checkpatch even complains if it does not exist when you have a
reported-by tag).

BR, Jarkko
