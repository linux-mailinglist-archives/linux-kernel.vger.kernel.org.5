Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287EA75729D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjGRD7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGRD7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:59:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8D118C;
        Mon, 17 Jul 2023 20:59:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 632536141D;
        Tue, 18 Jul 2023 03:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4CFC433C8;
        Tue, 18 Jul 2023 03:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689652745;
        bh=/z0ph85m/oZuXsYkIBjHBds8eCFZfTduyMmR4MczRfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s8JQTqzlwdNNKvYU+6XP9NuVuvJDH/gvIEviT79fh67Qovg7Z9Z/W/uPyU2shxH+3
         EJ6X+nm3vAzQgQqCs1e3P376daslUYFPMh6fcLNMWTrZZreNdT46/PDZzu28NOZOyo
         VlRfPXQzL3CfKboeyeWWASWDGrcWEecFVPWwVgm9EdwTRjTHQgBte8NT81F0rXwqSf
         mCDgp823KtPxf/4TBFOrBynlNMAgY6tWcmpAPXxntdb7YVGNa6MFtxnCIo+doSNyX2
         iL6oVQajk4/MCpPtT3hA9bv60uUBp9jiSj0YACXpm47mdsdgrthZ5ypnGlTTRqnM2g
         ABNZ1PYzCNM6g==
Date:   Mon, 17 Jul 2023 21:02:29 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
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
Subject: Re: [PATCH 04/15] clk: qcom: gcc-sm6375: Add runtime PM
Message-ID: <pv7pcn5xc7xdjigefrwzvbjvp5lmgfziywfpvxn2nl7hjnvyre@kukniawnm5rm>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
 <20230717-topic-branch_aon_cleanup-v1-4-27784d27a4f4@linaro.org>
 <ZLVru50N2ukdXnsW@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLVru50N2ukdXnsW@gerhold.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 06:26:35PM +0200, Stephan Gerhold wrote:
> On Mon, Jul 17, 2023 at 05:19:11PM +0200, Konrad Dybcio wrote:
> > The GCC block on SM6375 is powered by the VDD_CX rail. We need to ensure
> > that it's enabled to prevent unwanted power collapse.
> > 
> > Enable runtime PM to keep the power flowing only when necessary.
> > 
> 
> Are you sure this is necessary? If VDD_CX was really possible to fully
> "power collapse" then I would expect that you lose all register
> settings. This is not something we want or can even handle for GCC.
> You would need to restore all frequency settings, branch bits etc etc.
> 

This differ between platforms, some allow us to completely power down CX
while keeping registers state using MX, others require that CX stays in
retention at least.

So, CX isn't the only rail powering GCC. For the most part though, we
have a relationship between frequencies votes for by clients and the
corner of CX, and hence I think the current description is ok...

> Otherwise it's a retention state, but these are covered by the
> corners/levels, not the enable/disable state.
> 

I _think_ we still want to suspend each individual device (and the vote
from Linux), and let the system keep us at retention, instead of off...

> I think most of these power domains are effectively always-on. The
> important part is voting for minimal corners/levels so they can go to
> minimal retention state with vlow/vmin.
> 

When you hit s2idle, you should expect to have the majority of the
rpm(h) PDs be voted off.

Regards,
Bjorn

> Thanks,
> Stephan
