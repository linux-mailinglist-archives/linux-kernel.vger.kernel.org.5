Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F217DA28F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346579AbjJ0Vib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0Vi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:38:29 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC326B0;
        Fri, 27 Oct 2023 14:38:27 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3ae5a014d78so1808123b6e.1;
        Fri, 27 Oct 2023 14:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698442707; x=1699047507;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VV8Y/zqWOyOyj9MA+JjAGw6dwCs6zYKJK0DrbktN/0Q=;
        b=xHCzMyzmJbb+PgPEosQevMdAlWebD+AmX1eoJ3SdMsbE3lbqVrmphH0fAJ9TqCPHcW
         w/I9eGDwH+2uRzMht4TDa4EMN36A4E1p4xCUn5PAZWpbqlh63rP8lWkAXKItmaIEjrGv
         NtwgB+gfXcIZCqF3c/1RZEuIn0hvb4A6LgK9+WZqfQyQPqcm9m1dCDe4asIRnaT4gQXb
         afooJBgJbbRSNiEaElaeTEfR0aDXaS/XRap4nhNiw+nj7gM8c6S8ut4pOfTC/tgEz19o
         A8oxRKpZrvqFbwIxTrstM/obB2eRRIiHAdag1bJz+bimmHj6Cu39ijmQNanu6Dqbmpjd
         uO6g==
X-Gm-Message-State: AOJu0YwsfxhLgGuuOmMsVZFBlQo+ibO+JlahriKqIfgNHSADb8fO8Wee
        8uL+bGMEROmqcDo3rR+X4g==
X-Google-Smtp-Source: AGHT+IHNV+P5hgurCcMFrxa/aHq6K4VEJjP14O5KjqfBtUZ4qmUT65FmoCi5UaJ+a5hXPc9/ZNP5Zw==
X-Received: by 2002:a05:6808:7da:b0:3ad:e05b:6745 with SMTP id f26-20020a05680807da00b003ade05b6745mr4135494oij.27.1698442707162;
        Fri, 27 Oct 2023 14:38:27 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id de8-20020a0568200a8800b00586d187ed06sm237653oob.48.2023.10.27.14.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 14:38:25 -0700 (PDT)
Received: (nullmailer pid 3416502 invoked by uid 1000);
        Fri, 27 Oct 2023 21:38:24 -0000
Date:   Fri, 27 Oct 2023 16:38:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Sonal Santan <sonal.santan@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Max Zhen <max.zhen@amd.com>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Lizhi Hou <lizhi.hou@amd.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/1] of: unittest: Fix test build on config without
 CONFIG_OF_ADDRESS
Message-ID: <169844262050.3414534.12903371538340691664.robh@kernel.org>
References: <20231027102440.677773-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231027102440.677773-1-herve.codina@bootlin.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Oct 2023 12:24:37 +0200, Herve Codina wrote:
> of_address_to_resource() is not defined if !CONFIG_OF_ADDRESS.
> 
> Return early in of_unittest_check_addr() to avoid the
> of_address_to_resource() usage.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310271513.8MUErCK4-lkp@intel.com/
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> Rob,
> 
> This fixes a patch you already applied from my series
> https://lore.kernel.org/all/20231017110221.189299-1-herve.codina@bootlin.com/
> 
> I don't know if it's too late or not but maybe you can squash this fix patch.
> 
> My apologies for this issue.
> 
> Hervé
> 
>  drivers/of/unittest.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Squashed and applied, thanks!

