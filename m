Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888EF7FDBB4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343529AbjK2Pl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbjK2Pl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:41:27 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCE2D46;
        Wed, 29 Nov 2023 07:41:33 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1f5d34235dbso470732fac.0;
        Wed, 29 Nov 2023 07:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701272493; x=1701877293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhWAdsQici9g+lW6DZXRUrjB3jILRrvTFlf8WoGKfH4=;
        b=XolJwodWxaX2Czxd4YF2+ibDGPv4o8fIF6c5qy+cijfJ45iNWxJEG7NDwv+pRQpSS+
         T2IFX4YWNj4t3maYb+3f12jdBFxHGybMNJPm/305RcTnn6DaDPZ3qm0KMqIQ3dk9S679
         WfjCWas6wUNnrzahBsOyKvlJc51mFhGUjN0OYjgnk1XzhPAuCRj9JLC7xDJEbL/yyTJW
         aR5qhCxg7nqk0d+WJhDrmaxKBmaFUUUA+gr1Gdi049vH4aIcps/ZcWIgmkYkL9Z4LQUT
         S5YYUhxyLQy81mlSsfmqcKhziw+Io9Pt9EdzdCMaLp7UlBRrQUfoOSVSyc4Kg50s2aQV
         l51g==
X-Gm-Message-State: AOJu0YzyqY4at0sHDEqLxrOFvzwlHUyuyfTPzlzi+8atxOiPENXqd6pe
        NPVLIwdvFJFfcABGFL+Dzw==
X-Google-Smtp-Source: AGHT+IGShj4w5pAAan02Vu2TdEfoW9dIA5VZFrU5p2wq/oTBmRvMEWXn+CtF2RmZFL6FNEfaedG+wA==
X-Received: by 2002:a05:6870:4d0b:b0:1fa:692:f3c4 with SMTP id pn11-20020a0568704d0b00b001fa0692f3c4mr9952940oab.8.1701272493024;
        Wed, 29 Nov 2023 07:41:33 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id oo14-20020a0568715a8e00b001fa52b18d3dsm1633149oac.57.2023.11.29.07.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 07:41:32 -0800 (PST)
Received: (nullmailer pid 2534299 invoked by uid 1000);
        Wed, 29 Nov 2023 15:41:31 -0000
Date:   Wed, 29 Nov 2023 09:41:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     James Tai <james.tai@realtek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v3 2/6] irqchip: Add interrupt controller support for
 Realtek DHC SoCs
Message-ID: <20231129154131.GA2492847-robh@kernel.org>
References: <20231129054339.3054202-1-james.tai@realtek.com>
 <20231129054339.3054202-3-james.tai@realtek.com>
 <d94c79bf-04c4-4e87-bd7e-a8755508ac89@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d94c79bf-04c4-4e87-bd7e-a8755508ac89@suswa.mountain>
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 11:21:06AM +0300, Dan Carpenter wrote:
> On Wed, Nov 29, 2023 at 01:43:35PM +0800, James Tai wrote:
> > +static int realtek_intc_subset(struct device_node *node, struct realtek_intc_data *data, int index)
> > +{
> > +	struct realtek_intc_subset_data *subset_data = &data->subset_data[index];
> > +	const struct realtek_intc_subset_cfg *cfg = &data->info->cfg[index];
> > +	int irq;
> > +
> > +	irq = irq_of_parse_and_map(node, index);
> > +	if (irq <= 0)
> > +		return irq;
> 
> I don't think irq_of_parse_and_map() can return negatives.  Only zero
> on error.  Returning zero on error is a historical artifact with IRQ
> functions and a constant source of bugs.  But here returning zero is
> success.  See my blog for more details:
> https://staticthinking.wordpress.com/2023/08/07/writing-a-check-for-zero-irq-error-codes/

It's worse than that. The irq functions historically returned NO_IRQ on 
error, but that could be 0 or -1 depending on the arch.

Use of_irq_get() instead. It's a bit better in that it returns an error 
code for most cases. But still returns 0 on mapping failure.

Rob
