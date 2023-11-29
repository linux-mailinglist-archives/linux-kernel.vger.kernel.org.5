Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A859D7FCF4A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 07:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377003AbjK2GjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 01:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjK2GjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 01:39:08 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FFC19B1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:39:13 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-332ff20ec45so288620f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 22:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscv-rocks.de; s=google; t=1701239951; x=1701844751; darn=vger.kernel.org;
        h=organization:user-agent:in-reply-to:content-disposition
         :mime-version:references:mail-followup-to:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p6/IzwZ4++Eyvr4AEHiFF29kjsF9e99uXuz1YF9cXMU=;
        b=gC7E73IOXPuC+2a0dlSbZx1zk2KadYvV/uJtC4kaYp9tj5j+s0VusSfKw0EOH07q4e
         GdrmPHmNlVazQeZNZpmbJ4yRygflz5VEzbKibIbf6Vb8+3ymgL8yjJvlHt8J2pD8iTmA
         W6tuNLd1mLLAq5o99h8WxbM46YaQVQWBFzAxZGztOBbY6x+Q/pM2j8sAHIt9YDndfxMn
         UsLLxhwkw6QTHWaBAiMxqVzhwOkdVDIVaw+31F1Z/bqkb7b1kWQCczcgM0JxQcCLmprT
         C1fityS8al1/gpB6H9kfxRLFlkQhc0X9s0LcRf+dMTqfrWm09buSk4qk8tA/tZNc4A1W
         NMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701239951; x=1701844751;
        h=organization:user-agent:in-reply-to:content-disposition
         :mime-version:references:mail-followup-to:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6/IzwZ4++Eyvr4AEHiFF29kjsF9e99uXuz1YF9cXMU=;
        b=clxAJrzff3Z338Q6sB2hwg4MUrrVD95Q2dKdJY+ryKMardC7YMOhrZtcOmU7LInNGE
         MnfHtQ/eBNUnbThJpqQ6BqcqsNhN5F3cx2Kw4TZ3zLsLusHh2y3q5t+qWCvHy7ZwWi5s
         wkwiAW3NbxJsKuxIRM4T390y9bGfON8e8I7kdzS+y3LjOGzNDHC0y1xunK3HzeC/XzkX
         l8rAOp1s8VyIufeI/3ygryIe9nODdl8SAC6aV8j20xogLqS7kx7yHIJhGFMGQsVVG2GL
         6mPj1+lklfciBY5oygllnq6oHkBDQTuiReTq6LHkygbQTAHPfHbBIO3TzhnpF8/+nvk5
         8KiA==
X-Gm-Message-State: AOJu0YwZF+IaFw2W//UgLSHvge47N2au/ZpcZymkXFBXvdQjtZ+cbAGt
        BBEokKt9bAfLI44VXgAkFzlcVA==
X-Google-Smtp-Source: AGHT+IElrXCuUdhI0iLq/2tfxGtJ0D6cTrgJFsBONc6wg4+Vq6XFLxyIlQW5+yVV6mihnLaW4mCZUA==
X-Received: by 2002:a05:6000:1c3:b0:332:eaf0:cebb with SMTP id t3-20020a05600001c300b00332eaf0cebbmr14360551wrx.18.1701239951094;
        Tue, 28 Nov 2023 22:39:11 -0800 (PST)
Received: from fedora.fritz.box (p549451cc.dip0.t-ipconnect.de. [84.148.81.204])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c261300b0040523bef620sm521833wma.0.2023.11.28.22.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 22:39:10 -0800 (PST)
Date:   Wed, 29 Nov 2023 07:39:08 +0100
From:   Damian Tometzki <damian@riscv-rocks.de>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Conor Dooley <conor@kernel.org>,
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
Message-ID: <ZWbcjKiSfvp-74CL@fedora.fritz.box>
Reply-To: Damian Tometzki <damian@riscv-rocks.de>
Mail-Followup-To: Minda Chen <minda.chen@starfivetech.com>,
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
References: <20231115114912.71448-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115114912.71448-1-minda.chen@starfivetech.com>
User-Agent: Mutt
X-Operating-System: Linux Fedora release 39 (Thirty Nine) (Kernel 6.7.0-rc3)
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

Hello Minda,

i tried this Patchset on Linux-6.6.3 but boot with nvme doesnt work. Linux doesnt find
/root partition /dev/nvme0n1p4. 
I dont know if it has anything to do with this patchset ?
Best regards
Damian

On Wed, 15. Nov 19:48, Minda Chen wrote:
> This patchset final purpose is add PCIe driver for StarFive JH7110 SoC.
> JH7110 using PLDA XpressRICH PCIe IP. Microchip PolarFire Using the
> same IP and have commit their codes, which are mixed with PLDA
> controller codes and Microchip platform codes.
> 
> For re-use the PLDA controller codes, I request refactoring microchip
> codes, move PLDA common codes to PLDA files.
> Desigware and Cadence is good example for refactoring codes.
> 
> ----------------------------------------------------------
> The refactoring patches total number is 16,(patch 1-16)
> which do NOT contain changing logic of codes.
> 
> These patches just contain three type basic operations.
> (rename, modify codes to support starfive platform, and moving to common file)
> If these patched are all be reviewed. They can be accepted first.
> 
> Refactoring patches can be devided to different groups
> 1. (patch 1- 3 is the prepare work of refactoring)
> patch1 is move PLDA XpressRICH PCIe host common properties dt-binding
>        docs from microchip,pcie-host.yaml
> patch2 is move PolarFire codes to PLDA directory.
> patch3 is move PLDA IP register macros to plda-pcie.h
> 
> 2. (patch4 - 6 is processing and re-use PCIe host instance)
> patch4 is add bridge_addr field to PCIe host instance.
> patch5 is rename data structure in microchip codes.
> patch6 is moving two data structures to head file
> 
> 3. (patch 7 - 9 are for re-use two PCIe setup function)
> patch7 is rename two setup functions in microchip codes, prepare to move
> to common file.
> patch8 is change the arguments of plda_pcie_setup_iomems()
> patch9 is move the two setup functions to common file pcie-plda-host.c
> 
> 4.(patch 10 - 16 are for re-use interupt processing codes)
> patch10 is rename the IRQ related functions, prepare to move to
> pcie-plda-host.c
> patch 11 - 15 is modify the interrupt event codes, preparing for support starfive
> and microchip two platforms.
> patch16 is move IRQ related functions to pcie-plda-host.c
> 
> ------------------------------------------------------------
> The remainder patches (patch 17 -20) are not refactoring patch.
> They are for adding StarFive codes and dont modify the microchip's
> codes.
> 
> patch17 is Add PLDA event interrupt codes and host init/deinit functions.
> patch18 is add StarFive JH7110 PCIe dt-binding doc.
> patch19 is add StarFive JH7110 Soc PCIe codes.
> patch20 is Starfive dts config
> 
> This patchset is base on v6.7-rc1
> 
> previous version:
> v6:https://patchwork.kernel.org/project/linux-pci/cover/20230915102243.59775-1-minda.chen@starfivetech.com/
> v7:https://patchwork.kernel.org/project/linux-pci/cover/20230927100802.46620-1-minda.chen@starfivetech.com/
> v8:https://patchwork.kernel.org/project/linux-pci/cover/20231011110514.107528-1-minda.chen@starfivetech.com/
> v9:https://patchwork.kernel.org/project/linux-pci/cover/20231020104341.63157-1-minda.chen@starfivetech.com/
> v10:https://patchwork.kernel.org/project/linux-pci/cover/20231031115430.113586-1-minda.chen@starfivetech.com/
> 
> change:
>   v11:
>      check and modify some commit messages again.
>      All the codes are the same with v10.   
> 
>   v10:
>    All the commit message set to fit in 75 columns.
>    All the codes fit in less than 80 colunms.
>    patch 14: 
> 	Commit message changes suggested by Conor.
>    patch 19:
>         Add 100 ms delay macro to pci.h
> 	generic phy pointer related codes moving to pcie-starfive.c
> 	This patch Change pcie-starfive only, bus_ops move to patch 16.
> 	Some Codes changes suggested by Bjorn.
> 
>   v9:
>    v8 patch 10 squash to v9 patch 12, v8 patch 18 squash to v9 patch 16.
>    patch 4 - 16: Add new review tags and add more accurate commit messages.
>    patch 17: move the plda_pcie_host_init/deinit from patch 19. Make
>              plda driver become to whole driver.
> 
>   v8:
>     The patch description in cover-letter has been changed.
> 
>     v7 patch 4 split to v8 patch 4 - 6.
>         (It is patches about re-use pcie host data structure, new patches just contain one
> 	function modification. It is more reguluar and easier to review).
> 
>     patch 7- 9: modify the commit messages and add reason of
> 		modifcation.
>     patch10- 16 :
>              Add review tag and add more commit messages to declear the
> 	     reason of modifying the codes.
>     patch17: plda_handle_events() using bit mask macro. The function are
> 	     easier to read.
> 
>   v7:
>     patch17: fix the build warning.
>     patch19: Some format changes (Emil's comment)
>     patch20: change the pcie node sequences by alphabetical
>              delete the "interupt-parent" in pcie node.
> 
>   v6:
>     v5 patch 4 split to patch 4 -9. New patches just contain one function modification. It is more reguluar.
> 
>     patch 9: Just move the two setup functions only
>     patch 19 : draw a graph of PLDA local register, make it easier to
>                review the codes.
>     v5 patch 7 split to patch 10- 16. Each patch just contain one
>                 function modification. It is more regular.
>     patch 10: rename IRQ related functions.
>     patch 11 - 15 : modify the events codes, total five patch.
>     patch 16: move IRQ related functions to pcie-plda-host.c
>     patch 19- 20 using "linux,pci-domain" dts setting.
> 
> Minda Chen (20):
>   dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
>   PCI: microchip: Move pcie-microchip-host.c to plda directory
>   PCI: microchip: Move PLDA IP register macros to pcie-plda.h
>   PCI: microchip: Add bridge_addr field to struct mc_pcie
>   PCI: microchip: Rename two PCIe data structures
>   PCI: microchip: Move PCIe host data structures to plda-pcie.h
>   PCI: microchip: Rename two setup functions
>   PCI: microchip: Change the argument of plda_pcie_setup_iomems()
>   PCI: microchip: Move setup functions to pcie-plda-host.c
>   PCI: microchip: Rename interrupt related functions
>   PCI: microchip: Add num_events field to struct plda_pcie_rp
>   PCI: microchip: Add request_event_irq() callback function
>   PCI: microchip: Add INTx and MSI event num to struct plda_event
>   PCI: microchip: Add get_events() callback function
>   PCI: microchip: Add event IRQ domain ops to struct plda_event
>   PCI: microchip: Move IRQ functions to pcie-plda-host.c
>   PCI: plda: Add event interrupt codes and host init/deinit functions
>   dt-bindings: PCI: Add StarFive JH7110 PCIe controller
>   PCI: starfive: Add JH7110 PCIe controller
>   riscv: dts: starfive: add PCIe dts configuration for JH7110
> 
>  .../bindings/pci/microchip,pcie-host.yaml     |  55 +-
>  .../pci/plda,xpressrich3-axi-common.yaml      |  75 ++
>  .../bindings/pci/starfive,jh7110-pcie.yaml    | 120 ++++
>  MAINTAINERS                                   |  19 +-
>  .../jh7110-starfive-visionfive-2.dtsi         |  64 ++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  86 +++
>  drivers/pci/controller/Kconfig                |   9 +-
>  drivers/pci/controller/Makefile               |   2 +-
>  drivers/pci/controller/plda/Kconfig           |  29 +
>  drivers/pci/controller/plda/Makefile          |   4 +
>  .../{ => plda}/pcie-microchip-host.c          | 602 ++--------------
>  drivers/pci/controller/plda/pcie-plda-host.c  | 657 ++++++++++++++++++
>  drivers/pci/controller/plda/pcie-plda.h       | 266 +++++++
>  drivers/pci/controller/plda/pcie-starfive.c   | 460 ++++++++++++
>  drivers/pci/pci.h                             |   7 +
>  15 files changed, 1851 insertions(+), 604 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
>  create mode 100644 drivers/pci/controller/plda/Kconfig
>  create mode 100644 drivers/pci/controller/plda/Makefile
>  rename drivers/pci/controller/{ => plda}/pcie-microchip-host.c (54%)
>  create mode 100644 drivers/pci/controller/plda/pcie-plda-host.c
>  create mode 100644 drivers/pci/controller/plda/pcie-plda.h
>  create mode 100644 drivers/pci/controller/plda/pcie-starfive.c
> 
> 
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> -- 
> 2.17.1
> 
