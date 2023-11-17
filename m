Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4474C7EEB7A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 04:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344874AbjKQDic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 22:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQDib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 22:38:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF058E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 19:38:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4256BC433C8;
        Fri, 17 Nov 2023 03:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700192307;
        bh=pT1BzgitY92OrK+bcmiH4d/YlOWx34mfM/YbnLtCb3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m0Bbp8AeEm3UxtlqyPQPLRXg82ZM0TQdcnipmtkwDsW+4DZZ50ef9wqoevPWRMyOG
         NBSYb1Z9XXmbs5+n7QfFGUO8kgfQLZWvV9aDb29YrpsIr2iACm0euhAKpAp/OEfPDl
         AgsmzhqcQB+jAWtbYKx0229xVosdWvyY6DH4jKPCHNRbl8UlzbuKk3pNhxXmuuglC5
         1psVDWzt8iYqPiYmUeyXKmo0e7i0w9WRB5jgyG+FwAm13aI0LQdkOB8EFVEhvv+Y06
         5M9zzp4DvSz7C0NdWKBdufjSxOG2ItZyIgjiGZewM6zkksVTCzN48QyWHT8+NrNCtJ
         gnypkcvrJuraA==
Date:   Fri, 17 Nov 2023 11:38:14 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] usb: cdns3: support power-off of controller when in
 host role
Message-ID: <20231117033814.GA485583@nchen-desktop>
References: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
 <20231113-j7200-usb-suspend-v1-4-ad1ee714835c@bootlin.com>
 <20231114083838.GC64573@nchen-desktop>
 <CWYHLRBFE1X1.15330WETL2R7U@tleb-bootlin-xps13-01>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CWYHLRBFE1X1.15330WETL2R7U@tleb-bootlin-xps13-01>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-14 12:10:18, Théo Lebrun wrote:
> Hello,
> 
> On Tue Nov 14, 2023 at 9:38 AM CET, Peter Chen wrote:
> > On 23-11-13 15:26:59, Théo Lebrun wrote:
> > > The controller is not being reconfigured at resume. Change resume to
> > > redo hardware config if quirk CDNS3_RESET_ON_RESUME is active.
> >
> > Current logic has power off judgement, see cdns3_controller_resume for
> > detail.
> 
> Indeed! Thanks for the pointer. I had not noticed that, those patches
> come from an older kernel which didn't have it. That'll make for less
> changes; patches 4 & 5 can go away.
> 
> > > +	if (cdns->pdata && cdns->pdata->quirks & CDNS3_RESET_ON_RESUME)
> > > +		cdns->xhci_plat_data->quirks |= XHCI_RESET_ON_RESUME | XHCI_SUSPEND_RESUME_CLKS;
> > > +
> >
> > If you set this flag, how could you support the USB remote wakeup
> > request? In that case, the USB bus does not expect re-enumeration.
> 
> We didn't support remote USB wakeup. Only S2R mattered in our case and
> USB remote wakeup wasn't a possibility.

Without this patch, will below be hit for your platform:


	/* re-initialize the HC on Restore Error, or Host Controller Error */
	if (temp & (STS_SRE | STS_HCE)) {
		reinit_xhc = true;
		if (!xhci->broken_suspend)
			xhci_warn(xhci, "xHC error in resume, USBSTS 0x%x, Reinit\n", temp);
	}


-- 

Thanks,
Peter Chen
