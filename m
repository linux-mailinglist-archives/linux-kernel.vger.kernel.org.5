Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9B17AD5BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjIYKX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjIYKX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:23:26 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C728E;
        Mon, 25 Sep 2023 03:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1695637396;
        bh=zNEHMjTGryYRc6k3/UydU+1ksmTv+08v4jyV1rUpTZw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Cq7O5cQ1W5BjxBPgVTIeSExTIcnTkss2LgFbDKyL1+OfokdjiQUKwYj/rCeVBYYe6
         OWy/PSeRL8JvoqDTBGlrACxgx8BU3W/8yqcQ3T7L7dU01Y6WaBXoLxw6eyp4Tj9ERH
         vOhPBooPo2/mzjHgHwcQgh8nVjnlSSor0GLts8KQ=
Received: from [127.0.0.1] (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 16B32659AC;
        Mon, 25 Sep 2023 06:23:11 -0400 (EDT)
Message-ID: <aeb2cc43ea4e5281195c8bccd1f033ed73e6a7ef.camel@xry111.site>
Subject: Re: [PATCH 2/6] mmc: sdhci: add __sdhci_execute_tuning() to header
From:   Xi Ruoyao <xry111@xry111.site>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Han Gao <gaohan@iscas.ac.cn>, Icenowy Zheng <uwu@icenowy.me>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Mon, 25 Sep 2023 18:23:10 +0800
In-Reply-To: <4ef60ffd-3661-4bca-91a3-b49d6189c71b@intel.com>
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
         <20230921-th1520-mmc-v1-2-49f76c274fb3@baylibre.com>
         <4ef60ffd-3661-4bca-91a3-b49d6189c71b@intel.com>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-25 at 13:21 +0300, Adrian Hunter wrote:
> On 22/09/23 04:49, Drew Fustini wrote:
> > Expose __sdhci_execute_tuning() so that it can be called from the
> > mmc host controller drivers.
> >=20
> > In the sdhci-of-dwcmshc driver, sdhci_dwcmshc_th1520_ops sets
> > platform_execute_tuning to th1520_execute_tuning(). That function has
> > to manipulate phy registers before tuning can be performed. To avoid
> > copying the code verbatim from __sdhci_execute_tuning() into
> > th1520_execute_tuning(), make it possible for __sdhci_execute_tuning()
> > to be called from sdhci-of-dwcmshc.
> >=20
> > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > ---
> > =C2=A0drivers/mmc/host/sdhci.c | 2 +-
> > =C2=A0drivers/mmc/host/sdhci.h | 1 +
> > =C2=A02 files changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index ff41aa56564e..fd607058d176 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2841,7 +2841,7 @@ void sdhci_send_tuning(struct sdhci_host *host, u=
32 opcode)
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(sdhci_send_tuning);
> > =C2=A0
> > -static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
> > +int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
>=20
> Also need
> 	EXPORT_SYMBOL_GPL(__sdhci_execute_tuning);
>=20
> > =C2=A0{
> > =C2=A0	int i;

By the way should we rename this function?  I think
"__sdhci_execute_tuning" vs "sdhci_execute_tuning" might be confusing
when we export both.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
