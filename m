Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5913A7CFE97
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346376AbjJSPqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345938AbjJSPqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:46:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D1CCF;
        Thu, 19 Oct 2023 08:46:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E061C433C8;
        Thu, 19 Oct 2023 15:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697730405;
        bh=dlXwrAmr23RZBJTQ4tZB3ILSltevA7NR468NS5iSreI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qd9oN9q3CDls1FHxrQ/fEHIzbFe3gGdXb9PwNIyIMVNdcHKeYaukZaB+ZRvCEElLa
         IN5LRY41J2F9SBZ6c/hCI9wkG2d/He9mO/VpTf4aiVbz8OUqOpL6ZMkc7mc//znpQM
         TuUnrJkSUHMZ4Zz2Q0AY/tlRHyf71pcP6uT6/L6w=
Date:   Thu, 19 Oct 2023 17:46:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, joe@perches.com, linux-i3c@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, imx@lists.linux.dev,
        jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/5] i3c: add slave mode support
Message-ID: <2023101935-papaya-legible-5849@gregkh>
References: <20231018215809.3477437-1-Frank.Li@nxp.com>
 <20231018215809.3477437-2-Frank.Li@nxp.com>
 <dd06c2d3-e273-4356-835b-42619543dfab@linaro.org>
 <ZTFE8hrRgPBrb7e3@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTFE8hrRgPBrb7e3@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 11:02:10AM -0400, Frank Li wrote:
> On Thu, Oct 19, 2023 at 09:00:05AM +0200, Krzysztof Kozlowski wrote:
> > On 18/10/2023 23:58, Frank Li wrote:
> > > Introduce a new slave core layer in order to support slave functions in
> > > linux kernel. This comprises the controller library and function library.
> > > Controller library implements functions specific to an slave controller
> > > and function library implements functions specific to an slave function.
> > > 
> > > Introduce a new configfs entry to configure the slave function configuring
> > > and bind the slave function with slave controller.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/i3c/Kconfig       |  26 ++
> > >  drivers/i3c/Makefile      |   2 +
> > >  drivers/i3c/i3c-cfs.c     | 389 +++++++++++++++++++++++++++++
> > >  drivers/i3c/slave.c       | 453 ++++++++++++++++++++++++++++++++++
> > >  include/linux/i3c/slave.h | 503 ++++++++++++++++++++++++++++++++++++++
> > >  5 files changed, 1373 insertions(+)
> > >  create mode 100644 drivers/i3c/i3c-cfs.c
> > >  create mode 100644 drivers/i3c/slave.c
> > >  create mode 100644 include/linux/i3c/slave.h
> > > 
> > > diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
> > > index 30a441506f61c..d5f5ca7cd6a56 100644
> > > --- a/drivers/i3c/Kconfig
> > > +++ b/drivers/i3c/Kconfig
> > > @@ -22,3 +22,29 @@ menuconfig I3C
> > >  if I3C
> > >  source "drivers/i3c/master/Kconfig"
> > >  endif # I3C
> > > +
> > > +config I3C_SLAVE
> > 
> > It doesn't look like you follow Kernel naming convention (see coding style).
> 
> I checked I3C spec. It use words 'target'.
> Is it okay using I3C_TARGET?

Why wouldn't it be?
