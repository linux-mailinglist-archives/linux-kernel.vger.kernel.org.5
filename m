Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042CB7EED61
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjKQINZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjKQINX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:13:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76203A8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:13:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B6AC433C7;
        Fri, 17 Nov 2023 08:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700208800;
        bh=RPcbB+jdW8SosobxciCWR/egl8ZrKh5jeQWqAfD2+vU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hKR2r491krdpa74I19bkbkY1tFTT5yyVBwSe81sMme0lcZKOwrlp9p5wQsHPX6JCs
         OfCvtlHvt91nBQHPPsu16TdT4me5IELzYagjdEhjyirOohQnO18EMcmwakimhiyyB/
         zQEcXEUE39SIfrEuALskJDZp+8Rqn7D1+r6Sw94vMSlkky/qX5UiZm6XOSqQMfXVN9
         gppN60qQqdoDO3g31P7UAhYZjf27W1auinHQvnTXGp6azipSTK2DQt1rBhNhRtKxEu
         qVeNd6EJ9n5RtP5wiDmF7j+23q861zIS2K47YgfUX2O9qBIDmwIFsC0HfOviCaavR5
         luomQ9p5tHNiA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r3tyb-000629-16;
        Fri, 17 Nov 2023 09:13:22 +0100
Date:   Fri, 17 Nov 2023 09:13:21 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        conor+dt@kernel.org, quic_tdas@quicinc.com,
        quic_rjendra@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        abel.vesa@linaro.org, quic_tsoni@quicinc.com
Subject: Re: [PATCH 2/4] clk: qcom: Add Global Clock controller (GCC) driver
 for SC8380XP
Message-ID: <ZVcgoX56q0lYWKyw@hovoldconsulting.com>
References: <20231025133320.4720-1-quic_sibis@quicinc.com>
 <20231025133320.4720-3-quic_sibis@quicinc.com>
 <483c4de3-951c-4ba4-89fb-36fcd44fa99f@linaro.org>
 <e857c853-51ef-8314-2a21-fa6fd25162ca@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e857c853-51ef-8314-2a21-fa6fd25162ca@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 09:26:18AM +0530, Sibi Sankar wrote:
> On 10/25/23 22:10, Bryan O'Donoghue wrote:
> > On 25/10/2023 14:33, Sibi Sankar wrote:

> >> +static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
> >> +    .cmd_rcgr = 0x14018,
> >> +    .mnd_width = 8,
> >> +    .hid_width = 5,
> >> +    .parent_map = gcc_parent_map_9,
> >> +    .freq_tbl = ftbl_gcc_sdcc2_apps_clk_src,
> >> +    .clkr.hw.init = &(const struct clk_init_data) {
> >> +        .name = "gcc_sdcc2_apps_clk_src",
> >> +        .parent_data = gcc_parent_data_9,
> >> +        .num_parents = ARRAY_SIZE(gcc_parent_data_9),
> >> +        .flags = CLK_SET_RATE_PARENT,
> >> +        .ops = &clk_rcg2_floor_ops,
> > 
> > diff sc8280xp..sc8380xp
> > 
> > Here you've used floor instead of shared ops, why is that ?
> 
> We seem to use floor ops for sdcc clks on all other QC SoCs and
> sc8280xp seems to be the exception here. So I'll continue to use floor
> ops for sdcc.

> >> +static struct clk_rcg2 gcc_usb30_mp_mock_utmi_clk_src = {
> >> +    .cmd_rcgr = 0x17158,
> >> +    .mnd_width = 0,
> >> +    .hid_width = 5,
> >> +    .parent_map = gcc_parent_map_0,
> >> +    .freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
> >> +    .clkr.hw.init = &(const struct clk_init_data) {
> >> +        .name = "gcc_usb30_mp_mock_utmi_clk_src",
> >> +        .parent_data = gcc_parent_data_0,
> >> +        .num_parents = ARRAY_SIZE(gcc_parent_data_0),
> >> +        .flags = CLK_SET_RATE_PARENT,
> >> +        .ops = &clk_rcg2_ops,
> > 
> > This is another discontinuinty with sc8280xp.
> > 
> > Could you have a look through the sc8280xp gcc and do an aduit for 
> > clk_rcg2_shared_ops as against sc8380xp ?
> 
> ack, will do a quick audit before the re-spin.

Please trim unnecessary context from your replies. You quoted some 1400
lines of irrelevant clock structs when all you needed was something like
the above.

Not trimming replies makes it a pain to read your mails and to revisit
threads like this one, for example, in the lore web archives.

Johan
