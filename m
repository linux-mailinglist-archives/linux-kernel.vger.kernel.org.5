Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2F5759082
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjGSIna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjGSIn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:43:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3643419F;
        Wed, 19 Jul 2023 01:43:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B84316130D;
        Wed, 19 Jul 2023 08:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E45C433C7;
        Wed, 19 Jul 2023 08:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689756203;
        bh=BlGThz6noR1JWehEW08NX7EICRzWrLxkKOFSlD5SvVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H8fDI4LDMObASKfrxz4XlsfXVSKNkMBEGNJ65hizZvbIslddKnOVAo3wbyLAZgXhq
         a7MUOM5Gcy+a+fdkvHG4IshEAk3sHdceXy2D2Po1JzNnjoJ6nxcrkO7QS1oZq/CsRg
         BGcapRq5J6CffnEQFmtCgiAAJ0tsqkUWitES4n5OP5ICMN33mbznaBb4pLhe2OhGKb
         vJLXs8VM+nltisaUxKE0c5+BX6bjOPhKq9CuNNCVM8DlfvYlepesVVjBw5qOkQW/EE
         wq/3d/u0Sh6D62BcNYMWGDzhsy8irpP3O0Q/+O67s1MUMW61CbWj6iA85e06DMUMuh
         fbHy873N0kLwA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qM2mR-0002yG-1A;
        Wed, 19 Jul 2023 10:43:32 +0200
Date:   Wed, 19 Jul 2023 10:43:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 03/15] clk: qcom: gcc-sm6375: Unregister critical clocks
Message-ID: <ZLeiM6l6tu6XDzrr@hovoldconsulting.com>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
 <20230717-topic-branch_aon_cleanup-v1-3-27784d27a4f4@linaro.org>
 <ZLaRtrH85v4kpSvb@hovoldconsulting.com>
 <33a26241-026a-9466-5dd6-e3202b29f57c@linaro.org>
 <ybugl2m7o5cnzj4lv5ksit2rip6yvths5ieo3xlw6cycto2zax@2jimga475z2t>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ybugl2m7o5cnzj4lv5ksit2rip6yvths5ieo3xlw6cycto2zax@2jimga475z2t>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 09:23:52AM -0700, Bjorn Andersson wrote:
> On Tue, Jul 18, 2023 at 03:26:51PM +0200, Konrad Dybcio wrote:
> > On 18.07.2023 15:20, Johan Hovold wrote:
> > > On Mon, Jul 17, 2023 at 05:19:10PM +0200, Konrad Dybcio wrote:
> > >> Some clocks need to be always-on, but we don't really do anything
> > >> with them, other than calling enable() once and telling Linux they're
> > >> enabled.
> > >>
> > >> Unregister them to save a couple of bytes and, perhaps more
> > >> importantly, allow for runtime suspend of the clock controller device,
> > >> as CLK_IS_CRITICAL prevents the latter.
> > > 
> > > But this doesn't sound right. How can you disable a controller which
> > > still has clocks enabled?
> > > 
> > > Shouldn't instead these clocks be modelled properly so that they are
> > > only enabled when actually needed?
> > Hm.. We do have clk_branch2_aon_ops, but something still needs to
> > toggle these clocks.
> > 
> 
> Before we started replacing these clocks with static votes, I handled
> exactly this problem in the turingcc-qcs404 driver by registering the
> ahb clock with a pm_clk_add(). The clock framework will then
> automagically keep the clock enabled around operations, but it will also
> keep the runtime state active as long as the clock is prepared.
> 
> As mentioned in an earlier reply today, there's no similarity to this in
> the reset or gdsc code, so we'd need to add that in order to rely on
> such mechanism.

This reminds me of:

	4cc47e8add63 ("clk: qcom: gdsc: Remove direct runtime PM calls")

which recently removed a broken attempt to implement this for gdscs.

Just stumbled over GENPD_FLAG_PM_CLK which may provide a way forward at
least for genpd (but see below).

> > I *think* we could leave a permanent vote in probe() without breaking
> > runtime pm! I'll give it a spin bit later..
> > 
> 
> Modelling the AHB clock in DT and putting a devm_clk_get_enabled() would
> properly connect the two, and thereby handle probe order between the two
> clock controllers.

Yeah, this dependency really should be described eventually.

> But it would prevent the power-domain of the parent provider to ever
> suspending. Using pm_clk_add() this would at least depend on client
> votes.

IIUC using pm_clk_add() would also prevent the parent from suspending
due to that resume call in clk_prepare().

And this mechanism is also used for GENPD_FLAG_PM_CLK...

Johan
