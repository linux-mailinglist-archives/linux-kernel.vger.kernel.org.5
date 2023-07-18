Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9627581F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjGRQUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGRQUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:20:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB73E0;
        Tue, 18 Jul 2023 09:20:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CAFB615E4;
        Tue, 18 Jul 2023 16:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43C6C433C8;
        Tue, 18 Jul 2023 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689697228;
        bh=c2kq9yglTyBKkN+7oETy1EDzjSuSLPZJWdny+o8VQ/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XOPUAa+eM/tTEsH8tdvIg98C482Th52LWsYb76BnmMIgZuSXapxbuprHsiEa/rryS
         AhwTyreo6R6Xk556bDH47DjRdm8aj1UQ0D+hbnC+klT5lbWSIbXnUADzWuFKpf57LE
         xvd1P1URcwAHdRt6A58V4LgmREB0wM98hjoGwpayBqihkWyjMtxjEPW70DypGJ1tmZ
         qAGDkbOl1kbTx5hqWp0y1a26P09uBi5b4o8VdqYb5jb8JTz0tjeXrXbFsC7lyzYRQC
         7C9LubKovEEw5jM96iJrP9Jg+IW0su5Uoj4vhppFVhdYJyoBe2mTEwOTYCAj5NB6am
         0Z+rN207FLhvQ==
Date:   Tue, 18 Jul 2023 09:23:52 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 03/15] clk: qcom: gcc-sm6375: Unregister critical clocks
Message-ID: <ybugl2m7o5cnzj4lv5ksit2rip6yvths5ieo3xlw6cycto2zax@2jimga475z2t>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
 <20230717-topic-branch_aon_cleanup-v1-3-27784d27a4f4@linaro.org>
 <ZLaRtrH85v4kpSvb@hovoldconsulting.com>
 <33a26241-026a-9466-5dd6-e3202b29f57c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33a26241-026a-9466-5dd6-e3202b29f57c@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 03:26:51PM +0200, Konrad Dybcio wrote:
> On 18.07.2023 15:20, Johan Hovold wrote:
> > On Mon, Jul 17, 2023 at 05:19:10PM +0200, Konrad Dybcio wrote:
> >> Some clocks need to be always-on, but we don't really do anything
> >> with them, other than calling enable() once and telling Linux they're
> >> enabled.
> >>
> >> Unregister them to save a couple of bytes and, perhaps more
> >> importantly, allow for runtime suspend of the clock controller device,
> >> as CLK_IS_CRITICAL prevents the latter.
> > 
> > But this doesn't sound right. How can you disable a controller which
> > still has clocks enabled?
> > 
> > Shouldn't instead these clocks be modelled properly so that they are
> > only enabled when actually needed?
> Hm.. We do have clk_branch2_aon_ops, but something still needs to
> toggle these clocks.
> 

Before we started replacing these clocks with static votes, I handled
exactly this problem in the turingcc-qcs404 driver by registering the
ahb clock with a pm_clk_add(). The clock framework will then
automagically keep the clock enabled around operations, but it will also
keep the runtime state active as long as the clock is prepared.

As mentioned in an earlier reply today, there's no similarity to this in
the reset or gdsc code, so we'd need to add that in order to rely on
such mechanism.

> I *think* we could leave a permanent vote in probe() without breaking
> runtime pm! I'll give it a spin bit later..
> 

Modelling the AHB clock in DT and putting a devm_clk_get_enabled() would
properly connect the two, and thereby handle probe order between the two
clock controllers.

But it would prevent the power-domain of the parent provider to ever
suspending. Using pm_clk_add() this would at least depend on client
votes.

Regards,
Bjorn
