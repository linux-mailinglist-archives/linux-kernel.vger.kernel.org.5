Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D088E7D2ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjJWHFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWHFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:05:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7D0D67;
        Mon, 23 Oct 2023 00:05:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C967C433C7;
        Mon, 23 Oct 2023 07:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698044730;
        bh=aGK3CokEYchS1e6n3w7Slxf6W1MaIaw+DtNEY1I6FKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W8gocUY8gnrutgUJFQRN6fkDKjYdnaIT50d1D6ny1Due5P9yB58dV9r6evwr2TTeT
         3l8KWAowpe6PBBNg3IHxiRTJ5uGfqmOdn1N6/UKKRm/WuqeQ5U5AJCfeffHe7XBQQM
         c6tnhPGLFM5dUsn93vn2ZwBo2Ylxx5R1/x0tVqDauXWhrphku92gmyZBW1RL3boYQN
         m2heP33nPuHU6nSdL7o0FbGNBrZ3/C//HA2R8+/EzgIF33MOKvLCu2aeT7+UbG+avz
         axPMe5wOFXqIem3LajR5rqOWd+IAlUv+pUMlAZHKLmizyRkXQZrJVqlSJwey9XTCIu
         vKwgWASFj//Jw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qup0S-0000Td-19;
        Mon, 23 Oct 2023 09:05:44 +0200
Date:   Mon, 23 Oct 2023 09:05:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>
Subject: Need SPMI ack (was: Re: (subset) [PATCH 0/5] mfd: qcom-spmi-pmic:
 fix revid implementation)
Message-ID: <ZTYbSAYDi4KUEFZa@hovoldconsulting.com>
References: <20231003152927.15000-1-johan+linaro@kernel.org>
 <169710605745.1174112.5043840678154728515.b4-ty@kernel.org>
 <ZSkUDl6bIQkArUO0@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSkUDl6bIQkArUO0@hovoldconsulting.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, Oct 13, 2023 at 11:55:27AM +0200, Johan Hovold wrote:
> On Thu, Oct 12, 2023 at 11:20:57AM +0100, Lee Jones wrote:
> > On Tue, 03 Oct 2023 17:29:22 +0200, Johan Hovold wrote:
> > > The Qualcomm SPMI PMIC revid implementation is broken in multiple ways
> > > that can lead to resource leaks and crashes. This series reworks the
> > > implementation so that can be used safely.
> > > 
> > > Included is also a rename of the SPMI device lookup helper which can
> > > hopefully help prevent similar leaks from being reintroduced.
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/5] mfd: qcom-spmi-pmic: fix reference leaks in revid helper
> >       commit: 365cf70ff33fe20e749227346d7245f7f0dccb58
> > [2/5] mfd: qcom-spmi-pmic: fix revid implementation
> >       commit: 7370f9de463b1d21dcdf9480a0a15babecd14ac7
> > [3/5] mfd: qcom-spmi-pmic: switch to EXPORT_SYMBOL_GPL()
> >       commit: b5cd5e72a71e9d368e20271d3a772dd045ae220e
> 
> Thanks for picking these up, Lee. You don't seem to have pushed these
> out yet so I'm not sure if you intend to send them on for 6.6-rc or
> 6.7-rc1 yet.
> 
> Either way, would it be possible to include also the related and
> dependant spmi cleanups?
> 
> Stephen, could you ack those changes so Lee can take them as well?

Could you please consider acking the two SPMI patches so that they can
go in through Lee's tree along with the rest of the series for 6.7-rc1
(e.g. to avoid dealing with inter-tree dependencies)?

Johan
