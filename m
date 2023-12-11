Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B3C80CC15
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343752AbjLKN46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjLKNzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:55:19 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AF12D5F;
        Mon, 11 Dec 2023 05:53:51 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2049AE0009;
        Mon, 11 Dec 2023 13:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702302829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G91nbRDQvTxgKQfiCOALo2gwKx6l/eFwHnf5hoG+LM0=;
        b=aMnK32FXCGdwAu4nD5lUDStjrPYv6UY2bfRpSkznOdBUAROGO/gyK7D1+VFSOQDkJUtoGR
        BarM4TsD+NCHH2SuhVCXltjhSLdHnImDZLJBe8PJlvYn6m8s5erXweYoiZFAPk9kZTcC/0
        y6ZkMzWSgwOk4G48XP8ND6/H3hCETgVcVSjLkRCcOyFmHARjfEbBulMoo3NTmrseHtd4F8
        ybQJt6ww22sW755aErcs/gxkW1unfwNLR/OUTV+jBgJjyAnULZx/JfYkAXg2eeDhYe4Ava
        pIyi0beOnuVE1ndW8y4xhtVoN09sdubK0SdAGRNY07BVgefVUR6hIfYJhfcsBw==
Date:   Mon, 11 Dec 2023 14:53:46 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the nvmem tree
Message-ID: <20231211145346.6665a16d@xps-13>
In-Reply-To: <ad69788c-468e-403e-85fc-a3d82add5041@linaro.org>
References: <20231211164916.6f0d2357@canb.auug.org.au>
        <730b71e2-9c3c-4b40-86a6-0794615222fd@linaro.org>
        <20231211113059.094f4226@xps-13>
        <ad69788c-468e-403e-85fc-a3d82add5041@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Mon, 11 Dec 2023 11:10:19 +0000:

> Hi Miquel,
>=20
> On 11/12/2023 10:30, Miquel Raynal wrote:
> > Hi Srinivas,
> >=20
> > srinivas.kandagatla@linaro.org wrote on Mon, 11 Dec 2023 10:23:40 +0000:
> >  =20
> >> Thankyou Stephen for the patch.
> >>
> >> On 11/12/2023 05:49, Stephen Rothwell wrote: =20
> >>> Hi all,
> >>>
> >>> After merging the nvmem tree, today's linux-next build (i386 defconfi=
g)
> >>> failed like this:
> >>>
> >>> /home/sfr/next/next/drivers/nvmem/core.c: In function 'nvmem_cell_put=
':
> >>> /home/sfr/next/next/drivers/nvmem/core.c:1603:9: error: implicit decl=
aration of function 'nvmem_layout_module_put' [-Werror=3Dimplicit-function-=
declaration]
> >>>    1603 |         nvmem_layout_module_put(nvmem);
> >>>         |         ^~~~~~~~~~~~~~~~~~~~~~~
> >>>
> >>> Caused by commit
> >>>
> >>>     ed7778e43271 ("nvmem: core: Rework layouts to become regular devi=
ces")
> >>>
> >>> I have applied the following patch for today.
> >>>
> >>> From: Stephen Rothwell <sfr@canb.auug.org.au>
> >>> Date: Mon, 11 Dec 2023 16:34:34 +1100
> >>> Subject: [PATCH] fix up for "nvmem: core: Rework layouts to become re=
gular devices"
> >>>
> >>> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> >>> ---
> >>>    drivers/nvmem/core.c | 5 +++++
> >>>    1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> >>> index 9fc452e8ada8..784b61eb4d8e 100644
> >>> --- a/drivers/nvmem/core.c
> >>> +++ b/drivers/nvmem/core.c
> >>> @@ -1491,6 +1491,11 @@ struct nvmem_cell *of_nvmem_cell_get(struct de=
vice_node *np, const char *id)
> >>>    	return cell;
> >>>    }
> >>>    EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
> >>> +
> >>> +#else /* IS_ENABLED(CONFIG_OF) */
> >>> +
> >>> +static inline void nvmem_layout_module_put(struct nvmem_device *nvme=
m) { }
> >>> + =20
> >>
> >> I see no reason why nvmem_layout_module_put() should be even under IS_=
ENABLED(CONFIG_OF).
> >>
> >> Updated the patch with this fixed. =20
> >=20
> > Ok, works for me. I will send a fixup with the doc change (see the
> > other kernel test robot report) so you can squash it as well with the
> > original patch.
> >  =20
> if you have fix up ready, can you send it.

Actually I mixed up two e-mails, I think this is all what is needed on
your branch. I don't have anything else. I thought there was a kernel
doc warning but I cannot find it anymore, so I believe I read my
e-mail too quickly.
=20
Thanks,
Miqu=C3=A8l
