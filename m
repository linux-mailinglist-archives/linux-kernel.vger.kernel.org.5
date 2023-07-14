Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4626753DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbjGNOjx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jul 2023 10:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbjGNOjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:39:51 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A244BC1;
        Fri, 14 Jul 2023 07:39:50 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-98e1fc9d130so55767066b.0;
        Fri, 14 Jul 2023 07:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689345589; x=1691937589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uqk2kWFpKCNIHS0V3Eun0NY/W3j63YHRH1/UBNPRx40=;
        b=l0wxbSkAh1fESKqddeMcijJa3scTgSqRyKFp5emISDGaQmOfBnK/6Yx/zDv2n6d95S
         5MTuKyYnnDbCdBe91jzEwbvMf2SV3dUsTMKIukV7znzD+5NHZ+f1F5XYTKiuze89DZTH
         20gklicBscJpwVH14mwYsF1DlUz1FQEXMs83rJf0GdvfHCuukZvuTVZG6LUgbCccCm1Y
         QB2cyepUZs92wKbc5ZpC4u29X/6auoRxiwTUt2IOZmrLtDWMaYJTwgiipegd2Kmn5aCt
         zWevuTB7fGS41YOMLPrj5YY9KIYS1o8ycwS7+9rOGxeV7ViGFyEJ/swTNGMvsoJyITTH
         Ymzw==
X-Gm-Message-State: ABy/qLYv+hdkb4f/96KWN5einQAYXHSAuR+h8k6AVRRuFQGLCWTqe0kO
        D8fsriA0bHmqSrLVOxFisOkh56PYR/tAwDKJuwY=
X-Google-Smtp-Source: APBJJlF49+bXOJw780PQQaOR/4uepS5BzQy3qzM2cgHLnsecGTO4wWEMweEjE0fJTDoer0NalhruZAbc60zTD44a8x0=
X-Received: by 2002:a17:906:77cd:b0:994:33b2:c32d with SMTP id
 m13-20020a17090677cd00b0099433b2c32dmr3809694ejn.5.1689345588930; Fri, 14 Jul
 2023 07:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230704050238.712223-1-rui.zhang@intel.com> <CAJZ5v0gZz1RCqp=Do0RTOCwPvWW9E_SQSyFjuRVuBkR9jxCJjw@mail.gmail.com>
 <a6d032df2b664950a63518c83a7db3f3@AcuMS.aculab.com>
In-Reply-To: <a6d032df2b664950a63518c83a7db3f3@AcuMS.aculab.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jul 2023 16:39:35 +0200
Message-ID: <CAJZ5v0hu2Gimbxv+RSQVRyLXOPSCNSzQDdneS8ig4zn63VkUKA@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl_tpmi: Fix a sparse warning
To:     David Laight <David.Laight@aculab.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 3:34 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Rafael J. Wysocki
> > Sent: 11 July 2023 19:14
> ...
> > On Tue, Jul 4, 2023 at 7:02 AM Zhang Rui <rui.zhang@intel.com> wrote:
> > >
> > > Fix a sparse warning in intel_rapl_tpmi driver.
> > >
> > > ../drivers/powercap/intel_rapl_tpmi.c:141:41: sparse: warning: incorrect type in initializer
> > (different address spaces)
> > > ../drivers/powercap/intel_rapl_tpmi.c:141:41: sparse:    expected unsigned long long [usertype]
> > *tpmi_rapl_regs
> > > ../drivers/powercap/intel_rapl_tpmi.c:141:41: sparse:    got void [noderef] __iomem *
> > >
> > > Fixes: 9eef7f9da928 ("powercap: intel_rapl: Introduce RAPL TPMI interface driver")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202307031405.dy3druuy-lkp@intel.com/
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > >  drivers/powercap/intel_rapl_tpmi.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
> > > index 4f4f13ded225..05f664a096ab 100644
> > > --- a/drivers/powercap/intel_rapl_tpmi.c
> > > +++ b/drivers/powercap/intel_rapl_tpmi.c
> > > @@ -138,7 +138,7 @@ static int parse_one_domain(struct tpmi_rapl_package *trp, u32 offset)
> > >         enum tpmi_rapl_register reg_index;
> > >         enum rapl_domain_reg_id reg_id;
> > >         int tpmi_domain_size, tpmi_domain_flags;
> > > -       u64 *tpmi_rapl_regs = trp->base + offset;
> > > +       u64 *tpmi_rapl_regs = (u64 *)(trp->base + offset);
> > >         u64 tpmi_domain_header = readq((void __iomem *)tpmi_rapl_regs);
>
> Isn't the correct fix to add __iomem to the definition of
> tpmi_rapi_regs and also remove the cast from the following
> readq() line?

Good point.

Rui, can you take another look at this, please?
