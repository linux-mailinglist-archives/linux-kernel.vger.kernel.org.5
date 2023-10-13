Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C227C82E2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjJMKRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjJMKRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:17:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23EBB7;
        Fri, 13 Oct 2023 03:17:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6D5C433C8;
        Fri, 13 Oct 2023 10:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697192260;
        bh=PduGR+0ma56Dbfse5BIk5TN6YS6QXizfqz1tDhApY7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bkg3xrihknM18esv2S5ictlU/E6O8sPBZkndKX1ui9Rle2CkAXmzAny1XTM1yU//L
         pqJ9Ic1RrhpUsjiQG58pYWejXDqCswK5hCUVtxv1jx5c+JKIMgR3hCPXIEyMTxR46A
         iIhamaJQyvtcWKHaJ4RjXJtFFGJoeDOFDDmu/23UGcAPtWOdZQa4XV/4HGp/0XsrhG
         0Eo8eqCfM6jObqs7s+1+LuVf0h5og7oUYNnOmN+vBoNZtZD0AdMPFFnrZLG48Gc7qC
         qI58C/oHrOJQHK0qugR5YPr0HyPSytgwoNpjriIDkSAUmOkhnX2jFUf6JLYxNaHItp
         3iZbS/e317RMg==
Date:   Fri, 13 Oct 2023 11:17:34 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] mfd: Use device_get_match_data()
Message-ID: <20231013101734.GJ8314@google.com>
References: <20231009211356.3242037-3-robh@kernel.org>
 <CAGb2v66ZHD8mMMNVwp+sTYT6DAFDUrP8ydeTo7KW+uUtBRM3bQ@mail.gmail.com>
 <20231012092618.GF8314@google.com>
 <CAL_JsqK22vWx1VPnrwEh+N-6vy5a7npFSW-=gp1uabTPSG2PpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqK22vWx1VPnrwEh+N-6vy5a7npFSW-=gp1uabTPSG2PpA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023, Rob Herring wrote:

> On Thu, Oct 12, 2023 at 4:26 AM Lee Jones <lee@kernel.org> wrote:
> >
> > On Tue, 10 Oct 2023, Chen-Yu Tsai wrote:
> >
> > > On Tue, Oct 10, 2023 at 5:14 AM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > Use preferred device_get_match_data() instead of of_match_device() to
> > > > get the driver match data. With this, adjust the includes to explicitly
> > > > include the correct headers.
> > > >
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  drivers/mfd/axp20x.c           | 22 +++-------------------
> > >
> > > I'd keep the error message, but otherwise for axp20x,
> > >
> > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > >
> > > >  drivers/mfd/hi6421-pmic-core.c |  9 +++------
> > > >  drivers/mfd/mxs-lradc.c        |  9 ++-------
> > > >  drivers/mfd/qcom-spmi-pmic.c   |  6 ++++--
> > > >  drivers/mfd/qcom_rpm.c         |  8 ++++----
> > > >  drivers/mfd/tps65910.c         | 11 ++---------
> > > >  drivers/mfd/twl4030-power.c    |  9 +++------
> > > >  drivers/mfd/twl6030-irq.c      | 10 +++++-----
> > > >  8 files changed, 26 insertions(+), 58 deletions(-)
> >
> > FYI, this patch is not in my inbox.
> 
> There seems to be some issue with kernel.org delivering my mails. You
> are not the only one. I thought it was just ones with large numbers of
> recipients, but seems to be something else. Konstantin has been
> looking into it. Do you see any pattern of mails you do receive from
> me? Sent via google vs. kernel.org?

How would I know which emails I haven't received from you? :)

This is the only one that I'm aware of.

-- 
Lee Jones [李琼斯]
