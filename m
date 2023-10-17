Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DB87CCAD7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjJQShu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjJQShs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:37:48 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E580990;
        Tue, 17 Oct 2023 11:37:46 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-581d4f9a2c5so544588eaf.0;
        Tue, 17 Oct 2023 11:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697567866; x=1698172666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLFTW47UAIBGXkLdBcrMObcIRWeTgSfUsdng3xDHxtM=;
        b=BMwypR2a5byScN7pz4lybK0Vrn2rJXmjZXHBBPDK9nR11/1aDXVNLGgNRmUmsHYdB3
         8QZMnZEZCWm9n5mGbvQPsTMI3YghS9plqHP8Djnvu27VhaTFUKkabh7L9DULpaF2Amb0
         EGO+cOjpylpbqlmLxFBf2RGFI3a9M75NbObdgOOQv4cicyzqlV6VM/mOatjMVsIYFZie
         V7KRh4inPb8H4SPfjE3Mp5P+rJE+A5ALqzZFzj0JJUGhcC0koJcXnh3jzu3zQuTql6Hi
         IO4J74pVs2kxTY6d2M1D2eUcFSXhPNekKjNO2NXdOXh63GWyh/nhiEd/cLP5UGEasIIh
         /atQ==
X-Gm-Message-State: AOJu0Yw+byuWpPmIR9T0as8O2UHzvJd/lzODXUpcpe7P3872r9GAqA43
        Cnji4hG7uWlARizWoJxVtQ==
X-Google-Smtp-Source: AGHT+IGYM6bN09eNkmdiIkM37jIqZ+Xk32CbW/vA5PPI8vSWSwNcgWp/futKRqQbnQwewp5XJ/6FzA==
X-Received: by 2002:a05:6820:608:b0:57b:92f2:1f64 with SMTP id e8-20020a056820060800b0057b92f21f64mr4158748oow.8.1697567866077;
        Tue, 17 Oct 2023 11:37:46 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id br7-20020a0568201a4700b00573fb6178a6sm343044oob.44.2023.10.17.11.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 11:37:45 -0700 (PDT)
Received: (nullmailer pid 2487541 invoked by uid 1000);
        Tue, 17 Oct 2023 18:37:43 -0000
Date:   Tue, 17 Oct 2023 13:37:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peng Fan <peng.fan@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v3 1/2] amba: bus: balance firmware node reference
 counting
Message-ID: <169756785858.2487391.2620832432762980006.robh@kernel.org>
References: <20231006145732.3419115-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006145732.3419115-1-andriy.shevchenko@linux.intel.com>
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


On Fri, 06 Oct 2023 17:57:31 +0300, Andy Shevchenko wrote:
> Currently the ACPI code doesn't bump the reference count of
> the firmware node, while OF counter part does. Not that it's
> a problem right now, since ACPI doesn't really use the reference
> counting for firmware nodes, it still makes sense to make code
> robust against any changes done there. For this,
>  - switch ACPI case to use device_set_node() to be unified with OF
>  - move reference counting to amba_device_add()
>  - switch to use firmware nodes instead of OF ones
> 
> In the result we will have reference counting done in the same module
> for all callers independently on the nature of firmware node behind.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v3: no changes
> v2: fixed compilation error (LKP), all dependencies are in v6.6-rcX (Rob)
> 
>  drivers/acpi/arm64/amba.c | 2 +-
>  drivers/amba/bus.c        | 5 ++++-
>  drivers/of/platform.c     | 2 +-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 

Applied, thanks!

