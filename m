Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068767D4BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjJXJSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjJXJSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:18:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3979F12E;
        Tue, 24 Oct 2023 02:18:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4215C433C7;
        Tue, 24 Oct 2023 09:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698139090;
        bh=KFYMxmIIBaDVhoLukW+W9QqiiwgOD6QveGj2pTgxMm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UwsrXBvTb+myp+lSUKeeEIyvcBo0gH0yZyOw4MrlubWYxXeRMQPrNEJhLUqdHKNuX
         bxH6dh/QiqUDKieRdChjc2ckF0vnBikpBmr/29c7+Zi/wAyNvsyzc/Yht+X+zV35dS
         GiL+3o35jPE15xuFBZgDdTGdeSoYlHkq6sqSkr1Hye7u/p8vPJ2W1a0v61XglKf9y5
         wzjCiQcttbywYYisxbWZsZaPPT4EIKLPg6rkCj7qc1cbfC06z2YFhTPgqmGvb4NYYR
         hwiGeGBrPzU7L69iVybnZMRAav8XdulU5SOvZAosURbS4N8J7JBUPd8YQXfGbwe2Ut
         YHB2r3Twb/6Iw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qvDYQ-000421-2k;
        Tue, 24 Oct 2023 11:18:27 +0200
Date:   Tue, 24 Oct 2023 11:18:26 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
Subject: Re: [PATCH v13 05/10] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
Message-ID: <ZTeL4nSw6dMGKODm@hovoldconsulting.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-6-quic_kriskura@quicinc.com>
 <ZTJ_T1UL8-s2cgNz@hovoldconsulting.com>
 <14fc724c-bc99-4b5d-9893-3e5eff8895f7@quicinc.com>
 <ZTY7Lwjd3_8NlfEi@hovoldconsulting.com>
 <cabf24d0-8eea-4eb5-8205-bf7fe6017ec2@quicinc.com>
 <ZTZ-EvvbuA6HpycT@hovoldconsulting.com>
 <fb5e5e1d-520c-4cbc-adde-f30e853421a1@quicinc.com>
 <ZTdqnSHq_Jo8AuPW@hovoldconsulting.com>
 <196601cc-f8c6-4266-bfff-3fd69f0ab31c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <196601cc-f8c6-4266-bfff-3fd69f0ab31c@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 02:23:57PM +0530, Krishna Kurapati PSSNV wrote:
> On 10/24/2023 12:26 PM, Johan Hovold wrote:

> > No, you clearly did not understand [1] at all. And stop trying to game
> > the upstreaming process. Bindings and driver patches go together. The
> > devicetree changes can be sent separately in case of USB but only
> > *after* the first set has been merged.
> > 
> > If the code had been in good shape from the start it would have been
> > merged by now. Just learn from your mistakes and next time things will
> > be smoother.
> 
> I agree that bindings should go first. My point is core bindings are 
> already approved and merged and just wanted to check if core driver 
> changes can be merged without glue blocking them. Core driver changes 
> have nothing to do with interrupt handling in glue. If we get the core 
> changes merged separately after fixing the nits mentioned, we can take 
> up this interrupt handling in glue in parallel. I am just trying to see 
> if we can start merging independent portions of code. I agree that my 
> glue driver changes are still not upto mark. But that has nothing to do 
> with core driver changes.

Again, no. The dwc3 glue and core bits are not independent, and ideally
the bindings should not have been merged either before having the
implementation in a decent shape either (e.g. as the messy
implementation suggested that the bindings were incomplete).

You're again trying to sneak in an incomplete implementation. Qualcomm
has a terrible track record of doing just that and leaving others with
the task to clean up their mess.

This should go in as one series, when it's ready, and not before.

And we may even consider reverting the updated bindings as it appears
they are still not correct.

Johan
