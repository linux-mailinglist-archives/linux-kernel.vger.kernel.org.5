Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3566A7D8413
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbjJZN7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbjJZN7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:59:01 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33B11BD;
        Thu, 26 Oct 2023 06:58:58 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ce37d0f1a9so559583a34.0;
        Thu, 26 Oct 2023 06:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698328738; x=1698933538;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BN+qtvPSspseGb/uUMPDqoZhAWMErSRG57vJlzJzwzg=;
        b=S9HsYFi7h+ZLNIKQ/eNQbvrcI54Bh+ZMleswTWAGdbmQvKbXlc98QMvnTWLPwiumxp
         2CcVCureP2oAWTH3z0M6tA83FdDniXEfZtBhJLR2SnCluMR3ookj4VrDwFnEbNvbyTJC
         WhmHwb5Yk89X+MKjEV0HOpm6B/zN/1s/h8mfEzOenbXmBAa3YY73L1d4M4CgfhiTinf1
         dHgKEezNmcglnQGOlvK6NAJLtVj6SLTSAskYhydsEs509cBq/h9EwF0LJOCuUsUyYf4y
         BcKETX4Z3WBZ7V1eCwWTKYEWEFymrOF/Ag6G2LC3/GZXv/JiFkEHZm2uWrPYSpjNoZk6
         2YKQ==
X-Gm-Message-State: AOJu0YxX4uZAtzA9jp+AX6i4YJLHK2QBwm5r/K/bUkz+Q8EXUH3RFSEK
        AOTThrZhQKe9gDycUIbLlg==
X-Google-Smtp-Source: AGHT+IGi0KrG1N1eZFWWL6FEyV23fFEYLOJ0fBtoIezsQ/ZaUeZSwF+NPXQ3XZkQjsEeXnG9KD557Q==
X-Received: by 2002:a9d:7ac6:0:b0:6bb:1071:ea72 with SMTP id m6-20020a9d7ac6000000b006bb1071ea72mr18729961otn.36.1698328738112;
        Thu, 26 Oct 2023 06:58:58 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l18-20020a056830269200b006b8e8884f2fsm2652604otu.51.2023.10.26.06.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 06:58:57 -0700 (PDT)
Received: (nullmailer pid 3570816 invoked by uid 1000);
        Thu, 26 Oct 2023 13:58:56 -0000
Date:   Thu, 26 Oct 2023 08:58:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>,
        Sonal Santan <sonal.santan@amd.com>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 0/3] Fix DT based address translations
Message-ID: <20231026135856.GA3567352-robh@kernel.org>
References: <20231017110221.189299-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017110221.189299-1-herve.codina@bootlin.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 01:02:15PM +0200, Herve Codina wrote:
> Hi,
> 
> This patch series fixes a DT based address translation (translations
> using the ranges property).
> 
> The issue is present with a ranges property made of a 3 cells child
> address, a 3 cells parent address and a 2 cells child size.
> This can happen with the recent addition of of_pci_prop_ranges() in
> commit 407d1a51921e ("PCI: Create device tree node for bridge")
> 
> The issue description is fully described in the first patch commit log.
> 
> In this series,
>   - The first patch fixes the issue.
>   - The second patch avoids duplicated code.
>   - The third patch adds unit tests related address translations.
> 
> I previously sent the first patch alone:
>   https://lore.kernel.org/linux-kernel/20231003065236.121987-1-herve.codina@bootlin.com/
> This series v2 has to be considered as the next iteration based on the
> review done on my previous patch sent alone.
> 
> Best regards,
> Hervé
> 
> Changes v1 -> v2
> 
>  - Patch 1
>    Simplify of_bus_default_flags_map().
>    Fix the commit log (pci-ep-bus ranges[0] size is 0x200_0000 instead
>    of 0x2000_0000).
> 
>  - Patch 2 (new in v2)
>    Remove duplicated code.
> 
>  - Patch 3 (new in v2)
>    Add unit tests.
> 
> Herve Codina (3):
>   of: address: Fix address translation when address-size is greater than
>     2
>   of: address: Remove duplicated functions
>   of: unittest: Add tests for address translations
> 
>  drivers/of/address.c                        |  43 ++++++---
>  drivers/of/unittest-data/tests-address.dtsi | 101 ++++++++++++++++++++
>  drivers/of/unittest.c                       |  74 ++++++++++++++
>  3 files changed, 205 insertions(+), 13 deletions(-)

I've applied this. I sent out this series[1] of clean-ups to apply on 
top.

Rob

[1] https://lore.kernel.org/all/20231026135358.3564307-2-robh@kernel.org/
