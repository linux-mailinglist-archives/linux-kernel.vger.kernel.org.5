Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A957681328E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573393AbjLNOJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573115AbjLNOJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:09:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA17A7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:09:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3E9C433C8;
        Thu, 14 Dec 2023 14:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702562979;
        bh=F3Budhbk+oO4EaTBoG3jnHcriilK7yvDChjm2zriBQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fonDCcbmN11dfo8tFhAC9T0TGc8c1GNGBfvFzoWua/DlBDFRbYa56Lbj8ZKCdvVol
         LlZEPSN6l96Pzz9AsWP6PWvZMRvYLxLDtof/FQS6TKJNWs0o8F/dWYGRi1tCHq6wbK
         n1LWvn+lq9Q+x4suypErvJ5VUTFax2vilb4NQbt53YeO5ePBxQqxEu5zUjYaOlAM4X
         fP2TF/Sjugrm3SelgTZaLM6Pzv8aIw1HMdKr5ktJGSVPq1bca2bZr9rCBf3DueLnOF
         vTTUD8fIx8kyYwhuX06tNHH8ELTaEdwMm/H7p8jYgubuqusFNl0l+q0YtLjLWJQIex
         SeS9Y38XCKRGQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rDmPA-0007zy-14;
        Thu, 14 Dec 2023 15:09:36 +0100
Date:   Thu, 14 Dec 2023 15:09:36 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: pmic_glink: Fix boot when QRTR=m
Message-ID: <ZXsMoFiivUCWA0yr@hovoldconsulting.com>
References: <20231213210644.8702-1-robdclark@gmail.com>
 <ZXqr0RFw9KsP876v@hovoldconsulting.com>
 <CAA8EJpoSvaq9imP-dT4p=4jveZyFmh=OoWOP7jWGo4OYkHQDTA@mail.gmail.com>
 <ZXsKzsij3Xb50Ap9@hovoldconsulting.com>
 <CAA8EJpqBstKyAfUcBPzoF2CitTwWBZ9Xhd28Y+FCo14OoBqkxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqBstKyAfUcBPzoF2CitTwWBZ9Xhd28Y+FCo14OoBqkxw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 04:04:49PM +0200, Dmitry Baryshkov wrote:
> On Thu, 14 Dec 2023 at 16:01, Johan Hovold <johan@kernel.org> wrote:
> > On Thu, Dec 14, 2023 at 01:04:43PM +0200, Dmitry Baryshkov wrote:
> > > On Thu, 14 Dec 2023 at 09:16, Johan Hovold <johan@kernel.org> wrote:
> > > > On Wed, Dec 13, 2023 at 01:06:43PM -0800, Rob Clark wrote:
> > > > > From: Rob Clark <robdclark@chromium.org>
> > > > >
> > > > > We need to bail out before adding/removing devices, if we are going
> > > > > to -EPROBE_DEFER.  Otherwise boot will get stuck forever at
> > > > > deferred_probe_initcall().
> > > >
> > > > Can please you expand on why this is a problem here in the commit
> > > > message?
> > > >
> > > > The aux devices appear to be tore down correctly in the probe error
> > > > paths so how exactly does that lead to deferred_probe_initcall() being
> > > > stuck? This sounds like we may have a problem elsewhere which this patch
> > > > is papering over.
> > >
> > > This is a known problem. Successful probes during the probe deferral
> > > loop causes the whole loop to be reiterated. Creating child devices
> > > usually results in  a successful probe. Aso I thought that just
> > > creating new device also causes a reprobe, but I can not find any
> > > evidence now.
> >
> > This still needs to be described in the commit message.
> >
> > Only a successful probe should trigger a reprobe, and when the child
> > devices are registered the parent is not yet on the deferred probe list.
> > So something is not right or missing here.
> 
> Child devices can be successfully probed, then the parent gets
> -EPROBE_DEFER, removes children and then it goes on and on.

So what? As I described above, the successful probe of the children
should have nothing to do with whether the parent is reprobed.

If that isn't the case, then explain how.

Johan
