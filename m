Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067BC7F7100
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345491AbjKXKNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345440AbjKXKNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:13:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71E710EC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:13:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8937FC433C9;
        Fri, 24 Nov 2023 10:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700820790;
        bh=vis1BiFk98hLVEdtkKkxZn3B9EHbkZYHyPAFzLruJzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xxy8hdsKFHpAb3C7+nUdIRN1CSeITx7p8FXrwpjmfHLA2Xxuv7ll2CtfAoDDVYMZN
         EaW8go6udVVXR8WUxoJk9UKnIAIDFG9HxP3HrhNppbJ9q1TAJSuA0Iai1mdi2eaGiT
         wy2xz0EShjp1X1sgJUKs7Nc7DAfzYOEG5IDj1wRvADerDyOw33ffstnUPc/E4j9xSO
         klc94r10pKhuO3xu4byM/jxzT/XtYqE9eS2ZJuTY0ILn7OnCRTlRc6bkH14FmmW0uV
         BXvipyW2oMgagR1DmbFg2ISTL5/0gypEqTMjzYU981sKT83tJrTRHat1TJwlaZdtlS
         Un3XQmryJsiyw==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r6TBh-0007C1-22;
        Fri, 24 Nov 2023 11:13:30 +0100
Date:   Fri, 24 Nov 2023 11:13:29 +0100
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
Message-ID: <ZWB3SWJWXwj0atdH@hovoldconsulting.com>
References: <ZTZ-EvvbuA6HpycT@hovoldconsulting.com>
 <fb5e5e1d-520c-4cbc-adde-f30e853421a1@quicinc.com>
 <ZTdqnSHq_Jo8AuPW@hovoldconsulting.com>
 <04615205-e380-4719-aff1-f32c26004b14@quicinc.com>
 <ZUz4RD3MjnLlPn6V@hovoldconsulting.com>
 <6d4d959c-b155-471b-b13d-f6fda557cfe0@quicinc.com>
 <ZVYTFi3Jnnljl48L@hovoldconsulting.com>
 <e0789695-43ee-4285-95e9-4cdee24d6ffe@quicinc.com>
 <ZV9XTU-q038BaWn3@hovoldconsulting.com>
 <4fc27dbb-b0aa-437a-a48c-9deea236282d@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fc27dbb-b0aa-437a-a48c-9deea236282d@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 02:30:56PM +0530, Krishna Kurapati PSSNV wrote:
> > 
> >> I didn't add missing interrupts on sc8280xp because I see that current
> >> interrupts present are working fine (I see ADB working and wakeup
> >> working as well), but the interrupt vector numbers are off by "1"
> >> between hs specifics and DT (both upstream and downstream). Will sort it
> >> out and clean that target up later.
> > 
> > Which interrupt numbers are off by one here?

> Sorry for mentioning that it is wrong. The DT entries are right and it 
> is working on upstream.

Thanks for clarifying.

> >> [1]: https://patchwork.kernel.org/project/linux-arm-msm/list/?series=803412
> > 
> > I took a quick look at the series, and it looks like this will
> > eventually clean things up a lot. We should probably define a generic
> > order for the interrupts with the sometimes optional SS interrupts last.
> > 
> > Side note: It looks like the threading in that series is broken.
> > Consider using git-send-email for sending series as it takes care of
> > things like that.
> 
> Usually I do git send-email for the whole out folder where the patches 
> are present, but linux-usb list is common to all the patches in that 
> case, even the DT ones. So to avoid that and to send patches to only 
> relavant mailing lists, I did git send email individually on each patch 
> which might have caused this issue.

I'd suggest that you just send two separate series, one with binding and
driver updates, which will eventually be merged by Greg, and one with
the devicetree changes, which goes through Bjorn's tree.

It's good if you could add a link to the binding series in the cover
letter of the devicetree changes as they are of course going to be quite
closely related and need to be reviewed in parallel.

Johan
