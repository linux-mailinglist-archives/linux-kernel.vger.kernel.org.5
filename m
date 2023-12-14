Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84392813263
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573337AbjLNOBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjLNOBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:01:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824EA9C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:01:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4F2C433C7;
        Thu, 14 Dec 2023 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702562513;
        bh=3r3g7bIo3sjseeWV5/DRYEPcjrp1JoaPlGCxb6Ob5QQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I+q8Nh8NF2rssDlqnmFsZSPw6QZe8EqIwWcQg+8/ULrRxAalHiLwIx4r87jyOnCJM
         RpqYsrX8VhC7vMHd9FVvktT5sEPUoZmVPHCDwzuSXzyf4EXmghHHtgR6tyLgEgVoRQ
         AoXsQWJ28PV/zlP0d0Ua279YSDakUseNe/XaBmassFpcg33+VCF/X+rFH6jS0wvHvX
         gXRCfN3Lk2falUHK8z1u7Pbk+ECO8Zveb0WwYxbablilyHrqRIdim3DEg6iQUywE1c
         8aVqkjLZBr26uvJfeH8b+yZj+NWXhsVfJQnhTMQmdin91K1jdtdwn2t/vnJpQiZ9QL
         jUB3Qdbn1qf2w==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rDmHe-0007sY-0C;
        Thu, 14 Dec 2023 15:01:50 +0100
Date:   Thu, 14 Dec 2023 15:01:50 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: pmic_glink: Fix boot when QRTR=m
Message-ID: <ZXsKzsij3Xb50Ap9@hovoldconsulting.com>
References: <20231213210644.8702-1-robdclark@gmail.com>
 <ZXqr0RFw9KsP876v@hovoldconsulting.com>
 <CAA8EJpoSvaq9imP-dT4p=4jveZyFmh=OoWOP7jWGo4OYkHQDTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpoSvaq9imP-dT4p=4jveZyFmh=OoWOP7jWGo4OYkHQDTA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 01:04:43PM +0200, Dmitry Baryshkov wrote:
> On Thu, 14 Dec 2023 at 09:16, Johan Hovold <johan@kernel.org> wrote:
> >
> > On Wed, Dec 13, 2023 at 01:06:43PM -0800, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > We need to bail out before adding/removing devices, if we are going
> > > to -EPROBE_DEFER.  Otherwise boot will get stuck forever at
> > > deferred_probe_initcall().
> >
> > Can please you expand on why this is a problem here in the commit
> > message?
> >
> > The aux devices appear to be tore down correctly in the probe error
> > paths so how exactly does that lead to deferred_probe_initcall() being
> > stuck? This sounds like we may have a problem elsewhere which this patch
> > is papering over.
> 
> This is a known problem. Successful probes during the probe deferral
> loop causes the whole loop to be reiterated. Creating child devices
> usually results in  a successful probe. Aso I thought that just
> creating new device also causes a reprobe, but I can not find any
> evidence now.

This still needs to be described in the commit message.

Only a successful probe should trigger a reprobe, and when the child
devices are registered the parent is not yet on the deferred probe list.
So something is not right or missing here.

Johan
