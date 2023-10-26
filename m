Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B95B7D7AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjJZCLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZCLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:11:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DD5132;
        Wed, 25 Oct 2023 19:11:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2941BC433C7;
        Thu, 26 Oct 2023 02:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698286264;
        bh=R2ZbMNpdOpfJaB62Jul1L9JZ9xwhe/4teAKNNVrfx28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OyAHD95fdOd+HAODdk/x8mwrujgZx5m6WQ0k89PXxYbVg26EbQKU22QMamEBa+EES
         EBYIVRCNxyEPKUGhy7VIB8VEvQ89wGVylsl4exapIO2q+2zmDfDFrEAVnV79jpmZ2a
         zT3OxtWlNZ05dvR6MmyVfwfkNlwdPpnQVnE4s16bMo39M1/ulQSXjNnJBffcWDX5iV
         V1lwX0dU26CjhMSDm4jdlqyEIyHCpsXW+CphcaTEPnB0ElzkZykAD6WCwA/eUUADRT
         5uSddfKca0f1NMh6OOJZYBiwl/T/1wClk1pkTFJqZr9AWiTRbDDZF8vrNsWLTd+Mw0
         wgNdX1Pk0FkWA==
Date:   Wed, 25 Oct 2023 19:15:21 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, agross@kernel.org,
        conor+dt@kernel.org, dmitry.baryshkov@linaro.org,
        jonathan@marek.ca, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        quic_tdas@quicinc.com, robh+dt@kernel.org,
        vladimir.zapolskiy@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3.1 3/4] clk: qcom: camcc-sc8280xp: Add sc8280xp CAMCC
Message-ID: <htdwp25oqvy6vmp6ff2z7ycmckvem2ejhitqonjgfzinqv5nds@rlfuary2ouc3>
References: <20231023153821.189331-1-bryan.odonoghue@linaro.org>
 <20231023153821.189331-4-bryan.odonoghue@linaro.org>
 <aef93a48cf270d5078ccdc39d95113a4.sboyd@kernel.org>
 <866d5582-a4e2-4b98-a291-6e41939bd9f3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <866d5582-a4e2-4b98-a291-6e41939bd9f3@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 10:40:04AM +0100, Bryan O'Donoghue wrote:
> On 24/10/2023 01:34, Stephen Boyd wrote:
> > Quoting Bryan O'Donoghue (2023-10-23 08:38:20)
> > > diff --git a/drivers/clk/qcom/camcc-sc8280xp.c b/drivers/clk/qcom/camcc-sc8280xp.c
> > > new file mode 100644
> > > index 000000000000..0631bd5fad57
> > > --- /dev/null
> > > +++ b/drivers/clk/qcom/camcc-sc8280xp.c
> > > @@ -0,0 +1,3048 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> > > + * Copyright (c) 2023, Linaro Ltd.
> > > + */
> > > +
> > > +#include <linux/clk-provider.h>
> > > +#include <linux/err.h>
> > 
> > Is this include used?
> > 
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_device.h>
> > 
> > Should be mod_devicetable.h instead?
> > 
> > > +#include <linux/of.h>
> > 
> > Is this include used?
> > 
> > > +#include <linux/pm_clock.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/pm_runtime.h>
> > 
> > This got included twice.
> > 
> > > +
> > > +#include <dt-bindings/clock/qcom,sc8280xp-camcc.h>
> > > +
> > > +#include "clk-alpha-pll.h"
> 
> You're right, I didn't scrub the autogen headers.
> 
> Update sent as v3.2.
> 

Resubmitting one of the four patches as 3.2 confuses both me and the
tools. Please send a v4 of all 4 patches instead.

Regards,
Bjorn
