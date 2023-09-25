Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925D47ADA30
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjIYOlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjIYOlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:41:47 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8919A103
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:41:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-404fbfac998so73866165e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695652899; x=1696257699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnQkb6b5eXRZq2LrytU5CtIWVTHEXBAeVcMvdSE/Rjs=;
        b=RgrjnsBAhL6Gsfqefnw2S4Nddo2drXSwMMH3mHDEhVQILMGP2SstZN882aVhsvu3Dx
         jEU5hGPGMuOS96AWyEsw5yI2nSuXu36pR6so+ZjVD2GO26joIZ+xPZMEq2dBTqIeXiC4
         0PoLZfHkDnK1fCiPeiOuAo/3G3gpDbezpoiqq/4iP7X6Dc/TFjEwSR6PlyvEk6Djrhjd
         CdCI2Ir1ClAcaXdrObTwAZswQVphBhq2PZd5Z0mJ7Dv/d7/n80+bcQIpqTeMm6hUvjAQ
         h+NPxqixVADe3HyJnaitXq7qVHoOiu7vTjPvpgmTeYfA8+k5kjSlVua3f87IZrcpBFCD
         XZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695652899; x=1696257699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnQkb6b5eXRZq2LrytU5CtIWVTHEXBAeVcMvdSE/Rjs=;
        b=sdlrxp1gUqQDXEdDrO7i5fhvUMJjI2IaGUxoHBJtr+nqclG8Y/sj1ORWNpWXIDB0LW
         5oKlaH9Q3J/llP6Ox9d9fofEJ1l/Xt/zZuK6kRWlS1okVyKUnPk1VlkSnfR0CviuL78i
         A6VwZtxXzwBc9mIpsDKvtY/TbR/CDgDcHd8HdYkYeHngC/wPKFspAMLV9FA7kPxQ1Ajq
         b+g4tXEBrrbYMlq8yeKvmfIVDcBj6hOo5/pdrOWZgPIdAaXzl+BTNhZLYZJMLHVB8nEO
         6ChH3orBz9B2xASORxY5hxoKCHZEmy492+QBZ31pOzJeEmRTbs+qdgnl72Faur8KMAZE
         iccw==
X-Gm-Message-State: AOJu0Yyyqw/S6IZrEfvpvrV1HNDm9RDuLP/Vg7ECjpXo01zmKeGJX9YQ
        hPEApCVqVPeuq669pOxRVNcZaA==
X-Google-Smtp-Source: AGHT+IHPb8vKchvFnY0s05TsviFcSJxnsXgmrDWlqO7Le6/fH+Zwot+4Ces80LRgrG4M+d5CjIT0Lw==
X-Received: by 2002:adf:f205:0:b0:31f:8a6d:e527 with SMTP id p5-20020adff205000000b0031f8a6de527mr6030302wro.45.1695652898924;
        Mon, 25 Sep 2023 07:41:38 -0700 (PDT)
Received: from x1 ([193.52.24.5])
        by smtp.gmail.com with ESMTPSA id bt14-20020a056000080e00b003200c918c81sm5683354wrb.112.2023.09.25.07.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 07:41:38 -0700 (PDT)
Date:   Mon, 25 Sep 2023 16:41:30 +0200
From:   Drew Fustini <dfustini@baylibre.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/6] mmc: sdhci: add __sdhci_execute_tuning() to header
Message-ID: <ZRGcGnl8N80yblkw@x1>
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
 <20230921-th1520-mmc-v1-2-49f76c274fb3@baylibre.com>
 <4ef60ffd-3661-4bca-91a3-b49d6189c71b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ef60ffd-3661-4bca-91a3-b49d6189c71b@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 01:21:05PM +0300, Adrian Hunter wrote:
> On 22/09/23 04:49, Drew Fustini wrote:
> > Expose __sdhci_execute_tuning() so that it can be called from the
> > mmc host controller drivers.
> > 
> > In the sdhci-of-dwcmshc driver, sdhci_dwcmshc_th1520_ops sets
> > platform_execute_tuning to th1520_execute_tuning(). That function has
> > to manipulate phy registers before tuning can be performed. To avoid
> > copying the code verbatim from __sdhci_execute_tuning() into
> > th1520_execute_tuning(), make it possible for __sdhci_execute_tuning()
> > to be called from sdhci-of-dwcmshc.
> > 
> > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > ---
> >  drivers/mmc/host/sdhci.c | 2 +-
> >  drivers/mmc/host/sdhci.h | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index ff41aa56564e..fd607058d176 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2841,7 +2841,7 @@ void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_send_tuning);
> >  
> > -static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
> > +int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
> 
> Also need
> 	EXPORT_SYMBOL_GPL(__sdhci_execute_tuning);

Thank, I will add that.

I wasn't sure if making __sdhci_execute_tuning() available outside of
sdhci.c was going to be seen as an acceptable solution.

Do you think my apporach is acceptable (once I add EXPORT_SYMBOL_GPL)?

Thanks,
Drew
