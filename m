Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5868804D6F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjLEJSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLEJSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:18:11 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D607A138
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:18:16 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1915034144so648771966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscv-rocks.de; s=google; t=1701767895; x=1702372695; darn=vger.kernel.org;
        h=organization:user-agent:in-reply-to:content-disposition
         :mime-version:references:mail-followup-to:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NyyV7FDLLTugfQIqaxP8FNjfHS3S4eEzbgCWNE04/AY=;
        b=RPil/7n23NNJXri+OQNHPb6RQpSGWxkcEW7Y6g1+BnhYoYY1U9ue3/xYWdKY2DSp+h
         wI9duNOfEYRAWDigjv7cHSX1mAeAry/dT1q+rSrbRqPtx05XJzCOCuHUWI4el2GVWsoV
         ZYuD0/S2WUQDVo2H01Agpqa2XhBa2yS7ESwjQxfyoxxqPEreqn58fTZpboO6x1lwNCGF
         y+FGwletCLLutyN6WPvAxsDNFqqa5FkmpDZSJxOiaCG7P92M6422P/OKErICoX7FcAeV
         7xAqCgVLiL7xXqVolUYXiQeHnzFxwme0oKIHHH7JfgEfOG9zelp7BhVAhuJSzD2ep14A
         4IVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701767895; x=1702372695;
        h=organization:user-agent:in-reply-to:content-disposition
         :mime-version:references:mail-followup-to:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyyV7FDLLTugfQIqaxP8FNjfHS3S4eEzbgCWNE04/AY=;
        b=FsUlxzEoXaIUVedED6GbCfTyPVjbO+TCSkFa4WBtmVni28Yp6J93P1qyXr7JiAZcdT
         HRLvHsJMjQP0YROOOqJwKJU4bQHKX+3k+ZWQtgG2uVQC4mlpLQ9i/LP32a1ln7ZOrE1/
         RLxE/bCAo6VbienGofUIthqvloxvVir4AVLsdHzQAmHXaLROChM2l/O/4qqE2M83UWrB
         vuv+PLbXPTjcK/y4ekZACvZDRVNpQHkN3STipWN1G0Lpm5mL1oahtfUg7N3EVjgUbJOm
         0AkSewssX9IvF79N4Z9xvAYdktEx94EqVNJb9jW/m3CvFaz7P2QreR9PIKuHV+/oAZlb
         vasQ==
X-Gm-Message-State: AOJu0YzC546/aVyC9VBYj3jGhLWu8Hfi5Xs23W0HztO+mDdwKeVX2/5N
        hSgCIM2fVKizCGD6sybSuM0OMOwbnTzW8VLDZXMhLTC7
X-Google-Smtp-Source: AGHT+IGqyRUTu9WLUc6nH2xCm42ZpYmhyLu5VkZd6XTvkBxqfK7IGfbNYY1unAPGXa7vSv96T8dnMQ==
X-Received: by 2002:a17:906:243:b0:a19:a19b:c732 with SMTP id 3-20020a170906024300b00a19a19bc732mr3544020ejl.130.1701767895199;
        Tue, 05 Dec 2023 01:18:15 -0800 (PST)
Received: from fedora (p549451d5.dip0.t-ipconnect.de. [84.148.81.213])
        by smtp.gmail.com with ESMTPSA id js22-20020a17090797d600b00a1b32663d7csm3271996ejc.102.2023.12.05.01.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:18:14 -0800 (PST)
Date:   Tue, 5 Dec 2023 10:18:12 +0100
From:   Damian Tometzki <damian@riscv-rocks.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Minda Chen <minda.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v11 0/20] Refactoring Microchip PCIe driver and add
 StarFive PCIe
Message-ID: <ZW7q1LEvEpVxoI4l@fedora>
Reply-To: Damian Tometzki <damian@riscv-rocks.de>
Mail-Followup-To: Bjorn Helgaas <helgaas@kernel.org>,
        Minda Chen <minda.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <c4154501-5b93-4eaf-8d2d-690809d26c57@starfivetech.com>
 <20231204212807.GA629695@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204212807.GA629695@bhelgaas>
User-Agent: Mutt
X-Operating-System: Linux Fedora release 39 (Thirty Nine) (Kernel 6.7.0-rc4)
Organization: Linux hacker
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04. Dec 15:28, Bjorn Helgaas wrote:
> On Sat, Dec 02, 2023 at 09:17:24PM +0800, Minda Chen wrote:
> > ...
> > Please check this configuation.
> > CONFIG_PHY_STARFIVE_JH7110_PCIE=y
> > CONFIG_PINCTRL_STARFIVE_JH7110=y
> > CONFIG_PINCTRL_STARFIVE_JH7110_SYS=y
> > CONFIG_PINCTRL_STARFIVE_JH7110_AON=y
> > 
> > BTW, Maybe you can reply e-mail to me only.
> 
> There's usually no benefit to replying off-list.  The list archives
> are very valuable for future maintenance because they help us
> understand the reason things were done a certain way.
> 
> Bjorn
Hello together,
the main problemwas was  to find the rquired CONFIG_* options for StarFive
Board. It would be great to have an CONFIG_ Options with all required
Dependencies.

Best regards
damian
 

