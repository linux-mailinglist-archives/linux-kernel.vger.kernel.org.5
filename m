Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5416C80D086
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344022AbjLKQGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344744AbjLKQGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:06:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2D6198A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:04:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED72C433C7;
        Mon, 11 Dec 2023 16:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702310697;
        bh=9rFmEbQU4MZkS3VQLzOd79r5Gp+jBwJMXH7fo8EetM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7+02ZjY/7X8I/+BgJsrca+AzH+JW3BiOsETthZ0M9Vy7eaTItqHsJcrgWBRn8soO
         rVp5qql1We0uh/D8VVWFFRS1A6b6PaPBi15MPddWQ1fWyDverZdOnqYGkHxPleO/ux
         qAN0BJpImE2sI5oftTYXEA69rUYE42RHMP4+UZZQgaXU3gEpsHBZJn4MShy7kKtW2o
         N5f3ND/61rdANPxq3eJ+LIot31/hF39tWN3mq0G8LJ5xyxIi2Sy+U4uJnQnjv6DJwG
         ByvveGsUNa8IwOtSpv5VaQZrBiFY2KTpj46N/GEiaTxwvKze2Ir+yNqgLtdyhy57Yf
         EaAEbRKPq53fA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rCimu-0005sB-2h;
        Mon, 11 Dec 2023 17:05:44 +0100
Date:   Mon, 11 Dec 2023 17:05:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: pmic_glink: disable UCSI on sc8280xp
Message-ID: <ZXczWLyZHhxnraZh@hovoldconsulting.com>
References: <20231208125730.10323-1-johan+linaro@kernel.org>
 <CAA8EJpp+wZbHwetDD5pDAXJJLVO+URoZJuW8OQavf5rSTPNWzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpp+wZbHwetDD5pDAXJJLVO+URoZJuW8OQavf5rSTPNWzg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 06:34:00PM +0200, Dmitry Baryshkov wrote:
> On Fri, 8 Dec 2023 at 14:56, Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > Enabling UCSI on sc8280xp and the Lenovo ThinkPad X13s in particular
> > results in a number of errors and timeouts during boot:
> >
> > [    9.012421] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: GET_CONNECTOR_STATUS failed (-95)
> > [   14.047379] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: timeout waiting for UCSI sync write response
> > [   14.050708] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: GET_CONNECTOR_STATUS failed (-110)
> > [   20.192382] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: timeout waiting for UCSI sync write response
> > [   20.192542] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: GET_CONNECTOR_STATUS failed (-110)
> >
> > Disable UCSI on sc8280xp until this has been resolved.

> Johan, if you can capture message traces in
> pmic_glink_ucsi_locked_write() / pmic_glink_ucsi_read() /
> pmic_glink_ucsi_callback(), this would help me understand what is
> causing the issue.

I don't have time to dig into this at the moment, and its probably
easiest for everyone if you just try this on your own X13s.

Johan
