Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618C4758125
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjGRPjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjGRPjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:39:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE20E52;
        Tue, 18 Jul 2023 08:39:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72DDE6164D;
        Tue, 18 Jul 2023 15:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D56C433C8;
        Tue, 18 Jul 2023 15:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689694785;
        bh=niFUIW8RgEpvAiA6LUCdCCanWa0dt1Z+kgLKjKniI74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F8nqHHPzXSuaiu4yqCxVn6565ivWW36QEwkPKlE4Yfn7Y2zDQ08Tlk+6MG1k25YCY
         jLImfir4nCohVHrD01iUvnCVkW6XrTh7ApdvGcmOZzH1/a6N9TU6KW4VO31yHNNgAx
         Nc+TfTJgONI8Wz6uq4mJhfIDRv0VFizJRGOIkIfr2d41zu7uR3l1gwowN6C+EDZnPw
         YaUYTMALn2uo46LI0tUUaKDB7oehgXlsLawg6to9S1yQNiDnO+LBdxcioakgMUYd0l
         yWYJAvJinQjqIwDxupQRzyocLyfylbXKpCaPxQ+ZcaxQ6zyUSlhdlGvhWoaE/EgVvA
         QL3pz4SaW4esg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qLmnr-0006Bq-1J;
        Tue, 18 Jul 2023 17:39:55 +0200
Date:   Tue, 18 Jul 2023 17:39:55 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>
Subject: Re: [PATCH 5/8] clk: qcom: lpasscc-sc7280: fix missing resume during
 probe
Message-ID: <ZLaySwCQsgQCSRIW@hovoldconsulting.com>
References: <20230718132902.21430-1-johan+linaro@kernel.org>
 <20230718132902.21430-6-johan+linaro@kernel.org>
 <xbek6yuldy7ck3zlux76hosn4iqt52ocydovuol7geiwapslrd@j7uyxhrkiyaw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xbek6yuldy7ck3zlux76hosn4iqt52ocydovuol7geiwapslrd@j7uyxhrkiyaw>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 07:58:41AM -0700, Bjorn Andersson wrote:
> On Tue, Jul 18, 2023 at 03:28:59PM +0200, Johan Hovold wrote:
> > Drivers that enable runtime PM must make sure that the controller is
> > runtime resumed before accessing its registers to prevent the power
> > domain from being disabled.
> > 
> 
> NB: the clock framework will runtime resume the controller surrounding
> operations, even so during probe. But this is not done for resets and
> gdscs - and in some clock drivers we poke registers directly from
> probe...
> 
> The one time this really matters is where we associate the ahb clock
> with the runtime state, e.g. in qcs404 turingcc. On most other platforms
> we just mark these clocks always-on in gcc...

Right, I started looking at this with respect to the PM domain, but
my initial commit message only mentioned the need to make sure the
controller is resumed, which would have covered such interface clocks as
well. 

And while ending up with a concurrent request to disable the PM domain
is not that likely, there is currently nothing preventing it so it still
needs to be fixed.

Johan
