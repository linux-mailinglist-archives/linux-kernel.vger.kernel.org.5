Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CCF759716
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjGSNg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjGSNgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:36:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B5611B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A06D5611F9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2C5C433C7;
        Wed, 19 Jul 2023 13:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689773779;
        bh=wReR3wE3+Bic4nDhYj0aTbtveQfuwLx1sVheIXbZsMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2IjU6/pvTor2wKteVBMHwRaIZFZVY3E7ujHxjCkNEREIvf9cf0FNlTWvb7KH7+dEv
         fHmcVg50DcqP0n3azHgTrcAkLaYdkEwBZPYhvPlF/zEQl3C5N7QNa56NCi8fIl1cC7
         jQ6A9ytiefU3VjjKc8KNLIoOnUG+i9k0UNHAVytE=
Date:   Wed, 19 Jul 2023 15:36:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Gupta, Nipun" <nipun.gupta@amd.com>
Cc:     linux-kernel@vger.kernel.org, git@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com
Subject: Re: [PATCH] cdx: add support for bus mastering
Message-ID: <2023071939-delegator-kebab-51b8@gregkh>
References: <20230718100651.18317-1-nipun.gupta@amd.com>
 <2023071817-floss-visibly-396a@gregkh>
 <f5b7216c-8e6f-16c4-6902-dc8a04997fb9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5b7216c-8e6f-16c4-6902-dc8a04997fb9@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 06:06:40PM +0530, Gupta, Nipun wrote:
> 
> 
> On 7/18/2023 7:16 PM, Greg KH wrote:
> > On Tue, Jul 18, 2023 at 03:36:51PM +0530, Nipun Gupta wrote:
> > > Introduce cdx_set_master() and cdx_clear_master() APIs
> > > to support enable and disable of bus mastering. Drivers
> > > need to use these APIs to enable/disable DMAs from the
> > > CDX devices.
> > 
> > You do have a full 72 columns, why not use that?
> 
> sure, will update accordingly.
> 
> > 
> > > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > > Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> > > ---
> > >   drivers/cdx/cdx.c                       | 32 ++++++++++++++
> > >   drivers/cdx/controller/cdx_controller.c |  4 ++
> > >   drivers/cdx/controller/mcdi_functions.c | 57 +++++++++++++++++++++++++
> > >   drivers/cdx/controller/mcdi_functions.h | 13 ++++++
> > >   include/linux/cdx/cdx_bus.h             | 16 +++++++
> > >   5 files changed, 122 insertions(+)
> > > 
> > > diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> > > index d2cad4c670a0..efb24672b7d9 100644
> > > --- a/drivers/cdx/cdx.c
> > > +++ b/drivers/cdx/cdx.c
> > > @@ -182,6 +182,38 @@ cdx_match_id(const struct cdx_device_id *ids, struct cdx_device *dev)
> > >   	return NULL;
> > >   }
> > > +int cdx_set_master(struct cdx_device *cdx_dev)
> > > +{
> > > +	struct cdx_controller *cdx = cdx_dev->cdx;
> > > +	struct cdx_device_config dev_config;
> > > +	int ret;
> > > +
> > > +	dev_config.type = CDX_DEV_BUS_MASTER_CONF;
> > > +	dev_config.bme = true;
> > 
> > What is "bme"?
> 
> This is bus master enable. I will add a comment on the structure definition.

Better yet, spell it out "bus_master_enable" so no one has to look up
the comment, no need to try to make cryptic variable names :)

thanks,

greg k-h
